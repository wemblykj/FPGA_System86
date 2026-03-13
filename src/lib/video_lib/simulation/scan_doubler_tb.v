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

  localparam BitDepth = 3;
  localparam LineWidth = 12;
    
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

  // Clock 1X generation
  initial begin
    clk = 1'b0;
    forever #4 clk = ~clk;
  end
  
  // Clock 2X generation
  initial begin
    clk_x2 = 1'b0;
    forever #2 clk_x2 = ~clk_x2;
  end

  // Reset generation
  initial begin
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end
  
  // Single write/read checker
  task automatic check_read(
    input [BitDepth-1:0] expected_data,
    input                expected_hsync,
    input                expected_hblank
  );
    @(posedge clk_x2);
    if (data !== expected_data)
      $display("FAIL: Expected: %0h, Got: %0h", expected_data, x2_data);
    else
      $display("PASS: Data: %0h", x2_data);
  endtask

  // Test sequence
  integer i;
  initial begin
    // Initialize signals
    data = '0;
    hsync_n = '1;
    hblank_n = '1;
    vsync_n = '1;
    vblank_n = '1;

    // Wait for clocks to stabilize
    repeat(2) @(posedge clk);
    repeat(2) @(posedge clk_x2);

    @(negedge clk) data = 3'd1;
    @(negedge clk) data = 3'd3;
    @(negedge clk) data = 3'd7;
    @(negedge clk) data = 3'd5;
    @(negedge clk) data = 3'd0; hblank_n = '0;
    @(negedge clk) data = 3'd0;
    @(negedge clk) data = 3'd0;
    @(negedge clk) data = 3'd0; hsync_n = '0;
    @(negedge clk) data = 3'd0;
    @(negedge clk) data = 3'd0; hsync_n = '1;
    @(negedge clk) data = 3'd0;
    @(negedge clk) data = 3'd0; hblank_n = '1;
    
    // Read a handful of values
    //check_read(4'd0, 8'h12);
    //check_read(4'd3, 8'hAB);
    //check_read(4'd7, 8'hFF);
    //check_read(4'd15, 8'h01);

    // Optional: Loop through a pattern
    //for (i = 0; i < 16; i = i + 1) begin
    //  check_write_read(i[AddrWidth-1:0], (i * 7) & 8'hFF);
    //end

    $display("All tests completed.");
    $finish;
  end
endmodule
