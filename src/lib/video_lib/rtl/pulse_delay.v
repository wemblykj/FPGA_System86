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
  input  d_i,
  output q_o
);
  
  reg q, q2;
  
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      q <= 1'b0;
      q2 <= 1'b0;
    end else if (d_i) begin
      q2 <= q;
      q <= d_i;
    end
  end
  
  assign q_o = q2;
  
endmodule

