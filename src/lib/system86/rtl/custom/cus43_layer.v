`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:11:05 05/15/2018 
// Design Name:    CUS43
// Module Name:    system86\src\custom\cus43.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    CUS43 - Dual tilemap generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cus43
	#(
		parameter ASSIGNED_LAYER = 0,
		parameter LAYER_PRIORITY = 0
	)
	(
		  input rst,
		
        input wire [2:0] PRI,
        input wire [7:0] CLI,
        input wire [2:0] DTI,
        input wire [11:0] GDI,
        input wire nOE,			// hard to decipher text from schematics (held at logic high)
        input wire [2:0] CA,
        input wire nWE,
        input wire [7:0] MDI, // hard to decipher text from schematics
        input wire [2:0] HA, 	// hard to decipher text from schematics
        input wire CLK_6M,
        input wire CLK_2H,
        input wire LATCH,
        input wire FLIP,
        input wire HA2,
        input wire HB2,
        output reg [2:0] PRO,
        output reg [7:0] CLO,
        output reg [2:0] DTO,
        output wire CLE			// hard to decipher text from schematics (not used)
    );

	reg [7:0] mdi_latched;
	reg [3:0] plane0_latched;
	reg [3:0] plane1_latched;
	reg [3:0] plane2_latched;
	
	reg [7:0] attr;
	// 3 planes, 4 bits (4 pixels)
	reg [3:0] plane0_shift;
	reg [3:0] plane1_shift;
	reg [3:0] plane2_shift;
	
	// layer 1 (A)
	reg [2:0] PR = LAYER_PRIORITY;
	
	wire [7:0] CL = attr;

	// first bit of each plane buffer
	wire [2:0] DT = FLIP ? 
		  { plane2_shift[0], plane1_shift[0], plane0_shift[0] } 
		: { plane2_shift[3], plane1_shift[3], plane0_shift[3] };	
	
	wire layer = CLK_2H;
	
	always @(negedge CLK_2H) begin
		if (rst) begin
			mdi_latched <= 0;
		end else begin
			mdi_latched <= MDI;
		end
	end
	
	always @(posedge CLK_2H) begin
		if (rst) begin
			plane0_latched <= 0;
			plane1_latched <= 0;
			plane2_latched <= 0;
		end else begin
			plane0_latched <= GDI[3:0];
			plane1_latched <= GDI[7:4];
			plane2_latched <= GDI[11:8];
		end
	end
	
	always @(posedge CLK_6M) begin
		if (rst) begin
			attr <= 0;
			plane0_shift <= 0;
			plane1_shift <= 0;
			plane1_shift <= 0;
		end else begin
			if (HA2) begin
				attr <= mdi_latched[0];
				plane0_shift <= plane0_latched;
				plane1_shift <= plane1_latched;
				plane2_shift <= plane2_latched;
			end else begin
				if (FLIP) begin
					plane0_shift <= plane0_shift >> 1;
					plane1_shift <= plane1_shift >> 1;
					plane2_shift <= plane2_shift >> 1;
				end else begin
					plane0_shift <= plane0_shift << 1;
					plane1_shift <= plane1_shift << 1;
					plane2_shift <= plane2_shift << 1;
				end
			end
		end
	end
		
	always @(posedge CLK_6M) begin
		if (rst) begin
			PRO <= 0;
			CLO <= 0;
			DTO <= 0;
		end else begin
			if (DT !== 7 && PR > PRI) begin
				PRO <= PR;
				CLO <= CL;
				DTO <= DT;
			end
		end
	end
	
	always @(nLATCH or CA or MDI or rst) begin
		if (rst) begin
			PR = LAYER_PRIORITY;
		end else if (!nLATCH) begin
			// latch priority assignments from the CPU
			if (CA[2] == ASSIGNED_LAYER)
				PR = MDI[3:1];
			/*if (!CA[2:0] == 3'b001) begin
				PR = MDI[3:1];
			end else if (!CA[2:0] == 3'b101) begin
				PR_B = MDI[3:1];
			end*/
		end 
	end
	
endmodule
