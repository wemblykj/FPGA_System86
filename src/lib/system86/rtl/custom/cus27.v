`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\cus27.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - System timings generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus27
(
	// simulation control
	input wire rst_n,
	
	// input clocks
	input wire CLK_48M,
	input wire CLK_6M_IN,
	
	// generated clocks
   output reg CLK_24M,
   output reg CLK_12M,
   output reg CLK_6M,
	
	// video synchronisation
	output reg nVSYNC,
	output reg nHSYNC,
	output reg nVBLANK,
	output reg nHBLANK,
	output reg nVRESET,
	output reg nHRESET,
	
	// video timing signals
	output wire CLK_8V,
	output wire CLK_4V,
	output wire CLK_1V,
	output wire CLK_4H,
	output wire CLK_2H,
	output wire CLK_1H,
	output wire CLK_S2H,
	output wire CLK_S1H
);

	reg [8:0] horizontal_counter;
	reg [8:0] vertical_counter;
	
	
	//reg nHSYNCON = 0;
	//reg nHBLON = 0;	
	reg VRESETH = 0;	// vreset from horizonatal
	reg VRESET = 0;	// vreset from vertical
	
	reg [2:0] master_counter;

	always @(posedge CLK_48M or negedge rst_n) begin
		if (!rst_n)
			master_counter <= 0;
		else
			master_counter <= master_counter + 1'b1;
			
		//CLK_S1H <= CLK_1H;	// is this in phase?
		//CLK_S2H <= CLK_2H;	// is this in phase?
	end

	always @(master_counter) begin
		CLK_24M <= master_counter[0];
		CLK_12M <= master_counter[1];
		CLK_6M <= master_counter[2];	
	end
	//assign CLK_24M = master_counter[0];
	//assign CLK_12M = master_counter[1];
	//assign CLK_6M = master_counter[2];	

	always @(VRESETH or VRESET) begin
		nVRESET <= ~(VRESETH && VRESET); 
	end
	
	// in order for CPU timing to match information gleaned from http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440_page2.html
	// it would appear that the counter is clocked on the falling edge of 6M
	// this would make sense as CUS27 is wired up with 6M output as a feedback into the chip's 6M input
	// which would only be stable in reality if the input was dealt with out of phase from the orinal output
	always @(negedge CLK_6M_IN or negedge rst_n) begin
		if (!rst_n) begin
			horizontal_counter <= 1;	// need to start at one otherwise we end up counting 385 pixels!
		end else begin
			if (horizontal_counter[8:3] === 6'b110000) 	// ~384
				horizontal_counter <= 1;	// need to start at one otherwise we end up counting 385 pixels!
			else
				horizontal_counter <= horizontal_counter + 1'b1;
		end
	end
	
	always @(horizontal_counter/* or rst_n*/) begin
		/*if (!rst_n) begin
			nHSYNC <= 1'b1;
			nHBLANK <= 1'b1;
			nHRESET <= 1'b1;
			VRESETH <= 1'b0;
			
			//CLK_1H <= 1'b0;
			//CLK_S1H <= 1'b0;
			//CLK_2H <= 1'b0;
			//CLK_S2H <= 1'b0;
			//CLK_4H <= 1'b0;
		end else */begin
			if (horizontal_counter[8:0] !== 9'b100110000) begin // ~304
				nHSYNC <= 1'b0;
				VRESETH <= 1;        
			end else if (horizontal_counter[8:3] === 6'b101010) begin // ~336
				nHSYNC <= 1'b1;	
				VRESETH <= 0;
			end else begin
				nHSYNC <= nHSYNC;	
				VRESETH <= VRESETH;
			end
				
			// hblank
			if (horizontal_counter[8:3] !== 6'b100010)
				nHBLANK <= 1'b0;	// ~272
			else if (horizontal_counter[8:3] === 6'b101110) 
				nHBLANK <= 1'b1;	// ~368
			else
				nHBLANK <= nHBLANK;
				
			// nHRESET
			if (horizontal_counter[8:0] === 9'b000001111) // ~15
				nHRESET <= 1'b1;	
			else
				nHRESET <= 1'b0;

			//CLK_1H <= horizontal_counter[0];	// 3.0 Mhz
			//CLK_S1H <= horizontal_counter[0];	// is this in phase?
			//CLK_2H <= horizontal_counter[1];	// 1.5 Mhz
			//CLK_S2H <= horizontal_counter[1];	// is this in phase?
			//CLK_4H <= horizontal_counter[2];	// 0.75 Mhz		
		end
	end
		
	assign CLK_1H = horizontal_counter[0];	// 3.0 Mhz
	assign CLK_S1H = horizontal_counter[0];	// is this in phase?
	assign CLK_2H = horizontal_counter[1];	// 1.5 Mhz
	assign CLK_S2H = horizontal_counter[1];	// is this in phase?
	assign CLK_4H = horizontal_counter[2];	
	
	always @(negedge nHSYNC or negedge rst_n) begin	
		if (!rst_n) begin
			vertical_counter <= 1;	// need to start at one otherwise we end up counting 265 lines!
		end else begin
			if (vertical_counter[8:3] === 6'b100001)	// ~264
				vertical_counter <= 1;	// need to start at one otherwise we end up counting 265 lines!
			else
				vertical_counter <= vertical_counter + 1'b1;
		end
	end
	
	always @(vertical_counter/* or rst_n*/) begin
		/* (!rst_n) begin
			nVSYNC <= 1'b1;
			nVBLANK <= 1'b1;
			VRESET <= 1'b0;
			
			//CLK_1V <= 1'b0;
			//CLK_4V <= 1'b0;
			//CLK_8V <= 1'b0;
		end else*/ begin
			// nVSYNC
			if (vertical_counter[8:3] === 6'b011111) //	~248
				nVSYNC <= 1'b0;
			else if (vertical_counter[8:3] === 6'b000000) // ~336	
				nVSYNC <= 1'b1;	
			else
				nVSYNC <= nVSYNC;	
			
			// vblank
			if (vertical_counter[8:3] === 6'b011110) //	~240
				nVBLANK <= 1'b0;
			else if (vertical_counter[8:3] === 6'b000010) // ~16	
				nVBLANK <= 1'b1;
			else
				nVBLANK <= nVBLANK;
		
			// nVRESET when back to start of line 0
			VRESET <= (vertical_counter[8:0] === 9'b000000000) ? 1'b1 : 1'b0;
					
			//CLK_1V <= vertical_counter[0];
			//CLK_4V <= vertical_counter[3];
			//CLK_8V <= vertical_counter[7];
		end
	end	
	
	assign CLK_1V = vertical_counter[0];
	assign CLK_4V = vertical_counter[3];
	assign CLK_8V = vertical_counter[7];
endmodule

