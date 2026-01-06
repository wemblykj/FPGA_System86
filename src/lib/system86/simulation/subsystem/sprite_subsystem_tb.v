`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:17:03 11/25/2020
// Design Name:   sprite_subsystem
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/system86/simulation/subsystem/sprite_subsystem_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sprite_subsystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`include "ttl_mem/cy6264.vh"
`include "ttl_mem/m58725.vh"

`include "ttl_mem/ttl_mem.vh"

`include "test_bench/assert.vh"

module sprite_subsystem_tb;


	// Inputs
	reg rst;
	reg s86_6M;
	
	reg s86_1H;
	reg nOBJECT;
	reg bHSYNC;
	reg nVRESET;
	reg [12:0] A;
	wire [7:0] D;
	reg s86_RbW;

	`SRAM_WIRE_DEFS(CY6264, sram_10m);
	`SRAM_WIRE_DEFS(M58725, sram_11k);
			
	// Instantiate the Unit Under Test (UUT)
	sprite_subsystem uut (
		.rst(rst), 
		.s86_6M(s86_6M), 
		.s86_1H(s86_1H), 
		.nOBJECT(nOBJECT), 
		.bHSYNC(bHSYNC), 
		.nVRESET(nVRESET), 
		.A(A), 
		.D(D), 
		.s86_RbW(s86_RbW),
		
		`SRAM_CONNECTION_DEFS(sram_10m, sram_10m),
		`SRAM_CONNECTION_DEFS(sram_11k, sram_11k)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		
		s86_6M = 0;
		s86_1H = 0;
		nOBJECT = 1;
		bHSYNC = 1;
		nVRESET = 1;
		A = 'h0000;
		s86_RbW = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		
		// Add stimulus here
		
		// test 0h1fff with 1H low
		A = 'h0000;
		s86_1H = 0;
		
		// CUS35 enable read
		nOBJECT = 0;
		
		#10
		//`ASSERT_EQUAL(0, sram_10m_oe_n)
		`ASSERT_EQUAL(1, sram_10m_we_n)
		`ASSERT_EQUAL('h0000, sram_10m_addr)
		`ASSERT_EQUAL(8'b01011010, D)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		
		#990
		nOBJECT = 1;
		#1000
		
		// CUS35 enable write
		nOBJECT = 0;
		#200
		s86_RbW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h0000, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		s86_RbW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		// test h0000 with 1H high
		s86_1H = 1;
		
		// CUS35 enable read
		nOBJECT = 0;
		
		#10
		//`ASSERT_EQUAL(0, sram_10m_oe_n)
		`ASSERT_EQUAL(1, sram_10m_we_n)
		`ASSERT_EQUAL('h1800, sram_10m_addr)
		`ASSERT_EQUAL(8'b01011010, D)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		
		#990
		nOBJECT = 1;
		#1000
		
		// CUS35 enable write
		nOBJECT = 0;
		#200
		s86_RbW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h1800, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		s86_RbW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		// test 0h1fff with 1H low
		A = 'h1fff;
		s86_1H = 0;
		
		// CUS35 enable read
		nOBJECT = 0;
		
		#10
		//`ASSERT_EQUAL(0, sram_10m_oe_n)
		`ASSERT_EQUAL(1, sram_10m_we_n)
		`ASSERT_EQUAL('h1fff, sram_10m_addr)
		`ASSERT_EQUAL(8'b01011010, D)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		
		#990
		nOBJECT = 1;
		#1000
		
		// CUS35 enable write
		nOBJECT = 0;
		#200
		s86_RbW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h1fff, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		s86_RbW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		// test h1fff with 1H high
		A = 'h1fff;
		s86_1H = 1;
		
		// CUS35 enable read
		nOBJECT = 0;
		
		#10
		//`ASSERT_EQUAL(0, sram_10m_oe_n)
		`ASSERT_EQUAL(1, sram_10m_we_n)
		`ASSERT_EQUAL('h1fff, sram_10m_addr)
		`ASSERT_EQUAL(8'b01011010, D)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		
		#990
		nOBJECT = 1;
		#1000
		
		// CUS35 enable write
		nOBJECT = 0;
		#200
		s86_RbW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h1fff, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		s86_RbW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		$finish;
	end
      
	assign D = ~s86_RbW ? 8'b10100101 : 8'bz;
	assign sram_10m_data = s86_RbW ? 8'b01011010 : 8'bz;
	
	// generate our 6.14025Mhz input clock
	always #81.4299 s86_6M = ~s86_6M; 
	
endmodule

