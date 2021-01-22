`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:38:51 11/25/2020 
// Design Name: 
// Module Name:    sprite_subsystem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`include "ttl_mem/cy6264.vh"
`include "ttl_mem/m58725.vh"

`include "ttl_mem/ttl_mem.vh"

module sprite_subsystem(
		input wire rst_n,
	
		input wire CLK_6M,
		input wire CLK_1H,
		input wire nOBJECT,
		input wire nHSYNC,
		input wire nVRESET,
		input wire [12:0] A,
		inout wire [7:0] D,
		input wire RnW,
		
		`SRAM_OUTPUT_DEFS(CY6264, sram_10m),
		`SRAM_OUTPUT_DEFS(M58725, sram_11k)
    );

	wire cus35_9m_cs0_n;
	wire cus35_9m_cs1_n;
	wire cus35_9m_rwe_n;
	wire cus35_9m_roe_n;
	wire [7:0] cus35_9m_b0;
	wire [7:0] cus35_9m_b1;
	
	cus35
		cus35_9m
		(
			.rst_n(rst_n),
			
			// inputs
			.CLK_6M(CLK_6M), 
			.nHSYNC(nHSYNC),
			.nVRES(nVRESET),
			.nOCS(nOBJECT),
			.RnW(RnW),
			.A(A),
			.D(D),
			// outputs
			.nCS0(cus35_9m_cs0_n),
			.nCS1(cus35_9m_cs1_n),
			.nRWE(cus35_9m_rwe_n),
			.nROE(cus35_9m_roe_n),
			.B0(cus35_9m_b0),
			.B1(cus35_9m_b1)
		);
	
	wire ls32_6e_y3;
	wire ls32_6e_y4;
	
	ls32
		ls32_6e
		(
			.A3(CLK_1H),		// pin 9
			.B3(A[12]),			// pin 10
			.A4(CLK_1H),		// pin 12
			.B4(A[0]),			// pin 13
			.Y3(ls32_6e_y3),	// pin 8 - 10M A11
			.Y4(ls32_6e_y4)	// pin 11 - to 10M A12
		);

	// object ram
	assign sram_10m_ce_n = cus35_9m_cs1_n;
	assign sram_10m_we_n = cus35_9m_rwe_n;
	assign sram_10m_oe_n = cus35_9m_roe_n;
	assign sram_10m_addr = { ls32_6e_y4, ls32_6e_y3, A[10:0] };
	assign sram_10m_data = ~RnW ? cus35_9m_b1 : 8'bz;

	assign cus35_9m_b1 = RnW ? sram_10m_data : 8'bz;		

	assign sram_11k_ce_n = cus35_9m_cs0_n;
	assign sram_11k_we_n = cus35_9m_rwe_n;
	assign sram_11k_oe_n = cus35_9m_roe_n;
	assign sram_11k_addr = { 1'b0, A[11:1] };
	assign sram_11k_data = cus35_9m_b0;
	
	assign cus35_9m_b0 = RnW ? sram_11k_data : 8'bz;
	
endmodule
