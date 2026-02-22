`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Paul Wightmore
// 
// Design Name:    mb111_fd1_dff
// Description:    Namco CUS27 - D-type flip-flop reconstructed from die analysis.
//
// References:
//   [1] https://siliconprawn.org/map/namco/27/
//   [2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//   [3] https://www.ti.com/lit/ds/symlink/sn74lvc2g74-ep.pdf
//
// Notes:
//   - Implements the six-cell topology of the CUS27 D-FF.
//   - Q is taken from cell F, XQ from cell C.
//   - All unused D inputs are tied low for clarity.
//   - DELAY parameter is passed to each primitive cell.
//
// License: Apache 2.0
//////////////////////////////////////////////////////////////////////////////////

module mb111_fd1_dff
(
    input  wire CLK,
    input  wire D,
    input  wire bSET,
    input  wire bRES,
    output wire Q,
    output wire XQ
);

    // -------------------------------------------------------------------------
    // Internal signals (XQ outputs of each primitive cell)
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
    assign Q  = sig_F;
    assign XQ = sig_C;

    // -------------------------------------------------------------------------
    // Primitive cell network (A-F)
    // -------------------------------------------------------------------------

    mb111_gate 
		cell_A (
			.C(D),
			.B(sig_B),
			.A(bRES),
			.F(sig_A)
		);

    mb111_gate 
		cell_B (
			.D(sig_A),
			.C(sig_E),
			.B(bSET),
			.A(CLK),
			.F(sig_B)
		);

    mb111_gate 
		cell_C (
			.C(sig_F),
			.B(bRES),
			.A(sig_B),
			.F(sig_C)
		);

    mb111_gate 
		cell_D (
			.C(sig_A),
			.B(sig_E),
			.A(bSET),
			.F(sig_D)
		);

    mb111_gate 
		cell_E (
			.C(sig_D),
			.B(bRES),
			.A(CLK),
			.F(sig_E)
		);

    mb111_gate 
		cell_F (
			.C(sig_C),
			.B(bSET),
			.A(sig_E),
			.F(sig_F)
		);

endmodule
