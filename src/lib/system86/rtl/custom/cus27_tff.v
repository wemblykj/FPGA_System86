//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_tff
// Module Name:    system86\src\custom\cus27_tff.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Namco CUS27 - toggle flip-flop based on third-party reverse engineering of the CUS27 die
//                 
//
//                 [^1] https://siliconprawn.org/map/namco/27/
//                 [^2] https://github.com/furrtek/SiliconRE/tree/master/Namco/CUS27
//                 [^3] https://www.electronics-tutorials.ws/sequential/toggle-flip-flop.html
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
module cus27_tff 
(
	input wire CLK,
	input wire SET,
	input wire RES,
	output wire Q,
	output wire bQ
);

	wire sig_A_bQ;
	wire sig_B_bQ;
	wire sig_C_bQ;
	wire sig_D_bQ;
	wire sig_E_Q;
	wire sig_F_bQ;
	
	assign Q = sig_D_bQ;
	assign bQ = sig_A_bQ;
	
	assign sig_CLK = CLK;
	assign sig_SET = (SET !== 1'bz && SET !== 1'bx) ? SET : 1'b1;	// low if not connected
	assign sig_RES = (RES !== 1'bz && RES !== 1'bx) ? RES : 1'b1;	// low if not connected
	
	// ~Q driver - depends on D, C
	cus27_cell
		cell_A (
			.D2(sig_D_bQ),
			.D3(sig_RES),
			.D4(sig_C_bQ),
			.bQ(sig_A_bQ)
			);
			
	// feedback depends on ~A, C
	cus27_cell
		cell_B (
			.D2(sig_C_bQ),
			.D3(sig_RES),
			.D4(sig_A_bQ),
			.bQ(sig_B_bQ)
			);
	
	cus27_cell
		cell_C (
			.D1(sig_B_bQ),
			.D2(sig_F_bQ),
			.D3(sig_SET),
			.D4(sig_CLK),
			.bQ(sig_C_bQ)
			);
			
	// Q driver - depends on ~A, ~F
	cus27_cell
		cell_D (
			.D2(sig_A_bQ),
			.D3(sig_SET),
			.D4(sig_F_bQ),
			.bQ(sig_D_bQ)
			);	
	
	// feedback depends on ~B, ~F
	cus27_cell
		cell_E (
			.D2(sig_B_bQ),
			.D3(sig_F_bQ),
			.D4(sig_SET),	
			.bQ(sig_E_bQ)
			);
			
	// slave gate - clocked latch depends on ~E, CLK
	cus27_cell
		cell_F (
			.D2(sig_E_bQ),	// latch driver
			.D3(sig_RES),	// reset latch
			.D4(sig_CLK),	// clock
			.bQ(sig_F_bQ)
			);	
			
	/*wire iob_i = IOB_INPUT_INVERSION;
	wire iob_o = IOB_OUTPUT_INVERSION;
	wire active = ~iob_i;
	
	reg q;

	assign t = resolve_input(T) ^ iob_i;

	assign set = (SET !== 1'bz) ? ~SET : 1'b0;
	assign res = (RES !== 1'bz) ? ~RES : 1'b0;

	assign Q = (set && res) ? 1'b1 : q;     // Unstable state when both SET and RES are low
	assign bQ = (set && res) ? 1'b1 : ~q;   // Unstable state when both SET and RES are low

	always @(posedge CLK or posedge set or posedge res) begin
		if (set && res) begin
			// this is not a scenario possible in the CUS27 according to [^2]
			// so we'll just ignore and leave the state unchanged
			q <= q;
		end else if (set) begin
			q <= 1'b1;
		end else if (res) begin
			q <= 1'b0;
		end else begin
			// currently assuming that SET and RES are as per D-type FF and that when they are not active
			// the FF toggles on every clock tick and that there is no explicit enabling 'T' input [^3]
			q <= ~q;
		end
	end
	
	// Function to resolve high-impedance inputs
	function resolve_input(input sig);
		begin
			resolve_input = (sig !== 1'bx) ? sig : active;
		end
	endfunction*/
endmodule