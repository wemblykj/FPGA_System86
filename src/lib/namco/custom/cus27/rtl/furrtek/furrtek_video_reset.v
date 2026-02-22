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
module furrtek_video_reset (
		// input clocks
		input wire sig_b48M_2_i,
		input wire sig_bHRES_IN_i,
		input wire sig_bVRES_IN_i,
		input wire sig_E5TOP_i,
		output wire sig_HRESET_o,
		output wire sig_bHRESET1_o,
		output wire sig_bHRESET2_o,
		output wire sig_bHRESET3_o,
		output wire sig_bVRESET1_o,
		output wire sig_bVRESET2_o,
		output wire sig_bVRESET3_o
	);

	wire sig_E5BOT;
	wire sig_F5BOT;
	wire sig_F5TOP;
	
	wire sig_C16TOP;
	wire sig_B15TOP;
	wire sig_B15BOT;
	
	wire sig_F9TOP;
	wire sig_F9BOT;
	wire sig_H9TOP;
	
	assign #1 sig_HRESET_o = sig_F5TOP;
	assign #1 sig_bHRESET1_o = sig_F9TOP;
	assign #1 sig_bHRESET2_o = sig_F9BOT;
	assign #1 sig_bHRESET3_o = sig_H9TOP;
	
	assign #1 sig_bVRESET1_o = sig_F9TOP;
	assign #1 sig_bVRESET2_o = sig_F9BOT;
	assign #1 sig_bVRESET3_o = sig_H9TOP;
	
	//
	// RTL
	//
	
	//
	// synthesise the routing of signals through simple logic cells 
	
	assign sig_C16TOP = ~sig_F5BOT;
	assign sig_B15TOP = ~sig_F5BOT;
	assign sig_B15BOT = ~sig_F5BOT;
	
	assign sig_F9TOP = ~sig_F5TOP;
	assign sig_F9BOT = ~sig_F5TOP;
	assign sig_H9TOP = ~sig_F5TOP;

	//
	// standard cell synthesis
	
	n03_nand3
		cus27_E5BOT_nand3(
			.A(sig_b48M_2_i),
			.B(sig_E5TOP_i),
			.Y(sig_E5BOT)
		);
		
	n03_nand3
		cus27_F5BOT_nand3(
			.A(sig_bHRES_IN_i),
			.B(sig_E5BOT),
			.Y(sig_F5BOT)
		);
		
	n03_nand3
		cus27_F5TOP_nand3(
			.A(sig_bHRES_IN_i),
			.B(sig_E5BOT),
			.Y(sig_F5TOP)
		);
			
endmodule
