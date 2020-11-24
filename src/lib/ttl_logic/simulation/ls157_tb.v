`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:21:25 11/24/2020
// Design Name:   ls157
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/ttl_logic/simulation/ls157_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls157
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`include "test_bench/assert.vh"

module ls157_tb;

	// Inputs
	reg nG;
	reg nSELA;
	reg A1;
	reg A2;
	reg A3;
	reg A4;
	reg B1;
	reg B2;
	reg B3;
	reg B4;

	// Outputs
	wire Y1;
	wire Y2;
	wire Y3;
	wire Y4;

	// Instantiate the Unit Under Test (UUT)
	ls157 uut (
		.nG(nG), 
		.nSELA(nSELA), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.A4(A4), 
		.B1(B1), 
		.B2(B2), 
		.B3(B3), 
		.B4(B4), 
		.Y1(Y1), 
		.Y2(Y2), 
		.Y3(Y3), 
		.Y4(Y4)
	);

	initial begin
		// Initialize Inputs
		nG = 1;
		nSELA = 0;
		A1 = 0;
		A2 = 0;
		A3 = 0;
		A4 = 0;
		B1 = 0;
		B2 = 0;
		B3 = 0;
		B4 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		`ASSERT_EQUAL(0, Y1)
		`ASSERT_EQUAL(0, Y2)
		`ASSERT_EQUAL(0, Y3)
		`ASSERT_EQUAL(0, Y4)
		
		A1 = 1;
		A2 = 0;
		A3 = 1;
		A4 = 0;
		B1 = 0;
		B2 = 1;
		B3 = 0;
		B4 = 1;
		#10
		
		`ASSERT_EQUAL(0, Y1)
		`ASSERT_EQUAL(0, Y2)
		`ASSERT_EQUAL(0, Y3)
		`ASSERT_EQUAL(0, Y4)
		
		nSELA = 1;
		#10
		
		`ASSERT_EQUAL(0, Y1)
		`ASSERT_EQUAL(0, Y2)
		`ASSERT_EQUAL(0, Y3)
		`ASSERT_EQUAL(0, Y4)
		
		// Enable active
		nG = 0;
		nSELA = 0;
		#10
		
		`ASSERT_EQUAL(1, Y1)
		`ASSERT_EQUAL(0, Y2)
		`ASSERT_EQUAL(1, Y3)
		`ASSERT_EQUAL(0, Y4)
		
		nSELA = 1;
		#10
		
		`ASSERT_EQUAL(0, Y1)
		`ASSERT_EQUAL(1, Y2)
		`ASSERT_EQUAL(0, Y3)
		`ASSERT_EQUAL(1, Y4)
		
		A1 = 0;
		A2 = 1;
		A3 = 0;
		A4 = 1;
		B1 = 1;
		B2 = 0;
		B3 = 1;
		B4 = 0;
		#10
		
		`ASSERT_EQUAL(1, Y1)
		`ASSERT_EQUAL(0, Y2)
		`ASSERT_EQUAL(1, Y3)
		`ASSERT_EQUAL(0, Y4)
		
		nSELA = 0;
		#10
		
		`ASSERT_EQUAL(0, Y1)
		`ASSERT_EQUAL(1, Y2)
		`ASSERT_EQUAL(0, Y3)
		`ASSERT_EQUAL(1, Y4)
		
		nG = 1;
		#10
		
		`ASSERT_EQUAL(0, Y1)
		`ASSERT_EQUAL(0, Y2)
		`ASSERT_EQUAL(0, Y3)
		`ASSERT_EQUAL(0, Y4)
		
		$finish;
	end
      
endmodule

