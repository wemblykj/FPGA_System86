`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Paul Wightmore
// 
// Create Date:    February 2026 
// Design Name:    Fujitsu MB111XXX
// Module Name:    mb111_ft1_tff.v 
// Project Name:   Fujistu MB111XXX Gate Array
// Target Devices: 
// Tool versions: 
// Description:    FT1 Toggle Flip-Flop
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

module mb111_ft1_tff
(
	input  wire CLK,
    input  wire bSET,
    input  wire bRES,
    output wire Q,
    output wire XQ
);

    // -------------------------------------------------------------------------
    // Internal signals (F outputs of each primitive cell)
    // -------------------------------------------------------------------------
    wire sig_A;
    wire sig_B;
    wire sig_C;
    wire sig_D;
    wire sig_E;
    wire sig_F;

    // -------------------------------------------------------------------------
    // Output mapping (matches die-level behaviour)
    // -------------------------------------------------------------------------
    assign Q  = sig_D;   // non-inverted output
    assign XQ = sig_A;   // inverted output

    // -------------------------------------------------------------------------
    // Primitive cell network (A-F)
    // -------------------------------------------------------------------------

    mb111_gate cell_A (
        .C(sig_D),
        .B(bRES),
        .A(sig_C),
        .F(sig_A)
    );

    mb111_gate cell_B (
        .C(sig_C),
        .B(bRES),
        .A(sig_A),
        .F(sig_B)
    );

    mb111_gate cell_C (
        .D(sig_B),
        .C(sig_F),
        .B(bSET),
        .A(CLK),
        .F(sig_C)
    );

    mb111_gate cell_D (
        .C(sig_A),
        .B(bSET),
        .A(sig_F),
        .F(sig_D)
    );

    mb111_gate cell_E (
        .C(sig_B),
        .B(sig_F),
        .A(bSET),
        .F(sig_E)
    );

    mb111_gate cell_F (
        .C(sig_E),
        .B(bRES),
        .A(CLK),
        .F(sig_F)
    );

endmodule
