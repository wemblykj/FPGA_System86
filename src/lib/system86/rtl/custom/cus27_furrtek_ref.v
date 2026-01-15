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
	input wire pin_MODE1_i,		// use external resets
	input wire pin_FLIP_i,
	
	input wire pin_bHRES_IN_i,	// external horizontal reset
	input wire pin_bVRES_IN_i, // external vertical reset
	
	// generated clocks
   output wire pin_24M_o,
   output wire pin_12M_o,
   output wire pin_6M_o,
	
	// video synchronisation
	
	output wire pin_bHSYNC_o,
	output wire pin_bHBLANK_o,
	output wire pin_bHRES_o,
	output wire dir_bHRES_o,
	
	output wire pin_bVSYNC_o,
	output wire pin_bVBLANK_o,
	output wire pin_bVRES_o,
	output wire dir_bVRES_o,
	
	// video timing signals
	
	output wire pin_1H_o,	// 1 pixel count
	output wire pin_2H_o,	// 2 pixel count
	output wire pin_4H_o,	// 4 pixel count
	output wire pin_1V_o,	//	1 line count
	output wire pin_2V_o,	//	2 line count
	output wire pin_4V_o,	//	4 line count
	output wire pin_8V_o,	//	8 line count
	output wire pin_S1H_o,	//	1 pixel count (negative offset?)
	output wire pin_S2H_o,	//	2 pixel count (negative offset?)
	
	output wire pin_PIN40_o,	// unknown function, HRESET dependant
	output wire pin_PIN41_o	// unknown function, regular pulse in sync with 48M clock
);

	// I'm going out on a limb and assuming that signals into and out of the chip are inverted and that the logic cells are
	// expecting this such that the inputs to an inverter are themselves inverted and the standard cell input stage logic is a NOR gate
	// resulting in NAND logic
	
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
	
	//
	// internal signals
	
	wire sig_48M;
	wire sig_24M;
	wire sig_12M;
	wire sig_6M;

	wire sig_S1H;
	wire sig_S2H;
	
	wire sig_MODE0;
	wire sig_MODE1;
	wire sig_FLIP;
	
	// inverted inputs
	wire sig_b48M;
	wire sig_b48M2;
	wire sig_b6MIN;
	wire sig_b6MIN2;
	wire sig_bMODE0;
	wire sig_bFLIP;
		
	wire sig_bHRESET1;
	wire sig_E7BOT;
	
	wire sig_PIN40;
	wire sig_PIN41;
	
	//
	// route input pins to internal signals
	
	assign sig_48M = pin_48M_i;
	assign sig_6M = pin_6M_i;
	
	assign sig_MODE0 = pin_MODE0_i;
	assign sig_MODE1 = pin_MODE1_i;
	assign sig_FLIP = pin_FLIP_i;
	assign sig_bHRES_IN = pin_bHRES_IN_i;
	assign sig_bVRES_IN = pin_bVRES_IN_i;
	
	//
	// route internal signals to output pins
	
	assign pin_24M_o = sig_24M;
	assign pin_12M_o = sig_12M;
	//assign pin_6M_o = sig_6M;
	assign pin_S1H_o = sig_S1H;
	assign pin_S2H_o = sig_S2H;
	
	assign pin_bHRES_o = sig_bHRES;
	assign dir_HRES_o = pin_MODE1_i;
	assign pin_bVRES_o = sig_bVRES;
	assign dir_VRES_o = pin_MODE1_i;
	
	assign pin_PIN40_o = sig_PIN40;
	assign pin_PIN41_o = sig_PIN41;

	// TODO
	assign sig_E5BOT = ~(sig_48M & sig_E5TOP);
	
	// HRESET in input mode
	assign sig_F5TOP = ~(sig_bHRES_IN & sig_E5BOT);
	assign sig_HRESET = sig_F5TOP;
	assign sig_bHRESET1 = ~sig_F5TOP;
	assign sig_bHRESET2 = ~sig_F5TOP;
	assign sig_bHRESET3 = ~sig_F5TOP;
	// VRESET in input mode
	assign sig_F5BOT = ~(sig_bVRES_IN & sig_E5BOT);
	assign sig_VRESET = sig_F5BOT;
	assign sig_bVRESET1 = ~sig_F5BOT;
	assign sig_bVRESET2 = ~sig_F5BOT;
	assign sig_bVRESET3 = ~sig_F5BOT;
	// HRESET in output mode
	assign sig_bHRES = 1'b1; 
	// VRESET in output mode
	assign sig_bVRES = 1'b1; 
	
	//
	// RTL
	//
	
	//
	// synthesise the routing of signals through inverter cells  
	
	// inverted input signals
	assign sig_b48M = ~pin_48M_i;
	assign sig_b48M2 = ~pin_48M_i;	// schematic shows this is driven off a secondary IO block signal pin_48M_2_i
	assign sig_b6MIN = ~pin_6M_i;
	assign sig_b6MIN2 = ~pin_6M_i;
	
	assign sig_bMODE0 = ~pin_MODE0_i;
	assign sig_bFLIP = ~pin_FLIP_i;		// schematic shows this is driven off a secondary IO block signal pin_FLIP_2_i
	assign sig_bFLIP2 = ~pin_FLIP_i;
	
	// inverted internal signals
	assign sig_E5TOP = ~sig_E7BOT;
	
	//
	// miscellaneous standard cell synthesis
	
	// E7BOT interpretation - disables all clocks if MODE1 active
	//	output is low if MODE1 high and MODE0 and FLIP are low, otherwise output is high
	cus27_nand
		cus27_E7BOT_nand(
			.A(sig_MODE1),
			.B(sig_bMODE0),
			.C(sig_bFLIP),
			.Y(sig_E7BOT)
		);
	
	//	
	// delegate to sub-modules
	
	furrtek_clockdivider 
		clockdivider (
		._rst_ni(_rst_ni), 
		.sig_48M_i(sig_48M), 
		.sig_bHRESET1_i(sig_bHRESET1), 
		.sig_E7BOT_i(sig_E7BOT),
		.sig_24M_o(sig_24M), 
		.sig_12M_o(sig_12M), 
		.sig_6M_o(pin_6M_o), // drive the output pin directly as sig_6M maps to the CUS27 input
		.sig_S1H_o(sig_S1H), 
		.sig_S2H_o(sig_S2H)
	);
	
	furrtek_pin40
		pin40 (
		._rst_ni(_rst_ni),		
		.sig_48M_i(sig_48M),
		.sig_24M_i(sig_24M),
		.sig_12M_i(sig_12M),
		.sig_HRESET_i(sig_HRESET),
		.sig_PIN40_o(sig_PIN40)
	);
	
	furrtek_pin41
		pin41 (
		._rst_ni(_rst_ni),
		.sig_MODE1_i(sig_MODE1),
		.sig_bMODE0_i(sig_bMODE0),
		.sig_bFLIP_i(sig_bFLIP),
		.sig_48M_i(sig_48M),
		.sig_b48M2_i(sig_b48M2), 
		.sig_PIN41_o(sig_PIN41)
	);
			
endmodule