`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026 
// Design Name: 
// Module Name:    furrtek_flipping_muxes 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module furrtek_flipping_muxes (
	input wire sig_FLIP2_i,
	input wire sig_bFLIP_2_i,
	input wire sig_A17_Q_i,
	input wire sig_A17_XQ_i,
	input wire sig_B11_Q_i,
	input wire sig_B11_XQ_i,	
	input wire sig_D11_Q_i,
	input wire sig_D11_XQ_i,
	input wire sig_D15_Q_i,
	input wire sig_D15_XQ_i,
	input wire sig_D18_Q_i,
	input wire sig_D18_XQ_i,
	input wire sig_E12_Q_i,
	input wire sig_E12_XQ_i,
	input wire sig_G11_Q_i,
	input wire sig_G11_XQ_i,
	input wire sig_G18_Q_i,
	input wire sig_G18_XQ_i,
	input wire sig_H18_Q_i,
	input wire sig_H18_XQ_i,
	input wire sig_J5_Q_i,
	input wire sig_J5_XQ_i,
	output wire sig_E15BOT_o,
	output wire sig_F13TOP_o,
	output wire sig_F13BOT_o,
	output wire sig_H11TOP_o,
	output wire sig_H11BOT_o,
	output wire sig_H13TOP_o,
	output wire sig_H13BOT_o,
	output wire sig_J11TOP_o,
	output wire sig_J13TOP_o,
	output wire sig_J13BOT_o
);

	wire sig_E15BOT;
	wire sig_F13TOP;
	wire sig_F13BOT;
	wire sig_H11TOP;
	wire sig_H11BOT;
	wire sig_H13TOP;
	wire sig_H13BOT;
	wire sig_J11TOP;
	wire sig_J13TOP;
	wire sig_J13BOT;
	
	assign sig_E15BOT_o = sig_E15BOT;
	assign sig_F13TOP_o = sig_F13TOP;
	assign sig_F13BOT_o = sig_F13BOT;
	assign sig_H11TOP_o = sig_H11TOP;
	assign sig_H11BOT_o = sig_H11BOT;
	assign sig_H13TOP_o = sig_H13TOP;
	assign sig_H13BOT_o = sig_H13BOT;
	assign sig_J11TOP_o = sig_J11TOP;
	assign sig_J13TOP_o = sig_J13TOP;
	assign sig_J13BOT_o = sig_J13BOT;
	
	mb111_an32_and_nor32
		cus27_J11TOP_inverter (
			.A1(sig_J5_XQ_i),
			.A2(sig_FLIP2_i),
			.B1(sig_J5_Q_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_J11TOP)
		);
	
	mb111_an32_and_nor32
		cus27_F13TOP_inverter (
			.A1(sig_D11_XQ_i),
			.A2(sig_FLIP2_i),
			.B1(sig_D11_Q_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_F13TOP)
		);

	mb111_an32_and_nor32
		cus27_H11BOT_inverter (
			.A1(sig_E12_XQ_i),
			.A2(sig_FLIP2_i),
			.B1(sig_E12_Q_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_H11BOT)
		);

	mb111_an32_and_nor32
		cus27_H11TOP_inverter (
			.A1(sig_G11_Q_i),
			.A2(sig_FLIP2_i),
			.B1(sig_G11_XQ_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_H11TOP)
		);
		
	mb111_an32_and_nor32
		cus27_J13TOP_inverter (
			.A1(sig_B11_Q_i),
			.A2(sig_FLIP2_i),
			.B1(sig_B11_XQ_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_J13TOP)
		);

	mb111_an32_and_nor32
		cus27_J13BOT_inverter (
			.A1(sig_A17_XQ_i),
			.A2(sig_FLIP2_i),
			.B1(sig_A17_Q_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_J13BOT)
		);

	mb111_an32_and_nor32
		cus27_H13BOT_inverter (
			.A1(sig_D18_Q_i),
			.A2(sig_FLIP2_i),
			.B1(sig_D18_XQ_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_H13BOT)
		);

	mb111_an32_and_nor32
		cus27_F13BOT_inverter (
			.A1(sig_D15_Q_i),
			.A2(sig_FLIP2_i),
			.B1(sig_D15_XQ_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_F13BOT)
		);

	mb111_an32_and_nor32
		cus27_H13TOP_inverter (
			.A1(sig_H18_Q_i),
			.A2(sig_FLIP2_i),
			.B1(sig_H18_XQ_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_H13TOP)
		);

	mb111_an32_and_nor32
		cus27_E15BOT_inverter (
			.A1(sig_G18_Q_i),
			.A2(sig_FLIP2_i),
			.B1(sig_G18_XQ_i),
			.B2(sig_bFLIP_2_i),
			.Y(sig_E15BOT)
		);

endmodule
