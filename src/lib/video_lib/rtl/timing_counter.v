`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    timing_counter
// Module Name:    timing_counter.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Video timing clock counter
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module timing_counter #(
  parameter integer CounterWidth = 12
) (
  input                     clk_i,
  input                     rst_ni,
  input                     reset_i,    // reset pulse for counter
  output [CounterWidth-1:0] counter_o,
  output                    is_valid_o
);

  wire                    reset_d;
  reg                     reset_q;
  wire [CounterWidth-1:0] counter_d;
  reg  [CounterWidth-1:0] counter_q;
  reg                     is_valid_q;

  //assign reset_d = reset_i && !reset_q;
  assign counter_d = reset_i ? 1'b0 : counter_q + 1'b1;
  
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
	  //reset_q    <= 1'b0;
      counter_q  <= 1'b0;  
	  is_valid_q <= 1'b0;
    end else begin
	  //reset_q <= reset_i;
	  if (is_valid_q == 1'b0) begin
	    is_valid_q <= 1'b1;
	  end else begin
	    counter_q <= counter_d;
	  end
    end
  end
  
  assign counter_o = counter_q;
  assign is_valid_o = is_valid_q;
  
endmodule
