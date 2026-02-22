`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    mb111_fj3_jxkff
// Module Name:    fj3_jxkff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - J-XK flip flop, based on third-party reverse engineering of the CUS27 die.
//                 From further investigation it looks like the chip is a Fujistu B-350 gate array [^4].
//                 Due to lack of logic block documentation for this device I will use documentation for later
//                 devices as a reference, for example [^5].
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//                 [^4] https://datasheet4u.com/pdf-down/M/B/1/MB111XXX_Fujitsu.pdf
//                 [^5] https://bitsavers.org/components/fujitsu/_dataBooks/1990_Fujitsu_Channelless_Gate_Arrays.pdf
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

module mb111_fj3_jxkff 
(
    input  wire CLK,     // internal clock (latch-based, not edge-triggered)
    input  wire J,      // J input (active-high internally after inversion)
    input  wire XK,       // XK input (active-high)
    input  wire bSET,     // internal active-high bSET (forces Q)
    input  wire bRES,     // internal active-high bRES (forces bQ)
    output wire Q,       // primary output
    output wire XQ       // complementary output
);

    // -------------------------------------------------------------------------
    // Internal routing wires (combinational outputs of each cell)
    // -------------------------------------------------------------------------
    wire sig_A_nand;
    wire sig_B;
    wire sig_C;
    wire sig_D;
    wire sig_E;
    wire sig_F;
    wire sig_G;

    // -------------------------------------------------------------------------
    // Output mapping
    // -------------------------------------------------------------------------
    assign Q  = sig_F;
    assign XQ = sig_E;

    mb111_gate
		cell_A (
			.C(J),
			.B(sig_E),
			.A(sig_G),
			.NAND_OUT(sig_A_nand)
		);

    mb111_gate
		cell_B (
			.D(sig_F),
			.C(bSET),
			.B(XK),
			.A(sig_G),
			.NAND_IN(sig_A_nand),
			.F(sig_B)
		);

    mb111_gate
		cell_C (
			.C(bSET),
			.B(CLK),
			.A(sig_D),
			.F(sig_C)
		);

	mb111_gate
		cell_D (
			.C(sig_C),
			.B(sig_B),
			.A(bRES),
			.F(sig_D)
		);

	mb111_gate
		cell_E (
			.C(sig_C),
			.B(bRES),
			.A(sig_F),
			.F(sig_E)
		);

    mb111_gate
		cell_F (
			.C(bSET),
			.B(sig_G),
			.A(sig_E),
			.F(sig_F)
		);

    mb111_gate
		cell_G (
			.D(sig_C),
			.C(sig_B),
			.B(CLK),
			.A(bRES),
			.F(sig_G)
		);

endmodule
