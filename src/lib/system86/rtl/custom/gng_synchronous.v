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
// Description:    Namco CUS27 - System timings generator (Capcom GnG reference)
//						 Inspired by the [not to dissimilar] Ghost 'n'Goblins SYNCHRONOUS schematics
//						 GnG has a 384x262 framesize (256x256 visible) which is not too far off
//						 the System 86 target 384x264 (288x224) with two extra lines and blanking adjustments)
//						 Implementation is so as to represent the physical schematics rather than robust
//						 and optimised verilog.
//
// Dependencies: 
//
// Revision:		 Revisiting timing accuracy 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus27_gng_ref
(
	// simulation control
	input wire rst_n,
	
	// input clocks
	input wire CLK_48M,
	input wire CLK_6M_IN,
	
	// generated clocks
   output wire CLK_24M,
   output wire CLK_12M,
   output wire CLK_6M,
	
	// video synchronisation
	output wire nVSYNC,
	output wire nHSYNC,
	output wire nVBLANK,
	output wire nHBLANK,
	output wire nVRESET,
	output wire nHRESET,
	
	// video timing signals
	output wire _8V,
	output wire _4V,
	output wire _1V,
	output wire _4H,
	output wire _2H,
	output wire _1H,
	output wire S2H,
	output wire S1H
);

	//
	// master clock divider
	//
	
	reg [2:0] master_counter;
	
	always @(posedge CLK_48M or negedge rst_n) begin
		if (!rst_n)
			master_counter <= 0;
		else
			master_counter <= master_counter + 1'b1;
	end	

	assign CLK_24M = master_counter[0];
	assign CLK_12M = master_counter[1];
	assign CLK_6M = master_counter[2];
	
	//
	// horizontal
	//

	reg [9:0] horizontal_counter;	// represents the two 74'161 4-bit counters plus 2 74'74 flip-flops
											// 9 bits plus 'H512' carry used for HRESET
	// 3L - 74'74 flip-flop
	reg VCLK;
	
	
	// 3K - 74'74 flip-flop
	wire H1 = horizontal_counter[0];	
	// 2K - 74'161 4-bit counter
	wire H2 = horizontal_counter[1];		
	wire H4 = horizontal_counter[2];
	wire H8 = horizontal_counter[3];
	wire H16 = horizontal_counter[4];
	// 1K - 74'161 4-bit counter
	wire H32 = horizontal_counter[5];
	wire H64 = horizontal_counter[6];
	wire H128 = horizontal_counter[7];
	wire H256 = ~horizontal_counter[8];	// looking at VBLANK circuitry and also Galaxians 
										// the signal out of the counter most probably negated
	
	wire HINIT = horizontal_counter[9];	// carry signal 'HRESET'	

	reg HBLANK;
	reg HSYNC;
	
	assign nHRESET = ~HINIT;
	assign nHBLANK = ~HBLANK;
	assign nHSYNC = ~HSYNC;
	
	// TO BE LATCHED akin to GnG's 0H 4-3H 4H signals
	reg __0H;	// GnG only
	reg __0_1H;	// S86 signal using GnG approach
	reg __1H;	// S86 signal using GnG approach
	reg __1_2H;	// S86 signal using GnG approach
	reg __2H;	// S86 signal using GnG approach
	reg __4_3H; // GnG only
	reg __4H;	// GnG signal also used by S86
	reg __7H;	// GnG only
		
	// are these in phase or off by half a clock or something else
	// for now assume they are the raw Hx signals exposed as is
	assign _1H = __1H;
	assign _2H = __2H;
	assign _4H = __4H;
	assign S1H = H1;
	assign S2H = H2;
	
	// horizontal counter
	always @(posedge CLK_6M_IN or negedge rst_n) begin
		if (!rst_n) begin
			horizontal_counter <= 0;	
			VCLK <= 0;
		end else begin
			VCLK <= HINIT;	// latch HINIT value into vlck
			if (HINIT) begin	// 74xx161 provides synchronous load and reset of TC
				horizontal_counter[9:1] <= 9'b001000000;	// zero'd with H128 set (512-128 = 384 target)	
			end else
				horizontal_counter <= horizontal_counter + 1'b1;	
		end
	end
	
	// horizontal latches
	always @(negedge CLK_6M_IN or negedge rst_n) begin
		if (!rst_n) begin
			__0_1H <= 1'b0;
			__1_2H <= 1'b0;
			__4_3H <= 1'b0;
			__7H <= 1'b0;
		end else begin
			__0_1H <= __0H && ~H1 & ~H2 & ~H4;	// might work?
			__1_2H <= H1 & ~H2 & ~H4;
			__4_3H <= H1 & H2 & ~H4;
			__7H <= H1 & H2 & H4; 
		end
	end
	
	always @(posedge CLK_6M_IN or negedge rst_n) begin
		if (!rst_n) begin
			__0H <= 1'b0;
			__1H <= 1'b0;
			__2H <= 1'b0;
			__4H <= 1'b0;
		end else begin
			__0H <= __7H;
			__1H <= __0_1H & ~H1;
			__2H <= __1_2H & ~H2;
			__4H <= __4_3H & ~H4;
		end
	end
	
	// horizontal blank
	always @(HINIT or H16 or H64 or negedge rst_n) begin
		if (!rst_n)
			HBLANK <= 1'b0;
		else begin
			if (H16 && H64)	// 240
				HBLANK <= 1'b1;
			else if (HINIT)
				HBLANK <= 1'b0;
			else
				HBLANK <= HBLANK;
		end
	end
	
	// horizontal sync
	always @(HBLANK or H32 or negedge rst_n) begin
		if (!rst_n)
			HSYNC <= 1'b0;
		else begin
			if (HBLANK && H32)
				HSYNC <= 1'b1;
			else
				HSYNC <= 1'b0;
		end
	end
	
	//
	// vertical unit
	//
	
	assign nVRESET = ~VRESET;
	assign nVBLANK = ~VBLANK;
	assign nVSYNC = ~VSYNC;
	
	// vertical counter aliases
	assign _1V = vertical_counter[0];
	wire _2V = vertical_counter[1];
	assign _4V = vertical_counter[2];
	assign _8V = vertical_counter[3];
	wire _16V = vertical_counter[4];
	wire _32V = vertical_counter[5];
	wire _64V = vertical_counter[6];
	wire _128V = vertical_counter[7];
	wire _256V = vertical_counter[8];
	
	reg [8:0] vertical_counter;
	wire VRESET = _256V && _8V;	// 264;
	reg VBLANK;
	reg VSYNC;
	
	// vertical counter
	always @(posedge VCLK or VRESET or negedge rst_n) begin
		if (!rst_n || VRESET)
			vertical_counter <= 0;	
		else	
			vertical_counter <= vertical_counter + 1'b1;	
	end
	
	// vertical reset
	/*always @(posedge HRESET or negedge rst_n) begin
		if (!rst_n)
			VRESET <= 0;	
		else	
			VRESET <= _256V && _8V;	// 264
	end*/
	
	// vertical blank
	always @(VRESET or _16V or negedge rst_n) begin
		if (!rst_n)
			VBLANK <= 1'b0;
		else begin
			if (_16V)
				VBLANK <= 1'b1;
			else if (VRESET)
				VBLANK <= 1'b0;
			else
				VBLANK <= VBLANK;
		end
	end
	
	// vertical sync
	always @(VBLANK or _8V or _4V or negedge rst_n) begin
		if (!rst_n)
			VSYNC <= 1'b0;
		else begin
			if (VBLANK && _4V && ~_8V)
				VSYNC <= 1'b1;
			else
				VSYNC <= 1'b0;
		end
	end
	
endmodule

