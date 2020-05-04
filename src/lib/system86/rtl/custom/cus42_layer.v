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
	#
	(
		parameter ASSIGNED_LAYER = 0
	)
	(
		input wire rst,
		
		input wire CLK_6M,
		input wire FLIP,
		input wire nLATCH,		// CPU write request
		input wire [1:0] CA,		// CPU address bus
		input wire [7:0] CD,		// CPU data bus
		input wire [7:0] RD,		// SRAM data bus
		input wire [8:0] H,		// 9 bits
		input wire [8:0] V,		// 8 bits
		output reg [11:0] RA,	// SRAM address bus
		output reg [13:0] GA,	// PROM address bus
		output wire S3H			// latch request
	);
	
	reg [8:0] hScrollOffset;	// 2 layers 9 bits
	reg [8:0] vScrollOffset;	// 2 layers 9 bits
	
	wire [8:0] fhCounter;
	wire [8:0] hScrollCounter;
	wire [8:0] vScrollCounter;
	
	assign fhCounter = FLIP ? (384 - H) : H;	// * for flip just subtract from width
	
	// horizontal adder - GnG SCROLL H POSITION 85606 - 8 -  2
	assign hScrollCounter = hScrollOffset + fhCounter;
	// vertical adder - assumed this would work similar to horizontal (no vertical fliping?)
	assign vScrollCounter = vScrollOffset + V;
	
	wire [8:0] SH;		// 9 bits	0 -> 384
	wire [8:0] SV;		// 9 bits	0 -> 264
	
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
	
	always @(H[1:0] or rst) begin
		if (rst) begin
			RA <= 0;
			GA <= 0;
		end else begin
			case ( {ASSIGNED_LAYER, H[1:0]} )
				3'b010, 3'b100 : begin
					RA <= { SV[7:3], SH[8:3], 1'b0 };
					GA[3:0] <= { SV[2:0], SH[2] };
				end
				3'b011, 3'b101 : begin
					RA[0] <= 1'b1;
					GA[11:4] <= RD;
				end
				3'b000, 3'b110 : begin
					GA[13:12] <= RD;
				end
			endcase
		end
	end

	// Handle CPU control requests
	always @(nLATCH or rst or V) begin
		if (rst) begin
			hScrollOffset <= 0;
			vScrollOffset <= 0;
		end else if (V === 9'b100000111) begin
			hScrollOffset <= hScrollOffset + 1;
		end else	if (!nLATCH) begin
			if (!CA[1])
				// set lower 8 bits
				hScrollOffset[7:0] <= CD;
			else if (!CA[1:0] == 2'b01) begin
				// set 9th bit
				hScrollOffset[8] = CD[0];
			end else if (!CA[1:0] == 2'b10)
				// set all 8th bits
				vScrollOffset[7:0] <= CD;
		end
	end	
	
	assign SH = { hScrollCounter[8:3], FLIP ? ~hScrollCounter[2:0] : hScrollCounter[2:0] };
	assign SV = vScrollCounter;
	assign S3H = SH[1:0] === 2'b00;
	
	// debug
		
	// tilemap space
	assign tilemap_column = SH[8:3];
	assign tilemap_row = SV[7:3];
	
	// tile space
	assign tile_row = SV[2:0];
	assign tile_column = SH[2:0];
	assign tile_column_nibble = SH[2];
endmodule
