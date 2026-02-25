`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_pin41.v 
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
module furrtek_pin41 (
	input wire sim_rst_n,
	
	// input clocks
	input wire sig_b48M_i,
	input wire sig_48M2_i,
	
	// internal routing inputs
	input wire sig_bMODE1_i,
	input wire sig_MODE0_i,
	input wire sig_FLIP_i,
	
	output wire sig_bPIN41_o	//	pin 41 driver
);

	// output mapping
	assign sig_bPIN41_o = sig_D8_Q;
	
	// internal routing
	wire sig_E6BOT;
	wire sig_C1_Q;
	wire sig_C1_XQ;
	wire sig_C9TOP;
	wire sig_C5_Q;
	wire sig_C5_XQ;
	wire sig_D1_Q;
	wire sig_D1_XQ;
	wire sig_D8_Q;
	

	//
	// RTL
	//
	
	//
	// synthesise the routing of signals through simple logic cells 
	
	assign sig_C9TOP = sig_C5_XQ & sig_D1_XQ;
	
	//
	// standard cell synthesis
	
	// E6BOT interpretation - enable <pin 41> signal if MODE1 active
	//	output is low if MODE1 high and MODE0 and FLIP are low, otherwise output is high
	mb111_n03_nand3
		cus27_E6BOT_nand3(
			.A(sig_bMODE1_i),
			.B(sig_MODE0_i),
			.C(sig_FLIP_i),
			.Y(sig_E6BOT)
		);
		
	mb111_fj3_jxkff
		cus27_C1_jkff(
			.CLK(sig_48M2_i),
			.J(sig_C1_Q),
			.XK(sig_C9TOP),
			.bRES(sig_E6BOT & sim_rst_n),
			.Q(sig_C1_Q),
			.XQ(sig_C1_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_C5_jkff(
			.CLK(sig_48M2_i),
			.J(sig_C1_XQ),
			.XK(sig_C1_Q),
			.bRES(sig_E6BOT & sim_rst_n),
			.Q(sig_C5_Q),
			.XQ(sig_C5_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_D1_jkff(
			.CLK(sig_48M2_i),
			.J(sig_C5_XQ),
			.XK(sig_C5_Q),
			.bRES(sig_E6BOT & sim_rst_n),
			.Q(sig_D1_Q),
			.XQ(sig_D1_XQ)
		);
		
	mb111_fd1_dff
		cus27_D8_dff(
			.CLK(sig_b48M_i),
			.D(sig_D1_Q),
			.bSET(sig_E6BOT & sim_rst_n),
			.Q(sig_D8_Q)
		);
			
endmodule
