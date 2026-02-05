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
	#( parameter IOB_INPUT_INVERSION = 1'b0,
		parameter IOB_OUTPUT_INVERSION = 1'b0 )
	(
		// simulation control
		input wire _rst_ni,
		
		// input clocks
		input wire pin_48M_i,
		input wire pin_6M_IN_i,
		
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
		output wire pin_6M_OUT_o,
		
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
		output wire pin_8H_o,	// 8 pixel count (pin 6)
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
	// internal input signals
	
	wire sig_b48M;
	wire sig_b6M_IN;
	
	//wire sig_bMODE1;
	
	wire sig_bMODE0;
	wire sig_bFLIP;
	
	// input inverter stage
	
	wire sig_FLIP;		// E9TOP
	wire sig_FLIP2;	// A11BOT
	wire sig_MODE0;	// E10BOT
	wire sig_48M;		// A9BOT
	wire sig_48M_2;	// C9BOT
	wire sig_6MIN;		// H9BOT
	wire sig_6MIN2;	// J9BOT
	
	wire sig_bHRESET1;
	wire sig_E7BOT;
	
	// output signals
	
	wire sig_24M;
	wire sig_12M;
	wire sig_b6M_OUT;

	wire sig_bS1H;
	wire sig_bS2H;	

	wire sig_b1H;	
	wire sig_b2H;	
	wire sig_b4H;	
	wire sig_bPIN_6;	
	
	wire sig_bPIN40;
	wire sig_bPIN41;

	//
	//
	
	wire iob_i = IOB_INPUT_INVERSION;
	wire iob_o = IOB_OUTPUT_INVERSION;
	
	//
	// route input pins to internal signals (assuming external signal is inverted by IO block)
	
	assign sig_b48M = pin_48M_i ^ iob_i;
	assign sig_b48M_2 = pin_48M_i ^ iob_i;
	assign sig_bMODE1 = pin_MODE1_i ^ iob_i;
	assign sig_b6M_IN = pin_6M_IN_i ^ iob_i;
	assign sig_bFLIP = pin_FLIP_i ^ iob_i;
	assign sig_bMODE0 = pin_MODE0_i ^ iob_i;
	assign sig_bHRES_IN = pin_bHRES_IN_i ^ iob_i;
	assign sig_bVRES_IN = pin_bVRES_IN_i ^ iob_i;
	
	//
	// route internal signals to output pins (assuming internal signals are inverted by IO blocks)
	
	assign pin_24M_o = sig_24M ^ iob_o;	// non-barred 24M and barred PIN_24M are both driven from the same output
	assign pin_12M_o = sig_12M ^ iob_o;  // non-barred 12M and barred PIN_12M are both driven from the same output
	assign pin_6M_OUT_o = sig_b6M_OUT ^ iob_o;
	assign pin_S1H_o = sig_bS1H ^ iob_o;
	assign pin_S2H_o = sig_bS2H ^ iob_o;
	
	assign pin_1H_o = sig_b1H ^ iob_o;
	assign pin_2H_o = sig_b2H ^ iob_o;
	assign pin_4H_o = sig_b4H ^ iob_o;
	assign pin_8H_o = sig_bPIN_6 ^ iob_o;
	assign pin_bHRES_o = sig_bHRES ^ iob_o;
	assign pin_bVRES_o = sig_bVRES ^ iob_o;
	assign dir_HRES_o = sig_bMODE1;
	assign dir_VRES_o = sig_bMODE1;
	
	assign pin_PIN40_o = sig_bPIN40 ^ iob_o;
	assign pin_PIN41_o = sig_bPIN41 ^ iob_o;

	// TODO
	//assign sig_E5BOT = ~(sig_b48M_2 & sig_E5TOP);
	assign sig_E5BOT = sig_b48M_2 | sig_E5TOP;
	
	// HRESET in input mode
	//assign sig_F5TOP = ~(sig_bHRES_IN & sig_E5BOT);
	assign sig_F5TOP = sig_bHRES_IN | sig_E5BOT;
	assign sig_HRESET = sig_F5TOP;
	assign sig_bHRESET1 = ~sig_F5TOP;	// via F9TOP
	assign sig_bHRESET2 = ~sig_F5TOP;	// via F9BOT
	assign sig_bHRESET3 = ~sig_F5TOP;	// via H9TOP
	// VRESET in input mode
	//assign sig_F5BOT = ~(sig_bVRES_IN & sig_E5BOT);
	assign sig_F5BOT = sig_bVRES_IN | sig_E5BOT;
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
	
	assign sig_MODE0 = ~sig_bMODE0;		// E10BOT
	assign sig_FLIP = ~sig_bFLIP;			// E9TOP
	assign sig_FLIP2 = ~sig_bFLIP;		// E9TOP
	assign sig_48M = ~sig_b48M;			// A9BOT
	assign sig_48M2 = ~sig_b48M_2;		// C9BOT
	assign sig_6MIN = ~sig_b6M_IN;		// H9BOT
	assign sig_6MIN2 = ~sig_b6M_IN;		// J9BOT
	
	// inverted internal signals
	assign sig_E5TOP = ~sig_E7BOT;
	
	//
	// miscellaneous standard cell synthesis
	
	// E7BOT interpretation - disables all clocks if MODE1 active
	//	output is low if MODE1 high and MODE0 and FLIP are low, otherwise output is high
	cus27_nand #(
			IOB_INPUT_INVERSION )
		cus27_E7BOT_nand (
			.A(sig_bMODE1),
			.B(sig_MODE0),
			.C(sig_FLIP),
			.Y(sig_E7BOT)
		);
	
	//	
	// delegate to sub-modules
	
	furrtek_clockdivider #(
			IOB_INPUT_INVERSION )
		clock_divider (
			._rst_ni(_rst_ni), 
			.sig_48M_i(sig_48M), 
			.sig_bHRESET1_i(sig_bHRESET1), 
			.sig_E7BOT_i(sig_E7BOT),
			.sig_24M_o(sig_24M), 
			.sig_12M_o(sig_12M), 
			.sig_b6M_OUT_o(sig_b6M_OUT), // drive the output pin directly as sig_b6M_IN maps to the CUS27 input
			.sig_bS1H_o(sig_bS1H), 
			.sig_bS2H_o(sig_bS2H)
		);
	
	furrtek_horizontal #(
			IOB_INPUT_INVERSION )
		horizontal_timings (
			._rst_ni(_rst_ni),
			.sig_6MIN2_i(sig_6MIN2),
			.sig_bHRESET3_i(sig_bHRESET3),
			.sig_J5Q_o(sig_J5Q),
			.sig_J5bQ_o(sig_J5bQ),
			.sig_b1H_o(sig_b1H),
			.sig_b2H_o(sig_b2H),
			.sig_b4H_o(sig_b4H),
			.sig_bPIN_6_o(sig_bPIN_6)
		);
	
	furrtek_pin40
		pin40 (
		._rst_ni(_rst_ni),		
		.sig_b48M_i(sig_b48M),
		.sig_24M_i(sig_24M),
		.sig_12M_i(sig_12M),
		.sig_HRESET_i(sig_HRESET),
		.sig_bPIN40_o(sig_bPIN40)
	);
	
	furrtek_pin41
		pin41 (
		._rst_ni(_rst_ni),
		.sig_bMODE1_i(sig_bMODE1),
		.sig_MODE0_i(sig_MODE0),
		.sig_FLIP_i(sig_FLIP),
		.sig_b48M_i(sig_b48M),
		.sig_48M2_i(sig_48M2), 
		.sig_bPIN41_o(sig_bPIN41)
	);
			
endmodule