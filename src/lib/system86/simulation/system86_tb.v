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

`include "ttl_mem/mb7112.vh"
`include "ttl_mem/mb7116.vh"
`include "ttl_mem/mb7124.vh"
`include "ttl_mem/mb7138.vh"

`include "ttl_mem/m27512.vh"
`include "ttl_mem/m27256.vh"

`include "ttl_mem/cy6264.vh"
`include "ttl_mem/m58725.vh"

`include "ttl_mem/ttl_mem.vh"

`define ROM_PATH "../../../../../../../../roms"
`include "roms/rthunder.vh"

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
	wire s86_hblank_n;
	wire s86_vblank_n;
	
	`PROM_WIRE_DEFS(MB7124, prom_3r);
	`PROM_WIRE_DEFS(MB7116, prom_3s);
	`PROM_WIRE_DEFS(MB7138, prom_4v);
	`PROM_WIRE_DEFS(MB7112, prom_6u);
	
	`EPROM_WIRE_DEFS(M27512, eprom_4r);
	`EPROM_WIRE_DEFS(M27256, eprom_4s);
	`EPROM_WIRE_DEFS(M27512, eprom_7r);
	`EPROM_WIRE_DEFS(M27256, eprom_7s);
	
	`EPROM_WIRE_DEFS(M27256, eprom_9c);
	`EPROM_WIRE_DEFS(M27256, eprom_9d);
	`EPROM_WIRE_DEFS(M27256, eprom_12c);
	`EPROM_WIRE_DEFS(M27256, eprom_12d);
	
	`SRAM_WIRE_DEFS(CY6264, sram_4n);
	`SRAM_WIRE_DEFS(CY6264, sram_7n);
	
	`SRAM_WIRE_DEFS(CY6264, sram_10m);
	`SRAM_WIRE_DEFS(M58725, sram_11k);
	
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
			.VIDEO_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.LAYER_DISABLE_MASK(4'b0000),
			.BACKGROUND_LAYER_AUTOSCROLL(0),
			.BACKGROUND_LAYER_PRIORITY(2),
			.FOREGROUND_LAYER_PRIORITY(3),
			.TEXT_LAYER_PRIORITY(4),
			.UNKNOWN_LAYER_PRIORITY(5)
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
			.vid_hblank_n(s86_hblank_n),
			.vid_vblank_n(s86_vblank_n),
			
			`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
			`PROM_CONNECTION_DEFS(prom_3s, prom_3s),
			
			`PROM_CONNECTION_DEFS(prom_4v, prom_4v),
			`PROM_CONNECTION_DEFS(prom_6u, prom_6u),
			
			`EPROM_CONNECTION_DEFS(eprom_4r, eprom_4r),
			`EPROM_CONNECTION_DEFS(eprom_4s, eprom_4s),
			`EPROM_CONNECTION_DEFS(eprom_7r, eprom_7r),
			`EPROM_CONNECTION_DEFS(eprom_7s, eprom_7s),
			
			`EPROM_CONNECTION_DEFS(eprom_9c, eprom_9c),
			`EPROM_CONNECTION_DEFS(eprom_9d, eprom_9d),
			`EPROM_CONNECTION_DEFS(eprom_12c, eprom_12c),
			`EPROM_CONNECTION_DEFS(eprom_12d, eprom_12d),
			
			`SRAM_CONNECTION_DEFS(sram_4n, sram_4n),
			`SRAM_CONNECTION_DEFS(sram_7n, sram_7n)
		);

		// clut
	prom_mb7116 
		#(
			`ROM_3S
		) 
			prom_3s
		(
			.nE(prom_3s_ce_n), 
			.A(prom_3s_addr), 
			.Q(prom_3s_data),
			.data_valid(prom_3s_dv)
		);
			
	prom_mb7124 
		#(
			`ROM_3R
		)
		prom_3r
		(
			.nE(prom_3r_ce_n), 
			.A(prom_3r_addr), 
			.Q(prom_3r_data),
			.data_valid(prom_3r_dv)
		);	
		
	prom_mb7138 
		#(
			`ROM_4V
		) 
		prom_4v
		(
			.nE(prom_4v_ce_n), 
			.A(prom_4v_addr), 
			.Q(prom_4v_data),
			.data_valid(prom_4v_dv)
		);	
		
	prom_mb7112 
		#(
			`ROM_6U
		) 
		prom_6u
		(
			.nE(prom_6u_ce_n), 
			.A(prom_6u_addr), 
			.Q(prom_6u_data),
			.data_valid(prom_6u_dv)
		);	
	
	// trying 200ns as per GnG instead of 250ns as documented in Rolling Thunder operators manual
	eprom_m27512 
		#(
			.FILE_NAME(`ROM_4R),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_4r
		(
			.nE(eprom_4r_ce_n), 
			.nG(eprom_4r_oe_n), 
			.A(eprom_4r_addr), 
			.Q(eprom_4r_data),
			.data_valid(eprom_4r_dv)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_4S),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_4s
		(
			.nE(eprom_4s_ce_n), 
			.nG(eprom_4s_oe_n), 
			.A(eprom_4s_addr), 
			.Q(eprom_4s_data),
			.data_valid(eprom_4s_dv)
		);	
	
	eprom_m27512 
		#(
			.FILE_NAME(`ROM_7R),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_7r
		(
			.nE(eprom_7r_ce_n), 
			.nG(eprom_7r_oe_n), 
			.A(eprom_7r_addr), 
			.Q(eprom_7r_data),
			.data_valid(eprom_7r_dv)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_7S),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_7s
		(
			.nE(eprom_7s_ce_n), 
			.nG(eprom_7s_oe_n), 
			.A(eprom_7s_addr), 
			.Q(eprom_7s_data),
			.data_valid(eprom_7s_dv)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_9C),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_9c
		(
			.nE(eprom_9c_ce_n), 
			.nG(eprom_9c_oe_n), 
			.A(eprom_9c_addr), 
			.Q(eprom_9c_data),
			.data_valid(eprom_9c_dv)
		);	
		
	/* not used for rthunder
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_9D),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_9d
		(
			.nE(eprom_9d_ce_n), 
			.nG(eprom_9d_oe_n), 
			.A(eprom_9d_addr), 
			.Q(eprom_9d_data),
			.data_valid(eprom_9d_dv)
		);	
	*/
	
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_12C),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_12c
		(
			.nE(eprom_12c_ce_n), 
			.nG(eprom_12c_oe_n), 
			.A(eprom_12c_addr), 
			.Q(eprom_12c_data),
			.data_valid(eprom_12c_dv)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_12D),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_12d
		(
			.nE(eprom_12d_ce_n), 
			.nG(eprom_12d_oe_n), 
			.A(eprom_12d_addr), 
			.Q(eprom_12d_data),
			.data_valid(eprom_12d_dv)
		);	
			
		// tile ram
	sram_cy6264 
		/*#(
			"../../../../../../../../snapshots/rthunder_gfx2_002.bin"
		)*/
		sram_4n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(sram_4n_we_n),
			.nOE(sram_4n_oe_n),
			.A(sram_4n_addr),
			.D(sram_4n_data),
			.data_valid(sram_4n_dv)
		);
		
	sram_cy6264 
		/*#(
			"../../../../../../../../snapshots/rthunder_gfx1_002.bin"
		)*/
		sram_7n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(sram_7n_we_n),
			.nOE(sram_7n_oe_n),
			.A(sram_7n_addr),
			.D(sram_7n_data),
			.data_valid(sram_7n_dv)
		);

	// sprite ram
	sram_cy6264 
		/*#(
			"../../../../../../../../snapshots/rthunder_gfx2_002.bin"
		)*/
		sram_10m
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(sram_10m_we_n),
			.nOE(sram_10m_oe_n),
			.A(sram_10m_addr),
			.D(sram_10m_data),
			.data_valid(sram_10m_dv)
		);
		
	sram_m58725 
		/*#(
			"../../../../../../../../snapshots/rthunder_gfx1_002.bin"
		)*/
		sram_11k
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.nWE(sram_11k_we_n),
			.nOE(sram_11k_oe_n),
			.A(sram_11k_addr),
			.D(sram_11k_data),
			.data_valid(sram_11k_dv)
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
		
	/*VGA_Sync_Pulses
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
		
	Upscaler
		#(
			.COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.USE_BLANKING_A(1),
			.USE_BLANKING_B(1),
			.LINE_BUFFER_COUNT(128),
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
		#2000;
        
		// Add stimulus here
		rst = 0;
	end

	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;     
	
	// generate our 25Mhz VGA clock
	always #19.5313 clk_25m = ~clk_25m;
	
endmodule

