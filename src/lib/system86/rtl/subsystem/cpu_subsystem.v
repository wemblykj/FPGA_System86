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

`include "../../../ttl_mem/m27256.vh"

`include "../../../ttl_mem/ttl_mem.vh"

module cpu_subsystem
    #(
    )
	(
		  input wire rst,
		  
        input wire CLK_6M,
        input wire CLK_2H,
        input wire CLK_S2H,
        input wire CLK_1H,
        input wire CLK_S1H,
        input wire nVBLANK,
        //input wire nRESET,
        inout wire [12:0] A,
        inout wire [7:0] D,
        inout wire nWE,
        output wire nRESET,
        output wire nSCROLL0,
        output wire nSCROLL1,
        output wire nOBJECT,
        output wire nLATCH0,
        output wire nLATCH1,
        output wire nBACKCOLOR,
        output wire [7:0] MD,	// master CPU data bus to backcolor latch
        
        // == hardware abstraction - memory buses ==
        
		  `EPROM_OUTPUT_DEFS(M27256, eprom_9c),
		  `EPROM_OUTPUT_DEFS(M27256, eprom_9d),
		  `EPROM_OUTPUT_DEFS(M27256, eprom_12c),
		  `EPROM_OUTPUT_DEFS(M27256, eprom_12d)
    );

    
	// == Master CPU system ==
	
	// CPU 1 signals
	wire [7:0] cpu1_9a_d;
	wire [15:0] cpu1_9a_a;
	wire cpu1_9a_we_n;
	wire cpu1_9a_bs;
	wire cpu1_9a_ba;
	wire cpu1_9a_avma;
	wire cpu1_9a_busy;
	wire cpu1_9a_lic;
	
	// CUS47 signals
	wire cus47_10c_res_n;
	wire cus47_10c_mq;
	wire cus47_10c_me;
	wire cus47_10c_sube;
	wire cus47_10c_irq_n;
	wire cus47_10c_scr0_n;
	wire cus47_10c_scr1_n;
	wire cus47_10c_obj_n;
	wire cus47_10c_bank;
	wire cus47_10c_bufen_n;
	wire cus47_10C_mpmg_n;
	wire cus47_10C_spmg_n;

	// CPU 2
	wire [7:0] cpu2_11a_d;
	wire [15:0] cpu2_11a_a;
	wire cpu2_11a_we_n;
	wire cpu2_11a_bs;
	wire cpu2_11a_ba;
	wire cpu2_11a_avma;
	wire cpu2_11a_busy;
	wire cpu2_11a_lic;
	
	// CUS41 signals
	wire cus41_8a_q;
	wire cus41_8a_mreset_n;
	wire cus41_8a_sndirq_n;
	wire cus41_8a_subscr0_n;
	wire cus41_8a_subscr1_n;
	wire cus41_8a_subobj_n;
	wire cus41_8a_mcs4_n;
	wire cus41_8a_mrom_n;
	
	// == misc logic ==
	
	wire ls139_7d_3b_n;	// to J4
	
	wire ls02_12a_1y;
	ls02 ls02_12a(
			.A1(CLK_6M), 
			.B1(CLK_S1H),
			.Y1(ls02_12a_1y)
		);
	
	wire ls08_8e_1y_n;	// low if MCS4 or MROM activity on bus
	wire ls08_8e_2y_n;	// to nOBJECT
	wire ls08_8e_3y_n;	// to nSCROLL1
	wire ls08_8e_4y_n;	// to nSCROLL0
	ls08 ls08_8e(
			.A1(cus41_8a_mcs4_n),
			.B1(cus41_8a_mrom_n),
			.A2(cus47_10c_obj_n),
			.B2(cus41_8a_subobj_n),
			.A3(cus47_10c_scr1_n),
			.B3(cus41_8a_subscr1_n),
			.A4(cus47_10c_scr0_n),
			.B4(cus41_8a_subscr0_n),
			.Y1(ls08_8e_1y_n), 
			.Y2(ls08_8e_2y_n), 
			.Y3(ls08_8e_3y_n), 
			.Y4(ls08_8e_4y_n)
		);
	
	wire ls00_8d_1y_n;	
	wire ls00_8d_2y_n;	// low if 2H high and CPU 2 RnW high
	wire ls00_8d_3y_n;	// low if 2H high and MCS4 or MROM not active 
	ls00 ls00_8d(
			.A1(cpu2_11a_a[12]),
			.B1(cpu2_11a_a[15]),
			.A2(cpu2_11a_we_n),
			.B2(CLK_2H),
			.A3(ls08_8e_1y_n),
			.B3(CLK_2H),
			.Y1(ls00_8d_1y_n),
			.Y2(ls00_8d_2y_n),
			.Y3(ls00_8d_3y_n)
		);
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;

	// CPU 1
	mc68a09e cpu1_9a
        (
			.D(cpu1_9a_d), 
			.A(cpu1_9a_a), 
			.RnW(cpu1_9a_we_n), 
			.E(cus47_10c_me), 
			.Q(cus47_10c_mq), 
			.BS(cpu1_9a_bs), 
			.BA(cpu1_9a_ba), 
			.nIRQ(cus47_10c_irq_n), 
			.nFIRQ(1'b1), 
			.nNMI(1'b1), 
			.AVMA(cpu1_9a_avma), 
			.BUSY(cpu1_9a_busy), 
			.LIC(cpu1_9a_lic), 
			.nHALT(1'b1), 
			.nRESET(nRESET)
		);	
		
	// CUS47 - CPU 1 ADDRESS DECODER
	cus47 cus47_10c
        (
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_S2H), 
			.nVBLK(nVBLANK),
			.nRES(cus47_10c_res_n), 
			.nWE(cpu1_9a_we_n), 
			.A(cpu1_9a_a[15:10]), 
			.MQ(cus47_10c_mq), 
			.ME(cus47_10c_me), 
			.nIRQ(cus47_10c_irq_n), 
			.SUBE(cus47_10c_sube), 
			.SUBQ(cus41_8a_q),			// temp alt for CUS41
			.nLTH2(cus47_10c_latch2_n), 
			.nLTH1(cus47_10c_latch1_n), 
			.nLTH0(cus47_10c_latch0_n), 
			.nSCR0(cus47_10c_scr0_n), 
			.nSCR1(cus47_10c_scr1_n), 
			.nOBJ(cus47_10c_obj_n), 
			.BANK(cus47_10c_bank), 
			.nBUFEN(cus47_10c_bufen_n),
			.nSPGM(cus47_10C_spmg_n), 
			.nMPGM(cus47_10C_mpmg_n)
		);
	
	ls139 ls139_7d
        (
			.nEb(cpu1_9a_a[15]),
			.A0b(cpu1_9a_a[13]),
			.A1b(cpu1_9a_a[14]),
			.nO3b(ls139_7d_3b_n)
		);
	
	ls153 ls153_8f
        (
			.S0(cpu1_9a_a[0]),
			.S1(cpu1_9a_a[1]),
			.nEa(nLATCH0),
			.nEb(nLATCH1),
			.I0a(1'b0),
			.I1a(1'b0),
			.I2a(1'b0),
			.I3a(ls02_12a_1y),
			.I0b(1'b0),
			.I1b(1'b0),
			.I2b(1'b0),
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
			.nVBLA(nVBLANK),
			.nMWE(cpu2_11a_we_n), 
			.nMRES(cus41_8a_mreset_n), 	// master reset output?
			.nSINT(cus41_8a_sndirq_n), 
			.nLTH0(cus41_8a_latch0_n), 
			.nLTH1(cus41_8a_latch1_n), 
			.nMCS0(cus41_8a_subscr0_n), 
			.nMCS1(cus41_8a_subscr1_n), 
			.nMCS2(cus41_8a_subobj_n), 
			.nMCS4(cus41_8a_mcs4_n), 
			.nMROM(cus41_8a_mrom_n)
		);
		
	mc68a09e cpu2_11a
        (
			.D(cpu2_11a_d), 
			.A(cpu2_11a_a), 
			.RnW(cpu2_11a_we_n), 
			.E(cus47_10c_sube), 
			.Q(cus41_8a_q), 
			.BS(cpu2_11a_bs), 
			.BA(cpu2_11a_ba), 
			.nIRQ(cus41_8a_sndirq_n), 
			.nFIRQ(1'b1), 
			.nNMI(1'b1), 
			.AVMA(cpu2_11a_avma), 
			.BUSY(cpu2_11a_busy), 
			.LIC(cpu2_11a_lic), 
			.nHALT(1'b1), 
			.nRESET(nRESET)
		);	
	
	// == BUS MULTIPLEXER ==
	
	// to simplify HDL these are in reverse order of schematics [3:0] -> [4Y:1Y]
	wire [3:0] ls257_11e_y;
	wire [3:0] ls257_11d_y;
	wire [3:0] ls257_11f_y;
	wire [3:0] ls157_8c_y;
	
	ls245 ls245_9e
        (
			.DIR(cpu1_9a_we_n),
			.nOE(cus47_10c_bufen_n),
			.A(D),
			.B(cpu1_9a_d)
		);
		
	ls245 ls245_12e
        (
			.DIR(cpu2_11a_we_n),
			.nOE(ls00_8d_3y_n),
			.A(D),
			.B(cpu2_11a_d)
		);
	
	ls257 ls257_11e
        (
			.nG(CLK_1H),
			.nSELA(CLK_S2H),
			.A(cpu1_9a_a[3:0]),
			.B(cpu2_11a_a[3:0]),
			.Y(ls257_11e_y)
		);
		
	ls257 ls257_11d
        (
			.nG(CLK_1H),
			.nSELA(CLK_S2H),
			.A(cpu1_9a_a[7:4]),
			.B(cpu2_11a_a[7:4]),
			.Y(ls257_11d_y)
		);
		
	ls257 ls257_11f
        (
			.nG(CLK_1H),
			.nSELA(CLK_S2H),
			.A(cpu1_9a_a[11:8]),
			.B(cpu2_11a_a[11:8]),
			.Y(ls257_11f_y)
		);
		
	ls157 ls157_8c
        (
			.nG(CLK_1H),
			.nSELA(CLK_2H),
			.A( {cus47_10c_latch0_n, cus47_10c_latch1_n, cpu1_9a_we_n, cpu1_9a_a[12]} ),
			.B( {cus41_8a_latch0_n, cus41_8a_latch1_n, cpu2_11a_we_n, cpu2_11a_a[12]} ),
			.Y(ls157_8c_y)
		);
	
    // == hardware abstraction - memory buses ==
    
    // CPU 1 to program ROMs 9C and 9D
    
    assign eprom_9c_addr = cpu1_9a_a[14:0];
    assign eprom_9c_ce_n = CLK_2H | cus47_10C_mpmg_n;		// combined CE/OE
    
    assign eprom_9d_addr = cpu1_9a_a[14:0];
    assign eprom_9d_ce_n = CLK_2H | cus47_10C_spmg_n;		// combined CE/OE
    
    // Assign ROM data buses to CPU 1 bus if enabled
    assign cpu1_9a_d = 
		eprom_9c_ce_n ? 
			eprom_9d_ce_n ? 8'bZ : eprom_9d_data
		 : eprom_9c_data;
    
    // CPU 2 to program ROMs 12C and 12D
    
    assign eprom_12c_addr = cpu2_11a_a[14:0];
    assign eprom_12c_ce_n = ls00_8d_2y_n | cus41_8a_mrom_n;	// combined CE/OE
    
    assign eprom_12d_addr = cpu2_11a_a[14:0];
    assign eprom_12d_ce_n = ls00_8d_2y_n | cus41_8a_mcs4_n;	// combined CE/OE
    
    // Assign ROM data buses to CPU 2 bus if enabled
    assign cpu2_11a_d = 
		eprom_12c_ce_n ?
			eprom_12d_ce_n ? 8'bZ : eprom_12d_data
		 : eprom_12c_data;
	
	// == Global outputs ==
	
	assign A = { 
		ls157_8c_y[0], 	// A12
		ls257_11f_y,		// A8-11
		ls257_11d_y,		// A4-7
		ls257_11e_y			// A0-3
		};
	
	assign nRESET = (rst == 1 || cus47_10c_res_n == 1 || cus41_8a_mreset_n == 1) ? 1'b0 : 1'b1;
	
	assign MD = cpu1_9a_d;
	assign nBACKCOLOR = cus47_10c_latch2_n;
	assign nOBJECT = ls08_8e_2y_n;
	assign nSCROLL0 = ls08_8e_4y_n;
	assign nSCROLL1 = ls08_8e_3y_n;
	assign nLATCH0 = ls157_8c_y[3];
	assign nLATCH1 = ls157_8c_y[2];
	assign BANK = cus47_10c_bank;
	assign nWE = ls157_8c_y[1];
	
endmodule
