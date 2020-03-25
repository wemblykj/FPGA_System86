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
	input wire reset,
	input wire enable,
	input wire CLK_48M,
	
	// generated clocks
	output wire CLK_24M,
	output wire CLK_12M,
	output wire CLK_6M,
	output wire CLK_6MD,
	
	// video synchronisation
	output wire VSYNC,
	output wire HSYNC,
	output wire VBLANK,
	output wire HRESET,
	output wire VRESET,
	output wire BLANKING,
	output wire COMPSYNC,
	
	// video timing signals
	output wire CLK_8V,
	output wire CLK_4V,
	output wire CLK_1V,
	output wire CLK_4H,
	output wire CLK_2H,
	output wire CLK_1H,
	output wire CLK_S2H,
	output wire CLK_S1H
);

	wire cus27_hblank;
	
	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			.reset(reset),
			.enable(enable),
			.CLK_48M(CLK_48M), 
			.CLK_6M_IN(CLK_6M),
			.CLK_24M(CLK_24M),
			.CLK_12M(CLK_12M),
			.CLK_6M(CLK_6M),
			.VSYNC(VSYNC),
			.HSYNC(HSYNC),
			.HBLANK(cus27_hblank),
			.VBLANK(VBLANK),
			.HRESET(HRESET),
			.VRESET(VRESET),
			.CLK_8V(CLK_8V),
			.CLK_4V(CLK_4V),
			.CLK_1V(CLK_1V),
			.CLK_4H(CLK_4H),
			.CLK_2H(CLK_2H),
			.CLK_1H(CLK_1H),
			.CLK_S2H(CLK_S2H),
			.CLK_S1H(CLK_S1H)
		);

	// == TTL glue logic
    
	ls74 
		ls74_8u(
			.CLK1(GND),
			.PRE1(GND),
			.CLR1(GND),
			.CLK2(CLK_4H),
			.PRE2(GND),
			.CLR2(VBLANK),
			.D2(cus27_hblank),
			.Q2(BLANKING)
		);

	assign COMPSYNC = HSYNC | VSYNC;	// via LS08 (3H) and'ing of negated signals
	
endmodule
