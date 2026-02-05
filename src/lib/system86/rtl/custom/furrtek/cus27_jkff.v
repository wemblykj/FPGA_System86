//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_jkff
// Module Name:    system86\src\custom\furrtek\cus27_jkff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - JK flip-flop based on third-party reverse engineering of the CUS27 die
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.ti.com/lit/ds/symlink/sn5476.pdf
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
module cus27_jkff (
		input  wire CLK,
		input  wire bJ,
		input  wire K,
		input  wire SET,
		input  wire RES,
		output wire Q,
		output wire bQ
	);
	
	// input mapping
	assign sig_SET = SET;
	assign sig_RES = RES;
	
	// output mapping
	assign bQ = sig_E_bQ;
	assign Q = sig_F_bQ;
	
	// internal routing
	wire sig_A_Q;
	wire sig_B_bQ;
	wire sig_C_bQ;
	wire sig_D_bQ;
	wire sig_E_bQ;
	wire sig_F_bQ;
	wire sig_G_bQ;

	// J input gate
	// 	J
	// 	sig_E_bQ feedback from E (bQ gate)
	//		sig_G_bQ ?? clock pos edge
	cus27_cell
		cell_A (
			.D2(bJ),
			.D3(sig_E_bQ),
			.D4(sig_G_bQ),
			.Q(sig_A_Q)
		);

	// K input gate
	// 	K
	// 	sig_F_bQ feedback from F (Q gate)
	//		sig_G_bQ ?? clock pos edge
	cus27_cell
		cell_B (
			.D1(sig_F_bQ),
			.D2(sig_SET),	// TODO: confirm SET
			.D3(K),
			.D4(sig_G_bQ),
			.Q_IN(sig_A_Q),
			.bQ(sig_B_bQ)
		);
		
	// clock negative edge latch
	cus27_cell
		cell_C (
			.D2(sig_SET),	// TODO: SET?
			.D3(CLK),	// TODO: confirm CLK
			.D4(sig_D_bQ),
			.bQ(sig_C_bQ)
		);
		
	// ?? suppress or enable clock negative edge latch
	cus27_cell
		cell_D (
			.D2(sig_C_bQ),	// TODO: confirm
			.D3(sig_B_bQ),
			.D4(sig_RES), 	// TODO: confirm RES?
			.bQ(sig_D_bQ)
		);
		
	// bQ driver
	//   sig_G_bQ
	//   sig_F_bQ is feedback from F (Q gate)
	//   sig_C_bQ - ?? reset the flip-flop
	cus27_cell
		cell_E (
			.D2(sig_C_bQ),	// TODO: confirm
			.D3(sig_RES),		// reset logic
			.D4(sig_F_bQ),	// feedback
			.bQ(sig_E_bQ)
		);
	
		// Q driver
		//   sig_G_bQ
		//   sig_E_bQ is feedback from E (bQ gate)
		//   SET will set the flip-flop
	cus27_cell
		cell_F (
			.D2(sig_SET),		// set logic
			.D3(sig_G_bQ), // K
			.D4(sig_E_bQ),	// feedback
			.bQ(sig_F_bQ)
		);
	
	// clock positive edge latch
	cus27_cell
		cell_G (
			.D1(sig_C_bQ),
			.D2(sig_B_bQ),
			.D3(CLK),
			.D4(sig_RES),	// TODO: confirm RES?
			.bQ(sig_G_bQ)
		);
	
endmodule
