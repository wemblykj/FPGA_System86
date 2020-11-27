`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:57:30 04/12/2018
// Design Name:    system86_tb
// Module Name:    system86/simulation/subsystem/videogen_subsystem_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description:   Top-level Namco System86 board simulation - test bench
//
// Verilog Test Fixture created by ISE for module: videogen_subsystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

`include "ttl_mem/mb7116.vh"
`include "ttl_mem/mb7124.vh"

`include "ttl_mem/ttl_mem.vh"

`define ROM_PATH "../../../../../../../../roms"
`include "roms/rthunder.vh"

module videogen_subsystem_tb;

	// Inputs
	reg clk;
	reg rst;
	
	`PROM_WIRE_DEFS(MB7124, prom_3r);
	`PROM_WIRE_DEFS(MB7116, prom_3s);
	
	wire nHSYNC;
	wire nVSYNC;
	wire nHSYNC_2;
	wire nVSYNC_2;
	wire HBLANK_2;
	wire VBLANK_2;
	wire nHSYNC_3;
	wire nVSYNC_3;
	wire HBLANK_3;
	wire VBLANK_3;
	
 
	wire SYNC;
	wire [3:0] RED;
	wire [3:0] GREEN;
	wire [3:0] BLUE;
	
	// == [not so] global signals ==
	wire [7:0] DOT;			// multiplexed tilemap color index and sprite color index
			
	reg clut_bank = 1'b0;
	
	// == Timing subsystem ==
	/*timing_subsystem
		timing_subsystem(
			.CLK_48M(clk),
			.CLK_6M(CLK_6M),
			.CLK_6MD(CLK_6MD),	// secondary driver? in phase with 6M
			.nVSYNC(nVSYNC),
			.nHSYNC(nHSYNC),
			.nHBLANK(nHBLANK),
			.nVBLANK(nVBLANK),
			.nVRESET(nVRESET),
			.BLANKING(BLANKING),
			.nCOMPSYNC(nCOMPSYNC),
			.CLK_1H(CLK_1H),
			.CLK_S1H(CLK_S1H),	// secondary driver? in phase with 1H
			.CLK_2H(CLK_2H),
			.CLK_S2H(CLK_S2H),	// secondary driver? in phase with 2H
			.CLK_4H(CLK_4H)
		);
	*/
	
	// clut
	prom_mb7116 #(`ROM_3S) prom_3s(
		.nE(prom_3s_ce_n), 
		.A(prom_3s_addr), 
		.Q(prom_3s_data));
		
	prom_mb7124 #(`ROM_3R) prom_3r(
		.nE(prom_3r_ce_n), 
		.A(prom_3r_addr), 
		.Q(prom_3r_data));	
		
	videogen_subsystem
		uut(
			.rst(rst),
			
			// input
			.CLK_6MD(clk), 
			.nCLR(1'b1), //.CLR(ls174_6v_q6), 
			.D(DOT), 
			.BANK(clut_bank), //.BANK(ls174_9v_q5), 
			// output
			.SYNC(SYNC),
			.RED(RED), 
			.GREEN(GREEN), 
			.BLUE(BLUE),
			
			`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
			`PROM_CONNECTION_DEFS(prom_3s, prom_3s)
						
			// == hardware abstraction - memory buses ==
		);	
	
	VGA_Sync_Pulses
		#(
			.TOTAL_COLS(384),
			.TOTAL_ROWS(288),
			.SYNC_PULSE_HORZ(32),
			.SYNC_PULSE_VERT(8)
		)
		VGA_Sync_Pulses
		(
			.i_Clk(clk),
			.i_Rst(rst),
			.o_nHSync(nHSYNC),
			.o_nVSync(nVSYNC)
		);
		
	Sync_To_Blanking
		#(
			.TOTAL_COLS(384),
			.TOTAL_ROWS(288),
			.ACTIVE_COLS(288),
			.ACTIVE_ROWS(224),
			.SYNC_PULSE_HORZ(32),
			.SYNC_PULSE_VERT(8),
			.FRONT_PORCH_HORZ(32),
			.BACK_PORCH_HORZ(32),
			.FRONT_PORCH_VERT(48),
			.BACK_PORCH_VERT(8)
		)
		Sync_To_Blanking
		(
			.i_Clk(clk),
			.i_Rst(rst),
			.i_nHSync(nHSYNC),
			.i_nVSync(nVSYNC),
			.o_nHSync(nHSYNC_2),
			.o_nVSync(nVSYNC_2),
			.o_HBlank(HBLANK_2),
			.o_VBlank(VBLANK_2)
		);
		
	wire vid_locked;
	wire vid_active;
	wire [9:0] vid_active_col;
	wire [9:0] vid_active_row;
	
	Blanking_To_Count
		#(
			.ACTIVE_COLS(288),
			.ACTIVE_ROWS(224)
		)
		Blanking_To_Count
		(
			.i_Clk(clk),
			.i_Rst(rst),
			.i_nHSync(nHSYNC_2),
			.i_nVSync(nVSYNC_2),
			.i_HBlank(HBLANK_2),
			.i_VBlank(VBLANK_2),
			.o_Locked(vid_locked),
			.o_Active(vid_active),
			.o_nHSync(nHSYNC_3),
			.o_nVSync(nVSYNC_3),
			.o_HBlank(HBLANK_3),
			.o_VBlank(VBLANK_3),
			.o_Col_Count(vid_active_col),
			.o_Row_Count(vid_active_row)
		);
		
	reg [15:0] dot_lsb_acc = 0;
	reg [15:0] dot_msb_acc = 0;
	
	always @(negedge clk) begin
		if (vid_active_row[8:0] === 9'b001110000)
			clut_bank <= 1'b1;
		else if (vid_active_row[8:0] === 9'b000000000)
			clut_bank <= 1'b0;
			
		if (vid_active_col === 0) begin
			dot_lsb_acc <= 16'b0;
				
			if (vid_active_row === 112 || vid_active_row === 0)
				dot_msb_acc <= 16'b0;
			else
				dot_msb_acc <= dot_msb_acc + 590;
		end else
			dot_lsb_acc <= dot_lsb_acc + 228;			
	end
	
	assign DOT = (vid_active !== 1'b0) ? { dot_msb_acc[15:13], dot_lsb_acc[15:11] } : 8'b0;
		
	Video_Logger
	#(
		.C_COMPONENT_DEPTH(4),
		.C_FILE_NAME("raw.txt")
	)
	raw_logger (
		.i_Rst(rst),
		.i_Clk(clk),
		.i_OutputEnable(vid_locked),
		.i_Red(RED),
		.i_Green(GREEN),
		.i_Blue(BLUE),
		.i_nHSync(nHSYNC_3),
		.i_nVSync(nVSYNC_3)
	);
				
	initial begin
		// Initialize Inputs
		rst = 0;
		CLK_6M= 0;

		// Wait 1000 ns for global reset to finish
		#100;
      rst = 1;
		
		// Add stimulus here
		
	end

	// generate our 6.14025Mhz input clock
	always #81.4299 CLK_6M = ~CLK_6M;

endmodule

