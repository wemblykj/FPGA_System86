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

//`include "../../../../ttl_mem/mem.vh"
`define PINS_27256	1:28
`include "../../../../roms/rthunder.vh"

module system86
	(
		input wire CLK_48M,
		input wire RST,
				
		// == Native 4 bit RGB output and composite sync signals ==
		output wire [3:0] RED,
		output wire [3:0] GREEN,
		output wire [3:0] BLUE,
		output wire SYNC,
		
		// Simulation only video
		output wire nHSYNC,
		output wire nVSYNC,
		output wire nHBLANK,
		output wire nVBLANK,
 
		// == External boards connectors
		inout wire [1:20] conn_j5,			// 20 pin
		inout wire [1:40] conn_j34p,		// 40 pin
		
		// == Pluggable proms
		inout wire [1:20] prom_3r			// 7124 - 20 pin DIP/DIL
		inout wire [1:16] prom_3s, 		// 7116 - 16 pin DIP/DIL		
		inout wire  prom_4v,					// 7138
		inout wire  prom_5v,					// 7138
		inout wire  prom_6u,					// 7112
		
		// PROG
		inout wire [`PINS_27256] eprom_9c,		// 27256
		inout wire [1:28] eprom_9d,		// 27256
		inout wire [1:28] eprom_12c,		// 27256
		inout wire [1:28] eprom_12d,		// 27256
		
		// GFX
		inout wire [1:28] eprom_7r,		// 27512
		inout wire [1:28] eprom_7s,		// 27256
		inout wire [1:28] eprom_4r,		// 27256
		inout wire [1:28] eprom_4s,		// 27128
		
		// SRAM
		inout wire [1:28] sram_4n,			// CY6264
		inout wire [1:28] sram_7n,			// CY6264
		inout wire [1:28] sram_10m,		// CY6264


	);
	
	// == global signals ==
	wire RESET;
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
	
	wire BLANKING;
	wire nHRESET;
	
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
			.VRESET(VRESET),
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
			.CLK_6M(CLK_6M), 
			.CLR(GND), //.CLR(ls174_6v_q6), 
			.D(DOT), 
			.BANK(GND), //.BANK(ls174_9v_q5), 
			// output
			.RED(RED), 
			.GREEN(GREEN), 
			.BLUE(BLUE)
						
			// == hardware abstraction - memory buses ==
		);
		
	
	//assign SPR = cus43_6n_pro;
	//assign SCRWIN = ls85_7v_altb;	
	
	assign DOT = prom_4v_d ;//| prom_5v_d; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	// diagnostics I/O (driven as documented)
	assign conn_j5[16] = CLK_6M;
	assign conn_j5[7] = CLK_48M;	
	assign conn_j5[12] = ~HRESET;
	assign conn_j5[11] = ~VRESET;

endmodule
