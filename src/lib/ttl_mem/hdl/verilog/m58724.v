`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    18:05:38 05/06/2018 
// Design Name:    M58725
// Module Name:    system86\mem\cy6264.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Motorola M58725 Static RAM
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module sram_m58725
    #(
        parameter FILE_NAME = "",
        // CY6424-70 timing and naming conventions (or thereabouts)
		  // read
        parameter tAA = 70,	// address access time
        parameter tOHA = 5,				// output data hold time from address change
        parameter tACE = 70,	   		// CE access time
        parameter tLZCE = 10,				// CE to output low-Z
        parameter tHZCE = 30,	   		// CE to output high-Z
        parameter tDOE = 35,	   		// OE access time
        parameter tLZOE = 5,				// OE to output low-Z
        parameter tHZOE = 30,			   // OE to output high-Z
		  // write
		  parameter tSCE = 60,			   // CE LOW to write end#
		  parameter tSD = 35,			   // data setup to write end
		  parameter tHD = 0,				   // data hold from write end
		  
		  parameter tAW = 55,				// address setup to write end
		  parameter tPWE = 40,			   // WE pulse width
		  parameter tHZWE = 30,				// WE LOW to high
		  parameter tLZWE = 5				// WE HIGH to low-Z
    )
    (
        input wire nCE1,
        input wire CE2,
        input wire nOE,
        input wire nWE,
        input wire [10:0] A,
        inout wire [7:0] D,
		output wire data_valid
    );
	
	GENERIC_SRAM #(
		.ADDR_WIDTH(11), .DATA_WIDTH(8), 
		.FILE_NAME(FILE_NAME),
		.tAA(tAA), 
		.tOHA(tOHA),
		.tACE(tACE), 
		.tLZCE(tLZCE), .tHZCE(tHZCE),
		.tDOE(tDOE),	
		.tLZOE(tLZOE),	.tHZOE(tHZOE),
		.tSCE(tSCE),
		.tSD(tSD),
		.tHD(tHD),
		.tAW(tAW),
		.tPWE(tPWE),
		.tHZWE(tHZWE),	.tLZWE(tLZWE)
		) sram(
			.nCE(nCE1 && ~CE2),
			.nOE(nOE), 
			.nWE(nWE),
			.A(A),
			.D(D),
			.data_valid(data_valid)
		);
	
endmodule
