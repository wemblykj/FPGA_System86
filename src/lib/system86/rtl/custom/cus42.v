`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:14:43 05/04/2018 
// Design Name:    CUS42
// Module Name:    system86\src\custom\cus42.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS42 - Tilemap Address Generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus42(
		input wire rst,
			
		input wire CLK_6M,
		input wire CLK_2H,
		input wire nHSYNC,
		input wire nVSYNC,
		input wire nGCS,
		input wire nRCS,
		input wire nLATCH,
		input wire FLIP,
		input wire [13:0] CA,
		input wire nWE,
		inout wire [7:0] CD,
		inout wire [7:0] RD,
		output wire [13:0] GA,
		output wire [12:0] RA,
		output wire nRWE,
		output wire nROE,
		output reg HA2,
		output reg HB2
	);

	// RA   
	// RAM addr bus
	// 13 bits (2 layers @ 64x32 tiles, 2 byte per tile) 
	// 12 - layer (0000h or 1000h)
	// 11-1 y-offset * 48 + x-offset (11 bits)
	// 11-7 y-offset (5 bits)
	// 7-1 x-offset (6 bits)
	// 0 - byte select
	reg ra_layer = 0;
	reg [4:0] ra_tilemap_row = 0;
	reg [5:0] ra_tilemap_column = 0;
	reg ra_tilemap_byte = 0;
	assign RA = { ra_layer, ra_tilemap_row, ra_tilemap_column, ra_tilemap_byte };
	
   // wire [13:0] GA;   // PROM addr bus
	// 14 bits (
	// 12:11 - attr lsb
	// 10:6 - row
	// 7:4 - column
	// 3:1 - row
	// 0 - nibble
	reg [1:0] ga_tile_attrs = 0;
	reg [7:0] ga_tile_index = 0;
	reg [2:0] ga_tile_row = 0;
	reg ga_tile_column_nibble = 0;
			
	assign GA = { ga_tile_attrs, ga_tile_index, ga_tile_row, ga_tile_column_nibble };
			
	reg hsyncLast = 1;
	reg vsyncLast = 1;
	
	// screen space
	reg [8:0] hCounter = 0;	// 9 bits
	reg [8:0] vCounter = 0; // 9 bits
	wire [5:0] screen_column = hCounter[8:3];
	wire [4:0] screen_row = vCounter[7:3];
	wire [11:0] screen_tile = (screen_row*8) + screen_column;
	
	assign layer = CLK_2H;
	
	// per layer inputs
	
	// scroll layer 1 ;	// 2 layers 9 bits
	reg [8:0] hScrollOffset[0:1];	// 2 layers 9 bits
	reg [7:0] vScrollOffset[0:1];	// 2 layers 8 bits
	
	// tilemap space
	//reg [8:0] hScrollCounter [0:1];	// 2 layers 9 bits 
	//reg [7:0] vScrollCounter [0:1]; // 2 layers 8 bits
	reg [5:0] tilemap_column [0:1];
	reg [4:0] tilemap_row [0:1];
	
	// tile space
	reg [2:0] tile_row [0:1];		// the row of the tile
	reg [2:0] tile_column [0:1];
	reg tile_column_nibble [0:1];	// which nibble of the tile row MSB or LSB
	
	// priority layer 1 & 2, may not be used here (see CUS43)
	reg [2:0] pri;						// 2 layers 3 bits
    
	// Handle CPU control requests
	always @(*) begin
		if (nLATCH == 1'b0) begin
			if (!CA[1])
				// set lower 8 bits
				hScrollOffset[CA[2]][7:0] = CD;
			else if (!CA[1:0] == 2'b01) begin
				// set 9th bit
				hScrollOffset[CA[2]][8] = CD[0];
				pri[CA[2]] = CD[3:1];
			end else if (!CA[1:0] == 2'b10)
				// set all 8th bits
				vScrollOffset[CA[2]][7:0] = CD;
		end
	end	

	integer hScrollCounter;
	integer vScrollCounter;
	
	always @(negedge CLK_6M or rst) begin
		if (rst) begin
			pri = 3'b0;
			hScrollOffset[0] = 0;
			vScrollOffset[0] = 0;
			hScrollOffset[1] = 0;
			vScrollOffset[1] = 0;
			ra_layer = 0;  
			ra_tilemap_row = 0;  
			ra_tilemap_column = 0;  
			ra_tilemap_byte = 0;  
			ga_tile_attrs = 0;
			ga_tile_index = 0;
			ga_tile_row = 0;
			ga_tile_column_nibble = 0;
			HA2 = 0;
			HB2 = 0;
		end else begin
			hCounter = hCounter + 1;
			if (!nHSYNC && hsyncLast) begin
				hCounter = 0;
				vCounter = vCounter + 1;
			end
				
			if (!nVSYNC && vsyncLast) begin
				vCounter = 0;
				// HACK to scroll each frame
				//hScrollOffset[0] = hScrollOffset[0] + 1;
				//hScrollOffset[1] = hScrollOffset[1] + 1;
			end 
			
			HA2 <= (hCounter[2:0] + hScrollOffset[0][2:0]) === 3'b000;
			HB2 <= (hCounter[2:0] + hScrollOffset[1][2:0]) === 3'b000;
			
			hsyncLast <= nHSYNC;
			vsyncLast <= nVSYNC;
			
			// get the counters for the current layer
			hScrollCounter = hCounter + hScrollOffset[layer];
			vScrollCounter = vCounter + vScrollOffset[layer];
			
			// Assign SRAM address				// changes every two pixels
			if (hCounter[0] === 2'b0)
				ra_layer = layer;					// latch the layer on first pixel
				
			ra_tilemap_row = 
				vScrollCounter[7:3];		 	// row select,	0 - 31 vCounter/8
				
			ra_tilemap_column = 
				hScrollCounter[8:3];				// column select, 0 - 47 hCounter/8
				
			ra_tilemap_byte = hCounter[0];				// byte select, first or second alternates every pixel
			
			// PROM address
			ga_tile_column_nibble = hScrollCounter[2];
			ga_tile_row = vScrollCounter[2:0]; 	// row select
				
			// per layer debugging outputs
			
			// tilemap space
			tilemap_column[layer] <= hScrollCounter[8:3];
			tilemap_row[layer] <= vScrollCounter[7:3];
		
			// tile space
			tile_row[layer] <= vScrollCounter[2:0];
			tile_column[layer] <= hScrollCounter[2:0];
			tile_column_nibble[layer] <= hScrollCounter[2];
		end
	end
	
	always @(posedge CLK_6M or rst) begin
		// Data read - read on second pixel
			if (hCounter[1:0] === 2'b01)
				ga_tile_index <= RD;					// read byte 1 into tile index
			else if (hCounter[1:0] === 2'b10)
				ga_tile_attrs <= RD[1:0];				// read byte 2 lsb into tile index	
	end
	
	assign nRWE = nRCS ? 1'b1 : nWE;
	assign nROE = nRCS ? 1'b0 : ~nWE;
	assign RD = ~nRCS && ~nWE ? CD : 8'bZ;
	assign CD = ~nRCS && nWE ? RD : 8'bZ;

endmodule
