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
    input wire clk48m,
    input wire rst
    //inout [15:0] addr,
    //inout [7:0] data
    );

	// == supply rails ==
	supply0 GND;
	
	
	// == global signals ==
	wire RESET;
	wire LATCH0;
	wire LATCH1;
	wire [12:0] A;
	wire [7:0] D;
	
	assign nRESET = ~RESET;
	
	// CUS27 signals
	wire cus27_9p_6m;
	reg cus27_9p_6m_latched;
	wire cus27_9p_1h;
	wire cus27_9p_s1h;
	wire cus27_9p_2h;
	wire cus27_9p_s2h;
	
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
	wire cus47_10c_bufen;
	wire cus47_10c_bank;
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
	
	wire [4:1] ls02_12a_y;
	nor ls02_12a[4:1](ls02_12a_y, 
			{ GND, GND, GND, cus27_9p_6m }, 
			{ GND, GND, GND, cus27_9p_s1h }
		);
	
	wire [4:1] ls08_8e_y;
	and ls08_8e[4:1](ls08_8e_y[4:1], 
			{ GND, GND, GND, ~cus41_8a_mcs4 }, 
			{ GND, GND, GND, ~cus41_8a_mrom }
		);
	
	wire [4:1] ls00_8d_y;
	nand ls00_8d[4:1](ls00_8d_y, 
		{ GND, ls08_8e_y[1], ~cpu2_11a_we, cpu2_11a_a[12] === 1'b1 }, 
		{ GND, cus27_9p_2h, cus27_9p_2h, cpu2_11a_a[15] === 1'b1 });
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;
	
	// CUS27 - CLOCK DIVIDER
	CUS27 CUS_27_CLKDIV_9P(
		.CLK_48M_I(clk48m), 
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
		.CLK_6M(cus27_9p_6m_latched), 
		.CLK_2H(cus27_9p_s2h), 
		.VBLK(GND),
		.RES(cus47_10c_res), 
		.WE(cpu1_9a_we), 
		.A(cpu1_9a_a[15:10]), 
		.MQ(cus47_10c_mq), 
		.ME(cus47_10c_me), 
		.SUBE(cus47_10c_sube), 
		.SUBQ(cus41_8a_q),			// temp alt for CUS41
		.IRQ(cus47_10c_irq), 
		.BUFEN(cus47_10c_bufen),
		.BANK(cus47_10c_bank), 
		.SPGM(cus47_10C_spmg), 
		.MPGM(cus47_10C_mpmg)
		);
	
	// EEPROM 27256 - CPU 1 PROGRAM ROM 9C
	PROM_FILE #(15, 8, "roms/rt3_1b.9c") EEPROM_9C(
		.OE(~cus27_9p_2h),
		.CE(cus47_10C_mpmg), 
		.A(cpu1_9a_a[14:0]), 
		.Q(cpu1_9a_d)
		);
		
	// EEPROM 27256 - CPU 1 PROGRAM ROM 9D
	/*PROM_FILE #(14, 8, "roms\rt3_1b.9c") EEPROM_9D(
		.OE(cus27_9p_2h),
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
			.I0a(0),
			.I1a(0),
			.I2a(0),
			.I3a(ls02_12a_y[1]),
			.I0b(0),
			.I1b(0),
			.I2b(0),
			.I3b(~ls02_12a_y[1]),
			.Za(ls153_8f_1y),
			.Zb(ls153_8f_2y)
		);
			
	// Sub CPU system
	
	// CUS41 - CPU 2 ADDRESS DECODER
	CUS41 CUS41_8A(
		.MA(cpu2_11a_a[15:11]), 
		.CLK_0(~cus27_9p_s2h), 
		.CLK_6M(cus27_9p_6m_latched), 
		.VBLK(GND),
		.MWE(cpu2_11a_we), 
		.MRESET(cus41_8a_mreset), 
		.SINT(cus41_8a_sndirq), 
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
		.OE(~ls00_8d_y[2]),
		.CE(cus41_8a_mrom),
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
		
	PROM_FILE #(15, 8, "roms/rt3_3.12d") EEPROM_12D(
		.OE(~ls00_8d_y[2]),
		.CE(cus41_8a_mcs4), 
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
	
	
	// == BUS MULTIPLEXER ==
	
	wire [4:1] ls257_11e_y;
	wire [4:1] ls257_11d_y;
	wire [4:1] ls257_11f_y;
	wire [4:1] ls157_8c_y;
	
	LS245 LS245_9E(
		.DIR(~cpu1_9a_we),
		.OE(cus47_10c_bufen),
		.A(ls245_9e_a),
		.B(cpu1_9a_d)
		);
	
	LS245 LS245_12E(
		.DIR(~cpu2_11a_we),
		.OE(ls00_8d_y[3]),
		.A(ls245_12e_a),
		.B(cpu2_11a_d)
		);
	
	LS257 LS257_11E(
		.G(cus27_9p_1h),
		.SELA(cus27_9p_s2h),
		.A(cpu1_9a_a[3:0]),
		.B(cpu2_11a_a[3:0]),
		.Y(ls257_11e_y)
		);
		
	LS257 LS257_11D(
		.G(cus27_9p_1h),
		.SELA(cus27_9p_s2h),
		.A(cpu1_9a_a[7:4]),
		.B(cpu2_11a_a[7:4]),
		.Y(ls257_11d_y)
		);
		
	LS257 LS257_11F(
		.G(cus27_9p_1h),
		.SELA(cus27_9p_s2h),
		.A(cpu1_9a_a[11:8]),
		.B(cpu2_11a_a[11:8]),
		.Y(ls257_11f_y)
		);
		
	LS157 LS157_8C(
		.G(cus27_9p_1h),
		.SELA(cus27_9p_2h),
		.A( {cus47_10c_latch0, cus47_10c_latch1, cpu1_9a_we, cpu1_9a_a[12]} ),
		.B( {cus41_8a_latch0, cus41_8a_latch1, cpu2_11a_we, cpu2_11a_a[12]} ),
		.Y(ls157_8c_y)
		);
		
	// == SCROLL0 ==
	
	CUS42 CUS42_7K(
		.CLK_6M(cus27_9p_6m), 
		.CLK_2H(cus27_9p_2h), 
		.LATCH(LATCH0),
		.CA( { GND, A } ),
		.CD(D)
		);
	
	// RAM
	
	// == SCROLL1 ==
	
	CUS42 CUS42_5K(
		.CLK_6M(cus27_9p_6m), 
		.CLK_2H(cus27_9p_2h), 
		.LATCH(LATCH1),
		.CA( { GND, A } ),
		.CD(D)
		);
		
	// RAM
	
	//-------------Code Starts Here-------
	
	assign A = { ls157_8c_y[1], ls257_11f_y, ls257_11d_y, ls257_11e_y };
	assign D = ls245_9e_a | ls245_12e_a;
	assign RESET = (rst == 1 || cus47_10c_res == 1 || cus41_8a_mreset == 1) ? 1'b1 : 1'b0;
	
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
