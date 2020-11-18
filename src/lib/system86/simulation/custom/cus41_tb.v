`timescale 1ns/1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:23:35 11/17/2020
// Design Name:   cus41
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/system86/simulation/custom/cus41_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus41
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus41_tb;

	reg rst;
	reg clk_48m;

	// CUS27 outputs
	wire CLK_S2H;
	wire CLK_6M;
	wire nVBLANK;
	
	// Inputs
	reg [15:11] MA;
	reg nMWE;
	//reg nVBLA;
	//reg CLK_0;
	reg CLK_1;
	//reg CLK_6M;
	reg nSWE;
	reg SA15;
	reg SA14;
	reg SA13;
	reg SA12;
	reg SA11;

	// Outputs
	wire nMRESET;
	wire nSINT;
	wire nMINT;
	wire SROM;
	wire SCS4;
	wire SCS3;
	wire SCS2;
	wire SCS1;
	wire SCS0;
	wire Q;
	wire nLTH0;
	wire nLTH1;
	wire nSND;
	wire nMCS0;
	wire nMCS1;
	wire nMCS2;
	wire nMCS3;
	wire nMCS4;
	wire nMROM;

	// Instantiate the Unit Under Test (UUT)
	cus41 uut (
		.rst(rst), 
		.MA(MA), 
		.nMWE(nMWE), 
		.nVBLA(nVBLANK), 
		.CLK_0(~CLK_S2H), 
		.CLK_1(CLK_1), 
		.CLK_6M(CLK_6M), 
		.nSWE(nSWE), 
		.SA15(SA15), 
		.SA14(SA14), 
		.SA13(SA13), 
		.SA12(SA12), 
		.SA11(SA11), 
		.nMRESET(nMRESET), 
		.nSINT(nSINT), 
		.nMINT(nMINT), 
		.SROM(SROM), 
		.SCS4(SCS4), 
		.SCS3(SCS3), 
		.SCS2(SCS2), 
		.SCS1(SCS1), 
		.SCS0(SCS0), 
		.Q(Q), 
		.nLTH0(nLTH0), 
		.nLTH1(nLTH1), 
		.nSND(nSND), 
		.nMCS0(nMCS0), 
		.nMCS1(nMCS1), 
		.nMCS2(nMCS2), 
		.nMCS3(nMCS3), 
		.nMCS4(nMCS4), 
		.nMROM(nMROM)
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
		
		MA = 0;
		nMWE = 0;
		//nVBLA = 0;
		//CLK_0 = 0;
		CLK_1 = 0;
		//CLK_6M = 0;
		nSWE = 0;
		SA15 = 0;
		SA14 = 0;
		SA13 = 0;
		SA12 = 0;
		SA11 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
	end

	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;
      
endmodule

