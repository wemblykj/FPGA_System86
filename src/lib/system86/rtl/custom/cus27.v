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
	input wire rst,
	
	// input clocks
	input wire CLK_48M,
	input wire CLK_6M_IN,
	
	// generated clocks
   output wire CLK_24M,
   output wire CLK_12M,
   output wire CLK_6M,
	
	// video synchronisation
	output reg nVSYNC,
	output reg nHSYNC,
	output reg nVBLANK,
	output reg nHBLANK,
	output reg nVRESET,
	output reg nHRESET,
	
	// video timing signals
	output reg CLK_8V,
	output reg CLK_4V,
	output reg CLK_1V,
	output reg CLK_4H,
	output reg CLK_2H,
	output reg CLK_1H,
	output reg CLK_S2H,
	output reg CLK_S1H
);

	reg [8:0] horizontal_counter = 0;
	reg [8:0] vertical_counter = 0;
	
	
	reg nHSYNCON = 0;
	reg nHBLON = 0;	
	reg VRESETH = 0;	// vreset from horizonatal
	reg VRESET = 0;	// vreset from vertical
	
	reg [2:0] master_counter = 0;

	//reg rst_last = 0;
	always @(posedge CLK_48M) begin
		//if (rst && !rst_last)
		//	master_counter <= 0;
		//else
		master_counter <= master_counter + 1;
			
		//CLK_S1H <= CLK_1H;	// is this in phase?
		//CLK_S2H <= CLK_2H;	// is this in phase?
		//rst_last = rst;
	end

	assign CLK_24M = master_counter[0];
	assign CLK_12M = master_counter[1];
	assign CLK_6M = master_counter[2];	

	// inspired by information found @ http://www.ukvac.com/forum/namco-cus27-in-fpga-cus130-wip_topic362440.html
	/*always @(negedge CLK_6M_IN) begin
		if (rst) begin
			horizontal_counter <= 0;
		end else begin
			horizontal_counter = horizontal_counter + 1;
			if (horizontal_counter[8:3] === 6'b110000) 	// ~384
			horizontal_counter = 0;
		end
	end*/
		
	always @(horizontal_counter) begin
		nHSYNCON <= horizontal_counter[8:0] !== 9'b100110000;	
		nHBLON <= horizontal_counter[8:3] !== 6'b100010;	
	end
	
	always @(VRESETH or VRESET) begin
		nVRESET <= ~(VRESETH && VRESET); 
	end
	
	reg rst_last = 0;
	always @(posedge CLK_6M_IN) begin
		if (rst && ~rst_last) begin
			horizontal_counter <= 0;
			
			nHSYNC <= 1'b1;
			nHBLANK <= 1'b1;
			nHRESET <= 1'b1;
			VRESETH <= 1'b0;
			
			CLK_1H <= 1'b0;
			CLK_S1H <= 1'b0;
			CLK_2H <= 1'b0;
			CLK_S2H <= 1'b0;
			CLK_4H <= 1'b0;
		end else begin
			horizontal_counter <= horizontal_counter + 1;
			if (horizontal_counter[8:3] === 6'b110000) 	// ~384
				horizontal_counter <= 0;
			// nHSYNC
			
			// ~304
			if (!nHSYNCON)
				nHSYNC <= 1'b0;	
			
			if (horizontal_counter[8:3] === 6'b101010) 
				nHSYNC <= 1'b1;	// ~336
				
			// hblank
			if (nHBLON)	// horizontal_counter[8:3] === 6'b100010
				nHBLANK <= 1'b0;	// ~272
		
			if (horizontal_counter[8:3] === 6'b101110) 
				nHBLANK <= 1'b1;	// ~368
				
			// nHRESET
			if (horizontal_counter[8:0] === 9'b000001111) // ~15
				nHRESET <= 1'b1;	
			else
				nHRESET <= 1'b0;

			VRESETH <= ~nHSYNCON;
		
			CLK_1H <= horizontal_counter[0];	// 3.0 Mhz
			CLK_S1H <= horizontal_counter[0];	// is this in phase?
			//CLK_S1H <= CLK_1H;	// is this in phase?
			CLK_2H <= horizontal_counter[1];	// 1.5 Mhz
			CLK_S2H <= horizontal_counter[1];	// is this in phase?
			//CLK_S2H <= CLK_2H;	// is this in phase?
			CLK_4H <= horizontal_counter[2];	// 0.75 Mhz
		
		end
		
		rst_last <= rst;
	end
		
	always @(negedge nHSYNC) begin
		if (rst) begin
			nVSYNC <= 1'b1;
			nVBLANK <= 1'b1;
			VRESET <= 1'b0;
			
			CLK_1V <= 1'b0;
			CLK_4V <= 1'b0;
			CLK_8V <= 1'b0;
			
			vertical_counter <= 0;
		end else begin
			vertical_counter = vertical_counter + 1;
			if (vertical_counter[8:3] === 6'b100001)	// ~264
				vertical_counter = 0;
				
			// nVSYNC
			if (vertical_counter[8:3] === 6'b011111) //	~248
				nVSYNC <= 1'b0;
			
			if (vertical_counter[8:3] === 6'b000000) // ~336	
				nVSYNC <= 1'b1;	
			
			// vblank
			if (vertical_counter[8:3] === 6'b011110) //	~240
				nVBLANK <= 1'b0;
			
			if (vertical_counter[8:3] === 6'b000010) // ~16	
				nVBLANK <= 1'b1;
		
			// nVRESET when back to start of line 0
			VRESET <= (vertical_counter[8:0] === 9'b000000000) ? 1'b1 : 1'b0;
					
			CLK_1V <= vertical_counter[0];
			CLK_4V <= vertical_counter[3];
			CLK_8V <= vertical_counter[7];
		end
	end	
endmodule

