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
		input wire rst_n,
			
		input wire CLK_6M,
		input wire CLK_2H,
		input wire nHSYNC,
		input wire nVSYNC,
		input wire nGCS,
		input wire nRCS,
		input wire nLATCH,
		input wire FLIP,
		input wire [13:0] CA,
		input wire RnW,
		inout wire [7:0] CD,
		inout wire [7:0] RD,
		output wire [13:0] GA,
		output wire [12:0] RA,
		output wire nRWE,
		output wire nROE,
		output wire HA2,
		output wire HB2
	);

   wire enable_layer_a = CLK_2H;
	wire enable_layer_b = ~CLK_2H;
	
	wire [11:0] RAA;
	wire [13:0] GAA;
	wire S3HA;
	cus42_layer 
		layer_a
		(
			.rst_n(rst_n),
			.active(enable_layer_a),
			.CLK_6M(CLK_6M),
			.FLIP(FLIP),
			.nLATCH(nLATCH | CA[2]),
			.CA(CA[1:0]),
			.CD(CD),
			.RD(RD),
			.nHSYNC(nHSYNC),
			.nVSYNC(nVSYNC),
			.RA(RAA),
			.GA(GAA),
			.S3H(S3HA)
		);
	
	wire [11:0] RAB;
	wire [13:0] GAB;
	wire S3HB;
	cus42_layer
		layer_b
		(
			.rst_n(rst_n),
			.active(enable_layer_b),
			.CLK_6M(CLK_6M),
			.FLIP(FLIP),
			.nLATCH(nLATCH | ~CA[2]),
			.CA(CA[1:0]),
			.CD(CD),
			.RD(RD),
			.nHSYNC(nHSYNC),
			.nVSYNC(nVSYNC),
			.RA(RAB),
			.GA(GAB),
			.S3H(S3HB)
		);

	reg write_done_request;
	always @(posedge CLK_6M) begin
		write_done_request <= ~RnW;
	end

	// CPU/RAM multiplexing
	assign nRWE = nRCS | RnW | write_done_request;
	assign nROE = ~nRCS ? ~RnW : 1'b0;
	
	assign CD = (~nRCS & RnW) ? RD : 8'bz;
	assign RD = (~nRCS & ~RnW) ? CD : 8'bz;
	
	assign RA = ~nRCS ? CA : { enable_layer_b, enable_layer_a ? RAA : RAB };
	assign GA = { enable_layer_a ? GAB : GAA };				

	assign HA2 = S3HA;
	assign HB2 = S3HB;
endmodule
