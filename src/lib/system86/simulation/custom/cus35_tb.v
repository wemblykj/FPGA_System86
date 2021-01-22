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

`include "test_bench/assert.vh"

module cus35_tb;

	// Inputs
	reg rst;
	reg CLK_6M;
	
	reg nVRES;
	reg nHSYNC;
	reg nOCS;
	reg RnW;
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
	wire nCS0;
	wire nCS1;
	wire nROE;
	wire nRWE;

	// Bidirs
	wire [7:0] D;
	wire [7:0] B0;
	wire [7:0] B1;
	
	// Instantiate the Unit Under Test (UUT)
	cus35 uut (
		.rst(rst),
		.CLK_6M(CLK_6M), 
		.nVRES(nVRES), 
		.nHSYNC(nHSYNC), 
		.nOCS(nOCS), 
		.RnW(RnW), 
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
		.nCS0(nCS0), 
		.nCS1(nCS1), 
		.nROE(nROE), 
		.nRWE(nRWE), 
		.B0(B0),
		.B1(B1)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			.rst(rst),
			//.CLK_48M(clk_48m), 
			.CLK_6M_IN(CLK_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			//.CLK_6M(CLK_6M),
			//.nVSYNC(nVSYNC),
			//.nHSYNC(nHSYNC),
			//.nHBLANK(nHBLANK),
			//.nVBLANK(nVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			//.CLK_2H(CLK_2H),
			//.CLK_1H(CLK_1H),
			.CLK_S2H(CLK_S2H)
			//.CLK_S1H(CLK_S1H)
		);
		
	initial begin
		rst = 0;
		
		// Initialize Inputs
		CLK_6M = 0;
		nOCS = 1;
		nHSYNC = 1;
		nVRES = 1;
		A = 'hffff;
		RnW = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		
		// Add stimulus here
		#1000
		
		// CUS35 enable read
		nOCS = 0;
		#10
		`ASSERT_EQUAL(8'b01011010, B0)
		#990
		nOCS = 1;
		#1000
		
		// CUS35 enable write
		nOCS = 0;
		#200
		RnW = 0;
		#10
		`ASSERT_EQUAL(8'b10100101, D)
		#390 
		RnW = 1;
		#200
		nOCS = 1;
		#1000
		
		$finish;
	end
      
	assign D = ~RnW ? 8'b10100101 : 8'bz;
	assign B0 = RnW ? 8'b01011010 : 8'bz;

	// generate our 6.14025Mhz input clock
	always #81.4299 CLK_6M = ~CLK_6M;
	
endmodule

