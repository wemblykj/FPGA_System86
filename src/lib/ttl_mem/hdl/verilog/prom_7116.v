`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name:    MB7116
// Module Name:    system86\mem\prom_7116.v
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
module PROM_7116
    #(
        parameter FILE_NAME = "",
        // Type E (45ns) timings
        parameter tAA = 45,
        parameter tEN = 30,
        parameter tDIS = 30
    )
    (
        input wire nE,
        input wire [8:0] A,
        output wire [3:0] Q
    );
	
	supply1 VCC;
	
	GENERIC_PROM #(9, 4, FILE_NAME, tAA, tAA, tEN, tDIS) prom(
		.nE(nE),
		.nG(VCC),
		.A(A),
		.Q(Q)
	);
	
endmodule
