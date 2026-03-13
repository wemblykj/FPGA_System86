`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    pulse_generator_tb
// Module Name:    pulse_generator_tb.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Pulse generator testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_generator_tb;

  localparam CounterWidth = 3;
  logic clk;
  logic rst_n;
  logic [CounterWidth-1:0] counter;
  logic q;
  logic [CounterWidth-1:0] rising_at, falling_at;
  
  // Instantiate DUT
  pulse_generator #(
    .CounterWidth(CounterWidth)
  ) dut (
    .clk_i        (clk),
    .rst_ni       (rst_n),
    .counter_i    (counter),
    .rising_at_i  (rising_at),
    .falling_at_i (falling_at),
    .q_o          (q)
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
    input expect_q,
    input string msg
  );
    @(negedge clk);
    if (q !== expect_q)
      $display("FAIL: %s | d: %b", msg, q);
    else
      $display("PASS: %s", msg);
  endtask
  
  // Sequence of test stages
  initial begin
    counter = '0;
    
    rising_at = CounterWidth'(2);
    falling_at = CounterWidth'(4);

    @(posedge rst_n);
    
    // Stage 1: Initial state (low)
    @(negedge clk);
    check_output(0, "Initial state (low)");

    // Stage 2: Counter increment (still low)
    @(negedge clk); counter = counter + 1;
    check_output(0, "Counter increment (still low)");
    
    // Stage 3: Counter increment (rising)
    @(negedge clk); counter = counter + 1;
    check_output(1, "Counter increment (rising)");
    
    // Stage4: Counter increment (still high)
    @(negedge clk); counter = counter + 1;
    check_output(1, "Counter increment (still low)");
    
    // Stage 5: Counter increment (falling)
    @(negedge clk); counter = counter + 1;
    check_output(0, "Counter increment (faling)");
    
    // Stage 6: Counter increment (still low)
    @(negedge clk); counter = counter + 1;
    check_output(0, "Counter increment (still low)");
    
    $display("All tests completed.");
    $finish;
  end

endmodule
