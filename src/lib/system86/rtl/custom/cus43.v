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
module cus43(
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
        output wire [2:0] PRO,
        output wire [7:0] CLO,
        output wire [2:0] DTO,
        output wire CLE			// hard to decipher text from schematics (not used)
    );

	reg [7:0] mdi_latched [1:0];
	reg [3:0] plane0_latched [1:0];
	reg [3:0] plane1_latched [1:0];
	reg [3:0] plane2_latched [1:0];
	
	reg [7:0] mdi [1:0];
	// 3 planes, 4 bits (4 pixels)
	reg [3:0] plane0_shift [1:0];
	reg [3:0] plane1_shift [1:0];
	reg [3:0] plane2_shift [1:0];
	
	// layer 1 (A)
	reg [2:0] PR_A;
	reg [7:0] CL_A;

	// first bit of each plane buffer
	wire [2:0] DT_A = { plane2_shift[0][3], plane1_shift[0][3], plane0_shift[0][3] };	
	
	
	// layer 2 (B)
	reg [2:0] PR_B;
	reg [7:0] CL_B;
	
	// first bit of each plane buffer
	wire [2:0] DT_B = { plane2_shift[1][3], plane1_shift[1][3], plane0_shift[1][3] };	
	
	// perform priorty selection of layers (layer A or B)
	//wire [13:0] MUX1 = { PR_B, CL_B, DT_B };///*(DT_B != 7) && (PR_B > PR_A) ? { PR_B, CL_B, DT_B } :*/ { PR_A, CL_A, DT_A };
	// assign highest priority layer [or input] to output
	//assign {PRO, CLO, DTO } = (MUX1[2:0] != 7) && (MUX1[13:10] > PRI) ? MUX1 : { PRI, CLI, DTI };
	
	// Layer A only
	assign {PRO, CLO, DTO } = { PR_A, CL_A, DT_A };
	// Layer B only
	//assign {PRO, CLO, DTO } = { PR_B, CL_B, DT_B };
	
	wire layer = ~CLK_2H;

	initial begin
		mdi[0] = 0;
		mdi[1] = 0;
		plane0_latched[0] = 0;
		plane1_latched[0] = 0;
		plane2_latched[0] = 0;
		plane0_latched[1] = 0;
		plane1_latched[1] = 0;
		plane2_latched[1] = 0;
		PR_A = 3'b0;
		CL_A = 3'b0;
	end
	
	always @(posedge layer or negedge layer) begin
		// changed to new layer
		// latch the values for the previous layer
		mdi_latched[layer] = MDI;
		plane0_latched[layer][3:0] = GDI[3:0];
		plane1_latched[layer][3:0] = GDI[7:4];
		plane2_latched[layer][3:0] = GDI[11:8];
	end
		
	always @(negedge CLK_6M) begin
		// layer A latch request
		if (HA2) begin
			mdi[0] <= mdi_latched[0];
			plane0_shift[0] <= plane0_latched[0];
			plane1_shift[0] <= plane1_latched[0];
			plane2_shift[0] <= plane2_latched[0];
		end else begin
			plane0_shift[0] <= plane0_shift[0] << 1;
			plane1_shift[0] <= plane1_shift[0] << 1;
			plane2_shift[0] <= plane2_shift[0] << 1;
		end
		
		// layer B latch request
		if (HB2) begin
			mdi[1] <= mdi_latched[1];
			plane0_shift[1] <= plane0_latched[1];
			plane1_shift[1] <= plane1_latched[1];
			plane2_shift[1] <= plane2_latched[1];
		end else begin
			plane0_shift[1] <= plane0_shift[1] << 1;
			plane1_shift[1] <= plane1_shift[1] << 1;
			plane2_shift[1] <= plane2_shift[1] << 1;
		end
	end
		
	always @(LATCH or CA or MDI) begin
		// latch priority assignments from the CPU
		if (LATCH) begin
			if (!CA[2:0] == 3'b001) begin
				PR_A = MDI[3:1];
			end else if (!CA[2:0] == 3'b101) begin
				PR_B = MDI[3:1];
			end
		end 
	end
	
endmodule
