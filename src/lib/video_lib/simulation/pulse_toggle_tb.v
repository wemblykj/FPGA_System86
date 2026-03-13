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
// Description:    Toggle flip-flop testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_toggle_tb;

  logic clk;
  logic rst_n;
  logic d;
  logic q;

  // Instantiate DUT
  pulse_toggle dut (
    .clk_i  (clk),
    .rst_ni (rst_n),
    .d_i    (d),
    .q_o    (q)
  );

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #2 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  // Task for check stage
  task automatic check_output(
    input bit expected_q,
    input string msg
  );
    @(negedge clk);
    if (q !== expected_q)
      $display("FAIL: %s | q_o: %0b", msg, q);
    else
      $display("PASS: %s", msg);
  endtask

  // Sequence of test stages
  initial begin
    d = 1'b0;

    @(posedge rst_n);

    // Stage 1: Low after reset
    check_output(0, "Initial state (low)");

    // Stage 2: Low after clock (inhibited)
    @(negedge clk);
    check_output(0, "Toggle inhibited");

    // Stage 3: High after clock (toggle)
    @(negedge clk); d = 1'b1;
    check_output(1, "Toggled enabled (high)");

    // Stage 4: High after clock (inhibited)
    d = 1'b0;
    @(negedge clk);
    check_output(1, "No change (high)");

    // Stage 5: Low after clock (toggle)
    @(negedge clk); d = 1'b1;
    check_output(0, "Toggle enabled (low)");

    $display("All tests completed.");
    $finish;
  end

endmodule
