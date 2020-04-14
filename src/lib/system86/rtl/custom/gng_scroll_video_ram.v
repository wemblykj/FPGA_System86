`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    14/04/2020 
// Design Name:    SCROLL VIDEO RAM
// Module Name:    system86\src\custom\gng_scroll_video_ram.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS42 - GnG SCROLL VIDEO RAM 85606 - B - 2 - 8/9
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module gng_scroll_video_ram
	#(
	)
	(
		input wire rst,
			
		input wire CLK_6M,
		input wire FLIP,
		input wire nSCRCS,
		input wire [8:0] SH,		// 9 bits	0 -> 384
		input wire [8:0] SV,		// 9 bits	0 -> 264
		input wire SH2,
		input reg S0H,
		input reg S2H,
		input reg S4H,
		input wire nS7H,
		input wire nSCREN,
		input wire nMRDY2
	);
	
endmodule
