`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: P.Wightmore
// 
// Create Date:    20:28:15 05/15/2018 
// Design Name: 
// Module Name:    LS374 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: OCTAL D-TYPE TRANSPARENT LATCHES AND EDGE-TRIGGERED FLIP-FLOPS
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LS374(
	 input wire OC,
    input wire CLK,
    input wire [1:8] D,
    output reg [1:8] Q
    );

	always @(posedge CLK) begin
		if (OC)
			Q = D;
		else
			Q = 8'bZ;
	end

endmodule
