`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:13:54 04/24/2018 
// Design Name:    LS00
// Module Name:    system86/ttl/ls00.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    LS00 - Quadruple 2-Input Positive-NAND Gates
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module ls00(
        input wire A1,
        input wire B1,
        input wire A2,
        input wire B2,
        input wire A3,
        input wire B3,
        input wire A4,
        input wire B4,
        output wire Y1,
        output wire Y2,
        output wire Y3,
        output wire Y4
    );

	nand ls00[0:3] ( {Y4, Y3, Y2, Y1}, {A4, A3, A2, A1}, {B4, B3, B2, B1} );
	
endmodule
