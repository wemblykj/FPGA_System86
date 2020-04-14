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
	)
	(
		input wire rst,
			
		input wire CLK_6M,
		input wire FLIP,
		input wire nSCRCS,
		input wire [8:0] H,	// 9 bits
		input wire [8:0] V,	// 8 bits
		input wire [8:0] hScrollOffset,	// 9 bits
		input wire [8:0] vScrollOffset,	// 9 bits
		output wire [8:0] SH,		// 9 bits	0 -> 384
		output wire [8:0] SV,		// 9 bits	0 -> 264
		output reg S0H,
		output reg S2H,
		output reg S4H,
		output wire nS7H,
		output wire nSCREN,
		output wire nMRDY2
	);
	
	wire [8:0] fH;
	wire [8:0] fhCounter;
	//wire [2:0] fhCounterLsb;			// 3 bits
	
	// note: will probably only be horizontal
	assign fH[8:0] = FLIP ? ~H[8:0] : H[8:0];
	
	assign fhCounter[6:0] = fH[6:0];
	assign fhCounter[7] = ((fH[6] ^ ~FLIP) & ~H[8]) ^ fH[7];
	assign fhCounter[8] = ~H[8];
	
	// horizontal adder - GnG SCROLL H POSITION 85606 - 8 -  2
	assign SH = hScrollOffset + fhCounter;
	// vertical adder - assumed this would work similar to horizontal (no vertical fliping?)
	assign SV = vScrollOffset + V;
	
	//assign fhScrollLsb = FLIP ? ~H[2:0] : H[2:0];
	
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
	
	reg [7:0] hDemux;
	always @(fhCounter[2:0]) begin
		// horizontal line demux - LS138 10C	
		case (fhCounter[2:0])
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
	
	reg s6h;	// internal use only
	
	always @(posedge CLK_6M) begin
		// GnG 8C LS175 latch
		S0H <= ~hDemux[7];
		s6h <= ~hDemux[3];
		S4H <= ~hDemux[3];
		S2H <= ~hDemux[3];
		
		// debug
		
		// tilemap space
		tilemap_column <= SH[8:3];
		tilemap_row <= SV[7:3];
		
		// tile space
		tile_row <= SV[2:0];
		tile_column <= SH[2:0];
		tile_column_nibble <= SH[2];
	end
	
	reg gng_ls74_7c_1q;
	always @(posedge S4H) begin
		if (!hDemux[7])
			gng_ls74_7c_1q <= 0;
		else
			gng_ls74_7c_1q <= 1;
	end
	
	reg gng_ls74_7c_2q;
	always @(posedge s6h) begin
		if (!gng_ls74_7c_1q)
			gng_ls74_7c_2q <= 0;
		else
			gng_ls74_7c_2q <= 1;
	end
	
	assign nMRDY2 = ~(~gng_ls74_7c_2q && ~nSCRCS);
	assign nSCREN = ~(gng_ls74_7c_1q && ~nSCRCS);
	assign nSH2 = fhCounter[1];	// async
	assign nS7H = hDemux[7];		// async
endmodule
