`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_horizontal_timings.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - based on third-party reverse engineering of the CUS27 die
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//
//                 Kudos go to:
//                  Furrtek for reverse engineering: http://www.furrtek.org
//                  JohnDMcMaster for die photos: https://siliconprawn.org/
//
//
// Dependencies: 
//
// Revision:		 Revisiting timing accuracy 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module furrtek_horizontal_timings (
	input wire sim_rst_n,
	
	// input clocks
	input wire sig_6MIN2_i,
	
	input wire sig_bHRESET1_i,
	input wire sig_bHRESET2_i,
	input wire sig_J5_XQ_i,
	input wire sig_J10BOT_i,
	output wire sig_B11_Q_o,
	output wire sig_B11_XQ_o,
	output wire sig_C11TOP_o,
	output wire sig_D11_Q_o,
	output wire sig_D11_XQ_o,
	output wire sig_E12_Q_o,
	output wire sig_E12_XQ_o,
	output wire sig_G11_Q_o,
	output wire sig_G11_XQ_o,
	output wire sig_bHSYNC_o,
	output wire sig_bHBLA_o	
);

	wire sig_A11TOP;
	wire sig_A12_Q;
	wire sig_B11_Q;
	wire sig_B11_XQ;
	wire sig_C11BOT;
	wire sig_C11TOP;
	wire sig_C12_Q;
	wire sig_D11_Q;
	wire sig_D11_XQ;
	wire sig_E10TOP;
	wire sig_E11BOT;
	wire sig_E12_Q;
	wire sig_E12_XQ;
	wire sig_J11BOT;
	wire sig_J12BOT;
	
	assign sig_B11_Q_o = sig_B11_Q;
	assign sig_B11_XQ_o = sig_B11_XQ;
	assign sig_C11TOP_o = sig_C11TOP;
	assign sig_D11_Q_o = sig_D11_Q;
	assign sig_D11_XQ_o = sig_D11_XQ;
	assign sig_E12_Q_o = sig_E12_Q;
	assign sig_E12_XQ_o = sig_E12_XQ;
	assign sig_G11_Q_o = sig_G11_Q;
	assign sig_G11_XQ_o = sig_G11_XQ;
	assign sig_bHBLA_o = sig_A12_Q;
	assign sig_bHSYNC_o = sig_C12_Q;
	assign sig_bPIN_14_o = sig_E11BOT;
	
	//
	// RTL
	//
	
	//
	// standard cell synthesis
	
	mb111_n01_inverter
		cus27_E10TOP_inverter (
			.A(sig_C11BOT),
			.Y(sig_E10TOP)
		);
	
	mb111_n01_inverter
		cus27_C11TOP_inverter (
			.A(sig_E11BOT),
			.Y(sig_C11TOP)
		);
		
	mb111_n02_nand2
		cus27_C11BOT_nand2(
			.A(sig_J5_XQ_i),
			.B(sig_J10BOT_i),
			.Y(sig_C11BOT)
		);
		
	mb111_n02_nand2
		cus27_J11BOT_nand2(
			.A(sig_J12BOT),
			.B(sig_B11_XQ),
			.Y(sig_J11BOT)
		);

	mb111_n02_nand2
		cus27_J12BOT_nand2(
			.A(sig_bHRESET1_i & sim_rst_n),
			.B(sig_J11BOT),
			.Y(sig_J12BOT)
		);
					
	mb111_n02_nand2
		cus27_A11TOP_nand2(
			.A(sig_G11_Q),
			.B(sig_E12_Q),
			.Y(sig_A11TOP)
		);
		
	mb111_n03_nand3
		cus27_E11BOT_nand3(
			.A(sig_bHRESET1_i & sim_rst_n),
			.B(sig_J11BOT),
			.C(sig_B11_XQ),
			.Y(sig_E11BOT)
		);
				
	mb111_ft1_tff
		cus27_E12_tff(
			.CLK(sig_D11_Q),
			.bRES(sig_bHRESET2_i & sim_rst_n),
			.Q(sig_E12_Q),
			.XQ(sig_E12_XQ)
		);
		
	mb111_fj3_jxkff
		cus27_D11_jkff(
			.CLK(sig_6MIN2_i),
			.J(sig_C11BOT),
			.XK(sig_E10TOP),
			.bSET(sig_bHRESET2_i & sim_rst_n),
			.Q(sig_D11_Q),
			.XQ(sig_D11_XQ)
		);
		
	mb111_fd1_dff
		cus27_A12_dff(
			.CLK(sig_D11_XQ),
			.D(sig_A11TOP),
			.bRES(sig_C11TOP & sim_rst_n),
			.Q(sig_A12_Q)
		);	
	
	mb111_ft1_tff
		cus27_G11_tff(
			.CLK(sig_E12_XQ),
			.bRES(sig_bHRESET2_i & sim_rst_n),  // labelled as F9BOT driver for HRESET2
			.Q(sig_G11_Q),
			.XQ(sig_G11_XQ)
		);
				
	mb111_fj3_jxkff
		cus27_B11_jkff(
			.CLK(sig_G11_XQ),
			.J(sig_C11TOP),
			.bRES(sig_bHRESET2_i & sim_rst_n),	// labelled as F9BOT driver for HRESET2
			.Q(sig_B11_Q),
			.XQ(sig_B11_XQ)
		);
		
	mb111_fd1_dff
		cus27_C12_dff(
			.CLK(sig_D11_XQ),
			.D(sig_G11_XQ),
			.bRES(sig_A12_Q & sim_rst_n),
			.Q(sig_C12_Q)
		);	
		
endmodule
