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
		input wire rst_n,				// master reset
		
		// == Simulation outputs
		output wire vid_clk,
		output wire vid_hsync_n,
		output wire vid_vsync_n,
		output wire vid_hblank_n,
		output wire vid_vblank_n,

		// System 86 hardware timing
		input wire CLK_48M,				// System 86 master clock @ 49.125 MHz

		// == Native 4 bit RGB output and composite sync signals ==
		output wire [3:0] conn_j2_red,
		output wire [3:0] conn_j2_green,
		output wire [3:0] conn_j2_blue,
		output wire conn_j2_sync,
		
		// == External boards connectors
		inout wire [1:20] conn_j5,			// 20 pin
		inout wire [1:40] conn_j34p,		// 40 pin
		
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
	wire CLK_48M;
	wire CLK_6M;
	wire CLK_1H;
	wire CLK_S1H;
	wire CLK_2H;
	wire CLK_S2H;
	wire [12:0] A;
	wire [7:0] D;
	wire nSCROLL0;
	wire nSCROLL1;
	wire nOBJECT;
	wire nLATCH0;
	wire nLATCH1;
	wire nBACKCOLOR;
	wire RnW;
	wire BANK = 1'b0;
	wire FLIP = 1'b0;
	
	wire nHSYNC;
	wire nVSYNC;
	wire nHBLANK;
	wire nVBLANK;
 
	wire BLANKING;
	wire nHRESET;
	wire nVRESET;
	
	wire SYNC;
	wire [3:0] RED;
	wire [3:0] GREEN;
	wire [3:0] BLUE;
	
	// == [not so] global signals ==
	wire [7:0] MD;					// master CPU data bus to backcolor latch
	wire [2:0] SPR = 3'b0;			// CUS43 tile generator to sprite enable logic
	wire [7:0] DOT;			// multiplexed tilemap color index and sprite color index
	
	// Main CPU
	wire mcpu_11a_e;
	wire mcpu_11a_q;
	wire [7:0] mcpu_11a_d;
	wire [15:0] mcpu_11a_a;
	wire mcpu_11a_we_n;
	wire mcpu_11a_bs;
	wire mcpu_11a_ba;
	wire mcpu_11a_avma;
	wire mcpu_11a_busy;
	wire mcpu_11a_lic;	
	wire mcpu_11a_irq_n;
	wire mcpu_11a_reset_n;
	
	// Sub CPU signals
	wire scpu_9a_e;
	wire scpu_9a_q;
	wire [7:0] scpu_9a_d;
	wire [15:0] scpu_9a_a;
	wire scpu_9a_we_n;
	wire scpu_9a_bs;
	wire scpu_9a_ba;
	wire scpu_9a_avma;
	wire scpu_9a_busy;
	wire scpu_9a_lic;
	wire scpu_9a_irq_n;
	wire scpu_9a_reset_n;
	 
	// == Timing subsystem ==
	timing_subsystem
		timing_subsystem(
			.rst_n(rst_n),
			
			.CLK_48M(CLK_48M),
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
	
	tilegen_subsystem
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
			.rst_n(rst_n),
			
			// input
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.nSCROLL0(nSCROLL0),
			.nSCROLL1(nSCROLL1),
			.nLATCH0(nLATCH0),
			.nLATCH1(nLATCH1),
			.nHSYNC(nHSYNC),
			.nVSYNC(nVSYNC),
			.FLIP(FLIP),
			.BANK(BANK),
			.SRCWIN(SRCWIN),
			.nBACKCOLOR(nBACKCOLOR),
			.A(A[12:0]),
			.RnW(RnW),
			.MD(MD),
			// inout
			.D(D),
			.J5(conn_j5),
			// output
			.SPR(SPR),
			.DOT(DOT),
						
			// == hardware abstraction - memory buses ==			
			`EPROM_CONNECTION_DEFS(eprom_4r, eprom_4r),
			`EPROM_CONNECTION_DEFS(eprom_4s, eprom_4s),
			`PROM_CONNECTION_DEFS(prom_4v, prom_4v),
			`PROM_CONNECTION_DEFS(prom_6u, prom_6u),
			`EPROM_CONNECTION_DEFS(eprom_7r, eprom_7r),
			`EPROM_CONNECTION_DEFS(eprom_7s, eprom_7s),
			`SRAM_CONNECTION_DEFS(sram_4n, sram_4n),
			`SRAM_CONNECTION_DEFS(sram_7n, sram_7n)
		);
	
	reg ls174_9v_q5 = 1'b0;	// videogen_bank
	reg ls174_6v_q6 = 1'b1;	// videogen_clear
	
	sprite_subsystem
		sprite_subsystem
		(
			.rst_n(rst_n),
			
			// input
			.CLK_6M(CLK_6M),
			.CLK_1H(CLK_1H),
			.nOBJECT(nOBJECT),
			.nHSYNC(nHSYNC),
			.nVRESET(nVRESET),
			.A(A[12:0]),
			.RnW(RnW),
			.D(D),
						
			// == hardware abstraction - memory buses ==			
			//`EPROM_CONNECTION_DEFS(eprom_4r, eprom_4r),
			//`EPROM_CONNECTION_DEFS(eprom_4s, eprom_4s),
			//`PROM_CONNECTION_DEFS(prom_4v, prom_4v),
			//`PROM_CONNECTION_DEFS(prom_6u, prom_6u),
			//`EPROM_CONNECTION_DEFS(eprom_7r, eprom_7r),
			//`EPROM_CONNECTION_DEFS(eprom_7s, eprom_7s),
			`SRAM_CONNECTION_DEFS(sram_10m, sram_10m),
			`SRAM_CONNECTION_DEFS(sram_11k, sram_11k)
		);
		
	videogen_subsystem
		videogen_subsystem(
			.rst_n(rst_n),
			// input
			.CLK_6MD(CLK_6MD), 
			.nCLR(ls174_6v_q6),
			.D(DOT), 
			.BANK(ls174_9v_q5), 
			// output
			.SYNC(SYNC),
			.RED(RED), 
			.GREEN(GREEN), 
			.BLUE(BLUE),
			
			// == hardware abstraction - memory buses ==
			`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
			`PROM_CONNECTION_DEFS(prom_3s, prom_3s)
		);	
		
	cpu_subsystem
		cpu_subsystem(
			.rst_n(rst_n),
			// inputs
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.CLK_S2H(CLK_S2H),
			.CLK_1H(CLK_1H),
			.CLK_S1H(CLK_S1H),
			.nVBLANK(nVBLANK),
			//.nRESET(nRESET),
			// inout
			.A(A),
			.D(D),
			// outputs
			.RnW(RnW),
			.nRESET(nRESET),
			.nSCROLL0(nSCROLL0),
			.nSCROLL1(nSCROLL1),
			.nOBJECT(nOBJECT),
			.nLATCH0(nLATCH0),
			.nLATCH1(nLATCH1),
			.nBACKCOLOR(nBACKCOLOR),
			.MD(MD),
			
			// == hardware abstraction - cpu ==
			
		
			// CPU 2 - sub CPU
			.mcpu_11a_a(mcpu_11a_a),
			.mcpu_11a_we_n(mcpu_11a_we_n),
			.mcpu_11a_bs(mcpu_11a_bs),
			.mcpu_11a_ba(mcpu_11a_ba),
			.mcpu_11a_avma(mcpu_11a_avma),
			.mcpu_11a_busy(mcpu_11a_busy),
			.mcpu_11a_lic(mcpu_11a_lic),
			.mcpu_11a_d(mcpu_11a_d),
			.mcpu_11a_e(mcpu_11a_e),
			.mcpu_11a_q(mcpu_11a_q),
			.mcpu_11a_irq_n(mcpu_11a_irq_n),
			.mcpu_11a_reset_n(mcpu_11a_reset_n),

			.scpu_9a_a(scpu_9a_a),
			.scpu_9a_we_n(scpu_9a_we_n),
			.scpu_9a_bs(scpu_9a_bs),
			.scpu_9a_ba(scpu_9a_ba),
			.scpu_9a_avma(scpu_9a_avma),
			.scpu_9a_busy(scpu_9a_busy),
			.scpu_9a_lic(scpu_9a_lic),
			.scpu_9a_d(scpu_9a_d),
			.scpu_9a_e(scpu_9a_e),
			.scpu_9a_q(scpu_9a_q),
			.scpu_9a_irq_n(scpu_9a_irq_n),
			.scpu_9a_reset_n(scpu_9a_reset_n),
		  
			// == hardware abstraction - memory buses ==
			`EPROM_CONNECTION_DEFS(eprom_9c, eprom_9c),
			`EPROM_CONNECTION_DEFS(eprom_9d, eprom_9d),
			`EPROM_CONNECTION_DEFS(eprom_12c, eprom_12c),
			`EPROM_CONNECTION_DEFS(eprom_12d, eprom_12d)
			);
	
	// Main CPU
	mc68a09e 
		#(
			.tDHW(0),
			.tAH(0)
		)
		mcpu_11a
        (
			.D(mcpu_11a_d), 
			.A(mcpu_11a_a), 
			.RnW(mcpu_11a_we_n), 
			.E(mcpu_11a_e), 
			.Q(mcpu_11a_q), 
			.BS(mcpu_11a_bs), 
			.BA(mcpu_11a_ba), 
			.nIRQ(mcpu_11a_int_n), 
			.nFIRQ(1'b1), 
			.nNMI(1'b1), 
			.AVMA(mcpu_11a_avma), 
			.BUSY(mcpu_11a_busy), 
			.LIC(mcpu_11a_lic), 
			.nHALT(1'b1), 
			.nRESET(mcpu_11a_reset_n)
		);	
		
	// Sub CPU
	mc68a09e 
		#(
			.tDHW(0),
			.tAH(0)
		)
		scpu_9a
        (
			.D(scpu_9a_d), 
			.A(scpu_9a_a), 
			.RnW(scpu_9a_we_n), 
			.E(scpu_9a_e), 
			.Q(scpu_9a_q), 
			.BS(scpu_9a_bs), 
			.BA(scpu_9a_ba), 
			.nIRQ(scpu_9a_irq_n), 
			.nFIRQ(1'b1), 
			.nNMI(1'b1), 
			.AVMA(scpu_9a_avma), 
			.BUSY(scpu_9a_busy), 
			.LIC(scpu_9a_lic), 
			.nHALT(1'b1), 
			.nRESET(scpu_9a_reset_n)
		);	
		
	
		
	/*wire vid_active;
	wire [9:0] vid_active_col;
	wire [9:0] vid_active_row;
	
	reg [9:0] temp_active_col = 0;
	reg [9:0] temp_active_row = 0;
	
	Blanking_To_Count
		#(
			.ACTIVE_COLS(288),
			.ACTIVE_ROWS(224)
		)
		Blanking_To_Count
		(
			.i_Clk(CLK_6M),
			.i_rst_n(rst_n),
			.i_nHSync(nHSYNC),
			.i_nVSync(nVSYNC),
			.i_HBlank(~nHBLANK),
			.i_VBlank(~nVBLANK),
			.o_Active(vid_active),
			.o_Col_Count(vid_active_col),
			.o_Row_Count(vid_active_row)
		);
		
	reg [15:0] dot_lsb_acc = 0;
	reg [15:0] dot_msb_acc = 0;

	always @(negedge CLK_6M) begin
		if (vid_active_row[8:0] === 9'b001110000)
			ls174_9v_q5 <= 1'b1;
		else if (vid_active_row[8:0] === 9'b000000000)
			ls174_9v_q5 <= 1'b0;
			
		if (vid_active_col === 0) begin
			dot_lsb_acc <= 16'b0;
			
			if (vid_active_row === 112 || vid_active_row === 0)
				dot_msb_acc <= 16'b0;
			else
				dot_msb_acc <= dot_msb_acc + 590;
		end else begin
			dot_lsb_acc <= dot_lsb_acc + 228;			
		end
	end
	*/
	
	//assign SPR = cus43_6n_pro;
	//assign SCRWIN = ls85_7v_altb;	
	
	//assign DOT = (vid_active !== 1'b0) ? { dot_msb_acc[15:13], dot_lsb_acc[15:11] } : 8'b0;
	//assign DOT = prom_4v_data; //| prom_5v_data; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	
	// == assign external connections
	
	assign CLK_48M = clk;
	
	assign conn_j2_red = RED;
	assign conn_j2_green = GREEN;
	assign conn_j2_blue = BLUE;
	assign conn_j2_sync_n = SYNC;
	
	// diagnostics I/O (driven as documented)
	assign conn_j5[16] = CLK_6M;
	assign conn_j5[7] = CLK_48M;	
	assign conn_j5[12] = nHRESET;
	assign conn_j5[11] = nVRESET;

	// simulation outputs
	assign vid_clk = CLK_6M;
	assign vid_data = { BLUE, GREEN, RED };
	assign vid_hsync_n = nHSYNC;
	assign vid_vsync_n = nVSYNC;
	assign vid_hblank_n = nHBLANK;
	assign vid_vblank_n = nVBLANK;
	
endmodule
