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
module furrtek_pin41
(
	// simulation control
	input wire _rst_ni,
	
	// input clocks
	input wire sig_48M_i,
	input wire sig_b48M2_i,
	
	// internal routing inputs
	input wire sig_MODE1_i,
	input wire sig_bMODE0_i,
	input wire sig_bFLIP_i,
	
	output wire sig_PIN41_o	//	pin 41 driver
);

	wire sig_E6BOT;
	wire sig_C1_Q;
	wire sig_C1_bQ;
	wire sig_C9TOP;
	wire sig_C5_Q;
	wire sig_C5_bQ;
	wire sig_D1_Q;
	wire sig_D1_bQ;
	wire sig_D8_Q;
	
	assign sig_PIN41_o = sig_D8_Q;
	
	//
	// RTL
	//
	
	//
	// synthesise the routing of signals through simple logic cells 
	
	assign sig_C9TOP = sig_C5_bQ & sig_D1_bQ;
	
	//
	// standard cell synthesis
	
	// E6BOT interpretation - enable <pin 41> signal if MODE1 active
	//	output is low if MODE1 high and MODE0 and FLIP are low, otherwise output is high
	cus27_nand
		cus27_E6BOT_nand(
			.A(sig_MODE1_i),
			.B(sig_bMODE0_i),
			.C(sig_bFLIP_i),
			.Y(sig_E6BOT)
		);
		
	cus27_jkff
		cus27_C1_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_b48M2_i),
			.bJ(sig_C1_Q),
			.K(sig_C9TOP),
			.bRES(sig_E6BOT),
			.Q(sig_C1_Q),
			.bQ(sig_C1_bQ)
		);
		
	cus27_jkff
		cus27_C5_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_b48M2_i),
			.bJ(sig_C1_bQ),
			.K(sig_C1_Q),
			.bRES(sig_E6BOT),
			.Q(sig_C5_Q),
			.bQ(sig_C5_bQ)
		);
		
	cus27_jkff
		cus27_D1_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_b48M2_i),
			.bJ(sig_C5_bQ),
			.K(sig_C5_Q),
			.bRES(sig_E6BOT),
			.Q(sig_D1_Q),
			.bQ(sig_D1_bQ)
		);
		
	cus27_dff
		cus27_D8_dff(
			._rst_ni(_rst_ni),
			.CLK(sig_48M_i),
			.D(sig_D1_Q),
			.bSET(sig_E6BOT),
			.Q(sig_D8_Q)
		);
			
endmodule