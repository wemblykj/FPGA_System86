`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:10:47 01/08/2026
// Design Name:   cus27_furrtek_ref
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/cus27_furrtek_ref_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_furrtek_ref
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module furrtek_clockdivider_tb;

	// Inputs
	reg _rst_ni;
	reg sig_48M_i;
	reg sig_bHRESET1_i;
	reg sig_E7BOT_i;

	// Outputs
	wire sig_24M_o;
	wire sig_12M_o;
	wire sig_6M_o;

	wire sig_S1H_o;
	wire sig_S2H_o;

	// Instantiate the Unit Under Test (UUT)
	furrtek_clockdivider uut (
		._rst_ni(_rst_ni), 
		.sig_48M_i(sig_48M_i), 
		.sig_bHRESET1_i(sig_bHRESET1_i), 
		.sig_E7BOT_i(sig_E7BOT_i),
		.sig_24M_o(sig_24M_o), 
		.sig_12M_o(sig_12M_o), 
		.sig_6M_o(sig_6M_o), 
		.sig_S1H_o(sig_S1H_o), 
		.sig_S2H_o(sig_S2H_o)
	);

	initial begin
		// Initialize Inputs
		_rst_ni = 0;
		sig_48M_i = 0;
		sig_bHRESET1_i = 1'b1;
		sig_E7BOT_i = 1'b1;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_ni = 1;
		  
		// Add stimulus here

		#500;
		
		sig_E7BOT_i = 1'b0;
		
		#100;
		
		sig_E7BOT_i = 1'b1;
		
		#500;
		
		$finish;
	end
	
	always begin
		#10.1725 sig_48M_i = ~sig_48M_i;
	end
      
endmodule

