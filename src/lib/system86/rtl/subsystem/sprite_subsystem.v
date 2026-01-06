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
		input wire _rst_n,
	
		input wire s86_6M_i,
		input wire s86_1H_i,
		input wire s86_bOBJECT_i,
		input wire s86_bHSYNC_i,
		input wire s86_bVRESET_i,
		input wire [12:0] s86_A_i,
		inout wire [7:0] s86_D_io,
		input wire s86_RbW_i,
		
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
			._rst_n(_rst_n),
			
			// inputs
			.pin_6M_i(s86_6M_i), 
			.pin_bHSYNC_i(s86_bHSYNC_i),
			.pin_bVRES_i(s86_bVRESET_i),
			.pin_bOCS_i(s86_bOBJECT_i),
			.pin_RbW_i(s86_RbW_i),
			.pin_A_i(s86_A_i),
			.pin_D_io(s86_D_io),
			// outputs
			.pin_bCS0_o(cus35_9m_cs0_n),
			.pin_bCS1_o(cus35_9m_cs1_n),
			.pin_bRWE_o(cus35_9m_rwe_n),
			.pin_bROE_o(cus35_9m_roe_n),
			.pin_B0_io(cus35_9m_b0),
			.pin_B1_io(cus35_9m_b1)
		);
	
	wire ls32_6e_y3;
	wire ls32_6e_y4;
	
	ls32
		ls32_6e
		(
			.A3(s86_1H_i),		// pin 9
			.B3(s86_A_i[12]),			// pin 10
			.A4(s86_1H_i),		// pin 12
			.B4(s86_A_i[0]),			// pin 13
			.Y3(ls32_6e_y3),	// pin 8 - 10M A11
			.Y4(ls32_6e_y4)	// pin 11 - to 10M A12
		);

	// object ram
	assign sram_10m_ce_n = cus35_9m_cs1_n;
	assign sram_10m_we_n = cus35_9m_rwe_n;
	assign sram_10m_oe_n = cus35_9m_roe_n;
	assign sram_10m_addr = { ls32_6e_y4, ls32_6e_y3, s86_A_i[10:0] };
	assign sram_10m_data = ~s86_RbW_i ? cus35_9m_b1 : 8'bz;

	assign cus35_9m_b1 = s86_RbW_i ? sram_10m_data : 8'bz;		

	assign sram_11k_ce_n = cus35_9m_cs0_n;
	assign sram_11k_we_n = cus35_9m_rwe_n;
	assign sram_11k_oe_n = cus35_9m_roe_n;
	assign sram_11k_addr = { 1'b0, s86_A_i[11:1] };
	assign sram_11k_data = ~s86_RbW_i ? cus35_9m_b0 : 8'bz;
	
	assign cus35_9m_b0 = s86_RbW_i ? sram_11k_data : 8'bz;
	
endmodule
