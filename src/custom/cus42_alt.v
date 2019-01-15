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
//				   Implementation based on and inspired by Ghost 'n' Goblins
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module CUS42_ALT(
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
    
	reg hsyncLast = 0;
	reg vsyncLast = 0;
	
	// screen space
	reg [8:0] hCounter = 0;	// 9 bits
	reg [7:0] vCounter = 0; // 8 bits
	wire [5:0] screen_column = hCounter[8:3];
	wire [4:0] screen_row = vCounter[7:3];
	wire [11:0] screen_tile = (screen_row*8) + screen_column;
	
	// per layer inputs
	
	// scroll layer 1
	reg [8:0] hScrollOffset = 1;	// 2 layers 9 bits
	reg [7:0] vScrollOffset = 0;	// 2 layers 8 bits
	
	wire layer = 1'b0;
	
	// tilemap space
	reg [8:0] hScrollCounter;	// 2 layers 9 bits 
	reg [7:0] vScrollCounter; // 2 layers 8 bits
	wire [5:0] tilemap_column;
	wire [4:0] tilemap_row;
	assign tilemap_column = hScrollCounter[8:3];
	assign tilemap_row = vScrollCounter[7:3];
	
	// tile space
	wire [2:0] tile_row;		// the row of the tile
	wire [2:0] tile_column;		// the row of the tile
	wire tile_row_nibble;	// which nibble of the tile row MSB or LSB
	assign tile_row = vScrollCounter[2:0];
	assign tile_column = hScrollCounter[2:0];
	assign tile_row_nibble = hScrollCounter[2];
	
	// priority layer 1 & 2, may not be used here (see CUS43)
	reg [2:0] pri = 3'b0;						// 2 layers 3 bits

	reg [9:0] AS = 0;
	
	// GnG components
		// 2J - LS10 3-Input NAND
		reg ls10_2j_2y = 0;			

		// 4L - LS08 QUAD 2-Input AND
		reg ls08_4l_3y = 0;			

		// 5L - LS08 QUAD 2-Input AND
		reg ls08_5l_2y = 0;			
		reg ls08_5l_3y = 0;			

		// 5M - JK FLIP-FLOP
		reg ls112_5m_q = 0;
		//wire ls112_5m_q_n = ls112_5m_q;

		// 4N - 
		reg ls74_4n_1q = 0;
		reg ls74_4n_2q = 0;

		// 4N? - 
		reg ls74_4x_1q = 0;
		reg ls74_4x_2q = 0;

		// 11C - LS86 XOR (flip logic)
		reg ls86_11c_1y;
		reg ls86_11c_2y;
		reg ls86_11c_3y;

		// 10C - LS138 3-Input to 8-Line Decoder
		reg ls138_10c_1;
		reg ls138_10c_3;
		reg ls138_10c_5;
		reg ls138_10c_7;

		// 8C - LS175 D-TYPE FLIP-FLOP (inverting!)
		reg ls175_8c_1q;
		reg ls175_8c_2q;
		reg ls175_8c_3q;
		reg ls175_8c_4q;
		
	assign X6M = CLK_6M;
	assign L6M = ~X6M;
	assign H = hCounter;
	assign SH = hScrollCounter;
	
	assign X4_3H = ls74_4x_1q;
	assign X4H = ls74_4x_2q;
	assign X0H = ~ls74_4n_1q;
	assign LHBL = ls112_5m_q;

	assign S2H = ls175_8c_4q;
	assign S4H = ls175_8c_3q;
	assign S0H = ls175_8c_1q;
	assign S7H = ls138_10c_7;
	
	// Map GnG to CUS42
	assign HA2 = S4H;
	assign HB2 = S0H;
	
	// GnG support logic
    always @ (*) begin
		ls10_2j_2y <= hCounter[2:0] !== 3'b111;
		ls08_4l_3y <= hCounter[1:0] === 2'b11;
		ls08_5l_3y <= hCounter[7] & ~ls10_2j_2y;
		ls08_5l_2y <= ~hCounter[7] & ~ls10_2j_2y;
		
		// load h scroll adder (SCROLL H POSITION GnG 7/9)
		hScrollCounter <= hCounter + hScrollOffset;
		
		// buffer v counter 0H (SCROLL VIDEO RAM GnG 8/9)
		vScrollCounter <= vCounter + vScrollOffset;
		
		ls86_11c_1y <= hScrollCounter[1];
		ls86_11c_2y <= hScrollCounter[0];
		ls86_11c_3y <= hScrollCounter[2];
		ls138_10c_1 <= { ls86_11c_3y, ls86_11c_1y, ls86_11c_2y } === 3'b001;
		ls138_10c_3 <= { ls86_11c_3y, ls86_11c_1y, ls86_11c_2y } === 3'b011;
		ls138_10c_5 <= { ls86_11c_3y, ls86_11c_1y, ls86_11c_2y } === 3'b101;
		ls138_10c_7 <= { ls86_11c_3y, ls86_11c_1y, ls86_11c_2y } === 3'b111;
	end
	
	// X6M latches
	always @ (posedge X6M) begin
		if (LATCH) begin
			if (!CA[1])
				// set lower 8 bits
				hScrollOffset/*[CA[2]]*/[7:0] <= CD;
			else if (!CA[1:0] == 2'b01) begin
				// set 9th bit
				hScrollOffset/*[CA[2]]*/[8] <= CD[0];
				pri[CA[2]] <= CD[3:1];
			end else if (!CA[1:0] == 2'b10)
				// set all 8th bits
				vScrollOffset/*[CA[2]]*/[7:0] <= CD;
		end 
		
		// 3K flip-flops
		//ls74_3k_2q <= ~ls74_3k_2q;
		
		// 4N flip-flops (stage 2)
		ls74_4n_2q <= ls74_4n_1q;
		ls74_4x_2q <= ls74_4x_1q & ~hCounter[3];
	
		// scroll
		ls175_8c_1q <= ls138_10c_7;
		ls175_8c_2q <= ls138_10c_5;
		ls175_8c_3q <= ls138_10c_3;
		ls175_8c_4q <= ls138_10c_1;
	
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
			// hack to scroll each frame
			hScrollOffset <= hScrollOffset + 1;
		end 
	end
	
	// L6M latches
	always @ (posedge L6M) begin
		// 4N flip-flops (stage 1)
		ls74_4n_1q <= ls10_2j_2y;
		ls74_4x_1q <= ls08_4l_3y;
		
		if (ls08_5l_2y && ls08_5l_3y)
			ls112_5m_q <= ~ls112_5m_q;
	end
	
	always @(posedge S2H) begin
		AS[7:0] <= RD;
	end
	
	always @(posedge S4H) begin
		AS[9:8] <= RD[1:0];
	end
	
	// assign outputs
	assign RA = { layer , vScrollCounter[7:3], hScrollCounter[8:3], hScrollCounter[2] };
	assign GA = { AS, vScrollCounter[2:0], hScrollCounter[2] };
	
	assign RWE = RCS ? WE : 1'b0;
	assign ROE = RCS ? !WE : 1'b1;
	assign RD = RCS && WE ? CD : 8'bZ;
	assign CD = RCS && !WE ? RD : 8'bZ;

endmodule
