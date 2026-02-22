`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_pin40.v 
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
module furrtek_pin40 (
		// input clocks
		input wire sig_b48M_i,
		input wire sig_24M_i,
		input wire sig_12M_i,
		
		// internal routing inputs
		input wire sig_HRESET_i,
		
		output wire sig_bPIN40_o	//	pin 40 driver
	);

	wire sig_B9TOP;
	wire sig_A5_Q;
	wire sig_A1_Q;
	wire sig_A1_bQ;
	wire sig_B1_Q;
	
	assign #1 sig_bPIN40_o = sig_B1_Q;
	
	//
	// RTL
	//
	
	//
	// standard cell synthesis
	
	// E6BOT interpretation - enable <pin 41> signal if MODE1 active
	//	output is low if MODE1 high and MODE0 and FLIP are low, otherwise output is high
	n04_nand4
		cus27_B9TOP_nand4(
			.A(sig_b48M_i),
			.B(sig_24M_i),
			.C(sig_12M_i),
			.D(sig_HRESET_i),
			.Y(sig_B9TOP)
		);
		
	fj3_jxkff
		cus27_A5_jkff(
			.CLK(sig_b48M_i),
			.bJ(sig_A1_bQ),
			.RES(sig_B9TOP),
			.Q(sig_A5_Q)
		);
		
	fj3_jxkff
		cus27_A1_jkff(
			.CLK(sig_b48M_i),
			.bJ(sig_A5_Q),
			.RES(sig_B9TOP),
			.Q(sig_A1_Q),
			.bQ(sig_A1_bQ)
		);
		
	fj3_jxkff
		cus27_D1_jkff(
			.CLK(sig_b48M_i),
			.bJ(sig_A1_bQ),
			.K(sig_A1_Q),
			.RES(sig_B9TOP),
			.Q(sig_B1_Q)
		);
			
endmodule
