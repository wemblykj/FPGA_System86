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

	parameter IOB_INPUT_INVERSION = 1'b1;
	parameter IOB_OUTPUT_INVERSION = 1'b1;
	
	// Inputs
	reg sig_48M_i;
	reg sig_6M_IN_i;
	reg sig_bHRES_IN_i;
	reg sig_bVRES_IN_i;

	// Outputs
	wire sig_24M_o;
	wire sig_12M_o;
	wire sig_6M_OUT_o;
	
	wire sig_bHSYNC_o;
	wire sig_bHBLANK_o;
	wire sig_bHRES_o;
	
	wire sig_bVSYNC_o;
	wire sig_bVBLANK_o;
	wire sig_bVRES_o;
		
	wire sig_1H_o;
	wire sig_2H_o;
	wire sig_4H_o;
	wire sig_8H_o;
	wire sig_1V_o;
	wire sig_2V_o;
	wire sig_4V_o;
	wire sig_8V_o;
	wire sig_S1H_o;
	wire sig_S2H_o;
	wire sig_PIN40_o;
	wire sig_PIN41_o;

	//assign #1 sig_6M_IN_i = sig_6M_o;
	
	// Instantiate the Unit Under Test (UUT)
	cus27_furrtek_ref #(	
			IOB_INPUT_INVERSION,
			IOB_OUTPUT_INVERSION )
		uut ( 
			.pin_48M_i(sig_48M_i), 
			.pin_OTEN_i(1'b0),
			.pin_MODE0_i(1'b0),
			.pin_MODE1_i(1'b0),
			.pin_FLIP_i(1'b0),
			.pin_6M_IN_i(sig_6M_IN_i), 
			.pin_bHRES_IN_i(sig_bHRES_IN_i),
			.pin_bVRES_IN_i(sig_bVRES_IN_i),
			.pin_24M_o(sig_24M_o), 
			.pin_12M_o(sig_12M_o), 
			.pin_6M_OUT_o(sig_6M_OUT_o), 
			.pin_bVSYNC_o(sig_bVSYNC_o), 
			.pin_bHSYNC_o(sig_bHSYNC_o), 
			.pin_bVBLANK_o(sig_bVBLANK_o), 
			.pin_bHBLANK_o(sig_bHBLANK_o), 
			.pin_bVRES_o(sig_bVRES_o), 
			.pin_bHRES_o(sig_bHRES_o), 
			.pin_1H_o(sig_1H_o), 
			.pin_2H_o(sig_2H_o), 
			.pin_4H_o(sig_4H_o), 
			.pin_8H_o(sig_8H_o), 
			.pin_1V_o(sig_1V_o), 
			.pin_2V_o(sig_2V_o), 
			.pin_4V_o(sig_4V_o), 
			.pin_8V_o(sig_8V_o), 
			.pin_S1H_o(sig_S1H_o), 
			.pin_S2H_o(sig_S2H_o),
			.pin_PIN40_o(sig_PIN40_o),
			.pin_PIN41_o(sig_PIN41_o)
		);

	initial begin
		// Initialize Inputs
		sig_48M_i = 1'b0;
		sig_6M_IN_i = 1'b0;
		sig_bHRES_IN_i = 1'b1;
		sig_bVRES_IN_i = 1'b1;

		// Wait 100 ns for global reset to finish
		#10;
		  
		// Add stimulus here
		
		#800;
		
		/*#800;
		
		sig_bHRES_IN_i = 1'b0;
		
		#100;
		
		sig_bHRES_IN_i = 1'b1;
		
		#100;
		
		sig_bVRES_IN_i = 1'b0;
		
		#100;
		
		sig_bVRES_IN_i = 1'b1;
		
		#800;*/
		
		$finish;

	end
	
	//always @(negedge sig_bHSYNC_o) begin
	//	if (sig_8V_o)
	//		$stop;
	//end
    
	always begin
		//#10.1725 sig_48M_i = ~sig_48M_i;
		#25 sig_48M_i = ~sig_48M_i;
		#10 sig_6M_IN_i = sig_6M_OUT_o;
	end
      
endmodule

