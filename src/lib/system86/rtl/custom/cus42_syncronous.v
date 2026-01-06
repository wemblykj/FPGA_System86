`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    14/04/2020 
// Design Name:    SCROLL sig_H_o POSITION
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
module cus42_synchronous
	#(
	)
	(
		input wire rst,
			
		input wire sig_6M_i,
		input wire sig_bHSYNC_i,
		input wire sig_bVSYNC_i,
		output reg [8:0] sig_H_o,
		output reg [8:0] sig_V_o
	);
	
	reg sig_6M_last;
	reg hsyncLast;
	reg vsyncLast;
	
	always @(sig_6M_i or sig_bHSYNC_i or sig_bVSYNC_i or rst) begin
		if (rst) begin
			sig_H_o <= 0;
			sig_V_o <= 0;
		end else begin
			if (!sig_bHSYNC_i && hsyncLast) begin
				sig_H_o <= 0;
				sig_V_o <= sig_V_o + 1;
			end else if (sig_6M_i && !sig_6M_last)
				sig_H_o <= sig_H_o + 1;
				
			if (!sig_bVSYNC_i && vsyncLast)
				sig_V_o <= 0;
		end
		
		sig_6M_last <= sig_6M_i;
		hsyncLast <= sig_bHSYNC_i;
		vsyncLast <= sig_bVSYNC_i;
	end
	
endmodule
