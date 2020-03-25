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
module cus27
(
	// simulation control
	input wire reset,
	input wire enable,
	
	// input clocks
	input wire CLK_48M,
	input wire CLK_6M_IN,
	
	// generated clocks
   output wire CLK_24M,
   output wire CLK_12M,
   output wire CLK_6M,
	
	// video synchronisation
	output reg VSYNC,
	output reg HSYNC,
	output reg VBLANK,
	output reg HBLANK,
	output reg VRESET,
	output reg HRESET,
	
	// video timing signals
	output reg CLK_8V,
	output reg CLK_4V,
	output reg CLK_1V,
	output reg CLK_4H,
	output reg CLK_2H,
	output reg CLK_1H,
	output reg CLK_S2H,
	output reg CLK_S1H
);

	reg [8:0] horizontal_counter = 0;
	reg [8:0] vertical_counter = 0;
	
	
	reg vresetH = 0;
	
	reg h_latch = 0;
	reg h_latch_next = 0;
	reg [8:0] horizontal_counter_next = 0;
	reg hsync_next = 0;
	reg hblank_next = 0;
	reg hreset_next = 0;
	
	reg [8:0] vertical_counter_next = 0;
	reg vsync_next = 0;
	reg vblank_next = 0;
	reg vreset_next = 0;
	
	reg [2:0] master_counter = 0;

	always @(posedge CLK_48M) begin
		if (!enable) begin
		end else if (reset) begin
			master_counter <= 0;
		end else begin
			master_counter <= master_counter + 1;
		end
	end

	assign CLK_24M = master_counter[0];
	assign CLK_12M = master_counter[1];
	assign CLK_6M = master_counter[2];	
	
	always @(*) begin
		if (!enable) begin
		end else if (reset) begin
			horizontal_counter <= 0;
			horizontal_counter_next = 0;
			HSYNC <= 1;
			hsync_next <= 1;
			HBLANK <= 0;
			hblank_next <= 0;
			HRESET <= 0;
			hreset_next <= 0;
		end else begin
			horizontal_counter <= horizontal_counter_next;
			HSYNC <= hsync_next;
			HBLANK <= hblank_next;
			HRESET <= hreset_next;
		end
	end
	
	always @(*) begin
		if (!enable) begin
		end else if (reset) begin
			//vresetH <= 0;
			vertical_counter <= 0;
			vertical_counter_next <= 0;
			VSYNC <= 1;
			vsync_next <= 1;
			VBLANK <= 0;
			vblank_next <= 0;
			VRESET <= 0;
			vreset_next <= 0;
		end else begin
			vertical_counter <= vertical_counter_next;
			VSYNC <= vsync_next;
			VBLANK <= vblank_next;
			VRESET <= vreset_next;
		end
	end
	
	// inspired by information found @ http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440.html
	always @(negedge CLK_6M_IN) begin
		horizontal_counter_next <= horizontal_counter + 1;
	end
		
	always @(posedge CLK_6M_IN) begin
		if (horizontal_counter[8:3] === 6'b110000) 	// ~384
			horizontal_counter <= 0;
	
		// hsync
		if (horizontal_counter[8:0] === 9'b100110000)
			hsync_next <= 0;	// ~304
		
		if (horizontal_counter[8:3] === 6'b101010) 
			hsync_next <= 1;	// ~336
	
		// hblank
		if (horizontal_counter[8:3] === 6'b100010)
			hblank_next <= 1;	// ~272
		
		if (horizontal_counter[8:3] === 6'b101110) 
			hblank_next <= 0;	// ~368
			
		// hreset
		hreset_next <= (horizontal_counter[8:0] === 9'b000001111) ? 1'b1 : 1'b0;	// ~15
		
		CLK_1H <= horizontal_counter[0];	// 3.0 Mhz
		CLK_S1H <= horizontal_counter[0];	// is this in phase?
		CLK_2H <= horizontal_counter[1];	// 1.5 Mhz
		CLK_S2H <= horizontal_counter[1];	// is this in phase?
		CLK_4H <= horizontal_counter[2];	// 0.75 Mhz
	end
	
	always @(posedge HSYNC) begin
		vertical_counter_next <= vertical_counter + 1;
		
		// vreset when back to start of line 0
		vreset_next <= (vresetH && (vertical_counter[8:0] === 9'b000000000)) ? 1'b1 : 1'b0;
	end
	
	always @(negedge HSYNC) begin
		if (vertical_counter[8:3] === 6'b100001)	// ~264
			vertical_counter <= 0;
	
		// vsync
		if (vertical_counter[8:3] === 6'b011111) //	~248
			vsync_next <= 0;
		
		if (vertical_counter[8:3] === 6'b000000) // ~336	
			vsync_next <= 1;	
		
		// vblank
		if (vertical_counter[8:3] === 6'b011110) //	~240
			vblank_next <= 1;
		
		if (vertical_counter[8:3] === 6'b000010) // ~16	
			vblank_next <= 0;			
			
		CLK_1V <= vertical_counter[0];
		CLK_4V <= vertical_counter[3];
		CLK_8V <= vertical_counter[7];
	end
	
endmodule

