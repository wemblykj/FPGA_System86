`timescale 1ns / 1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:42:37 12/09/2020
// Design Name:   cus42_layer
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/system86/simulation/custom/cus42_layer_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus42_layer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`include "ttl_mem/cy6264.vh"

`include "ttl_mem/ttl_mem.vh"

module cus42_layer_tb;

	// Inputs
	reg rst_n;
	reg CLK_6M;
	reg FLIP;
	reg nLATCH;
	reg [2:0] CA;
	reg [7:0] CD;
	wire [7:0] RD;
	wire nHSYNC;
	wire nVSYNC;

	// Outputs
	wire [11:0] RA;
	wire [13:0] GA;
	wire S3H;

	`SRAM_WIRE_DEFS(CY6264, sram_7n);
	
	// Instantiate the Unit Under Test (UUT)
	cus42_layer uut (
		.rst_n(rst_n), 
		.CLK_6M(CLK_6M), 
		.FLIP(FLIP), 
		.nLATCH(nLATCH), 
		.CA(CA), 
		.CD(CD), 
		.RD(RD), 
		.nHSYNC(nHSYNC), 
		.nVSYNC(nVSYNC), 
		.RA(RA), 
		.GA(GA), 
		.S3H(S3H)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			.rst_n(rst_n),
			//.CLK_48M(clk_48m), 
			.CLK_6M_IN(CLK_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			//.CLK_6M(CLK_6M),
			.nVSYNC(nVSYNC),
			.nHSYNC(nHSYNC)
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
			//.CLK_S2H(CLK_S2H)
			//.CLK_S1H(CLK_S1H)
		);
	
	sram_cy6264 
		#(
			"../../../../../../../../snapshots/rthunder_gfx1_002.bin"
		)
		sram_7n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(sram_7n_we_n),
			.nOE(sram_7n_oe_n),
			.A(sram_7n_addr),
			.D(sram_7n_data),
			.data_valid(sram_7n_dv)
		);
	
	assign sram_7n_ce_n = 0;
	assign sram_7n_oe_n = 0;
	assign sram_7n_we_n = 1;
	assign sram_7n_addr = RA;
	assign RD = sram_7n_data;
	
	initial begin
		// Initialize Inputs
		rst_n = 0;
		CLK_6M = 0;
		FLIP = 0;
		nLATCH = 0;
		CA = 0;
		CD = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      rst_n = 1;
		
		// Add stimulus here

	end
      
	// generate our 6.14025Mhz input clock
	always #81.3802084 CLK_6M = ~CLK_6M;
	
endmodule

