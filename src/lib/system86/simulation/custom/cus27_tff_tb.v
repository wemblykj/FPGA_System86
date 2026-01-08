`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:12:52 01/07/2026
// Design Name:   cus27_tff_tb
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/cus27_tff_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_tff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus27_tff_tb;

	reg _rst_n;
	
	// Inputs
	reg CLK;
	reg bSET;
	reg bRES;

	// Outputs
	wire Q;
	wire bQ;

	// Instantiate the Unit Under Test (UUT)
	cus27_tff uut (
		._rst_ni(_rst_n),
		.CLK(CLK), 
		.Q(Q), 
		.bQ(bQ), 
		.bSET(bSET), 
		.bRES(bRES)
	);

	initial begin
		_rst_n = 0;
		
		// Initialize Inputs
		CLK = 0;
		bSET = 0;
		bRES = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_n = 1;
		  
		// Add stimulus here

	end
      
endmodule

