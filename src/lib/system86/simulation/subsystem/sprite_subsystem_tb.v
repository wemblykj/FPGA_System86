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
	reg CLK_6M;
	
	reg CLK_1H;
	reg nOBJECT;
	reg nHSYNC;
	reg nVRESET;
	reg [12:0] A;
	wire [7:0] D;
	reg RnW;

	`SRAM_WIRE_DEFS(CY6264, sram_10m);
	`SRAM_WIRE_DEFS(M58725, sram_11k);
			
	// Instantiate the Unit Under Test (UUT)
	sprite_subsystem uut (
		.rst(rst), 
		.CLK_6M(CLK_6M), 
		.CLK_1H(CLK_1H), 
		.nOBJECT(nOBJECT), 
		.nHSYNC(nHSYNC), 
		.nVRESET(nVRESET), 
		.A(A), 
		.D(D), 
		.RnW(RnW),
		
		`SRAM_CONNECTION_DEFS(sram_10m, sram_10m),
		`SRAM_CONNECTION_DEFS(sram_11k, sram_11k)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		
		CLK_6M = 0;
		CLK_1H = 0;
		nOBJECT = 1;
		nHSYNC = 1;
		nVRESET = 1;
		A = 'h0000;
		RnW = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		
		// Add stimulus here
		
		// test 0h1fff with 1H low
		A = 'h0000;
		CLK_1H = 0;
		
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
		RnW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h0000, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		RnW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		// test h0000 with 1H high
		CLK_1H = 1;
		
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
		RnW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h1800, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		RnW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		// test 0h1fff with 1H low
		A = 'h1fff;
		CLK_1H = 0;
		
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
		RnW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h1fff, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		RnW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		// test h1fff with 1H high
		A = 'h1fff;
		CLK_1H = 1;
		
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
		RnW = 0;
		#10
		
		`ASSERT_EQUAL(0, sram_10m_ce_n)
		`ASSERT_EQUAL(1, sram_10m_oe_n)
		`ASSERT_EQUAL(0, sram_10m_we_n)
		`ASSERT_EQUAL('h1fff, sram_10m_addr)
		`ASSERT_EQUAL(8'b10100101, sram_10m_data)
		
		`ASSERT_EQUAL(1, sram_11k_ce_n)
		#390 
		RnW = 1;
		#200
		nOBJECT = 1;
		#1000
		
		$finish;
	end
      
	assign D = ~RnW ? 8'b10100101 : 8'bz;
	assign sram_10m_data = RnW ? 8'b01011010 : 8'bz;
	
	// generate our 6.14025Mhz input clock
	always #81.4299 CLK_6M = ~CLK_6M; 
	
endmodule

