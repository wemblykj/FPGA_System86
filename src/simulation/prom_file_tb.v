`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:      Paul Wightmore
//
// Create Date:   21:26:22 04/15/2018
// Design Name:   PROM_FILE
// Module Name:   system86/simulation/prom_file_tb.v
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

module PROM_FILE_TB;

	parameter ADDR_WIDTH = 15;
	parameter DATA_WIDTH = 8;

	// Inputs
	reg [ADDR_WIDTH-1:0] A;
	reg CE;
	reg OE;

	// Outputs
	wire [DATA_WIDTH-1:0] Q;

	// Instantiate the Unit Under Test (UUT)
	PROM_FILE #(ADDR_WIDTH, DATA_WIDTH, "roms/rt3_1b.9c") uut (
		.A(A), 
		.Q(Q), 
		.CE(CE), 
		.OE(OE)
	);

	integer i = 0;
	
	initial begin
		// Initialize Inputs
		A = 0;
		CE = 0;
		OE = 0;

		// Wait 100 ns for global reset to finish
		#10;

		// Add stimulus here
	  $monitor("%d, %d, 0x%x, 0x%x", CE, OE, A, Q);
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
	  
	  
	  CE = 1;
	  for (i=0; i<2**ADDR_WIDTH; i=i+1) begin
			#1;
			A <= i;
			#1;
			OE = 1;
			#1;
			OE = 0;
	  end
	  
	end
	
	   
endmodule

