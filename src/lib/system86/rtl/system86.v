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

`include "system86/system86.vh"

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

`include "roms/rthunder.vh"

module system86
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
		input wire _rst_n,				// master reset
		
		// == Simulation outputs
		output wire vid_clk,
		output wire [11:0] vid_data,
		output wire vid_hsync_n,
		output wire vid_vsync_n,
		output wire vid_hblank_n,
		output wire vid_vblank_n,
		output wire [3:0] vid_red,
		output wire [3:0] vid_green,
		output wire [3:0] vid_blue,

		// System 86 hardware timing
		input wire s86_48M_i,				// System 86 master clock @ 49.125 MHz

		// == Native 4 bit RGB output and composite sync signals ==
		output wire [3:0] s86_J2_1_RED,
		output wire [3:0] s86_J2_2_GREEN,
		output wire [3:0] s86_J2_3_BLUE,
		output wire s86_J2_4_SYNC,

		// == External boards connectors
		inout wire [1:20] s86_J5_io,			// 20 pin
		inout wire [1:40] s86_J34_io,		// 40 pin
		
		// == Pluggable CPUs
		
		`MC6809_INPUT_DEFS(E, mcpu_11a),		// 6809 - master cpu
		`MC6809_INPUT_DEFS(E, scpu_9a),			// 6809 - sub cpu
		
		// == Pluggable proms
		
		`PROM_OUTPUT_DEFS(MB7124, prom_3r),			// 7124 - 20 pin DIP/DIL
		`PROM_OUTPUT_DEFS(MB7116, prom_3s), 		// 7116 - 16 pin DIP/DIL		
		`PROM_OUTPUT_DEFS(MB7138, prom_4v),			// 7138
		`PROM_OUTPUT_DEFS(MB7138, prom_5v),			// 7138
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
	
	// == global signals ==
	//wire RESET;
	wire s86_6M;
	wire s86_1H;
	wire s86_S1H;
	wire s86_2H;
	wire s86_S2H;
	wire [12:0] s86_A;
	wire [7:0] s86_D;
	wire s86_bSCROLL0;
	wire s86_bSCROLL1;
	wire s86_OBJECT;
	wire s86_bLATCH0;
	wire s86_bLATCH1;
	wire s86_bBACKCOLOR;
	wire s86_RbW;
	wire s86_BANK = 1'b0;
	wire s86_FLIP = 1'b0;
	
	wire s86_bHSYNC;
	wire s86_bVSYNC;
	wire s86_bHBLANK;
	wire s86_bVBLANK;
 
	wire s86_BLANKING;
	wire s86_bCOMPSYNC;
	wire s86_bHRESET;
	wire s86_bVRESET;
	
	wire [3:0] s86_RED;
	wire [3:0] s86_GREEN;
	wire [3:0] s86_BLUE;
	
	// == [not so] global signals ==
	wire [7:0] s86_MD;					// master CPU data bus to backcolor latch
	wire [2:0] SPR = 3'b0;			// CUS43 tile generator to sprite enable logic
	wire [7:0] DOT;			// multiplexed tilemap color index and sprite color index
	 
	// == Timing subsystem ==
	timing_subsystem
		timing_subsystem(
			._rst_n(_rst_n),
			
			.s86_48M_i(s86_48M_i),
      //.CLK_24M(0),
      //.CLK_12M(0),
			.s86_6M_o(s86_6M),
			.s86_6MD_o(s86_6MD),	// secondary driver? in phase with 6M
			//.s86_X6M_o(s86_X6M),
			//.s86_X24M_o(s86_X24M),
			.s86_bVSYNC_o(s86_bVSYNC),
			.s86_bHSYNC_o(s86_bHSYNC),
			.s86_bHBLANK_o(s86_bHBLANK),
			.s86_bVBLANK_o(s86_bVBLANK),
			.s86_bVRESET_o(s86_bVRESET),
			.s86_BLANKING_o(s86_BLANKING),
			.s86_bCOMPSYNC_o(s86_bCOMPSYNC),
			.s86_1H_o(s86_1H),
			.s86_S1H_o(s86_S1H),	// secondary driver? in phase with 1H
			.s86_2H_o(s86_2H),
			.s86_S2H_o(s86_S2H)	// secondary driver? in phase with 2H
			//.s86_4H(s86_4H)
		);
	
	/*tilegen_subsystem
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK),
			.BACKGROUND_LAYER_AUTOSCROLL(BACKGROUND_LAYER_AUTOSCROLL),
			.BACKGROUND_LAYER_PRIORITY(BACKGROUND_LAYER_PRIORITY),
			.FOREGROUND_LAYER_PRIORITY(FOREGROUND_LAYER_PRIORITY),
			.TEXT_LAYER_PRIORITY(TEXT_LAYER_PRIORITY),
			.UNKNOWN_LAYER_PRIORITY(UNKNOWN_LAYER_PRIORITY)
		)
		tilegen_subsystem
		(
			._rst_n(_rst_n),
			
			// input
			.s86_6M_i(s86_6M),
			.s86_2H_i(s86_2H),
			.s86_bSCROLL0_i(s86_bSCROLL0),
			.s86_bSCROLL1_i(s86_bSCROLL1),
			.s86_bLATCH0_i(s86_bLATCH0),
			.s86_bLATCH1_i(s86_bLATCH1),
			.s86_bHSYNC_i(s86_bHSYNC),
			.s86_bVSYNC_i(s86_bVSYNC),
			.s86_FLIP_i(s86_FLIP),
			.s86_BANK_i(s86_BANK),
			.SRCWIN_i(SRCWIN),
			.s86_bBACKCOLOR_i(s86_bBACKCOLOR),
			.s86_A_i(s86_A[12:0]),
			.s86_RbW_i(s86_RbW),
			.MD_i(s86_MD),
			// inout
			.s86_D_io(s86_D),
			.s86_J5_io_io(s86_J5_io),
			// output
			.s86_SPR_o(SPR),
			.s86_DOT_o(DOT),
						
			// == hardware abstraction - memory buses ==			
			`EPROM_CONNECTION_DEFS(eprom_4r, eprom_4r),
			`EPROM_CONNECTION_DEFS(eprom_4s, eprom_4s),
			`PROM_CONNECTION_DEFS(prom_4v, prom_4v),
			`PROM_CONNECTION_DEFS(prom_6u, prom_6u),
			`EPROM_CONNECTION_DEFS(eprom_7r, eprom_7r),
			`EPROM_CONNECTION_DEFS(eprom_7s, eprom_7s),
			`SRAM_CONNECTION_DEFS(sram_4n, sram_4n),
			`SRAM_CONNECTION_DEFS(sram_7n, sram_7n)
		);*/
	
	reg ls174_9v_q5 = 1'b0;	// videogen_s86_BANK
	reg ls174_6v_q6 = 1'b1;	// videogen_clear
	
	/*sprite_subsystem
		sprite_subsystem
		(
			._rst_n(_rst_n),
			
			// input
			.s86_6M(s86_6M),
			.s86_1H(s86_1H),
			.s86_OBJECT(s86_OBJECT),
			.s86_bHSYNC(s86_bHSYNC),
			.s86_bVRESET(s86_bVRESET),
			.s86_A(s86_A[12:0]),
			.s86_RbW(s86_RbW),
			.s86_D(s86_D),
						
			// == hardware abstraction - memory buses ==			
			//`EPROM_CONNECTION_DEFS(eprom_4r, eprom_4r),
			//`EPROM_CONNECTION_DEFS(eprom_4s, eprom_4s),
			//`PROM_CONNECTION_DEFS(prom_4v, prom_4v),
			//`PROM_CONNECTION_DEFS(prom_6u, prom_6u),
			//`EPROM_CONNECTION_DEFS(eprom_7r, eprom_7r),
			//`EPROM_CONNECTION_DEFS(eprom_7s, eprom_7s),
			`SRAM_CONNECTION_DEFS(sram_10m, sram_10m),
			`SRAM_CONNECTION_DEFS(sram_11k, sram_11k)
		);*/
		
	videogen_subsystem
		videogen_subsystem(
			._rst_n(_rst_n),
			// input
			.s86_6MD_i(s86_6MD), 
			.s86_bCLR_i(ls174_6v_q6),
			.s86_D_i(DOT), 
			.s86_BANK_i(ls174_9v_q5), 
			// output
			.s86_RED_o(s86_RED), 
			.s86_GREEN_o(s86_GREEN), 
			.s86_BLUE_o(s86_BLUE),
			
			// == hardware abstraction - memory buses ==
			`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
			`PROM_CONNECTION_DEFS(prom_3s, prom_3s)
		);	
		
	cpu_subsystem
		cpu_subsystem(
			._rst_ni(_rst_n),
			// inputs
			.s86_6M_i(s86_6M),
			.s86_2H_i(s86_2H),
			.s86_S2H_i(s86_S2H),
			.s86_1H_i(s86_1H),
			.s86_S1H_i(s86_S1H),
			.s86_bVBLANK_i(s86_bVBLANK),
			//.s86_bRESET(s86_bRESET),
			// inout
			.s86_A_o(s86_A),
			.s86_D_io(s86_D),
			// outputs
			.s86_RbW_o(s86_RbW),
			.s86_bRESET_o(s86_bRESET),	// input???
			.s86_bSCROLL0_o(s86_bSCROLL0),
			.s86_bSCROLL1_o(s86_bSCROLL1),
			.s86_OBJECT_o(s86_OBJECT),
			.s86_bLATCH0_o(s86_bLATCH0),
			.s86_bLATCH1_o(s86_bLATCH1),
			.s86_bBACKCOLOR_o(s86_bBACKCOLOR),
			.s86_BANK_o(s86_BANK),
			.s86_MD_o(s86_MD),
			// == hardware abstraction - CPU buses ==
			`MC6809_CONNECTION_DEFS(mcpu_11a, mcpu_11a),
			`MC6809_CONNECTION_DEFS(scpu_9a, scpu_9a),
		  
			// == hardware abstraction - memory buses ==
			`EPROM_CONNECTION_DEFS(eprom_9c, eprom_9c),
			`EPROM_CONNECTION_DEFS(eprom_9d, eprom_9d),
			`EPROM_CONNECTION_DEFS(eprom_12c, eprom_12c),
			`EPROM_CONNECTION_DEFS(eprom_12d, eprom_12d)
			);
			
	always @(negedge s86_6M) begin
    if (_rst_n) begin
      ls174_6v_q6  <= 1;
      ls174_9v_q5  <= 0;
    end
  end
		
	//assign SPR = cus43_6n_pro;
	//assign SCRWIN = ls85_7v_altb;	
	
	//assign DOT = (vid_active !== 1'b0) ? { dot_msb_acc[15:13], dot_lsb_acc[15:11] } : 8'b0;
	//assign DOT = prom_4v_data; //| prom_5v_data; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	
	// == assign external connections
	
  	assign s86_J2_4_SYNC = s86_bCOMPSYNC;
	assign s86_J2_1_RED = s86_RED;
	assign s86_J2_2_GREEN = s86_GREEN;
	assign s86_J2_3_BLUE = s86_BLUE;
	
	// diagnostics I/O (driven as documented)
	assign s86_J5_io[16] = s86_6M;
	assign s86_J5_io[7] = s86_48M_i;	
	assign s86_J5_io[12] = s86_bHRESET;
	assign s86_J5_io[11] = s86_bVRESET;

	// simulation outputs
	assign vid_clk = s86_6M;
	assign vid_data = { s86_BLUE, s86_GREEN, s86_RED };
	assign vid_red = s86_RED;
	assign vid_green = s86_GREEN;
	assign vid_blue = s86_BLUE;
	assign vid_hsync_n = s86_bHSYNC;
	assign vid_vsync_n = s86_bVSYNC;
	assign vid_hblank_n = s86_bHBLANK;
	assign vid_vblank_n = s86_bVBLANK;
	
endmodule
