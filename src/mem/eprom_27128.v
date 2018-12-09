`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name: 
// Module Name:    system86\mem\prom_27128 
// Project Name:   Namco System86 simulation
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
module EPROM_27128(
    input wire E,
    input wire G,
    input wire [13:0] A,
    output wire [7:0] Q
    );

	parameter FILE_NAME = "";
	// timings (250ns - blank, -25) 
	parameter tAVQV = 250;
	parameter tAXQX = 0;
	parameter tELQV = 250;
	parameter tEHQZ = 0:60:60;  // (using worst case for typical)
	parameter tGLQV = 100;
	parameter tGHQZ = 0:60:60;  // (using worst case for typical)
	
	GENERIC_PROM #(14, 8, FILE_NAME, tAVQV, tAXQX, tELQV, tEHQZ, tGLQV, tGHQZ) fprom(
		.E(E),
		.G(G),
		.A(A),
		.Q(Q)
	);
	
endmodule
