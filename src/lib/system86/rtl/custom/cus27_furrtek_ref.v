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
module cus27_furrtek_ref
(
	// simulation control
	input wire _rst_ni,
	
	// input clocks
	input wire pin_48M_i,
	input wire pin_6M_i,
	
	// configuration
	input wire pin_OTEN_i,
	input wire pin_MODE0_i,
	input wire pin_MODE1_i,
	input wire pin_FLIP_i,
	
	// generated clocks
   output wire pin_24M_o,
   output wire pin_12M_o,
   output wire pin_6M_o,
	
	// video synchronisation
	output wire pin_bVSYNC_o,
	output wire pin_bHSYNC_o,
	output wire pin_bVBLANK_o,
	output wire pin_bHBLANK_o,
	output wire pin_bVRESET_o,
	output wire pin_bHRESET_o,
	
	// video timing signals
	
	output wire pin_1H_o,	// 1 pixel count
	output wire pin_2H_o,	// 2 pixel count
	output wire pin_4H_o,	// 4 pixel count
	output wire pin_1V_o,	//	1 line count
	output wire pin_2V_o,	//	2 line count
	output wire pin_4V_o,	//	4 line count
	output wire pin_8V_o,	//	8 line count
	output wire pin_S1H_o,	//	1 pixel count
	output wire pin_S2H_o	//	2 pixel count
);

	// I'm going out on a limb and assuming that signals into and out of the chip are inverted and that the logic cells are
	// expecting this such that the inputs to an inverter are themselves inverted and the standard cell input stage is a NOR gate
	
	// As a proof of my conjecture...
	// Assume an external observer applies signls A and B to input pins routed through an internal 'NAND' gate and the resultant output is observered as signal Q
	// The truth table for the observer is therefore as follows
	//
	//  A  |  B  |  Q ¬(A AND B) `
	// ----+-----+--------------
	//  0  |  0  |  1
	//  0  |  1  |  1
	//  1  |  0  |  1
	//  1  |  1  |  0
	//
	// However internally if inputs are inverted and the output is inverted (via a 3 output NAND as proposed by [^2])
	// then the standard cell can be implemented as an N input NOR gate (my unfounded suspicion from looking at the die)
   //	
	// observable      standard cell                    observable
	// inputs          logic                            output
	//  A  |  B  |     | ¬A |  ¬B |  ¬Q ¬(A OR B) |     | Q ¬(A AND B) |
	// ----+-----+     +----+-----+---------------+     +--------------+
	//  0  |  0  |     | 1  |  1  |  0            |     |  1           |
	//  0  |  1  |  => | 1  |  0  |  0            |  => |  1           |
	//  1  |  0  |     | 0  |  1  |  0            |     |  1           |
	//  1  |  1  |     | 0  |  0  |  1            |     |  0           |
	//
	// An inverter is simply one of these NOR gates with a single input and the unconnected inputs being treated as [high? TBC]
   //
	// observable         standard cell                    observable
	// inputs             logic                            output
	//  A  |  B (nc)|     | ¬A |  ¬B |  ¬Q ¬(A OR B) |     | Q ¬(A AND B) |
	// ----+--------+     +----+-----+---------------+     +--------------+
	//  0  |  1     |  => | 1  |  1  |  0            |     |  1           |
	//  1  |  1     |     | 0  |  0  |  1            |     |  0           |
	
	wire sig_D5_Q;
	wire sig_D5_bQ;
	wire sig_B5_Q;
	wire sig_E7BOT_Y;
	wire sig_B9BOT_Y;
	wire sig_E1_Q;
	wire sig_E1_bQ;
	wire sig_G8_Q;
	wire sig_G8_bQ;
	wire sig_G1_Q;
	wire sig_G1_bQ;
	
	assign sig_bHRESET = 1'b1;
	assign sig_E5TOP = ~sig_E7BOT_Y;
	assign sig_E6TOP = ~sig_B9BOT_Y;

	assign pin_24M_o = ~sig_D5_bQ;
	assign pin_12M_o = ~sig_B5_Q;
	assign pin_6M_o = ~sig_E1_Q;
	assign pin_S1H_o = ~sig_G8_bQ;
	assign pin_S2H_o = ~sig_G1_Q;

	cus27_nand
		cus27_E7BOT_nand(
			.A(~pin_MODE1_i),
			.B(pin_MODE0_i),
			.C(pin_FLIP_i),
			.Y(sig_E7BOT_Y)
		);
		
	cus27_tff
		cus27_D5_tff(
			._rst_ni(_rst_ni),
			.CLK(pin_48M_i),
			.bSET(sig_E7BOT_Y),
			.Q(sig_D5_Q),
			.bQ(sig_D5_bQ)
		);
		
	cus27_jkff
		cus27_B5_jkff(
			._rst_ni(_rst_ni),
			.CLK(pin_48M_i),
			.bJ(sig_D5_Q),
			.K(sig_D5_bQ),
			.bRES(sig_E7BOT_Y),
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
			.CLK(pin_48M_i),
			.bJ(sig_B9BOT_Y),
			.K(sig_E6TOP),
			.bRES(sig_E7BOT_Y),
			.Q(sig_E1_Q),
			.bQ(sig_E1_bQ)
		);
		
	cus27_tff
		cus27_G8_tff(
			._rst_ni(_rst_ni),
			.CLK(sig_E1_bQ),
			.bRES(sig_bHRESET1),
			.Q(sig_G8_Q),
			.bQ(sig_G8_bQ)
		);
		
	cus27_jkff
		cus27_G1_jkff(
			._rst_ni(_rst_ni),
			.CLK(sig_E1_bQ),
			.bJ(sig_G8_bQ),
			.K(sig_G8_Q),
			.bSET(sig_bHRESET1),
			.Q(sig_G1_Q),
			.bQ(sig_G1_bQ)
		);
			
endmodule