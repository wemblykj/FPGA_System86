`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    11:16:41 05/12/2018 
// Design Name:    clut_subsystem
// Module Name:    system86/subsystem/videogen_subsystem.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    videogen subsystem - 8-bit index to 4-bit RGB via CLUT
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`include "ttl_mem/mb7116.vh"
`include "ttl_mem/mb7124.vh"

`include "ttl_mem/ttl_mem.vh"

module videogen_subsystem 
#(
)
(
	 input wire _rst_n,
	
    input s86_6MD_i,
    input s86_bCLR_i,
    input [7:0] s86_D_i,
    input s86_BANK_i,
	  //output wire SYNC,
    output wire [3:0] s86_RED_o,
    output wire [3:0] s86_GREEN_o,
    output wire [3:0] s86_BLUE_o,
    
    // == hardware abstraction - memory buses ==
   
	 `PROM_OUTPUT_DEFS(MB7124, prom_3r),
	 `PROM_OUTPUT_DEFS(MB7116, prom_3s)
);
		
	wire [7:0] ls273_4u_d;
	ls273 ls273_4u(
		.CLK(s86_6MD_i),
		.s86_bCLR_i(s86_bCLR_i),
		.s86_D_i(s86_D_i),
		.Q(ls273_4u_d)
		);
	
	wire [3:0] ls173_3v_d;
	ls173 ls173_3v(
		.CLK(s86_6MD_i),
		.CLR(1'b0),
		.nG1(1'b0),
		.nG2(1'b0),
		.M(1'b0),
		.N(1'b0),
		.s86_D_i(prom_3s_data),
		.Q(ls173_3v_d)
		);
		
	wire [3:0] ls173_3u_d;
	ls173 ls173_3u(
		.CLK(s86_6MD_i),
		.CLR(1'b0),
		.nG1(1'b0),
		.nG2(1'b0),
		.M(1'b0),
		.N(1'b0),
		.s86_D_i(prom_3r_data[7:4]),
		.Q(ls173_3u_d)
		);
		
	wire [3:0] ls173_3t_d;
	ls173 ls173_3t(
		.CLK(s86_6MD_i),
		.CLR(1'b0),
		.nG1(1'b0),
		.nG2(1'b0),
		.M(1'b0),
		.N(1'b0),
		.s86_D_i(prom_3r_data[3:0]),
		.Q(ls173_3t_d)
		);
		
	// == hardware abstraction - memory buses ==

	assign s86_BLUE_o = ls173_3v_d;
	assign s86_GREEN_o = ls173_3u_d;
	assign s86_RED_o = ls173_3t_d;
    
	assign prom_3r_addr = {s86_BANK_i, ls273_4u_d};
	assign prom_3r_ce_n = 1'b0;
	
	assign prom_3s_addr = {s86_BANK_i, ls273_4u_d};
	assign prom_3s_ce_n = 1'b0;
	
	 	
endmodule

