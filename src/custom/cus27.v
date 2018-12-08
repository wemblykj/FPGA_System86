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
module CUS27(
    input wire CLK_48M_I,
    input wire CLK_6M_I,
    output wire CLK_24M_O,
    output wire CLK_12M_O,
    output wire CLK_6M_O,
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

	reg [3:0] master_counter;
	reg [8:0] horizontal_counter;
	reg [8:0] vertical_counter;
	
	reg VRESETH;
	
	initial begin
		master_counter = 0;
		horizontal_counter = 0;
		vertical_counter = 0;
		VSYNC = 0;
		HSYNC = 0;
		VBLANK = 0;
		HBLANK = 0;
		VRESETH = 0;
		VRESET = 0;
		HRESET = 0;
	end	
	
	always @(posedge CLK_48M_I) begin
		master_counter <= master_counter + 1;
	end
	
	// based on information found @ http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440.html
	
	always @(negedge CLK_6M_I) begin		// note: negative edge of clock
		if (horizontal_counter[8:3] === 6'b110000) 	// ~384
			horizontal_counter = 0;
		else begin
			horizontal_counter = horizontal_counter + 1;
		end
	end
	
	always @(posedge CLK_6M_I) begin
		// HSYNC & VRESETH
		if (horizontal_counter[8:0] === 9'b100110011) begin
			HSYNC <= 1'b1;	// ~304
			VRESETH <= 1'b1;
		end else
			VRESETH <= 1'b0;
			
		if (horizontal_counter[8:3] === 6'b100110) HSYNC = 1'b0;	// ~336
		
		// HRESET
		HRESET <= (horizontal_counter[8:0] === 10'b0000001111) ? 1'b1 : 1'b0;	// ~15
	end
	
	always @(posedge HSYNC) begin		// input is negated
		if (vertical_counter[8:3] === 6'b100001)	// ~264
			vertical_counter = 0;
		else
			vertical_counter = vertical_counter + 1;
		
		// VSYNC
		if (vertical_counter[8:3] === 6'b011111) //	~248
			VSYNC <= 1'b1;
			
		if (vertical_counter[8:3] === 6'b000000) // ~336	
			// reset VSYNC at start of first line
			VSYNC <= 1'b0;	
			
		// VBLANK
		if (vertical_counter[8:3] === 6'b011110) //	~240
			VBLANK <= 1'b1;
			
		if (vertical_counter[8:3] === 6'b000010) // ~16	
			VBLANK <= 1'b0;	
		
		// VRESET when back to start of line 0
		VRESET <= (VRESETH && (vertical_counter[8:0] === 9'b000000000)) ? 1'b1 : 1'b0;
	end
	
	assign CLK_24M_O = master_counter[0];
	assign CLK_12M_O = master_counter[1];
	assign CLK_6M_O = master_counter[2];
	
	assign CLK_1H_O = horizontal_counter[0];	// 3.0 Mhz
	assign CLK_S1H_O = horizontal_counter[0];	
	assign CLK_2H_O = horizontal_counter[1];	// 1.5 Mhz
	assign CLK_S2H_O = horizontal_counter[1];	
	assign CLK_4H_O = horizontal_counter[2];	// 0.75 Mhz
	
	assign CLK_1V_O = vertical_counter[0];
	assign CLK_4V_O = vertical_counter[3];
	assign CLK_8V_O = vertical_counter[7];
	
endmodule

