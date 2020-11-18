`timescale 1ns/1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:10:11 11/17/2020
// Design Name:   cus47
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/system86/simulation/custom/cus47_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus47
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus47_tb;

	reg rst;
	reg clk_48m;

	// CUS27 outputs
	wire CLK_S2H;
	wire CLK_6M;
	wire nVBLANK;
	
	// Inputs
	//reg rst;
	//reg CLK_6M;
	//reg CLK_2H;
	//reg nVBLK;
	reg nWE;
	reg [15:10] A;

	// Outputs
	wire nRES;
	wire MQ;
	wire ME;
	wire SUBE;
	wire SUBQ;
	wire nIRQ;
	wire nLTH2;
	wire nLTH0;
	wire nLTH1;
	wire nSCR0;
	wire nSCR1;
	wire nSND;
	wire nOBJ;
	wire nBUFEN;
	wire BANK;
	wire nSPGM;
	wire nMPGM;

	// Instantiate the Unit Under Test (UUT)
	cus47 uut (
		.rst(rst), 
		.CLK_6M(CLK_6M), 
		.CLK_2H(CLK_S2H), 
		.nVBLK(nVBLK), 
		.nWE(nWE), 
		.A(A), 
		.nRES(nRES), 
		.MQ(MQ), 
		.ME(ME), 
		.SUBE(SUBE), 
		.SUBQ(SUBQ), 
		.nIRQ(nIRQ), 
		.nLTH2(nLTH2), 
		.nLTH0(nLTH0), 
		.nLTH1(nLTH1), 
		.nSCR0(nSCR0), 
		.nSCR1(nSCR1), 
		.nSND(nSND), 
		.nOBJ(nOBJ), 
		.nBUFEN(nBUFEN), 
		.BANK(BANK), 
		.nSPGM(nSPGM), 
		.nMPGM(nMPGM)
	);

// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			.rst(rst),
			.CLK_48M(clk_48m), 
			.CLK_6M_IN(CLK_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			.CLK_6M(CLK_6M),
			//.nVSYNC(nVSYNC),
			//.nHSYNC(nHSYNC),
			//.nHBLANK(nHBLANK),
			.nVBLANK(nVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			//.CLK_2H(CLK_2H),
			//.CLK_1H(CLK_1H),
			.CLK_S2H(CLK_S2H)
			//.CLK_S1H(CLK_S1H)
		);
	
	initial begin
		clk_48m = 0;
		rst = 0;
		
		// Initialize Inputs
		//nVBLK = 0;
		nWE = 0;
		A = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
	end
      
	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;    
	
endmodule

