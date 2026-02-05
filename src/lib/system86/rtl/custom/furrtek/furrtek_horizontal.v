`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    22:56:27 04/17/2018 
// Design Name:    cus27
// Module Name:    system86\src\custom\furrtek\furrtek_horizontal.v
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
module furrtek_horizontal (
		// input clocks
		input wire sig_6MIN2_i,
		input wire sig_bHRESET3_i,
		
		output wire sig_b1H_o,
		output wire sig_b2H_o,
		output wire sig_b4H_o,
		output wire sig_bPIN_6_o,	// presuming this is equivalent to 8H
		
		// internal routing ouputs
		output wire sig_J5Q_o,
		output wire sig_J5bQ_o
	);

	wire sig_H10BOT;
	wire sig_H10TOP;
	wire sig_J9TOP;
	wire sig_J10BOT;
	wire sig_H1_Q;
	wire sig_H1_bQ;
	wire sig_H5_Q;
	wire sig_H5_bQ;
	wire sig_J1_Q;
	wire sig_J1_bQ;
	wire sig_J5_Q;
	wire sig_J5_bQ;
	
	assign sig_J5Q_o = sig_J5_Q;
	assign sig_J5bQ_o = sig_J5_bQ;
	assign sig_b1H_o = sig_H1_bQ;
	assign sig_b2H_o = sig_H5_Q;
	assign sig_b4H_o = sig_J1_Q;
	assign sig_bPIN_6_o = sig_J5_Q;
	
	//
	// RTL
	//
	
	//
	// synthesise the routing of signals through simple logic cells 
	
	assign sig_J9TOP = ~sig_H10BOT;
	assign sig_J10BOT = ~sig_H10TOP;
	
	//
	// standard cell synthesis
	
	cus27_nand3
		cus27_H10BOT_nand3(
			.A(sig_H1_Q),
			.B(sig_H5_bQ),
			.Y(sig_H10BOT)
		);
		
	cus27_nand3
		cus27_H10TOP_nand3(
			.A(sig_J1_bQ),
			.B(sig_H1_Q),
			.C(sig_H5_bQ),
			.Y(sig_H10TOP)
		);
				
	cus27_tff
		cus27_H1_tff(
			.CLK(sig_6MIN2_i),
			.bRES(sig_HRESET),
			.Q(sig_H1_Q),
			.bQ(sig_H1_bQ)
		);
		
	cus27_jkff
		cus27_H5_jkff(
			.CLK(sig_6MIN2_i),
			.bJ(sig_H1_bQ),
			.K(sig_H1_Q),
			.bSET(sig_HRESET),
			.Q(sig_H5_Q),
			.bQ(sig_H5_bQ)
		);
		
	cus27_jkff
		cus27_J1_jkff(
			.CLK(sig_6MIN2_i),
			.bJ(sig_H10BOT),
			.K(sig_J9TOP),
			.bSET(sig_HRESET),
			.Q(sig_J1_Q),
			.bQ(sig_J1_bQ)
		);
		
	cus27_jkff
		cus27_J5_jkff(
			.CLK(sig_6MIN2_i),
			.bJ(sig_H10TOP),
			.K(sig_J10BOT),
			.bSET(sig_HRESET),
			.Q(sig_J5_Q),
			.bQ(sig_J5_bQ)
		);
			
endmodule
