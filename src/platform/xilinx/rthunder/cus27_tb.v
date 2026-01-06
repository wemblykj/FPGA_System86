`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:12:41 12/17/2025
// Design Name:   cus27
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/platform/xilinx/xsystem86/cus27_tb.v
// Project Name:  xsystem86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus27_tb;
	// Inputs
	reg sig_48M;

	// Outputs
	wire sig_24M;
	wire sig_12M;
	wire sig_6M;
	wire sig_bVSYNC;
	wire sig_bHSYNC;
	wire sig_bVBLANK;
	wire sig_bHBLANK;
	wire sig_bVRESET;
	wire sig_bHRESET;
	wire sig_8V;
	wire sig_4V;
	wire sig_1V;
	wire sig_4H;
	wire sig_2H;
	wire sig_1H;
	wire sig_S2H;
	wire sig_S1H;
	wire sig_A;

	// Implementation
	reg _rst_n;

	// Instantiate the Unit Under Test (UUT)
	cus27 uut (
		._rst_ni(_rst_n), 
		.pin_48M_i(sig_48M), 
		.pin_6M_i(sig_6M), 
		.pin_24M_i(sig_24M), 
		.pin_12M_i(sig_12M), 
		.pin_6M_o(sig_6M), 
		.pin_bVSYNC_o(sig_bVSYNC), 
		.pin_bHSYNC_o(sig_bHSYNC), 
		.pin_bVBLANK_o(sig_bVBLANK), 
		.pin_bHBLANK_o(sig_bHBLANK), 
		.pin_bVRESET_o(sig_bVRESET), 
		.pin_bHRESET_o(sig_bHRESET), 
		.pin_8V_o(sig_8V), 
		.pin_4V_o(sig_4V), 
		.pin_1V_o(sig_1V), 
		.pin_4H_o(sig_4H), 
		.pin_2H_o(sig_2H), 
		.pin_1H_o(sig_1H), 
		.pin_S2H_o(sig_S2H), 
		.pin_S1H_o(sig_S1H),
		.pin_A_o(sig_A)
	);

	initial begin
		// Initialize Inputs
		_rst_n = 0;
		sig_48M = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_n = 1;
		
		// Add stimulus here
		sig_48M = ~sig_48M;
	end
	
endmodule

