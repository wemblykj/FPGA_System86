`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:24:56 04/21/2018
// Design Name:    CUS27
// Module Name:    system86/src/custom/cus27_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description:    Namco CUS47 - System timings generator testbench
//
// Verilog Test Fixture created by ISE for module: CUS27
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module CUS27_tb;

	// Inputs
	reg CLK_48M_I;
	wire CLK_6M_I;
	reg HRESET;
	// Outputs
	wire CLK_24M_O;
	wire CLK_12M_O;
	wire CLK_6M_O;
	wire VSYNC;
	wire HSYNC;
	wire VBLANK;
	wire HBLANK;
	wire VRESET;
	wire CLK_4H_O;
	wire CLK_2H_O;
	wire CLK_1H_O;
	wire CLK_S2H_O;
	wire CLK_S1H_O;

	// Instantiate the Unit Under Test (UUT)
	CUS27 uut (
		.CLK_48M_I(CLK_48M_I), 
		.CLK_6M_I(CLK_6M_I), 
		.CLK_24M_O(CLK_24M_O), 
		.CLK_12M_O(CLK_12M_O), 
		.CLK_6M_O(CLK_6M_O), 
		.VSYNC(VSYNC), 
		.HSYNC(HSYNC), 
		.VBLANK(VBLANK), 
		.HBLANK(HBLANK), 
		.VRESET(VRESET), 
		.CLK_4H_O(CLK_4H_O), 
		.CLK_2H_O(CLK_2H_O), 
		.CLK_1H_O(CLK_1H_O), 
		.CLK_S2H_O(CLK_S2H_O), 
		.CLK_S1H_O(CLK_S1H_O)
	);

	initial begin
		// Initialize Inputs
		CLK_48M_I = 0;
		//CLK_6M_I = 0;
		HRESET = 1;

		// Wait 1000 ns for global reset to finish
		#10;
        
		// Add stimulus here
		HRESET = 0;
		
		#400000;
		$finish;
	end
      
	always begin
		#10 CLK_48M_I = ~CLK_48M_I;
		
	end
      
	assign CLK_6M_I = CLK_6M_O;
endmodule

