`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:51:32 05/14/2018 
// Design Name: 
// Module Name:    LS273 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LS273(
	 input wire CLK,
	 input wire CLR,
    input wire [7:0] D,
    output reg [7:0] Q
    );

	always @(posedge CLK) begin
		if (CLR)
			Q = 8'b0;
		else
			Q = D;
	end
	
endmodule
