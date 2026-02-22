`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Paul Wightmore
// 
// Design Name:    mb111_ft1_tff
// Description:    Namco CUS27 - Toggle Flip-Flop reconstructed from die analysis.
//
// References:
//   [1] https://siliconprawn.org/map/namco/27/
//   [2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//   [3] https://www.electronics-tutorials.ws/sequential/toggle-flip-flop.html
//
// Notes:
//   - Implements the six-cell topology of the CUS27 T-FF.
//   - Q is taken from cell D, F from cell A.
//   - All unused D inputs are tied low for clarity.
//   - DELAY parameter is passed to each primitive cell.
//
// License: Apache 2.0
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
