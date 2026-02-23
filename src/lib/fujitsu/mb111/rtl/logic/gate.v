`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_nand
// Module Name:    mb111_gate.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - 4 input NAND gate based on third-party reverse engineering of the CUS27 die.
//                 From further investigation it looks like the chip is a Fujistu B-350 gate array [^4].
//                 Out of interest, the patent US4584653A [^5] possibly describes this device's origins.
//
//                 The 6-input NAND gate is two bsic gates linked by 
//                 Details from datasheet [^4]:
//                 
//                 Input transistors are PNP so behaviour is that of a NAND gate as inferred by die schematics. [^2]
//                 Propogation delay through the [standard speed] cell is 1.65ns. I have picked intermediate propogation delays
//                 for the intermediate wired-AND and wired-NAND taps.
//
// References:
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//                 [^4] https://datasheet4u.com/pdf-down/M/B/1/MB111XXX_Fujitsu.pdf
//                 [^5] https://patents.google.com/patent/US4584653A/ja
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

module mb111_gate
    #(parameter T_AND = 0.3,
	  parameter T_NAND = 0.8,	
	  parameter T_TOTAL = 1.65 )
(
    input wire A,
    input wire B,
    input wire C,
    input wire D,

    // used to wire-AND two cells together
	input  wire AND_IN,
	output wire AND_OUT,
	 
    // used to wire-NAND two cells together
    input  wire NAND_IN,
	output wire NAND_OUT,
    
    // Logical output (inverted active node)
    output wire F
);

    // Resolve inputs: treat x/z as high (inert)
    wire a = (A !== 1'b0);
    wire b = (B !== 1'b0);
    wire c = (C !== 1'b0);
    wire d = (D !== 1'b0);
	 
	wire and_in = (AND_IN !== 1'b0);
	wire nand_in = (NAND_IN !== 1'b0);

    wire and_comb = and_in & a & b & c & d;
    wire #(T_AND) and_tap = and_comb;
	 
	wire nand_comb = nand_in & ~and_comb;
    wire #(T_NAND - T_AND) nand_tap = nand_comb;
	 
	wire #(T_TOTAL - T_NAND) f = nand_comb;

    // Outputs
	assign AND_OUT = and_tap;
    assign NAND_OUT = nand_tap;
    assign F = f;

endmodule
