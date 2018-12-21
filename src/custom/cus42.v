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

	reg [7:0] DOut;     // CPU data bus
	reg ROEOut;         // RAM enable signal
	reg [7:0] RDOut;    // RAM data bus
	
	
	// 13 bits (2 layers @ 64x32 tiles, 2 byte per tile) 
	// 12 - layer (0000h or 1000h)
	// 7-11 y-offset (5 bits)
	// 1-6  x-offset (6 bits)
	// 0 - byte select
	reg [12:0] RAOut;   // RAM addr bus
    
    reg [13:0] GAOut;   // PROM addr bus
	reg HAOut;          // ? nibble or layer specific signal
    reg HBOut;          // ? alternative nibble or layer specific signal
	
	reg hsyncLast = 0;
	reg vsyncLast = 0;
	
	reg [8:0] hCounter = 0;	// 9 bits
	reg [7:0] vCounter = 0; // 8 bits
	wire [5:0] column = hCounter[8:3];
	wire [4:0] row = vCounter[7:3];
	wire [11:0] tile = (row*8)+column;
	
	// per layer inputs
	
	// scroll layer 1
	reg [8:0] hScrollOffset[0:1];	// 2 layers 9 bits
	reg [7:0] vScrollOffset[0:1];	// 2 layers 8 bits
	
	wire [8:0] hScrollCounter[0:1];	// 2 layers 9 bits 
	wire [7:0] vScrollCounter[0:1]; // 2 layers 8 bits
	
	// priority layer 1 & 2, may not be used here (see CUS43)
	reg [2:0] pri[0:1];						// 2 layers 3 bits

	reg [7:0] td1[0:1];
	reg [7:0] td2[0:1];
	
	initial begin
        hScrollOffset = 0;
        vScrollOffset = 0;
        pri = 3'b0;
        td1 = 0;
        td2 = 0;
        HAOut = 0;
        HBOut = 0;
    end
    
    assign hScrollCounter = hCounter + hScrollOffset;
    assign vScrollCounter = vCounter + vScrollOffset;
    
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
	end	
	
	always @(posedge CLK_6M) begin
        HAOut <= 0;
		HBOut <= 0;
        
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
		end 
		
        if (hScrollCounter[2:0] == 2'b000) begin
            // request byte 1
            RAOut = { 0, vScrollCounter[7:3], hScrollCounter[8:3], 0 };
		end else if (hScrollCounter[2:0] == 2'b001) begin
            // read byte 1
			td1 <= RD;
        end else if (hScrollCounter[2:0] == 2'b010) begin
            // request byte 2
            RAOut = { 0, vScrollCounter[7:3], hScrollCounter[8:3], 1 };
		end else if (hScrollCounter[2:0] == 2'b011) begin
            // read byte 2
			td2 <= RD;	
            // send first nibble
            GAOut <= { td2[1:0], td1, vScrollCounter[2:0], 0 };
			HAOut <= 1;
		end else if (hScrollCounter[2:0] == 2'b111) begin
            // send second nibble
            GAOut <= { td2[1:0], td1, vScrollCounter[2:0], 1 };
			HBOut <= 1;
		end
	end
	
	// assign outputs
	assign RA = RCS ? CA : RAOut;
	assign GA = GAOut;
	assign HA2 = ha;
	assign HB2 = hb;
	
	assign RWE = RCS ? WE : 1'b0;
	assign ROE = RCS ? !WE : 1'b1;
	assign RD = RCS && WE ? CD : 8'bZ;
	assign CD = RCS && !WE ? RD : 8'bZ;

endmodule
