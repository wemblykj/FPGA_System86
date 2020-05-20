`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    18:05:38 05/06/2018 
// Design Name:    CY6264
// Module Name:    system86\mem\cy6264.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    M5M5165P-10 Static RAM
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module sram_m5m5165p-10
    #(
        parameter FILE_NAME = "",
        // M5M5165P-10 worst case timings
		  // read
        parameter tAA = 100:100:100,	// address access time
        parameter tOHA = 10:10:10,			// output data hold time from address change
        parameter tACE = 100:100:100,	    // CE access time
        parameter tLZCE = 10:10:10,			// CE to output low-Z
        parameter tHZCE = 35:35:35,	    // CE to output high-Z
        parameter tDOE = 50:50:50,	    // OE access time
        parameter tLZOE = 10:10:10,			// OE to output low-Z
        parameter tHZOE = 35:35:35,	    // OE to output high-Z
		  // write
		  // from M5M5165P-10
		  parameter tSCE = 80:80:80,	    	// CE LOW to write end#
		  parameter tSD = 40:40:40,	   // data setup to write end
		  parameter tHD = 5:5:5,	    	// data hold from write end
		  parameter tAW = 0:0:0,		// address setup to write end
		  parameter tPWE = 60:60:60,	   // WE pulse width
		  parameter tHZWE = 35:35:35,		// WE LOW to high
		  parameter tLZWE = 10:10:10		// WE HIGH to low-Z
    )
    (
        input wire nCE1,
        input wire CE2,
        input wire nOE,
        input wire nWE,
        input wire [12:0] A,
        inout wire [7:0] D
    );
	
	GENERIC_SRAM #(
		.ADDR_WIDTH(13), .DATA_WIDTH(8), 
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
			.D(D)
			
		);
	
endmodule
