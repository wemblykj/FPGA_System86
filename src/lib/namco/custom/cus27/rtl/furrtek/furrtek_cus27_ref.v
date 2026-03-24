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
//                 Kudos go to:
//                  Furrtek for reverse engineering: http://www.furrtek.org
//                  JohnDMcMaster for die photos: https://siliconprawn.org/
//
// References:
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//                 [^4] https://datasheet4u.com/pdf-down/M/B/1/MB111XXX_Fujitsu.pdf
//                 [^5] https://patents.google.com/patent/US4584653A/ja
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
	input wire sim_rst_n,
	
	// input clocks
	input wire pin_48M_i,
	input wire pin_6M_IN_i,
	
	// configuration
	input wire pin_OTEN_i,
	input wire pin_MODE0_i,
	input wire pin_MODE1_i,		// use external resets
	input wire pin_FLIP_i,
	
	input wire pin_bHRES_IN_i,	// external horizontal reset
	input wire pin_bVRES_IN_i,  // external vertical reset
	
	// generated clocks
	output wire pin_24M_o,
	output wire pin_12M_o,
	output wire pin_6M_OUT_o,
	
	// video synchronisation
	
	output wire pin_bHSYNC_o,
	output wire pin_bHBLANK_o,
	output wire pin_bHRES_o,
	output wire dir_HRES_o,
	
	output wire pin_bVSYNC_o,
	output wire pin_bVBLANK_o,
	output wire pin_bVRES_o,
	output wire dir_VRES_o,
	
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
	
	output wire pin_A0_o,
	output wire pin_A1_o,
	output wire pin_A2_o,
	output wire pin_A3_o,
	output wire pin_A4_o,
	output wire pin_A5_o,
	output wire pin_A6_o,
	output wire pin_A7_o,
	output wire pin_A8_o,
	output wire pin_A9_o,
	output wire pin_A10_o,
	
	output wire pin_PIN40_o,	// unknown function, HRESET dependant
	output wire pin_PIN41_o	// unknown function, regular pulse in sync with 48M clock
);

	//
	// internal input signals
	
	wire sig_b48M;
	wire sig_b6M_IN;
	
	//wire sig_bMODE1;
	
	wire sig_bMODE0;
	wire sig_bFLIP;
	wire sig_bOTEN;
	
	// input inverter stage
	
	wire sig_FLIP;		// E9TOP
	wire sig_FLIP2;		// A11BOT
	wire sig_MODE0;		// E10BOT
	wire sig_48M;		// A9BOT
	wire sig_48M2;		// C9BOT
	wire sig_6MIN;		// H9BOT
	wire sig_6MIN2;		// J9BOT
	
	// internal routing
	
	wire sig_24M;
	wire sig_12M;
	wire sig_bHRESET1;
	
	// output signals
	
	wire sig_b24M;
	wire sig_b12M;
	wire sig_b6M_OUT;

	wire sig_bS1H;
	wire sig_bS2H;	

	wire sig_A0;
	wire sig_A1;
	wire sig_A2;
	wire sig_A3;
	wire sig_A4;
	wire sig_A5;
	wire sig_A6;
	wire sig_A7;
	wire sig_A8;
	wire sig_A9;
	wire sig_A10;

	// horizontal counter
	wire sig_J5_XQ;
	wire sig_J10BOT;
	wire sig_b1H;	
	wire sig_b2H;	
	wire sig_b4H;	
	wire sig_bPIN_6;	
	
	// horizontal timings
	wire sig_B11_Q;
	wire sig_B11_XQ;
	wire sig_C11TOP;
	wire sig_D11_Q;
	wire sig_D11_XQ;
	wire sig_E12_Q;
	wire sig_E12_XQ;
	wire sig_G11_Q;
	wire sig_G11_XQ;
	wire sig_bHBLA;
	wire sig_bHSYNC;
	
	// vertical timings
	wire sig_D15_Q;
	wire sig_D15_XQ;
	wire sig_D18_Q;
	wire sig_D18_XQ;
	wire sig_F18_XQ;
	wire sig_G18_Q;
	wire sig_G18_XQ;
	wire sig_H18_Q;
	wire sig_J18_Q;
	wire sig_bVBLA;
	
	// video reset
	wire sig_bHRES_IN;
	wire sig_bHRES;
	wire sig_bVRES_IN;
	//wire sig_bVRES;
	wire sig_F6_XQ;
	wire sig_G5_XQ;
	
	wire sig_bPIN40;
	wire sig_bPIN41;

	wire sig_C17_XQ;
	wire sig_A17_Q;
	wire sig_A17_XQ;
	
	// flipping muxes
	wire sig_E15BOT;
	wire sig_F13TOP;
	wire sig_F13BOT;
	wire sig_H11BOT;
	wire sig_H11TOP;
	wire sig_H13BOT;
	wire sig_H13TOP;
	wire sig_J11TOP;
	wire sig_J13TOP;
	wire sig_J13BOT;
	
	//
	// route input pins to internal signals (assuming external signal is inverted by IO block)
	
	assign sig_b48M = ~pin_48M_i;
	assign sig_b48M_2 = ~pin_48M_i;
	assign sig_b6M_IN = ~pin_6M_IN_i;
	assign sig_bOTEN = ~pin_OTEN_i;
	assign sig_bFLIP = ~pin_FLIP_i;
	assign sig_bFLIP_2 = ~pin_FLIP_i;
	assign sig_bMODE0 = ~pin_MODE0_i;
	assign sig_bMODE1 = ~pin_MODE1_i;
	
	// becomes unstable if we feed the IOB output state directly into the IOB output state
	//assign sig_bHRES_IN = sig_HRES_DIR ? sig_HRES_IOB : (pin_bHRES_IN_i);
	//assign sig_bVRES_IN = sig_VRES_DIR ? sig_VRES_IOB : (pin_bVRES_IN_i);
	// we can stabilise by managing and debouncing, and looping back the reset signal externally
	// FIXME: for some reason this does not work if the pin is inverted by the IOB
	assign sig_bHRES_IN = /*sig_HRES_DIR ? / *1'b1* /sig_HRES_IOB :*/ pin_bHRES_IN_i;
	assign sig_bVRES_IN = /*sig_VRES_DIR ? / *1'b1* /sig_VRES_IOB :*/ pin_bVRES_IN_i;
	
	//
	// route internal signals to output pins (assuming internal signals are inverted by IO blocks)
	
	assign pin_24M_o = ~sig_b24M;	// non-barred 24M and barred PIN_24M are both driven from the same output
	assign pin_12M_o = ~sig_b12M;  // non-barred 12M and barred PIN_12M are both driven from the same output
	assign pin_6M_OUT_o = ~sig_b6M_OUT;
	assign pin_S1H_o = ~sig_bS1H;
	assign pin_S2H_o = ~sig_bS2H;
	
	assign pin_1H_o = ~sig_b1H;
	assign pin_2H_o = ~sig_b2H;
	assign pin_4H_o = ~sig_b4H;
	assign pin_8H_o = ~sig_bPIN_6;
	
	assign pin_1V_o = ~sig_b1V;
	assign pin_2V_o = ~sig_b2V;
	assign pin_4V_o = ~sig_b4V;
	assign pin_8V_o = ~sig_A17_Q;	// intuition

	assign sig_HRES = sig_6MIN & sig_F6_XQ;		// IOB input and loopback
	assign sig_bHRES_IOB = ~sig_HRES;			// IOB output pin logic
	assign sig_HRES_DIR = sig_bMODE1;
	
	assign sig_VRES = sig_6MIN & sig_G5_XQ;		// IOB input and loopback
	assign sig_bVRES_IOB = ~sig_VRES;			// IOB output pin logic
	assign sig_VRES_DIR = sig_bMODE1;
	
	assign pin_bHSYNC_o = ~sig_bHSYNC ;
	assign pin_bHBLANK_o = ~sig_bHBLA;
	assign pin_bHRES_o = sig_HRES_DIR ? sig_bHRES_IOB : 1'bz;
	assign dir_HRES_o = sig_HRES_DIR;
	
	assign pin_bVSYNC_o = ~(sig_A17_XQ & sig_H18_Q & sig_F18_XQ); // looks to use NAND logic of IOB
	assign pin_bVBLANK_o = ~sig_bVBLA;
	assign pin_bVRES_o = sig_VRES_DIR ? sig_bVRES_IOB : 1'bz;
	assign dir_VRES_o = sig_VRES_DIR;

	// A0 - A9 are already inverted via IOB NAND logic applied in sub-module
	assign pin_A0_o = sig_A0;
	assign pin_A1_o = sig_A1;
	assign pin_A2_o = sig_A2;
	assign pin_A3_o = sig_A3;
	assign pin_A4_o = sig_A4;
	assign pin_A5_o = sig_A5;
	assign pin_A6_o = sig_A6;
	assign pin_A7_o = sig_A7;
	assign pin_A8_o = sig_A8;
	assign pin_A9_o = sig_A9;
	assign pin_A10_o = sig_A10;	// buffer change in OTEN?

	assign pin_PIN40_o = sig_bPIN40;
	assign pin_PIN41_o = sig_bPIN41; 
	
	//
	// RTL
	//
	
	//
	// synthesise the routing of static signals through inverter cells  
	
	assign sig_MODE0 = ~sig_bMODE0;		// E10BOT
	assign sig_FLIP = ~sig_bFLIP;		// E9TOP
	assign sig_FLIP2 = ~sig_bFLIP;		// E9TOP
	
	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_A9BOT_inverter (
			.A(sig_b48M),
			.Y(sig_48M)
		);
			
	mb111_n01_inverter
		cus27_C9BOT_inverter (
			.A(sig_b48M_2),
			.Y(sig_48M2)
		);
			
	mb111_n01_inverter
		cus27_H9BOT_inverter (
			.A(sig_b6M_IN),
			.Y(sig_6MIN)
		);
			
	mb111_n01_inverter
		cus27_J9BOT_inverter (
			.A(sig_b6M_IN),
			.Y(sig_6MIN2)
		);
	
	//	
	// delegate to sub-modules
	
	furrtek_clock_divider
		clock_divider (
			.sim_rst_n(sim_rst_n),
			.sig_bMODE1_i(sig_bMODE1),
			.sig_MODE0_i(sig_MODE0),
			.sig_FLIP_i(sig_FLIP),
			.sig_48M_i(sig_48M), 
			.sig_bHRESET1_i(sig_bHRESET1),
			.sig_E5TOP_o(sig_E5TOP),			
			.sig_24M_o(sig_24M), 
			.sig_12M_o(sig_12M), 
			.sig_b24M_o(sig_b24M), 
			.sig_b12M_o(sig_b12M), 
			.sig_b6M_OUT_o(sig_b6M_OUT), // drive the output pin directly as sig_b6M_IN maps to the CUS27 input
			.sig_bS1H_o(sig_bS1H), 
			.sig_bS2H_o(sig_bS2H)
		);
	
	furrtek_video_reset_in
		video_reset_in (
			.sim_rst_n(sim_rst_n),
			.sig_b48M_2_i(sig_b48M_2),
			.sig_bHRES_IN_i(sig_bHRES_IN),
			.sig_bVRES_IN_i(sig_bVRES_IN),
			.sig_E5TOP_i(sig_E5TOP), 
			.sig_HRESET_o(sig_HRESET),
			.sig_bHRESET1_o(sig_bHRESET1), 
			.sig_bHRESET2_o(sig_bHRESET2), 
			.sig_bHRESET3_o(sig_bHRESET3), 
			.sig_bVRESET1_o(sig_bVRESET1),
			.sig_bVRESET2_o(sig_bVRESET2),
			.sig_bVRESET3_o(sig_bVRESET3)
		);

	furrtek_horizontal_counter
		horizontal_counter (
			.sim_rst_n(sim_rst_n),
			.sig_6MIN2_i(sig_6MIN2),
			.sig_bHRESET3_i(sig_bHRESET3),
			.sig_J5_Q_o(sig_J5_Q),
			.sig_J5_XQ_o(sig_J5_XQ),
			.sig_J10BOT_o(sig_J10BOT),
			.sig_b1H_o(sig_b1H),
			.sig_b2H_o(sig_b2H),
			.sig_b4H_o(sig_b4H),
			.sig_bPIN_6_o(sig_bPIN_6)
		);
	
	furrtek_horizontal_timings
		horizontal_timings (
			.sim_rst_n(sim_rst_n),
			.sig_6MIN2_i(sig_6MIN2),
			.sig_bHRESET1_i(sig_bHRESET1),
			.sig_bHRESET2_i(sig_bHRESET2),
			.sig_J5_XQ_i(sig_J5_XQ),	// 8H
			.sig_J10BOT_i(sig_J10BOT),	// 4H, 2H, 1H = 111
			.sig_C11TOP_o(sig_C11TOP),
			.sig_B11_Q_o(sig_B11_Q),
			.sig_B11_XQ_o(sig_B11_XQ),
			.sig_D11_Q_o(sig_D11_Q),
			.sig_D11_XQ_o(sig_D11_XQ),
			.sig_E12_Q_o(sig_E12_Q),
			.sig_E12_XQ_o(sig_E12_XQ),
			.sig_G11_Q_o(sig_G11_Q),
			.sig_G11_XQ_o(sig_G11_XQ),
			.sig_bHSYNC_o(sig_bHSYNC),
			.sig_bHBLA_o(sig_bHBLA)
		);
		
	furrtek_vertical_counter
		vertical_counter (
			.sim_rst_n(sim_rst_n),
			.sig_6MIN_i(sig_6MIN),
			.sig_bVRESET3_i(sig_bVRESET3),
			.sig_MODE0_i(sig_MODE0),
			.sig_FLIP_i(sig_FLIP),
			.sig_E12_Q_i(sig_E12_Q),
			.sig_J5_XQ_i(sig_J5_XQ),
			.sig_C11TOP_i(sig_C11TOP),
			.sig_D11_Q_i(sig_D11_Q),
			.sig_J10BOT_i(sig_J10BOT),
			.sig_G11_XQ_i(sig_G11_XQ),
			.sig_b1V_o(sig_b1V),
			.sig_b2V_o(sig_b2V),
			.sig_b4V_o(sig_b4V),
			.sig_C17_Q_o(sig_C17_Q),
			.sig_C17_XQ_o(sig_C17_XQ),
			.sig_A17_Q_o(sig_A17_Q),
			.sig_A17_XQ_o(sig_A17_XQ),
			.sig_C15TOP_o(sig_C15TOP)
		);
		
	furrtek_vertical_timings
		vertical_timings (
			.sim_rst_n(sim_rst_n),
			.sig_bVRESET1_i(sig_bVRESET1),
			.sig_bVRESET2_i(sig_bVRESET2),
			.sig_bVRESET3_i(sig_bVRESET3),
			.sig_A17_Q_i(sig_A17_Q),
			.sig_D15_Q_o(sig_D15_Q),
			.sig_D15_XQ_o(sig_D15_XQ),
			.sig_D18_Q_o(sig_D18_Q),
			.sig_D18_XQ_o(sig_D18_XQ),
			.sig_F18_XQ_o(sig_F18_XQ),
			.sig_H18_Q_o(sig_H18_Q),
			.sig_H18_XQ_o(sig_H18_XQ),
			.sig_J18_Q_o(sig_J18_Q),
			.sig_G18_Q_o(sig_G18_Q),
			.sig_G18_XQ_o(sig_G18_XQ),
			.sig_bVBLA_o(sig_bVBLA)
		);
	
	furrtek_video_reset_out
		video_reset_out (
			.sim_rst_n(sim_rst_n),
			.sig_6MIN_i(sig_6MIN),
			.sig_E12_Q_i(sig_E12_Q),
			.sig_J5_XQ_i(sig_J5_XQ),
			.sig_C11TOP_i(sig_C11TOP),
			.sig_D11_XQ_i(sig_D11_XQ),
			.sig_J10BOT_i(sig_J10BOT),
			.sig_G11_Q_i(sig_G11_Q),
			.sig_J18_Q_i(sig_J18_Q),
			.sig_C17_XQ_i(sig_C17_XQ),
			.sig_C15TOP_i(sig_C15TOP),
			.sig_F6_XQ_o(sig_F6_XQ),
			.sig_G5_XQ_o(sig_G5_XQ)
		);
	
	furrtek_flipping_muxes
		flipping_muxes (
			.sig_FLIP2_i(sig_FLIP2),
			.sig_bFLIP_2_i(sig_bFLIP_2),	
			.sig_A17_Q_i(sig_A17_Q),
			.sig_A17_XQ_i(sig_A17_XQ),			
			.sig_B11_Q_i(sig_B11_Q),
			.sig_B11_XQ_i(sig_B11_XQ),
			.sig_D11_Q_i(sig_D11_Q),
			.sig_D11_XQ_i(sig_D11_XQ),
			.sig_D15_Q_i(sig_D15_Q),
			.sig_D15_XQ_i(sig_D15_XQ),
			.sig_D18_Q_i(sig_D18_Q),
			.sig_D18_XQ_i(sig_D18_XQ),
			.sig_E12_Q_i(sig_E12_Q),
			.sig_E12_XQ_i(sig_E12_XQ),
			.sig_G11_Q_i(sig_G11_Q),
			.sig_G11_XQ_i(sig_G11_XQ),
			.sig_G18_Q_i(sig_G18_Q),
			.sig_G18_XQ_i(sig_G18_XQ),
			.sig_H18_Q_i(sig_H18_Q),
			.sig_H18_XQ_i(sig_H18_XQ),
			.sig_J5_Q_i(sig_J5_Q),
			.sig_J5_XQ_i(sig_J5_XQ),
			.sig_E15BOT_o(sig_E15BOT),
			.sig_F13TOP_o(sig_F13TOP),
			.sig_F13BOT_o(sig_F13BOT),
			.sig_H11TOP_o(sig_H11TOP),
			.sig_H11BOT_o(sig_H11BOT),
			.sig_H13TOP_o(sig_H13TOP),
			.sig_H13BOT_o(sig_H13BOT),
			.sig_J11TOP_o(sig_J11TOP),
			.sig_J13TOP_o(sig_J13TOP),
			.sig_J13BOT_o(sig_J13BOT)
		);
		
	furrtek_address_lines
		furrtek_address_lines (
			.sim_rst_n(sim_rst_n),
			.sig_bHRESET1_i(sig_bHRESET1),
			.sig_bOTEN_i(sig_bOTEN),
			.sig_MODE0_i(sig_MODE0),
			.sig_C11TOP_i(sig_C11TOP),
			.sig_E15BOT_i(sig_E15BOT),
			.sig_F13TOP_i(sig_F13TOP),
			.sig_F13BOT_i(sig_F13BOT),
			.sig_H11TOP_i(sig_H11TOP),
			.sig_H11BOT_i(sig_H11BOT),
			.sig_H13TOP_i(sig_H13TOP),
			.sig_H13BOT_i(sig_H13BOT),
			.sig_J11TOP_i(sig_J11TOP),
			.sig_J13TOP_i(sig_J13TOP),
			.sig_J13BOT_i(sig_J13BOT),
			.sig_A0_o(sig_A0),
			.sig_A1_o(sig_A1),
			.sig_A2_o(sig_A2),
			.sig_A3_o(sig_A3),
			.sig_A4_o(sig_A4),
			.sig_A5_o(sig_A5),
			.sig_A6_o(sig_A6),
			.sig_A7_o(sig_A7),
			.sig_A8_o(sig_A8),
			.sig_A9_o(sig_A9),
			.sig_A10_o(sig_A10)			
		);
		
	furrtek_pin40
		pin40 (	
			.sim_rst_n(sim_rst_n),
			.sig_b48M_i(sig_b48M),
			.sig_24M_i(sig_24M),
			.sig_12M_i(sig_12M),
			.sig_HRESET_i(sig_HRESET),
			.sig_bPIN40_o(sig_bPIN40)
	);
	
	furrtek_pin41
		pin41 (
			.sim_rst_n(sim_rst_n),
			.sig_bMODE1_i(sig_bMODE1),
			.sig_MODE0_i(sig_MODE0),
			.sig_FLIP_i(sig_FLIP),
			.sig_b48M_i(sig_b48M),
			.sig_48M2_i(sig_48M2), 
			.sig_bPIN41_o(sig_bPIN41)
	);
			
endmodule
