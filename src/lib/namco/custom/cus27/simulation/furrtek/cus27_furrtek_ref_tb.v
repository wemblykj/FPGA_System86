`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:      Paul Wightmore
//
// Create Date:   January 2026
// Design Name:   furrtek_cus27_ref_tb
// Module Name:   furrtek_cus27_ref_tb.v
// Project Name:  Namco Custom Chips
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

module furrtek_cus27_ref_tb;

	parameter CLOCK_FREQ_MHZ = 49.152;
	parameter CLOCK_PERIOD_NS = 1000.0 / CLOCK_FREQ_MHZ;
	parameter CLOCK_HALF_PERIOD_NS = CLOCK_PERIOD_NS / 2.0;
	
	parameter IOB_INPUT_INVERSION = 1'b1;
	parameter IOB_OUTPUT_INVERSION = 1'b1;
	
	reg sim_rst_n;
	
	// Inputs
	reg opt_OTEN_i;
	reg opt_FLIP_i;
	reg opt_MODE0_i;
	reg opt_MODE1_i;
	reg sig_48M_i;
	reg sig_6M_IN_i;
	//reg sig_bHRES_IN_i;
	//reg sig_bVRES_IN_i;
	wire sig_bHRES_IN_i = dir_HRES_o ? 1'bz : 1'b0;
	wire sig_bVRES_IN_i = dir_VRES_o ? 1'bz : 1'b0;
	
	// Outputs
	wire sig_24M_o;
	wire sig_12M_o;
	wire sig_6M_OUT_o;
	
	wire sig_bHSYNC_o;
	wire sig_bHBLANK_o;
	wire sig_bHRES_o;
	wire dir_HRES_o;
	
	wire sig_bVSYNC_o;
	wire sig_bVBLANK_o;
	wire sig_bVRES_o;
	wire dir_VRES_o;
		
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
	wire sig_A0_o;
	wire sig_A1_o;
	wire sig_A2_o;
	wire sig_A3_o;
	wire sig_A4_o;
	wire sig_A5_o;
	wire sig_A6_o;
	wire sig_A7_o;
	wire sig_A8_o;
	wire sig_A9_o;
	wire sig_A10_o;
	wire sig_PIN40_o;
	wire sig_PIN41_o;

	//assign #1 sig_6M_IN_i = sig_6M_OUT_o;
	
	// Instantiate the Unit Under Test (UUT)
	cus27_furrtek_ref #(	
			IOB_INPUT_INVERSION,
			IOB_OUTPUT_INVERSION )
		uut ( 
			.sim_rst_n(sim_rst_n),
			.pin_48M_i(sig_48M_i), 
			.pin_OTEN_i(opt_OTEN_i),
			.pin_FLIP_i(opt_FLIP_i),
			.pin_MODE0_i(opt_MODE0_i),
			.pin_MODE1_i(opt_MODE1_i),
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
			.pin_bHRES_o(sig_bHRES_o), 
			.dir_HRES_o(dir_HRES_o),
			.pin_bVRES_o(sig_bVRES_o), 
			.dir_VRES_o(dir_VRES_o),
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
			.pin_A0_o(sig_A0_o),
			.pin_A1_o(sig_A1_o),
			.pin_A2_o(sig_A2_o),
			.pin_A3_o(sig_A3_o),
			.pin_A4_o(sig_A4_o),
			.pin_A5_o(sig_A5_o),
			.pin_A6_o(sig_A6_o),
			.pin_A7_o(sig_A7_o),
			.pin_A8_o(sig_A8_o),
			.pin_A9_o(sig_A9_o),
			.pin_A10_o(sig_A10_o),
			.pin_PIN40_o(sig_PIN40_o),
			.pin_PIN41_o(sig_PIN41_o)
		);

	initial begin
		// Initialize Inputs
		opt_OTEN_i = 1'b1;
		opt_FLIP_i = 1'b0;
		opt_MODE0_i = 1'b0;
		opt_MODE1_i = 1'b0;
		sig_48M_i = 1'b0;
		sig_6M_IN_i = 1'b0;

		sim_rst_n = 1'b0;
		
		// Wait for global reset to finish - sync'd to clock to avoid instabilities
		#(CLOCK_PERIOD_NS)
		#(CLOCK_PERIOD_NS)
		#(CLOCK_PERIOD_NS)
		 
		sim_rst_n = 1'b1;
		
		// Add stimulus here
		
		#8000;
		
		$finish;

	end
	
	always @(negedge sig_bVRES_o) begin
		$stop;
	end
    
	always @(posedge sig_48M_i) begin
		sig_6M_IN_i = sig_6M_OUT_o;
	end
	
	always begin
		#(CLOCK_HALF_PERIOD_NS) sig_48M_i = ~sig_48M_i;
	end
      
endmodule

