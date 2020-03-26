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

module videogen_subsystem 
#(
)
(
	input wire reset,
	input wire enable,
	
    input CLK_6MD,
    input nCLR,
    input [7:0] D,
    input BANK,
	 output wire SYNC,
    output wire [3:0] RED,
    output wire [3:0] GREEN,
    output wire [3:0] BLUE,
    
    // == hardware abstraction - memory buses ==
    
    input [7:0] prom_3r_data,
    output wire [8:0] prom_3r_addr,
    output wire prom_3r_ce,
    
    input [3:0] prom_3s_data,
    output wire [8:0] prom_3s_addr,
    output wire prom_3s_ce
);
	
	assign BLUE = ls173_3v_d;
	assign GREEN = ls173_3u_d;
	assign RED = ls173_3t_d;
	
	wire [7:0] ls273_4u_d;
	ls273 ls273_4u(
		.CLK(CLK_6MD),
		.nCLR(nCLR),
		.D(D),
		.Q(ls273_4u_d)
		);
	
	wire [3:0] ls173_3v_d;
	ls173 ls173_3v(
		.CLK(CLK_6MD),
		.CLR(GND),
		.nG1(GND),
		.nG2(GND),
		.M(GND),
		.N(GND),
		.D(prom_3s_data),
		.Q(ls173_3v_d)
		);
		
	wire [3:0] ls173_3u_d;
	ls173 ls173_3u(
		.CLK(CLK_6MD),
		.CLR(CLR),
		.nG1(GND),
		.nG2(GND),
		.M(GND),
		.N(GND),
		.D(prom_3r_data[7:4]),
		.Q(ls173_3u_d)
		);
		
	wire [3:0] ls173_3t_d;
	ls173 ls173_3t(
		.CLK(CLK_6MD),
		.CLR(CLR),
		.nG1(GND),
		.nG2(GND),
		.M(GND),
		.N(GND),
		.D(prom_3r_data[3:0]),
		.Q(ls173_3t_d)
		);
		
	// == hardware abstraction - memory buses ==
    
	assign prom_3r_addr = {BANK, ls273_4u_d};
	assign prom_3r_ce = 1;
    
	assign prom_3s_addr = {BANK, ls273_4u_d};
	assign prom_3s_ce = 1;
    	
endmodule

