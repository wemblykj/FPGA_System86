`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    edge_detector
// Module Name:    edge_detector.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Signal pulse edge detector
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module edge_detector (
  input  clk_i,
  input  rst_ni,
  input  d_i,
  output falling_o,
  output rising_o
);

  reg d_q;
  wire falling_d, rising_d;
  reg falling_q, rising_q;
  
  assign falling_d = d_q && !d_i;
  assign rising_d = !d_q && d_i;
  
  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      d_q <= 1'b0;
    end else begin
      d_q <= d_i;
      falling_q <= falling_d;
      rising_q <= rising_d;
    end
  end

  assign falling_o = falling_q;
  assign rising_o = rising_q;
  
endmodule
