`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    scanline_doubler_tb
// Module Name:    scanline_doubler_tb.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Scanline doubler testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module scanline_doubler_tb;

  localparam BitDepth  = 3;
  localparam LineWidth = 12;

  // -------------------------------------------------------
  // Line timing (in clk_i cycles)
  //
  //   |<-- active -->|<- fp ->|<- sync ->|<- bp ->|
  //   | hblank_n = 1 |       hblank_n = 0         |
  //   |              |        |hsync_n=0 |         |
  // -------------------------------------------------------
  localparam ACTIVE_PIXELS = 8;
  localparam HFRONT_PORCH  = 1;   // hblank asserted, before hsync
  localparam HSYNC_WIDTH   = 2;   // hsync asserted
  localparam HBACK_PORCH   = 1;   // hblank asserted, after hsync
  localparam BLANK_PIXELS  = HFRONT_PORCH + HSYNC_WIDTH + HBACK_PORCH;
  localparam TOTAL_LINE    = ACTIVE_PIXELS + BLANK_PIXELS;

  localparam NUM_LINES     = 6;   // number of active lines to drive

  // -------------------------------------------------------
  // DUT signals
  // -------------------------------------------------------
  logic                clk;
  logic                clk_x2;
  logic                rst_n;

  logic [BitDepth-1:0] data;
  logic                hsync_n;
  logic                hblank_n;
  logic                vsync_n;
  logic                vblank_n;

  logic [BitDepth-1:0] x2_data;
  logic                x2_hsync_n;
  logic                x2_hblank_n;
  logic                x2_vsync_n;
  logic                x2_vblank_n;
  logic                x2_valid;

  scanline_doubler #(
    .BitDepth(BitDepth),
    .LineWidth(LineWidth)
  ) dut (
    .clk_i(clk),
    .clk_x2_i(clk_x2),
    .rst_ni(rst_n),
    .data_i(data),
    .hsync_ni(hsync_n),
    .hblank_ni(hblank_n),
    .vsync_ni(vsync_n),
    .vblank_ni(vblank_n),
    .x2_data_o(x2_data),
    .x2_hsync_no(x2_hsync_n),
    .x2_hblank_no(x2_hblank_n),
    .x2_vsync_no(x2_vsync_n),
    .x2_vblank_no(x2_vblank_n),
    .x2_valid_o(x2_valid)
  );

  // -------------------------------------------------------
  // Clock generation
  // -------------------------------------------------------
  initial begin
    clk = 1'b0;
    forever #4 clk = ~clk;      // period = 8ns
  end

  initial begin
    clk_x2 = 1'b0;
    forever #2 clk_x2 = ~clk_x2; // period = 4ns
  end

  // -------------------------------------------------------
  // Reset
  // -------------------------------------------------------
  initial begin
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  // -------------------------------------------------------
  // Reference storage: what we drove as input
  // -------------------------------------------------------
  logic [BitDepth-1:0] ref_line [0:NUM_LINES-1][0:ACTIVE_PIXELS-1];

  // -------------------------------------------------------
  // Task: drive one complete scanline
  //
  //  Cycle:  0..ACTIVE-1 | ACTIVE..ACTIVE+FP-1 | +FP..+FP+SYNC-1 | ...BP |
  //  hblank: ^^^^^^^^^^^^   ___________________________________________^^^^
  //  hsync:  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ________________^^^^^^^
  //  data:   px0 px1 ...    000                     000              000
  //
  //  Note: edges are driven on @(negedge clk) so they are stable
  //        well before the DUT samples on @(posedge clk).
  // -------------------------------------------------------
  task automatic drive_line(input integer line_num);
    integer px;

    // --- Active region ---
    for (px = 0; px < ACTIVE_PIXELS; px++) begin
      @(negedge clk);
      hblank_n <= 1'b1;
      hsync_n  <= 1'b1;
      data     <= (line_num * ACTIVE_PIXELS + px) & {BitDepth{1'b1}};
      // store reference
      ref_line[line_num][px] = (line_num * ACTIVE_PIXELS + px) & {BitDepth{1'b1}};
    end

    // --- Front porch (hblank asserted, hsync still high) ---
    repeat (HFRONT_PORCH) begin
      @(negedge clk);
      hblank_n <= 1'b0;
      hsync_n  <= 1'b1;
      data     <= '0;
    end

    // --- Hsync pulse (hblank and hsync both asserted) ---
    repeat (HSYNC_WIDTH) begin
      @(negedge clk);
      hblank_n <= 1'b0;
      hsync_n  <= 1'b0;
      data     <= '0;
    end

    // --- Back porch (hblank asserted, hsync deasserted) ---
    repeat (HBACK_PORCH) begin
      @(negedge clk);
      hblank_n <= 1'b0;
      hsync_n  <= 1'b1;
      data     <= '0;
    end
  endtask

  // -------------------------------------------------------
  // Output capture & verification (runs concurrently)
  //
  // Strategy: on every clk_x2 posedge where x2_valid and
  //           x2_hblank_n are both high, capture x2_data.
  //           When x2_hblank goes low, we've finished one
  //           output line — verify it.
  // -------------------------------------------------------
  integer              cap_errors = 0;
  integer              out_line_count = 0;
  integer              cap_px;
  logic [BitDepth-1:0] cap_buf [0:ACTIVE_PIXELS-1];

  initial begin
    // Wait for reset and valid
    @(posedge rst_n);
    @(posedge x2_valid);

    forever begin
      // Wait for start of active output (hblank deasserted while valid)
      @(posedge clk_x2);
      while (!(x2_valid && x2_hblank_n)) @(posedge clk_x2);

      cap_px = 0;

      // Capture active pixels
      while (x2_valid && x2_hblank_n && cap_px < ACTIVE_PIXELS) begin
        cap_buf[cap_px] = x2_data;
        cap_px++;
        @(posedge clk_x2);
      end

      // Verify: each output line should match the input line it came from.
      // Lines are doubled, so output lines 0&1 = input line 0, etc.
      // But the first input line is used to prime the pipeline (timing 
      // capture), so useful output may start from input line 1 or 2 
      // depending on latency. We check what we can.
      begin
        integer input_line;
        integer px;
        integer line_ok;

        // The output line corresponds to input_line = out_line_count / 2
        // (each input line produces two output lines)
        input_line = out_line_count / 2;

        line_ok = 1;
        if (input_line < NUM_LINES && cap_px == ACTIVE_PIXELS) begin
          for (px = 0; px < ACTIVE_PIXELS; px++) begin
            if (cap_buf[px] !== ref_line[input_line][px]) begin
              $display("FAIL: out_line=%0d (input_line=%0d), px=%0d: expected=%0h got=%0h",
                       out_line_count, input_line, px,
                       ref_line[input_line][px], cap_buf[px]);
              line_ok = 0;
              cap_errors++;
            end
          end
          if (line_ok)
            $display("PASS: out_line=%0d (input_line=%0d) — %0d pixels verified",
                     out_line_count, input_line, ACTIVE_PIXELS);
        end else begin
          $display("INFO: out_line=%0d captured %0d pixels (input_line=%0d)",
                   out_line_count, cap_px, input_line);
        end
      end

      out_line_count++;
    end
  end

  // -------------------------------------------------------
  // Main stimulus
  // -------------------------------------------------------
  integer line;
  initial begin
    // Initialize
    data     = '0;
    hsync_n  = 1'b1;
    hblank_n = 1'b1;
    vsync_n  = 1'b1;
    vblank_n = 1'b1;

    @(posedge rst_n);
    repeat (2) @(posedge clk);

    // Drive multiple scanlines
    $display("=== Driving %0d input lines ===", NUM_LINES);
    for (line = 0; line < NUM_LINES; line++) begin
      $display("--- Input line %0d ---", line);
      drive_line(line);
    end

    // Let the pipeline drain: enough time for all doubled output to appear
    repeat (TOTAL_LINE * 4) @(posedge clk_x2);

    // Report
    $display("===================================");
    if (cap_errors == 0)
      $display("ALL TESTS PASSED (%0d output lines captured)", out_line_count);
    else
      $display("TESTS FAILED: %0d errors in %0d output lines", cap_errors, out_line_count);
    $display("===================================");

    $finish;
  end

  // -------------------------------------------------------
  // Waveform dump
  // -------------------------------------------------------
  initial begin
    $dumpfile("scanline_doubler_tb.vcd");
    $dumpvars(0, scanline_doubler_tb);
  end

endmodule