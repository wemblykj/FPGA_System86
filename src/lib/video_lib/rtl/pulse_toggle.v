`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    pulse_toggle
// Module Name:    pulse_toggle.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Toggle flip-flop 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module pulse_toggle (
  input        clk_i,
  input        rst_ni,
  input        d_i,
  output logic q_o
);
  
  logic q;
  
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      q <= 1'b0;
    end else if (d_i) begin
      q <= ~q;
    end
  end
  
  assign q_o = q;
  
endmodule

