`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    11:16:41 05/12/2018 
// Design Name:    CLUT
// Module Name:    system86/clut.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    CLUT subsystem - 8-bit to 12-bit (RGB) CLUT
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

module CLUT 
#(
    parameter ROM_3R = "",
    parameter ROM_3S = "",
    parameter RM1 = 220,
    parameter RM2 = 470,
    parameter RM3 = 1000,
    parameter RM4 = 2200,
    parameter BPP = 8
)
(
    input CLK_6M,
    input CLR,
    input [7:0] D,
    input BANK,
    output wire [BPP-1:0] R,
    output wire [BPP-1:0] G,
    output wire [BPP-1:0] B
);

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	

	reg [BPP-1:0] intensity_tbl [0:15];
	
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
	real saturation = (2.0**BPP)-1.0;
	initial begin
		for (i = 0; i < 16; i = i + 1) begin
			r1_1 = (i[0] * rm4_1) + (i[1] * rm3_1) + (i[2] * rm2_1) + (i[3] * rm1_1);
			//r2_1 = (!i[0] * rm4_1) + (!i[1] * rm3_1) + (!i[2] * rm2_1) + (!i[3] * rm1_1);
			r2_1 = (rm4_1 + rm3_1 + rm2_1 + rm1_1) - r1_1;
			if (r1_1 > 0) r1 = 1.0/r1_1; else r1 = 0.0;
			if (r2_1 > 0) r2 = 1.0/r2_1; else r2 = 0.0;
			//r1 = 1.0/r1_1;
			//r2 = 1.0/r2_1;
			
			if ((r1+r2) > 0)
				intensity = (saturation * (r2 / (r1 + r2)) /*+ 0.5*/);
			else
				intensity = 0.0;
			
			intensity_tbl[i] = (intensity < saturation) ? intensity : saturation;
			
			//$display("%b -> %f, %f, %f = %d", i, r1, r2, intensity, intensity_tbl[i]);
		end
	end
	
	wire [3:0] prom_3r_r;
	wire [3:0] prom_3r_g;
	wire [3:0] prom_3s_b;
	
	assign R = intensity_tbl[prom_3r_r];
	assign G = intensity_tbl[prom_3r_g];
	assign B = intensity_tbl[prom_3s_b];
	
	wire [7:0] ls273_4u_d;
	LS273 LS273_4U(
		.CLK(CLK_6M),
		.CLR(CLR),
		.D(D),
		.Q(ls273_4u_d)
		);
		
	PROM_7124 #(ROM_3R) PROM_3R(
		.E(VCC),
		.A( {BANK, ls273_4u_d} ), 
		.Q( {prom_3r_g, prom_3r_r} )
		);
		
	PROM_7116 #(ROM_3S) PROM_3S(
		.E(VCC),
		.A( {BANK, ls273_4u_d} ), 
		.Q(prom_3s_b)
		);
		
endmodule

