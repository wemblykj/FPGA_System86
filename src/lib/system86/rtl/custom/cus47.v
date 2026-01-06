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
		input wire _rst_n,
		  
        input wire pin_6M_i,
        input wire pin_2H_i,
        input wire pin_bVBLK_i,
        input wire pin_RbW_i,
        input wire [15:10] pin_A_i,
        // RES is implied, by convention, as an 'input' on schematics but must logically be an output for watchdog functionality.
        // ref: Pac-Mania CUS117:MRES, MAME namco86.cpp
        output wire pin_bRES_o,	
        output wire pin_MQ_o,
        output wire pin_ME_o,
        output wire pin_SE_o,
        output reg pin_bIRQ_o,
        output wire pin_bLTH2_o,
        output wire pin_bLTH0_o,
        output wire pin_bLTH1_o,
        output wire pin_bSCR0_o,
        output wire pin_bSCR1_o,
        output wire pin_bSND_o,
        output wire pin_bOBJ_o,
        output wire pin_bBUFEN_o,
        output wire pin_BANK_o,
        output wire pin_bSPGM_o,
        output wire pin_bMPGM_o
    );

	reg [WATCHDOG_WIDTH-1:0] watchdog_counter = 0;
	wire watchdog_clear;
	wire int_ack;
	
	reg [3:0] cpu_clock_counter = 0;
	
	/*wire CKA;
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
		.CLK(pin_6M_i),
		.CLR(RES),
		.D1(pin_S2H),
		.D2(CKB_LATCHED),
		.D3(pin_2H_i),
		.D4(CKB_LATCHED),
		.Q1(CKB),
		.Q1_L(CKD),
		.Q2(CKC),
		.Q2_L(CKA),
		.Q3(PHASEB),
		.Q3_L(PHASED),
		.Q4(PHASEC),
		.Q4_L(PHASEA)
	);*/
	
	// the following timings result in E going low towards the end of the EPROM cycle
	assign pin_MQ_o = cpu_clock_counter[1] ^ cpu_clock_counter[0];
	assign pin_ME_o = ~pin_2H_i;
	assign pin_SE_o = pin_2H_i;
	
	// TBD
	//assign pin_ME_o = CKB;
	//assign SUBQ = CKC;
	//assign SUBE = CKD;
	
	// 0000h - 1FFFh W 	(videoram 1)
	// Try synchronising with E as is done for the WRB signal in GnG
	assign pin_bSCR0_o = |pin_A_i[15:13]; // pin_A_i[15:13] !== 'b000;
	
	// 2000 - 3FFFh W		(videoram 2)
	assign pin_bSCR1_o = ~pin_A_i[13] | |pin_A_i[15:14]; // pin_A_i[15:13] !== 'b001;
	
	// 4000h - 5FFFh W	(sprite ram)
	assign pin_bOBJ_o = pin_A_i[15:13] !== 'b010;

	// 4000h - 43FFh R/W	(CUS 30)
	assign pin_bSND_o = pin_A_i[15:10] !== 'b010000;
	
	// 6000h - 7FFFh R	(EEPROM 9D)
	assign pin_bSPGM_o =  ~pin_RbW_i | pin_A_i[15] | ~&pin_A_i[14:13]; 					// pin_A_i[15:13] !== 'b011;
	
	// 8000h W	(watchdog)
	assign watchdog_clear = ~pin_RbW_i & pin_A_i[15] & ~&pin_A_i[14:10];
	
	// 8000h - FFFFh R	(EEPROM 9C)
	assign pin_bMPGM_o = ~pin_RbW_i | ~pin_A_i[15];	// // pin_A_i[15] !== 'b1;
	
	// 8800h - 8FFFh W	(tile bank select)
	assign pin_BANK_o = ~pin_RbW_i & pin_A_i[15] & pin_A_i[11] & ~|pin_A_i[14:12]; //(pin_A_i[15:11] === 'b10001x) && pin_A_i[10];
	
	// 9000h - 9002h W	(scroll + priority)
	// 9003h - 9003h W 	(ROM 9D bank select)
	// 9004h - 9006h W	(scroll + priority)
	assign pin_bLTH0_o = pin_RbW_i | ~(pin_A_i[15] & pin_A_i[12]) | |pin_A_i[14:13] | |pin_A_i[11:10];  // pin_A_i[15:10] !== 'b100100;// & (~pin_A_i[1] == 'b0 | pin_A_i[1:0] == 'b10));	
	
	// 9400h - 9402h W	(scroll 2 + priority)
	// 9403h - 9403h W	(ROM 12D bank select)
	// 9404h - 9406h W	(scroll 3 + priority)
	assign pin_bLTH1_o = pin_RbW_i | ~(pin_A_i[15] & pin_A_i[12] & pin_A_i[10]) | |pin_A_i[14:13] | pin_A_i[11]; // pin_A_i[15:10] !== 'b100101;	
	
	// A000h - A000h W	(BACKCOLOR) - documented as C000h but implemented as A000h in Mame
	assign pin_bLTH2_o = pin_RbW_i | ~(pin_A_i[15] & pin_A_i[13]) | pin_A_i[14] | |pin_A_i[12:10]; // pin_A_i[15:10] !== 'b101000;
	
	assign pin_bBUFEN_o = pin_bSCR0_o & pin_bSCR1_o & pin_bOBJ_o & pin_bSND_o & pin_bLTH0_o & pin_bLTH1_o;
	
	// 0x8400 - 0x8400 W  (INT ACK)
	assign int_ack = ~pin_RbW_i && pin_A_i[15:10] !== 'b100001;
	
	assign pin_bRES_o = ~watchdog_counter[WATCHDOG_WIDTH-1]; // reset on msb
	
	// CPU clock - 90 degrees out of phase from 2H is inferred from knowledge of CUS41 and the fact that the input clock is 180 degrees
	// out of phase to the clock of CUS41
	// http://www.ukvac.com/forum/topic362440&OB=DESC.html
	always @(negedge pin_6M_i or negedge _rst_n) begin
		if (!_rst_n || !pin_2H_i) begin
			cpu_clock_counter <= 0;
		end else begin
			cpu_clock_counter <= cpu_clock_counter + 1'b1;
		end
	end
	
	// watchdog reset and int ack
	// http://www.ukvac.com/forum/topic362440&OB=DESC.html
	always @(posedge pin_bVBLK_i or negedge _rst_n) begin
		if (!_rst_n || watchdog_clear || watchdog_counter === 'b1010) begin
			watchdog_counter <= 'b0000;
		end else begin
			watchdog_counter <= watchdog_counter + 1'b1;
      pin_bIRQ_o <= ~int_ack;
		end
	end
	
	/*always @(*) begin
		CKB_LATCHED <= CKB;
	end*/
	
endmodule
