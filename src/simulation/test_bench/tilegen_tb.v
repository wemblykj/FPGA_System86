`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    18:27:25 05/30/2018
// Design Name:    tilegen_tb
// Module Name:    system86/simulation/test_bench/tilegen_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TILEGEN
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

`include "../roms/rthunder.vh"

module tilegen_tb;

	// Inputs
	reg CLK_6M;
	reg CLK_2H;
	reg SCROLL0;
	reg SCROLL1;
	reg LATCH0;
	reg LATCH1;
	reg HSYNC;
	reg VSYNC;
	reg FLIP;
	reg SRCWIN;
	reg BACKCOLOR;
	reg [12:0] A;
	reg WE;
	reg [7:0] MD;

	// Outputs
	wire [2:0] SPR;
	wire [7:0] DOT;

	// Bidirs
	wire [7:0] D;
	wire [20:1] J5;

	// Instantiate the Unit Under Test (UUT)
	TILEGEN 
		#(
			`ROM_4R, `ROM_4S, `ROM_4V, `ROM_6U,
			`ROM_7R, `ROM_7S
		)
		uut
		(
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_2H), 
			.SCROLL0(SCROLL0), 
			.SCROLL1(SCROLL1), 
			.LATCH0(LATCH0), 
			.LATCH1(LATCH1), 
			.HSYNC(HSYNC), 
			.VSYNC(VSYNC), 
			.FLIP(FLIP), 
			.SRCWIN(SRCWIN), 
			.BACKCOLOR(BACKCOLOR), 
			.A(A), 
			.WE(WE),
			.MD(MD), 
			.D(D), 
			.J5(J5), 
			.SPR(SPR), 
			.DOT(DOT)
		);
	
	reg [2:0] counter = 0;
	
	initial begin
		counter = 0;
		
		// Initialize Inputs
		CLK_6M = 0;
		CLK_2H = 0;
		SCROLL0 = 0;
		SCROLL1 = 0;
		LATCH0 = 0;
		LATCH1 = 0;
		HSYNC = 0;
		VSYNC = 0;
		FLIP = 0;
		SRCWIN = 0;
		BACKCOLOR = 0;
		A = 0;
		WE = 0;
		MD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		SCROLL0 = 1;
		A = 0;
		#162.760417
		WE = 1;
		#162.760417
		WE = 0;

	end
    
	always begin
		#81.3802085 CLK_6M = ~CLK_6M;
		
		if (CLK_6M)
				counter = counter + 1;
		
		CLK_2H = counter[1];
	end
	
endmodule

