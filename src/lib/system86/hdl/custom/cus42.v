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
module CUS42(
        input wire CLK_6M,
        input wire CLK_2H,
        input wire HSYNC,
        input wire VSYNC,
        input wire GCS,
        input wire RCS,
        input wire LATCH,
        input wire FLIP,
        input wire [13:0] CA,
        input wire WE,
        inout wire [7:0] CD,
        inout wire [7:0] RD,
        output wire [13:0] GA,
        output wire [12:0] RA,
        output wire RWE,
        output wire ROE,
        output wire HA2,
        output wire HB2
    );

	
	// 13 bits (2 layers @ 64x32 tiles, 2 byte per tile) 
	// 12 - layer (0000h or 1000h)
	// 7-11 y-offset (5 bits)
	// 1-6  x-offset (6 bits)
	// 0 - byte select
	//wire [12:0] RAOut [0:1];   // RAM addr bus
	wire [12:0] RA_ref;   // RAM addr bus
    
    //wire [13:0] GAOut [0:1];   // PROM addr bus
	
	reg HAOut;          // ? nibble or layer specific signal
    reg HBOut;          // ? alternative nibble or layer specific signal
	reg HA_ref;          // ? nibble or layer specific signal
    reg HB_ref;          // ? alternative nibble or layer specific signal
	
	reg hsyncLast = 0;
	reg vsyncLast = 0;
	
	// screen space
	reg [8:0] hCounter = 0;	// 9 bits
	reg [7:0] vCounter = 0; // 8 bits
	wire [5:0] screen_column = hCounter[8:3];
	wire [4:0] screen_row = vCounter[7:3];
	wire [11:0] screen_tile = (screen_row*8) + screen_column;
	
	wire layer = CLK_2H;
	
	// per layer inputs
	
	// scroll layer 1
	reg [8:0] hScrollOffset [0:1];	// 2 layers 9 bits
	reg [7:0] vScrollOffset[0:1];	// 2 layers 8 bits
	
	// tilemap space
	reg [8:0] hScrollCounter [0:1];	// 2 layers 9 bits 
	reg [7:0] vScrollCounter [0:1]; // 2 layers 8 bits
	wire [5:0] tilemap_column;
	wire [4:0] tilemap_row;
	
	// tile space
	wire [4:0] tile_row;		// the row of the tile
	wire [4:0] tile_row_nibble;	// which nibble of the tile row MSB or LSB
	
	// priority layer 1 & 2, may not be used here (see CUS43)
	reg [2:0] pri;						// 2 layers 3 bits

	reg [9:0] AS_ref;	// phase 1 - single layer implementation
	reg [9:0] AS [0:1];
	reg [13:0] GAOut [0:1];
	reg [12:0] RAOut [0:1];   // RAM addr bus
	wire [13:0] GA_ref;

	initial begin
        
        pri = 3'b0;
		
		AS_ref[9:0] = 0;
		
		hScrollOffset[0] = 0;
		hScrollOffset[1] = 0;
        vScrollOffset[0] = 0;
        vScrollOffset[1] = 0;
        AS[0] = 0;
		AS[1] = 0;
		GAOut[0] = 0;
		GAOut[1] = 0;
		
        HAOut = 0;
        HBOut = 0;
    end
    
	// tilemap space
    assign tilemap_column = hScrollCounter[0][8:3];
	assign tilemap_row = vScrollCounter[0][7:3];
	
	// tile space
	assign tile_row = vScrollCounter[0][2:0];
	assign tile_column = hScrollCounter[0][2:0];
	assign tile_row_nibble = hScrollCounter[0][2];
	
    // Handle CPU control requests
	always @(*) begin
		if (LATCH) begin
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
		
		hScrollCounter[0] = hCounter + hScrollOffset[0];
		hScrollCounter[1] = hCounter + hScrollOffset[1];
		vScrollCounter[0] = vCounter + vScrollOffset[0];
		vScrollCounter[1] = vCounter + vScrollOffset[1];
	end	
	
	always @(posedge CLK_6M) begin
	
		//HAOut <= 0;
		//HBOut <= 0;
        
		// handle pixel counters and resets
		hsyncLast <= HSYNC;
		vsyncLast <= VSYNC;
		
        
		if (HSYNC && !hsyncLast) begin
			hCounter <= 0;
			vCounter <= vCounter + 1;
		end else
			hCounter <= hCounter + 1;
			
		if (VSYNC && !vsyncLast) begin
			vCounter <= 0;
			// HACK to scroll each frame
			hScrollOffset[0] <= hScrollOffset[0] + 1;
			hScrollOffset[1] <= hScrollOffset[1] + 1;
		end 
		
		// need to multiplex for each layer....???
		if (hScrollCounter[0][2:0] === 3'b001) begin
			// read byte 1
			AS_ref[7:0] <= RD;
			
		end else if (hScrollCounter[0][2:0] === 3'b011) begin
			// read byte 2
			AS_ref[9:8] <= RD;
		end	
	end
	
	always @(posedge CLK_6M) begin
		if (hCounter[0] === 1'b0) begin
			// request byte
			/*if (hScrollCounter[layer][2:1] === 2'b00) begin
				RAOut[layer] <= { layer , vScrollCounter[layer][7:3], hScrollCounter[layer][8:3], hScrollCounter[layer][2] };
			end else if (hScrollCounter[layer][2:1] === 2'b10) begin
				//RAOut[layer] <= { layer , vScrollCounter[layer][7:3], hScrollCounter[layer][8:3], hScrollCounter[layer][2] };
				GAOut[layer] <= { AS[layer], vScrollCounter[layer][2:0], hScrollCounter[layer][1] };
			end else if (hScrollCounter[layer][2:1] === 2'b11) begin
				GAOut[layer] <= { AS[layer], vScrollCounter[layer][2:0], hScrollCounter[layer][1] };
			end*/
		end else if (hCounter[0] === 1'b1) begin
			if (hScrollCounter[layer][2:1] === 2'b00) begin
				// read byte 1
				AS[layer][7:0] <= RD;
			end if (hScrollCounter[layer][2:1] === 2'b10) begin
				// read byte 2
				AS[layer][9:8] <= RD[1:0];
				//GAOut_ref[layer] <= { RD[1:0], AS[layer][7:0]};
				//GAOut[layer] <= { RD[1:0], AS[layer][7:0], vScrollCounter[layer][2:0], hScrollCounter[layer][2] };
			end
		end
	end
	
	always @(negedge CLK_6M) begin
		HAOut <= 0;
		HBOut <= 0;
		HA_ref <= 0;
		HB_ref <= 0;
		
		
		if (hScrollCounter[0][2:0] === 3'b011) begin
			// commit first nibble
			HA_ref <= 1;
			
		end else if (hScrollCounter[0][2:0] === 3'b111) begin
			// commit second nibble
			HB_ref <= 1;
		end
		
		if (hScrollCounter[0][2:0] === 3'b010) begin
			// commit first layer
			HAOut <= 1;
		end
		
		if (hScrollCounter[1][2:0] === 3'b010) begin
			// commit second layer
			HBOut <= 1;
		end
	end
	
	//wire [12:0] RAOut [0:1];
	//wire [13:0] GAOut [0:1];
	
	//assign RAOut[0] = { 1'b0, vScrollCounter[7:3], hScrollCounter[8:3], hCounter[1] };
	//assign RAOut[1] = { 1'b1, vScrollCounter[7:3], hScrollCounter[8:3], hCounter[1] };
	
	//assign GAOut[0] = { AS[0], vScrollCounter[2:0], hScrollCounter[2] };
	//assign GAOut[1] = { AS[1], vScrollCounter[2:0], hScrollCounter[2] };
	
	//assign RA = { 1'b0 , vScrollCounter[7:3], hScrollCounter[8:3], ra_byte_select };
	//assign RA_ref = { 1'b0 , vScrollCounter[0][7:3], hScrollCounter[0][8:3], hScrollCounter[0][1] };
	//assign GA = { AS, vScrollCounter[2:0], ga_nibble_select };
	//assign GA = { AS, vScrollCounter[2:0], hScrollCounter[2] };
	
	assign RA = { layer , vScrollCounter[layer][7:3], hScrollCounter[layer][8:3], hScrollCounter[layer][2] };
	//RAOut[layer]; // { layer, vScrollCounter[layer][7:3], hScrollCounter[layer][8:3], hCounter[0] };
	assign GA = { AS[layer], vScrollCounter[layer][2:0], hScrollCounter[layer][1] };
	//GAOut[layer]; //{ AS[layer], vScrollCounter[layer][2:0], hScrollCounter[layer][2] };	
	assign GA_ref = { AS[layer], vScrollCounter[layer][2:0], hScrollCounter[layer][2] };
	
	assign HA2 = HAOut;
	assign HB2 = HBOut;
	
	assign RWE = RCS ? WE : 1'b0;
	assign ROE = RCS ? !WE : 1'b1;
	assign RD = RCS && WE ? CD : 8'bZ;
	assign CD = RCS && !WE ? RD : 8'bZ;

endmodule
