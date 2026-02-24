`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_clock_divider.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - based on third-party reverse engineering of the CUS27 die
//                 From further investigation it looks like the chip is a Fujistu B-350 gate array [^4]
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//                 [^4] https://datasheet4u.com/pdf-down/M/B/1/MB111XXX_Fujitsu.pdf
//
//                 Kudos go to:
//                  Furrtek for reverse engineering: http://www.furrtek.org
//                  JohnDMcMaster for die photos: https://siliconprawn.org/
//
//
// Dependencies: 
//
// Revision:		 Revisiting timing accuracy 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module furrtek_clock_divider
(
	input wire sim_rst_n,
    
	// input clocks
	input wire sig_48M_i,
	
	// internal routing inputs
	input wire sig_bMODE1_i,
	input wire sig_MODE0_i,
	input wire sig_FLIP_i,
	input wire sig_bHRESET1_i,
	
	// generated clocks
	output wire sig_b24M_o,
	output wire sig_b12M_o,
	output wire sig_b6M_OUT_o,
	
	output wire sig_bS1H_o,	//	1 pixel count (negative offset?)
	output wire sig_bS2H_o,	//	2 pixel count (negative offset?)
	
	// internal routing outputs
	output wire sig_E5TOP_o,
	output wire sig_24M_o,
	output wire sig_12M_o
);
	
	assign sig_b24M_o = sig_D5_XQ;
	assign sig_b12M_o = sig_B5_Q;
	assign sig_b6M_OUT_o = sig_E1_Q;
	assign sig_bS1H_o = sig_G8_XQ;
	assign sig_bS2H_o = sig_G1_Q;
	
	// inverted internal signals
	assign sig_E5TOP_o = sig_E5TOP;
	assign sig_24M_o = sig_D5_XQ; // schematics show that these are in-phase with the pin outputs driven by sig_b24M_o
	assign sig_12M_o = sig_B5_Q;
	
	wire sig_E7BOT;
	wire sig_E5TOP;
	wire sig_D5_Q;
	wire sig_D5_XQ;
	wire sig_B5_Q;
	wire sig_B9BOT;
	wire sig_E1_Q;
	wire sig_E1_XQ;
	wire sig_G8_Q;
	wire sig_G8_XQ;
	wire sig_G1_Q;

	//
	// RTL
	//

	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_E5TOP_inverter (
			.A(sig_E7BOT),
			.Y(sig_E5TOP)
		);
		
	mb111_n01_inverter
		cus27_E6TOP_inverter (
			.A(sig_B9BOT),
			.Y(sig_E6TOP)
		);
		
	// disables all clocks if MODE1 active
	mb111_n03_nand3
		cus27_E7BOT_nand3 (
			.A(sig_bMODE1_i),
			.B(sig_MODE0_i),
			.C(sig_FLIP_i),
			.Y(sig_E7BOT)
		);
		
	mb111_ft1_tff
		cus27_D5_tff (
			.CLK(sig_48M_i),
			.bSET(sig_E7BOT & sim_rst_n),
			.Q(sig_D5_Q),
			.XQ(sig_D5_XQ) );
		
	mb111_fj3_jxkff
		cus27_B5_jkff (
			.CLK(sig_48M_i),
			.J(sig_D5_Q),
			.XK(sig_D5_XQ),
			.bRES(sig_E7BOT & sim_rst_n),
			.Q(sig_B5_Q) );
		
	mb111_n02_nand2
		cus27_B9BOT_nand2 (
			.A(sig_D5_XQ),
			.B(sig_B5_Q),
			.Y(sig_B9BOT) );
			
	mb111_fj3_jxkff
		cus27_E1_jkff(
			.CLK(sig_48M_i),
			.J(sig_B9BOT),
			.XK(sig_E6TOP),
			.bRES(sig_E7BOT & sim_rst_n),
			.Q(sig_E1_Q),
			.XQ(sig_E1_XQ)
		);
		
	mb111_ft1_tff
		cus27_G8_tff(
			.CLK(sig_E1_XQ),
			.bRES(sig_bHRESET1_i & sim_rst_n),
			.Q(sig_G8_Q),
			.XQ(sig_G8_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_G1_jkff(
			.CLK(sig_E1_XQ),
			.J(sig_G8_XQ),
			.XK(sig_G8_Q),
			.bSET(sig_bHRESET1_i & sim_rst_n),
			.Q(sig_G1_Q)
		);
			
endmodule
