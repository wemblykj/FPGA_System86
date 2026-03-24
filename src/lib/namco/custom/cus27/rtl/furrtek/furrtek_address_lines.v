`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name: 
// Module Name:    furrtek_address_lines 
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
module furrtek_address_lines (
	input wire sim_rst_n,
	input wire sig_bHRESET1_i,
	input wire sig_bOTEN_i,	
	input wire sig_MODE0_i,
	input wire sig_C11TOP_i,
	input wire sig_E15BOT_i,
	input wire sig_F13TOP_i,
	input wire sig_F13BOT_i,
	input wire sig_H11TOP_i,
	input wire sig_H11BOT_i,
	input wire sig_H13TOP_i,
	input wire sig_J11TOP_i,
	input wire sig_J13TOP_i,
	input wire sig_J13BOT_i,
	input wire sig_H13BOT_i,	
	output wire sig_A0_o,
	output wire sig_A1_o,
	output wire sig_A2_o,
	output wire sig_A3_o,
	output wire sig_A4_o,
	output wire sig_A5_o,
	output wire sig_A6_o,
	output wire sig_A7_o,
	output wire sig_A8_o,
	output wire sig_A9_o,
	output wire sig_A10_o
);

	wire sig_A15BOT;
	wire sig_B16BOT;
	wire sig_C15BOT;
	wire sig_E16TOP;
	wire sig_F1_XQ;
	wire sig_F10TOP;
	wire sig_F10BOT;
	wire sig_H15TOP;
	wire sig_H15BOT;
	wire sig_H16TOP;
	wire sig_H16BOT;
	wire sig_H17TOP;
	wire sig_H17BOT;
	wire sig_G15TOP;
	wire sig_G16BOT;
	wire sig_G17BOT;
	wire sig_J17TOP;
	wire sig_J15BOT;
	wire sig_J15TOP;
	wire sig_J16TOP;
	wire sig_J16BOT;
	wire sig_J17BOT;
	
	assign sig_A0_o = ~(sig_F10TOP & sig_H17TOP & sig_J17TOP);
	assign sig_A1_o = ~(sig_F10TOP & sig_H15BOT & sig_J15BOT);
	assign sig_A2_o = ~(sig_F10TOP & sig_H15TOP & sig_J15TOP);
	assign sig_A3_o = ~(sig_F10TOP & sig_H16BOT & sig_J16TOP);
	assign sig_A4_o = ~(sig_F10TOP & sig_H16TOP & sig_J16BOT);
	assign sig_A5_o = ~(sig_F10BOT & sig_G17BOT & sig_J17BOT);
	assign sig_A6_o = ~(sig_F10BOT & sig_G16BOT & sig_H17BOT);
	assign sig_A7_o = ~(sig_F10BOT & sig_A15TOP & sig_G15TOP);
	assign sig_A8_o = ~(sig_F10BOT & sig_A16BOT & sig_B16BOT);
	assign sig_A9_o = ~(sig_F10BOT & sig_A15BOT & sig_E16TOP);
	assign sig_A10_o = ~(sig_F10BOT & sig_F1_XQ);

	//
	// RTL
	//
	
	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_F10TOP_inverter (
			.A(sig_bOTEN_i),
			.Y(sig_F10TOP)
		);
		
	mb111_n01_inverter
		cus27_F10BOT_inverter (
			.A(sig_bOTEN_i),
			.Y(sig_F10BOT)
		);
	
	mb111_a02_and2
		cus27_C15BOT_and2(
			.A(sig_C11TOP_i),
			.B(sig_MODE0_i),
			.Y(sig_C15BOT)
		);			
			
	mb111_n02_nand2
		cus27_H17TOP_nand2(
			.A(sig_C15BOT),
			.B(sig_J13BOT_i),
			.Y(sig_H17TOP)
		);
			
	mb111_n02_nand2
		cus27_H15BOT_nand2(
			.A(sig_C15BOT),
			.B(sig_H13TOP_i),
			.Y(sig_H15BOT)
		);
		
	mb111_n02_nand2
		cus27_H15TOP_nand2(
			.A(sig_C15BOT),
			.B(sig_F13BOT_i),
			.Y(sig_H15TOP)
		);
		
	mb111_n02_nand2
		cus27_H16BOT_nand2(
			.A(sig_C15BOT),
			.B(sig_H13BOT_i),
			.Y(sig_H16BOT)
		);
		
	mb111_n02_nand2
		cus27_H16TOP_nand2(
			.A(sig_C15BOT),
			.B(sig_E15BOT_i),
			.Y(sig_H16TOP)
		);
		
	mb111_n02_nand2
		cus27_G17BOT_nand2(
			.A(sig_C15BOT),
			.B(sig_J11TOP_i),
			.Y(sig_G17BOT)
		);
		
	mb111_n02_nand2
		cus27_G16BOT_nand2(
			.A(sig_C15BOT),
			.B(sig_H11TOP_i),
			.Y(sig_G16BOT)
		);
		
	mb111_n02_nand2
		cus27_A15TOP_nand2(
			.A(sig_C15BOT),
			.B(sig_H11TOP_i),
			.Y(sig_A15TOP)
		);
		
	mb111_n02_nand2
		cus27_A16BOT_nand2(
			.A(sig_C15BOT),
			.B(sig_H11TOP_i),
			.Y(sig_A16BOT)
		);
		
	mb111_n02_nand2
		cus27_A15BOT_nand2(
			.A(sig_C15BOT),
			.B(sig_H11TOP_i),
			.Y(sig_A15BOT)
		);
		
	//
	
	mb111_n02_nand2
		cus27_G15BOT_nand2(
			.A(sig_MODE0_i),
			.B(sig_C11TOP_i),
			.Y(sig_G15BOT)
		);
		
	mb111_n02_nand2
		cus27_J17TOP_nand2(
			.A(sig_G15BOT),
			.B(sig_J11TOP_i),
			.Y(sig_J17TOP)
		);
		
	mb111_n02_nand2
		cus27_J15BOT_nand2(
			.A(sig_G15BOT),
			.B(sig_F13TOP_i),
			.Y(sig_J15BOT)
		);
		
	mb111_n02_nand2
		cus27_J15TOP_nand2(
			.A(sig_G15BOT),
			.B(sig_H11BOT_i),
			.Y(sig_J15TOP)
		);
		
	mb111_n02_nand2
		cus27_J16TOP_nand2(
			.A(sig_G15BOT),
			.B(sig_H11TOP_i),
			.Y(sig_J16TOP)
		);
		
	mb111_n02_nand2
		cus27_J16BOT_nand2(
			.A(sig_G15BOT),
			.B(sig_J13TOP_i),
			.Y(sig_J16BOT)
		);
		
	mb111_n02_nand2
		cus27_J17BOT_nand2(
			.A(sig_G15BOT),
			.B(sig_J13BOT_i),
			.Y(sig_J17BOT)
		);
		
	mb111_n02_nand2
		cus27_H17BOT_nand2(
			.A(sig_G15BOT),
			.B(sig_H13TOP_i),
			.Y(sig_H17BOT)
		);
		
	mb111_n02_nand2
		cus27_G15TOP_nand2(
			.A(sig_G15BOT),
			.B(sig_F13BOT_i),
			.Y(sig_G15TOP)
		);
		
	mb111_n02_nand2
		cus27_B16BOT_nand2(
			.A(sig_G15BOT),
			.B(sig_H13BOT_i),
			.Y(sig_B16BOT)
		);
		
	mb111_n02_nand2
		cus27_E16TOP_nand2(
			.A(sig_G15BOT),
			.B(sig_E15BOT_i),
			.Y(sig_E16TOP)
		);
		
	mb111_ft1_tff
		cus27_F1_tff(
			.CLK(sig_bOTEN_i),
			.bRES(sig_bHRESET1_i & sim_rst_n),
			.XQ(sig_F1_XQ)
		);
			
endmodule
