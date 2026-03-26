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
// Description:    Pulse edge timing capture testbench
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
  
  reg                     clk;
  reg                     rst_n;
  reg [CounterWidth-1:0]  counter;
  reg                     rising, falling;
  wire [CounterWidth-1:0] rising_at, falling_at;
  wire                    is_valid;
  reg [CounterWidth-1:0]  last_rising_at, last_falling_at;

  // Instantiate DUT
  edge_timing_capture #(
    .CounterWidth(CounterWidth)
  ) dut (
    .clk_i        (clk),
    .rst_ni       (rst_n),
    .counter_i    (counter),
    .rising_i     (rising),
    .falling_i    (falling),
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
    input [8*32-1:0] msg
  );
    begin
      @(negedge clk);
      if (is_valid)
        $display("FAIL: %s | is_valid: %b | rising_at: %b | falling_at: %b", msg, is_valid, rising_at, falling_at);
      else
        $display("PASS: %s", msg);
      end
  endtask

  task automatic check_valid(
    input [CounterWidth-1:0] expect_rising_at,
    input [CounterWidth-1:0] expect_falling_at,
    input [8*32-1:0] msg
  );
	begin
	  @(negedge clk);
	  if (!is_valid || falling_at !== expect_falling_at || rising_at !== expect_rising_at)
	    $display("FAIL: %s | is_valid: %b | rising_o: %b| falling_o: %b", msg, is_valid, rising_at, falling_at);
      else
  	    $display("PASS: %s", msg);
	end
  endtask
  
  // Sequence of test stages
  initial begin
    counter = {CounterWidth{1'b0}};
    
    rising = 1'b0;
    falling = 1'b0;
    
    last_rising_at = {CounterWidth{1'b0}};
    last_falling_at = {CounterWidth{1'b0}};

    @(posedge rst_n);
    
    // Stage 1: Initial state (invalid)
    @(negedge clk); counter = counter + 1;
    check_invalid("Initial state");

    // Stage 2: Rising edge only (invalid)
    @(negedge clk); counter = counter + 1; rising = 1'b1; 
    check_invalid("Capture rising edge only (invalid)");
    rising = 1'b0; last_rising_at = counter;
    
    // Stage 3: No change (invalid)
    @(negedge clk); counter = counter + 1;
    check_invalid("No change (invalid)");
    
    // Stage 4: Falling edge only (valid)
    @(negedge clk); counter = counter + 1; falling = 1'b1; 
    check_valid(last_rising_at, counter, "Capture falling edge (goes valid)");
    falling = 1'b0; last_falling_at = counter;
    
    // Stage 5: No change (valid)
    @(negedge clk); counter = counter + 1;
    check_valid(last_rising_at, last_falling_at, "No change (valid)");
    
    // Stage 6: Recapture falling edge (valid)
    @(negedge clk); counter = counter + 1; falling = 1'b1; 
    check_valid(last_rising_at, counter, "Recapture falling edge (valid)");
    falling = 1'b0; last_falling_at = counter;
    
    // Stage 7: Recapture rising edge (valid)
    @(negedge clk); counter = counter + 1; rising = 1'b1; 
    check_valid(counter, last_falling_at, "Recapture rising edge (valid)");
    rising = 1'b0; last_rising_at = counter;
    
    // Stage 8: No change (valid)
    @(negedge clk); counter = counter + 1;
    check_valid(last_rising_at, last_falling_at, "No change (valid)");
    
    $display("All tests completed.");
    $finish;
  end

endmodule
