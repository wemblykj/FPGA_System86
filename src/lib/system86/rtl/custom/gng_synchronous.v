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
	input wire _rst_n,
	
	// input clocks
	input wire pin_48M_i,
	input wire pin_6M_i,
	
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
	output wire pin_8V_o,
	output wire pin_4V_o,
	output wire pin_1V_o,
	output wire pin_4H_o,
	output wire pin_2H_o,
	output wire pin_1H_o,
	output wire pin_S2H_o,
	output wire pin_S1H_o
);

	//
	// master clock divider
	//
	
	reg [2:0] master_counter;
	
	always @(posedge pin_48M_i or negedge _rst_n) begin
		if (!_rst_n)
			master_counter <= 0;
		else
			master_counter <= master_counter + 1'b1;
	end	

	assign pin_24M_o = master_counter[0];
	assign pin_12M_o = master_counter[1];
	assign pin_6M_o = master_counter[2];
	
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
	
	assign pin_bHRESET_o = ~HINIT;
	assign pin_bHBLANK_o = ~HBLANK;
	assign pin_bHSYNC_o = ~HSYNC;
	
	// TO BE LATCHED akin to GnG's 0H 4-3H 4H signals
	reg __0H;	// GnG only
	reg __0pin_1H_o;	// S86 signal using GnG approach
	reg _pin_1H_o;	// S86 signal using GnG approach
	reg __1pin_2H_o;	// S86 signal using GnG approach
	reg _pin_2H_o;	// S86 signal using GnG approach
	reg __4_3H; // GnG only
	reg _pin_4H_o;	// GnG signal also used by S86
	reg __7H;	// GnG only
		
	// are these in phase or off by half a clock or something else
	// for now assume they are the raw Hx signals exposed as is
	assign pin_1H_o = _pin_1H_o;
	assign pin_2H_o = _pin_2H_o;
	assign pin_4H_o = _pin_4H_o;
	assign pin_S1H_o = H1;
	assign pin_S2H_o = H2;
	
	// horizontal counter
	always @(posedge pin_6M_i or negedge _rst_n) begin
		if (!_rst_n) begin
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
	always @(negedge pin_6M_i or negedge _rst_n) begin
		if (!_rst_n) begin
			__0pin_1H_o <= 1'b0;
			__1pin_2H_o <= 1'b0;
			__4_3H <= 1'b0;
			__7H <= 1'b0;
		end else begin
			__0pin_1H_o <= __0H && ~H1 & ~H2 & ~H4;	// might work?
			__1pin_2H_o <= H1 & ~H2 & ~H4;
			__4_3H <= H1 & H2 & ~H4;
			__7H <= H1 & H2 & H4; 
		end
	end
	
	always @(posedge pin_6M_i or negedge _rst_n) begin
		if (!_rst_n) begin
			__0H <= 1'b0;
			_pin_1H_o <= 1'b0;
			_pin_2H_o <= 1'b0;
			_pin_4H_o <= 1'b0;
		end else begin
			__0H <= __7H;
			_pin_1H_o <= __0pin_1H_o & ~H1;
			_pin_2H_o <= __1pin_2H_o & ~H2;
			_pin_4H_o <= __4_3H & ~H4;
		end
	end
	
	// horizontal blank
	always @(HINIT or H16 or H64 or negedge _rst_n) begin
		if (!_rst_n)
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
	always @(HBLANK or H32 or negedge _rst_n) begin
		if (!_rst_n)
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
	
	assign pin_bVRESET_o = ~VRESET;
	assign pin_bVBLANK_o = ~VBLANK;
	assign pin_bVSYNC_o = ~VSYNC;
	
	// vertical counter aliases
	assign pin_1V_o = vertical_counter[0];
	wire pin_2V_o = vertical_counter[1];
	assign pin_4V_o = vertical_counter[2];
	assign pin_8V_o = vertical_counter[3];
	wire _16V = vertical_counter[4];
	wire _32V = vertical_counter[5];
	wire _64V = vertical_counter[6];
	wire _128V = vertical_counter[7];
	wire _256V = vertical_counter[8];
	
	reg [8:0] vertical_counter;
	wire VRESET = _256V && pin_8V_o;	// 264;
	reg VBLANK;
	reg VSYNC;
	
	// vertical counter
	always @(posedge VCLK or VRESET or negedge _rst_n) begin
		if (!_rst_n || VRESET)
			vertical_counter <= 0;	
		else	
			vertical_counter <= vertical_counter + 1'b1;	
	end
	
	// vertical reset
	/*always @(posedge HRESET or negedge _rst_n) begin
		if (!_rst_n)
			VRESET <= 0;	
		else	
			VRESET <= _256V && pin_8V_o;	// 264
	end*/
	
	// vertical blank
	always @(VRESET or _16V or negedge _rst_n) begin
		if (!_rst_n)
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
	always @(VBLANK or pin_8V_o or pin_4V_o or negedge _rst_n) begin
		if (!_rst_n)
			VSYNC <= 1'b0;
		else begin
			if (VBLANK && pin_4V_o && ~pin_8V_o)
				VSYNC <= 1'b1;
			else
				VSYNC <= 1'b0;
		end
	end
	
endmodule

