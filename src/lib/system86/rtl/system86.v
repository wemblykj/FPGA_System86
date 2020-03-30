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

//`include "common/defines.vh"

`include "../../ttl_mem/mb7112.vh"
`include "../../ttl_mem/mb7116.vh"
`include "../../ttl_mem/mb7124.vh"
`include "../../ttl_mem/mb7138.vh"

`include "../../ttl_mem/m27128.vh"
`include "../../ttl_mem/m27256.vh"
`include "../../ttl_mem/m27512.vh"

`include "../../ttl_mem/cy6264.vh"

`include "../../ttl_mem/ttl_mem.vh"

`include "../../../../roms/rthunder.vh"

module system86
	#(
		parameter VIDEO_COMPONENT_DEPTH = 8
	)
	(
		// == Simulation inputs
		input wire rst,				// master reset
		input wire clk,				// System 86 master clock @ 49.125 MHz
		
		// == Simulation outputs
		output wire vid_clk,
		output wire vid_hsync_n,
		output wire vid_vsync_n,
		output wire vid_hblank_n,
		output wire vid_vblank_n,
		output wire [VIDEO_COMPONENT_DEPTH-1:0] vid_red,
		output wire [VIDEO_COMPONENT_DEPTH-1:0] vid_green,
		output wire [VIDEO_COMPONENT_DEPTH-1:0] vid_blue,

		// == Native 4 bit RGB output and composite sync signals ==
		output wire [3:0] conn_j2_red,
		output wire [3:0] conn_j2_green,
		output wire [3:0] conn_j2_blue,
		output wire conn_j2_sync,
		
		// == External boards connectors
		inout wire [1:20] conn_j5,			// 20 pin
		inout wire [1:40] conn_j34p,		// 40 pin
		
		// == Pluggable proms
		
		`OUTPUT_DEFS(MB7124, prom_3r),			// 7124 - 20 pin DIP/DIL
		`OUTPUT_DEFS(MB7116, prom_3s), 			// 7116 - 16 pin DIP/DIL		
		`OUTPUT_DEFS(MB7138, prom_4v),				// 7138
		`OUTPUT_DEFS(MB7138, prom_5v),				// 7138
		`OUTPUT_DEFS(MB7112, prom_6u),				// 7112
		
		// PROG
		`OUTPUT_DEFS(M27256, eprom_9c),
		`OUTPUT_DEFS(M27256, eprom_9d),
		`OUTPUT_DEFS(M27256, eprom_12c),
		`OUTPUT_DEFS(M27256, eprom_12d),
		
		// GFX
		`OUTPUT_DEFS(M27512, eprom_7r),
		`OUTPUT_DEFS(M27256, eprom_7s),
		`OUTPUT_DEFS(M27256, eprom_4r),
		`OUTPUT_DEFS(M27128, eprom_4s),
		
		// SRAM
		`OUTPUT_DEFS(CY6264, sram_4n),
		`OUTPUT_DEFS(CY6264, sram_7n),
		`OUTPUT_DEFS(CY6264, sram_10m)
	);
	
	// == global signals ==
	wire RESET;
	wire CLK_48M;
	wire CLK_6M;
	wire CLK_1H;
	wire CLK_S1H;
	wire CLK_2H;
	wire CLK_S2H;
	wire [12:0] A;
	wire [7:0] D;
	wire SCROLL0;
	wire SCROLL1;
	wire OBJECT;
	wire LATCH0;
	wire LATCH1;
	wire BACKCOLOR;
	wire WE;
	
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
	wire [7:0] MD;		// master CPU data bus to backcolor latch
	wire [2:0] SPR;			// CUS43 tile generator to sprite enable logic
	wire [7:0] DOT;			// multiplexed tilemap color index and sprite color index
			
	// == Timing subsystem ==
	timing_subsystem
		timing_subsystem(
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
	
	/*tilegen_subsystem
		tilegen_subsystem
		(
			// input
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.SCROLL0(SCROLL0),
			.SCROLL1(SCROLL1),
			.LATCH0(LATCH0),
			.LATCH1(LATCH1),
			.HSYNC(HSYNC),
			.VSYNC(HSYNC),
			.FLIP(FLIP),
			.BANK(BANK),
			.SRCWIN(SRCWIN),
			.BACKCOLOR(BACKCOLOR),
			.A(A[12:0]),
			.WE(WE),
			.MD(MD),
			// inout
			.D(D),
			.J5(J5),
			// output
			.SPR(SPR),
			.DOT(DOT),
						
			// == hardware abstraction - memory buses ==
			
			.eeprom_4r_addr(eeprom_4r_addr),
			.eeprom_4r_data(eeprom_4r_data),
			.eeprom_4r_ce(eeprom_4r_ce),
			
			.eeprom_4s_addr(eeprom_4s_addr),
			.eeprom_4s_data(eeprom_4s_data),
			.eeprom_4s_ce(eeprom_4s_ce),
			
			.prom_4v_addr(prom_4v_addr),
			.prom_4v_data(prom_4v_data),
			.prom_4v_ce(prom_4v_ce),
			
			.prom_6u_addr(prom_6u_addr),
			.prom_6u_data(prom_6u_data),
			.prom_6u_ce(prom_6u_ce),
			
			.eeprom_7r_addr(eeprom_7r_addr),
			.eeprom_7r_data(eeprom_7r_data),
			.eeprom_7r_ce(eeprom_7r_ce),
			
			.eeprom_7s_addr(eeprom_7s_addr),
			.eeprom_7s_data(eeprom_7s_data),
			.eeprom_7s_ce(eeprom_7s_ce),
			
			.sram_10m_data(sram_4n_data),
			.sram_10m_addr(sram_4n_addr),
			.sram_10m_ce(sram_4n_ce),
			.sram_10m_we(sram_4n_we),
			.sram_10me(sram_4ne),
			
			.sram_10m_data(sram_7n_data),
			.sram_10m_addr(sram_7n_addr),
			.sram_10m_ce(sram_7n_ce),
			.sram_10m_we(sram_7n_we),
			.sram_10me(sram_7ne)
		);*/
	
	videogen_subsystem
		videogen_subsystem(
			// input
			.CLK_6MD(CLK_6MD), 
			.nCLR(1'b1), //.CLR(ls174_6v_q6), 
			.D(DOT), 
			.BANK(1'b0), //.BANK(ls174_9v_q5), 
			// output
			.SYNC(SYNC),
			.RED(RED), 
			.GREEN(GREEN), 
			.BLUE(BLUE),
			
			`CONNECTION_DEFS(prom_3r, prom_3r),
			`CONNECTION_DEFS(prom_3s, prom_3s)
						
			// == hardware abstraction - memory buses ==
		);	
	
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
			.i_Clk(CLK_6M),
			.i_Rst(rst),
			.i_HSync(nHSYNC),
			.i_VSync(nVSYNC),
			.i_HBlank(nHBLANK),
			.i_VBlank(nVBLANK),
			.o_Active(vid_active),
			.o_Col_Count(vid_active_col),
			.o_Row_Count(vid_active_row)
		);
		
	reg [15:0] dot_lsb_acc = 0;
	reg [15:0] dot_msb_acc = 0;
	reg BANK = 0;
	
	always @(negedge CLK_6M) begin
		if (vid_active_row[8:0] === 9'b001110000)
			BANK <= 1'b1;
		else if (vid_active_row[8:0] === 9'b000000000)
			BANK <= 1'b0;
			
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
	
	//assign SPR = cus43_6n_pro;
	//assign SCRWIN = ls85_7v_altb;	
	
	//assign DOT = dot_test; //`DATA(MB7138, prom_4v); //| prom_5v_d; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	
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
	assign vid_red[VIDEO_COMPONENT_DEPTH-1:VIDEO_COMPONENT_DEPTH-4] = RED;
	assign vid_green[VIDEO_COMPONENT_DEPTH-1:VIDEO_COMPONENT_DEPTH-4] = GREEN;
	assign vid_blue[VIDEO_COMPONENT_DEPTH-1:VIDEO_COMPONENT_DEPTH-4] = BLUE;
	assign vid_hsync_n = nHSYNC;
	assign vid_vsync_n = nVSYNC;
	assign vid_hblank_n = nHBLANK;
	assign vid_vblank_n = nVBLANK;
	
endmodule
