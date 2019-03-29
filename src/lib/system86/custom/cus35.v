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
        input wire CLK_6M,
        input wire VRES,
        input wire HSYNC,
        input wire OCS,
        input wire WE,
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
        output wire CS0,
        output wire CS1,
        output wire ROE,
        output wire RWE,
        inout wire [7:0] BI,
        inout wire [7:0] BO
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
