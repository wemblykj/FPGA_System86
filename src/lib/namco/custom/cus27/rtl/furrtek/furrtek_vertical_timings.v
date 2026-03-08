`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_horizontal_timings.v
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
module furrtek_vertical_timings (
	input wire sim_rst_n,
	input wire sig_bVRESET1_i,
	input wire sig_bVRESET2_i,
	input wire sig_bVRESET3_i,
	input wire sig_A17_Q_i,
	output wire sig_D15_Q_o,
	output wire sig_D15_XQ_o,
	output wire sig_D18_Q_o,
	output wire sig_D18_XQ_o,
	output wire sig_F18_XQ_o,
	output wire sig_H18_Q_o,
	output wire sig_H18_XQ_o,
	output wire sig_G18_Q_o,
	output wire sig_G18_XQ_o,
	output wire sig_J18_Q_o,
	output wire sig_bVBLA_o
);
	
	wire sig_D15_Q;
	wire sig_D15_XQ;
	wire sig_D18_Q;
	wire sig_D18_XQ;
	wire sig_F18_XQ;
	wire sig_G18_Q;
	wire sig_H18_Q;
	wire sig_H18_XQ;
	wire sig_J18_Q;
	wire sig_J18_XQ;
	wire sig_F15BOT;
	
	assign sig_D15_Q_o = sig_D15_Q;
	assign sig_D15_XQ_o = sig_D15_XQ;
	assign sig_D18_Q_o = sig_D18_Q;
	assign sig_D18_XQ_o = sig_D18_XQ;
	assign sig_F18_XQ_o = sig_F18_XQ;
	assign sig_G18_Q_o = sig_G18_Q;
	assign sig_G18_XQ_o = sig_G18_XQ;
	assign sig_H18_Q_o = sig_H18_Q;
	assign sig_H18_XQ_o = sig_H18_XQ;
	assign sig_J18_Q_o = sig_J18_Q;
	assign sig_bVBLA_o = sig_F18_XQ;

	//
	// RTL
	//
	
	//
	// standard cell synthesis
	
	mb111_ft1_tff
		cus27_H18_tff(
			.CLK(sig_A17_Q_i),
			.bRES(sig_bVRESET2_i & sim_rst_n),
			.Q(sig_H18_Q),
			.XQ(sig_H18_XQ)
		);
	
	mb111_ft1_tff
		cus27_D15_tff(
			.CLK(sig_H18_XQ),
			.bRES(sig_bVRESET2_i & sim_rst_n),
			.Q(sig_D15_Q),
			.XQ(sig_D15_XQ)
		);
	
	mb111_ft1_tff
		cus27_D18_tff(
			.CLK(sig_D15_XQ),
			.bRES(sig_bVRESET1_i & sim_rst_n),
			.Q(sig_D18_Q),
			.XQ(sig_D18_XQ)
		);
		
	mb111_ft1_tff
		cus27_G18_tff(
			.CLK(sig_D18_XQ),
			.bRES(sig_bVRESET1_i & sim_rst_n),
			.Q(sig_G18_Q),
			.XQ(sig_G18_XQ)
		);
		
	mb111_ft1_tff
		cus27_J18_tff(
			.CLK(sig_G18_XQ),
			.bRES(sig_bVRESET1_i & sim_rst_n),
			.Q(sig_J18_Q)
		);
		
	mb111_n03_nand3
		cus27_F15BOT_nand3(
			.A(sig_D15_Q),
			.B(sig_D18_Q),
			.C(sig_J18_Q),
			.Y(sig_F15BOT)
		);
		
	mb111_fd1_dff
		cus27_F18_dff(
			.CLK(sig_H18_Q),
			.D(sig_F15BOT),
			.bRES(sig_bHRESET3 & sim_rst_n),
			.XQ(sig_F18_XQ)
		);	

endmodule
