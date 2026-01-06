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
	     input wire _rst_ni,
        input wire s86_6M_i,
        input wire s86_2H_i,
        input wire s86_S2H_i,
        input wire s86_1H_i,
        input wire s86_S1H_i,
        input wire s86_bVBLANK_i,
        inout wire [7:0] s86_D_io,
		  output wire [12:0] s86_A_o,
        output wire s86_RbW_o,
        output wire s86_bRESET_o,
        output wire s86_bSCROLL0_o,
        output wire s86_bSCROLL1_o,
        output wire s86_bOBJECT_o,
        output wire s86_bLATCH0_o,
        output wire s86_bLATCH1_o,
        output wire s86_bBACKCOLOR_o,
		  output wire s86_BANK_o,
        output wire [7:0] s86_MD_o,	// master CPU data bus to backcolor latch
      
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
			.A1(s86_6M_i), 
			.B1(s86_S1H_i),
			.Y1(ls02_12a_1y)
		);
	
	wire ls08_8e_1y_n;	// low if MCS4 or MROM activity on bus
	wire ls08_8e_2y_n;	// to s86_bOBJECT_o
	wire ls08_8e_3y_n;	// to s86_bSCROLL1_o
	wire ls08_8e_4y_n;	// to s86_bSCROLL0_o
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
	wire ls00_8d_2y_n;	// low if 2H high and main CPU s86_RbW_o high
	wire ls00_8d_3y_n;	// low if 2H high and MCS4 or MROM not active 
	ls00 ls00_8d(
			.A1(mcpu_11a_addr[12]),
			.B1(mcpu_11a_addr[15]),
			.A2(mcpu_11a_we_n),
			.B2(s86_2H_i),
			.A3(ls08_8e_1y_n),
			.B3(s86_2H_i),
			.Y1(ls00_8d_1y_n),
			.Y2(ls00_8d_2y_n),
			.Y3(ls00_8d_3y_n)
		);
	
	wire ls153_8f_1y;
	wire ls153_8f_2y;
		
	// CUS41 - main CPU address decoder
	cus41 cus41_8a
        (
			._rst_ni(_rst_ni),
			
			.pin_MA_i(mcpu_11a_addr[15:11]), 
			.pin_CLK0_i(~s86_S2H_i), 	// negate for active low
			.pin_6M_i(s86_6M_i), 
			.pin_Q_i(cus41_8a_q),
			.pin_bVBLA_i(s86_bVBLANK_i),
			.pin_bMWE_i(mcpu_11a_we_n), 
			.pin_bMRESET_o(cus41_8a_mreset_n), 	// master reset output?
			.pin_bMINT_o(cus41_8a_mint_n), 
			.pin_bSINT_o(cus41_8a_sndirq_n), 
			.pin_bLTH0_o(cus41_8a_latch0_n), 
			.pin_bLTH1_o(cus41_8a_latch1_n), 
			.pin_bMCS0_o(cus41_8a_subscr0_n), 
			.pin_bMCS1_o(cus41_8a_subscr1_n), 
			.pin_bMCS2_o(cus41_8a_subobj_n), 
			.pin_bMCS4_o(cus41_8a_mcs4_n), 
			.pin_bMROM_o(cus41_8a_mrom_n)
		);
		
	assign mcpu_11a_e = cus47_10c_sube; 
	assign mcpu_11a_q = cus41_8a_q;
	assign mcpu_11a_irq_n = cus41_8a_sndirq_n;
	assign mcpu_11a_reset_n = s86_bRESET_o;	
	
	// CUS47 - Sub CPU address decoder
	cus47 cus47_10c
        (
			._rst_ni(_rst_ni),
		  
			.pin_6M_i(s86_6M_i), 
			.pin_2H_i(s86_S2H_i), 
			.pin_bVBLK_i(s86_bVBLANK_i),
			.pin_bRES_i(cus47_10c_res_n), 
			.pin_RbW_i(scpu_9a_we_n), 
			.pin_A_i(scpu_9a_addr[15:10]), 
			.pin_MQ_o(cus47_10c_mq), 
			.pin_ME_o(cus47_10c_me), 
			.pin_bIRQ_o(cus47_10c_irq_n), 
			.pin_SE_o(cus47_10c_sube), 
			.pin_bLTH2_o(cus47_10c_latch2_n), 
			.pin_bLTH1_o(cus47_10c_latch1_n), 
			.pin_bLTH0_o(cus47_10c_latch0_n), 
			.pin_bSCR0_o(cus47_10c_scr0_n), 
			.pin_bSCR1_o(cus47_10c_scr1_n), 
			.pin_bOBJ_o(cus47_10c_obj_n), 
			.pin_BANK_o(cus47_10c_bank), 
			.pin_bBUFEN_o(cus47_10c_bufen_n),
			.pin_bSPGM_o(cus47_10C_spmg_n), 
			.pin_bMPGM_o(cus47_10C_mpmg_n)
		);
	
	assign scpu_9a_e = cus47_10c_me;
	assign scpu_9a_q = cus47_10c_mq;	
	assign scpu_9a_irq_n = cus47_10c_irq_n;
	assign scpu_9a_reset_n = s86_bRESET_o;
	
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
			.nEa(s86_bLATCH0_o),
			.nEb(s86_bLATCH1_o),
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
			._rst_ni(_rst_ni), 
			.s86_2H_i(s86_2H_i), 
			.s86_S2H_i(s86_S2H_i), 
			.s86_1H_i(s86_1H_i), 
			.s86_MA(mcpu_11a_addr[12:0]), 
			.s86_MRbW(mcpu_11a_we_n), 
			.s86_bMBUFEN(ls00_8d_3y_n), 
			.s86_bMLTH0(cus41_8a_latch0_n), 
			.s86_bMLTH1(cus41_8a_latch1_n), 
			.s86_SA(scpu_9a_addr[12:0]), 
			.s86_sRbW(scpu_9a_we_n), 
			.s86_bSBUFEN(cus47_10c_bufen_n), 
			.s86_bSLTH0(cus47_10c_latch0_n), 
			.s86_bSLTH1(cus47_10c_latch1_n), 
			.s86_A_o(s86_A_o), 
			.s86_RbW_o(s86_RbW_o), 
			.s86_bLATCH0_o(s86_bLATCH0_o), 
			.s86_bLATCH1_o(s86_bLATCH1_o)
		);
	
	// Main CPU data bus
	ls245 ls245_12e
        (
			.DIR(mcpu_11a_we_n),
			.bOE(ls00_8d_3y_n),
			.s86_A_o(s86_D_io),
			.B(mcpu_11a_data)
		);
	
	// Sub CPU data bus
	ls245 ls245_9e
        (
			.DIR(scpu_9a_we_n),
			.bOE(cus47_10c_bufen_n),
			.s86_A_o(s86_D_io),
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
	 assign eprom_9c_oe_n = s86_2H_i;
    
    assign eprom_9d_addr = scpu_9a_addr[14:0];
    assign eprom_9d_ce_n = cus47_10C_spmg_n;
	 assign eprom_9d_oe_n = s86_2H_i;
    
    // Assign ROM data buses to sub CPU bus if enabled
	assign scpu_9a_data = scpu_9a_we_n ? (cus47_10c_bufen_n ? eprom_9c_data : 8'bz) : 8'bz;
    
	assign mcpu_11a_nmi_n = 0;
	assign mcpu_11a_firq_n = 0;
	assign mcpu_11a_halt_n = 0;
	assign scpu_9a_nmi_n = 0;
	assign scpu_9a_firq_n = 0;
	assign scpu_9a_halt_n = 0;
	
	// == Global outputs ==
	
	assign s86_bRESET_o = cus47_10c_res_n & cus41_8a_mreset_n;
	
	assign s86_MD_o = scpu_9a_data;
	assign s86_bBACKCOLOR_o = cus47_10c_latch2_n;
	assign s86_bOBJECT_o = ls08_8e_2y_n;
	assign s86_bSCROLL0_o = ls08_8e_4y_n;
	assign s86_bSCROLL1_o = ls08_8e_3y_n;
	assign s86_BANK_o = cus47_10c_bank;
	
endmodule
