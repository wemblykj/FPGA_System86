`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    February 2026 
// Design Name:    Fujitsu MB111XXX
// Module Name:    mb111_an32_and_nor32.v 
// Project Name:   Fujistu MB111XXX Gate Array
// Target Devices: 
// Tool versions: 
// Description:    AN32 3-input 2-wide AND-NOR
//
//                 Based on third-party reverse engineering of the Namco CUS27 die
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//
//                 Kudos go to:
//                  Furrtek for reverse engineering: http://www.furrtek.org
//                  JohnDMcMaster for die photos: https://siliconprawn.org/
//
// Dependencies:  mb111_gate.v
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module mb111_an32_and_nor32
(	
	input wire A1,
	input wire A2,
	input wire A3,
	input wire B1,
	input wire B2,
	input wire B3,
	output wire Y 
);
	
	wire sig_B;
	
	mb111_gate
		cell_A (
			.A(A1),
			.B(A2),
			.C(A3),
			.NAND_IN(sig_B),
			.F(Y)
		);
		
	mb111_gate
		cell_B (
			.A(B1),
			.B(B2),
			.C(B3),
			.NAND_OUT(sig_B)
		);
  
endmodule
