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
module CY6264(
	 input OE,
	 input CE,
	 input WE,
    input [12:0] A,
    inout [7:0] D
    );

	parameter FILE_NAME = "";
	
	SRAM #(13, 8, FILE_NAME) sram(
			.OE(OE), 
			.CE(CE),
			.WE(WE),
			.A(A),
			.D(D)
			
		);
	
endmodule
