`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:14:43 05/04/2018 
// Design Name:    CUS42
// Module Name:    system86\src\custom\cus42.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS42 - Tilemap Address Generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus42
	#(
		parameter LAYER_A_AUTOSCROLL = 0,
		parameter LAYER_B_AUTOSCROLL = 0
	)
	(
		input wire rst,
			
		input wire CLK_6M,
		input wire CLK_2H,
		input wire nHSYNC,
		input wire nVSYNC,
		input wire nGCS,
		input wire nRCS,
		input wire nLATCH,
		input wire FLIP,
		input wire [13:0] CA,
		input wire nWE,
		inout wire [7:0] CD,
		inout wire [7:0] RD,
		output wire [13:0] GA,
		output wire [12:0] RA,
		output wire nRWE,
		output wire nROE,
		output wire HA2,
		output wire HB2
	);

	assign sram_layer = ~CLK_2H;
	assign prom_layer = CLK_2H;
	
	wire [8:0] H;
	wire [8:0] V;
	
	cus42_synchronous synchronous
	(
		.rst(rst),
		
		.CLK_6M(CLK_6M),
		.nHSYNC(nHSYNC),
		.nVSYNC(nVSYNC),
		.H(H),
		.V(V)
	);
	
	wire [11:0] RAA;
	wire [13:0] GAA;
	wire S3HA;
	cus42_layer 
		#
		(
			.ASSIGNED_LAYER(0)
		)
		layer_a
		(
			.rst(rst),
			
			.CLK_6M(CLK_6M),
			.FLIP(FLIP),
			.nLATCH(nLATCH || CA[2]),
			.CA(CA[2:0]),
			.CD(CD),
			.RD(RD),
			.H(H),
			.V(V),
			.RA(RAA),
			.GA(GAA),
			.S3H(S3HA)
		);
	
	wire [11:0] RAB;
	wire [13:0] GAB;
	wire S3HB;
	cus42_layer
		#
		(
			.ASSIGNED_LAYER(1)
		)
		layer_b
		(
			.rst(rst),
			
			.CLK_6M(CLK_6M),
			.FLIP(FLIP),
			.nLATCH(nLATCH || !CA[2]),
			.CA(CA[2:0]),
			.CD(CD),
			.RD(RD),
			.H(H),
			.V(V),
			.RA(RAB),
			.GA(GAB),
			.S3H(S3HB)
		);
		
	// CPU/RAM multiplexing
	assign nRWE = nRCS ? 1'b1 : nWE;
	assign nROE = nRCS ? 1'b0 : ~nWE;
	assign CD = ~nRCS && nWE ? RD : 8'bZ;
	
	assign RD = ~nRCS && ~nWE ? CD : 8'bZ;
	
	assign RA = { sram_layer, sram_layer ? RAB : RAA };
	assign GA = { prom_layer ? GAB : GAA };				

	assign HA2 = S3HA;
	assign HB2 = S3HB;
endmodule
