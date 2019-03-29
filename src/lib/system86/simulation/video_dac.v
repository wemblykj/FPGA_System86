`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    11:16:41 05/12/2018 
// Design Name:    video_dac
// Module Name:    system86/simulation/video_dac.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    System 86 4-bit video DAC emulation
//              
//                  Currently a bit of a hack 
//                  TODO:  need to use line impedence as part of a voltage divider calculation
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`include "common/defines.vh"

module video_dac
#(
    // Attributes of the display hardware
    parameter LINE_IMPEDENCE = 75,      
    
    // == 4-bit DAC resiter network ==
    parameter RM1 = 220,                
    parameter RM2 = 470,
    parameter RM3 = 1000,
    parameter RM4 = 2200,
    
    // == Output bit width ==
	parameter DEST_WIDTH = 8
)
(
    // == 4-bit RGB input ==
    input [3:0] RIn,
	input [3:0] GIn,
	input [3:0] BIn,
    
    // == n-bit RGB output ==
    output wire [DEST_WIDTH-1:0] R,
    output wire [DEST_WIDTH-1:0] G,
    output wire [DEST_WIDTH-1:0] B
);

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	

	reg [DEST_WIDTH-1:0] intensity_tbl [0:15];
	
	integer i;
	real rm1_1 = 1.0/RM1;
	real rm2_1 = 1.0/RM2;
	real rm3_1 = 1.0/RM3;
	real rm4_1 = 1.0/RM4;
	real r1_1;
	real r2_1;
	real r1;
	real r2;
	real intensity;
	real saturation = (2.0**DEST_WIDTH)-1.0;
	
	initial begin
		$display("intensity map");
		for (i = 0; i < 16; i = i + 1) begin
			r1_1 = (i[0] * rm4_1) + (i[1] * rm3_1) + (i[2] * rm2_1) + (i[3] * rm1_1);
			//r2_1 = (!i[0] * rm4_1) + (!i[1] * rm3_1) + (!i[2] * rm2_1) + (!i[3] * rm1_1);
			r2_1 = (rm4_1 + rm3_1 + rm2_1 + rm1_1) - r1_1;
			//if (r1_1 > 0) r1 = 1.0/r1_1; else r1 = 1.0;
			//if (r2_1 > 0) r2 = 1.0/r2_1; else r2 = 1.0;
			
			// this current calculation can most probably be simplified, but for now it is working
			// r1 = 1.0/r1_1;
			// r2 = 1.0/r2_1;
			// intensity = (saturation * (r2 / (r1 + r2)));
			
			if (r1_1 == 0 && r2_1 == 0) begin
				// r1 and r2 cancel each other out
				intensity = saturation;
			end else if (r1_1 == 0) begin
				// r1 is infinitly large and r2 is negligable
				intensity = 0.0;
			end else if (r2_1 == 0) begin
				// r2 is zero and r1 has no affect
				intensity = saturation;
			end else begin
				r1 = 1.0/r1_1;
				r2 = 1.0/r2_1;
				intensity = (saturation * (r2 / (r1 + r2)));
			end
			
			intensity_tbl[i] = (intensity < saturation) ? intensity : saturation;
			
			$display("%04d -> %f, %f, %f = %d", i, r1, r2, intensity, intensity_tbl[i]);
		end
	end
	
	assign R = intensity_tbl[RIn];
	assign G = intensity_tbl[GIn];
	assign B = intensity_tbl[BIn];
		
endmodule

