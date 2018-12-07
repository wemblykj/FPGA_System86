`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:26:22 04/15/2018
// Design Name:   PROM_FILE
// Module Name:   System86/PROM_FILE_tb.v
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
// 
////////////////////////////////////////////////////////////////////////////////

module PROM_FILE_tb;

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
	  $monitor(CE, OE, A, Q);
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
	  OE = 1;
	  CE = 1;
	  for (i=0; i<2**ADDR_WIDTH; i=i+1) begin
			#1;
			A <= i;
	  end
	  
	end
	
	   
endmodule

