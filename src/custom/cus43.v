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
module CUS43(
        input wire [2:0] PRI,
        input wire [7:0] CLI,
        input wire [2:0] DTI,
        input wire [11:0] GDI,
        input wire OE,			// hard to decipher text from schematics (held at logic high)
        input wire [2:0] CA,
        input wire WE,
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

	//reg [11:0] gdiLatched;
	//reg [7:0] mdiLatched;
	reg [11:0] gdiALatched;
	reg [7:0] mdiALatched;
	reg [11:0] gdiBLatched;
	reg [7:0] mdiBLatched;
	
	// layer 1 (A)
	reg [2:0] PR_A;
	reg [7:0] CL_A;
	// 3 planes, 4 bits (4 pixels) with 4-bit delay line
	reg [3:0] DT_A_PLANE0_BUFFER;
	reg [3:0] DT_A_PLANE1_BUFFER;
	reg [3:0] DT_A_PLANE2_BUFFER;

	// first bit of each plane buffer
	wire [2:0] DT_A = { DT_A_PLANE2_BUFFER[3], DT_A_PLANE1_BUFFER[3], DT_A_PLANE0_BUFFER[3] };	
	
	// layer 2 (B)
	reg [2:0] PR_B;
	reg [7:0] CL_B;
	// 3 planes, 4 bits (4 pixels)
	reg [3:0] DT_B_PLANE0_BUFFER;
	reg [3:0] DT_B_PLANE1_BUFFER;
	reg [3:0] DT_B_PLANE2_BUFFER;

	// first bit of each plane buffer
	wire [2:0] DT_B = { DT_B_PLANE2_BUFFER[3], DT_B_PLANE1_BUFFER[3], DT_B_PLANE0_BUFFER[3] };	
	
	// perform priorty selection of layers (layer A or B)
	wire [13:0] MUX1 = /*(DT_B != 7) && (PR_B > PR_A) ? { PR_B, CL_B, DT_B } :*/ { PR_A, CL_A, DT_A };
	// assign highest priority layer [or input] to output
	//assign {PRO, CLO, DTO } = (MUX1[2:0] != 7) && (MUX1[13:10] > PRI) ? MUX1 : { PRI, CLI, DTI };
	
	// Layer 1 only
	assign {PRO, CLO, DTO } = { PR_A, CL_A, DT_A };
	//assign {PRO, CLO, DTO } = { PR_B, CL_B, DT_B };
	
	wire layer = CLK_2H;

	initial begin
		PR_A = 3'b0;
		CL_A = 3'b0;
		DT_A_PLANE0_BUFFER = 4'b0;
		DT_A_PLANE1_BUFFER = 4'b0;
		DT_A_PLANE2_BUFFER = 4'b0;
		gdiALatched = 0;
		mdiALatched = 0;
		
		PR_B = 3'b0;
		CL_B = 3'b0;
		DT_B_PLANE0_BUFFER = 4'b0;
		DT_B_PLANE1_BUFFER = 4'b0;
		DT_B_PLANE2_BUFFER = 4'b0;
		gdiBLatched = 0;
		mdiBLatched = 0;
	end
	
	reg haSig = 0;
	reg haLast = 0;
	reg hbSig = 0;
	reg hbLast = 0;
	
	always @(HA2) begin
		if (HA2) begin
			mdiALatched <= MDI;
			gdiALatched <= GDI;
			haSig <= 0;
		end else begin
			haSig <= 1;
		end
	end
	
	always @(HB2) begin
		if (HB2) begin
			mdiBLatched <= MDI;
			gdiBLatched <= GDI;
			hbSig <= 0;
		end else begin
			hbSig <= 1;
		end
	end
	
	always @(posedge CLK_6M) begin

		haLast <= (haSig);
		hbLast <= (hbSig);
		
		if (haSig && !haLast) begin
			DT_A_PLANE0_BUFFER <= gdiALatched[3:0];
			DT_A_PLANE1_BUFFER <= gdiALatched[7:4];
			DT_A_PLANE2_BUFFER <= gdiALatched[11:8];

			CL_A <= mdiALatched;
		end else if (hbSig && !hbLast) begin
			DT_A_PLANE0_BUFFER <= gdiBLatched[3:0];
			DT_A_PLANE1_BUFFER <= gdiBLatched[7:4];
			DT_A_PLANE2_BUFFER <= gdiBLatched[11:8];
		end else begin
			// when not loading we are forever shifting
			// TODO: flip support
			//DT_A_PLANE0_BUFFER_H <= DT_A_PLANE0_BUFFER_H >> 1;
			//DT_A_PLANE1_BUFFER_H <= DT_A_PLANE1_BUFFER_H >> 1;
			//DT_A_PLANE2_BUFFER_H <= DT_A_PLANE2_BUFFER_H >> 1;
			DT_A_PLANE0_BUFFER <= DT_A_PLANE0_BUFFER << 1;
			DT_A_PLANE1_BUFFER <= DT_A_PLANE1_BUFFER << 1;
			DT_A_PLANE2_BUFFER <= DT_A_PLANE2_BUFFER << 1;
		end

	end
	
	always @(LATCH or CA or MDI) begin
		if (LATCH) begin
			if (!CA[2:0] == 3'b001) begin
				PR_A = MDI[3:1];
			end else if (!CA[2:0] == 3'b101) begin
				PR_B = MDI[3:1];
			end
		end 
	end
	
endmodule
