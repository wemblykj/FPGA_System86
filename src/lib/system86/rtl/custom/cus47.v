`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:28:10 04/17/2018 
// Design Name:    CUS47
// Module Name:    system86/src/custom/cus47.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS47 - Secondary CPU address line generator 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus47
    #(
        // based on Atari watchdog based on LS197 decade
        // this equates to about 4^2 V-blanks
        parameter WATCHDOG_WIDTH = 4
    )
    (
        input wire CLK_6M,
        input wire CLK_2H,
        input wire nVBLK,
        input wire nWE,
        input wire [15:10] A,
        // RES is implied, by convention, as an 'input' on schematics but must logically be an output for watchdog functionality.
        // ref: Pac-Mania CUS117:MRES, MAME namco86.cpp
        output wire nRES,	
        output wire MQ,
        output wire ME,
        output wire SUBE,
        output wire SUBQ,
        output reg nIRQ,
        output wire nLTH2,
        output wire nLTH0,
        output wire nLTH1,
        output wire nSCR0,
        output wire nSCR1,
        output wire nSND,
        output wire nOBJ,
        output wire nBUFEN,
        output wire BANK,
        output wire nSPGM,
        output wire nMPGM
    );

	reg [WATCHDOG_WIDTH-1:0] watchdog_counter = 0;
	
	wire CKA;
	wire CKB;
	wire CKC;
	wire CKD;
	wire PHASEA;
	wire PHASEB;
	wire PHASEC;
	wire PHASED;
	
	reg CKB_LATCHED;
	reg VBLK_LATCHED;
	
	//Based on Pacland circuitry
	ls175 eq_generator(
		.CLK(CLK_6M),
		.CLR(RES),
		.D1(CLK_2H),
		.D2(CKB_LATCHED),
		.D3(CLK_2H),
		.D4(CKB_LATCHED),
		.Q1(CKB),
		.Q1_L(CKD),
		.Q2(CKC),
		.Q2_L(CKA),
		.Q3(PHASEB),
		.Q3_L(PHASED),
		.Q4(PHASEC),
		.Q4_L(PHASEA)
	);
	
	assign MQ = CKB;
	assign ME = CKC;
	assign SUBE = CKA;
	assign SUBQ = CKD;
	//assign MQ = CKD;
	//assign ME = CKA;
	//assign SUBE = CKC;
	//assign SUBQ = CKB;
	
	// 0000h - 1FFFh W 	(videoram 1)
	assign nSCR0 = A[15:13] !== 'b000;
	
	// 2000 - 3FFFh W		(videoram 2)
	assign nSCR1 = A[15:13] !== 'b001;
	
	// 4000h - 5FFFh W	(sprite ram)
	assign nOBJ = A[15:13] !== 'b010;

	// 4000h - 43FFh R/W	(CUS 30)
	assign nSND = A[15:10] !== 'b010000;
	
	// 6000h - 7FFFh R	(EEPROM 9D)
	assign nSPGM = (A[15:13] !== 'b011);
	
	// 8000h - FFFFh R	(EEPROM 9C)
	assign nMPGM = A[15] !== 'b1;
	
	// 8800h - 8FFFh W	(tile bank select)
	assign BANK = (A[15:11] === 'b10001) && A[10];
	
	// 9000h - 9002h W	(scroll + priority)
	// 9003h - 9003h W 	(ROM 9D bank select)
	// 9004h - 9006h W	(scroll + priority)
	assign nLTH0 = A[15:10] !== 'b100100;// & (~A[1] == 'b0 | A[1:0] == 'b10));	
	
	// 9400h - 9402h W	(scroll 2 + priority)
	// 9403h - 9403h W	(ROM 12D bank select)
	// 9404h - 9406h W	(scroll 3 + priority)
	assign nLTH1 = A[15:10] !== 'b100101;	
	
	// A000h - A000h W	(BACKCOLOR) - documented as C000h but implemented as A000h in Mame
	assign nLTH2 = A[15:10] !== 'b101000;
	
	assign nBUFEN = nSCR0 && nSCR1 && nOBJ && nSND && nLTH0 && nLTH1;
	
	// 0x8400 - 0x8400 W  (INT ACK)
	assign nIRQ_ACK = nWE || A[15:10] !== 'b100001;
	assign nIRQ_next = nVBLK || nIRQ_ACK;
	
	assign nRES = ~watchdog_counter[WATCHDOG_WIDTH-1];
	
	initial begin
		nIRQ = 0;
	end
	
	/*always @(posedge VBLK, negedge IRQ_ACK) begin
		IRQ <= IRQ_next;
		
		if (WE & (A[15:10] === 'b100000))
			watchdog_counter <= 0;
		else if (VBLK)
			watchdog_counter <= watchdog_counter + 1;
	end*/
	
	always @(*) begin
		CKB_LATCHED <= CKB;
	end
	
endmodule
