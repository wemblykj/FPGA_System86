`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: P.Wightmore
//
// Create Date:   10:40:07 05/13/2018
// Design Name:   CLUT
// Module Name:   C:/Development/Xilinx/system86/clut_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLUT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CLUT_tb;

	// Inputs
	reg CLK_6M;
	reg CLR;
	reg [7:0] D;
	reg BANK;

	// Outputs
	wire [7:0] R;
	wire [7:0] G;
	wire [7:0] B;

	integer i = 0;
	
	// Instantiate the Unit Under Test (UUT)
	CLUT #("roms/rt1-1.3r", "roms/rt1-2.3s") uut (
		.CLK_6M(CLK_6M), 
		.CLR(CLR), 
		.D(D), 
		.BANK(BANK), 
		.R(R), 
		.G(G), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		CLK_6M = 0;
		CLR = 0;
		D = 0;
		BANK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("%x = %d, %d, %d", D, R, G, B);
		for (i = 0; i < 256; i = i +1) begin
			D = i;
			#1;
		end
	end
      
endmodule

