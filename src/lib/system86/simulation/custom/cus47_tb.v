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

`include "../address_decode_defs.vh"

module cus47_tb;

	reg rst;
	reg clk_48m;

	// CUS27 outputs
	wire CLK_6M;
	wire CLK_S2H;
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
		.SE(SUBE), 
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
		
	integer address_msb;
	integer address_high;
	integer address_low;
	
	initial begin
		clk_48m = 0;
		rst = 0;
		
		// Initialize Inputs
		//nVBLK = 0;
		nWE = 1;
		A = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;
		
		// Add stimulus here
		
		// 000xxxxxxxxxxxxx R/W xxxxxxxx SCROLL0   tilemap 0/1 RAM (shared with sub CPU)
		$display ("tilemap 0/1 RAM (shared with sub CPU)");
		nWE = 1;
		`test_address_decode_range(1'b0, nSCR0, A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nSCR0, A, 'h2000, 'he000, 15, 10)
		nWE = 0;
		`test_address_decode_range(1'b0, nSCR0, A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nSCR0, A, 'h2000, 'he000, 15, 10)
		nWE = 1;

		// 001xxxxxxxxxxxxx R/W xxxxxxxx SCROLL1   tilemap 2/3 RAM (shared with sub CPU)
		nWE = 1;
		`test_address_decode_range(1'b1, nSCR1, A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b0, nSCR1, A, 'h2000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nSCR1, A, 'h4000, 'hb000, 15, 10)
		nWE = 0;
		`test_address_decode_range(1'b1, nSCR1, A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b0, nSCR1, A, 'h2000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nSCR1, A, 'h4000, 'hb000, 15, 10)
		nWE = 1;
		
		// 010000xxxxxxxxxx R/W xxxxxxxx SOUND     sound RAM (through CUS30, shared with MCU)
		// 01000000xxxxxxxx R/W xxxxxxxx           portion holding the sound wave data
		// 0100000100xxxxxx R/W xxxxxxxx           portion holding the sound registers
		
		// 010xxxxxxxxxxxxx R/W xxxxxxxx OBJECT    work RAM (shared with sub CPU) [1]
		nWE = 1;
		`test_address_decode_range(1'b1, nOBJ, A, 'h0000, 'h4000, 15, 10)
		`test_address_decode_range(1'b0, nOBJ, A, 'h4000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nOBJ, A, 'h6000, 'h9000, 15, 10)
		nWE = 0;
		`test_address_decode_range(1'b1, nOBJ, A, 'h0000, 'h4000, 15, 10)
		`test_address_decode_range(1'b0, nOBJ, A, 'h4000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nOBJ, A, 'h6000, 'h9000, 15, 10)
		nWE = 1;
		
		// 01011xxxxxxxxxxx R/W xxxxxxxx           portion holding sprite registers
		// 011xxxxxxxxxxxxx R   xxxxxxxx ROM 9D    program ROM (banked) [2]
		
		nWE = 1;
		`test_address_decode_range(1'b1, nSPGM, A, 'h0000, 'h6000, 15, 10)
		`test_address_decode_range(1'b0, nSPGM, A, 'h6000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nSPGM, A, 'h8000, 'h8000, 15, 10)
		nWE = 0;
		`test_address_decode_range(1'b1, nSPGM, A, 'h0000, 'h6000, 15, 10)
		`test_address_decode_range(1'b1, nSPGM, A, 'h6000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, nSPGM, A, 'h8000, 'h8000, 15, 10)
		nWE = 1;
		
		// 1xxxxxxxxxxxxxxx R   xxxxxxxx ROM 9C    program ROM
		nWE = 1;
		`test_address_decode_range(1'b1, nMPGM, A, 'h0000, 'h8000, 15, 10)
		`test_address_decode_range(1'b0, nMPGM, A, 'h8000, 'h8000, 15, 10)
		nWE = 0;
		`test_address_decode_range(1'b1, nMPGM, A, 'h0000, 'h8000, 15, 10)
		`test_address_decode_range(1'b1, nMPGM, A, 'h8000, 'h8000, 15, 10)
		nWE = 1;
		
		// 100000----------   W --------           watchdog reset (RES generated by CUS47)
		// 100001----------   W --------           main CPU irq acknowledge (IRQ generated by CUS47)
		// 10001x----------   W -------- BANK      tile gfx bank select (data is in A10) (latch in CUS47)
		
		// 100100-------x0x   W xxxxxxxx LATCH0    tilemap 0/1 X scroll + priority
		// 100100-------x10   W xxxxxxxx LATCH0    tilemap 0/1 Y scroll
		nWE = 1;
		`test_address_decode_range(1'b1, nLTH0, A, 'h0000, 'h9000, 15, 10)
		`test_address_decode_range(1'b0, nLTH0, A, 'h9000, 'h0400, 15, 10)
		`test_address_decode_range(1'b1, nLTH0, A, 'h9400, 'h6c00, 15, 10)
		nWE = 0;
		`test_address_decode_range(1'b1, nLTH0, A, 'h0000, 'h9000, 15, 10)
		`test_address_decode_range(1'b0, nLTH0, A, 'h9000, 'h0400, 15, 10)
		`test_address_decode_range(1'b1, nLTH0, A, 'h9400, 'h6c00, 15, 10)
		nWE = 1;
		
		// 100100--------11   W ------xx BAMNKM    ROM 9D bank select
		
		// 100101-------x0x   W xxxxxxxx LATCH1    tilemap 2/3 X scroll + priority
		// 100101-------x10   W xxxxxxxx LATCH1    tilemap 2/3 Y scroll
		`test_address_decode_range(1'b1, nLTH1, A, 'h0000, 'h9400, 15, 10)
		`test_address_decode_range(1'b0, nLTH1, A, 'h9400, 'h0400, 15, 10)
		`test_address_decode_range(1'b1, nLTH1, A, 'h9800, 'h6800, 15, 10)
		`test_address_decode_range(1'b1, nLTH1, A, 'h9800, 'h6800, 15, 10)
		
		// 100101--------11   W ------xx BAMNKS    ROM 12D bank select
		// 110000----------   W xxxxxxxx BACKCOLOR background color
		
		$display("DONE");
		$finish();
	end
      
	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;    
	
endmodule

