`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:23:07 11/24/2020
// Design Name:   ls153
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/ttl_logic/simulation/ls153_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls153
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ls153_tb;

	// Inputs
	reg S0;
	reg S1;
	reg nEa;
	reg I0a;
	reg I1a;
	reg I2a;
	reg I3a;
	reg nEb;
	reg I0b;
	reg I1b;
	reg I2b;
	reg I3b;

	// Outputs
	wire Za;
	wire Zb;

	// Instantiate the Unit Under Test (UUT)
	ls153 uut (
		.S0(S0), 
		.S1(S1), 
		.nEa(nEa), 
		.I0a(I0a), 
		.I1a(I1a), 
		.I2a(I2a), 
		.I3a(I3a), 
		.nEb(nEb), 
		.I0b(I0b), 
		.I1b(I1b), 
		.I2b(I2b), 
		.I3b(I3b), 
		.Za(Za), 
		.Zb(Zb)
	);

	initial begin
		// Initialize Inputs
		S0 = 0;
		S1 = 0;
		nEa = 0;
		I0a = 0;
		I1a = 0;
		I2a = 0;
		I3a = 0;
		nEb = 0;
		I0b = 0;
		I1b = 0;
		I2b = 0;
		I3b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

