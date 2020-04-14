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
			
		input wire CLK_6M,
		input wire nHSYNC,
		input wire nVSYNC,
		output reg [8:0] H,
		output reg [8:0] V
	);
	
	reg hsyncLast;
	reg vsyncLast;
	
	// Synchronous - GnG 65606 - A - 2 - 5/8
	always @(posedge CLK_6M) begin
		if (rst) begin
			H <= 0;
			V <= 0;
		end else begin
			if (!nHSYNC && hsyncLast) begin
				H <= 0;
				
				if (!nVSYNC && vsyncLast)
					V <= 0;
				else
					V <= V + 1;
			end else
				H <= H + 1;
		end
		
		hsyncLast <= nHSYNC;
		vsyncLast <= nVSYNC;
	end
	
endmodule
