`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    07/01/2025 
// Design Name:    cus27_nand
// Module Name:    system86\src\custom\furrtek\cus27_cell.v 
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
module cus27_cell (
		input  wire D1,
		input  wire D2,
		input  wire D3,
		input  wire D4,
		input  wire Q_IN,
		output wire Q,
		output wire bQ
	);
	assign d1 = resolve_input(D1);
	assign d2 = resolve_input(D2);
	assign d3 = resolve_input(D3);
	assign d4 = resolve_input(D4);
	
	// logic high if not connected otherwise acts as a pull-down when logic low
	assign q_in = (Q_IN !== 1'bx && Q_IN !== 1'bz) ? Q_IN : 1'b1;
	
	assign Q = q;
	assign bQ = ~q;
	
	// output of input stage - logic high if all inputs are low (or disconnected)
	assign x = d1 | d2 | d3 | d4;
	
	// q is logic high when x is logic high and not pulled-low by Q_IN
	// FIXME: this works but is not intuitive
	assign #1 q = q_in & x;

	// Function to resolve high-impedance inputs - logic low if not connected
	function resolve_input(input sig);
		begin
			resolve_input = (sig !== 1'bx && sig !== 1'bz) ? sig : 1'b0;
		end
		
	endfunction
	
endmodule
