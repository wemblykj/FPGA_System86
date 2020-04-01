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
// Description:    CY6264 Static RAM
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cy6264
    #(
        parameter FILE_NAME = "",
        // CY6264 timing and naming conventions (or thereabouts)
        parameter tAA = 100:100:100,	// address access time
        parameter tOHA = 10,			// output data hold time from address change
        parameter tACE = 0:100:100,	    // CE access time
        parameter tLZCE = 10,			// CE to output low-Z
        parameter tHZCE = 0:40:40,	    // CE to output high-Z
        parameter tDOE = 0:40:40,	    // OE access time
        parameter tLZOE = 5,			// OE to output low-Z
        parameter tHZOE = 0:35:35	    // OE to output high-Z
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
		13, 8, 
		FILE_NAME,
		tAA, tOHA,
		tACE, tLZCE, tHZCE,
		tDOE,	tLZOE, tHZOE
		) sram(
			.nCE(nCE1 && ~CE2),
			.nOE(nOE), 
			.nWE(nWE),
			.A(A),
			.D(D)
			
		);
	
endmodule
