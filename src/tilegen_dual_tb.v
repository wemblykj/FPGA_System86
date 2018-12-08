`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    19:43:02 06/12/2018
// Design Name:    TILEGEN
// Module Name:    system86/tilegen_single_tb.v
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

module tilegen_single_tb(

	// Inputs
	input reg clk_in,
	input reg rst,
	output wire [7:0] R,
	output wire [7:0] G,
	output wire [7:0] B,
	output wire HSYNC,
	output wire VSYNC
	);

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire CLK_6M;
	wire CLK_2H;
	
	// Timing subsystem
	TIMING TIMING(
		.CLK_48M(clk_in),
		.CLK_6M(CLK_6M),
		.VSYNC(VSYNC),
		.HSYNC(HSYNC),
		.HBLANK(HBLANK),
		.VBLANK(VBLANK),
		.VRESET(VRESET),
		.COMPSYNC(COMPSYNC),
		.CLK_2H(CLK_2H)
	);
	
	// Inputs
	
	reg SCROLL0;
	reg SCROLL1;
	reg LATCH0;
	reg LATCH1;
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

	reg [2:0] counter = 0;
	integer rgb_fd;

	// Instantiate the Unit Under Test (UUT)
	TILEGEN uut (
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
		
	initial begin
		// Initialize Inputs
		clk_in = 0;
		FLIP = 0;
		SRCWIN = 0;
		BACKCOLOR = 0;
		A = 0;
		WE = 0;
		MD = 0;

		rgb_fd = $fopen("rgb.log", "w");

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#10.1725 clk_in = ~clk_in;
		
		if (!rst) begin
			if (counter[2])
				$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, HSYNC, VSYNC, R, G, B);
				
			if (clk_in)
				counter = counter + 1;
		end
	end
      
endmodule

