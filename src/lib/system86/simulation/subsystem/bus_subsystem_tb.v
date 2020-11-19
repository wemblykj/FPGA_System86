`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:56:26 11/19/2020
// Design Name:   bus_subsystem
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/system86/simulation/subsystem/bus_subsystem_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bus_subsystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bus_subsystem_tb;

	reg rst;
	reg clk_48m;

	// CUS27 outputs
	wire CLK_6M;
	wire CLK_2H;
	wire CLK_S2H;
	wire CLK_1H;
	
	// Inputs
	reg [12:0] MA;
	reg MRnW;
	reg nMBUFEN;
	reg nMLTH0;
	reg nMLTH1;
	reg [12:0] SA;
	reg SRnW;
	reg nSBUFEN;
	reg nSLTH0;
	reg nSLTH1;

	// Outputs
	wire [12:0] A;
	wire nWE;
	wire nLATCH0;
	wire nLATCH1;

	// Bidirs
	wire [7:0] MD;
	wire [7:0] SD;
	wire [7:0] D;

	// Instantiate the Unit Under Test (UUT)
	bus_subsystem uut (
		.rst(rst), 
		.CLK_2H(CLK_2H), 
		.CLK_S2H(CLK_S2H), 
		.CLK_1H(CLK_1H), 
		.MA(MA), 
		.MD(MD), 
		.MRnW(MRnW), 
		.nMBUFEN(nMBUFEN), 
		.nMLTH0(nMLTH0), 
		.nMLTH1(nMLTH1), 
		.SA(SA), 
		.SD(SD), 
		.SRnW(SRnW), 
		.nSBUFEN(nSBUFEN), 
		.nSLTH0(nSLTH0), 
		.nSLTH1(nSLTH1), 
		.A(A), 
		.D(D), 
		.nWE(nWE), 
		.nLATCH0(nLATCH0), 
		.nLATCH1(nLATCH1)
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
			//.nVBLANK(nVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			.CLK_2H(CLK_2H),
			.CLK_1H(CLK_1H),
			.CLK_S2H(CLK_S2H)
			//.CLK_S1H(CLK_S1H)
		);
		
	initial begin
		clk_48m = 0;
		rst = 0;
		
		// Initialize Inputs
		MA = 0;
		MRnW = 0;
		nMBUFEN = 0;
		nMLTH0 = 0;
		nMLTH1 = 0;
		SA = 0;
		SRnW = 0;
		nSBUFEN = 0;
		nSLTH0 = 0;
		nSLTH1 = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		
		// Add stimulus here

	end
      
endmodule

