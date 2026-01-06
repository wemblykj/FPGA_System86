`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:47:43 11/18/2020
// Design Name:   cpu_subsystem
// Module Name:   /home/administrator/Development/fpga/system86/src/lib/system86/simulation/subsystem/cpu_subsystem_tb.v
// Project Name:  system86
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu_subsystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_subsystem_tb;

reg rst;
	reg clk_48m;

	// CUS27 outputs
	wire s86_6M;
	wire s86_2H;
	wire s86_S2H;
	wire s86_1H;
	wire s86_S1H;
	wire bVBLANK;
	
	// Inputs
	//reg rst;
	//reg s86_6M;
	//reg s86_2H;
	//reg s86_S2H;
	//reg s86_1H;
	//reg s86_S1H;
	//reg bVBLANK;

	// Outputs
	wire bWE;
	wire nRESET;
	wire nSCROLL0;
	wire nSCROLL1;
	wire nOBJECT;
	wire nLATCH0;
	wire nLATCH1;
	wire nBACKCOLOR;
	wire [7:0] MD;

	// Bidirs
	wire [12:0] A;
	wire [7:0] D;

	// Instantiate the Unit Under Test (UUT)
	cpu_subsystem uut (
		.rst(rst), 
		.s86_6M(s86_6M), 
		.s86_2H(s86_2H), 
		.s86_S2H(s86_S2H), 
		.s86_1H(s86_1H), 
		.s86_S1H(s86_S1H), 
		.bVBLANK(bVBLANK), 
		.A(A), 
		.D(D), 
		.bWE(bWE), 
		.nRESET(nRESET), 
		.nSCROLL0(nSCROLL0), 
		.nSCROLL1(nSCROLL1), 
		.nOBJECT(nOBJECT), 
		.nLATCH0(nLATCH0), 
		.nLATCH1(nLATCH1), 
		.nBACKCOLOR(nBACKCOLOR), 
		.MD(MD)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			.rst(rst),
			.CLK_48M(clk_48m), 
			.s86_6M_IN(s86_6M),
			//.CLK_24M(CLK_24M),
			//.CLK_12M(CLK_12M),
			.s86_6M(s86_6M),
			//.bVSYNC(bVSYNC),
			//.bHSYNC(bHSYNC),
			//.bHBLANK(bHBLANK),
			.bVBLANK(bVBLANK),
			//.nHRESET(nHRESET),
			//.nVRESET(nVRESET),
			//.CLK_8V(CLK_8V),
			//.CLK_4V(CLK_4V),
			//.CLK_1V(CLK_1V),
			//.CLK_4H(CLK_4H),
			.s86_2H(s86_2H),
			.s86_1H(s86_1H),
			.s86_S2H(s86_S2H),
			.s86_S1H(s86_S1H)
		);
		
	initial begin
		clk_48m = 0;
		rst = 0;
		
		// Initialize Inputs
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
	end
     
	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;
	
	// pacland circuitry for single 6809
	reg PACLAND_Q;
	wire PACLAND_E;
	
	always @(posedge s86_1H) begin
		PACLAND_Q <= s86_2H;
	end
	
	assign PACLAND_E = ~s86_2H;
	
endmodule

