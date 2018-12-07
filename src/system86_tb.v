`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:   20:57:30 04/12/2018
// Design Name:   system86/system86.v
// Module Name:   C:/Development/Xilinx/system86/system86_tb.v
// Project Name:  Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description:   Top-level Namco System86 board simulation - test bench
//
// Verilog Test Fixture created by ISE for module: system86
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module system86_tb;

	// Inputs
	reg clk_in;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	system86 uut (
		.clk48m(clk_in), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 1;

		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
      
	always begin
		#2 clk_in = ~clk_in;
	end
	
endmodule

