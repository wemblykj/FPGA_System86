`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:02:26 04/24/2018 
// Design Name:    LS139
// Module Name:    system86\src\ttl\ls139.v
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
module ls139(
        input wire nEa,
        input wire A0a,
        input wire A1a,
        input wire nEb,
        input wire A0b,
        input wire A1b,
        output wire nO0a,
        output wire nO1a,
        output wire nO2a,
        output wire nO3a,
        output wire nO0b,
        output wire nO1b,
        output wire nO2b,
        output wire nO3b
    );

	assign nO0a = nEa | (A0a | A1a);
	assign nO1a = nEa | (~A0a | A1a);
	assign nO2a = nEa | (A0a | ~A1a);
	assign nO3a = nEa | (~A0a | ~A1a);
	
	assign nO0b = nEb | (A0b | A1b);
	assign nO1b = nEb | (~A0b | A1b);
	assign nO2b = nEb | (A0b | ~A1b);
	assign nO3b = nEb | (~A0b | ~A1b);

endmodule
