`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_horizontal.v
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
module furrtek_horizontal (
	input wire sim_rst_n,
	
	// input clocks
	input wire sig_6MIN2_i,
	input wire sig_bHRESET3_i,
	
	output wire sig_b1H_o,
	output wire sig_b2H_o,
	output wire sig_b4H_o,
	output wire sig_bPIN_6_o,	// presuming this is equivalent to 8H
	
	// internal routing ouputs
	output wire sig_J5_Q_o,
	output wire sig_J5_XQ_o
);

	wire sig_H10BOT;
	wire sig_H10TOP;
	wire sig_J9TOP;
	wire sig_J10BOT;
	wire sig_H1_Q;
	wire sig_H1_XQ;
	wire sig_H5_Q;
	wire sig_H5_XQ;
	wire sig_J1_Q;
	wire sig_J1_XQ;
	wire sig_J5_Q;
	wire sig_J5_XQ;
	
	assign sig_J5_Q_o = sig_J5_Q;
	assign sig_J5_XQ_o = sig_J5_XQ;
	assign sig_b1H_o = sig_H1_XQ;
	assign sig_b2H_o = sig_H5_Q;
	assign sig_b4H_o = sig_J1_Q;
	assign sig_bPIN_6_o = sig_J5_Q;
	
	//
	// RTL
	//
	
	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_H10BOT_inverter (
			.A(sig_H10BOT),
			.Y(sig_J9TOP)
		);
	
	mb111_n01_inverter
		cus27_J10BOT_inverter (
			.A(sig_H10TOP),
			.Y(sig_J10BOT)
		);
		
	mb111_n02_nand2
		cus27_H10BOT_nand2(
			.A(sig_H1_Q),
			.B(sig_H5_XQ),
			.Y(sig_H10BOT)
		);
		
	mb111_n03_nand3
		cus27_H10TOP_nand3(
			.A(sig_J1_XQ),
			.B(sig_H1_Q),
			.C(sig_H5_XQ),
			.Y(sig_H10TOP)
		);
				
	mb111_ft1_tff
		cus27_H1_tff(
			.CLK(sig_6MIN2_i),
			.bRES(sig_bHRESET3_i & sim_rst_n),
			.Q(sig_H1_Q),
			.XQ(sig_H1_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_H5_jkff(
			.CLK(sig_6MIN2_i),
			.J(sig_H1_XQ),
			.XK(sig_H1_Q),
			.bSET(sig_bHRESET3_i & sim_rst_n),
			.Q(sig_H5_Q),
			.XQ(sig_H5_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_J1_jkff(
			.CLK(sig_6MIN2_i),
			.J(sig_H10BOT),
			.XK(sig_J9TOP),
			.bSET(sig_bHRESET3_i & sim_rst_n),
			.Q(sig_J1_Q),
			.XQ(sig_J1_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_J5_jkff(
			.CLK(sig_6MIN2_i),
			.J(sig_H10TOP),
			.XK(sig_J10BOT),
			.bSET(sig_bHRESET3_i & sim_rst_n),
			.Q(sig_J5_Q),
			.XQ(sig_J5_XQ)
		);
	
endmodule
