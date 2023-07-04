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

	reg clk_in;
	reg rst_n;

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire CLK_6M;
	
	wire _1H;
	wire _2H;
	wire _4H;

	wire _1V;
	//wire CLK_2V;
	wire _4V;
	
	wire n1H;
	wire S1H;
	wire S2H;
	wire nS1H;
		
	wire nHSYNC;
	wire nVSYNC;
	wire nHBLANK;
	wire nVBLANK;
	
	wire nVRESET;
	wire nCOMPSYNC;
	
	// Timing subsystem
	timing_subsystem timing(
	   .rst_n(rst_n),
		.CLK_48M(clk_in),
		.CLK_6M(CLK_6M),
		.nHSYNC(nHSYNC),
		.nVSYNC(nVSYNC),
		.nHBLANK(nHBLANK),
		.nVBLANK(nVBLANK),
		.nVRESET(nVRESET),
		.nCOMPSYNC(nCOMPSYNC),
		._1H(_1H),
		.n1H(n1H),
		._2H(_2H),
		._4H(_4H),
		._1V(_1V),
		//.CLK_2V(_2V),
		._4V(_4V),
		._8V(_8V),
		.S1H(S1H),
		.nS1H(nS1H),
		.S2H(S2H)
	);

	initial begin
		rst_n = 0;
		clk_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		rst_n = 1;
	end
	
	always @(negedge nHSYNC) begin
		if (_1V && _4V && _8V)
			$stop;
	end
    
	always begin
		#10.1725 clk_in = ~clk_in;
	end
	
endmodule

