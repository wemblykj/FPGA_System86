`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\cus27.v 
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
module furrtek_clockdivider
(
	// simulation control
	input wire _rst_ni,
	
	// input clocks
	input wire sig_48M_i,
	
	// internal routing inputs
	input wire sig_bHRESET1_i,
	input wire sig_E7BOT_i,
	
	// generated clocks
   output wire sig_24M_o,
   output wire sig_12M_o,
   output wire sig_6M_o,
	
	output wire sig_S1H_o,	//	1 pixel count (negative offset?)
	output wire sig_S2H_o	//	2 pixel count (negative offset?)
);

	assign sig_24M_o = ~sig_D5_bQ;
	assign sig_12M_o = ~sig_B5_Q;
	assign sig_6M_o = ~sig_E1_Q;
	assign sig_S1H_o = ~sig_G8_bQ;
	assign sig_S2H_o = ~sig_G1_Q;
	
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
	
	cus27_tff
		cus27_D5_tff(
			._rst_ni(_rst_ni),
			.CLK(sig_48M_i),
			.bSET(sig_E7BOT_i),
			.Q(sig_D5_Q),
			.bQ(sig_D5_bQ)
		);
		
	cus27_jkff
		cus27_B5_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_48M_i),
			.bJ(sig_D5_Q),
			.K(sig_D5_bQ),
			.bRES(sig_E7BOT_i),
			.Q(sig_B5_Q)
		);
		
	cus27_nand
		cus27_B9BOT_nand(
			.A(sig_D5_bQ),
			.B(sig_B5_Q),
			.Y(sig_B9BOT_Y)
		);
			
	cus27_jkff
		cus27_E1_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_48M_i),
			.bJ(sig_B9BOT_Y),
			.K(sig_E6TOP),
			.bRES(sig_E7BOT_i),
			.Q(sig_E1_Q),
			.bQ(sig_E1_bQ)
		);
		
	cus27_tff
		cus27_G8_tff(
			._rst_ni(_rst_ni),
			.CLK(sig_E1_bQ),
			.bRES(sig_bHRESET1_i),
			.Q(sig_G8_Q),
			.bQ(sig_G8_bQ)
		);
		
	cus27_jkff
		cus27_G1_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_E1_bQ),
			.bJ(sig_G8_bQ),
			.K(sig_G8_Q),
			.bSET(sig_bHRESET1_i),
			.Q(sig_G1_Q),
			.bQ(sig_G1_bQ)
		);
			
endmodule