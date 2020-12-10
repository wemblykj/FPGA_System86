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
	input wire enable,
	
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
	output wire CLK_8V,
	output wire CLK_4V,
	output wire CLK_1V,
	output wire CLK_4H,
	output wire CLK_2H,
	output wire CLK_1H,
	output wire CLK_n1H,
	output wire CLK_S2H,
	output wire CLK_S1H,
	output wire CLK_nS1H
);

	wire cus27_hblank;
	
	// CUS27 - CLOCK DIVIDER
	cus27 
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
			.CLK_8V(CLK_8V),
			.CLK_4V(CLK_4V),
			.CLK_1V(CLK_1V),
			.CLK_4H(CLK_4H),
			.CLK_2H(CLK_2H),
			.CLK_1H(CLK_1H),
			.CLK_S2H(CLK_S2H),
			.CLK_S1H(CLK_S1H)
		);

	// == TTL glue logic
    
	ls74 
		ls74_8u(
			.CLK1(CLK_6M),
			.nPRE1(1'b1),
			.nCLR1(1'b1),
			.D1(CLK_1H),
			.Q1(CLK_n1H),
			.CLK2(CLK_4H),
			.nPRE2(1'b1),
			.nCLR2(nVBLANK),
			.D2(nHBLANK),
			.nQ2(BLANKING)
		);

	assign CLK_6MD = CLK_6M;
	assign CLK_nS1H = ~CLK_S1H;
	assign nCOMPSYNC = nHSYNC && nVSYNC;	// via LS08 (3H) and'ing of negated signals
	
endmodule
