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
			parameter LAYER_DISABLE_MASK = 0,
			parameter LAYER_A_PRIORITY = 0,
			parameter LAYER_B_PRIORITY = 0
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

	reg [7:0] mdi_latched [1:0];
	reg [3:0] plane0_latched [1:0];
	reg [3:0] plane1_latched [1:0];
	reg [3:0] plane2_latched [1:0];
	
	reg [7:0] attr [1:0];
	// 3 planes, 4 bits (4 pixels)
	reg [3:0] plane0_shift [1:0];
	reg [3:0] plane1_shift [1:0];
	reg [3:0] plane2_shift [1:0];
	
	// layer 1 (A)
	reg [2:0] PR_A = LAYER_A_PRIORITY;
	
	wire [7:0] CL_A = attr[0];

	// first bit of each plane buffer
	wire [2:0] DT_A = FLIP ? 
		  { plane2_shift[0][0], plane1_shift[0][0], plane0_shift[0][0] } 
		: { plane2_shift[0][3], plane1_shift[0][3], plane0_shift[0][3] };	
	
	// layer 2 (B)
	reg [2:0] PR_B = LAYER_B_PRIORITY;
	
	wire [7:0] CL_B = attr[1];
	
	// first bit of each plane buffer
	wire [2:0] DT_B = FLIP ? 
		  { plane2_shift[1][0], plane1_shift[1][0], plane0_shift[1][0] } 
		: { plane2_shift[1][3], plane1_shift[1][3], plane0_shift[1][3] };	
	
	wire layer = CLK_2H;
	reg layer_latched = 0;

	always @(negedge layer) begin
		if (rst) begin
			mdi_latched[0] <= 0;
			plane0_latched[1] <= 0;
			plane1_latched[1] <= 0;
			plane2_latched[1] <= 0;
		end else begin
			mdi_latched[0] <= MDI;
			plane0_latched[1] <= GDI[3:0];
			plane1_latched[1] <= GDI[7:4];
			plane2_latched[1] <= GDI[11:8];
		end
	end
	
	always @(posedge layer) begin
		if (rst) begin
			mdi_latched[1] <= 0;
			plane0_latched[0] <= 0;
			plane1_latched[0] <= 0;
			plane2_latched[0] <= 0;
		end else begin
			mdi_latched[1] <= MDI;
			plane0_latched[0] <= GDI[3:0];
			plane1_latched[0] <= GDI[7:4];
			plane2_latched[0] <= GDI[11:8];
		end
	end
	
	always @(posedge CLK_6M) begin
		if (rst) begin
			attr[0] <= 0;
			plane0_shift[0] <= 0;
			plane1_shift[0] <= 0;
			plane1_shift[0] <= 0;
			attr[1] <= 0;
			plane0_shift[1] <= 0;
			plane1_shift[1] <= 0;
			plane1_shift[1] <= 0;
		// layer A latch request
		end else begin
			if (HA2) begin
				attr[0] <= mdi_latched[0];
				plane0_shift[0] <= plane0_latched[0];
				plane1_shift[0] <= plane1_latched[0];
				plane2_shift[0] <= plane2_latched[0];
			end else begin
				if (FLIP) begin
					plane0_shift[0] <= plane0_shift[0] >> 1;
					plane1_shift[0] <= plane1_shift[0] >> 1;
					plane2_shift[0] <= plane2_shift[0] >> 1;
				end else begin
					plane0_shift[0] <= plane0_shift[0] << 1;
					plane1_shift[0] <= plane1_shift[0] << 1;
					plane2_shift[0] <= plane2_shift[0] << 1;
				end
			end
			
			// layer B latch request
			if (HB2) begin
				attr[1] <= mdi_latched[1];
				plane0_shift[1] <= plane0_latched[1];
				plane1_shift[1] <= plane1_latched[1];
				plane2_shift[1] <= plane2_latched[1];
			end else begin
				if (FLIP) begin
					plane0_shift[1] <= plane0_shift[1] >> 1;
					plane1_shift[1] <= plane1_shift[1] >> 1;
					plane2_shift[1] <= plane2_shift[1] >> 1;
				end else begin
					plane0_shift[1] <= plane0_shift[1] << 1;
					plane1_shift[1] <= plane1_shift[1] << 1;
					plane2_shift[1] <= plane2_shift[1] << 1;
				end
			end
		end
	end
		
	assign SELB = PR_B>PR_A;
	assign AVAL = DT_A!==7;
	assign BVAL = DT_B!==7;
	wire [6:0] STATE;
	assign STATE = { LAYER_DISABLE_MASK, (PR_B>PR_A), (PR_B>PRI), (PR_A>PRI), BVAL, AVAL };
	
	always @(posedge CLK_6M) begin
		if (rst) begin
			PRO <= 0;
			CLO <= 0;
			DTO <= 0;
		end else begin
			casex ( STATE )
				7'b0?11?1?, 7'b0?01?10 : begin
						PRO <= PR_B;
						CLO <= CL_B;
						DTO <= DT_B;
					end
				7'b?00?1?1, 7'b?01?101 : begin
						PRO <= PR_A;
						CLO <= CL_A;
						DTO <= DT_A;
					end
				default : begin
						PRO <= PRI;
						CLO <= CLI;
						DTO <= DTI;
					end
			endcase
		end
	end
	
	always @(LATCH or CA or MDI or rst) begin
		if (rst) begin
			PR_A = LAYER_A_PRIORITY;
			PR_B = LAYER_B_PRIORITY;
		end else if (LATCH) begin
			// latch priority assignments from the CPU
			if (!CA[2:0] == 3'b001) begin
				PR_A = MDI[3:1];
			end else if (!CA[2:0] == 3'b101) begin
				PR_B = MDI[3:1];
			end
		end 
	end
	
endmodule
