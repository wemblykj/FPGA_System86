`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:16:09 11/25/2020
// Design Name:   cus35
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/system86/simulation/custom/cus35_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus35
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus35_tb;

	// Inputs
	reg CLK_6M;
	reg VRES;
	reg HSYNC;
	reg OCS;
	reg WE;
	reg [12:0] A;

	// Outputs
	wire O16VA;
	wire O8VA;
	wire O4VA;
	wire O2VA;
	wire O1VA;
	wire O16HA;
	wire O8HA;
	wire O4HA;
	wire O2HA;
	wire FLIP;
	wire HFLIP;
	wire O8EN;
	wire HSET;
	wire VSET;
	wire CS0;
	wire CS1;
	wire ROE;
	wire RWE;

	// Bidirs
	wire [7:0] D;
	wire [7:0] BI;
	wire [7:0] BO;

	// Instantiate the Unit Under Test (UUT)
	cus35 uut (
		.CLK_6M(CLK_6M), 
		.VRES(VRES), 
		.HSYNC(HSYNC), 
		.OCS(OCS), 
		.WE(WE), 
		.A(A), 
		.D(D), 
		.O16VA(O16VA), 
		.O8VA(O8VA), 
		.O4VA(O4VA), 
		.O2VA(O2VA), 
		.O1VA(O1VA), 
		.O16HA(O16HA), 
		.O8HA(O8HA), 
		.O4HA(O4HA), 
		.O2HA(O2HA), 
		.FLIP(FLIP), 
		.HFLIP(HFLIP), 
		.O8EN(O8EN), 
		.HSET(HSET), 
		.VSET(VSET), 
		.CS0(CS0), 
		.CS1(CS1), 
		.ROE(ROE), 
		.RWE(RWE), 
		.BI(BI), 
		.BO(BO)
	);

	initial begin
		// Initialize Inputs
		CLK_6M = 0;
		VRES = 0;
		HSYNC = 0;
		OCS = 0;
		WE = 0;
		A = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

