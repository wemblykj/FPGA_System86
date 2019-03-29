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
		C_USE_HARDWARE_CLOCKS = 0
	)
	(
generate
	if (C_USE_HARDWARE_CLOCKS = 1) begin
		input wire clk_6m,
	else
		input wire CLK_48M,
		output wire CLK_24M,
		output wire CLK_12M,
		output wire CLK_6M,
		output wire CLK_6MD,
	end	
endgenerate
		output wire VSYNC,
		output wire HSYNC,
		output wire VBLANK,
		output wire HBLANK,
		output wire HRESET,
		output wire VRESET,
 		output wire BLANKING,
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
generate
	if (C_USE_HARDWARE_CLOCKS = 1) begin
			.CLK_6M_I(clk_6m), 
	else begin
			.CLK_48M_I(CLK_48M), 
			.CLK_6M_O(CLK_6M),
			.CLK_6M_I(cus27_9p_6m_latched), 
	end	
endgenerate
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
	
        // == TTL glue logic
    
	LS74 
        ls74_8u(
			.PRE2(GND),
			.CLK2(CLK_4H),
			.CLR2(VBLANK),
			.D2(HBLANK),
			.Q2(BLANKING)
		);

	assign COMPSYNC = HSYNC || VSYNC;	// via LS08 (3H) and'ing of negated signals
	
generate
	if (C_USE_HARDWARE_CLOCKS = 1) begin
		always @(*) begin
			// Timing hack - is this still required?
			cus27_9p_6m_latched = CLK_6M;
		end
	end	
endgenerate
	
endmodule
