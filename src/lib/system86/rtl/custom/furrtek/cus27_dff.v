`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_dff
// Module Name:    system86\src\custom\furrtek\cus27_dff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - D-type flip-flop based on third-party reverse engineering of the CUS27 die
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
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
module cus27_dff	(
		input wire CLK,
		input wire DIN,
		output wire Q,
		output wire bQ,
		input wire SET,
		input wire RES
	);

	// input mapping
	assign sig_CLK = CLK;
	assign sig_DIN = DIN;
	assign sig_SET = SET;
	assign sig_RES = RES;
	
	// output mapping
	assign Q = sig_F_bQ;
	assign bQ = sig_C_bQ;
	
	// internal routing
	wire sig_A_bQ;
	wire sig_B_bQ;
	wire sig_C_bQ;
	wire sig_D_bQ;
	wire sig_E_bQ;
	wire sig_F_bQ;	
	
	cus27_cell
		cell_A (
			.D1(),
			.D2(sig_DIN),
			.D3(sig_B_bQ),
			.D4(sig_RES),
			.bQ(sig_A_bQ)
			);
			
	cus27_cell
		cell_B (
			.D1(sig_A_bQ),
			.D2(sig_E_bQ),
			.D3(sig_SET),
			.D4(sig_CLK),
			.bQ(sig_B_bQ)
			);
	
	cus27_cell
		cell_C (
			.D2(sig_F_bQ),
			.D3(sig_RES),
			.D4(sig_B_bQ),
			.bQ(sig_C_bQ)
			);
			
	cus27_cell
		cell_D (
			.D2(sig_A_bQ),
			.D3(sig_E_bQ),
			.D4(sig_SET),
			.bQ(sig_D_bQ)
			);	
	
	cus27_cell
		cell_E (
			.D2(sig_D_bQ),
			.D3(sig_RES),
			.D4(sig_CLK),	
			.bQ(sig_E_bQ)
			);
			
	cus27_cell
		cell_F (
			.D2(sig_C_bQ),
			.D3(sig_SET),
			.D4(sig_E_bQ),
			.bQ(sig_F_bQ)
			);	
			
endmodule
