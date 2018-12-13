`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    19:03:51 05/16/2018 
// Design Name:    TIMING
// Module Name:    system86\timing.v 
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
module TIMING(
    input wire CLK_48M,
    output wire CLK_24M,
    output wire CLK_12M,
    output wire CLK_6M,
    output wire CLK_6MD,
    output wire VSYNC,
    output wire HSYNC,
    output wire VBLANK,
    output wire HBLANK,
    output wire HRESET,
    output wire VRESET,
    output wire COMPSYNC,
    output wire CLK_8V,
    output wire CLK_4V,
    output wire CLK_1V,
    output wire CLK_4H,
    output wire CLK_2H,
    output wire CLK_1H,
    output wire CLK_S1H,
    output wire CLK_S2H
    );

	reg cus27_9p_6m_latched;
	
	// CUS27 - CLOCK DIVIDER
	CUS27 CUS_27_CLKDIV_9P(
		.CLK_48M_I(CLK_48M), 
		.CLK_6M_I(cus27_9p_6m_latched), 
		.CLK_6M_O(CLK_6M),
		.VSYNC(VSYNC),
		.HSYNC(HSYNC),
		.HBLANK(HBLANK),
		.VBLANK(VBLANK),
		.HRESET(HRESET),
		.VRESET(VRESET),
		.CLK_1H_O(CLK_1H),
		.CLK_S1H_O(CLK_S1H),
		.CLK_2H_O(CLK_2H),
		.CLK_S2H_O(CLK_S2H),
		.CLK_4H_O(CLK_4H),
		.CLK_1V_O(CLK_1V),
		.CLK_4V_O(CLK_4V),
		.CLK_8V_O(CLK_8V)
		);
	
	assign COMPSYNC = HSYNC || VSYNC;	// via LS08 (3H) and'ing of negated signals
	
	always @(*) begin
		// Timing hack
		cus27_9p_6m_latched = CLK_6M;
	end
	
endmodule
