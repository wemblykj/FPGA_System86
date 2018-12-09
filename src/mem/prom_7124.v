`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name: 
// Module Name:    system86\mem\prom_7124 
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
module PROM_7124(
    input wire E,
    input wire [8:0] A,
    output wire [7:0] Q
    );

	parameter FILE_NAME = "";
	// Type E (45ns) timings
	parameter tAA = 26:26:45;
	parameter tEN = 15:15:30;
	parameter tDIS = 15:15:30;

	supply1 VCC;
	
	GENERIC_PROM #(9, 8, FILE_NAME, tAA, tAA, tEN, tDIS) prom(
		.E(E),
		.G(VCC),
		.A(A),
		.Q(Q)
	);
	
endmodule
