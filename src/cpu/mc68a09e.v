`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Paul Wightmore 
// 
// Create Date:    23:55:35 05/01/2018 
// Design Name: 
// Module Name:    system86\src\cpu\mc68A09e.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Wrapper for 6809 CPU abstraction
//                 NOTE: All signals are driven logic high
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MC68A09E(
    input E,
    input Q,
    input IRQ,
    input FIRQ,
    input NMI,
    input HALT,
    input RESET,
    input DMABREQ,
 	
    inout [15:0] A,
    inout [7:0] D,
    output WE,
    output BS,
    output BA,
    output AVMA,
    output BUSY,
    output LIC
    );

	wire [15:0] AOut;
	wire [7:0] DOut;
	wire RnW;
	
	wire nIRQ;
	wire nFIRQ;
	wire nNMI;
	wire nHALT;
	wire nRESET;
	
	assign WE = ~RnW;
	assign D = WE ? DOut : 8'bZ;
	assign A = BA ? 8'bZ : AOut;
	
	assign nIRQ = ~IRQ;
	assign nFIRQ = ~FIRQ;
	assign nNMI = ~NMI;
	assign nHALT = ~HALT;
	assign nRESET = ~RESET;
	
	reg [7:0] DLatched;
	
	mc6809e mc6809e(
		.D(DLatched), 
		.DOut(DOut), 
		.ADDR(AOut), 
		.RnW(RnW), 
		.E(E), 
		.Q(Q), 
		.BS(BS), 
		.BA(BA), 
		.nIRQ( nIRQ), 
		.nFIRQ(nFIRQ), 
		.nNMI(nNMI), 
		.AVMA(AVMA), 
		.BUSY(BUSY), 
		.LIC(LIC), 
		.nHALT(nHALT), 
		.nRESET(nRESET));
		
	always @(*) begin
		// Timing hack
		DLatched = E ? D : DLatched;
	end
endmodule
