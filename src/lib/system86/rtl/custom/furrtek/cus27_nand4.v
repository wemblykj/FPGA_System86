`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_nand
// Module Name:    system86\src\custom\furrtek\cus27_nand.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - 4 input NAND gate based on third-party reverse engineering of the CUS27 die
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
module cus27_nand4 (	
		input wire A,
		input wire B,
		input wire C,
		input wire D,
		output wire Y 
	);
	
	// making this up for now
	assign Y = yA & yB;
	
	wire yA;
	wire yB;
	
	cus27_cell
		cell_A (
			.D3(B),
			.D4(A),
			.bQ(yA)
		);
		
	cus27_cell
		cell_B (
			.D3(D),
			.D4(C),
			.bQ(yB)
		);
  
endmodule
