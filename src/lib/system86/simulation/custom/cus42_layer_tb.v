`timescale 1ns / 1ps

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

module cus42_layer_tb;

	// Inputs
	reg rst;
	reg CLK_6M;
	reg FLIP;
	reg nLATCH;
	reg [2:0] CA;
	reg [7:0] CD;
	reg [7:0] RD;
	wire nHSYNC;
	wire nVSYNC;

	// Outputs
	wire [11:0] RA;
	wire [13:0] GA;
	wire S3H;

	// Instantiate the Unit Under Test (UUT)
	cus42_layer uut (
		.rst(rst), 
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
			.rst(rst),
			//.CLK_48M(clk_48m), 
			//.CLK_6M_IN(CLK_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			.CLK_6M(CLK_6M),
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
		
	initial begin
		// Initialize Inputs
		rst = 0;
		CLK_6M = 0;
		FLIP = 0;
		nLATCH = 0;
		CA = 0;
		CD = 0;
		RD = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	// generate our 6.14025Mhz input clock
	always #81.4299 CLK_6M = ~CLK_6M;
	
endmodule

