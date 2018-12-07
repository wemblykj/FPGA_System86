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

	// global signals
	wire RESET;
	wire LATCH0;
	wire LATCH1;
	
	assign nRESET = ~RESET;
	// Master CPU system 
	
	// CPU 1 signals
	wire [7:0] cpu1_9a_d;
	wire [15:0] cpu1_9a_a;
	wire cpu1_9a_we;
	wire cpu1_9a_bs;
	wire cpu1_9a_ba;
	wire cpu1_9a_avma;
	wire cpu1_9a_busy;
	wire cpu1_9a_lic;
	
	// CUS27 signals
	wire cus27_9p_6m;
	reg cus27_9p_6m_latched;
	wire cus27_9p_s1h;
	wire cus27_9p_2h;
	wire cus27_9p_s2h;
	
	wire cus27_9p_2h_l;
	wire cus27_9p_s2h_l;
	assign cus27_9p_2h_l = ~cus27_9p_2h;
	assign cus27_9p_s2h_l = ~cus27_9p_s2h;
	
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

	// CUS41 signals
	wire cus41_8a_q;
	
	wire ls139_7d_o3b;	
	
	supply0 GND;
	
	// CUS27 - CLOCK DIVIDER
	CUS27 CUS_27_CLKDIV_9P(
		.CLK_48M_I(clk48m), 
		.CLK_6M_I(cus27_9p_6m_latched), 
		.CLK_6M_O(cus27_9p_6m),
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
		.OE(cus27_9p_2h),
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
		.O3b(ls139_7d_o3b)
		);
		
	wire ls02_12a_o_l;
	wire ls02_12a_o;
	nor (ls02_12a_o_l, cus27_9p_6m, cus27_9p_s1h);
	assign ls02_12a_o = ~ ls02_12a_o_l;
	
	wire ls00_8d_o;
	nand (ls00_8d_o, cus27_9p_2h, ~cpu1_9a_we);
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;
	LS153 LS153_8F(
			.S0(cpu1_9a_a[0]),
			.S1(cpu1_9a_a[1]),
			.Ea(LATCH0),
			.Eb(LATCH1),
			.I0a(0),
			.I1a(0),
			.I2a(0),
			.I3a(ls02_12a_o),
			.I0b(0),
			.I1b(0),
			.I2b(0),
			.I3b(ls02_12a_o),
			.Za(ls153_8f_1y),
			.Zb(ls153_8f_2y)
		);
			
	// Sub CPU system
	
	wire [7:0] cpu2_11a_d;
	wire [15:0] cpu2_11a_a;
	wire cpu2_11a_we;
	wire cpu2_11a_bs;
	wire cpu2_11a_ba;
	wire cpu2_11a_avma;
	wire cpu2_11a_busy;
	wire cpu2_11a_lic;
	
	wire cus41_8a_mreset;
	wire cus41_8a_sndirq;
	wire cus41_8a_subscr0;
	wire cus41_8a_subscr1;
	wire cus41_8a_subobj;
	wire cus41_8a_mcs4;
	wire cus41_8a_mrom;
	
	// CUS41 - CPU 2 ADDRESS DECODER
	CUS41 CUS41_8A(
		.MA(cpu2_11a_a[15:11]), 
		.CLK_0(~cus27_9p_s2h), 
		.CLK_6M(cus27_9p_6m_latched), 
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
		.IRQ(cpu2_11a_irq), 
		.FIRQ(GND), 
		.NMI(GND), 
		.AVMA(cpu2_11a_avma), 
		.BUSY(cpu2_11a_busy), 
		.LIC(cpu2_11a_lic), 
		.HALT(GND), 
		.RESET(RESET));	
	
	PROM_FILE #(15, 8, "roms/rt3_2b.12c") EEPROM_12C(
		.OE(ls02_12a_o),
		.CE(cus41_8a_mrom),
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
		
	PROM_FILE #(15, 8, "roms/rt3_3.12d") EEPROM_12D(
		.OE(ls02_12a_o),
		.CE(cus41_8a_mcs4), 
		.A(cpu2_11a_a[14:0]), 
		.Q(cpu2_11a_d));
	

	//------------Internal Variables--------
	//reg [7:0] counter;
	 
	//-------------Code Starts Here-------
	
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
