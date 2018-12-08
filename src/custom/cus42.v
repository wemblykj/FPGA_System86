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
    output wire [13:0] GA,
    output [12:0] RA,
    output RWE,
    output ROE,
    output [1:0] SYNC
    );

	reg [7:0] DOut;
	//reg [12:0] RAOut;
	reg ROEOut;
	reg [7:0] RDOut;
	
	reg [8:0] hcounter = 0;
	reg [8:0] hcounter_next = 0;
	reg [7:0] vcounter = 0;
	
	// per layer inputs
	
	// scroll layer 1 & 2
	reg [8:0] hscroll[0:1];
	reg [7:0] vscroll[0:1];
	// priority layer 1 & 2, may not be used
	reg [2:0] pri[0:1];
	
	// per layer outputs
	reg [13:0] GAOut[0:1];
	
	wire layer = ~CLK_2H;
	
	// 12 bits (2 layers @ 64x32 tiles, 2 byte per tile) 
	// 12 - layer (0000h or 1000h)
	// 7-11 y-offset (5 bits)
	// 1-6  x-offset (6 bits)
	// 0 - byte select
	wire [8:0] hoffset = hcounter + hscroll[layer];
	wire [7:0] voffset = vcounter + vscroll[layer];
	wire [12:0] RAOut = { layer, voffset[7:3], hoffset[8:3], state_counter };
	
	// memory access state
	reg state_counter = 0;
	
	integer l;
	
	initial begin
		
		//RAOut = 0;
		for (l = 0; l < 2; l = l + 1) begin
			GAOut[l] = 0;
			hscroll[l] = 9'b0;
			vscroll[l] = 8'b0;
			pri[l] = 3'b0;
		end
		
		hscroll[1] = 4;
		vscroll[1] = 1;
	end

always @(LATCH or CA or CD) begin
		if (LATCH) begin
			if (!CA[1])
				hscroll[CA[2]][7:0] = CD;
			else if (!CA[1:0] == 2'b01) begin
				hscroll[CA[2]][8] = CD[0];
				pri[CA[2]] = CD[3:1];
			end else if (!CA[1:0] == 2'b10)
				vscroll[CA[2]][7:0] = CD;
		end 
	end	
	
	always @(posedge CLK_2H) begin
		state_counter <= 0;
		hcounter = hcounter_next;
		hcounter_next <= hcounter_next + 1;
	end

	always @(HSYNC) begin
		if (HSYNC) begin
			hcounter_next <= 0;
			vcounter <= vcounter + 1;
		end
	end
	
	always @(VSYNC) begin
		if (VSYNC)
			vcounter <= 0;
	end
		
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
	end
	
	// assign outputs
	assign RA = RCS ? CA : RAOut;
	assign GA = GAOut[~layer];	// output layer just processed
	assign RWE = RCS ? WE : 1'b0;
	assign ROE = RCS ? !WE : 1'b1;
	assign RD = RCS && WE ? CD : 8'bZ;
	assign CD = RCS && !WE ? RD : 8'bZ;
	assign SYNC = hcounter[1:0];

endmodule
