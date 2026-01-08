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

module cus27_furrtek_ref_tb;

	// Inputs
	reg _rst_ni;
	reg sig_48M_i;
	//reg sig_6M_i;

	// Outputs
	wire sig_24M_o;
	wire sig_12M_o;
	wire sig_6M_o;
	wire sig_bVSYNC_o;
	wire sig_bHSYNC_o;
	wire sig_bVBLANK_o;
	wire sig_bHBLANK_o;
	wire sig_bVRESET_o;
	wire sig_bHRESET_o;
	wire sig_1H_o;
	wire sig_2H_o;
	wire sig_4H_o;
	wire sig_1V_o;
	wire sig_2V_o;
	wire sig_4V_o;
	wire sig_8V_o;
	wire sig_S1H_o;
	wire sig_S2H_o;

	// Instantiate the Unit Under Test (UUT)
	cus27_furrtek_ref uut (
		._rst_ni(_rst_ni), 
		.pin_48M_i(sig_48M_i), 
		.pin_OTEN_i(1'b0),
		.pin_MODE0_i(1'b0),
		.pin_MODE1_i(1'b0),
		.pin_FLIP_i(1'b0),
		.pin_6M_i(sig_6M_o), 
		.pin_24M_o(sig_24M_o), 
		.pin_12M_o(sig_12M_o), 
		.pin_6M_o(sig_6M_o), 
		.pin_bVSYNC_o(sig_bVSYNC_o), 
		.pin_bHSYNC_o(sig_bHSYNC_o), 
		.pin_bVBLANK_o(sig_bVBLANK_o), 
		.pin_bHBLANK_o(sig_bHBLANK_o), 
		.pin_bVRESET_o(sig_bVRESET_o), 
		.pin_bHRESET_o(sig_bHRESET_o), 
		.pin_1H_o(sig_1H_o), 
		.pin_2H_o(sig_2H_o), 
		.pin_4H_o(sig_4H_o), 
		.pin_1V_o(sig_1V_o), 
		.pin_2V_o(sig_2V_o), 
		.pin_4V_o(sig_4V_o), 
		.pin_8V_o(sig_8V_o), 
		.pin_S1H_o(sig_S1H_o), 
		.pin_S2H_o(sig_S2H_o)
	);

	initial begin
		// Initialize Inputs
		_rst_ni = 0;
		sig_48M_i = 0;
		//sig_6M_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_ni = 1;
		  
		// Add stimulus here

	end
	
	always @(negedge sig_bHSYNC_o) begin
		if (sig_8V_o)
			$stop;
	end
    
	always begin
		#10.1725 sig_48M_i = ~sig_48M_i;
	end
      
endmodule

