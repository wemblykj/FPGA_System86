`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: P.Wightmore
// 
// Create Date:    22:06:05 05/14/2018 
// Design Name: 
// Module Name:    LS85 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 4-BIT MAGNITUDE COMPARATORS
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LS85(
    input [3:0] A,
    input [3:0] B,
	 output AgtBin,
    output AeqBin,
    output AltBin,
    output AgtBout,
    output AeqBout,
    output AltBout
    );

	assign AgtBout = (A > B) || (!AeqBin && AgtBin && (A == B));
	assign AeqBout = (A == B) && AeqBin;
	assign AltBout = (A < B) || (!AeqBin && AltBin && (A == B));

endmodule
