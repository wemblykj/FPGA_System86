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
		input wire _rst_n,
		input wire [1:0] state,
		input wire sig_6M_i,
		input wire sig_FLIP_i,
		input wire sig_bLATCH_i,		// CPU write request
		input wire [1:0] sig_CA_i,		// CPU address bus
		input wire [7:0] sig_CD_i,		// CPU data bus
		input wire [7:0] sig_RD_i,		// SRAM data bus
		input wire sig_bHSYNC_i,
		input wire sig_bVSYNC_i,
		output wire [11:0] sig_RA_o,	// SRAM address bus
		output wire [13:0] sig_GA_o,	// PROM address bus
		output wire sig_S3H_o			// latch request
	);
	
	reg [8:0] hScrollOffset;	// 2 layers 9 bits
	reg [8:0] vScrollOffset;	// 2 layers 9 bits
	
	//wire [8:0] fhCounter;
	reg [8:0] hScrollCounter_next;
	reg [8:0] vScrollCounter_next;
	reg [8:0] hScrollCounter;
	reg [8:0] vScrollCounter;
	
	// worry about flipping later
	//assign fhCounter = sig_FLIP_i ? (384 - H) : H;	// * for flip just subtract from width
	
	wire [8:0] SH;		// 9 bits	0 -> 384
	wire [8:0] SV;		// 9 bits	0 -> 264
	
	reg [7:0] tile_index = 0;
	reg [7:0] attr = 0;
	
	//
	// debug
	//
	
	// tilemap space
	wire [5:0] tilemap_column;
	wire [4:0] tilemap_row;
	
	// ram
	reg [11:0] sram_addr;
	
	// tile space
	wire [2:0] tile_row;		// the row of the tile
	wire [2:0] tile_column;
	wire tile_column_nibble;	// which nibble of the tile row MSB or LSB
	
	//
	// behaviour
	//
	
	reg nHSYNC_last = 0;
	reg nVSYNC_last = 0;
	
	/*always @(posedge sig_6M_i) begin
		if (!_rst_n) begin
			hScrollCounter <= 0;
			vScrollCounter <= 0;
		end else	begin
			if (!sig_bHSYNC_i && nHSYNC_last) begin
				hScrollCounter <= hScrollOffset;
				
				if (sig_bVSYNC_i && !nVSYNC_last)
					vScrollCounter <= vScrollOffset;
				else
					vScrollCounter <= vScrollCounter + 1'b1;
			end else
					hScrollCounter <= hScrollCounter + 1'b1;
		end
		
		nHSYNC_last <= sig_bHSYNC_i;
		nVSYNC_last <= sig_bVSYNC_i;
	end*/
	
	always @(negedge sig_6M_i or negedge _rst_n) begin
		if (!_rst_n) begin
			hScrollCounter_next <= 0;
		end else	begin	
			if (!sig_bHSYNC_i)
				hScrollCounter_next <= hScrollOffset;
			else
				hScrollCounter_next <= hScrollCounter_next + 1'b1;
		end
	end
	
	always @(posedge sig_6M_i or negedge _rst_n) begin
		if (!_rst_n) begin
			hScrollCounter = 0;
			sram_addr = 0;
		end else	begin
			hScrollCounter = hScrollCounter_next;
			
			case (state)
				2'b00: sram_addr = { tilemap_row, tilemap_column, 1'b0 };
				2'b01: attr = sig_RD_i;
				2'b10: sram_addr = { tilemap_row, tilemap_column, 1'b1 };
				2'b11: tile_index = sig_RD_i;
			endcase
		end
	end
	
	always @(negedge sig_bHSYNC_i or negedge _rst_n) begin
		if (!_rst_n) begin
			vScrollCounter_next <= 0;
		end else	begin
			if (!sig_bVSYNC_i)
				vScrollCounter_next <= vScrollOffset;
			else
				vScrollCounter_next <= vScrollCounter_next + 1'b1;
		end
	end
	
	always @(posedge sig_bHSYNC_i or negedge _rst_n) begin
		if (!_rst_n) begin
			vScrollCounter <= 0;
		end else	begin
			vScrollCounter <= vScrollCounter_next;
		end
	end
	
	/*always @(SH[1:0] or sig_RD_i) begin
		if (SH[1:0] === 2'b01)
			tile_index <= sig_RD_i;
		else if (SH[1:0] === 2'b11)
		*/

	// Handle CPU control requests
	always @(negedge sig_bLATCH_i or negedge _rst_n) begin
		if (!_rst_n) begin
			hScrollOffset <= 0;
			vScrollOffset <= 0;
		end else	if (!sig_bLATCH_i) begin
			if (sig_CA_i[1:0] == 'b00)
				// tilemap 0/1 X scroll + priority
				// set lower 8 bits
				hScrollOffset[7:0] <= sig_CD_i;
			else if (sig_CA_i[1:0] == 2'b01) begin
				// tilemap 0/1 X scroll + priority
				// set 9th bit
				hScrollOffset[8] <= sig_CD_i[0];
			end else if (sig_CA_i[1:0] == 2'b10)
				// tilemap 0/1 Y scroll
				// set all 8 bits
				vScrollOffset[7:0] <= sig_CD_i;
		end
	end	
	
	//assign SH = { hScrollCounter[8:3], sig_FLIP_i ? ~hScrollCounter[2:0] : hScrollCounter[2:0] };	// negate flipped counter
	assign SH = { hScrollCounter[8:3], hScrollCounter[2:0] };
	assign SV = vScrollCounter;
	assign sig_S3H_o = SH[1:0] === 2'b11;
	
	//assign sig_RA_o = { SV[7:3], SH[8:3], SH[1] };
	assign sig_RA_o = sram_addr;
	
	assign sig_GA_o = { attr, tile_index, SV[2:0], SH[2] };
	
	// debug
		
	// tilemap space
	assign tilemap_column = SH[8:3];
	assign tilemap_row = SV[7:3];
	
	// tile space
	assign tile_row = SV[2:0];
	assign tile_column = SH[2:0];
	assign tile_column_nibble = SH[2];
endmodule
