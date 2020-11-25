`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:17:03 11/25/2020
// Design Name:   sprite_subsystem
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/system86/simulation/subsystem/sprite_subsystem_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sprite_subsystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sprite_subsystem_tb;

	// Inputs
	reg rst;
	reg CLK_6M;
	reg CLK_1H;
	reg nOBJECT;
	reg nHSYNC;
	reg nVRESET;
	reg [12:0] A;
	reg [7:0] D;
	reg RnW;

	// Instantiate the Unit Under Test (UUT)
	sprite_subsystem uut (
		.rst(rst), 
		.CLK_6M(CLK_6M), 
		.CLK_1H(CLK_1H), 
		.nOBJECT(nOBJECT), 
		.nHSYNC(nHSYNC), 
		.nVRESET(nVRESET), 
		.A(A), 
		.D(D), 
		.RnW(RnW)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		CLK_6M = 0;
		CLK_1H = 0;
		nOBJECT = 0;
		nHSYNC = 0;
		nVRESET = 0;
		A = 0;
		D = 0;
		RnW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

