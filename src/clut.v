`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: P.Wightmore
// 
// Create Date:    11:16:41 05/12/2018 
// Design Name: 
// Module Name:    clut 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 8-bit to 12-bit (RGB) CLUT
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CLUT(
	 input CLK_6M,
	 input CLR,
    input [7:0] D,
    input BANK,
	 output wire [BPP-1:0] R,
	 output wire [BPP-1:0] G,
	 output wire [BPP-1:0] B
    );

	parameter FILE_NAME_3R = "";
	parameter FILE_NAME_3S = "";
	parameter RM1 = 220;
	parameter RM2 = 470;
	parameter RM3 = 1000;
	parameter RM4 = 2200;
	parameter BPP = 8;
	
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
			r1 = 1.0/r1_1;
			r2 = 1.0/r2_1;
			intensity = (saturation * (r2 / (r1 + r2)) /*+ 0.5*/);
			
			intensity_tbl[i] = (intensity < saturation) ? intensity : saturation;
			
			//$display("%b -> %f, %f, %f = %d", i, r1, r2, intensity, intensity_tbl[i]);
		end
	end
	
	supply1 VCC;
	
	wire [3:0] r;
	wire [3:0] g;
	wire [3:0] b;
	
	assign R = intensity_tbl[r];
	assign G = intensity_tbl[g];
	assign B = intensity_tbl[b];
	
	reg [7:0] ls273_4u_d;
	LS273 LS273_4U(
		.CLK(CLK_6M),
		.CLR(CLR),
		.D(D),
		.Q(ls273_4u_d)
		);
		
	PROM_FILE #(9, 8, FILE_NAME_3R) PROM_3R(
		.OE(VCC),
		.CE(VCC), 
		.A( {BANK, ls273_4u_d} ), 
		.Q( {g, r} )
		);
		
	PROM_FILE #(9, 4, FILE_NAME_3S) PROM_3S(
		.OE(VCC),
		.CE(VCC), 
		.A( {BANK, ls273_4u_d} ), 
		.Q(b)
		);
		
endmodule

