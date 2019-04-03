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
#(
	parameter C_USE_HARDWARE_CLOCKS = 0
)
(
	// global reset
	input wire rst,
	// input clocks
	input wire clk_48m,
	input wire clk_6m,
	// generated clocks
   output wire clk_24m_o,
   output wire clk_12m_o,
   output wire clk_6m_o,
	// video synchronisation
	output reg vsync,
	output reg hsync,
	output reg vblank,
	output reg hblank,
	output reg vreset,
	output reg hreset,
	// pixel clocks
	output wire pclk_8v_o,
	output wire pclk_4v_o,
	output wire pclk_1v_o,
	output wire pclk_4h_o,
	output wire pclk_2h_o,
	output wire pclk_1h_o,
	output wire pclk_s1h_o,
	output wire pclk_s2h_o
);

	reg [8:0] horizontal_counter = 0;
	reg [8:0] vertical_counter = 0;
	
	reg h_latch = 0;
	reg vresetH;
	
	initial begin
		vsync = 0;
		hsync = 0;
		vblank = 0;
		hblank = 0;
		vresetH = 0;
		vreset = 0;
		hreset = 0;
	end	
	
	generate
		if (C_USE_HARDWARE_CLOCKS == 0) begin
			reg [2:0] master_counter = 0;
		
			always @(posedge clk_48m) begin
				if (rst) begin
					master_counter <= 0;
				end else begin
					master_counter <= master_counter + 1;
				end
			end

			assign clk_24m_o = master_counter[0];
			assign clk_12m_o = master_counter[1];
			assign clk_6m_o = master_counter[2];	
		end else begin
			assign clk_24m_o = 0;
			assign clk_12m_o = 0;
			assign clk_6m_o = 0;	
		end
	endgenerate
	
	// inspired by information found @ http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440.html
	always @(posedge clk_6m) begin
		if (rst) begin
			h_latch <= 0;
			horizontal_counter <= 0;
			hsync <= 0;
			hblank <= 0;
			vresetH <= 0;
		end else begin	
			// increment h counter with one clock delay
			horizontal_counter[8:1] <= horizontal_counter[8:1] + horizontal_counter[0];
			horizontal_counter[0] <= h_latch;
			h_latch <= ~h_latch;
		
			if (horizontal_counter[8:3] === 6'b110000) 	// ~384
				horizontal_counter <= 0;
		
			// hsync & vresetH
			if (horizontal_counter[8:0] === 9'b100110011) begin
				hsync <= 1;	// ~304
				vresetH <= 1;
			end else
				vresetH <= 0;
			
			if (horizontal_counter[8:3] === 6'b100110) hsync <= 0;	// ~336
		
			// hreset
			hreset <= (horizontal_counter[8:0] === 9'b000001111) ? 1'b1 : 1'b0;	// ~15
		end
	end
	
	always @(posedge hsync) begin		// input is negated
		if (rst) begin
				vertical_counter <= 0;
				vsync <= 0;
				vblank <= 0;
				vreset <= 0;
		end else begin
			vertical_counter <= vertical_counter + 1;
		
			if (vertical_counter[8:3] === 6'b100001)	// ~264
				vertical_counter <= 0;
		
			// vsync
			if (vertical_counter[8:3] === 6'b011111) //	~248
				vsync <= 1;
			
			if (vertical_counter[8:3] === 6'b000000) // ~336	
				// reset vsync at start of first line
				vsync <= 0;	
			
			// vblank
			if (vertical_counter[8:3] === 6'b011110) //	~240
				vblank <= 1;
			
			if (vertical_counter[8:3] === 6'b000010) // ~16	
				vblank <= 0;	
		
			// vreset when back to start of line 0
			vreset <= (vresetH && (vertical_counter[8:0] === 9'b000000000)) ? 1'b1 : 1'b0;
		end
	end
	
	assign pclk_1h_o = horizontal_counter[0];	// 3.0 Mhz
	assign pclk_s1h_o = horizontal_counter[0];	// is this in phase?
	assign pclk_2h_o = horizontal_counter[1];	// 1.5 Mhz
	assign pclk_s2h_o = horizontal_counter[1];	// is this in phase?
	assign pclk_4h_o = horizontal_counter[2];	// 0.75 Mhz
	
	assign pclk_1v_o = vertical_counter[0];
	assign pclk_4v_o = vertical_counter[3];
	assign pclk_8v_o = vertical_counter[7];
	
endmodule

