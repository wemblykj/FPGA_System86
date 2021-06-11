`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name:    MB7112
// Module Name:    system86\mem\prom_7112.v
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
module prom_mb7112
    #(
        parameter FILE_NAME = "",
        // Type E (35ns) timings
        parameter tAA = 15:15:35,
        parameter tEN = 10:10:20,
        parameter tDIS = 15:15:25
    )
    (
        input wire nE,
        input wire [4:0] A,
        output wire [7:0] Q
    );
	
	supply1 VCC;
	
	GENERIC_PROM #(5, 8, FILE_NAME, tAA, tAA, tEN, tDIS) prom(
		.nE(nE),
		.nG(1'b0),
		.A(A),
		.Q(Q)
	);
	
endmodule
