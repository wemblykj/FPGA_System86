`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    18:27:25 05/30/2018
// Design Name:    tilegen_tb
// Module Name:    system86/simulation/test_bench/tilegen_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TILEGEN
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module timing_subsystem_tb;

	reg _rst_n;

	reg sig_48M;

	wire sig_24M;
	wire sig_12M;
	wire sig_6M;
	wire sig_6MD;
	wire sig_X6M;
	wire sig_X24M;
	
	wire sig_1H;
	wire sig_b1H;
	wire sig_2H;
	wire sig_4H;

	wire sig_1V;
	wire sig_2V;
	wire sig_4V;
	wire sig_8V;
	
	wire sig_S1H;
	wire sig_S2H;
	wire sig_bS1H;
		
	wire sig_bHSYNC;
	wire sig_bVSYNC;
	wire sig_bHBLANK;
	wire sig_bVBLANK;
	wire sig_HRESET;
	wire sig_VRESET;
	wire sig_bCOMPSYNC;
	wire sig_BLANKING;
	
	// Timing subsystem
	timing_subsystem timing(
	   ._rst_ni(_rst_n),
		.s86_48M_i(sig_48M),
		.s86_24M_o(sig_24M),
		.s86_12M_o(sig_12M),
		
		.s86_6M_o(sig_6M),
		.s86_6MD_o(sig_6MD),
		.s86_X24M_o(sig_X24M),
		.s86_X6M_o(sig_X6M),
		
		.s86_bHSYNC_o(sig_bHSYNC),
		.s86_bVSYNC_o(sig_bVSYNC),
		.s86_bHBLANK_o(sig_bHBLANK),
		.s86_bHRESET_o(sig_HRESET),
		.s86_bVBLANK_o(sig_bVBLANK),
		.s86_bVRESET_o(sig_VRESET),
		.s86_bCOMPSYNC_o(sig_bCOMPSYNC),
		.s86_BLANKING_o(sig_BLANKING),
		.s86_1H_o(sig_1H),
		.s86_b1H_o(sig_b1H),
		.s86_2H_o(sig_2H),
		.s86_4H_o(sig_4H),
		.s86_1V_o(sig_1V),
		.s86_2V_o(sig_2V),
		.s86_4V_o(sig_4V),
		.s86_8V_o(sig_8V),
		.s86_S1H_o(sig_S1H),
		.s86_bS1H_o(sig_bS1H),
		.s86_S2H_o(sig_S2H)
	);

	initial begin
		_rst_n = 0;
		sig_48M = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_n = 1;
	end
	
	always @(negedge sig_bHSYNC) begin
		if (sig_8V)
			$stop;
	end
    
	always begin
		#10.1725 sig_48M = ~sig_48M;
	end
	
endmodule

