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
		input _rst_n,
		
		input wire sig_6M_i,
        input wire sig_2H_i,
        input wire [2:0] sig_PRI_i,
        input wire [7:0] sig_CLI_i,
        input wire [2:0] sig_DTI_i,
        input wire [11:0] sig_GDI_i,
        input wire [2:0] sig_CA_i,
        input wire [7:0] sig_MDI_i,
        input wire sig_bLATCH_i,
        input wire sig_FLIP_i,
        input wire sig_H2_i,
        output reg [2:0] sig_PRO_o,
        output reg [7:0] sig_CLO_o,
        output reg [2:0] sig_DTO_o
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
	wire [2:0] DT = sig_FLIP_i ? 
		  { plane2_shift[0], plane1_shift[0], plane0_shift[0] } 
		: { plane2_shift[3], plane1_shift[3], plane0_shift[3] };	
	
	always @(negedge sig_2H_i) begin
		if (!_rst_n) begin
			mdi_latched <= 0;
		end else begin
			mdi_latched <= sig_MDI_i;
		end
	end
	
	always @(posedge sig_2H_i) begin
		if (!_rst_n) begin
			mdi_latched2 <= 0;
			plane0_latched <= 0;
			plane1_latched <= 0;
			plane2_latched <= 0;
		end else begin
			mdi_latched2 <= mdi_latched;
			plane0_latched <= sig_GDI_i[3:0];
			plane1_latched <= sig_GDI_i[7:4];
			plane2_latched <= sig_GDI_i[11:8];
		end
	end
	
	always @(posedge sig_6M_i) begin
		if (!_rst_n) begin
			attr <= 0;
			plane0_shift <= 0;
			plane1_shift <= 0;
			plane1_shift <= 0;
		end else begin
			if (sig_H2_i) begin
				attr <= sig_MDI_i; //mdi_latched2;
				plane0_shift <= sig_GDI_i[3:0]; // plane0_latched;
				plane1_shift <= sig_GDI_i[7:4]; // plane1_latched;
				plane2_shift <= sig_GDI_i[11:8]; // plane2_latched;
			end else begin
				if (sig_FLIP_i) begin
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
		if (!_rst_n) begin
			sig_PRO_o <= 0;
			sig_CLO_o <= 0;
			sig_DTO_o <= 0;
		end else begin
			if (DT !== 7 && PR > sig_PRI_i) begin
				sig_PRO_o <= PR;
				sig_CLO_o <= CL;
				sig_DTO_o <= DT;
			end else begin
				sig_PRO_o <= sig_PRI_i;
				sig_CLO_o <= sig_CLI_i;
				sig_DTO_o <= sig_DTI_i;
			end
		end
	end
	
	always @(sig_bLATCH_i or sig_CA_i or sig_MDI_i or _rst_n) begin
		if (!_rst_n) begin
			PR = LAYER_PRIORITY;
		end else if (!sig_bLATCH_i) begin
			// latch priority assignments from the CPU
			if (sig_CA_i[2] == ASSIGNED_LAYER)
				if (!sig_CA_i[0])
					PR = sig_MDI_i[3:1];
		end 
	end
	
endmodule
