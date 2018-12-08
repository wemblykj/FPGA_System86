`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: P.Wightmore
// 
// Create Date:    23:33:42 05/14/2018 
// Design Name: 
// Module Name:    LS174 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: HEX/QUADRUPLE D-TYPE FLIP-FLOPS WITH CLEAR
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LS174(
    input wire CLK,
    input wire CLR,
    input wire [5:0] D,
    output reg [5:0] Q
    );

	always @(posedge CLK) begin
		if (CLR)
			Q = 6'b0;
		else
			Q = D;
	end
	
endmodule
