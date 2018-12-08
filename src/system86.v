`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:18:35 04/12/2018 
// Design Name: 
// Module Name:    C:/Development/Xilinx/system86/system86.v
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
    input wire clk,
    input wire rst,
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
	//wire HSYNC;
	//wire VSYNC;
	
	// == [not so] global signals ==
	wire [7:0] MD;		// master CPU data bus to backcolor latch
	wire [2:0] SPR;	// CUS43 tile generator to sprite enable logic
	wire [7:0] DOT;	// multiplexed tilemap color index and sprite color index
	
	// CUS43 inter-connect
	wire [2:0] PR;		// 'attr' in MAME - transparancy - default can be overridden from diagnosics P5?
	wire [7:0] CL;		//	not sure maybe color - certainly defaulted to background color
	wire [2:0] DT;		// not sure - defaults from J5 and pulled up high - maps to A0-A2 of tilemap clut.
	
	// diagnostic inputs
	wire con_j5_5;		// pull1	(negated from J5 input)
	wire con_j5_8;		// pull1
	wire con_j5_9;		// pull1
	wire con_j5_10;	// pull1
	wire con_j5_13;	// pull0
	wire con_j5_14;	// pull0
	wire con_j5_15;	// pull0
	
	// CUS27 signals
	wire cus27_9p_6m;
	reg cus27_9p_6m_latched;
	wire cus27_9p_1h;
	wire cus27_9p_s1h;
	wire cus27_9p_2h;
	wire cus27_9p_s2h;
	wire cus27_9p_hsync;
	wire cus27_9p_hreset;
	wire cus27_9p_vsync;
	wire cus27_9p_vblank;
	wire cus27_9p_vreset;
	
	wire cus27_9p_2h_l;
	wire cus27_9p_s2h_l;
	assign cus27_9p_2h_l = ~cus27_9p_2h;
	assign cus27_9p_s2h_l = ~cus27_9p_s2h;
	
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
		.A1(cus27_9p_6m), 
		.B1(cus27_9p_s1h),
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
		.B2(cus27_9p_2h),
		.A3(ls08_8e_1y),
		.B3(cus27_9p_2h),
		.Y1(ls00_8d_1y),
		.Y2(ls00_8d_2y),
		.Y3(ls00_8d_3y)
		);
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;
	
	// CUS27 - CLOCK DIVIDER
	CUS27 CUS_27_CLKDIV_9P(
		.CLK_48M_I(CLK_48M), 
		.CLK_6M_I(cus27_9p_6m_latched), 
		.CLK_6M_O(cus27_9p_6m),
		.CLK_1H_O(cus27_9p_1h),
		.CLK_S1H_O(cus27_9p_s1h),
		.CLK_2H_O(cus27_9p_2h),
		.CLK_S2H_O(cus27_9p_s2h)
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
		.VBLK(GND),
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
	
	// EEPROM 27256 - CPU 1 PROGRAM ROM 9C
	PROM_FILE #(15, 8, "roms/rt3_1b.9c") EEPROM_9C(
		.OE(~CLK_2H),	// negate for active low
		.CE(cus47_10C_mpmg), 
		.A(cpu1_9a_a[14:0]), 
		.Q(cpu1_9a_d)
		);
		
	// EEPROM 27256 - CPU 1 PROGRAM ROM 9D
	/*PROM_FILE #(14, 8, "roms\rt3_1b.9c") EEPROM_9D(
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
		.VBLK(GND),
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
	
	PROM_FILE #(15, 8, "roms/rt3_2b.12c") EEPROM_12C(
		.OE(~ls00_8d_2y),
		.CE(cus41_8a_mrom),
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
		
	PROM_FILE #(15, 8, "roms/rt3_3.12d") EEPROM_12D(
		.OE(~ls00_8d_2y),
		.CE(cus41_8a_mcs4), 
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
		.A(ls245_9e_a),
		.B(cpu1_9a_d)
		);
	
	LS245 LS245_12E(
		.DIR(~cpu2_11a_we),
		.OE(ls00_8d_3y),
		.A(ls245_12e_a),
		.B(cpu2_11a_d)
		);
	
	LS257 LS257_11E(
		.G(CLK_1H),
		.SELA(CLK_S2H),
		.A(cpu1_9a_a[3:0]),
		.B(cpu2_11a_a[3:0]),
		.Y(ls257_11e_y)
		);
		
	LS257 LS257_11D(
		.G(CLK_1H),
		.SELA(CLK_S2H),
		.A(cpu1_9a_a[7:4]),
		.B(cpu2_11a_a[7:4]),
		.Y(ls257_11d_y)
		);
		
	LS257 LS257_11F(
		.G(CLK_1H),
		.SELA(CLK_S2H),
		.A(cpu1_9a_a[11:8]),
		.B(cpu2_11a_a[11:8]),
		.Y(ls257_11f_y)
		);
		
	LS157 LS157_8C(
		.G(CLK_1H),
		.SELA(CLK_2H),
		.A( {cus47_10c_latch0, cus47_10c_latch1, cpu1_9a_we, cpu1_9a_a[12]} ),
		.B( {cus41_8a_latch0, cus41_8a_latch1, cpu2_11a_we, cpu2_11a_a[12]} ),
		.Y(ls157_8c_y)
		);
	
	// == OBJECT ==
	
	// 1H high == main CPU on bus
	// 1H low == sub CPU on bus
	
	// A12 != 0 then ram A11 = 1 (xxxx1xxxxxxxxxxx)
	// 1H  A12  | A11
	//  0    0  |   0		sub CPU address == 0x0xxx 	=> 0x0000 base
	//  0    1  |   1		sub CPU address == 0x1xxx 	=> 0x0800 base (sprite registers)
	//  1    0  |   1		main CPU address == 0x0xxx => 0x0800 base (sprite registers)
	//  1    1  |   1		main CPU address == 0x1xxx	=> 0x0800 base (sprite registers)
	wire ls32_6e_3y;
	// A0 != 0 then ram A12 = 1 (xxx1xxxxxxxxxxxx)
	// 1H   A0  | A12
	//  0    0  |   0		sub CPU even address 	=> 0x0000 base
	//  0    1  |   1		sub CPU odd address 		=> 0x1000 base
	//  1    0  |   1		main CPU even address 	=> 0x1000 base
	//  1    1  |   1		main CPU odd address 	=> 0x1000 base
	wire ls32_6e_4y;
	
	// 1H   A12  A0  | A12 A11
	//  0    0    0  |  0    0		sub CPU address == 0x0xxx 	=> 0x0000 base	()
	//  0    0    1  |  1    0		sub CPU even address 		=> 0x1000 base	()
	//  0    1    0  |  0    1		sub CPU odd address 			=> 0x0800 base	(sprite registers)
	//  0    1    1  |  1    1		sub CPU address == 0x1xxx 	=> 0x1800 base (sprite registers)
	//  1    0    0  |  1    1		main CPU address == 0x0xxx => 0x1800 base (sprite registers)
	//  1    0    1  |  1    1		main CPU even address 		=> 0x1800 base	(sprite registers)
	//  1    1    0  |  1    1		main CPU address == 0x1xxx	=> 0x1800 base (sprite registers)
	//  1    1    1  |  1    1		main CPU odd address 		=> 0x1800 base	(sprite registers)
	
	LS32 LS32_6E(
		.A3(CLK_2H),
		.B3(A[12]),
		.A4(CLK_2H),
		.B4(A[0]),
		.Y3(lls32_6e_3y),
		.Y4(lls32_6e_4y)
		);
	
	wire ls174_6v_q1;
	wire ls174_6v_q2;
	wire ls174_6v_q3;
	wire ls174_6v_q4;
	wire ls174_6v_q5;
	wire ls174_6v_q6;
	
	wire ls174_9v_q1;
	wire ls174_9v_q2;
	wire ls174_9v_q3;
	wire ls174_9v_q4;
	wire ls174_9v_q5;
	wire ls174_9v_q6;
	
	wire ls174_8v_q1;
	wire ls174_8v_q2;
	wire ls174_8v_q3;
	wire ls174_8v_q4;
	wire ls174_8v_q5;
	wire ls174_8v_q6;
	
	// sprite registers?
	// A != xxx11xxxxxxxxxx0
	// A12 A11  A0  Y1
	//   0   0   0   1
	//   0   0   1   1
	//   0   1   0   1
	//   0   1   1   1
	//   1   0   0   1
	//   1   0   1   1
	//   1   1   0   0
	//   1   1   1   1
	wire ls10_7e_1y;
	wire ls10_7e_2y;
	wire ls10_7e_3y;
	
	wire ls85_7v_agtb;
	
	wire [3:0] cus39_11n_oo;
	wire [7:0] prom_11u_d;	// prom or sram? 2018 (i think it is a sram!)
	
	LS10 LS10_7E(
		.A1(~A[0]),
		.B1(A[12]),
		.C1(A[11] | ls174_6v_q4),
		.A2(VCC),
		.B2(ls174_6v_q5),
		.C2(BLANKING),
		.A3(ls174_6v_q1),
		.B3(ls174_6v_q2),
		.C3(ls174_6v_q3),
		.Y1(ls10_7e_1y),
		.Y2(ls10_7e_2y),
		.Y3(ls10_7e_3y)
		);
	
	LS174 LS174_6V(
		.CLK(cus39_11n_latch),
		.CLR(VCC),
		.D( { ls10_7e_2y, BLANKING, cus39_11n_oo[0], cus39_11n_oo[1], cus39_11n_oo[2], cus39_11n_oo[3] } ),
		.Q( { ls174_6v_q6, ls174_6v_q5, ls174_6v_q4, ls174_6v_q3, ls174_6v_q2, ls174_6v_q1} )
		);
		
	LS174 LS174_9V(
		.CLK(cus39_11n_latch),
		.CLR(VCC),
		.D( { GND, ls85_7v_agtb, GND, GND, GND, GND} ),
		.Q( { ls174_9v_q6, ls174_9v_q5, ls174_9v_q4, ls174_9v_q3, ls174_9v_q2, ls174_9v_q1} )
		);
		
	LS174 LS174_8V(
		.CLK(cus39_11n_latch),
		.CLR(VCC),
		.D( { prom_11u_d[0], prom_11u_d[1], prom_11u_d[2], prom_11u_d[3], GND, GND} ),
		.Q( { ls174_8v_q6, ls174_8v_q5, ls174_8v_q4, ls174_8v_q3, ls174_8v_q2, ls174_8v_q1} )
		);
		
	wire cus35_9m_cs0;
	wire cus35_9m_cs1;
	wire cus35_9m_rwe;
	wire cus35_9m_roe;
	wire [7:0] cus35_9m_bi;
	wire [7:0] cus35_9m_bo;
	
	wire [7:0] prom_6u_d;
	
	CUS35 CUS35_9M(
		.A( { GND, A[11:1], ls10_7e_1y } ),
		.D(D[7:0]),
		.ROE(cus35_9m_roe),
		.RWE(cus35_9m_rwe),
		.BI(cus35_9m_bi),
		.BO(cus35_9m_bo)
		);
	
	// sprite ram
	CY6264 CY6264_10M(
		.CE(cus35_9m_cs1),
		.WE(cus35_9m_rwe),
		.OE(cus35_9m_roe),
		.A( { ls32_6e_4y, ls32_6e_3y, A[11:1] } ),
		.D(cus35_9m_bi)
		);

	LS85 LS85_7V(
		.A( { ls10_7e_3y, ls174_9v_q1, ls174_9v_q2, ls174_9v_q3 } ),
		.B( { VCC, SPR } ),
		.AgtBin(VCC),
		.AeqBin(GND),
		.AltBin(GND),
		.AgtBout(ls85_7v_agtb),
		.AltBout(ls85_7v_altb)
		);
		
	wire [7:0] prom_5v_d;
	PROM_FILE #(10, 8, "roms/rt1-4.5v") PROM_5V(
		.OE(VCC),
		.CE(BLANKING | ls85_7v_agtb), 
		.A( { ls174_9v_q4, ls174_8v_q1, ls174_8v_q3, ls174_8v_q4, ls174_8v_q5, ls174_8v_q6, ls174_6v_q1, ls174_6v_q2, ls174_6v_q3, ls174_6v_q4 } ), 
		.Q(prom_5v_d)
		);
		
	// == SCROLL ==
	
	wire [13:0] cus42_7k_ga;
	wire cus42_7k_rwe;
	wire cus42_7k_roe;
	wire [12:0] cus42_7k_ra;
	wire [7:0] cus42_7k_rd;
	
	wire [13:0] cus42_5k_ga;
	wire cus42_5k_rwe;
	wire cus42_5k_roe;
	wire [12:0] cus42_5k_ra;
	wire [7:0] cus42_5k_rd;
	
	
	
	// background colour latch
	wire [1:8] ls374_8h_q;
	
	LS374 LS374_8H(
		.OC(con_j5_5),
		.CLK(~BACKCOLOR),	// latches on negative edge
		.D(MD),
		.Q(ls374_8h_q)
		);
		
	// tile address decoder (used at runtime) 0x1400 - 0x0020
	PROM_FILE #(5, 8, "roms/rt1-5.6u") EEPROM_6U(
		.OE(VCC),
		.CE(VCC), 
		.A( { CLK_2H, cus42_7k_ga[13:12], cus42_5k_ga[13:12] } ), 
		.Q(prom_6u_d));
	
	CUS43 CUS43_8N(
		.CLK_6M(CLK_6M),
		.CLK_2H(CLK_2H),
		.PRI( { con_j5_15, con_j5_14, con_j5_13 } ),
		.CLI(ls374_8h_q),
		.DTI( { con_j5_8, con_j5_9, con_j5_10 } ),
		.CA(A[2:0]),
		.WE(WE),
		.LATCH(LATCH0),
		.FLIP(FLIP),
		.PRO(PR),
		.CLO(CL),
		.DTO(DT)
		);
		
	// == SCROLL0 =
	
	CUS42 CUS42_7K(
		.CLK_6M(CLK_6M), 
		.CLK_2H(CLK_2H), 
		.RCS(SCROLL0),
		//.GCS()?,
		.LATCH(LATCH0),
		.CA( { GND, A } ),
		.CD(D),
		.GA(cus42_7k_ga),
		.RWE(cus42_7k_rwe),
		.ROE(cus42_7k_roe),
		.RA(cus42_7k_ra),
		.RD(cus42_7k_rd)
		);
	
	// tile ram 0
	CY6264 CY6264_7N(
		.CE(VCC),
		.WE(cus42_7k_rwe),
		.OE(cus42_7k_roe),
		.A(cus42_7k_ra),
		.D(cus42_7k_rd)
		);
	
	
	// plane 1/2 0x00000 0x10000
	wire [7:0] prom_7r_d;
	PROM_FILE #(15, 8, "roms/rt1_7.7r") EEPROM_7R(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[3:1], cus42_7k_ga[11:0] } ), 
		.Q(prom_7r_d));
		
	// plane 3 0x10000 0x80000
	wire [7:0] prom_7s_d;
	PROM_FILE #(14, 8, "roms/rt1_8.7s") EEPROM_7S(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[3:1], cus42_7k_ga[11:1] } ), 
		.Q(prom_7s_d));	
		
	// == GFX 2 SCROLL1 ==
	
	CUS42 CUS42_5K(
		.CLK_6M(CLK_6M), 
		.CLK_2H(CLK_2H), 
		.RCS(SCROLL1),
		.LATCH(LATCH1),
		.CA( { GND, A } ),
		.CD(D),
		.GA(cus42_5k_ga),
		.RWE(cus42_5k_rwe),
		.ROE(cus42_5k_roe),
		.RA(cus42_5k_ra),
		.RD(cus42_5k_rd)
		);
		
	// tile ram 1
	CY6264 CY6264_4N(
		.CE(VCC),
		.WE(cus42_5k_rwe),
		.OE(cus42_5k_roe),
		.A(cus42_5k_ra),
		.D(cus42_5k_rd)
		);
	
	// plane 1/2 0x00000 (0x08000)
	wire [7:0] prom_4r_d;
	PROM_FILE #(15, 8, "roms/rt1_5.4r") EEPROM_4R(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[7:5], cus42_5k_ga[11:0] } ), 
		.Q(prom_4r_d));
		
	// plane 3 0x08000 (0x04000) 
	wire [7:0] prom_4s_d;
	PROM_FILE #(14, 8, "roms/rt1_6.4s") EEPROM_4S(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[7:5], cus42_5k_ga[11:1] } ), 
		.Q(prom_4s_d));
	
	wire [2:0] cus43_6n_pro;
	wire [7:0] cus43_6n_clo;
	wire [2:0] cus43_6n_dto;
	CUS43 CUS43_6N(
		.CLK_6M(CLK_6M),
		.CLK_2H(CLK_2H),
		.PRI(PR),
		.CLI(CL),
		.DTI(DT),
		.CA(A[2:0]),
		.WE(WE),
		.LATCH(LATCH1),
		.FLIP(FLIP),
		.PRO(cus43_6n_pro),
		.CLO(cus43_6n_clo),
		.DTO(cus43_6n_dto)
		);
	
	wire [7:0] prom_4v_d;
	PROM_FILE #(11, 8, "roms/rt1-3.4v") PROM_4V(
		.OE(VCC),
		.CE(SCRWIN), 
		.A( { cus43_6n_clo, cus43_6n_dto } ), 
		.Q(prom_4v_d));
	
	//-------------Code Starts Here-------
	
	CLUT #("roms/rt1-1.3r", "roms/rt1-2.3s") CLUT(
		.CLK_6M(CLK_6M), 
		.CLR(ls174_6v_q6), 
		.D(8'b0), 
		.BANK(ls174_9v_q5), 
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
	
	assign RESET = (rst == 1 || cus47_10c_res == 1 || cus41_8a_mreset == 1) ? 1'b1 : 1'b0;	
	assign CLK_48M = clk;
	assign CLK_6M = cus27_9p_6m;
	assign CLK_1H = cus27_9p_1h;
	assign CLK_S1H = cus27_9p_s1h;
	assign CLK_2H = cus27_9p_2h;
	assign CLK_S2H = cus27_9p_s2h;
	
	assign HSYNC = cus27_9p_hsync;
	assign HRESET = cus27_9p_hreset;	// schematics imply this is an input to cus27 but must logically be an output
	assign VSYNC = cus27_9p_vsync;
	assign VBLANK = cus27_9p_vblank;
	assign VRESET = cus27_9p_vreset;
	assign COMPSYNC = cus27_9p_hsync | cus27_9p_vsync;	// via LS08 and of negated signals
	
	assign D = ls245_9e_a | ls245_12e_a;
	
	assign MD = cpu1_9a_d;
	assign BACKCOLOR = cus47_10c_latch2;
	assign OBJECT = ls08_8e_2y;
	assign SCROLL0 = ls08_8e_4y;
	assign SCROLL1 = ls08_8e_3y;
	assign LATCH0 = ls157_8c_y[3];
	assign LATCH1 = ls157_8c_y[2];
	assign WE = ls157_8c_y[1];
	
	assign SPR = cus43_6n_pro;
	assign SCRWIN = ls85_7v_altb;	
	
	assign DOT = prom_4v_d | prom_5v_d; // need to check how this behaves when one is valid and the other is high imp. (Z)
	
	// diagnostics I/O (driven as documented)
	assign J5[1] = ls374_8h_q[2];						assign J5[20] = ls374_8h_q[1];
	assign J5[2] = ls374_8h_q[4];						assign J5[19] = ls374_8h_q[3];
	assign J5[3] = ls374_8h_q[6];						assign J5[18] = ls374_8h_q[5];
	assign J5[4] = ls374_8h_q[8];						assign J5[17] = ls374_8h_q[7];
	assign (supply0, pull1) con_j5_5 = ~J5[5];	assign J5[16] = CLK_6M;
	assign J5[6] = ~BACKCOLOR;							assign (pull0, supply1) con_j5_15 = J5[15];
	assign J5[7] = CLK_48M;								assign (pull0, supply1) con_j5_14 = J5[14];
	assign (supply0, pull1) con_j5_8 = J5[8];		assign (pull0, supply1) con_j5_13 = J5[13];
	assign (supply0, pull1) con_j5_9 = J5[9];		assign J5[12] = ~HRESET;
	assign (supply0, pull1) con_j5_10 = J5[10];	assign J5[11] = ~VRESET;
	
	always @(*) begin
		// Timing hack
		cus27_9p_6m_latched = cus27_9p_6m;
	end
	
	initial begin
	end
	
	//always @(posedge CLK_48M) begin
	//	cpu_data_i = cpu_oe_o ? 8'b0 : 8'bZ;
	//end

endmodule
