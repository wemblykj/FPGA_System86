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
module system86(
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
	//wire HSYNC;
	//wire VSYNC;

	// == [not so] global signals ==
	wire [7:0] MD;		// master CPU data bus to backcolor latch
	wire [2:0] SPR;	// CUS43 tile generator to sprite enable logic
	wire [7:0] DOT;	// multiplexed tilemap color index and sprite color index
	
	// diagnostic inputs
	wire con_j5_5;		// pull1	(negated from J5 input)
	wire con_j5_8;		// pull1
	wire con_j5_9;		// pull1
	wire con_j5_10;	// pull1
	wire con_j5_13;	// pull0
	wire con_j5_14;	// pull0
	wire con_j5_15;	// pull0
	
	// == Master CPU system ==
	
	// CPU 1 signals
	wire [7:0] cpu1_9a_d;
	wire [15:0] cpu1_9a_a;
	wire cpu1_9a_we;
	wire cpu1_9a_bs;
	wire cpu1_9a_ba;
	wire cpu1_9a_avma;
	wire cpu1_9a_busy;
	wire cpu1_9a_lic;
	
	// CUS47 signals
	wire cus47_10c_res;
	wire cus47_10c_mq;
	wire cus47_10c_me;
	wire cus47_10c_sube;
	wire cus47_10c_irq;
	wire cus47_10c_scr0;
	wire cus47_10c_scr1;
	wire cus47_10c_obj;
	wire cus47_10c_bank;
	wire cus47_10c_bufen;
	wire cus47_10c_mpmg;
	wire cus47_10c_spmg;

	// CPU 2
	wire [7:0] cpu2_11a_d;
	wire [15:0] cpu2_11a_a;
	wire cpu2_11a_we;
	wire cpu2_11a_bs;
	wire cpu2_11a_ba;
	wire cpu2_11a_avma;
	wire cpu2_11a_busy;
	wire cpu2_11a_lic;
	
	// CUS41 signals
	wire cus41_8a_q;
	wire cus41_8a_mreset;
	wire cus41_8a_sndirq;
	wire cus41_8a_subscr0;
	wire cus41_8a_subscr1;
	wire cus41_8a_subobj;
	wire cus41_8a_mcs4;
	wire cus41_8a_mrom;
	
	// == misc logic ==
	
	wire ls139_7d_3b;	
	
	wire [7:0] ls245_9e_a;
	wire [7:0] ls245_12e_a;
	
	wire ls02_12a_1y;
	LS02 ls02_12a(
		.A1(CLK_6M), 
		.B1(CLK_S1H),
		.Y1(ls02_12a_1y)
		);
	
	wire ls08_8e_1y;
	wire ls08_8e_2y;
	wire ls08_8e_3y;
	wire ls08_8e_4y;
	LS08 ls08_8e(
		.A1(~cus41_8a_mcs4),
		.B1(cus41_8a_mrom),
		.A2(~cus47_10c_obj),
		.B2(~cus41_8a_subobj),
		.A3(~cus47_10c_scr1),
		.B3(~cus41_8a_subscr1),
		.A4(~cus47_10c_scr0),
		.B4(~cus41_8a_subscr0),
		.Y1(ls08_8e_1y), 
		.Y2(ls08_8e_2y), 
		.Y3(ls08_8e_3y), 
		.Y4(ls08_8e_4y)
		);
	
	wire ls00_8d_1y;
	wire ls00_8d_2y;
	wire ls00_8d_3y;
	LS00 ls00_8d(
		.A1(cpu2_11a_a[12]),
		.B1(cpu2_11a_a[15]),
		.A2(~cpu2_11a_we),
		.B2(CLK_2H),
		.A3(ls08_8e_1y),
		.B3(CLK_2H),
		.Y1(ls00_8d_1y),
		.Y2(ls00_8d_2y),
		.Y3(ls00_8d_3y)
		);
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;
	
	// can this (8U) be moved into timing if not used elsewhere
	LS74 ls74_8u(
		.PRE2(GND),
		.CLK2(CLK_4H),
		.CLR2(VBLANK),
		.D2(HBLANK),
		.Q2(BLANKING)
		);
		
	// Timing subsystem
	TIMING TIMING(
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
	
	// CPU 1
	MC68A09E CPU1_9A(
		.D(cpu1_9a_d), 
		.A(cpu1_9a_a), 
		.WE(cpu1_9a_we), 
		.E(cus47_10c_me), 
		.Q(cus47_10c_mq), 
		.BS(cpu1_9a_bs), 
		.BA(cpu1_9a_ba), 
		.IRQ(cus47_10c_irq), 
		.FIRQ(GND), 
		.NMI(GND), 
		.AVMA(cpu1_9a_avma), 
		.BUSY(cpu1_9a_busy), 
		.LIC(cpu1_9a_lic), 
		.HALT(GND), 
		.RESET(RESET));	
		
	// CUS47 - CPU 1 ADDRESS DECODER
	CUS47 CUS47_10C(
		.CLK_6M(CLK_6M), 
		.CLK_2H(CLK_S2H), 
		.VBLK(VBLANK),
		.RES(cus47_10c_res), 
		.WE(cpu1_9a_we), 
		.A(cpu1_9a_a[15:10]), 
		.MQ(cus47_10c_mq), 
		.ME(cus47_10c_me), 
		.IRQ(cus47_10c_irq), 
		.SUBE(cus47_10c_sube), 
		.SUBQ(cus41_8a_q),			// temp alt for CUS41
		.LTH2(cus47_10c_latch2), 
		.LTH1(cus47_10c_latch1), 
		.LTH0(cus47_10c_latch0), 
		.SCR0(cus47_10c_scr0), 
		.SCR1(cus47_10c_scr1), 
		.OBJ(cus47_10c_obj), 
		.BANK(cus47_10c_bank), 
		.BUFEN(cus47_10c_bufen),
		.SPGM(cus47_10C_spmg), 
		.MPGM(cus47_10C_mpmg)
		);
	
	// EPROM 27256 - CPU 1 PROGRAM ROM 9C
	EPROM_27256 #("roms/rt3_1b.9c") EPROM_9C(
		.E(cus47_10C_mpmg), 
		.G(~CLK_2H),	// negate for active low
		.A(cpu1_9a_a[14:0]), 
		.Q(cpu1_9a_d)
		);
		
	// EPROM 27256 - CPU 1 PROGRAM ROM 9D
	/*EPROM_27256 #(14, 8, "roms\rt3_1b.9c") EPROM_9D(
		.OE(CLK_2H),
		.CE(cus47_10C_spmg), 
		.A(cpu1_9a_a[14:0]), 
		.Q(cpu1_9a_d)
		);*/
	
	LS139 LS139_7D(
		.Eb(cpu1_9a_a[15]),
		.A0b(cpu1_9a_a[13]),
		.A1b(cpu1_9a_a[14]),
		.O3b(ls139_7d_3b)
		);
	
	LS153 LS153_8F(
			.S0(cpu1_9a_a[0]),
			.S1(cpu1_9a_a[1]),
			.Ea(LATCH0),
			.Eb(LATCH1),
			.I0a(GND),
			.I1a(GND),
			.I2a(GND),
			.I3a(ls02_12a_1y),
			.I0b(GND),
			.I1b(GND),
			.I2b(GND),
			.I3b(~ls02_12a_1y),
			.Za(ls153_8f_1y),
			.Zb(ls153_8f_2y)
		);
		
	// Sub CPU system
	
	// CUS41 - CPU 2 ADDRESS DECODER
	CUS41 CUS41_8A(
		.MA(cpu2_11a_a[15:11]), 
		.CLK_0(~CLK_S2H), 	// negate for active low
		.CLK_6M(CLK_6M), 
		.VBLK(VBLANK),
		.MWE(cpu2_11a_we), 
		.MRESET(cus41_8a_mreset), 
		.SINT(cus41_8a_sndirq), 
		.LTH0(cus41_8a_latch0), 
		.LTH1(cus41_8a_latch1), 
		.MCS0(cus41_8a_subscr0), 
		.MCS1(cus41_8a_subscr1), 
		.MCS2(cus41_8a_subobj), 
		.MCS4(cus41_8a_mcs4), 
		.MROM(cus41_8a_mrom)
		);
		
	MC68A09E CPU2_11A(
		.D(cpu2_11a_d), 
		.A(cpu2_11a_a), 
		.WE(cpu2_11a_we), 
		.E(cus47_10c_sube), 
		.Q(cus41_8a_q), 
		.BS(cpu2_11a_bs), 
		.BA(cpu2_11a_ba), 
		.IRQ(cus41_8a_sndirq), 
		.FIRQ(GND), 
		.NMI(GND), 
		.AVMA(cpu2_11a_avma), 
		.BUSY(cpu2_11a_busy), 
		.LIC(cpu2_11a_lic), 
		.HALT(GND), 
		.RESET(RESET));	
	
	EPROM_27256 #("roms/rt3_2b.12c") EPROM_12C(
		.E(cus41_8a_mrom),
		.G(~ls00_8d_2y),
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
		
	EPROM_27256 #("roms/rt3_3.12d") EPROM_12D(
		.E(cus41_8a_mcs4), 
		.G(~ls00_8d_2y),
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
	
	// == BUS MULTIPLEXER ==
	
	// to simplify HDL these are in reverse order of schematics [3:0] -> [4Y:1Y]
	wire [3:0] ls257_11e_y;
	wire [3:0] ls257_11d_y;
	wire [3:0] ls257_11f_y;
	wire [3:0] ls157_8c_y;
	
	LS245 LS245_9E(
		.DIR(~cpu1_9a_we),
		.OE(cus47_10c_bufen),
		.A(D),//.A(ls245_9e_a),
		.B(cpu1_9a_d)
		);
	
	LS245 LS245_12E(
		.DIR(~cpu2_11a_we),
		.OE(~ls00_8d_3y),
		.A(D),//.A(ls245_12e_a),
		.B(cpu2_11a_d)
		);
	
	LS257 LS257_11E(
		.G(~CLK_1H),
		.SELA(~CLK_S2H),
		.A(cpu1_9a_a[3:0]),
		.B(cpu2_11a_a[3:0]),
		.Y(ls257_11e_y)
		);
		
	LS257 LS257_11D(
		.G(~CLK_1H),
		.SELA(~CLK_S2H),
		.A(cpu1_9a_a[7:4]),
		.B(cpu2_11a_a[7:4]),
		.Y(ls257_11d_y)
		);
		
	LS257 LS257_11F(
		.G(~CLK_1H),
		.SELA(~CLK_S2H),
		.A(cpu1_9a_a[11:8]),
		.B(cpu2_11a_a[11:8]),
		.Y(ls257_11f_y)
		);
		
	LS157 LS157_8C(
		.G(~CLK_1H),
		.SELA(~CLK_2H),
		.A( {cus47_10c_latch0, cus47_10c_latch1, cpu1_9a_we, cpu1_9a_a[12]} ),
		.B( {cus41_8a_latch0, cus41_8a_latch1, cpu2_11a_we, cpu2_11a_a[12]} ),
		.Y(ls157_8c_y)
		);
	
	SPRITEGEN SPRITEGEN(
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
		
	TILEGEN TILEGEN(
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
	
	CLUT #("roms/rt1-1.3r", "roms/rt1-2.3s") CLUT(
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
		
	// globals
	
	assign A = { 
		ls157_8c_y[0], 
		ls257_11f_y, 
		ls257_11d_y,
		ls257_11e_y
		 };
	
	assign RESET = (RST == 1 || cus47_10c_res == 1 || cus41_8a_mreset == 1) ? 1'b1 : 1'b0;	
	
	
	//assign D = CLK_1H ? ls245_9e_a : ls00_8d_3y ? ls245_12e_a : 8'bZ;
	
	assign MD = cpu1_9a_d;
	assign BACKCOLOR = cus47_10c_latch2;
	assign OBJECT = ~ls08_8e_2y;
	assign SCROLL0 = ~ls08_8e_4y;
	assign SCROLL1 = ~ls08_8e_3y;
	assign LATCH0 = ls157_8c_y[3];
	assign LATCH1 = ls157_8c_y[2];
	assign BANK = cus47_10c_bank;
	assign WE = ls157_8c_y[1];
	
	//assign SPR = cus43_6n_pro;
	//assign SCRWIN = ls85_7v_altb;	
	
	//assign DOT = prom_4v_d ;//| prom_5v_d; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	// diagnostics I/O (driven as documented)
	assign J5[16] = CLK_6M;
	assign J5[7] = CLK_48M;	
	assign J5[12] = ~HRESET;
	assign J5[11] = ~VRESET;
	
	initial begin
	end
	
	//always @(posedge CLK_48M) begin
	//	cpu_data_i = cpu_oe_o ? 8'b0 : 8'bZ;
	//end

endmodule
