`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    14/04/2020 
// Design Name:    SCROLL H POSITION
// Module Name:    system86\src\custom\gng_scroll_position.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS42 - GnG SYNCHRONOUS 85606 - A - 2 - 5/8
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module gng_synchronous
	#(
	)
	(
		input wire rst,
			
		input wire s86_6M,
		input wire bHSYNC,
		input wire bVSYNC,
		output reg [8:0] H,
		output reg [8:0] V
	);
	
	reg s86_6M_last;
	reg hsyncLast;
	reg vsyncLast;
	
	// Synchronous - GnG 65606 - A - 2 - 5/8
	// *cheat for now - see revision in scroll position also
	always @(s86_6M or bHSYNC or bVSYNC or rst) begin
		if (rst) begin
			H <= 0;
			V <= 0;
		end else begin
			if (!bHSYNC && hsyncLast) begin
				// * H <= 9'b010000000;
				H <= 0;
				V <= V + 1;
			end else if (s86_6M && !s86_6M_last)
				H <= H + 1;
				
			if (!bVSYNC && vsyncLast)
				// * V <= 9'b011111010;
				V <= 0;
				
		end
		
		s86_6M_last <= s86_6M;
		hsyncLast <= bHSYNC;
		vsyncLast <= bVSYNC;
	end
	
endmodule
