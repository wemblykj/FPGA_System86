`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:57:44 05/08/2018 
// Design Name:    CUS35
// Module Name:    system86\src\custom\cus35.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    CUS35 - Sprite address generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0 
//
//////////////////////////////////////////////////////////////////////////////////
module cus35(
		  input wire rst_n,

        input wire CLK_6M,
        input wire nVRES,
        input wire nHSYNC,
        input wire nOCS,
        input wire RnW,
        input wire [12:0] A,
        inout wire [7:0] D,
        output wire O16VA,
        output wire O8VA,
        output wire O4VA,
        output wire O2VA,
        output wire O1VA,
        output wire O16HA,
        output wire O8HA,
        output wire O4HA,
        output wire O2HA,
        output wire FLIP,
        output wire HFLIP,
        output wire O8EN,
        output wire HSET,
        output wire VSET,
        output wire nCS0,
        output wire nCS1,
        output wire nROE,
        output wire nRWE,
        inout wire [7:0] B0,		// CPU data bus
        inout wire [7:0] B1		// line buffer - for internal xfer?
    );

	reg write_done_request;
	always @(posedge CLK_6M) begin
		write_done_request <= ~RnW;
	end
	
	assign nCS0 = 1'b1;
	assign nCS1 = nOCS;
	assign nRWE = nOCS | RnW | write_done_request;
	assign nROE = nOCS | ~nRWE;
	assign B0 = 8'bz; //~nCS0 ? (~RnW ? D : 8'bz) : 8'bx;
	assign B1 = 8'bz; //~nCS1 ? (~RnW ? D : 8'bz) : 8'bx;
	assign D = ~RnW ? 8'bz : (~nCS1 ? B1 : (~nCS0 ? B0 : 8'bx));
endmodule
