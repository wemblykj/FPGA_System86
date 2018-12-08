`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    17:00:13 04/29/2018 
// Design Name: 
// Module Name:    system86\src\custom\cus41 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS47 - Primary CPU address line generator 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module CUS41(
	input [15:11] MA,
	input MWE,
	input VBLK,
	input wire CLK_0,
	input wire CLK_1,
	input wire CLK_6M,
	input wire SWE,
	input wire SA15,
	input wire SA14,
	input wire SA13,
	input wire SA12,
	input wire SA11,
	// MRESET is implied, by convention, as an 'input' on schematics but must logically be an output for watchdog functionality.
	// ref: Pac-Mania CUS117:SUBRES, MAME namco86.cpp  
	output wire MRESET,
	output reg SINT,
	output wire SROM,
	output wire SCS4,
	output wire SCS3,
	output wire SCS2,
	output wire SCS1,
	output wire SCS0,
	output wire Q,
	output wire LTH0,
	output wire LTH1,
	output wire SND,
	output wire MCS0,
	output wire MCS1,
	output wire MCS2,
	output wire MCS3,
	output wire MCS4,
	output wire MROM
    );

	parameter WATCHDOG_WIDTH = 8;
	
	reg [WATCHDOG_WIDTH-1:0] watchdog_counter = 0;
	
	// 0000h - 1FFFh R/W	(sprite ram)
	assign MCS2 = MA[15:13] === 'b000;
	
	// 2000h - 3FFFh R/W 	(videoram 1)
	assign MCS0 = MA[15:13] === 'b001;
	
	// 4000h - 5FFFh R/W		(videoram 2)
	assign MCS1 = MA[15:13] === 'b010;
	
	// 6000h - 7FFFh R	(EEPROM 12D)
	assign MCS4 = ~MWE && (MA[15:13] === 'b011);
	
	// 8000h - FFFFh R	(EEPROM 12C)
	assign MROM = ~MWE && MA[15] === 1;
	
	// 0x8800 - 0x8800 W  (INT ACK)
	assign IRQ_ACK = MWE && MA[15:11] === 'b10001;
	assign IRQ_next = VBLK && ~IRQ_ACK;
	
	// D000h - D002h W	(scroll + priority)
	// D003h - D003h W 	(ROM 9D bank select)
	// D004h - D006h W	(scroll + priority)
	assign LTH0 = MWE && MA[15:11] === 'b11010;// & (~A[1] == 'b0 | A[1:0] == 'b10));	
	
	// D800h - D802h W	(scroll + priority)
	// D803h - D803h W 	(ROM 12D bank select)
	// D8004h - D806h W	(scroll + priority)
	assign LTH1 = MWE && MA[15:11] === 'b11011;	
	
	assign MRESET = watchdog_counter[WATCHDOG_WIDTH-1];
	
	initial begin
		SINT = 0;
	end
	
	/*always @(posedge VBLK, negedge IRQ_ACK) begin
		SINT <= IRQ_next === 1'b1;
		
		if (MWE && MA[15:11] === 'b10000)
			watchdog_counter <= 0;
		else if (VBLK)
			watchdog_counter <= watchdog_counter + 1;
	end
	*/
	
endmodule
