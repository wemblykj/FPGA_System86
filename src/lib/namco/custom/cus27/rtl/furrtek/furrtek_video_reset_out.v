`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_video_reset_out.v
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
module furrtek_video_reset_out (
	input wire sim_rst_n,
	input wire sig_6MIN_i,
	input wire sig_E12_Q_i,
	input wire sig_J5_XQ_i,
	input wire sig_C11TOP_i,
	input wire sig_D11_XQ_i,
	input wire sig_J10BOT_i,
	input wire sig_G11_Q_i,
	input wire sig_J18_Q_i,
	input wire sig_C17_XQ_i,
	input wire sig_C15TOP_i,
	output wire sig_F6_XQ_o,
	output wire sig_G5_XQ_o
 ); 
	
	wire sig_F11BOT;
	wire sig_G17TOP;
	wire sig_F6_XQ;
	wire sig_G5_XQ;
	
	assign sig_F6_XQ_o = sig_F6_XQ;
	assign sig_G5_XQ_o = sig_G5_XQ;
	
	
	mb111_n06_nand6
		cus27_F11BOT_nand6(
			.A(sig_E12_Q_i),
			.B(sig_J5_XQ_i),
			.C(sig_C11TOP_i),
			.D(sig_D11_XQ_i),
			.E(sig_J10BOT_i),
			.F(sig_G11_Q_i),
			.Y(sig_F11BOT)
		);
		
	mb111_n03_nand3
		cus27_G17TOP_nand3(
			.A(sig_J18_Q_i),
			.B(sig_C17_XQ_i),
			.C(sig_C15TOP_i),
			.Y(sig_G17TOP)
		);
	
	mb111_fd1_dff
		cus27_F6_dff(
			.CLK(sig_6MIN_i),
			.D(sig_F11BOT),
			.XQ(sig_F6_XQ)
		);
		
	mb111_fd1_dff
		cus27_G5_dff(
			.CLK(sig_6MIN_i),
			.D(sig_G17TOP),
			.XQ(sig_G5_XQ)
		);
	
endmodule
