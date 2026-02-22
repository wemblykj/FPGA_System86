`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_vertical.v
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
module furrtek_vertical (
		// input clocks
		input wire sig_6MIN_i,
		
		input wire sig_FLIP_i,
		input wire sig_MODE0_i,
		
		input wire sig_bVRESET3_i,
		
		input wire sig_E12Q_i,
		input wire sig_J5bQ_i,
		input wire sig_C11TOP_i,
		input wire sig_D11Q_i,
		input wire sig_J10BOT_i,
		input wire sig_G11bQ_i,
		
		output wire sig_b1V_o,
		output wire sig_b2V_o,
		output wire sig_b4V_o,
		
		// internal routing ouputs
		output wire sig_C15TOP_o,
		output wire sig_C17bQ_o,
		output wire sig_A17Q_o,	// presuming this is equivalent to 8V
		output wire sig_A17Q_o
	);
	
	wire sig_A16TOP;
	wire sig_B16TOP;
	wire sig_C15TOP;
	wire sig_E15TOP;
	wire sig_E9BOT;
	
	wire sig_F11TOP;
	wire sig_F16BOT;
	wire sig_F17TOP;
	
	assign sig_b1V_o = sig_E17_Q;
	assign sig_b2V_o = sig_B17_Q;
	assign sig_b4V_o = sig_C17_Q;
	assign sig_C15TOP_o = sig_C15TOP;
	assign sig_C17_bQ_o = sig_C17_bQ;
	assign sig_A17Q_o = sig_A17_Q;
	assign sig_A17bQ_o = sig_A17_bQ;
	
	//
	// RTL
	//
	
	//
	// synthesise the routing of signals through simple logic cells 
	
	assign sig_E15TOP = ~sig_F16BOT;
	assign sig_B16TOP = ~sig_F17BOT;
	assign sig_C15TOP = ~sig_F17TOP;
	assign sig_A16TOP = ~sig_F15TOP;
	
	//
	// standard cell synthesis
	
	n06_nand6
		cus27_F11TOP_nand6(
			.A(sig_E12Q_i),
			.B(sig_J5bQ_i),
			.C(sig_C11TOP_i),
			.D(sig_D11Q_i),
			.E(sig_J10BOT_i),
			.F(sig_G11bQ_i),
			.Y(sig_F11TOP)
		);
	
	n03_nand3
		cus27_E9BOT_nand3(
			.A(sig_FLIP_i),
			.B(sig_MODE0_i),
			.Y(sig_E9BOT)
		);
		
	n03_nand3
		cus27_F16BOT_nand3(
			.A(sig_F11TOP),
			.B(sig_E9BOT),
			.Y(sig_F16BOT)
		);
		
	n03_nand3
		cus27_F17BOT_nand3(
			.A(sig_E17_bQ),
			.B(sig_F16BOT),
			.Y(sig_F17BOT)
		);
	
	n03_nand3
		cus27_F17TOP_nand3(
			.A(sig_B17_bQ),
			.B(sig_E17_bQ),
			.C(sig_F16BOT),
			.Y(sig_F17TOP)
		);
		
	fj3_jxkff
		cus27_E17_jkff(
			.CLK(sig_6MIN_i),
			.bJ(sig_E17TOP),
			.K(sig_F16BOT),
			.SET(sig_bVRESET3_i),
			.Q(sig_E17_Q),
			.bQ(sig_E17_bQ)
		);
		
	fj3_jxkff
		cus27_B17_jkff(
			.CLK(sig_6MIN_i),
			.bJ(sig_F16BOT),
			.K(sig_B16TOP),
			.SET(sig_bVRESET3_i),
			.Q(sig_B17_Q),
			.bQ(sig_B17_bQ)
		);
		
	fj3_jxkff
		cus27_C17_jkff(
			.CLK(sig_6MIN_i),
			.bJ(sig_F17TOP),
			.K(sig_C15TOP),
			.SET(sig_bVRESET3_i),
			.Q(sig_C17_Q),
			.bQ(sig_C17_bQ)
		);
		
	fj3_jxkff
		cus27_E17_jkff(
			.CLK(sig_6MIN_i),
			.bJ(sig_F15TOP),
			.K(sig_A16TOP),
			.SET(sig_bVRESET3_i),
			.Q(sig_E17_Q),
			.bQ(sig_E17_bQ)
		);
	
endmodule
