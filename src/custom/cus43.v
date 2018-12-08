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
    input [1:0] SYNC,
    output [2:0] PRO,
    output [7:0] CLO,
    output [2:0] DTO,
    output CLE			// hard to decipher text from schematics (not used)
    );

	assign PRO = PRI;
	//assign CLO = CLI;
	//assign DTO = DTI;
	
	assign CLO = MDI;
	assign DTO = { GDI[SYNC+8], GDI[SYNC+4], GDI[SYNC] };
	
	wire layer = CLK_2H;
	
	// scroll, may not be used
	reg [8:0] hscroll[0:1];
	reg [7:0] vscroll[0:1];
	// priority, must be used
	reg [2:0] pri[0:1];
	
	reg [4:0] state_counter = 0;
	
	integer k;
	
	initial begin
		for (k = 0; k < 2; k = k + 1) begin
			hscroll[k] = 9'b0;
			vscroll[k] = 8'b0;
			pri[k] = 3'b0;
		end
	end
		
	always @(posedge CLK_2H) begin
		state_counter <= 0;
	end
	
	always @(posedge CLK_6M) begin
		state_counter <= state_counter + 1;
	end
	
	always @(LATCH or CA or MDI) begin
		if (LATCH) begin
			if (!CA[1])
				hscroll[CA[2]][7:0] = MDI;
			else if (!CA[1:0] == 2'b01) begin
				hscroll[CA[2]][8] = MDI[0];
				pri[CA[2]] = MDI[3:1];
			end else if (!CA[1:0] == 2'b10)
				vscroll[CA[2]][7:0] = MDI;
		end 
	end
	
endmodule
