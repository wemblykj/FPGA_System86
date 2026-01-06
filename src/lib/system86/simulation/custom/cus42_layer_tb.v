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
	reg _rst_n;
	reg s86_6M;
	reg FLIP;
	reg nLATCH;
	reg [2:0] CA;
	reg [7:0] CD;
	wire [7:0] RD;
	wire bHSYNC;
	wire bVSYNC;

	// Outputs
	wire [11:0] RA;
	wire [13:0] GA;
	wire S3H;

	`SRAM_WIRE_DEFS(CY6264, sram_7n);
	
	// Instantiate the Unit Under Test (UUT)
	cus42_layer uut (
		._rst_n(_rst_n), 
		.s86_6M(s86_6M), 
		.FLIP(FLIP), 
		.nLATCH(nLATCH), 
		.CA(CA), 
		.CD(CD), 
		.RD(RD), 
		.bHSYNC(bHSYNC), 
		.bVSYNC(bVSYNC), 
		.RA(RA), 
		.GA(GA), 
		.S3H(S3H)
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
			.bHSYNC(bHSYNC)
			//.bHBLANK(bHBLANK),
			//.bVBLANK(bVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			//.s86_2H(s86_2H),
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
	assign sram_7n_oe_n = 0;
	assign sram_7n_we_n = 1;
	assign sram_7n_addr = RA;
	assign RD = sram_7n_data;
	
	initial begin
		// Initialize Inputs
		_rst_n = 0;
		s86_6M = 0;
		FLIP = 0;
		nLATCH = 0;
		CA = 0;
		CD = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      _rst_n = 1;
		
		// Add stimulus here

	end
      
	// generate our 6.14025Mhz input clock
	always #81.3802084 s86_6M = ~s86_6M;
	
endmodule

