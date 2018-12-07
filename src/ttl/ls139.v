`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:02:26 04/24/2018 
// Design Name: 
// Module Name:    system86\src	tl\ls139 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    LS139 - Dual 2-Line To 4-Line Decoder/Demultiplexer
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module LS139(
    input Ea,
    input A0a,
    input A1a,
    input Eb,
    input A0b,
    input A1b,
    output O0a,
    output O1a,
    output O2a,
    output O3a,
	output O0b,
    output O1b,
    output O2b,
    output O3b
    );

	assign O0a = Ea & (~A0a & ~A1a);
	assign O1a = Ea & (A0a & ~A1a);
	assign O2a = Ea & (~A0a & A1a);
	assign O3a = Ea & (A0a & A1a);
	
	assign O0b = Eb & (~A0b & ~A1b);
	assign O1b = Eb & (A0b & ~A1b);
	assign O2b = Eb & (~A0b & A1b);
	assign O3b = Eb & (A0b & A1b);

endmodule
