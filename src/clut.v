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
    parameter ROM_3S = ""
)
(
    input CLK_6M,
    input CLR,
    input [7:0] D,
    input BANK,
    output wire [3:0] R,
    output wire [3:0] G,
    output wire [3:0] B
);

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire [3:0] prom_3r_r;
	wire [3:0] prom_3r_g;
	wire [3:0] prom_3s_b;
	
	assign R = prom_3r_r;
	assign G = prom_3r_g;
	assign B = prom_3s_b;
	
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

