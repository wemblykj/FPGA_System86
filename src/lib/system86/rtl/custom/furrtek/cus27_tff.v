`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_tff
// Module Name:    system86\src\custom\furrtek\cus27_tff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - toggle flip-flop based on third-party reverse engineering of the CUS27 die
//                 
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.electronics-tutorials.ws/sequential/toggle-flip-flop.html
//
//                 Kudos go to:
//                  Furrtek for reverse engineering: http://www.furrtek.org
//                  JohnDMcMaster for die photos: https://siliconprawn.org/
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module cus27_tff (
		input wire CLK,
		input wire SET,
		input wire RES,
		output wire Q,
		output wire bQ
	);

	// input mapping
	assign sig_CLK = CLK;
	assign sig_SET = SET;
	assign sig_RES = RES;

	// output mapping
	assign #5 Q = sig_D_bQ_2;
	assign #5 bQ = sig_A_bQ_2;
	
	assign #4 sig_A_bQ_2 = sig_A_bQ;
	assign #1 sig_B_bQ_2 = sig_B_bQ;
	assign sig_C_bQ_2 = sig_C_bQ;
	assign #4 sig_D_bQ_2 = sig_D_bQ;
	assign #1 sig_E_bQ_2 = sig_E_bQ;
	assign sig_F_bQ_2 = sig_F_bQ;
	
	// internal routing
	wire sig_A_bQ;
	wire sig_B_bQ;
	wire sig_C_bQ;
	wire sig_D_bQ;
	wire sig_E_Q;
	wire sig_F_bQ;
		
	// ~Q driver - depends on D, C
	cus27_cell
		cell_A (
			.D2(sig_D_bQ_2),
			.D3(sig_RES),
			.D4(sig_C_bQ_2),
			.bQ(sig_A_bQ)
			);
			
	// feedback depends on ~A, C
	cus27_cell
		cell_B (
			.D2(sig_C_bQ_2),
			.D3(sig_RES),
			.D4(sig_A_bQ_2),
			.bQ(sig_B_bQ)
			);
	
	cus27_cell
		cell_C (
			.D1(sig_B_bQ_2),
			.D2(sig_F_bQ_2),
			.D3(sig_SET),
			.D4(sig_CLK),
			.bQ(sig_C_bQ)
			);
			
	// Q driver - depends on ~A, ~F
	cus27_cell
		cell_D (
			.D2(sig_A_bQ_2),
			.D3(sig_SET),
			.D4(sig_F_bQ_2),
			.bQ(sig_D_bQ)
			);	
	
	// feedback depends on ~B, ~F
	cus27_cell
		cell_E (
			.D2(sig_B_bQ_2),
			.D3(sig_F_bQ_2),
			.D4(sig_SET),	
			.bQ(sig_E_bQ)
			);
			
	// slave gate - clocked latch depends on ~E, CLK
	cus27_cell
		cell_F (
			.D2(sig_E_bQ_2),	// latch driver
			.D3(sig_RES),	// reset latch
			.D4(sig_CLK),	// clock
			.bQ(sig_F_bQ)
			);	

endmodule
