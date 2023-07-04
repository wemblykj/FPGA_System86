`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    19:03:51 05/16/2018 
// Design Name:    timing_subsystem
// Module Name:    system86\subsystem\timing_subsystem.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Timing subsystem
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module timing_subsystem
#(
	parameter C_USE_HARDWARE_CLOCKS = 0
)
(
	input wire rst_n,
	
	input wire CLK_48M,
	
	// generated clocks
	output wire CLK_24M,
	output wire CLK_12M,
	output wire CLK_6M,
	output wire CLK_6MD,
	
	// video synchronisation
	output wire nVSYNC,
	output wire nHSYNC,
	output wire nHBLANK,
	output wire nVBLANK,
	output wire nHRESET,
	output wire nVRESET,
	output wire BLANKING,
	output wire nCOMPSYNC,
	
	// video timing signals
	output wire _8V,
	output wire _4V,
	output wire _1V,
	output wire _4H,
	output wire _2H,
	output wire _1H,
	output wire n1H,
	output wire S2H,
	output wire S1H,
	output wire nS1H
);

	wire cus27_hblank;
	
	// CUS27 - CLOCK DIVIDER
	//cus27 
	cus27_gng_ref
		cus27_9p_clock_divider(
			.rst_n(rst_n),
			.CLK_48M(CLK_48M), 
			.CLK_6M_IN(CLK_6M),
			.CLK_24M(CLK_24M),
			.CLK_12M(CLK_12M),
			.CLK_6M(CLK_6M),
			.nVSYNC(nVSYNC),
			.nHSYNC(nHSYNC),
			.nHBLANK(nHBLANK),
			.nVBLANK(nVBLANK),
			.nHRESET(nHRESET),
			.nVRESET(nVRESET),
			._8V(_8V),
			._4V(_4V),
			._1V(_1V),
			._4H(_4H),
			._2H(_2H),
			._1H(_1H),
			.S2H(S2H),
			.S1H(S1H)
		);

	// == TTL glue logic
    
	ls74 
		ls74_8u(
			.CLK1(CLK_6M),
			.nPRE1(1'b1),
			.nCLR1(1'b1),
			.D1(CLK_1H),
      .Q1(CLK_n1H),
      //.nQ1(1'b0),
			.CLK2(CLK_4H),
			.nPRE2(1'b1),
			.nCLR2(nVBLANK),
			.D2(nHBLANK),
      //.Q2(1'b0),
			.nQ2(BLANKING)
		);

	assign CLK_6MD = CLK_6M;
	assign nS1H = ~S1H;
	assign nCOMPSYNC = nHSYNC && nVSYNC;	// via LS08 (3H) and'ing of negated signals
	
endmodule
