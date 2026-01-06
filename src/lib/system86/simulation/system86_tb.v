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

//`define ROM_PATH "../../../../../../../../roms"
`define ROM_PATH "../../../../roms"
`include "roms/rthunder.vh"

module system86_tb;

	parameter C_VIDEO_COMPONENT_DEPTH = 4;

	// Inputs
	reg clk_48m;
	reg _rst_n;

	reg clk_25m;
		
	reg log = 0;
	
	wire vid_clk;
	wire [3:0] vid_red;
	wire [3:0] vid_green;
	wire [3:0] vid_blue;
	wire vid_bHSYNC;
	wire vid_bVSYNC;
	wire vid_bHBLANK;
	wire vid_bVBLANK;
	
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
	wire out_vid_bHSYNC;
	wire out_vid_bVSYNC;
	wire out1_bHSYNC;
	wire out1_bVSYNC;
	wire out2_bHSYNC;
	wire out2_bVSYNC;
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
			._rst_n(_rst_n),
			.clk_48m_i(clk_48m), 
			
			.vid_clk(vid_clk),
			.vid_red(vid_red),
			.vid_green(vid_green),
			.vid_blue(vid_blue),
			.vid_bHSYNC(vid_bHSYNC),
			.vid_bVSYNC(vid_bVSYNC),
			.vid_bHBLANK(vid_bHBLANK),
			.vid_bVBLANK(vid_bVBLANK),
			
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
			`SRAM_CONNECTION_DEFS(sram_7n, sram_7n),
			
			`SRAM_CONNECTION_DEFS(sram_10m, sram_10m),
			`SRAM_CONNECTION_DEFS(sram_11k, sram_11k)
		);

		// clut
	prom_mb7116 
		#(
			`ROM_3S
		) 
			prom_3s
		(
			.bE(prom_3s_ce_n), 
			.A(prom_3s_addr), 
			.Q(prom_3s_data)
		);
			
	prom_mb7124 
		#(
			`ROM_3R
		)
		prom_3r
		(
			.bE(prom_3r_ce_n), 
			.A(prom_3r_addr), 
			.Q(prom_3r_data)
		);	
		
	prom_mb7138 
		#(
			`ROM_4V
		) 
		prom_4v
		(
			.bE(prom_4v_ce_n), 
			.A(prom_4v_addr), 
			.Q(prom_4v_data)
		);	
		
	prom_mb7112 
		#(
			`ROM_6U
		) 
		prom_6u
		(
			.bE(prom_6u_ce_n), 
			.A(prom_6u_addr), 
			.Q(prom_6u_data)
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
			.bE(eprom_4r_ce_n), 
			.nG(eprom_4r_oe_n), 
			.A(eprom_4r_addr), 
			.Q(eprom_4r_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_4S),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_4s
		(
			.bE(eprom_4s_ce_n), 
			.nG(eprom_4s_oe_n), 
			.A(eprom_4s_addr), 
			.Q(eprom_4s_data)
		);	
	
	eprom_m27512 
		#(
			.FILE_NAME(`ROM_7R),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_7r
		(
			.bE(eprom_7r_ce_n), 
			.nG(eprom_7r_oe_n), 
			.A(eprom_7r_addr), 
			.Q(eprom_7r_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_7S),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_7s
		(
			.bE(eprom_7s_ce_n), 
			.nG(eprom_7s_oe_n), 
			.A(eprom_7s_addr), 
			.Q(eprom_7s_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_9C),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_9c
		(
			.bE(eprom_9c_ce_n), 
			.nG(eprom_9c_oe_n), 
			.A(eprom_9c_addr), 
			.Q(eprom_9c_data)
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
			.bE(eprom_9d_ce_n), 
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
			.bE(eprom_12c_ce_n), 
			.nG(eprom_12c_oe_n), 
			.A(eprom_12c_addr), 
			.Q(eprom_12c_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_12D),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_12d
		(
			.bE(eprom_12d_ce_n), 
			.nG(eprom_12d_oe_n), 
			.A(eprom_12d_addr), 
			.Q(eprom_12d_data)
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
			.bWE(sram_4n_we_n),
			.bOE(sram_4n_oe_n),
			.A(sram_4n_addr),
			.D(sram_4n_data)
		);
		
	sram_cy6264 
		/*#(
			"../../../../../../../../snapshots/rthunder_gfx1_002.bin"
		)*/
		sram_7n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_7n_we_n),
			.bOE(sram_7n_oe_n),
			.A(sram_7n_addr),
			.D(sram_7n_data)
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
			.bWE(sram_10m_we_n),
			.bOE(sram_10m_oe_n),
			.A(sram_10m_addr),
			.D(sram_10m_data)
		);
		
	sram_m58725 
		/*#(
			"../../../../../../../../snapshots/rthunder_gfx1_002.bin"
		)*/
		sram_11k
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_11k_we_n),
			.bOE(sram_11k_oe_n),
			.A(sram_11k_addr),
			.D(sram_11k_data)
		);
		
		Video_Logger
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.C_FILE_NAME("raw.txt")
		)
		raw_logger (
			.i_Rst(~_rst_n),
			.i_Clk(vid_clk),
			.i_OutputEnable(log),
			.i_Red(vid_red),
			.i_Green(vid_green),
			.i_Blue(vid_blue),
			.i_nHSync(vid_bHSYNC),
			.i_nVSync(vid_bVSYNC)
		);
		
	/*scan_doubler
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		doubler (
			.pixel_clk_in(vid_clk),
			.pixel_clk_out_ref(clk_24m),
			
			.red_in(vid_red),
			.green_in(vid_green),
			.blue_in(vid_blue),
			.hsync_in(vid_hsync),
			.vsync_in(vid_vsync),
			
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
			.o_nHSync(out1_bHSYNC),
			.o_nVSync(out1_bVSYNC)
		);
	
	Sync_To_Blanking
		output_blanking (
			.i_Clk(clk_25m),
			.i_Rst(rst),
			.i_nHSync(out1_bHSYNC),
			.i_nVSync(out1_bVSYNC),
			.o_nHSync(out2_bHSYNC),
			.o_nVSync(out2_bVSYNC),
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
			
			.i_ClkA(vid_clk),
			.i_RedA(vid_red),
			.i_GreenA(vid_green),
			.i_BlueA(vid_blue),
			.i_nHSyncA(vid_bHSYNC),
			.i_nVSyncA(vid_bVSYNC),
			.i_HBlankA(vid_hblank),
			.i_VBlankA(vid_vblank),
			
			.i_ClkB(clk_25m),
			.i_nHSyncB(out2_bHSYNC),
			.i_nVSyncB(out2_bVSYNC),
			.i_HBlankB(out2_hblank),
			.i_VBlankB(out2_vblank),
			
			.o_LockedA(in_vid_locked),
			.o_WidthA(in_vid_width),
			.o_HeightA(in_vid_height),
			.o_LockedB(out_vid_locked),
			.o_WidthB(out_vid_width),
			.o_HeightB(out_vid_height),
			
			.o_nHSyncB(out_vid_bHSYNC),
			.o_nVSyncB(out_vid_bVSYNC),
			
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
			.i_nHSync(out_vid_bHSYNC),
			.i_nVSync(out_vid_bVSYNC)
		);
		*/
		
	initial begin
		// Initialize Inputs
		clk_48m = 0;
		clk_25m = 0;
		_rst_n = 0;
		log = 0;

		// Wait 1000 ns for global reset to finish
		#2000;
		  
		// Add stimulus here
		_rst_n = 1;
		//log = 1;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		#100000000;
		log = 1;
		#120000000;
		$stop();
		
	end

	// generate our 49.125Mhz input clock
	always #10.1725 clk_48m = ~clk_48m;     
	
	// generate our 25Mhz VGA clock
	always #19.5313 clk_25m = ~clk_25m;
	
endmodule

