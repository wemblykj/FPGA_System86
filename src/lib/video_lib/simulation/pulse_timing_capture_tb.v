`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    edge_timing_capture_tb
// Module Name:    edge_timing_capture_tb.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Pulse timing capture testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module edge_timing_capture_tb;

  localparam CounterWidth = 3;
  logic clk;
  logic rst_n;
  logic [CounterWidth-1:0] counter;
  logic d;
  logic [CounterWidth-1:0] rising_at, falling_at;
  logic is_valid;
  logic [CounterWidth-1:0] last_rising_at, last_falling_at;

  // Instantiate DUT
  pulse_timing_capture #(
    .CounterWidth(CounterWidth)
  ) dut (
    .clk_i        (clk),
    .rst_ni       (rst_n),
    .counter_i    (counter),
    .d_i          (d),
    .rising_at_o  (rising_at),
    .falling_at_o (falling_at),
    .is_valid_o   (is_valid)
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
  task automatic check_invalid(
    input string msg
  );
    @(negedge clk);
    if (is_valid)
      $display("FAIL: %s | is_valid: %b | rising_at: %b | falling_at: %b", msg, is_valid, rising_at, falling_at);
    else
      $display("PASS: %s", msg);
  endtask

  task automatic check_valid(
    input [CounterWidth-1:0] expect_rising_at,
    input [CounterWidth-1:0] expect_falling_at,
    input string msg
  );
    @(negedge clk);
    if (!is_valid || falling_at !== expect_falling_at || rising_at !== expect_rising_at)
      $display("FAIL: %s | is_valid: %b | rising_o: %b| falling_o: %b", msg, is_valid, rising_at, falling_at);
    else
      $display("PASS: %s", msg);
  endtask
  
  // Sequence of test stages
  initial begin
    counter = '0;
    
    d = '0;
    
    last_rising_at = '0;
    last_falling_at = '0;

    @(posedge rst_n);
    
    // Stage 1: Initial state (invalid)
    @(negedge clk); counter = counter + 1;
    check_invalid("Initial state");

    // Stage 2: Rising edge only (invalid)
    @(negedge clk); counter = counter + 1; d = '1; 
    check_invalid("Calture rising edge only (invalid)");
    @(negedge clk); last_rising_at = counter;
    
    // Stage 3: No change (invalid)
    @(negedge clk); counter = counter + 1;
    check_invalid("No change (invalid)");
    
    // Stage 4: Falling edge only (valid)
    @(negedge clk); counter = counter + 1; d = '0; 
    check_valid(last_rising_at, counter, "Capture falling edge (goes valid)");
    @(negedge clk); last_falling_at = counter;
    
    // Stage 5: No change (valid)
    @(negedge clk); counter = counter + 1;
    check_valid(last_rising_at, last_falling_at, "No change (valid)");
    
    // Stage 6: Recapture rising edge (valid)
    @(negedge clk); counter = counter + 1; d = '1; 
    check_valid(counter, last_falling_at, "Recapture rising edge (valid)");
    @(negedge clk); last_rising_at = counter;
    
    // Stage 7: Recapture falling edge (valid)
    @(negedge clk); counter = counter + 1; d = '0; 
    check_valid(last_rising_at, counter, "Recapture falling edge (valid)");
    @(negedge clk); last_falling_at = counter;
    
    // Stage 8: No change (valid)
    @(negedge clk); counter = counter + 1;
    check_valid(last_rising_at, last_falling_at, "No change (valid)");
    
    $display("All tests completed.");
    $finish;
  end

endmodule
