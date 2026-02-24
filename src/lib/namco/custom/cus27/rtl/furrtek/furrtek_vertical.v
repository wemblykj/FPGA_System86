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
	input wire sim_rst_n,
	
	// input clocks
	input wire sig_6MIN_i,
	
	input wire sig_FLIP_i,
	input wire sig_MODE0_i,
	
	input wire sig_bVRESET3_i,
	
	input wire sig_E12_Q_i,
	input wire sig_J5_XQ_i,
	input wire sig_C11TOP_i,
	input wire sig_D11_Q_i,
	input wire sig_J10BOT_i,
	input wire sig_G11_XQ_i,
	
	output wire sig_b1V_o,
	output wire sig_b2V_o,
	output wire sig_b4V_o,
	
	// internal routing ouputs
	output wire sig_C15TOP_o,
	output wire sig_C17_XQ_o,
	output wire sig_A17_Q_o,	// presuming this is equivalent to 8V
	output wire sig_A17_XQ_o
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
	assign sig_C17_XQ_o = sig_C17_XQ;
	assign sig_A17_Q_o = sig_A17_Q;
	assign sig_A17_XQ_o = sig_A17_XQ;
	
	//
	// RTL
	//

	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_E15TOP_inverter (
			.A(sig_F16BOT),
			.Y(sig_E15TOP)
		);
		
	mb111_n01_inverter
		cus27_B16TOP_inverter (
			.A(sig_F17BOT),
			.Y(sig_B16TOP)
		);
		
	mb111_n01_inverter
		cus27_C15TOP_inverter (
			.A(sig_F17TOP),
			.Y(sig_C15TOP)
		);
		
	mb111_n01_inverter
		cus27_E5TOP_inverter (
			.A(sig_F15TOP),
			.Y(sig_A16TOP)
		);
		
	mb111_n06_nand6
		cus27_F11TOP_nand6(
			.A(sig_E12Q_i),
			.B(sig_J5XQ_i),
			.C(sig_C11TOP_i),
			.D(sig_D11Q_i),
			.E(sig_J10BOT_i),
			.F(sig_G11XQ_i),
			.Y(sig_F11TOP)
		);
	
	mb111_n02_nand2
		cus27_E9BOT_nand2(
			.A(sig_FLIP_i),
			.B(sig_MODE0_i),
			.Y(sig_E9BOT)
		);
		
	mb111_n02_nand2
		cus27_F16BOT_nand2(
			.A(sig_F11TOP),
			.B(sig_E9BOT),
			.Y(sig_F16BOT)
		);
		
	mb111_n02_nand2
		cus27_F17BOT_nand3(
			.A(sig_E17_XQ),
			.B(sig_F16BOT),
			.Y(sig_F17BOT)
		);
	
	mb111_n03_nand3
		cus27_F17TOP_nand3(
			.A(sig_B17_XQ),
			.B(sig_E17_XQ),
			.C(sig_F16BOT),
			.Y(sig_F17TOP)
		);
		
	mb111_fj3_jxkff
		cus27_E17_jkff(
			.CLK(sig_6MIN_i),
			.J(sig_E17TOP),
			.XK(sig_F16BOT),
			.bSET(sig_bVRESET3_i & sim_rst_n),
			.Q(sig_E17_Q),
			.XQ(sig_E17_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_B17_jkff(
			.CLK(sig_6MIN_i),
			.J(sig_F16BOT),
			.XK(sig_B16TOP),
			.bSET(sig_bVRESET3_i & sim_rst_n),
			.Q(sig_B17_Q),
			.XQ(sig_B17_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_C17_jkff(
			.CLK(sig_6MIN_i),
			.J(sig_F17TOP),
			.XK(sig_C15TOP),
			.bSET(sig_bVRESET3_i & sim_rst_n),
			.Q(sig_C17_Q),
			.XQ(sig_C17_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_A17_jkff(
			.CLK(sig_6MIN_i),
			.J(sig_F15TOP),
			.XK(sig_A16TOP),
			.bSET(sig_bVRESET3_i & sim_rst_n),
			.Q(sig_A17_Q),
			.XQ(sig_A17_XQ)
		);
	
endmodule
