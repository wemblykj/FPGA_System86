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
	input wire sim_rst_n,
	
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
	
	assign sig_HRESET_o = sig_F5TOP;
	assign sig_bHRESET1_o = sig_F9TOP;
	assign sig_bHRESET2_o = sig_F9BOT;
	assign sig_bHRESET3_o = sig_H9TOP;
	
	assign sig_bVRESET1_o = sig_C16TOP;
	assign sig_bVRESET2_o = sig_B15TOP;
	assign sig_bVRESET3_o = sig_B15BOT;
	
	//
	// RTL
	//
	
	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_C16TOP_inverter (
			.A(sig_F5BOT),
			.Y(sig_C16TOP)
		);
	
	mb111_n01_inverter
		cus27_B15TOP_inverter (
			.A(sig_F5BOT),
			.Y(sig_B15TOP)
		);
		
	mb111_n01_inverter
		cus27_B15BOT_inverter (
			.A(sig_F5BOT),
			.Y(sig_B15BOT)
		);
		
	mb111_n01_inverter
		cus27_F9TOP_inverter (
			.A(sig_F5TOP),
			.Y(sig_F9TOP)
		);
		
	mb111_n01_inverter
		cus27_F9BOT_inverter (
			.A(sig_F5TOP),
			.Y(sig_F9BOT)
		);
		
	mb111_n01_inverter
		cus27_H9TOP_inverter (
			.A(sig_F5TOP),
			.Y(sig_H9TOP)
		);
		
	mb111_n02_nand2
		cus27_E5BOT_nand2(
			.A(sig_b48M_2_i),
			.B(sig_E5TOP_i),
			.Y(sig_E5BOT)
		);
		
	mb111_n02_nand2
		cus27_F5BOT_nand2(
			.A(sig_bVRES_IN_i),
			.B(sig_E5BOT),
			.Y(sig_F5BOT)
		);
		
	mb111_n02_nand2
		cus27_F5TOP_nand2(
			.A(sig_bHRES_IN_i),
			.B(sig_E5BOT),
			.Y(sig_F5TOP)
		);
			
endmodule
