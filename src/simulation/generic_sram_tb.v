`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:49:38 05/09/2018
// Design Name:    SRAM
// Module Name:    system86\simulation\sram_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SRAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module SRAM_tb;

	parameter ADDR_WIDTH = 4;
	parameter DATA_WIDTH = 8;

	// Inputs
	reg OE;
	reg CE;
	reg WE;
	reg [ADDR_WIDTH-1:0] A;

	// Outputs
	wire [DATA_WIDTH-1:0] D;

	reg [DATA_WIDTH-1:0] DIn;
	
	// Instantiate the Unit Under Test (UUT)
	SRAM #(ADDR_WIDTH, DATA_WIDTH) uut (
		.OE(OE), 
		.CE(CE), 
		.WE(WE), 
		.A(A), 
		.D(D)
	);

	integer i = 0;
	
	assign D = (CE && WE) ? DIn : 8'bZ;
	
	initial begin
		// Initialize Inputs
		OE = 0;
		CE = 0;
		WE = 0;
		A = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		$monitor("%d, %d, %d, 0x%x, 0x%x", CE, OE, WE, A, D);
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
			DIn = A[7:0];
			#1;
			A = i;
			#1;
			WE = 1;
			#1;
			WE = 0;
	  end
	  
	  #1;
	  
	  for (i=0; i<2**ADDR_WIDTH; i=i+1) begin
			#1;
			A = i;
			#1;
			OE = 1;
			#1;
			OE = 0;
	  end

	  #1;
	  CE = 0;
	  
	end
      
endmodule

