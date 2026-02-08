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
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
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
module furrtek_clock_divider (
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
	
	assign sig_b24M_o = sig_D5_bQ_2;
	assign sig_b12M_o = sig_B5_Q_2;
	assign sig_b6M_OUT_o = sig_E1_Q_2;
	assign sig_bS1H_o = sig_G8_bQ_2;
	assign sig_bS2H_o = sig_G1_Q_2;
	
	// inverted internal signals
	assign sig_E5TOP_o = ~sig_E7BOT;
	assign sig_24M_o = sig_D5_bQ_2; // schematics show that these are in-phase with the pin outputs driven by sig_b24M_o
	assign sig_12M_o = sig_B5_Q_2;
	
	assign sig_D5_Q_2 = sig_D5_Q;
	assign sig_D5_bQ_2 = sig_D5_bQ;
	assign sig_B5_Q_2 = sig_B5_Q;
	assign sig_E1_Q_2 = sig_E1_Q;
	assign sig_E1_bQ_2 = sig_E1_bQ;
	assign sig_G8_Q_2 = sig_G8_Q;
	assign sig_G8_bQ_2 = sig_G8_bQ;
	assign sig_G1_Q_2 = sig_G1_Q;
	assign sig_G1_bQ_2 = sig_G1_bQ;
	
	wire sig_E7BOT;
	wire sig_D5_Q;
	wire sig_D5_bQ;
	wire sig_B5_Q;
	wire sig_B9BOT_Y;
	wire sig_E1_Q;
	wire sig_E1_bQ;
	wire sig_G8_Q;
	wire sig_G8_bQ;
	wire sig_G1_Q;
	wire sig_G1_bQ;

	//
	// RTL
	//
	
	//
	// synthesise the routing of internal signals through inverter cells 
	
	assign sig_E6TOP = ~sig_B9BOT_Y;
	
	//
	// standard cell synthesis
	
		// E7BOT interpretation - disables all clocks if MODE1 active
	//	output is low if MODE1 high and MODE0 and FLIP are low, otherwise output is high
	cus27_nand3
		cus27_E7BOT_nand3 (
			.A(sig_bMODE1_i),
			.B(sig_MODE0_i),
			.C(sig_FLIP_i),
			.Y(sig_E7BOT)
		);
		
	cus27_tff
		cus27_D5_tff (
			.CLK(sig_48M_i),
			.SET(sig_E7BOT),
			.Q(sig_D5_Q),
			.bQ(sig_D5_bQ) );
		
	cus27_jkff
		cus27_B5_jkff (
			.CLK(sig_48M_i),
			.bJ(sig_D5_Q_2),
			.K(sig_D5_bQ_2),
			.RES(sig_E7BOT),
			.Q(sig_B5_Q) );
		
	cus27_nand3
		cus27_B9BOT_nand3 (
			.A(sig_D5_bQ_2),
			.B(sig_B5_Q_2),
			.Y(sig_B9BOT_Y) );
			
	cus27_jkff
		cus27_E1_jkff(
			.CLK(sig_48M_i),
			.bJ(sig_B9BOT_Y),
			.K(sig_E6TOP),
			.RES(sig_E7BOT),
			.Q(sig_E1_Q),
			.bQ(sig_E1_bQ)
		);
		
	cus27_tff
		cus27_G8_tff(
			.CLK(sig_E1_bQ_2),
			.RES(sig_bHRESET1_i),
			.Q(sig_G8_Q),
			.bQ(sig_G8_bQ)
		);
		
	cus27_jkff
		cus27_G1_jkff(
			.CLK(sig_E1_bQ_2),
			.bJ(sig_G8_bQ_2),
			.K(sig_G8_Q_2),
			.SET(sig_bHRESET1_i),
			.Q(sig_G1_Q),
			.bQ(sig_G1_bQ)
		);
			
endmodule
