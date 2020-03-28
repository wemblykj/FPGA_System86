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
`define PINS_MB7112		1:16
`define DATA_MB7112(pins)		{ pins[9], pins[7:1] }
`define ADDR_MB7112(pins)		{ pins[14:10] }
`define nCS_MB7112(pins)		{ pins[15] }
`define GND_MB7112(pins)		{ pins[8] }
`define VCC_MB7112(pins)		{ pins[16] }

`define PINS_MB7116		1:16
`define DATA_MB7116(pins)		{ pins[9:12] }
`define ADDR_MB7116(pins)		{ pins[1:4], pins[7:5] }
`define nCS_MB7116(pins)		{ pins[13] }
`define CS_MB7116(pins)			{ ~pins[13] }
`define GND_MB7116(pins)		{ pins[8] }
`define VCC_MB7116(pins)		{ pins[16] }

`define PINS_MB7124		1:20
`define DATA_MB7124(pins)		{ pins[14:11], pins[5:1] }
`define ADDR_MB7124(pins)		{ pins[19:16], pins[5:1] }
`define nCS_MB7124(pins)		{ pins[15] }
`define CS_MB7124(pins)			{ ~pins[15] }
`define GND_MB7124(pins)		{ pins[10] }
`define VCC_MB7124(pins)		{ pins[20] }

`define PINS_MB7138		1:24
`define DATA_MB7138(pins)		{ pins[17:13], pins[11:9] }
`define ADDR_MB7138(pins)		{ pins[21:23], pins[1:8] }
`define CS_MB7138(pins)			{ pins[20] }
`define nCE1_MB7138(pins)		{ ~pins[20] }
`define CE2_MB7138(pins)		{ pins[19] }
`define CE3_MB7138(pins)		{ pins[18] }
`define GND_MB7138(pins)		{ pins[22] }
`define VCC_MB7138(pins)		{ pins[24] }

`define PINS_M27128	1:28
`define DATA_M27128(pins)		{ pins[19:15], pins[13:11] }
`define ADDR_M27128(pins)		{ pin[26], pin[2], pin[23], pin[21], pins[24:25], pins[3:10] }
`define nCS_M27128(pins)		{ pins[20] }
`define CS_M27128(pins)			{ ~pins[20] }
`define nOE_M27128(pins)		{ pins[22] }
`define OE_M27128(pins)			{ ~pins[22] }
`define GND_M27128(pins)		{ pins[14] }
`define VCC_M27128(pins)		{ pins[28] }


`define PINS_M27256	1:28
`define DATA_M27256(pins)		{ pins[19:15], pins[13:11] }
`define ADDR_M27256(pins)		{ pin[27], pin[26], pin[2], pin[23], pin[21], pins[24:25], pins[3:10] }
`define nCS_M27256(pins)		{ pins[20] }
`define CS_M27256(pins)			{ ~pins[20] }
`define nOE_M27256(pins)		{ pins[22] }
`define OE_M27256(pins)			{ ~pins[22] }
`define GND_M27256(pins)		{ pins[14] }
`define VCC_M27256(pins)		{ pins[28] }

`define PINS_M27512	1:28
`define DATA_M27512(pins)		{ pins[19:15], pins[13:11] }
`define ADDR_M27512(pins)		{ pin[1], pin[27], pin[26], pin[2], pin[23], pin[21], pins[24:25], pins[3:10] }
`define nCS_M27512(pins)		{ pins[20] }
`define CS_M27512(pins)			{ ~pins[20] }
`define nOE_M27512(pins)		{ pins[22] }
`define OE_M27512(pins)			{ ~pins[22] }
`define GND_M27512(pins)		{ pins[14] }
`define VCC_M27512(pins)		{ pins[28] }

`define PINS_CY6264	1:28

`define PINS(type)	`PINS_``type``
`define SOCKET(type, name)	inout wire [`PINS_``type``] name
`define DATA(type, pins) `DATA_``type``(pins)
`define ADDR(type, pins) `ADDR_``type``(pins)
`define nCS(type, pins) `nCS_``type``(pins)
`define CS(type, pins) `CS_``type``(pins)
`define nOE(type, pins) `nOE_``type``(pins)
`define OE(type, pins) `OE_``type``(pins)

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
		
		`SOCKET(MB7124, prom_3r),			// 7124 - 20 pin DIP/DIL
		`SOCKET(MB7124, prom_3s), 			// 7116 - 16 pin DIP/DIL		
		`SOCKET(MB7138, prom_4v),				// 7138
		`SOCKET(MB7138, prom_5v),				// 7138
		`SOCKET(MB7112, prom_6u),				// 7112
		
		// PROG
		`SOCKET(M27256, eprom_9c),
		`SOCKET(M27256, eprom_9d),
		`SOCKET(M27256, eprom_12c),
		`SOCKET(M27256, eprom_12d),
		
		// GFX
		`SOCKET(M27512, eprom_7r),
		`SOCKET(M27256, eprom_7s),
		`SOCKET(M27256, eprom_4r),
		`SOCKET(M27128, eprom_4s),
		
		// SRAM
		`SOCKET(CY6264, sram_4n),
		`SOCKET(CY6264, sram_7n),
		`SOCKET(CY6264, sram_10m)
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
	wire nVRESET;
	
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
	
	assign DOT = `DATA(MB7138, prom_4v); //| prom_5v_d; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	// diagnostics I/O (driven as documented)
	assign conn_j5[16] = CLK_6M;
	assign conn_j5[7] = CLK_48M;	
	assign conn_j5[12] = nHRESET;
	assign conn_j5[11] = nVRESET;

endmodule
