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
module cus42
	#(
		parameter LAYER_A_AUTOSCROLL = 0,
		parameter LAYER_B_AUTOSCROLL = 0
	)
	(
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
		output wire HA2,
		output wire HB2
	);

	// RA   
	// RAM addr bus
	// 13 bits (2 layers @ 64x32 tiles, 2 byte per tile) 
	// 12 - layer (0000h or 1000h)
	// 11-1 y-offset * 48 + x-offset (11 bits)
	// 11-7 y-offset (5 bits)
	// 7-1 x-offset (6 bits)
	// 0 - byte select
	//reg ra_layer = 0;
	//reg [4:0] ra_tilemap_row = 0;
	//reg [5:0] ra_tilemap_column = 0;
	//reg ra_tilemap_byte = 0;
	//assign RA = { ra_layer, ra_tilemap_row, ra_tilemap_column, ra_tilemap_byte };
	
   // wire [13:0] GA;   // PROM addr bus
	// 14 bits (
	// 12:11 - attr lsb
	// 10:6 - row
	// 7:4 - column
	// 3:1 - row
	// 0 - nibble
	//reg [1:0] ga_tile_attrs[0:1];
	//reg [7:0] ga_tile_index[0:1];
	//reg [2:0] ga_tile_row = 0;
	//reg ga_tile_column_nibble = 0;
			
	//assign GA = { ga_tile_attrs, ga_tile_index, ga_tile_row, ga_tile_column_nibble };
			
	//reg hsyncLast;
	//reg vsyncLast;
	
	// screen space
	//reg [8:0] hCounter;	// 9 bits	0 -> 384
	//reg [8:0] vCounter; // 9 bits	0 -> 264
	//wire [8:0] fhCounter;	// flipped hCounter
	
	// per layer processing
	
	// latched scroll offsets	// 2 layers 9 bits
	//reg [8:0] hScrollOffset[0:1];	// 2 layers 9 bits
	//reg [8:0] vScrollOffset[0:1];	// 2 layers 9 bits
	
	assign sram_layer = ~CLK_2H;
	assign prom_layer = CLK_2H;
	
	//wire [8:0] hScrollCounter[0:1];	// 9 bits	0 -> 384
	//wire [8:0] vScrollCounter[0:1];	// 9 bits	0 -> 264
	
	//assign fhCounter = FLIP ? (384 - hCounter) : hCounter;
	
	// horizontal adder - GnG SCROLL H POSITION 85606 - 8 -  2
	//assign hScrollCounter[0] = hScrollOffset[0] + fhCounter;
	//assign hScrollCounter[1] = hScrollOffset[1] + fhCounter;
	// vertical adder - assumed to work similar to horizontal (no vertical fliping?)
	//assign vScrollCounter[0] = vScrollOffset[0] + vCounter;
	//assign vScrollCounter[1] = vScrollOffset[1] + vCounter;
	
	// priority layer 1 & 2, may not be used here (see CUS43)
	//reg [2:0] pri;						// 2 layers 3 bits
    
		
	//
	// debug
	//
	
	// screen space
	//wire [5:0] screen_column = fhCounter[8:3];
	//wire [4:0] screen_row = vCounter[7:3];
	//wire [11:0] screen_tile = (screen_row*8) + screen_column;
	
	// tilemap space
	//reg [5:0] tilemap_column [0:1];
	//reg [4:0] tilemap_row [0:1];
	
	// tile space
	//reg [2:0] tile_row [0:1];		// the row of the tile
	//reg [2:0] tile_column [0:1];
	//reg tile_column_nibble [0:1];	// which nibble of the tile row MSB or LSB
	
	//
	// behaviour
	//
	
	// Synchronous - GnG 65606 - A - 2 - 5/8
	/*reg CLK_6M_last;
	always @(CLK_6M or nHSYNC or nVSYNC or rst) begin
		if (rst) begin
			hCounter <= 0;
			vCounter <= 0;
			hScrollOffset[0] <= 0;
			vScrollOffset[0] <= 0;
			hScrollOffset[1] <= 0;
			vScrollOffset[1] <= 0;
		end else begin
			if (!nHSYNC && hsyncLast) begin
				hCounter <= 0;
				vCounter <= vCounter + 1;
			end else if (CLK_6M && !CLK_6M_last)
				hCounter <= hCounter + 1;
				
			if (!nVSYNC && vsyncLast) begin
				vCounter <= 0;
				
				// HACK to scroll each frame
				hScrollOffset[0] <= hScrollOffset[0] + 1; //LAYER_A_AUTOSCROLL;
				hScrollOffset[1] <= hScrollOffset[1] + 1; //LAYER_B_AUTOSCROLL;
			end
		end
		
		CLK_6M_last <= CLK_6M;
		hsyncLast <= nHSYNC;
		vsyncLast <= nVSYNC;
	end*/
	
	wire [8:0] H;
	wire [8:0] V;
	
	// WIP implmentation based on GnG schematics
	cus42_synchronous synchronous
	(
		.rst(rst),
		
		.CLK_6M(CLK_6M),
		.nHSYNC(nHSYNC),
		.nVSYNC(nVSYNC),
		.H(H),
		.V(V)
	);
	
	wire [11:0] RAA;
	wire [13:0] GAA;
	wire S3HA;
	cus42_layer 
		#
		(
			.ASSIGNED_LAYER(0)
		)
		layer_a
		(
			.rst(rst),
			
			.CLK_6M(CLK_6M),
			.FLIP(FLIP),
			.nLATCH(nLATCH | CA[2]),
			.CA(CA[1:0]),
			.CD(CD),
			.RD(RD),
			.H(H),
			.V(V),
			.RA(RAA),
			.GA(GAA),
			.S3H(S3HA)
		);
	
	wire [11:0] RAB;
	wire [13:0] GAB;
	wire S3HB;
	cus42_layer
		#
		(
			.ASSIGNED_LAYER(1)
		)
		layer_b
		(
			.rst(rst),
			
			.CLK_6M(CLK_6M),
			.FLIP(FLIP),
			.nLATCH(nLATCH | ~CA[2]),
			.CA(CA[1:0]),
			.CD(CD),
			.RD(RD),
			.H(H),
			.V(V),
			.RA(RAB),
			.GA(GAB),
			.S3H(S3HB)
		);
	
	/*always @(negedge CLK_6M or rst) begin
		if (rst) begin
			pri = 3'b0;
			//hScrollOffset[0] = 0;
			//vScrollOffset[0] = 0;
			//hScrollOffset[1] = 0;
			//vScrollOffset[1] = 0;
			//ra_layer = 0;  
			//ra_tilemap_row = 0;  
			//ra_tilemap_column = 0;  
			//ra_tilemap_byte = 0;  
			/ *ga_tile_attrs[0] = 1'bX;
			ga_tile_index[0] = 1'bX;
			ga_tile_attrs[1] = 1'bX;
			ga_tile_index[1] = 1'bX;* /
			//ga_tile_row = 0;
			//ga_tile_column_nibble = 0;
			//HA2 = 0;
			//HB2 = 0;
		end else begin
			
			// neg edge just before transition to start of next nibble
			//HA2 <= (hCounter[1:0] + hScrollOffset[0][1:0]) === 2'b11;
			//HB2 <= (hCounter[1:0] + hScrollOffset[1][1:0]) === 2'b11;
			
			// Assign SRAM address				// changes every two pixels
			/ *if (hCounter[0] === 2'b0)
				ra_layer = layer;					// latch the layer on first pixel
				
			ra_tilemap_row = 
				vScrollCounter[layer][7:3];		 	// row select,	0 - 31 vCounter/8
				
			ra_tilemap_column = 
				hScrollCounter[layer][8:3];				// column select, 0 - 47 hCounter/8
				
			ra_tilemap_byte = hCounter[0];				// byte select, first or second alternates every pixel
			* /
			// PROM address
			//ga_tile_column_nibble = hScrollCounter[layer][2];
			//ga_tile_row = vScrollCounter[layer][2:0]; 	// row select
				
			// per layer debugging outputs
			
			// tilemap space
			//tilemap_column[layer] <= hScrollCounter[layer][8:3];
			//tilemap_row[layer] <= vScrollCounter[layer][7:3];
		
			// tile space
			//tile_row[layer] <= vScrollCounter[layer][2:0];
			//tile_column[layer] <= hScrollCounter[layer][2:0];
			//tile_column_nibble[layer] <= hScrollCounter[layer][2];
		end
	end
	*/
	
	/*always @(hCounter[1:0] or rst) begin
		if (rst) begin
			ga_tile_index[0] = 0;
			ga_tile_attrs[0] = 0;
			ga_tile_index[1] = 0;
			ga_tile_attrs[1] = 0;
		end else begin
			case(hCounter[1:0])
				2'b01: ga_tile_index[0] = RD;
				2'b10: ga_tile_attrs[0] = RD;
				2'b11: ga_tile_index[1] = RD;
				2'b00: ga_tile_attrs[1] = RD;
			endcase
		end
	end*/

	// Handle CPU control requests
	/*always @(*) begin
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
	end	*/
	
	// CPU/RAM multiplexing
	assign nRWE = nRCS ? 1'b1 : nWE;
	assign nROE = nRCS ? 1'b0 : ~nWE;
	assign CD = ~nRCS && nWE ? RD : 8'bZ;
	
	assign RD = ~nRCS && ~nWE ? CD : 8'bZ;
	
	//assign RA = { layer, vScrollCounter[layer][7:3], hScrollCounter[layer][8:3], hCounter[0] };
	//assign GA = { ga_tile_attrs[layer], ga_tile_index[layer], vScrollCounter[layer][2:0], hScrollCounter[layer][2] };
	
	// includes minor timing hack to replicate general propogation delay that would otherwise result in delayed results form PROM and to a lesser extend the SRAM
	assign RA = { sram_layer, sram_layer ? RAB : RAA };
	assign GA = { prom_layer ? GAB : GAA };				

	assign HA2 = S3HA;
	assign HB2 = S3HB;
endmodule
