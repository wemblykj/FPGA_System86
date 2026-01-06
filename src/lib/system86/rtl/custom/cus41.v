`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    17:00:13 04/29/2018 
// Design Name:    CUS41
// Module Name:    system86\src\custom\cus41.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS41 - Primary CPU address line generator (a derivative/alternative of CUS130)
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus41
    #(
        parameter WATCHDOG_WIDTH = 4
    )
    (
		input wire _rst_ni,
			
        input wire [15:11] pin_MA_i,
        input wire pin_bMWE_i,
        input wire pin_bVBLA_i,
        input wire pin_CLK0,
        input wire pin_CLK1,
        input wire pin_6M_i,
        input wire pin_bSWE_i,
        input wire pin_SA15_i,
        input wire pin_SA14_i,
        input wire pin_SA13_i,
        input wire pin_SA12_i,
        input wire pin_SA11_i,
        // MRESET is implied, by convention, as an 'input' on schematics but must logically be an output for watchdog functionality.
        // ref: Pac-Mania CUS117:SUBRES, MAME namco86.cpp  
        output wire pin_bMRESET_o,
        output reg pin_bSINT_o,
		  output reg pin_bMINT_o,
        output wire pin_SROM_o,
        output wire pin_SCS4_o,
        output wire pin_SCS3_o,
        output wire pin_SCS2_o,
        output wire pin_SCS1_o,
        output wire pin_SCS0_o,
        output wire pin_Q_o,			// 90 degrees out of phase with nS2H? (http://www.ukvac.com/forum/topic362440&OB=DESC.html)
        output wire pin_bLTH0_o,
        output wire pin_bLTH1_o,
        output wire pin_bSND_o,
        output wire pin_bMCS0_o,
        output wire pin_bMCS1_o,
        output wire pin_bMCS2_o,
        output wire pin_bMCS3_o,
        output wire pin_bMCS4_o,
        output wire pin_bMROM_o
    );

	reg [WATCHDOG_WIDTH-1:0] main_watchdog_counter = 0;
	wire main_watchdog_clear;
	wire main_int_ack;
	//wire sound_int_ack;
	
	reg [3:0] cpu_clock_counter = 0;
	
	assign pin_Q_o = cpu_clock_counter[1] ^ cpu_clock_counter[0];
	
	// 0000h - 1FFFh R/W	(sprite ram)
	assign pin_bMCS2_o = pin_MA_i[15:13] !== 'b000;
	
	// 2000h - 3FFFh R/W 	(videoram 1)
	assign pin_bMCS0_o = ~pin_MA_i[13] | |pin_MA_i[15:14]; // pin_MA_i[15:13] !== 'b001;
	
	// 4000h - 5FFFh R/W		(videoram 2)
	assign pin_bMCS1_o = ~pin_MA_i[14] | pin_MA_i[15] | pin_MA_i[13]; // pin_MA_i[15:13] !== 'b010;
	
	// unused
	assign pin_bMCS3_o = 'b1;
	
	// 6000h - 7FFFh R	(EEPROM 12D)
	assign pin_bMCS4_o = ~pin_bMWE_i | pin_MA_i[15] | ~&pin_MA_i[14:13]; // /*pin_bMWE_i ||*/ (pin_MA_i[15:13] !== 'b011);
	
	// 8000h - FFFFh R	(EEPROM 12C)
	assign pin_bMROM_o = ~pin_bMWE_i | ~pin_MA_i[15];  //*pin_bMWE_i ||*/ pin_MA_i[15] !== 1;
	
	// 8000h W	(watchdog)
	assign main_watchdog_clear = ~pin_bMWE_i && pin_MA_i[15:11] === 'b10000;
	
	// 9800h W	(watchdog, CUS130)
	//assign sound_watchdog_clear = ~pin_bSWE_i & pin_MA_i[15:11] === 'b10011;
	
	// 0x8800 - 0x8800 W  (INT ACK)
	assign main_int_ack = ~pin_bMWE_i && pin_MA_i[15:11] === 'b10001;
	
	// 0x8800 - 0x8800 W  (INT ACK)
	//assign sound_int_ack = ~pin_bSWE_i && pin_MA_i[15:11] === 'b10011;
	
	// D000h - D002h W	(scroll + priority)
	// D003h - D003h W 	(ROM 9D bank select)
	// D004h - D006h W	(scroll + priority)
	assign pin_bLTH0_o = pin_bMWE_i | ~(&pin_MA_i[15:14] & pin_MA_i[12]) | pin_MA_i[13] | pin_MA_i[11]; // /*pin_bMWE_i ||*/ pin_MA_i[15:11] !== 'b11010;// & (~A[1] == 'b0 | A[1:0] == 'b10));	
	
	// D800h - D802h W	(scroll + priority)
	// D803h - D803h W 	(ROM 12D bank select)
	// D8004h - D806h W	(scroll + priority)
	assign pin_bLTH1_o = pin_bMWE_i | ~(&pin_MA_i[15:14] & &pin_MA_i[12:11]) | pin_MA_i[13]; // /*pin_bMWE_i ||*/ pin_MA_i[15:11] !== 'b11011;	
	
	assign pin_bMRESET_o = ~main_watchdog_counter[WATCHDOG_WIDTH-1];	// reset on msb
	
	initial begin
		pin_bMINT_o = 1'b1;
		pin_bSINT_o = 1'b1;
	end
	
	// CPU clock - 90 degrees out of phase from 2H? (http://www.ukvac.com/forum/topic362440&OB=DESC.html)
	always @(negedge pin_6M_i or negedge _rst_ni) begin
		/* based on interpretation of 74LS161 circuit from www.ukvac.com.
		 * N.B. to be out of sync by 90 as described required my CUS27 implmentation to be tweaked to update its counter on falling edge of 6M 
		 * (rather than the positive edge), this would lead me to believe that the CUS27 is now [more] correct.
		*/
		if (!_rst_ni || !pin_CLK0) begin
			cpu_clock_counter <= 0;
		end else begin
			cpu_clock_counter <= cpu_clock_counter + 1'b1;
		end
		
	end
	
	// watchdog reset and int ack
	// http://www.ukvac.com/forum/topic362440&OB=DESC.html
	always @(negedge pin_bVBLA_i or negedge _rst_ni) begin
		if (!_rst_ni || main_watchdog_clear || main_watchdog_counter === 'b1010) begin
			main_watchdog_counter <= 0;
      pin_bMINT_o <= 1;
		end else begin
			main_watchdog_counter <= main_watchdog_counter + 1'b1;
      pin_bMINT_o <= ~main_int_ack;
		//pin_bSINT_o <= ~sound_int_ack;
		end
	end
	
endmodule
