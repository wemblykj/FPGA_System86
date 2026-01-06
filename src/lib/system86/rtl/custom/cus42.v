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
		input wire _rst_n,
			
		input wire pin_6M_i,
		input wire pin_2H_i,
		input wire pin_bHSYNC_i,
		input wire pin_bVSYNC_i,
		input wire pin_bGCS_i,
		input wire pin_bRCS_i,
		input wire pin_bLATCH_i,
		input wire pin_FLIP_i,
		input wire [13:0] pin_CA_i,
		input wire pin_RbW_i,
		inout wire [7:0] pin_CD_io,
		inout wire [7:0] pin_RD_io,
		output wire [13:0] pin_GA_o,
		output wire [12:0] pin_RA_o,
		output wire pin_bRWE_o,
		output wire pin_bROE_o,
		output wire pin_HA2_o,
		output wire pin_HB2_o
	);

	reg [2:0] state_next;
	reg [2:0] state;
    reg enable_layer_a_next;
	reg enable_layer_b_next;
	reg enable_layer_a;
	reg enable_layer_b;
	
	wire [1:0] state_a = { state_next[2], state_next[0] };
	wire [1:0] state_b = { state_next[2], state_next[0] };
	
	wire [11:0] sig_RAA;
	wire [13:0] sig_GAA;
	wire sig_S3HA;
	cus42_layer 
		layer_a
		(
			._rst_n(_rst_n),
			.state(state_a),
			.sig_6M_i(pin_6M_i),
			.sig_FLIP_i(pin_FLIP_i),
			.sig_bLATCH_i(pin_bLATCH_i | pin_CA_i[2]),
			.sig_CA_i(pin_CA_i[1:0]),
			.sig_CD_io(pin_CD_io),
			.sig_RD_io(pin_RD_io),
			.sig_bHSYNC_i(pin_bHSYNC_i),
			.sig_bVSYNC_i(pin_bVSYNC_i),
			.sig_RA_o(sig_RAA),
			.sig_GA_o(sig_GAA),
			.sig_S3H_o(sig_S3HA)
		);
	
	wire [11:0] sig_RAB;
	wire [13:0] sig_GAB;
	wire sig_S3HB;
	cus42_layer
		layer_b
		(
			._rst_n(_rst_n),
			.state(state_b),
			.sig_6M_i(pin_6M_i),
			.sig_FLIP_i(pin_FLIP_i),
			.sig_bLATCH_i(pin_bLATCH_i | ~pin_CA_i[2]),
			.sig_CA_i(pin_CA_i[1:0]),
			.sig_CD_io(pin_CD_io),
			.sig_RD_io(pin_RD_io),
			.sig_bHSYNC_i(pin_bHSYNC_i),
			.sig_bVSYNC_i(pin_bVSYNC_i),
			.sig_RA_o(sig_RAB),
			.sig_GA_o(sig_GAB),
			.sig_S3H_o(sig_S3HB)
		);

	// 
	reg write_done_request;
	
	always @(negedge pin_6M_i or negedge _rst_n) begin
		if (~_rst_n || !pin_bHSYNC_i) begin
			state_next = 0;
			enable_layer_a_next = 0;
			enable_layer_b_next = 0;
		end else begin
			enable_layer_a_next = ~pin_2H_i;
			enable_layer_b_next = pin_2H_i;
			state_next = state_next + 1;
		end
	end
	
	always @(posedge pin_6M_i or negedge _rst_n) begin
		if (~_rst_n) begin
			state = 0;
			enable_layer_a = 0;
			enable_layer_b = 0;
		end else begin
			write_done_request <= ~pin_RbW_i;
			state = state_next;
			enable_layer_a = enable_layer_a_next;
			enable_layer_b = enable_layer_b_next;
		end
	end

	// CPU/RAM multiplexing
	assign pin_bRWE_o = pin_bRCS_i | pin_RbW_i | write_done_request;
	assign pin_bROE_o = ~pin_bRCS_i ? ~pin_RbW_i : 1'b0;
	
	assign pin_CD_io = (~pin_bRCS_i & pin_RbW_i) ? pin_RD_io : 8'bz;
	assign pin_RD_io = (~pin_bRCS_i & ~pin_RbW_i) ? pin_CD_io : 8'bz;
	
	assign pin_RA_o = ~pin_bRCS_i ? pin_CA_i : { enable_layer_b, enable_layer_a ? sig_RAA : sig_RAB };
	assign pin_GA_o = { enable_layer_a ? sig_GAB : sig_GAA };				

	assign pin_HA2_o = sig_S3HA;
	assign pin_HB2_o = sig_S3HB;
endmodule
