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
  reg clk;
  reg rst_n;
  reg [CounterWidth-1:0] counter;
  reg [CounterWidth-1:0] rising_at, falling_at;
  wire q;
  wire is_valid;
  
  // Instantiate DUT
  pulse_generator #(
    .CounterWidth(CounterWidth)
  ) dut (
    .clk_i        (clk),
    .rst_ni       (rst_n),
    .counter_i    (counter),
    .rising_at_i  (rising_at),
    .falling_at_i (falling_at),
    .q_o          (q),
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
  task automatic check_output(
    input expect_q,
    input expect_is_valid,
    input [8*32-1:0] msg
  );
    begin
      @(negedge clk);
      if (q !== expect_q || is_valid !== expect_is_valid)
        $display("FAIL: %s | q: %b | is_valid: %b", msg, q, is_valid);
      else
        $display("PASS: %s", msg);
	end
  endtask
  
  // Sequence of test stages
  initial begin
    counter = 1'b0;
    
    rising_at = 3'd2;
    falling_at = 3'd4;

    @(posedge rst_n);
    
    // Stage 1: Initial state (low)
    @(negedge clk);
    check_output(0, 0,"Initial state (low)");

    // Stage 2: Counter increment (still low)
    @(negedge clk); counter = counter + 1;
    check_output(0, 0, "Counter increment (still low)");
    
    // Stage 3: Counter increment (rising)
    @(negedge clk); counter = counter + 1;
    check_output(1, 0, "Counter increment (rising)");
    
    // Stage4: Counter increment (still high)
    @(negedge clk); counter = counter + 1;
    check_output(1, 0, "Counter increment (still low)");
    
    // Stage 5: Counter increment (falling)
    @(negedge clk); counter = counter + 1;
    check_output(0, 1, "Counter increment (falling, goes valid)");
    
    // Stage 6: Counter increment (still low)
    @(negedge clk); counter = counter + 1;
    check_output(0, 1, "Counter increment (still low)");
    
    $display("All tests completed.");
    $finish;
  end

endmodule
