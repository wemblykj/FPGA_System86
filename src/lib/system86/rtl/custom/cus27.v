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
	output reg pclk_8v_o,
	output reg pclk_4v_o,
	output reg pclk_1v_o,
	output reg pclk_4h_o,
	output reg pclk_2h_o,
	output reg pclk_1h_o,
	output reg pclk_s1h_o,
	output reg pclk_s2h_o
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
	
	always @(*) begin
		if (rst) begin
			horizontal_counter <= 0;
			horizontal_counter_next = 0;
			hsync <= 1;
			hsync_next <= 1;
			hblank <= 0;
			hblank_next <= 0;
			hreset <= 0;
			hreset_next <= 0;
		end else begin
			horizontal_counter <= horizontal_counter_next;
			hsync <= hsync_next;
			hblank <= hblank_next;
			hreset <= hreset_next;
		end
	end
	
	always @(*) begin
		if (rst) begin
			//vresetH <= 0;
			vertical_counter <= 0;
			vertical_counter_next <= 0;
			vsync <= 1;
			vsync_next <= 1;
			vblank <= 0;
			vblank_next <= 0;
			vreset <= 0;
			vreset_next <= 0;
		end else begin
			vertical_counter <= vertical_counter_next;
			vsync <= vsync_next;
			vblank <= vblank_next;
			vreset <= vreset_next;
		end
	end
	
	// inspired by information found @ http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440.html
	always @(negedge clk_6m) begin
		horizontal_counter_next <= horizontal_counter + 1;
	end
		
	always @(posedge clk_6m) begin
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
		
		pclk_1h_o <= horizontal_counter[0];	// 3.0 Mhz
		pclk_s1h_o <= horizontal_counter[0];	// is this in phase?
		pclk_2h_o <= horizontal_counter[1];	// 1.5 Mhz
		pclk_s2h_o <= horizontal_counter[1];	// is this in phase?
		pclk_4h_o <= horizontal_counter[2];	// 0.75 Mhz
	end
	
	always @(posedge hsync) begin
		vertical_counter_next <= vertical_counter + 1;
		
		// vreset when back to start of line 0
		vreset_next <= (vresetH && (vertical_counter[8:0] === 9'b000000000)) ? 1'b1 : 1'b0;
	end
	
	always @(negedge hsync) begin
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
			
		pclk_1v_o <= vertical_counter[0];
		pclk_4v_o <= vertical_counter[3];
		pclk_8v_o <= vertical_counter[7];
	end
	
endmodule

