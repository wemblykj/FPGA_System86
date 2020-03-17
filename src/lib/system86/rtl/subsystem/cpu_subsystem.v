`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:18:35 04/12/2018 
// Design Name:    cpu_subsystem
// Module Name:    system86/subsystem/cpu_subsystem.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Dual CPU sub-system
//                 - CUS41 & CUS 47 address generators
//                 - CPU buses
//                 - CPU bus to master bus multiplexing
//                 - CPU program roms
//                 - Support TTL logic
// Dependencies:   
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

module cpu_subsystem
    #(
    )
	(
        input wire CLK_6M,
        input wire CLK_2H,
        input wire CLK_S2H,
        input wire CLK_1H,
        input wire CLK_S1H,
        input wire VBLANK,
        input wire RST,
        inout wire [12:0] A,
        inout wire [7:0] D,
        inout wire WE,
        output wire RESET,
        output wire SCROLL0,
        output wire SCROLL1,
        output wire OBJECT,
        output wire LATCH0,
        output wire LATCH1,
        output wire BACKCOLOR,
        output wire [7:0] MD,	// master CPU data bus to backcolor latch
        
        // == hardware abstraction - memory buses ==
        
        input wire [7:0] eeprom_9c_data,
        output wire [14:0] eeprom_9c_addr,
        output wire eeprom_9c_ce,
        
        input wire [7:0] eeprom_9d_data,
        output wire [14:0] eeprom_9d_addr,
        output wire eeprom_9d_ce,
        
        input wire [7:0] eeprom_12c_data,
        output wire [14:0] eeprom_12c_addr,
        output wire eeprom_12c_ce,
        
        input wire [7:0] eeprom_12d_data,
        output wire [14:0] eeprom_12d_addr,
        output wire eeprom_12d_ce
    );

    
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
	ls02 ls02_12a(
			.A1(CLK_6M), 
			.B1(CLK_S1H),
			.Y1(ls02_12a_1y)
		);
	
	wire ls08_8e_1y;
	wire ls08_8e_2y;
	wire ls08_8e_3y;
	wire ls08_8e_4y;
	ls08 ls08_8e(
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
	ls00 ls00_8d(
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

	// CPU 1
	mc68a09e cpu1_9a
        (
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
			.RESET(RESET)
		);	
		
	// CUS47 - CPU 1 ADDRESS DECODER
	cus47 cus47_10c
        (
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
	
	ls139 ls139_7d
        (
			.Eb(cpu1_9a_a[15]),
			.A0b(cpu1_9a_a[13]),
			.A1b(cpu1_9a_a[14]),
			.O3b(ls139_7d_3b)
		);
	
	ls153 ls153_8f
        (
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
	cus41 cus41_8a
        (
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
		
	mc68a09e cpu2_11a
        (
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
			.RESET(RESET)
		);	
	
	// == BUS MULTIPLEXER ==
	
	// to simplify HDL these are in reverse order of schematics [3:0] -> [4Y:1Y]
	wire [3:0] ls257_11e_y;
	wire [3:0] ls257_11d_y;
	wire [3:0] ls257_11f_y;
	wire [3:0] ls157_8c_y;
	
	ls245 ls245_9e
        (
			.DIR(~cpu1_9a_we),
			.OE(cus47_10c_bufen),
			.A(ls245_9e_a),
			.B(cpu1_9a_d)
		);
	
	ls245 ls245_12e
        (
			.DIR(~cpu2_11a_we),
			.OE(~ls00_8d_3y),
			.A(ls245_12e_a),
			.B(cpu2_11a_d)
		);
	
	ls257 ls257_11e
        (
			.G(~CLK_1H),
			.SELA(~CLK_S2H),
			.A(cpu1_9a_a[3:0]),
			.B(cpu2_11a_a[3:0]),
			.Y(ls257_11e_y)
		);
		
	ls257 ls257_11d
        (
			.G(~CLK_1H),
			.SELA(~CLK_S2H),
			.A(cpu1_9a_a[7:4]),
			.B(cpu2_11a_a[7:4]),
			.Y(ls257_11d_y)
		);
		
	ls257 ls257_11f
        (
			.G(~CLK_1H),
			.SELA(~CLK_S2H),
			.A(cpu1_9a_a[11:8]),
			.B(cpu2_11a_a[11:8]),
			.Y(ls257_11f_y)
		);
		
	ls157 ls157_8c
        (
			.G(~CLK_1H),
			.SELA(~CLK_2H),
			.A( {cus47_10c_latch0, cus47_10c_latch1, cpu1_9a_we, cpu1_9a_a[12]} ),
			.B( {cus41_8a_latch0, cus41_8a_latch1, cpu2_11a_we, cpu2_11a_a[12]} ),
			.Y(ls157_8c_y)
		);
	
    // == hardware abstraction - memory buses ==
    
    // CPU 1 to program ROMs 9C and 9D
    
    assign eeprom_9c_addr = cpu1_9a_a[14:0];
    assign eeprom_9c_ce = CLK_2H & cus47_10C_mpmg;
    
    assign eeprom_9d_addr = cpu1_9a_a[14:0];
    assign eeprom_9d_ce = CLK_2H & cus47_10C_spmg;
    
    // Assign ROM data buses to CPU 1 bus if enabled
    assign cpu1_9a_d = eeprom_9c_ce ? eeprom_9c_data : eeprom_9d_ce ? eeprom_9d_data : 8'bZ;
    
    // CPU 2 to program ROMs 12C and 12D
    
    assign eeprom_12c_addr = cpu2_11a_a[14:0];
    assign eeprom_12c_ce = ls00_8d_2y & cus41_8a_mrom;
    
    assign eeprom_12d_addr = cpu2_11a_a[14:0];
    assign eeprom_12d_ce = ls00_8d_2y & cus41_8a_mcs4;
    
    // Assign ROM data buses to CPU 2 bus if enabled
    assign cpu2_11a_d = eeprom_12c_ce ? eeprom_12c_data : eeprom_12d_ce ? eeprom_12d_data : 8'bZ;
	
	// == Global outputs ==
	
	assign A = { 
		ls157_8c_y[0], 
		ls257_11f_y, 
		ls257_11d_y,
		ls257_11e_y
		};
	
	assign RESET = (RST == 1 || cus47_10c_res == 1 || cus41_8a_mreset == 1) ? 1'b1 : 1'b0;	
	
	//assign D = CLK_1H ? ls245_9e_a : ls00_8d_3y ? ls245_12e_a : 8'bZ;
   assign D = (ls245_9e_a == 1'bz) ? ((ls245_12e_a == 1'bz) ? ls00_8d_3y : ls245_12e_a) : ls245_9e_a;
	
	assign MD = cpu1_9a_d;
	assign BACKCOLOR = cus47_10c_latch2;
	assign OBJECT = ~ls08_8e_2y;
	assign SCROLL0 = ~ls08_8e_4y;
	assign SCROLL1 = ~ls08_8e_3y;
	assign LATCH0 = ls157_8c_y[3];
	assign LATCH1 = ls157_8c_y[2];
	assign BANK = cus47_10c_bank;
	assign WE = ls157_8c_y[1];

    
    
	initial begin
	end
	
endmodule
