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
    input [2:0] PRI,
    input [7:0] CLI,
    input [2:0] DTI,
    input [11:0] GDI,
    input OE,			// hard to decipher text from schematics (held at logic high)
    input [2:0] CA,
    input WE,
    input [7:0] MDI, // hard to decipher text from schematics
    input [2:0] HA, 	// hard to decipher text from schematics
    input CLK_6M,
    input CLK_2H,
    input LATCH,
    input FLIP,
    input HA2,
    input HB2,
    output [2:0] PRO,
    output [7:0] CLO,
    output [2:0] DTO,
    output CLE			// hard to decipher text from schematics (not used)
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
	
	reg haLast = 0;
	reg hbLast = 0;
	
	/*always @(posedge layer) begin
		gdiLatched = GDI;
		mdiLatched = MDI;
	end
	
	always @(negedge layer) begin
		gdiLatched = GDI;
		mdiLatched = MDI;
	end*/
	
	always @(posedge HA2) begin
		gdiALatched = GDI;
		mdiALatched = MDI;
		/*haLast <= HA2;
		if (HA2 && !haLast) begin
			DT_A_PLANE0_BUFFER <= GDI[3:0];
			DT_A_PLANE1_BUFFER <= GDI[7:4];
			DT_A_PLANE2_BUFFER <= GDI[11:8];
			CL_A <= MDI;
		end else begin
			DT_A_PLANE0_BUFFER <= DT_A_PLANE0_BUFFER_NEXT;
			DT_A_PLANE1_BUFFER <= DT_A_PLANE1_BUFFER_NEXT;
			DT_A_PLANE2_BUFFER <= DT_A_PLANE2_BUFFER_NEXT;
		end*/
	end
	
	/*always @(posedge HB2) begin
		gdiLatched[1] = GDI;
		mdiLatched[1] = MDI;
		/ *hbLast <= HB2;
		if (HB2 && ! hbLast) begin
			DT_B_PLANE0_BUFFER <= GDI[3:0];
			DT_B_PLANE1_BUFFER <= GDI[7:4];
			DT_B_PLANE2_BUFFER <= GDI[11:8];
			CL_B <= MDI;
		end else begin
			DT_B_PLANE0_BUFFER <= DT_B_PLANE0_BUFFER_NEXT;
			DT_B_PLANE1_BUFFER <= DT_B_PLANE1_BUFFER_NEXT;
			DT_B_PLANE2_BUFFER <= DT_B_PLANE2_BUFFER_NEXT;
		end* /
	end*/
	
	always @(negedge CLK_6M) begin
		/*DT_A_PLANE0_BUFFER_NEXT <= DT_A_PLANE0_BUFFER << 1;
		DT_A_PLANE1_BUFFER_NEXT <= DT_A_PLANE1_BUFFER << 1;
		DT_A_PLANE2_BUFFER_NEXT <= DT_A_PLANE2_BUFFER << 1;
		
		DT_B_PLANE0_BUFFER_NEXT <= DT_B_PLANE0_BUFFER << 1;
		DT_B_PLANE1_BUFFER_NEXT <= DT_B_PLANE1_BUFFER << 1;
		DT_B_PLANE2_BUFFER_NEXT <= DT_B_PLANE2_BUFFER << 1;*/
		
		// forever shift the low buffer shifting in the LSB from the high buffer
		/*DT_A_PLANE0_BUFFER_L[3] = DT_A_PLANE0_BUFFER_H[0];
		DT_A_PLANE1_BUFFER_L[3] = DT_A_PLANE1_BUFFER_H[0];
		DT_A_PLANE2_BUFFER_L[3] = DT_A_PLANE2_BUFFER_H[0];
		DT_A_PLANE0_BUFFER_L[2:0] <= DT_A_PLANE0_BUFFER_L[3:1];
		DT_A_PLANE1_BUFFER_L[2:0] <= DT_A_PLANE1_BUFFER_L[3:1];
		DT_A_PLANE2_BUFFER_L[2:0] <= DT_A_PLANE2_BUFFER_L[3:1];*/
		haLast <= (HA2);
		hbLast <= (HB2);
		
		if (HA2 && !haLast) begin
			DT_A_PLANE0_BUFFER <= gdiALatched[3:0];
			DT_A_PLANE1_BUFFER <= gdiALatched[7:4];
			DT_A_PLANE2_BUFFER <= gdiALatched[11:8];
			//DT_A_PLANE0_BUFFER <= GDI[3:0];//gdiLatched[0][3:0];
			//DT_A_PLANE1_BUFFER <= GDI[7:4];//gdiLatched[0][7:4];
			//DT_A_PLANE2_BUFFER <= GDI[11:8];//gdiLatched[0][11:8];
			//CL_A <= MDI;
			CL_A <= mdiALatched;
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
		
		/*if (HB2 && !hbLast) begin
			// load 4 x 3bpp values from bus
			DT_B_PLANE0_BUFFER <= GDI[3:0];
			DT_B_PLANE1_BUFFER <= GDI[7:4];
			DT_B_PLANE2_BUFFER <= GDI[11:8];
			CL_B <= MDI;
		end else begin
			// when not loading we are forever shifting
			// TODO: flip support
			DT_B_PLANE0_BUFFER <= DT_B_PLANE0_BUFFER << 1;
			DT_B_PLANE1_BUFFER <= DT_B_PLANE1_BUFFER << 1;
			DT_B_PLANE2_BUFFER <= DT_B_PLANE2_BUFFER << 1;	
		end*/
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
