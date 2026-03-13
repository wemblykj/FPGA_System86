`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    edge_detector_tb
// Module Name:    edge_detector_tb.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Signal pulse edge detector testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module edge_detector_tb;

  logic clk;
  logic rst_n;
  logic d;
  logic falling, rising;

  // Instantiate DUT
  edge_detector dut (
    .clk_i     (clk),
    .rst_ni    (rst_n),
    .d_i       (d),
    .falling_o (falling),
    .rising_o  (rising)
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
  task automatic check_edge(
    input bit expect_falling,
    input bit expect_rising,
    input string msg
  );
    @(negedge clk);
    if (falling !== expect_falling || rising !== expect_rising)
      $display("FAIL: %s | falling_o: %0b | rising_o: %0b", msg, falling, rising);
    else
      $display("PASS: %s", msg);
  endtask

  // Sequence of test stages
  initial begin
    d = 1'b0;

    @(posedge rst_n);

    // Stage 1: No edge
    check_edge(0, 0, "Initial state (no edge)");

    // Stage 2: Rising edge
    @(negedge clk); d = 1'b1;
    check_edge(0, 1, "Rising edge");

    // Stage 3: Stable high (no edge)
    @(negedge clk);
    check_edge(0, 0, "Stable high (no edge)");

    // Stage 4: Falling edge
    @(negedge clk); d = 1'b0;
    check_edge(1, 0, "Falling edge");

    // Stage 5: Stable low (no edge)
    @(negedge clk);
    check_edge(0, 0, "Stable low (no edge)");

    $display("All tests completed.");
    $finish;
  end

endmodule
