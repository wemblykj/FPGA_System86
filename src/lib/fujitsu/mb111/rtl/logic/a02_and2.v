`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    February 2026 
// Design Name:    Fujitsu MB111XXX
// Module Name:    mb111_a02_and2.v 
// Project Name:   Fujistu MB111XXX Gate Array
// Target Devices: 
// Tool versions: 
// Description:    A02 2-input AND
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
// Dependencies:   mb111_gate.v
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module mb111_a02_and2
(	
	input wire A,
	input wire B,
	output wire Y 
);
	
	wire sig_B;
	
	mb111_gate
		cell_A (
			.AND_IN(sig_B),
			.F(Y)
		);
		
	mb111_gate
		cell_B (
			.A(A),
			.B(B),
			.NAND_OUT(sig_B)
		);
  
endmodule
