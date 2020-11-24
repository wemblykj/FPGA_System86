`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:22:05 11/24/2020
// Design Name:   ls245
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/ttl_logic/simulation/ls245_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls245
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`include "test_bench/assert.vh"

module ls245_tb;

	reg [7:0] A_data = 'b10100101;
	reg [7:0] B_data = 'b01010010;
	reg drive_a = 0;
	reg drive_b = 0;
	
	// Inputs
	reg DIR;
	reg nOE;

	// Bidirs
	wire [7:0] A;
	wire [7:0] B;

	// Instantiate the Unit Under Test (UUT)
	ls245 uut (
		.DIR(DIR), 
		.nOE(nOE), 
		.A(A), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		DIR = 0;
		nOE = 1;
		drive_a = 0;
		drive_b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		`ASSERT_EQUAL(8'bz, A)
		`ASSERT_EQUAL(8'bz, B)
		
		drive_a = 1;
		drive_b = 0;
		#10
		
		`ASSERT_EQUAL(8'bz, B)
		
		drive_a = 0;
		drive_b = 1;
		#10
		
		`ASSERT_EQUAL(8'bz, A)
		
		drive_a = 0;
		drive_b = 0;
		
		DIR = 1;
		#10
		
		`ASSERT_EQUAL(8'bz, A)
		`ASSERT_EQUAL(8'bz, B)
		
		#10
		
		`ASSERT_EQUAL(8'bz, A)
		`ASSERT_EQUAL(8'bz, B)
		
		// enable output
		nOE = 0;
		
		DIR = 1;	// A data to B bus
		
		drive_a = 1;
		drive_b = 0;
		#10
		
		`ASSERT_EQUAL(A_data, B)
		
		
		drive_a = 0;
		#10
		
		`ASSERT_EQUAL(8'bz, A)
	
		DIR = 0;	// B data to A bus
		
		drive_b = 1;
		drive_a = 0;
		#10
		
		`ASSERT_EQUAL(B_data, A)
		
		
		drive_b = 0;
		#10
		
		`ASSERT_EQUAL(8'bz, A)
		
		$finish;
	end
      
	assign A = drive_a ? A_data : 8'bz;
	assign B = drive_b ? B_data : 8'bz;
endmodule

