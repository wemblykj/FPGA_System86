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
//						 From the basic schematics it would make sense the the S86 xH and xV lines map
//						 either directly, or indirectly, to their respective bits in the horizontal and
//						 vertical counters (Hx and Vx); certainly 2H is used as a latch signifying the active tile layer. 
//						 GnG on the other hand has similarly named signals but these would apppear to be 
//						 one clock pulses denoting the leading edge e.g. 
//							1H pulses with the leading edge of H1
//							4_3H pulses in the transition between H3 and H4
//						 For now my assuptions are as follows
//							xH maps to Hx, latched on the positive edge of 6M
//							SxH maps to Hx and will update on the negative edge of 6M such that it precedes Hx
//							by half a clock. This would give the address decoding chips (41 & 47) half a clock
//							in which to ensure the latches (LATCH0 & LATCH1) are driven appropriatly before the
//							next positive edge of the 6M clock
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
	input wire _rst_ni,
	
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

	//
	// master clock divider
	//
	
	reg [2:0] master_counter;
	
	always @(posedge pin_48M_i or _rst_ni) begin
		if (!_rst_ni)
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

	reg [8:0] horizontal_counter;	// represents the two 74'161 4-bit counters plus 2 74'74 flip-flops
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
	wire nH256 = horizontal_counter[8];
	wire H256 = ~nH256;

	wire HRESET = H1 & H2 & H4 & H8 & H16 & H32 & H64 & H128 & nH256;	// HRESET driven by ripple carry
	reg HBLANK;
	reg HSYNC;
	
	assign pin_bHRESET_o = ~HRESET;
	assign pin_bHBLANK_o = ~HBLANK;
	assign pin_bHSYNC_o = ~HSYNC;
	
	// TO BE LATCHED 
	reg __pin_S1H_o;
	reg __pin_S2H_o;
		
	// are these in phase or off by half a clock or something else
	// for now assume they are the raw Hx signals exposed as is
	assign pin_1H_o = H1;
	assign pin_2H_o = H2;
	assign pin_4H_o = H4;
	assign pin_S1H_o = __pin_S1H_o;
	assign pin_S2H_o = __pin_S2H_o;
	
	// horizontal counter
	always @(posedge pin_6M_i or _rst_ni) begin
		if (!_rst_ni) begin
			horizontal_counter <= 0;	
		end else begin
			if (HRESET) begin	// 74xx161 provides synchronous load and reset of TC
				horizontal_counter[8:0] <= 8'b010000000;	// zero'd with H128 set (512-128 = 384 target)	
			end else
				horizontal_counter <= horizontal_counter + 1'b1;	
		end
	end
	
	// horizontal latches
	always @(negedge pin_6M_i or _rst_ni) begin
		if (!_rst_ni)
			__pin_S1H_o <= 1'b0;
		else
			__pin_S1H_o <= ~H1;
	end
	
	// hblank clocked on 74'112 neg edge of neg 6M - note schematics show the H256 being used which would appear to be inverted
	wire _5M_CLK = pin_6M_i;
	wire _5M_J = H1 & H2 & H4 & H256;
	wire _5M_K = H1 & H2 & H4 & nH256; 
	always @(posedge _5M_CLK or _rst_ni) begin
		if (!_rst_ni) begin
			HBLANK <= 1'b0;
		end else begin
			case ( { _5M_J, _5M_K} )
				2'b00: HBLANK <= HBLANK;
				2'b01: HBLANK <= 1'b0;
				2'b10: HBLANK <= 1'b1;
				2'b11: HBLANK <= ~HBLANK;
			endcase
		end
	end
	
	always @(negedge __pin_S1H_o or _rst_ni) begin
		if (!_rst_ni)
			__pin_S2H_o <= 1'b0;
		else
			__pin_S2H_o <= ~H2;
	end
	
	
	
	// horizontal sync
	always @(H256 or H64 or H32 or H16 or _rst_ni) begin
		if (!_rst_ni)
			HSYNC <= 1'b0;
		else if (H256) begin
			case ( { H64, H32, H16} )
				3'b011:	HSYNC <= 1'b1;
				3'b100:	HSYNC <= 1'b1;
				default: HSYNC <= 1'b0;
			endcase
		end else
			HSYNC <= 1'b0;
	end
	
	//
	// vertical unit
	//
	
	assign pin_bVRESET_o = ~VRESET;
	assign pin_bVBLANK_o = ~VBLANK;
	assign pin_bVSYNC_o = ~VSYNC;
	
	// vertical counter aliases
	assign pin_1V_o = vertical_counter[0];
	assign pin_2V_o = vertical_counter[1];
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
	always @(posedge _256V or _rst_ni) begin
		if (!_rst_ni || VRESET)
			vertical_counter <= 0;	
		else	
			vertical_counter <= vertical_counter + 1'b1;	
	end
	
	// vertical reset
	/*always @(posedge HRESET or negedge _rst_ni) begin
		if (!_rst_ni)
			VRESET <= 0;	
		else	
			VRESET <= _256V && pin_8V_o;	// 264
	end*/
	
	// vertical blank
	always @(VRESET or _16V or _rst_ni) begin
		if (!_rst_ni)
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
	always @(VBLANK or pin_8V_o or pin_4V_o or negedge _rst_ni) begin
		if (!_rst_ni)
			VSYNC <= 1'b0;
		else begin
			if (VBLANK && pin_4V_o && ~pin_8V_o)
				VSYNC <= 1'b1;
			else
				VSYNC <= 1'b0;
		end
	end
	
endmodule

