`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:      Paul Wightmore
//
// Create Date:   21:26:22 04/15/2018
// Design Name:   GENERIC_PROM
// Module Name:   system86/simulation/generic_prom_tb.v
// Project Name:  Namco System86 simulation
//// Target Device:  
// Tool versions:  
// Description:   PROM simulation based on binary file - test bench
//
// Verilog Test Fixture created by ISE for module: PROM_FILE
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module GENERIC_PROM_tb;

	parameter ADDR_WIDTH = 15;
	parameter DATA_WIDTH = 8;
	parameter FILE_NAME = "roms/rt3_1b.9c";

	// Inputs
	reg [ADDR_WIDTH-1:0] A;
	reg E;
	reg G;

	// Outputs
	wire [DATA_WIDTH-1:0] Q;

	// Instantiate the Unit Under Test (UUT)
	GENERIC_PROM #(ADDR_WIDTH, DATA_WIDTH, FILE_NAME, 0, 0, 0, 0) uut (
		.A(A), 
		.Q(Q), 
		.E(E), 
		.G(G)
	);

	integer i = 0;
	
	initial begin
		// Initialize Inputs
		A = 0;
		E = 0;
		G = 0;

		// Wait 100 ns for global reset to finish
		#10;

		// Add stimulus here
	  $monitor("%d, %d, 0x%x, 0x%x", E, G, A, Q);
	  /*
	  for (i=0; i<16; i=i+1) begin
			#4;
			A = i;
	  end
	  
	  OE = 1;
	  for (i=0; i<16; i=i+1) begin
			#4;
			A = i;
	  end
	  
	  OE = 0;
	  CE = 1;
	  for (i=0; i<16; i=i+1) begin
			#4;
			A = i;
	  end
	  */  
	  
	  
	  E = 1;
	  #10 G = 1;
	  #300
	  for (i=0; i<4; i=i+1) begin
			A <= i;
			#20;
	  end
	  G = 0;
	  #200 E = 0;
	end
	
endmodule

