`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:44 05/08/2018 
// Design Name: 
// Module Name:    CUS35 
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
module CUS35(
	 input CLK_6M,
	 input CLK_2H,
	 input VRESET,
	 input HSYNC,
	 input OCS,
	 input WE,
	 input [12:0] A,
    input [7:0] D,
	 output O16VA,
	 output O8VA,
	 output O4VA,
	 output O2VA,
	 output O1VA,
	 output O16HA,
	 output O8HA,
	 output O4HA,
	 output O2HA,
	 output FLIP,
	 output HFLIP,
	 output O8EN,
	 output HSET,
    output VSET,
	 output CS1,
	 output CS2,
	 output ROE,
	 output RWE,
	 output [7:0] BI,
    output [7:0] BO
    );


endmodule
