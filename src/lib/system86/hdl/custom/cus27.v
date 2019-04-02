`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    CUS27
// Module Name:    system86\src\custom\cus27.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - System timings generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module CUS27
#(
	parameter C_USE_HARDWARE_CLOCKS = 0
)
(
	// Global reset
	input wire rst,
	// CUS27
	if (C_USE_HARDWARE_CLOCKS == 0) generate
		input wire CLK_48M,
    output wire CLK_24M_O,
    output wire CLK_12M_O,
    output wire CLK_6M_O,
	endgenerate
	input wire CLK_6M,
	output reg VSYNC,
	output reg HSYNC,
	output reg VBLANK,
	output reg HBLANK,
	output reg VRESET,
	output reg HRESET,
	output wire CLK_8V_O,
	output wire CLK_4V_O,
	output wire CLK_1V_O,
	output wire CLK_4H_O,
	output wire CLK_2H_O,
	output wire CLK_1H_O,
	output wire CLK_S1H_O,
	output wire CLK_S2H_O
);

	
	reg [8:0] horizontal_counter = 0;
	reg [8:0] vertical_counter = 0;
	
	reg h_latch = 0;
	reg VRESETH;
	
	initial begin
		VSYNC = 0;
		HSYNC = 0;
		VBLANK = 0;
		HBLANK = 0;
		VRESETH = 0;
		VRESET = 0;
		HRESET = 0;
	end	
	
	if (C_USE_HARDWARE_CLOCKS == 0) generate
		reg [2:0] master_counter = 0;
		
		always @(posedge CLK_48M) begin
			if (rst) begin
				master_counter <= 0;
			end else begin
				master_counter <= master_counter + 1;
			end
		end

		assign CLK_24M_O = master_counter[0];
		assign CLK_12M_O = master_counter[1];
		assign CLK_6M_O = master_counter[2];	
	endgenerate
	
	// inspired by information found @ http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440.html
	always @(posedge CLK_6M) begin
		if (rst) begin
			h_latch <= 0;
			horizontal_counter <= 0;
			HSYNC <= 0;
			HBLANK <= 0;
			VRESETH <= 0;
		end else begin	
			// increment h counter with one clock delay
			horizontal_counter[8:1] <= horizontal_counter[8:1] + horizontal_counter[0];
			horizontal_counter[0] <= h_latch;
			h_latch <= ~h_latch;
		
			if (horizontal_counter[8:3] === 6'b110000) 	// ~384
				horizontal_counter <= 0;
		
			// HSYNC & VRESETH
			if (horizontal_counter[8:0] === 9'b100110011) begin
				HSYNC <= 1;	// ~304
				VRESETH <= 1;
			end else
				VRESETH <= 0;
			
			if (horizontal_counter[8:3] === 6'b100110) HSYNC = 0;	// ~336
		
			// HRESET
			HRESET <= (horizontal_counter[8:0] === 10'b0000001111) ? 1 : 0;	// ~15
		end
	end
	
	always @(posedge HSYNC) begin		// input is negated
		if (rst) begin
				vertical_counter <= 0;
				VSYNC <= 0;
				VBLANK <= 0;
				VRESET <= 0
		end else begin
			vertical_counter <= vertical_counter + 1;
		
			if (vertical_counter[8:3] === 6'b100001)	// ~264
				vertical_counter <= 0;
		
			// VSYNC
			if (vertical_counter[8:3] === 6'b011111) //	~248
				VSYNC <= 1;
			
			if (vertical_counter[8:3] === 6'b000000) // ~336	
				// reset VSYNC at start of first line
				VSYNC <= 0;	
			
			// VBLANK
			if (vertical_counter[8:3] === 6'b011110) //	~240
				VBLANK <= 1;
			
			if (vertical_counter[8:3] === 6'b000010) // ~16	
				VBLANK <= 0;	
		
			// VRESET when back to start of line 0
			VRESET <= (VRESETH && (vertical_counter[8:0] === 9'b000000000)) ? 1'b1 : 1'b0;
		end
	end
	
	assign CLK_1H_O = horizontal_counter[0];	// 3.0 Mhz
	assign CLK_S1H_O = horizontal_counter[0];	// is this in phase?
	assign CLK_2H_O = horizontal_counter[1];	// 1.5 Mhz
	assign CLK_S2H_O = horizontal_counter[1];	// is this in phase?
	assign CLK_4H_O = horizontal_counter[2];	// 0.75 Mhz
	
	assign CLK_1V_O = vertical_counter[0];
	assign CLK_4V_O = vertical_counter[3];
	assign CLK_8V_O = vertical_counter[7];
	
endmodule

