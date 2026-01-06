`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:33:56 12/10/2020
// Design Name:   cus42
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/system86/simulation/custom/cus42_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus42
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

module cus42_tb;

	// Inputs
	reg _rst_n;
	reg s86_6M;
	wire s86_2H;
	wire bHSYNC;
	wire bVSYNC;
	reg nGCS;
	reg nRCS;
	reg nLATCH;
	reg FLIP;
	reg [13:0] CA;
	reg s86_RbW;

	// Outputs
	wire [13:0] GA;
	wire [12:0] RA;
	wire bRWE;
	wire bROE;
	wire HA2;
	wire HB2;

	// Bidirs
	wire [7:0] CD;
	wire [7:0] RD;

	`SRAM_WIRE_DEFS(CY6264, sram_7n);

	// Instantiate the Unit Under Test (UUT)
	cus42 uut (
		._rst_n(_rst_n), 
		.s86_6M(s86_6M), 
		.s86_2H(s86_2H), 
		.bHSYNC(bHSYNC), 
		.bVSYNC(bVSYNC), 
		.nGCS(nGCS), 
		.nRCS(nRCS), 
		.nLATCH(nLATCH), 
		.FLIP(FLIP), 
		.CA(CA), 
		.s86_RbW(s86_RbW), 
		.CD(CD), 
		.RD(RD), 
		.GA(GA), 
		.RA(RA), 
		.bRWE(bRWE), 
		.bROE(bROE), 
		.HA2(HA2), 
		.HB2(HB2)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			._rst_n(_rst_n),
			//.CLK_48M(clk_48m), 
			.s86_6M_IN(s86_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			//.s86_6M(s86_6M),
			.bVSYNC(bVSYNC),
			.bHSYNC(bHSYNC),
			//.bHBLANK(bHBLANK),
			//.bVBLANK(bVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			.s86_2H(s86_2H)
			//.s86_1H(s86_1H),
			//.s86_S2H(s86_S2H)
			//.s86_S1H(s86_S1H)
		);
		
	sram_cy6264 
		#(
			"../../../../../../../../snapshots/rthunder_gfx1_002.bin"
		)
		sram_7n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_7n_we_n),
			.bOE(sram_7n_oe_n),
			.A(sram_7n_addr),
			.D(sram_7n_data),
			.data_valid(sram_7n_dv)
		);

	assign sram_7n_ce_n = 0;
	assign sram_7n_oe_n = bROE;
	assign sram_7n_we_n = bRWE;
	assign sram_7n_addr = RA;
	assign RD = sram_7n_data;
	
	initial begin
		// Initialize Inputs
		_rst_n = 0;
		s86_6M = 0;
		nGCS = 1;
		nRCS = 1;
		nLATCH = 1;
		FLIP = 0;
		CA = 0;
		s86_RbW = 1;

		// Wait 100 ns for global reset to finish
		#100;
		_rst_n = 1;
        
		// Add stimulus here

	end
      
	// generate our 6.14025Mhz input clock
	always #81.3802084 s86_6M = ~s86_6M;
	
endmodule

