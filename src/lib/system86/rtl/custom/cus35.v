`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:57:44 05/08/2018 
// Design Name:    CUS35
// Module Name:    system86\src\custom\cus35.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    CUS35 - Sprite address generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0 
//
//////////////////////////////////////////////////////////////////////////////////
module cus35(
		input wire _rst_n,

        input wire pin_6M_i,
        input wire pin_bVRES_i,
        input wire pin_bHSYNC_i,
        input wire pin_bOCS_i,
        input wire pin_RbW_i,
        input wire [12:0] pin_A_i,
        inout wire [7:0] pin_D_i,
        output wire pin_O16VA_o,
        output wire pin_O8VA_o,
        output wire pin_O4VA_o,
        output wire pin_O2VA_o,
        output wire pin_O1VA_o,
        output wire pin_O16HA_o,
        output wire pin_O8HA_o,
        output wire pin_O4HA_o,
        output wire pin_O2HA_o,
        output wire pin_FLIP_o,
        output wire pin_HFLIP_o,
        output wire pin_O8EN_o,
        output wire pin_HSET_o,
        output wire pin_VSET_o,
        output wire pin_bCS0_o,
        output wire pin_bCS1_o,
        output wire pin_bROE_o,
        output wire pin_bRWE_o,
        inout wire [7:0] pin_B0_io,		// CPU data bus
        inout wire [7:0] pin_B1_io		// line buffer - for internal xfer?
    );

	reg write_done_request;
	always @(posedge pin_6M_i) begin
		write_done_request <= ~pin_RbW_i;
	end
	
	assign pin_bCS0_o = 1'b1;
	assign pin_bCS1_o = pin_bOCS_i;
	assign pin_bRWE_o = pin_bOCS_i | pin_RbW_i | write_done_request;
	assign pin_bROE_o = pin_bOCS_i | ~pin_bRWE_o;
	assign pin_B0_io = 8'bz; //~pin_bCS0_o ? (~pin_RbW_i ? pin_D_i : 8'bz) : 8'bx;
	assign pin_B1_io = 8'bz; //~pin_bCS1_o ? (~pin_RbW_i ? pin_D_i : 8'bz) : 8'bx;
	assign pin_D_i = ~pin_RbW_i ? 8'bz : (~pin_bCS1_o ? pin_B1_io : (~pin_bCS0_o ? pin_B0_io : 8'bx));
endmodule
