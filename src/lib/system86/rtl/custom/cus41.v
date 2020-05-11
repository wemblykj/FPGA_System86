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
module cus41
    #(
        parameter WATCHDOG_WIDTH = 8
    )
    (
        input wire [15:11] MA,
        input wire nMWE,
        input wire nVBLA,
        input wire CLK_0,
        input wire CLK_1,
        input wire CLK_6M,
        input wire nSWE,
        input wire SA15,
        input wire SA14,
        input wire SA13,
        input wire SA12,
        input wire SA11,
        // MRESET is implied, by convention, as an 'input' on schematics but must logically be an output for watchdog functionality.
        // ref: Pac-Mania CUS117:SUBRES, MAME namco86.cpp  
        output wire nMRES,
        output reg nSINT,
        output wire SROM,
        output wire SCS4,
        output wire SCS3,
        output wire SCS2,
        output wire SCS1,
        output wire SCS0,
        output wire Q,
        output wire nLTH0,
        output wire nLTH1,
        output wire nSND,
        output wire nMCS0,
        output wire nMCS1,
        output wire nMCS2,
        output wire nMCS3,
        output wire nMCS4,
        output wire nMROM
    );

	reg [WATCHDOG_WIDTH-1:0] watchdog_counter = 0;
	
	// 0000h - 1FFFh R/W	(sprite ram)
	assign nMCS2 = |MA[15:13]; // MA[15:13] !== 'b000;
	
	// 2000h - 3FFFh R/W 	(videoram 1)
	assign nMCS0 = ~MA[13] | |MA[15:14]; // MA[15:13] !== 'b001;
	
	// 4000h - 5FFFh R/W		(videoram 2)
	assign nMCS1 = ~MA[14] | MA[15] | MA[13]; // MA[15:13] !== 'b010;
	
	// 6000h - 7FFFh R	(EEPROM 12D)
	assign nMCS4 = ~MA[15] | |MA[14:13]; // /*nMWE ||*/ (MA[15:13] !== 'b011);
	
	// 8000h - FFFFh R	(EEPROM 12C)
	assign nMROM = ~MA[15];  //*nMWE ||*/ MA[15] !== 1;
	
	// 0x8800 - 0x8800 W  (INT ACK)
	assign nIRQ_ACK = nMWE || MA[15:11] !== 'b10001;
	assign nIRQ_next = nVBLA || nIRQ_ACK;
	
	// D000h - D002h W	(scroll + priority)
	// D003h - D003h W 	(ROM 9D bank select)
	// D004h - D006h W	(scroll + priority)
	assign nLTH0 = ~(&MA[15:14] & MA[12]) | MA[13] | MA[11]; // /*nMWE ||*/ MA[15:11] !== 'b11010;// & (~A[1] == 'b0 | A[1:0] == 'b10));	
	
	// D800h - D802h W	(scroll + priority)
	// D803h - D803h W 	(ROM 12D bank select)
	// D8004h - D806h W	(scroll + priority)
	assign nLTH1 = ~(&MA[15:14] & MA[12:11]) | MA[13]; // /*nMWE ||*/ MA[15:11] !== 'b11011;	
	
	assign MRESET = watchdog_counter[WATCHDOG_WIDTH-1];
	
	initial begin
		nSINT = 1'b1;
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
