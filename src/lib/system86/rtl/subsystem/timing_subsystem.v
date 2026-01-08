`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    19:03:51 05/16/2018 
// Design Name:    timing_subsystem
// Module Name:    system86\subsystem\timing_subsystem.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Timing subsystem
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module timing_subsystem
#(
	parameter C_USE_HARDWARE_CLOCKS = 0
)
(
	// master clock
	input wire _rst_ni,
	
	input wire s86_48M_i,
	
	// generated clocks
	output wire s86_24M_o,
	output wire s86_12M_o,
	output wire s86_6M_o,
	output wire s86_6MD_o,
	output wire s86_X6M_o,
	output wire s86_X24M_o,
	
	// video synchronisation
	output wire s86_bVSYNC_o,
	output wire s86_bHSYNC_o,
	output wire s86_bHBLANK_o,
	output wire s86_bVBLANK_o,
	output wire s86_bHRESET_o,
	output wire s86_bVRESET_o,
	output wire s86_BLANKING_o,
	output wire s86_bCOMPSYNC_o,
	
	// video timing signals
	output wire s86_8V_o,
	output wire s86_4V_o,
	output wire s86_2V_o,
	output wire s86_1V_o,
	output wire s86_4H_o,
	output wire s86_2H_o,
	output wire s86_1H_o,
	output wire s86_b1H_o,
	output wire s86_S2H_o,
	output wire s86_S1H_o,
	output wire s86_bS1H_o
);

	wire cus27_hblank;
	
	// CUS27 - CLOCK DIVIDER
	//cus27 
	cus27_furrtek_ref
		cus27_9p_clock_divider(
			._rst_ni(_rst_ni),
			.pin_48M_i(s86_48M_i), 
			.pin_6M_i(s86_6M_o),
			.pin_24M_o(s86_24M_o),
			.pin_12M_o(s86_12M_o),
			.pin_6M_o(s86_6M_o),
			.pin_bVSYNC_o(s86_bVSYNC_o),
			.pin_bHSYNC_o(s86_bHSYNC_o),
			.pin_bHBLANK_o(s86_bHBLANK_o),
			.pin_bVBLANK_o(s86_bVBLANK_o),
			.pin_bHRESET_o(s86_bHRESET_o),
			.pin_bVRESET_o(s86_bVRESET_o),
			.pin_1H_o(s86_1H_o),
			.pin_2H_o(s86_2H_o),
			.pin_4H_o(s86_4H_o),
			.pin_1V_o(s86_1V_o),
			.pin_2V_o(s86_2V_o),
			.pin_4V_o(s86_4V_o),
			.pin_8V_o(s86_8V_o),
			.pin_S1H_o(s86_S1H_o),
			.pin_S2H_o(s86_S2H_o)
		);

	// == TTL glue logic
    
	ls74 
		ls74_8u(
			.CLK1(s86_6M_o),
			.nPRE1(1'b1),
			.nCLR1(1'b1),
			.D1(s86_1H_o),
			.Q1(CLK_s86_b1H_o),
			//.nQ1(1'b0),
			.CLK2(s86_4H_o),
			.nPRE2(1'b1),
			.nCLR2(s86_bVBLANK_o),
			.D2(s86_bHBLANK_o),
			//.Q2(1'b0),
			.nQ2(s86_BLANKING_o)
		);

	assign s86_6MD_o = s86_6M_o;
	assign s86_X6M_o = s86_6M_o;
	assign s86_X24M_o = s86_24M_o;
	assign s86_b1H_o = ~s86_1H_o;
	assign s86_bS1H_o = ~s86_S1H_o;
	assign s86_bCOMPSYNC_o = s86_bHSYNC_o && s86_bVSYNC_o;	// via LS08 (3H) and'ing of negated signals
	
endmodule
