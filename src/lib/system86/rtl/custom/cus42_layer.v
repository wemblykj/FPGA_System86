`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    14/04/2020 
// Design Name:    SCROLL H POSITION
// Module Name:    system86\src\custom\gng_scroll_position.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS42 - GnG SCROLL H POSITION 85606 - B - 2 - 7/9
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus42_layer
	(
		input wire rst_n,
		
		input wire CLK_6M,
		input wire FLIP,
		input wire nLATCH,		// CPU write request
		input wire [1:0] CA,		// CPU address bus
		input wire [7:0] CD,		// CPU data bus
		input wire [7:0] RD,		// SRAM data bus
		input wire nHSYNC,
		input wire nVSYNC,
		output wire [11:0] RA,	// SRAM address bus
		output wire [13:0] GA,	// PROM address bus
		output wire S3H			// latch request
	);
	
	reg [8:0] hScrollOffset;	// 2 layers 9 bits
	reg [8:0] vScrollOffset;	// 2 layers 9 bits
	
	//wire [8:0] fhCounter;
	reg [8:0] hScrollCounter;
	reg [8:0] vScrollCounter;
	
	// worry about flipping later
	//assign fhCounter = FLIP ? (384 - H) : H;	// * for flip just subtract from width
	
	wire [8:0] SH;		// 9 bits	0 -> 384
	wire [8:0] SV;		// 9 bits	0 -> 264
	
	reg [7:0] tile_index = 0;
	reg [1:0] attr = 0;
	
	//
	// debug
	//
	
	// tilemap space
	wire [5:0] tilemap_column;
	wire [4:0] tilemap_row;
	
	// tile space
	wire [2:0] tile_row;		// the row of the tile
	wire [2:0] tile_column;
	wire tile_column_nibble;	// which nibble of the tile row MSB or LSB
	
	//
	// behaviour
	//
	
	reg nHSYNC_last = 0;
	reg nVSYNC_last = 0;
	
	always @(posedge CLK_6M) begin
		if (!rst_n) begin
			hScrollCounter <= 0;
			vScrollCounter <= 0;
		end else	begin
			if (!nHSYNC && nHSYNC_last) begin
				hScrollCounter <= hScrollOffset;
				
				if (nVSYNC && !nVSYNC_last)
					vScrollCounter <= vScrollOffset;
				else
					vScrollCounter <= vScrollCounter + 1;
			end else
					hScrollCounter <= hScrollCounter + 1;
		end
		
		nHSYNC_last <= nHSYNC;
		nVSYNC_last <= nVSYNC;
	end
	
	always @(SH[1:0]) begin
		if (SH[1:0] === 2'b01)
			tile_index <= RD;
		else if (SH[1:0] === 2'b11)
			attr <= RD[1:0];
	end

	// Handle CPU control requests
	always @(negedge nLATCH or negedge rst_n) begin
		if (!rst_n) begin
			hScrollOffset <= 0;
			vScrollOffset <= 0;
		end else	if (!nLATCH) begin
			if (CA[1:0] == 'b00)
				// tilemap 0/1 X scroll + priority
				// set lower 8 bits
				hScrollOffset[7:0] <= CD;
			else if (CA[1:0] == 2'b01) begin
				// tilemap 0/1 X scroll + priority
				// set 9th bit
				hScrollOffset[8] <= CD[0];
			end else if (CA[1:0] == 2'b10)
				// tilemap 0/1 Y scroll
				// set all 8 bits
				vScrollOffset[7:0] <= CD;
		end
	end	
	
	//assign SH = { hScrollCounter[8:3], FLIP ? ~hScrollCounter[2:0] : hScrollCounter[2:0] };	// negate flipped counter
	assign SH = { hScrollCounter[8:3], hScrollCounter[2:0] };
	assign SV = vScrollCounter;
	assign S3H = SH[1:0] === 2'b11;
	
	assign RA = { SV[7:3], SH[8:3], SH[1] };
	assign GA = { attr, tile_index, SV[2:0], SH[2] };
	
	// debug
		
	// tilemap space
	assign tilemap_column = SH[8:3];
	assign tilemap_row = SV[7:3];
	
	// tile space
	assign tile_row = SV[2:0];
	assign tile_column = SH[2:0];
	assign tile_column_nibble = SH[2];
endmodule
