`timescale 1ns / 1ps

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

	reg _rst_n;
	
	// CUS27 outputs
	reg cus47_6M;
	wire cus47_S2H;
	wire cus47_bVBLK;
	
	// Inputs
	//reg cus47_6M;
	//reg cus47_2H;
	//reg cus47_bVBLK;
	reg cus47_RbW;
	reg [15:10] cus47_A;

	// Outputs
	wire cus47_bRES;
	wire cus47_MQ;
	wire cus47_ME;
	wire cus47_SUBE;
	wire cus47_SUBQ;
	wire cus47_bIRQ;
	wire cus47_bLTH2;
	wire cus47_bLTH0;
	wire cus47_bLTH1;
	wire cus47_bSCR0;
	wire cus47_bSCR1;
	wire cus47_bSND;
	wire cus47_bOBJ;
	wire cus47_bBUFEN;
	wire cus47_BANK;
	wire cus47_bSPGM;
	wire cus47_bMPGM;

	// Instantiate the Unit Under Test (UUT)
	cus47 uut (
		._rst_ni(_rst_n), 
		.pin_6M_i(cus47_6M), 
		.pin_2H_i(cus47_S2H), 
		.pin_nVBLK_i(cus47_bVBLK), 
		.pin_RbW_i(cus47_RbW), 
		.pin_A_i(cus47_A), 
		.pin_bRES_o(cus47_bRES), 
		.pin_MQ_o(cus47_MQ), 
		.pin_ME_o(cus47_ME), 
		.pin_SE_o(cus47_SUBE), 
		.pin_bIRQ_o(cus47_bIRQ), 
		.pin_bLTH2_o(cus47_bLTH2), 
		.pin_bLTH0_o(cus47_bLTH0), 
		.pin_bLTH1_o(cus47_bLTH1), 
		.pin_bSCR0_o(cus47_bSCR0), 
		.pin_bSCR1_o(cus47_bSCR1), 
		.pin_bSND_o(cus47_bSND), 
		.pin_bOBJ_o(cus47_bOBJ), 
		.pin_bBUFEN_o(cus47_bBUFEN), 
		.pin_BANK_o(cus47_BANK), 
		.pin_bSPGM_o(cus47_bSPGM), 
		.pin_bMPGM_o(cus47_bMPGM)
	);

	// CUS27 - CLOCK DIVIDER
	cus27 
		cus27_9p_clock_divider(
			._rst_ni(_rst_n),
			//.pin_48M_i(cus47_48m), 
			.pin_6M_i(cus47_6M),
			//.pin_24M_o(cus47_24M),
			//.pin_12M_o(cus47_12M),
			//.pin_6M_o(cus47_6M),
			//.pin_nVSYNC_o(cus47_bVSYNC),
			//.pin_nHSYNC_o(cus47_bHSYNC),
			//.pin_bHBLANK_o(cus47_bHBLANK),
			.pin_bVBLANK_o(cus47_bVBLK),
			//.pin_nHRESET(cus47_bHRESET),
			//.pin_nVRESET_o(cus47_bVRESET),
			//.pin_8V_o(cus47_8V),
			//.pin_4V_o(cus47_4V),
			//.pin_1V_o(cus47_1V),
			//.pin_4H_o(cus47_4H),
			//.pin_2H_o(cus47_2H),
			//.pin_1H_o(cus47_1H),
			//.pin_S1H_o(cus47_S1H),
			.pin_S2H_o(cus47_S2H)
			
		);
		
	integer address_msb;
	integer address_high;
	integer address_low;
	
	initial begin
		clk_48m = 0;
		_rst_n = 0;
		
		// Initialize Inputs
		//cus47_bVBLK = 0;
		cus47_RbW = 1;
		cus47_A = 0;

		// Wait 100 ns for global reset to finish
		#100;
		_rst_n = 1;
		
		// Add stimulus here
		
		// 000xxxxxxxxxxxxx R/W xxxxxxxx SCROLL0   tilemap 0/1 RAM (shared with sub CPU)
		$display ("tilemap 0/1 RAM (shared with sub CPU)");
		cus47_RbW = 1;
		`test_address_decode_range(1'b0, cus47_bSCR0, cus47_A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSCR0, cus47_A, 'h2000, 'he000, 15, 10)
		cus47_RbW = 0;
		`test_address_decode_range(1'b0, cus47_bSCR0, cus47_A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSCR0, cus47_A, 'h2000, 'he000, 15, 10)
		cus47_RbW = 1;

		// 001xxxxxxxxxxxxx R/W xxxxxxxx SCROLL1   tilemap 2/3 RAM (shared with sub CPU)
		cus47_RbW = 1;
		`test_address_decode_range(1'b1, cus47_bSCR1, cus47_A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bSCR1, cus47_A, 'h2000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSCR1, cus47_A, 'h4000, 'hb000, 15, 10)
		cus47_RbW = 0;
		`test_address_decode_range(1'b1, cus47_bSCR1, cus47_A, 'h0000, 'h2000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bSCR1, cus47_A, 'h2000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSCR1, cus47_A, 'h4000, 'hb000, 15, 10)
		cus47_RbW = 1;
		
		// 010000xxxxxxxxxx R/W xxxxxxxx SOUND     sound RAM (through CUS30, shared with MCU)
		// 01000000xxxxxxxx R/W xxxxxxxx           portion holding the sound wave data
		// 0100000100xxxxxx R/W xxxxxxxx           portion holding the sound registers
		
		// 010xxxxxxxxxxxxx R/W xxxxxxxx OBJECT    work RAM (shared with sub CPU) [1]
		cus47_RbW = 1;
		`test_address_decode_range(1'b1, cus47_bOBJ, cus47_A, 'h0000, 'h4000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bOBJ, cus47_A, 'h4000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bOBJ, cus47_A, 'h6000, 'h9000, 15, 10)
		cus47_RbW = 0;
		`test_address_decode_range(1'b1, cus47_bOBJ, cus47_A, 'h0000, 'h4000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bOBJ, cus47_A, 'h4000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bOBJ, cus47_A, 'h6000, 'h9000, 15, 10)
		cus47_RbW = 1;
		
		// 01011xxxxxxxxxxx R/W xxxxxxxx           portion holding sprite registers
		// 011xxxxxxxxxxxxx R   xxxxxxxx ROM 9D    program ROM (banked) [2]
		
		cus47_RbW = 1;
		`test_address_decode_range(1'b1, cus47_bSPGM, cus47_A, 'h0000, 'h6000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bSPGM, cus47_A, 'h6000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSPGM, cus47_A, 'h8000, 'h8000, 15, 10)
		cus47_RbW = 0;
		`test_address_decode_range(1'b1, cus47_bSPGM, cus47_A, 'h0000, 'h6000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSPGM, cus47_A, 'h6000, 'h2000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bSPGM, cus47_A, 'h8000, 'h8000, 15, 10)
		cus47_RbW = 1;
		
		// 1xxxxxxxxxxxxxxx R   xxxxxxxx ROM 9C    program ROM
		cus47_RbW = 1;
		`test_address_decode_range(1'b1, cus47_bMPGM, cus47_A, 'h0000, 'h8000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bMPGM, cus47_A, 'h8000, 'h8000, 15, 10)
		cus47_RbW = 0;
		`test_address_decode_range(1'b1, cus47_bMPGM, cus47_A, 'h0000, 'h8000, 15, 10)
		`test_address_decode_range(1'b1, cus47_bMPGM, cus47_A, 'h8000, 'h8000, 15, 10)
		cus47_RbW = 1;
		
		// 100000----------   W --------           watchdog reset (RES generated by CUS47)
		// 100001----------   W --------           main CPU irq acknowledge (IRQ generated by CUS47)
		// 10001x----------   W -------- BANK      tile gfx bank select (data is in A10) (latch in CUS47)
		
		// 100100-------x0x   W xxxxxxxx LATCH0    tilemap 0/1 X scroll + priority
		// 100100-------x10   W xxxxxxxx LATCH0    tilemap 0/1 Y scroll
		cus47_RbW = 1;
		`test_address_decode_range(1'b1, cus47_bLTH0, cus47_A, 'h0000, 'h9000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bLTH0, cus47_A, 'h9000, 'h0400, 15, 10)
		`test_address_decode_range(1'b1, cus47_bLTH0, cus47_A, 'h9400, 'h6c00, 15, 10)
		cus47_RbW = 0;
		`test_address_decode_range(1'b1, cus47_bLTH0, cus47_A, 'h0000, 'h9000, 15, 10)
		`test_address_decode_range(1'b0, cus47_bLTH0, cus47_A, 'h9000, 'h0400, 15, 10)
		`test_address_decode_range(1'b1, cus47_bLTH0, cus47_A, 'h9400, 'h6c00, 15, 10)
		cus47_RbW = 1;
		
		// 100100--------11   W ------xx BAMNKM    ROM 9D bank select
		
		// 100101-------x0x   W xxxxxxxx LATCH1    tilemap 2/3 X scroll + priority
		// 100101-------x10   W xxxxxxxx LATCH1    tilemap 2/3 Y scroll
		`test_address_decode_range(1'b1, cus47_bLTH1, cus47_A, 'h0000, 'h9400, 15, 10)
		`test_address_decode_range(1'b0, cus47_bLTH1, cus47_A, 'h9400, 'h0400, 15, 10)
		`test_address_decode_range(1'b1, cus47_bLTH1, cus47_A, 'h9800, 'h6800, 15, 10)
		`test_address_decode_range(1'b1, cus47_bLTH1, cus47_A, 'h9800, 'h6800, 15, 10)
		
		// 100101--------11   W ------xx BAMNKS    ROM 12D bank select
		// 110000----------   W xxxxxxxx BACKCOLOR background color
		
		$display("DONE");
		$finish();
	end
      
	// generate our 6.14025Mhz input clock
	always #81.4299 cus47_6M = ~cus47_6M;
  
	
endmodule

