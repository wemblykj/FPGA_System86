`timescale 1ns/1fs
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:57:30 04/12/2018
// Design Name:    system86_tb
// Module Name:    system86/simulation/test_bench/system86_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description:   Top-level Namco System86 board simulation - test bench
//
// Verilog Test Fixture created by ISE for module: system86
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

`include "../../ttl_mem/mb7116.vh"
`include "../../ttl_mem/mb7124.vh"

`include "../../ttl_mem/ttl_mem.vh"

`define ROM_PATH "../../../../../../../../roms"
`include "../../../../roms/rthunder.vh"

module system86_tb;

	parameter C_VIDEO_COMPONENT_DEPTH = 4;

	// Inputs
	reg clk_48m;
	reg rst;

	reg clk_25m;
		
	wire s86_vid_clk;
	wire [3:0] s86_vid_red;
	wire [3:0] s86_vid_green;
	wire [3:0] s86_vid_blue;
	wire s86_hsync_n;
	wire s86_vsync_n;
	wire s86_hblank;
	wire s86_vblank;
	
	`WIRE_DEFS(MB7124, s86_prom_3r);
	`WIRE_DEFS(MB7116, s86_prom_3s);
	
	wire [3:0] out_vid_red;
	wire [3:0] out_vid_green;
	wire [3:0] out_vid_blue;
	wire in_vid_locked;
	wire [11:0] in_vid_width;
	wire [11:0] in_vid_height;
	wire out_vid_locked;
	wire [11:0] out_vid_width;
	wire [11:0] out_vid_height;
	wire out_vid_hsync_n;
	wire out_vid_vsync_n;
	wire out1_hsync_n;
	wire out1_vsync_n;
	wire out2_hsync_n;
	wire out2_vsync_n;
	wire out2_hblank;
	wire out2_vblank;
	
	// Instantiate the Unit Under Test (UUT)
	system86 
		#(
			.VIDEO_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		uut (
			.clk(clk_48m), 
			.rst(rst),
			
			.vid_clk(s86_vid_clk),
			.vid_red(s86_vid_red),
			.vid_green(s86_vid_green),
			.vid_blue(s86_vid_blue),
			.vid_hsync_n(s86_hsync_n),
			.vid_vsync_n(s86_vsync_n),
			.vid_hblank_n(s86_hblank),
			.vid_vblank_n(s86_vblank),
			
			`PROM_CONNECTION_DEFS(prom_3r, s86_prom_3r),
			`PROM_CONNECTION_DEFS(prom_3s, s86_prom_3s)
		);

		// clut
		PROM_7116 #(`ROM_3S) prom_3s(
			.nE(s86_prom_3s_ce_n), 
			.A(s86_prom_3s_addr), 
			.Q(s86_prom_3s_data));
			
		PROM_7124 #(`ROM_3R) prom_3r(
			.nE(s86_prom_3r_ce_n), 
			.A(s86_prom_3r_addr), 
			.Q(s86_prom_3r_data));	
		
		// tile ram
		cy6264 sram_4n(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(s86_sram_4n_we_n),
			.nOE(s86_sram_4n_oe_n),
			.A(s86_sram_4n_addr),
			.D(s86_sram_4n_data)
		);
		
		cy6264 sram_7n(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(s86_sram_7n_we_n),
			.nOE(s86_sram_7n_oe_n),
			.A(s86_sram_7n_addr),
			.D(s86_sram_7n_data)
		);
		
		Video_Logger
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.C_FILE_NAME("raw.txt")
		)
		raw_logger (
			.i_Rst(rst),
			.i_Clk(s86_vid_clk),
			.i_OutputEnable(~rst),
			.i_Red(s86_vid_red),
			.i_Green(s86_vid_green),
			.i_Blue(s86_vid_blue),
			.i_nHSync(s86_hsync_n),
			.i_nVSync(s86_vsync_n)
		);
		
	/*scan_doubler
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		doubler (
			.pixel_clk_in(s86_vid_clk),
			.pixel_clk_out_ref(clk_24m),
			
			.red_in(s86_vid_red),
			.green_in(s86_vid_green),
			.blue_in(s86_vid_blue),
			.hsync_in(s86_hsync),
			.vsync_in(s86_vsync),
			
			.red_out(x2_vid_red),
			.green_out(x2_vid_green),
			.blue_out(x2_vid_blue),
			.hsync_out(x2_hsync),
			.vsync_out(x2_vsync)
		);*/
		
	VGA_Sync_Pulses
		//#(
		//)
		output_sync_gen (
			.i_Clk(clk_25m),
			.i_Rst(rst),
			.o_nHSync(out1_hsync_n),
			.o_nVSync(out1_vsync_n)
		);
	
	Sync_To_Blanking
		output_blanking (
			.i_Clk(clk_25m),
			.i_Rst(rst),
			.i_nHSync(out1_hsync_n),
			.i_nVSync(out1_vsync_n),
			.o_nHSync(out2_hsync_n),
			.o_nVSync(out2_vsync_n),
			.o_HBlank(out2_hblank),
			.o_VBlank(out2_vblank)
		);
		
	/*Upscaler
		#(
			.COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.USE_BLANKING_A(1),
			.USE_BLANKING_B(1),
			.LINE_BUFFER_COUNT(16),
			.SCALE_PRECISION_WIDTH(12),
			.SCALE_PRECISION_HEIGHT(12)
		)
		Upscaler (
			.i_Rst(rst),
			
			.i_ClkA(s86_vid_clk),
			.i_RedA(s86_vid_red),
			.i_GreenA(s86_vid_green),
			.i_BlueA(s86_vid_blue),
			.i_nHSyncA(s86_hsync_n),
			.i_nVSyncA(s86_vsync_n),
			.i_HBlankA(s86_hblank),
			.i_VBlankA(s86_vblank),
			
			.i_ClkB(clk_25m),
			.i_nHSyncB(out2_hsync_n),
			.i_nVSyncB(out2_vsync_n),
			.i_HBlankB(out2_hblank),
			.i_VBlankB(out2_vblank),
			
			.o_LockedA(in_vid_locked),
			.o_WidthA(in_vid_width),
			.o_HeightA(in_vid_height),
			.o_LockedB(out_vid_locked),
			.o_WidthB(out_vid_width),
			.o_HeightB(out_vid_height),
			
			.o_nHSyncB(out_vid_hsync_n),
			.o_nVSyncB(out_vid_vsync_n),
			
			.o_RedB(out_vid_red),
			.o_GreenB(out_vid_green),
			.o_BlueB(out_vid_blue)
		);
		
	Video_Logger
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.C_FILE_NAME("scaled.txt")
		)
		vga_logger (
			.i_Rst(rst),
			.i_Clk(clk_25m),
			.i_OutputEnable(out_vid_locked),
			.i_Red(out_vid_red),
			.i_Green(out_vid_green),
			.i_Blue(out_vid_blue),
			.i_nHSync(out_vid_hsync_n),
			.i_nVSync(out_vid_vsync_n)
		);
		*/
	initial begin
		// Initialize Inputs
		clk_48m = 0;
		clk_25m = 0;
		rst = 1;

		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end

	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;     
	
	// generate our 25Mhz VGA clock
	always #19.5313 clk_25m = ~clk_25m;
	
endmodule

