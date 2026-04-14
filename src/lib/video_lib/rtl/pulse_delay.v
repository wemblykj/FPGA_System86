`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    pulse_delay
// Module Name:    pulse_delay.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Pulse delay
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_delay (
  input  clk_i,
  input  rst_ni,
  input  enable_i,
  input  d_i,
  output q_o,
  output is_valid_o
);
  
  reg q, q2;
  reg is_valid;
  
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      q <= d_i;
      q2 <= d_i;
	  is_valid <= 1'b0;
    end else begin
	  if (enable_i) begin
	    q2 <= q;
	    if (d_i != q) begin  
          q <= d_i;
		  is_valid <= 1'b1;
        end
	  end
	end
  end
  
  assign q_o = q2;
  assign is_valid_o = is_valid;
  
endmodule

