`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:18:35 04/12/2018 
// Design Name: 
// Module Name:    system86/system86.v
// Project Name:   Namco System86 simulation
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

`include "../roms/rthunder.vh"

module system86
	(
        input wire CLK_48M,
        input wire RST,
        inout wire [1:20] J5,
        inout wire [1:40] J34P,
        output wire [7:0] R,
        output wire [7:0] G,
        output wire [7:0] B,
        output wire HSYNC,
        output wire VSYNC
    );

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	// == connectors ==
	
	//wire [1:20] J5;
	//wire [1:40] J34P;
	
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
	
	// can this (8U) be moved into timing if not used elsewhere
	LS74 ls74_8u(
			.PRE2(GND),
			.CLK2(CLK_4H),
			.CLR2(VBLANK),
			.D2(HBLANK),
			.Q2(BLANKING)
		);
		
	// Timing subsystem
	TIMING timing(
			.CLK_48M(CLK_48M),
			.CLK_6M(CLK_6M),
			.CLK_6MD(CLK_6MD),	// secondary driver? in phase with 6M
			.VSYNC(VSYNC),
			.HSYNC(HSYNC),
			.HBLANK(HBLANK),
			.VBLANK(VBLANK),
			.VRESET(VRESET),
			.COMPSYNC(COMPSYNC),
			.CLK_1H(CLK_1H),
			.CLK_S1H(CLK_S1H),	// secondary driver? in phase with 1H
			.CLK_2H(CLK_2H),
			.CLK_S2H(CLK_S2H),	// secondary driver? in phase with 2H
			.CLK_4H(CLK_4H)
		);
	
    // CPU sub-system
    CPU #(`ROM_9C, `ROM_9D, `ROM_12C, `ROM_12D)
        cpu 
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
        )
    
	SPRITEGEN #(`ROM_5V)
		spritegen
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
			.SRCWIN(SRCWIN)
		);
		
	TILEGEN
		#(
			`ROM_4R, `ROM_4S, `ROM_4V, `ROM_6U,
			`ROM_7R, `ROM_7S
		)
		tilegen
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
	
	CLUT #(`ROM_3R, `ROM_3S) 
		clut(
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
