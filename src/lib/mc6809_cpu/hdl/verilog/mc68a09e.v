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
module mc68a09e
	(
        input wire E,
        input wire Q,
        input wire nIRQ,
        input wire nFIRQ,
        input wire nNMI,
        input wire nHALT,
        input wire nRESET,
        inout wire [7:0] D,
        output wire [15:0] A,
        output wire RnW,
        output wire BS,
        output wire BA,
        output wire AVMA,
        output wire BUSY,
        output wire LIC
    );

	//wire [15:0] AOut;
	wire [7:0] DOut;
	//wire RnWOut;
	
	//localparam tDHW = 30;			// write data hold time
	//localparam tAH = 20;			// address hold time
		
	// not sure why but the cycle accurate mc6809e core is not maintaining datasheet timing, at least during simulation
	/*assign #tDHW D = RnWOut ? 8'bZ : DOut;
	assign #tAH A = BA ? 8'bZ : AOut;
	assign #tAH RnW = RnWOut;*/
	
	assign D = RnW ? 8'bz : DOut;
	
	mc6809e mc6809e(
		.D(D), 
		.DOut(DOut), 
		.ADDR(A), 
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
