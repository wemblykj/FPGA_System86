`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: P.Wightmore
// 
// Create Date:    20:11:05 05/15/2018 
// Design Name: 
// Module Name:    CUS43 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: dual tilemap generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CUS43(
    input [2:0] PRI,
    input [7:0] CLI,
    input [2:0] DTI,
    input [11:0] ODI,
    input OE,			// hard to decipher text from schematics (held at logic high)
    input [2:0] CA,
    input WE,
    input [7:0] MDI, // hard to decipher text from schematics
	 input [2:0] HA, 	// hard to decipher text from schematics
    input CLK_6M,
    input CLK_2H,
    input LATCH,
    input FLIP,
    output [2:0] PRO,
    output [7:0] CLO,
    output [2:0] DTO,
    output CLE			// hard to decipher text from schematics (not used)
    );

	assign PRO = PRI;
	assign CLO = CLI;
	assign DTO = DTI;
endmodule
