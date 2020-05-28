`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name:    MB7138
// Module Name:    system86\mem\prom_7138.v
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
module prom_mb7138
    #(
        parameter FILE_NAME = "",
        // Type E (45ns) timings
        parameter tAA = 35:35:45,
        parameter tEN = 20:20:40,
        parameter tDIS = 15:15:40
    )
    (
        input wire nE,
        input wire [10:0] A,
        output wire [7:0] Q,
		  output wire data_valid
    );
	
	supply1 VCC;
	
	GENERIC_PROM #(11, 8, FILE_NAME, tAA, tAA, tEN, tDIS) prom(
		.nE(nE),
		.nG(1'b0),
		.A(A),
		.Q(Q),
		.data_valid(data_valid)
	);
	
endmodule
