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
module gng_scroll_position
	#(
		parameter LAYER = 0
	)
	(
		input wire rst,
		input wire layer,
			
		input wire CLK_6M,
		input wire FLIP,
		input wire nSCRCS,
		input wire [8:0] H,	// 9 bits
		input wire [8:0] V,	// 8 bits
		input wire [8:0] hScrollOffset,	// 9 bits
		input wire [8:0] vScrollOffset,	// 9 bits
		input wire [7:0] RD,
		/*output wire [8:0] SH,		// 9 bits	0 -> 384
		output wire [8:0] SV,		// 9 bits	0 -> 264
		output reg S0H,
		output reg S2H,
		output reg S4H,
		output wire nS7H,
		output wire nSCREN,
		output wire nMRDY2,*/
		// widths as per GnG
		output wire [11:0] RA,
		output wire [13:0] GA,
		output wire nS3H
	);
	
	wire [8:0] fhCounter;
	wire [8:0] hScrollCounter;
	wire [8:0] vScrollCounter;
	/* * cheat for now - see revision in synchronous also
	wire [8:0] fH;
	
	// note: will probably only be horizontal
	assign fH[8:0] = FLIP ? ~H[8:0] : H[8:0];
	
	assign fhCounter[6:0] = fH[6:0];
	
	// something not quite working here?
	//assign fhCounter[7] = ((fH[6] ^ ~FLIP) & ~H[8]) ^ fH[7];
	assign xor_13c_1 = ~FLIP ^ fH[6];
	assign and_13d_1 = xor_13c_1 & ~H[8];
	assign xor_13c_2 = and_13d_1 ^ fH[7];
	assign fhCounter[7] = xor_13c_2;
	
	assign fhCounter[8] = ~H[8];
	*/
	
	assign fhCounter = FLIP ? (384 - H) : H;	// * for flip just subtract from width
	
	
	// horizontal adder - GnG SCROLL H POSITION 85606 - 8 -  2
	assign hScrollCounter = hScrollOffset + fhCounter;
	// vertical adder - assumed this would work similar to horizontal (no vertical fliping?)
	assign vScrollCounter = vScrollOffset + V;
	
	//assign fhScrollLsb = FLIP ? ~H[2:0] : H[2:0];
	
	wire [8:0] SH;		// 9 bits	0 -> 384
	wire [8:0] SV;		// 9 bits	0 -> 264
	reg S0H;
	reg S2H;
	reg S1H;
	reg [9:0] AS;
	//reg s6h;	// internal use only
	
	//
	// debug
	//
	
	// tilemap space
	reg [5:0] tilemap_column;
	reg [4:0] tilemap_row;
	
	// tile space
	reg [2:0] tile_row;		// the row of the tile
	reg [2:0] tile_column;
	reg tile_column_nibble;	// which nibble of the tile row MSB or LSB
	
	//
	// behaviour
	//
	
	/*
	// horizontal line demux - LS138 10C
	reg [3:0] hDemux;
	always @(hScrollCounter[2:0]) begin
		// horizontal line demux - LS138 10C
		case (hScrollCounter[2:0])
			// for now retain negation of LS138
			3'b000: hDemux <= ~8'b00000001;
			3'b001: hDemux <= ~8'b00000010;
			3'b010: hDemux <= ~8'b00000100;
			3'b011: hDemux <= ~8'b00001000;
			3'b100: hDemux <= ~8'b00010000;
			3'b101: hDemux <= ~8'b00100000;
			3'b110: hDemux <= ~8'b01000000;
			3'b111: hDemux <= ~8'b10000000;
		endcase
	end
	*/
	
	reg [3:0] hDemux;
	always @(hScrollCounter[1:0]) begin
		case (hScrollCounter[1:0])
			2'b00: hDemux <= 4'b0001;
			2'b01: hDemux <= 4'b0010;
			2'b10: hDemux <= 4'b0100;
			2'b11: hDemux <= 4'b1000;
		endcase
	end
	
	always @(posedge CLK_6M) begin
		// GnG 8C LS175 latch
		/*S0H <= ~hDemux[7];
		s6h <= ~hDemux[5];
		S4H <= ~hDemux[3];
		S2H <= ~hDemux[1];*/
		
		// System86 equivalent !?!
		// RAM speed is up from 200ns to 45ns so we can process two layers in the same time period!
		S0H <= hDemux[4];
		//s3h <= ~hDemux[3];
		
		if (hScrollCounter[2] === LAYER) begin
			S2H <= hDemux[1];
			S1H <= hDemux[0];
		end
		
		// debug
		
		// tilemap space
		tilemap_column <= SH[8:3];
		tilemap_row <= SV[7:3];
		
		// tile space
		tile_row <= SV[2:0];
		tile_column <= SH[2:0];
		tile_column_nibble <= SH[2];
	end
	
	always @(posedge S1H) begin
		AS[7:0] <= RD;
	end
	
	always @(posedge S2H) begin
		AS[9:8] <= RD[1:0];
		
		/* GnG
		AS[9:8] <= RD[7:6];
		SVFLIP <= RD[5];
		SHFLIP <= RD[4];
		ATTR <= RD[5:0]
		*/
	end
	
	/*reg S4H_last;
	reg gng_ls74_7c_1q;
	wire gng_ls74_7c_1q_n = ~gng_ls74_7c_1q;
	always @(S0H or S4H) begin
		if (S0H) // nCLR
			gng_ls74_7c_1q <= 0;
		else if (S4H && !S4H_last)
			gng_ls74_7c_1q <= 1;
			
		S4H_last = S4H;
	end
	
	reg s6h_last;
	reg gng_ls74_7c_2q;
	wire gng_ls74_7c_2q_n = ~gng_ls74_7c_2q;
	always @(s6h or gng_ls74_7c_1q) begin
		if (!gng_ls74_7c_1q)	// nCLR
			gng_ls74_7c_2q <= 0;
		else if (s6h && !s6h_last)
			gng_ls74_7c_2q <= 1;
			
		s6h_last = s6h;
	end
	
	assign nMRDY2 = ~(~gng_ls74_7c_2q & ~nSCRCS);
	assign nSCREN = ~(~gng_ls74_7c_1q_n & ~nSCRCS);
	assign nS7H = hDemux[7];		// async
	assign SH2 = SH[1];		// async*/
	assign nS3H = hDemux[3];		// async
	assign SH = { hScrollCounter[8:3], FLIP ? ~hScrollCounter[2:0] : hScrollCounter[2:0] };
	assign SV = vScrollCounter;
	/* GnG
	assign RA = { SH2, SH[8:4], SV[8:4] };	// as per GnG SH2 is offset of 0x400 to attr byte
	assign GA = { AS, V[2:0], SHFLIP ? ~SH[3] : SH[3], SVFLIP ? ~SV[3:0] : SV[3:0] };
	*/
	assign RA = { SV[7:3], SH[8:3], SH[0] };
	assign GA = { AS, SV[2:0], SH[2] };
endmodule
