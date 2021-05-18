`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:			 Paul Wightmore
// 
// Create Date:		 20:18:35 04/12/2018 
// Design Name: 
// Module Name:		 system86/simulation/system86.v
// Project Name:	 Namco System86 top-level simulation module
// Target Devices: 
// Tool versions: 
// Description:		 Top-level Namco System86 board simulation
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

//`include "system86/system86.vh"

`include "mc6809_cpu/mc6809.vh"

`include "ttl_mem/mb7112.vh"
`include "ttl_mem/mb7116.vh"
`include "ttl_mem/mb7124.vh"
`include "ttl_mem/mb7138.vh"

`include "ttl_mem/m27128.vh"
`include "ttl_mem/m27256.vh"
`include "ttl_mem/m27512.vh"

`include "ttl_mem/cy6264.vh"
`include "ttl_mem/m58725.vh"

`include "ttl_mem/ttl_mem.vh"

//`include "roms/rthunder.vh"

module xsystem86
	#(
		parameter LAYER_DISABLE_MASK = 0,
		parameter BACKGROUND_LAYER_AUTOSCROLL = 0,
		parameter BACKGROUND_LAYER_PRIORITY = 0,
		parameter FOREGROUND_LAYER_PRIORITY = 0,
		parameter TEXT_LAYER_PRIORITY = 0,
		parameter UNKNOWN_LAYER_PRIORITY = 0
	)
	(
		// == Simulation inputs
		input wire rst_n,				// master reset
		
		// == Simulation outputs
		output wire vid_clk,
		//output wire [11:0] vid_data,
		output wire vid_hsync_n,
		output wire vid_vsync_n,
		output wire vid_hblank_n,
		output wire vid_vblank_n,

		// System 86 hardware timing
		input wire clk_48m,				// System 86 master clock @ 49.125 MHz

		// == Native 4 bit RGB output and composite sync signals ==
		output wire conn_j2_sync,
		output wire [3:0] conn_j2_red,
		output wire [3:0] conn_j2_green,
		output wire [3:0] conn_j2_blue,

		// == External boards connectors
		inout wire [1:20] conn_j5,			// 20 pin
		inout wire [1:40] conn_j34p,		// 40 pin
		
		// == Pluggable CPUs
		//`MC6809_OUTPUT_DEFS(E, mcpu_11a),		// 6809 - master cpu
		//`MC6809_OUTPUT_DEFS(E, scpu_9a),			// 6809 - sub cpu
		
		// == Pluggable proms
		
		`PROM_OUTPUT_DEFS(MB7124, prom_3r),			// 7124 - 20 pin DIP/DIL
		`PROM_OUTPUT_DEFS(MB7116, prom_3s), 		// 7116 - 16 pin DIP/DIL		
		`PROM_OUTPUT_DEFS(MB7138, prom_4v),			// 7138
		`PROM_OUTPUT_DEFS(MB7112, prom_6u),			// 7112
		
		// PROG
		`EPROM_OUTPUT_DEFS(M27256, eprom_9c),
		`EPROM_OUTPUT_DEFS(M27256, eprom_9d),
		`EPROM_OUTPUT_DEFS(M27256, eprom_12c),
		`EPROM_OUTPUT_DEFS(M27256, eprom_12d),
		
		// GFX
		`EPROM_OUTPUT_DEFS(M27512, eprom_7r),
		`EPROM_OUTPUT_DEFS(M27256, eprom_7s),
		`EPROM_OUTPUT_DEFS(M27512, eprom_4r),
		`EPROM_OUTPUT_DEFS(M27256, eprom_4s),
		
		// SRAM
		`SRAM_OUTPUT_DEFS(CY6264, sram_4n),
		`SRAM_OUTPUT_DEFS(CY6264, sram_7n),
		`SRAM_OUTPUT_DEFS(CY6264, sram_10m),
		`SRAM_OUTPUT_DEFS(M58725, sram_11k)
	);
	
	system86 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK),
			.BACKGROUND_LAYER_AUTOSCROLL(BACKGROUND_LAYER_AUTOSCROLL),
			.BACKGROUND_LAYER_PRIORITY(BACKGROUND_LAYER_PRIORITY),
			.FOREGROUND_LAYER_PRIORITY(FOREGROUND_LAYER_PRIORITY),
			.TEXT_LAYER_PRIORITY(TEXT_LAYER_PRIORITY),
			.UNKNOWN_LAYER_PRIORITY(UNKNOWN_LAYER_PRIORITY)
		)
		system86 (
			.clk_48m(clk_48m), 
			.rst_n(rst_n),
			
			.vid_clk(vid_clk),
			.vid_data(0),
			.vid_hsync_n(vid_hsync_n),
			.vid_vsync_n(vid_vsync_n),
			.vid_hblank_n(vid_hblank_n),
			.vid_vblank_n(vid_vblank_n),
			
			.conn_j2_sync(conn_j2_sync),
			.conn_j2_red(conn_j2_red),
			.conn_j2_green(conn_j2_green),
			.conn_j2_blue(conn_j2_blue),
			
			.conn_j5(conn_j5),
			.conn_j34p(conn_j34p),
			
			//`MC6809_CONNECTION_DEFS(mcpu_11a, mcpu_11a),
			//`MC6809_CONNECTION_DEFS(scpu_9a, scpu_9a),
			
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
		
endmodule
