`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name: 
// Module Name:    system86\src\CUS27 
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
	input wire HRESET,
    output wire CLK_24M_O,
    output wire CLK_12M_O,
    output wire CLK_6M_O,
	output wire VSYNC,
	output wire HSYNC,
	output wire VBLANK,
	output wire HBLANK,
	output wire VRESET,
	//output CLK_4V_O,
	//output CLK_2V_O,
	//output CLK_1V_O,
	output CLK_4H_O,
    output CLK_2H_O,
	output CLK_1H_O,
	output CLK_S1H_O,
	output CLK_S2H_O
    );

	reg [3:0] master_counter;
	reg [8:0] horizontal_counter;
	reg [8:0] vertical_counter;
	
	initial begin
		master_counter = 0;
		horizontal_counter = 0;
		vertical_counter = 0;
	end	
	
	always @(posedge CLK_48M_I) begin
		master_counter <= master_counter + 1;
	end
	
	always @(posedge CLK_6M_I) begin
		if (HRESET || horizontal_counter == 384) 
			horizontal_counter = 0;
		else
			horizontal_counter = horizontal_counter + 1;
			
	end
	
	assign HSYNC = horizontal_counter >= 304 || horizontal_counter <= 336;
	assign HBLANK = horizontal_counter >= 272 || horizontal_counter <= 368;
		
	assign CLK_24M_O = master_counter[0];
	assign CLK_12M_O = master_counter[1];
	assign CLK_6M_O = master_counter[2];
	
	assign CLK_1H_O = horizontal_counter[0];	// 3.0 Mhz
	assign CLK_S1H_O = horizontal_counter[0];	
	assign CLK_2H_O = horizontal_counter[1];	// 1.5 Mhz
	assign CLK_S2H_O = horizontal_counter[1];	
	assign CLK_4H_O = horizontal_counter[2];	// 0.75 Mhz
	
endmodule

