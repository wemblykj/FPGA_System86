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
module cus43_layer
	#(
		parameter ASSIGNED_LAYER = 0,
		parameter LAYER_DISABLE_MASK = 0,
		parameter LAYER_PRIORITY = 0
	)
	(
		  input rst_n,
		
		  input wire CLK_6M,
        input wire CLK_2H,
        input wire [2:0] PRI,
        input wire [7:0] CLI,
        input wire [2:0] DTI,
        input wire [11:0] GDI,
        input wire [2:0] CA,
        input wire [7:0] MDI,
        input wire nLATCH,
        input wire FLIP,
        input wire H2,
        output reg [2:0] PRO,
        output reg [7:0] CLO,
        output reg [2:0] DTO
    );

	reg [7:0] mdi_latched;
	reg [7:0] mdi_latched2;
	reg [3:0] plane0_latched;
	reg [3:0] plane1_latched;
	reg [3:0] plane2_latched;
	
	reg [7:0] attr;
	// 3 planes, 4 bits (4 pixels)
	reg [3:0] plane0_shift;
	reg [3:0] plane1_shift;
	reg [3:0] plane2_shift;
	
	reg [2:0] PR = LAYER_PRIORITY;
	
	wire [7:0] CL = attr;

	// first_n bit of each plane buffer
	wire [2:0] DT = FLIP ? 
		  { plane2_shift[0], plane1_shift[0], plane0_shift[0] } 
		: { plane2_shift[3], plane1_shift[3], plane0_shift[3] };	
	
	always @(negedge CLK_2H) begin
		if (!rst_n) begin
			mdi_latched <= 0;
		end else begin
			mdi_latched <= MDI;
		end
	end
	
	always @(posedge CLK_2H) begin
		if (!rst_n) begin
			mdi_latched2 <= 0;
			plane0_latched <= 0;
			plane1_latched <= 0;
			plane2_latched <= 0;
		end else begin
			mdi_latched2 <= mdi_latched;
			plane0_latched <= GDI[3:0];
			plane1_latched <= GDI[7:4];
			plane2_latched <= GDI[11:8];
		end
	end
	
	always @(posedge CLK_6M) begin
		if (!rst_n) begin
			attr <= 0;
			plane0_shift <= 0;
			plane1_shift <= 0;
			plane1_shift <= 0;
		end else begin
			if (H2) begin
				attr <= mdi_latched2;
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
		
	always @(*) begin
		if (!rst_n) begin
			PRO <= 0;
			CLO <= 0;
			DTO <= 0;
		end else begin
			if (DT !== 7 && PR > PRI) begin
				PRO <= PR;
				CLO <= CL;
				DTO <= DT;
			end else begin
				PRO <= PRI;
				CLO <= CLI;
				DTO <= DTI;
			end
		end
	end
	
	always @(nLATCH or CA or MDI or rst_n) begin
		if (!rst_n) begin
			PR = LAYER_PRIORITY;
		end else if (!nLATCH) begin
			// latch priority assignments from the CPU
			if (CA[2] == ASSIGNED_LAYER)
				if (!CA[0])
					PR = MDI[3:1];
		end 
	end
	
endmodule
