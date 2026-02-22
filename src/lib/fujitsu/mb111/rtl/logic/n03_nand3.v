`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    mb111_n03_nand3
// Module Name:    system86\src\custom\furrtek\mb111_n03_nand3.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    MB111 N03 3-input NAND
//
//                 Namco CUS27 - 3-input NAND gate based on third-party reverse engineering of the CUS27 die
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
module mb111_n03_nand3
(	
	input wire A,
	input wire B,
	input wire C,
	output wire Y 
);
	
	mb111_gate
		cell (
			.A(A),
			.B(B),
			.C(C),
			.F(Y)
		);
  
endmodule
