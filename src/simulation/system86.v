`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:18:35 04/12/2018 
// Design Name: 
// Module Name:    system86/simulation/system86.v
// Project Name:   Namco System86 top-level simulation module
// Target Devices: 
// Tool versions: 
// Description:    Top-level Namco System86 board simulation
//
// Dependencies:   
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`include "common/defines.vh"

`include "../roms/rthunder.vh"

module system86
	(
        input wire CLK_48M,
        input wire RST,
        
        // == Native 4 bit RGB output and sync signals ==
        output wire [3:0] R,
        output wire [3:0] G,
        output wire [3:0] B,
        output wire HSYNC,
        output wire VSYNC
 
        // == External boards connectors
        inout wire [1:20] J5,
        inout wire [1:40] J34P,

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
	wire HRESET;
	
	// == [not so] global signals ==
	wire [7:0] MD;		// master CPU data bus to backcolor latch
	wire [2:0] SPR;	    // CUS43 tile generator to sprite enable logic
	wire [7:0] DOT;	    // multiplexed tilemap color index and sprite color index
	
	// diagnostic inputs
	wire con_j5_5;		// pull1	(negated from J5 input)
	wire con_j5_8;		// pull1
	wire con_j5_9;		// pull1
	wire con_j5_10;	    // pull1
	wire con_j5_13;	    // pull0
	wire con_j5_14;	    // pull0
	wire con_j5_15;	    // pull0
	
    // == PROMS ==
    
    wire [7:0] prom_5v_data;
    wire [10:0] prom_5v_addr;
    wire prom_5v_ce;
    
	PROM_7138 #('ROM_5V, 10, 8) PROM_5V(
			.E(prom_5v_ce), 
			.A( prom_5v_addr ), 
			.Q(prom_5v_data)
		);
        
    // == EEPROMS ==
    
    wire [7:0] eeprom_9c_data;
    wire [14:0] eeprom_9c_addr;
    wire eeprom_9c_ce;
    
    wire [7:0] eeprom_9d_data;
    wire [14:0] eeprom_9d_addr;
    wire eeprom_9d_ce;
    
    wire [7:0] eeprom_12c_data;
    wire [14:0] eeprom_12c_addr;
    wire eeprom_12c_ce;
    
    wire [7:0] eeprom_12d_data;
    wire [14:0] eeprom_12d_addr;
    wire eeprom_12d_ce;
    
    // EPROM 27256 - CPU 1 PROGRAM ROM 9C
	EPROM_27256 #('ROM_9C) eprom_9c
        (
			.E(eeprom_9c_ce), 
			.G(GND),	// negate to compensate for active low
			.A(eeprom_9c_addr), 
			.Q(eeprom_9c_data)
		);
		
	// EPROM 27256 - CPU 1 PROGRAM ROM 9D
	EPROM_27256 #('ROM_9D) 
        eprom_9d
        (
            .E(eeprom_9d_ce),
            .G(GND), 
            .A(eeprom_9d_addr), 
            .Q(eeprom_9d_data)
		);
	
    // EPROM 27256 - CPU 2 PROGRAM ROM 12C
    EPROM_27256 #('ROM_12C) 
        eprom_12c(
			.E(eeprom_12c_ce),
			.G(GND),
			.A(eeprom_12c_addr), 
			.Q(eeprom_12c_data)
		);
		
    // EPROM 27256 - CPU 2 PROGRAM ROM 12D
	EPROM_27256 #('ROM_12D) 
        eprom_12d(
			.E(eeprom_12d_ce), 
			.G(GND),
			.A(eeprom_12d_addr), 
			.Q(eeprom_12d_data)
		);
        
   		
    // == SRAM ==
    
    wire [7:0] sram_10m_data;
    wire [13:0] sram_10m_addr;
    wire sram_10m_ce;
    wire sram_10m_we;
    wire sram_10m_oe;
    
    // sprite ram
	CY6264 CY6264_10M(
			.CE1(cus35_9m_cs1),
			.CE2(VCC),
			.WE(cus35_9m_rwe),
			.OE(cus35_9m_roe),
			.A( { ls32_6e_4y, ls32_6e_3y, A[11:1] } ),
			.D(sram_10m_data)
		);
    
	// == Timing subsystem ==
	timing_subsystem
        timing_subsystem(
			.CLK_48M(CLK_48M),
			.CLK_6M(CLK_6M),
			.CLK_6MD(CLK_6MD),	// secondary driver? in phase with 6M
			.VSYNC(VSYNC),
			.HSYNC(HSYNC),
			.HBLANK(HBLANK),
			.VBLANK(VBLANK),
			.VRESET(VRESET),
            .BLANKING(BLANKING),
			.COMPSYNC(COMPSYNC),
			.CLK_1H(CLK_1H),
			.CLK_S1H(CLK_S1H),	// secondary driver? in phase with 1H
			.CLK_2H(CLK_2H),
			.CLK_S2H(CLK_S2H),	// secondary driver? in phase with 2H
			.CLK_4H(CLK_4H)
		);
	
    // CPU sub-system
    cpu_subsystem
        cpu_subsystem 
        (
            // inputs
            .CLK_6M(CLK_6M),
            .CLK_2H(CLK_2H),
            .CLK_S2H(CLK_S2H),
            .CLK_1H(CLK_1H),
            .CLK_S1H(CLK_S1H),
            .VBLANK(VBLANK),
            .RST(RST),
            // inout
            .A(A),
            .D(D),
            .WE(WE),
            // outputs
            .RESET(RESET),
            .SCROLL0(SCROLL0),
            .SCROLL1(SCROLL1),
            .OBJECT(OBJECT),
            .LATCH0(LATCH0),
            .LATCH1(LATCH1),
            .BACKCOLOR(BACKCOLOR),
            .MD(MD)
            
            // == hardware abstraction - memory buses ==
            .eeprom_9c_data(eeprom_9c_data),
            .eeprom_9c_addr(eeprom_9c_addr),
            .eeprom_9c_ce(eeprom_9c_ce),
            .eeprom_9d_data(eeprom_9d_data),
            .eeprom_9d_addr(eeprom_9d_addr),
            .eeprom_9d_ce(eeprom_9d_ce),
            .eeprom_12c_data(eeprom_12c_data),
            .eeprom_12c_addr(eeprom_12c_addr),
            .eeprom_12c_ce(eeprom_12c_ce),
            .eeprom_12d_data(eeprom_12d_data),
            .eeprom_12d_addr(eeprom_12d_addr),
            .eeprom_12d_ce(eeprom_12d_ce)
           
        )
    
	spritegen_subsystem
		spritegen_subsystem
		(
			// input
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.OBJECT(OBJECT),
			.VRESET(VRESET),
			.SPR(SPR),
			.BLANKING(BLANKING),
			.A(A),
			.WE(WE),
			// inout
			.D(D),
			// output
			.DOT(DOT),
			.SRCWIN(SRCWIN),
            
            // == hardware abstraction - memory buses ==
            .prom_5v_data(prom_5v_data),
            .prom_5v_addr(prom_5v_addr),
            .prom_5v_ce(prom_5v_ce),
            .sram_10m_data(sram_10m_data),
            .sram_10m_addr(sram_10m_addr),
            .sram_10m_ce(sram_10m_ce),
            .sram_10m_we(sram_10m_we),
            .sram_10m_oe(sram_10m_oe)
		);
		
	tilegen_subsystem
		#(
			`ROM_4R, `ROM_4S, `ROM_4V, `ROM_6U,
			`ROM_7R, `ROM_7S
		)
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
			.DOT(DOT)
		);
	
	clut_subsystem #(`ROM_3R, `ROM_3S) 
		clut_subsystem(
			// input
			.CLK_6M(CLK_6M), 
			.CLR(GND), //.CLR(ls174_6v_q6), 
			.D(DOT), 
			.BANK(GND), //.BANK(ls174_9v_q5), 
			// output
			.R(R), 
			.G(G), 
			.B(B)
		);
		
	
	//assign SPR = cus43_6n_pro;
	//assign SCRWIN = ls85_7v_altb;	
	
	//assign DOT = prom_4v_d ;//| prom_5v_d; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	// diagnostics I/O (driven as documented)
	assign J5[16] = CLK_6M;
	assign J5[7] = CLK_48M;	
	assign J5[12] = ~HRESET;
	assign J5[11] = ~VRESET;

endmodule
