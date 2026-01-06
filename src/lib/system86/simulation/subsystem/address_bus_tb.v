`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:56:26 11/19/2020
// Design Name:   address_bus
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/system86/simulation/subsystem/address_bus_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: address_bus
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module address_bus_tb;

	reg _rst_n;
	reg clk_48m;
	
	// CUS27 outputs
	wire s86_6M;
	wire s86_2H;
	wire s86_S2H;
	wire s86_1H;
	
	// Inputs
	reg [12:0] MA;
	reg Ms86_RbW;
	reg nMBUFEN;
	reg nMLTH0;
	reg nMLTH1;
	reg [12:0] SA;
	reg Ss86_RbW;
	reg nSBUFEN;
	reg nSLTH0;
	reg nSLTH1;

	// Outputs
	wire [12:0] A;
	wire bWE;
	wire nLATCH0;
	wire nLATCH1;

	// Instantiate the Unit Under Test (UUT)
	address_bus uut (
		._rst_n(_rst_n), 
		.s86_2H(s86_2H), 
		.s86_S2H(s86_S2H), 
		.s86_1H(s86_1H), 
		.MA(MA), 
		.Ms86_RbW(Ms86_RbW), 
		.nMBUFEN(nMBUFEN), 
		.nMLTH0(nMLTH0), 
		.nMLTH1(nMLTH1), 
		.SA(SA), 
		.Ss86_RbW(Ss86_RbW), 
		.nSBUFEN(nSBUFEN), 
		.nSLTH0(nSLTH0), 
		.nSLTH1(nSLTH1), 
		.A(A), 
		.bWE(bWE), 
		.nLATCH0(nLATCH0), 
		.nLATCH1(nLATCH1)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			._rst_n(_rst_n),
			.CLK_48M(clk_48m), 
			.s86_6M_IN(s86_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			.s86_6M(s86_6M),
			//.bVSYNC(bVSYNC),
			//.bHSYNC(bHSYNC),
			//.bHBLANK(bHBLANK),
			//.bVBLANK(bVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			.s86_2H(s86_2H),
			.s86_1H(s86_1H),
			.s86_S2H(s86_S2H)
			//.s86_S1H(s86_S1H)
		);
	
	initial begin
		clk_48m = 0;
		_rst_n = 0;
		
		// Initialize Inputs
		MA = 0;
		Ms86_RbW = 1;
		nMBUFEN = 1;
		nMLTH0 = 1;
		nMLTH1 = 1;
		SA = 0;
		Ss86_RbW = 1;
		nSBUFEN = 1;
		nSLTH0 = 1;
		nSLTH1 = 1;
		
		// Wait 100 ns for global reset to finish
		#100;
      _rst_n = 1;
		
		#1000;
		
		// Add stimulus here
		MA = 'h0140;
		#1000;
		SA = 'h0280;
		#1000;
		
		nMLTH0 = 0;
		#100;
		Ms86_RbW = 0;
		#3800;
		nMLTH0 = 1;
		Ms86_RbW = 1;
		#100;
		
		nMBUFEN = 0;
		#100;
		nMLTH0 = 0;
		#100;
		Ms86_RbW = 0;
		#3600;
		nMLTH0 = 1;
		Ms86_RbW = 1;
		#100;
		nMBUFEN = 1;
		#100;
		
		nSLTH0 = 0;
		#100;
		Ss86_RbW = 0;
		#3800;
		nSLTH0 = 1;
		Ss86_RbW = 1;
		#100;
		
		nSBUFEN = 0;
		#100;
		nSLTH0 = 0;
		#100;
		Ss86_RbW = 0;
		#3600;
		nSLTH0 = 1;
		Ss86_RbW = 1;
		#100;
		nSBUFEN = 1;
		#100;
		
		nMBUFEN = 0;
		nSBUFEN = 0;
		#100;
		nMLTH0 = 0;
		nSLTH1 = 0;
		#100;
		Ms86_RbW = 0;
		Ss86_RbW = 1;
		#3600;
		nMLTH0 = 1;
		Ms86_RbW = 1;
		nSLTH1 = 1;
		Ss86_RbW = 1;
		#100;
		nMBUFEN = 1;
		nSBUFEN = 1;
		#100;
		
		$finish();
	end
      
	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;

endmodule

