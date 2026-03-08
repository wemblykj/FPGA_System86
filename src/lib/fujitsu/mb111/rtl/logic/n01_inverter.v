`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    February 2026 
// Design Name:    Fujitsu MB111XXX
// Module Name:    mb111_n01_inverter.v 
// Project Name:   Fujistu MB111XXX Gate Array
// Target Devices: 
// Tool versions: 
// Description:    N01 Inverter
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
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module mb111_n01_inverter
(	
	input wire A,
	output wire Y 
);
	
	mb111_gate
		cell (
			.A(A),
			.F(Y)
		);
  
endmodule
