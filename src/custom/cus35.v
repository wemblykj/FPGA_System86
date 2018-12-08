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
module CUS35(
    input CLK_6M,
    input VRES,
    input HSYNC,
    input OCS,
    input WE,
    input [12:0] A,
    inout [7:0] D,
    output O16VA,
    output O8VA,
    output O4VA,
    output O2VA,
    output O1VA,
    output O16HA,
    output O8HA,
    output O4HA,
    output O2HA,
    output FLIP,
    output HFLIP,
    output O8EN,
    output HSET,
    output VSET,
    output CS0,
    output CS1,
    output ROE,
    output RWE,
    inout [7:0] BI,
    inout [7:0] BO
    );

	reg [7:0] DOut;
	reg [7:0] BIOut;
	always @(posedge CLK_6M) begin
		if (OCS)
			if (WE)
				BIOut = D;
			else 
				DOut = BI;
	end
		
	assign CS1 = OCS;
	assign ROE = OCS && !WE;
	assign RWE = OCS && WE;
	
	assign D = (ROE) ? DOut : 8'bZ;
	assign BI = (RWE) ? BIOut : 8'bZ;
	
endmodule
