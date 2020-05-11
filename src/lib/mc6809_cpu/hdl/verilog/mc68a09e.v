`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Paul Wightmore 
// 
// Create Date:    23:55:35 05/01/2018 
// Design Name:    mc68a09e
// Module Name:    system86\src\cpu\mc68a09e.v
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
module mc68a09e(
        input wire E,
        input wire Q,
        input wire nIRQ,
        input wire nFIRQ,
        input wire nNMI,
        input wire nHALT,
        input wire nRESET,
        input wire DMABREQ,
        inout wire [15:0] A,
        inout wire [7:0] D,
        output wire RnW,
        output wire BS,
        output wire BA,
        output wire AVMA,
        output wire BUSY,
        output wire LIC
    );

	wire [15:0] AOut;
	wire [7:0] DOut;
	
	assign D = RnW ? 8'bZ : DOut;
	assign A = BA ? 8'bZ : AOut;
	
	reg [7:0] DLatched;
	
	mc6809e mc6809e(
		.D(D), 
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
