`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:25:19 11/23/2020
// Design Name:   ls175
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/ttl_logic/simulation/ls175_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls175
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`include "test_bench/assert.vh"

module ls175_tb;

	// Inputs
	reg CLK;
	reg nCLR;
	reg D1;
	reg D2;
	reg D3;
	reg D4;

	// Outputs
	wire Q1;
	wire Q1_L;
	wire Q2;
	wire Q2_L;
	wire Q3;
	wire Q3_L;
	wire Q4;
	wire Q4_L;

	// Instantiate the Unit Under Test (UUT)
	ls175 uut (
		.CLK(CLK), 
		.nCLR(nCLR), 
		.D1(D1), 
		.D2(D2), 
		.D3(D3), 
		.D4(D4), 
		.Q1(Q1), 
		.Q1_L(Q1_L), 
		.Q2(Q2), 
		.Q2_L(Q2_L), 
		.Q3(Q3), 
		.Q3_L(Q3_L), 
		.Q4(Q4), 
		.Q4_L(Q4_L)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		nCLR = 0;
		D1 = 0;
		D2 = 0;
		D3 = 0;
		D4 = 0;

		// Wait 100 ns for global reset to finish
		#100;
      nCLR <= 1;
		#10
		
		// Add stimulus here
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		D1 <= 1;
		D2 <= 0;
		D3 <= 1;
		D4 <= 0;
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		CLK <= 0;
		#10
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		CLK <= 1;
		#10
		
		`ASSERT_EQUAL(1, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(1, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		D1 <= 0;
		D2 <= 1;
		D3 <= 0;
		D4 <= 1;
		
		CLK <= 0;
		#10
		
		`ASSERT_EQUAL(1, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(1, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		CLK <= 1;
		#10
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(1, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(1, Q4)
		
		nCLR <= 0;
		#10
		
		D1 <= 1;
		D2 <= 1;
		D3 <= 1;
		D4 <= 1;
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		CLK <= 0;
		#10
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		CLK <= 1;
		#10
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		nCLR <= 1;
		#10
		
		CLK <= 0;
		#10
		
		`ASSERT_EQUAL(0, Q1)
		`ASSERT_EQUAL(0, Q2)
		`ASSERT_EQUAL(0, Q3)
		`ASSERT_EQUAL(0, Q4)
		
		CLK <= 1;
		#10
		
		`ASSERT_EQUAL(1, Q1)
		`ASSERT_EQUAL(1, Q2)
		`ASSERT_EQUAL(1, Q3)
		`ASSERT_EQUAL(1, Q4)
		
		$finish();
	end
      
	
endmodule

