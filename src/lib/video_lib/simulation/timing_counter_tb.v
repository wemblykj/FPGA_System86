`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    timing_counter_tb
// Module Name:    timing_counter_tb.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Video timing clock counter testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module timing_counter_tb;

  localparam CounterWidth = 3;
  logic clk;
  logic rst_n;
  logic reset;
  logic [CounterWidth-1:0] counter;
  logic [CounterWidth-1:0] test_counter;

  // Instantiate DUT
  timing_counter #(.CounterWidth(CounterWidth)) dut (
    .clk_i     (clk),
    .rst_ni    (rst_n),
    .reset_i   (reset),
    .counter_o (counter)
  );

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 1'b0;
    #10 rst_n = 1'b1;
  end

  // Task for check stage
  task automatic check_output(
    input [CounterWidth-1:0] expect_counter,
    input string msg
  );
    @(negedge clk);
    if (counter !== expect_counter)
      $display("FAIL: %s | counter: %0b", msg, counter);
    else
      $display("PASS: %s", msg);
  endtask

  // Sequence of test stages
  initial begin
    reset = 1'b0;

    @(posedge rst_n);
    
    // Stage 1: No edge
    @(negedge clk); test_counter = counter + 1;
    check_output(test_counter, "Initial state");

    // Stage 2: Increment
    @(negedge clk); test_counter = counter + 1;
    check_output(test_counter, "Increment");

    // Stage 3: Increment
    @(negedge clk); test_counter = counter + 1;
    check_output(test_counter, "Increment");

    // Stage 4: Increment
    @(negedge clk); test_counter = counter + 1;
    check_output(test_counter, "Increment");

    // Stage 5: Reset
    @(negedge clk); reset = 1'b1;
    check_output(0, "Reset");
    @(negedge clk); reset = 1'b0;
    
    // Stage 6: Increment
    @(negedge clk); test_counter = counter + 1;
    check_output(test_counter, "Increment");

    // Stage 7: Increment
    @(negedge clk); test_counter = counter + 1;
    check_output(test_counter, "Increment");
    
    // Stage 8: Reset
    @(negedge clk); reset = 1'b1;
    check_output(0, "Reset");
    @(negedge clk); reset = 1'b0;
    
    $display("All tests completed.");
    $finish;
  end

endmodule