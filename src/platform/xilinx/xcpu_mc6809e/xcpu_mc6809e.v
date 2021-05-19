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
module xcpu_mc6809e
	#(
		parameter tDHW = 30,			// write data hold time
		parameter tAH = 20			// address hold time
	)
	(
        input wire E,
        input wire Q,
        input wire nIRQ,
        input wire nFIRQ,
        input wire nNMI,
        input wire nHALT,
        input wire nRESET,
        inout wire [15:0] A,
        inout wire [7:0] D,
        output wire RnW,
        output wire BS,
        output wire BA,
        output wire AVMA,
        output wire BUSY,
        output wire LIC
    );
	
	mc68a09e 
		#(
			.tDHW(tDHW),
			.tAH(tAH)
		)
		mc68a09e(
			.D(D), 
			.A(A), 
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

endmodule
