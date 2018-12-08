`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:14:43 05/04/2018 
// Design Name: 
// Module Name:    system86\src\custom\cus42 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS42 - Tilemap Address Generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module CUS42(
	 input CLK_6M,
	 input CLK_2H,
	 input HSYNC,
	 input VSYNC,
	 input RCS,
	 input LATCH,
	 input FLIP,
    input [13:0] CA,
    input [7:0] CD,
	 input WE,
    output [13:0] GA,
    output [12:0] RA,
    output RWE,
	 output [7:0] RD,
    output ROE
    );


endmodule
