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
	wire CLK_6M;
	wire CLK_2H;
	wire CLK_S2H;
	wire CLK_1H;
	wire CLK_S1H;
	wire nVBLANK;
	
	// Inputs
	//reg rst;
	//reg CLK_6M;
	//reg CLK_2H;
	//reg CLK_S2H;
	//reg CLK_1H;
	//reg CLK_S1H;
	//reg nVBLANK;

	// Outputs
	wire nWE;
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
		.CLK_6M(CLK_6M), 
		.CLK_2H(CLK_2H), 
		.CLK_S2H(CLK_S2H), 
		.CLK_1H(CLK_1H), 
		.CLK_S1H(CLK_S1H), 
		.nVBLANK(nVBLANK), 
		.A(A), 
		.D(D), 
		.nWE(nWE), 
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
			.CLK_2H(CLK_2H),
			.CLK_1H(CLK_1H),
			.CLK_S2H(CLK_S2H),
			.CLK_S1H(CLK_S1H)
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
	
	always @(posedge CLK_1H) begin
		PACLAND_Q <= CLK_2H;
	end
	
	assign PACLAND_E = ~CLK_2H;
	
endmodule

