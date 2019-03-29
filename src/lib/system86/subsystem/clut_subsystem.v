`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    11:16:41 05/12/2018 
// Design Name:    clut_subsystem
// Module Name:    system86/subsystem/clut_subsystem.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    CLUT subsystem - 8-bit to 12-bit (RGB) CLUT
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`include "common/defines.vh"

module clut_subsystem 
#(
)
(
    input CLK_6M,
    input CLR,
    input [7:0] D,
    input BANK,
    output wire [3:0] R,
    output wire [3:0] G,
    output wire [3:0] B,
    
    // == hardware abstraction - memory buses ==
    
    input wire [7:0] prom_3r_data,
    output wire [8:0] prom_3r_addr,
    output wire prom_3r_ce,
    
    input wire [3:0] prom_3s_data,
    output wire [8:0] prom_3s_addr,
    output wire prom_3s_ce,
);
	
	assign R = prom_3r_data[3:0];
	assign G = prom_3r_data[7:4];
	assign B = prom_3s_data;
	
	wire [7:0] ls273_4u_d;
	LS273 LS273_4U(
		.CLK(CLK_6M),
		.CLR(CLR),
		.D(D),
		.Q(ls273_4u_d)
		);
	
    // == hardware abstraction - memory buses ==
    
    assign prom_3r_addr = {BANK, ls273_4u_d};
    assign prom_3r_ce = VCC;
    
    assign prom_3s_addr = {BANK, ls273_4u_d};
    assign prom_3s_ce = VCC;
    	
endmodule

