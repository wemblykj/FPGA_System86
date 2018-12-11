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
    input CLK_6M,
    input CLK_2H,
    input HSYNC,
    input VSYNC,
    input GCS,
    input RCS,
    input LATCH,
    input FLIP,
    input [13:0] CA,
    input WE,
    inout [7:0] CD,
    inout [7:0] RD,
    output [13:0] GA,
    output [12:0] RA,
    output RWE,
    output ROE,
    output HA2,
    output HB2
    );

	reg [7:0] DOut;
	//reg [12:0] RAOut;
	reg ROEOut;
	reg [7:0] RDOut;
	
	//reg HA2 = 0;
	//reg HB2 = 0;
	
	// per layer outputs
	//wire [13:0] GAOut[0:1];
	
	// 13 bits (2 layers @ 64x32 tiles, 2 byte per tile) 
	// 12 - layer (0000h or 1000h)
	// 7-11 y-offset (5 bits)
	// 1-6  x-offset (6 bits)
	// 0 - byte select
	wire [12:0] RAOut[0:1];
	reg [13:0] GA;
	
	reg hsyncLast = 0;
	reg vsyncLast = 0;
	
	reg [8:0] hCounter = 0;	// 9 bits
	reg [7:0] vCounter = 0; // 8 bits
	wire [5:0] column = hCounter[8:3];
	wire [4:0] row = vCounter[7:3];
	wire [11:0] tile = (row*8)+column;
	
	// per layer inputs
	
	// scroll layer 1 & 2
	reg [8:0] hScrollOffset[0:1];	// 2 layers 9 bits
	reg [7:0] vScrollOffset[0:1];	// 2 layers 8 bits
	
	wire [8:0] hScrollCounter[0:1];	// 2 layers 9 bits 
	wire [7:0] vScrollCounter[0:1]; // 2 layers 8 bits
	wire [5:0] sColumn[0:1];
	wire [4:0] sRow[0:1];
	wire [11:0] sTile[0:1];
	
	wire [2:0] tx[0:1];
	wire [2:0] ty[0:1];
	reg h2[0:1];
	
	// priority layer 1 & 2, may not be used here (see CUS43)
	reg [2:0] pri[0:1];						// 2 layers 3 bits

	reg [7:0] td1[0:1];
	reg [7:0] td2[0:1];
	
	wire layer = ~CLK_2H;
	
	genvar l;
	generate
		for (l = 0; l < 2 ; l = l + 1) begin
			initial begin
				hScrollOffset[l] = 0;
				vScrollOffset[l] = 0;
				pri[l] = 3'b0;
				td1[l] = 0;
				td2[l] = 0;
				h2[l] = 0;
			end
			assign hScrollCounter[l] = hCounter + hScrollOffset[l];
			assign vScrollCounter[l] = vCounter + vScrollOffset[l];
			assign sColumn[l] = hScrollCounter[l][8:3];
			assign sRow[l] = vScrollCounter[l][7:3];
			assign sTile[l] = (sRow[l]*8)+sColumn[l];
			assign RAOut[l] = { l, sRow[l], sColumn[l], hScrollCounter[l][0] };
			assign tx[l] = hScrollCounter[l][2:0];
			assign ty[l] = vScrollCounter[l][2:0];
		end
	endgenerate

	assign HA2 = h2[0];
	assign HB2 = h2[1];
	
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
	end	
	
	/*always @(negedge CLK_6M) begin
		if (hScrollCounter[layer][1:0] == 2'b11) begin
			td2[layer] = RD;
			GA = { td2[layer][1:0], td1[layer], ty[layer], tx[layer][2] };
			h2[layer] = 1;
		end
	end*/
	
	always @(posedge CLK_6M) begin
		// handle pixel counters and resets
		hsyncLast <= HSYNC;
		vsyncLast <= VSYNC;
		h2[0] <= 0;
		h2[1] <= 0;
		if (HSYNC && !hsyncLast) begin
			hCounter <= 0;
			vCounter <= vCounter + 1;
		end else
			hCounter <= hCounter + 1;
			
		if (VSYNC && !vsyncLast) begin
			vCounter <= 0;
		end 
		
		if (hScrollCounter[layer][1:0] == 2'b01) begin
			td1[layer] <= RD;
		end else if (hScrollCounter[layer][1:0] == 2'b11) begin
			td2[layer] <= RD;
			GA <= { td2[layer][1:0], td1[layer], ty[layer], tx[layer][2] };
			h2[layer] <= 1;
		//end else if (hScrollCounter[layer][1:0] == 2'b11) begin
			
		end
	end
	
	/*reg clkLatched;
	always @(*) begin
		#5 clkLatched <= CLK_6M;
	end
	
	always @(posedge clkLatched) begin
		//HA2 = 0;
		//HB2 = 0;
		h2[0] = 0;
		h2[1] = 0;
		if (hScrollCounter[layer][1:0] == 2'b11) begin
			GA <= { td2[layer][1:0], td1[layer], ty[layer], tx[layer][2] };
			h2[layer] <= 1;
		end
		
		/ *if (hCounter[1:0] == 2'b00) begin
			td2 = 0;//RD;
			// possibly we have reversed nibbles so last 4 pixels are first
			GA = 0;//{ td2, td1, vScrollCounter[0][2:0], hScrollCounter[0][2] };
			//GA = { RD[1:0], td1, hScrollCounter[layer][2], vScrollCounter[layer][2:0] };
			HB2 = 1;
			
			//RAOut = { 0, vScrollCounter[0][7:3], hScrollCounter[0][8:3], 0 };
		end else if (hCounter[1:0] == 2'b01) begin
			td1 = RD;
			//RAOut = { 0, vScrollCounter[0][7:3], hScrollCounter[0][8:3], 1 };
		end else if (hCounter[1:0] == 2'b10) begin
			td2 = RD;

			// possibly we have reversed nibbles so last 4 pixels are first
			GA = { td2, td1, vScrollCounter[0][2:0], hScrollCounter[0][2] };
			//GA = { RD[1:0], td1, hScrollCounter[layer][2], vScrollCounter[layer][2:0] };
			HA2 = 1;
			
			//RAOut = { 1, vScrollCounter[1][7:3], hScrollCounter[1][8:3], 0 };
		end else if (hCounter[1:0] == 2'b11) begin
			td1 = 0;//RD;
			//RAOut = 12'b1; //{ 1, vScrollCounter[1][7:3], hScrollCounter[1][8:3], 1 };		
		end
		* /
		/ *if (hCounter[2:0] == 3'b010) begin
			//GA = { td2, td1, vScrollCounter[layer][2:0], hScrollCounter[layer][2] };
			HA2 = 1;
		end* /
	end
	*/
	
	/*always @(negedge CLK_6M) begin
	always @(negedge CLK_6M) begin
		case (state_counter)
				// tile addr b7-0
				0 : begin
					GAOut[layer][11:4] <= RD;
				end
				// data 2
				1 : begin
					// tile select plus scroll lsb (nibble precision)
					// 4-13 - tile addr
					//   12-13 - data2 lsb
					//   4-11 - data 1
					// 1-3 - line select (line 1-8)
					// 0 - nibble select (pixels 1-4 or 5-8)
					
					// tile addr b9-8
					GAOut[layer][13:12] = RD[1:0];
					GAOut[layer][3:1] = voffset[2:0];
					GAOut[layer][0] = hoffset[2];	// per 4 pixel select 
				end
			endcase
			
			state_counter <= state_counter + 1;
	end*/
	
	// assign outputs
	//assign RAOut = { layer, row, column, ~hCounter[0] };
	assign RA = RCS ? CA : RAOut[layer];
	//assign GA = { td2[1:0], td1, vScrollCounter[layer][2:0], hScrollCounter[layer][2] };		
	
	// output the layer just processed
	
	//assign GA = layer ? { td2[1][1:0], td1[1], ty[1], tx[1][2] } : { td2[0][1:0], td1[0], ty[0], tx[0][2] };		
	
	assign RWE = RCS ? WE : 1'b0;
	assign ROE = RCS ? !WE : 1'b1;
	assign RD = RCS && WE ? CD : 8'bZ;
	assign CD = RCS && !WE ? RD : 8'bZ;
	//assign HA2 = layer && hScrollCounter[0][1:0] === 3'b10;	// 
	//assign HB2 = !layer && hScrollCounter[1][1:0] === 3'b10;

endmodule
