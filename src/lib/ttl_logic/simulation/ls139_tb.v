`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:22:42 11/24/2020
// Design Name:   ls139
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/ttl_logic/simulation/ls139_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls139
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ls139_tb;

	// Inputs
	reg nEa;
	reg A0a;
	reg A1a;
	reg nEb;
	reg A0b;
	reg A1b;

	// Outputs
	wire nO0a;
	wire nO1a;
	wire nO2a;
	wire nO3a;
	wire nO0b;
	wire nO1b;
	wire nO2b;
	wire nO3b;

	// Instantiate the Unit Under Test (UUT)
	ls139 uut (
		.nEa(nEa), 
		.A0a(A0a), 
		.A1a(A1a), 
		.nEb(nEb), 
		.A0b(A0b), 
		.A1b(A1b), 
		.nO0a(nO0a), 
		.nO1a(nO1a), 
		.nO2a(nO2a), 
		.nO3a(nO3a), 
		.nO0b(nO0b), 
		.nO1b(nO1b), 
		.nO2b(nO2b), 
		.nO3b(nO3b)
	);

	initial begin
		// Initialize Inputs
		nEa = 0;
		A0a = 0;
		A1a = 0;
		nEb = 0;
		A0b = 0;
		A1b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

