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

`include "mc6809_cpu/mc6809.vh"

`include "ttl_mem/m27256.vh"

`include "ttl_mem/ttl_mem.vh"

module cpu_subsystem
    #(
    )
	(
		  input wire rst_n,
		  
        input wire CLK_6M,
        input wire CLK_2H,
        input wire CLK_S2H,
        input wire CLK_1H,
        input wire CLK_S1H,
        input wire nVBLANK,
        inout wire [7:0] D,
		  output wire [12:0] A,
        output wire RnW,
        output wire nRESET,
        output wire nSCROLL0,
        output wire nSCROLL1,
        output wire nOBJECT,
        output wire nLATCH0,
        output wire nLATCH1,
        output wire nBACKCOLOR,
        output wire [7:0] MD,	// master CPU data bus to backcolor latch
      
        /// == Pluggable CPUs
		
        `MC6809_INPUT_DEFS(E, mcpu_11a),		// 6809 - master cpu
        `MC6809_INPUT_DEFS(E, scpu_9a),		// 6809 - sub cpu

		  // == hardware abstraction - memory buses ==
		  
		  `EPROM_OUTPUT_DEFS(M27256, eprom_9c),
		  `EPROM_OUTPUT_DEFS(M27256, eprom_9d),
		  `EPROM_OUTPUT_DEFS(M27256, eprom_12c),
		  `EPROM_OUTPUT_DEFS(M27256, eprom_12d)
    );

    
	// == Master CPU system ==
	
	// CUS41 signals
	wire cus41_8a_q;
	wire cus41_8a_mreset_n;
	wire cus41_8a_mint_n;
	wire cus41_8a_sndirq_n;
	wire cus41_8a_subscr0_n;
	wire cus41_8a_subscr1_n;
	wire cus41_8a_subobj_n;
	wire cus41_8a_mcs4_n;
	wire cus41_8a_mrom_n;
	
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
	wire ls00_8d_2y_n;	// low if 2H high and main CPU RnW high
	wire ls00_8d_3y_n;	// low if 2H high and MCS4 or MROM not active 
	ls00 ls00_8d(
			.A1(mcpu_11a_addr[12]),
			.B1(mcpu_11a_addr[15]),
			.A2(mcpu_11a_we_n),
			.B2(CLK_2H),
			.A3(ls08_8e_1y_n),
			.B3(CLK_2H),
			.Y1(ls00_8d_1y_n),
			.Y2(ls00_8d_2y_n),
			.Y3(ls00_8d_3y_n)
		);
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;
		
	// CUS41 - main CPU address decoder
	cus41 cus41_8a
        (
			.rst_n(rst_n),
			
			.MA(mcpu_11a_addr[15:11]), 
			.CLK_0(~CLK_S2H), 	// negate for active low
			.CLK_6M(CLK_6M), 
			.Q(cus41_8a_q),
			.nVBLA(nVBLANK),
			.nMWE(mcpu_11a_we_n), 
			.nMRESET(cus41_8a_mreset_n), 	// master reset output?
			.nMINT(cus41_8a_mint_n), 
			.nSINT(cus41_8a_sndirq_n), 
			.nLTH0(cus41_8a_latch0_n), 
			.nLTH1(cus41_8a_latch1_n), 
			.nMCS0(cus41_8a_subscr0_n), 
			.nMCS1(cus41_8a_subscr1_n), 
			.nMCS2(cus41_8a_subobj_n), 
			.nMCS4(cus41_8a_mcs4_n), 
			.nMROM(cus41_8a_mrom_n)
		);
		
	assign mcpu_11a_e = cus47_10c_sube; 
	assign mcpu_11a_q = cus41_8a_q;
	assign mcpu_11a_irq_n = cus41_8a_sndirq_n;
	assign mcpu_11a_reset_n = nRESET;	
	
	// CUS47 - Sub CPU address decoder
	cus47 cus47_10c
        (
			.rst_n(rst_n),
		  
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_S2H), 
			.nVBLK(nVBLANK),
			.nRES(cus47_10c_res_n), 
			.RnW(scpu_9a_we_n), 
			.A(scpu_9a_addr[15:10]), 
			.MQ(cus47_10c_mq), 
			.ME(cus47_10c_me), 
			.nIRQ(cus47_10c_irq_n), 
			.SE(cus47_10c_sube), 
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
	
	assign scpu_9a_e = cus47_10c_me;
	assign scpu_9a_q = cus47_10c_mq;	
	assign scpu_9a_irq_n = cus47_10c_irq_n;
	assign scpu_9a_reset_n = nRESET;
	
	ls139 ls139_7d
        (
			.nEb(scpu_9a_addr[15]),
			.A0b(scpu_9a_addr[13]),
			.A1b(scpu_9a_addr[14]),
			.nO3b(ls139_7d_3b_n)
		);
	
	ls153 ls153_8f
        (
			.S0(scpu_9a_addr[0]),
			.S1(scpu_9a_addr[1]),
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
		
	address_bus address_bus
		(
			.rst_n(rst_n), 
			.CLK_2H(CLK_2H), 
			.CLK_S2H(CLK_S2H), 
			.CLK_1H(CLK_1H), 
			.MA(mcpu_11a_addr[12:0]), 
			.MRnW(mcpu_11a_we_n), 
			.nMBUFEN(ls00_8d_3y_n), 
			.nMLTH0(cus41_8a_latch0_n), 
			.nMLTH1(cus41_8a_latch1_n), 
			.SA(scpu_9a_addr[12:0]), 
			.SRnW(scpu_9a_we_n), 
			.nSBUFEN(cus47_10c_bufen_n), 
			.nSLTH0(cus47_10c_latch0_n), 
			.nSLTH1(cus47_10c_latch1_n), 
			.A(A), 
			.RnW(RnW), 
			.nLATCH0(nLATCH0), 
			.nLATCH1(nLATCH1)
		);
	
	// Main CPU data bus
	ls245 ls245_12e
        (
			.DIR(mcpu_11a_we_n),
			.nOE(ls00_8d_3y_n),
			.A(D),
			.B(mcpu_11a_data)
		);
	
	// Sub CPU data bus
	ls245 ls245_9e
        (
			.DIR(scpu_9a_we_n),
			.nOE(cus47_10c_bufen_n),
			.A(D),
			.B(scpu_9a_data)
		);
		
		
    // == hardware abstraction - memory buses ==
    
	// Main CPU to program ROMs 12C and 12D
    
    assign eprom_12c_addr = mcpu_11a_addr[14:0];
    assign eprom_12c_ce_n = cus41_8a_mrom_n;
	 assign eprom_12c_oe_n = ls00_8d_2y_n;
    
    assign eprom_12d_addr = mcpu_11a_addr[14:0];
    assign eprom_12d_ce_n = cus41_8a_mcs4_n;
	 assign eprom_12d_oe_n = ls00_8d_2y_n;
    
    // Assign ROM data buses to main CPU bus if enabled
	 assign mcpu_11a_data = mcpu_11a_we_n ? (ls00_8d_3y_n ? eprom_12d_data : 8'bz) : 8'bz;
    			 
    // Sub CPU to program ROMs 9C and 9D
    
    assign eprom_9c_addr = scpu_9a_addr[14:0];
    assign eprom_9c_ce_n = cus47_10C_mpmg_n;
	 assign eprom_9c_oe_n = CLK_2H;
    
    assign eprom_9d_addr = scpu_9a_addr[14:0];
    assign eprom_9d_ce_n = cus47_10C_spmg_n;
	 assign eprom_9d_oe_n = CLK_2H;
    
    // Assign ROM data buses to sub CPU bus if enabled
	assign scpu_9a_data = scpu_9a_we_n ? (cus47_10c_bufen_n ? eprom_9c_data : 8'bz) : 8'bz;
    
	assign mcpu_11a_nmi_n = 0;
	assign mcpu_11a_firq_n = 0;
	assign mcpu_11a_halt_n = 0;
	assign scpu_9a_nmi_n = 0;
	assign scpu_9a_firq_n = 0;
	assign scpu_9a_halt_n = 0;
	
	// == Global outputs ==
	
	assign nRESET = cus47_10c_res_n & cus41_8a_mreset_n;
	
	assign MD = scpu_9a_data;
	assign nBACKCOLOR = cus47_10c_latch2_n;
	assign nOBJECT = ls08_8e_2y_n;
	assign nSCROLL0 = ls08_8e_4y_n;
	assign nSCROLL1 = ls08_8e_3y_n;
	assign BANK = cus47_10c_bank;
	
endmodule
