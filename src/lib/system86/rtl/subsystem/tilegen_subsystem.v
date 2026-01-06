`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:02:48 05/28/2018 
// Design Name:    tilegen_subsystem
// Module Name:    system86/subsystem/tilegen_subsystem.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Tile generation subsystem
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`include "ttl_mem/mb7112.vh"
`include "ttl_mem/mb7116.vh"
`include "ttl_mem/mb7138.vh"

`include "ttl_mem/m27512.vh"
`include "ttl_mem/m27256.vh"

`include "ttl_mem/cy6264.vh"

`include "ttl_mem/ttl_mem.vh"

module tilegen_subsystem
	#(
		parameter LAYER_DISABLE_MASK = 0,
		parameter BACKGROUND_LAYER_AUTOSCROLL = 0,
		parameter BACKGROUND_LAYER_PRIORITY = 0,
		parameter FOREGROUND_LAYER_PRIORITY = 0,
		parameter TEXT_LAYER_PRIORITY = 0,
		parameter UNKNOWN_LAYER_PRIORITY = 0
	)
	(
		input wire _rst_ni,
	
		input wire s86_6M_i,
		input wire s86_2H_i,
		input wire s86_bSCROLL0_i,
		input wire s86_bSCROLL1_i,
		input wire s86_bLATCH0_i,
		input wire s86_bLATCH1_i,
		input wire s86_bHSYNC_i,
		input wire s86_bVSYNC_i,
		input wire s86_FLIP_i,
		input wire s86_SRCWIN_i,
		input wire s86_BANK_i,
		input wire s86_bBACKCOLOR_i,
		input wire [12:0] s86_A_i,
		input wire s86_RbW_i,
		input wire [7:0] s86_MD_i,
		inout wire [7:0] s86_D_io,
		inout wire [20:1] s86_J5_io,
		output wire [2:0] s86_SPR_o,
		output wire [7:0] s86_DOT_o, 
        
      // == hardware abstraction - memory buses ==
		`EPROM_OUTPUT_DEFS(M27512, eprom_4r),
		`EPROM_OUTPUT_DEFS(M27256, eprom_4s),
		
		`EPROM_OUTPUT_DEFS(M27512, eprom_7r),
		`EPROM_OUTPUT_DEFS(M27256, eprom_7s),
		
		`PROM_OUTPUT_DEFS(MB7138, prom_4v),
		`PROM_OUTPUT_DEFS(MB7112, prom_6u),
        
		`SRAM_OUTPUT_DEFS(CY6264, sram_4n),
		`SRAM_OUTPUT_DEFS(CY6264, sram_7n)
    );

	
	// CUS43 inter-connects
	wire [2:0] PR;		// layer priority
	wire [7:0] CL;		//	not sure maybe color - certainly defaulted to background color
	wire [2:0] DT;		// not sure - defaults from s86_J5_io and pulled up high - maps to A0-A2 of tilemap clut.
	
	// == Layer 1 & 2 =
	
	wire [13:0] cus42_7k_ga;
	//wire cus42_7k_rwe;
	//wire cus42_7k_roe;
	//wire [12:0] cus42_7k_ra;
	//wire [7:0] cus42_7k_rd;
	wire cus42_7k_ha2;
	wire cus42_7k_hb2;
	
	wire [13:0] cus42_5k_ga;
	//wire cus42_5k_rwe;
	//wire cus42_5k_roe;
	//wire [12:0] cus42_5k_ra;
	//wire [7:0] cus42_5k_rd;
	wire cus42_5k_ha2;
	wire cus42_5k_hb2;
	
	// (possibly priority lut based on Mame's system 1 description)
	// b4-8 - layer 2 & 4
	// b0-3 - layer 1 & 2
	//   b1-2 -  (tile offset in Mame)
	//   b0 - disable the msb's of the 4 pixel nibble  (ignored in Mame)
	// wire [7:0] prom_6u_data;
	
	// plane 1 (bit 0) & 2 (bit 1)
	// b7 - Pixel 4 bit 1
	// b6 - Pixel 3 bit 1
	// b5 - Pixel 2 bit 1
	// b4 - Pixel 1 bit 1
	// b3 - Pixel 4 bit 0
	// b2 - Pixel 3 bit 0
	// b1 - Pixel 2 bit 0
	// b0 - Pixel 1 bit 0
	// wire [7:0] prom_7r_d;
	
	// plane 2 (bit 2)
	// b7 - Pixel 8 bit 2
	// b6 - Pixel 7 bit 2
	// b5 - Pixel 6 bit 2
	// b4 - Pixel 5 bit 2
	// b3 - Pixel 4 bit 2
	// b2 - Pixel 3 bit 2
	// b1 - Pixel 2 bit 2
	// b0 - Pixel 1 bit 2
    // wire [7:0] prom_7s_d;
	
	// background colour latch
	wire [7:0] ls374_8h_q;
	
	// == Layer 3 & 4 =
	
	// plane 1 (bit 0) & 2 (bit 1)
	// b7 - Pixel 4 bit 1
	// b6 - Pixel 3 bit 1
	// b5 - Pixel 2 bit 1
	// b4 - Pixel 1 bit 1
	// b3 - Pixel 4 bit 0
	// b2 - Pixel 3 bit 0
	// b1 - Pixel 2 bit 0
	// b0 - Pixel 1 bit 0
	//wire [7:0] prom_4r_d;	
    
	// plane 2 (bit 2)
	// b7 - Pixel 8 bit 2
	// b6 - Pixel 7 bit 2
	// b5 - Pixel 6 bit 2
	// b4 - Pixel 5 bit 2
	// b3 - Pixel 4 bit 2
	// b2 - Pixel 3 bit 2
	// b1 - Pixel 2 bit 2
	// b0 - Pixel 1 bit 2
	//wire [7:0] prom_4s_d;	
	
	// priority
	wire [2:0] cus43_6n_pro;
	// color
	wire [7:0] cus43_6n_clo;
	// ???
	wire [2:0] cus43_6n_dto;
	
	// background color latch
	ls374 LS374_8H(
			.nOC(s86_J5_io[5]),		// disable background color driver from auxillary driver over s86_J5_io
			.CLK(s86_bBACKCOLOR_i),	// latches on negative edge
			.s86_D_io(s86_MD_i),
			.Q(ls374_8h_q)
		);
	
    // tile address decoder (used at runtime) 0x1400 - 0x0020
	// possibly similar functionality to system 1 functionality as described in Mame	
    assign prom_6u_addr = { s86_2H_i, cus42_7k_ga[13:12], cus42_5k_ga[13:12] };
    assign prom_6u_ce_n = 1'b0;
	
    // tile map palette prom
    //assign prom_4v_addr = { cus43_6n_clo, cus43_6n_dto };
	 assign prom_4v_addr = { CL, DT };	// direct to layer 0/1
	 assign prom_4v_ce_n = 1'b0;  // SCRWIN
    
	// == Layer 1 & 2 =
	
	cus42
		#(
			.LAYER_A_AUTOSCROLL(BACKGROUND_LAYER_AUTOSCROLL),
			.LAYER_B_AUTOSCROLL(BACKGROUND_LAYER_AUTOSCROLL)
		)
		cus42_7k
		(
			._rst_ni(_rst_ni),
			
			// inputs
			.s86_6M_i(s86_6M_i), 
			.s86_2H_i(s86_2H_i),
			.s86_FLIP_i(s86_FLIP_i),
			.s86_bHSYNC_i(s86_bHSYNC_i),
			.s86_bVSYNC_i(s86_bVSYNC_i),
			.nRCS(s86_bSCROLL0_i),
			.nGCS(1'b1),	// held high (inactive) on schematics
			.nLATCH(s86_bLATCH0_i),
			.CA( { 1'b0, s86_A_i[12:0] } ),
			.s86_RbW_i(s86_RbW_i),
			.CD(s86_D_io),
			// outputs
			.GA(cus42_7k_ga),
			.RA(sram_7n_addr),
			.bRWE(sram_7n_we_n),
			.bROE(sram_7n_oe_n),
			.RD(sram_7n_data),
			.HA2(cus42_7k_ha2),
			.HB2(cus42_7k_hb2)
		);
	
	// tile ram
	assign sram_7n_ce_n = 1'b0;
	
   // layer 1/2 - red and green channels (4-bit per channel)
	assign eprom_7r_addr = { s86_BANK_i, prom_6u_data[3:1], cus42_7k_ga[11:0] };
   assign eprom_7r_ce_n = 1'b0;
	assign eprom_7r_oe_n = 1'b0;
    
   // layer 1/2 - blue channel (4-bit per channel with two pixels per address)
   assign eprom_7s_addr = { s86_BANK_i, prom_6u_data[3:1], cus42_7k_ga[11:1] };
   assign eprom_7s_ce_n = 1'b0;
	assign eprom_7s_oe_n = 1'b0;
    
   wire [3:0] ls158_7u_y;
	ls158 ls158_7u(
			.nG(prom_6u_data[0]),
			.nSELA(cus42_7k_ga[0]),
			.s86_A_i(eprom_7s_data[7:4]),
			.B(eprom_7s_data[3:0]),
			.Y(ls158_7u_y)
			);
	
	// auxillary select
	wire [2:0] cus43_8n_pr_in;
	wire [7:0] cus43_8n_cl_in;
	wire [2:0] cus43_8n_dt_in;
	// priority - held low if no aux
	assign cus43_8n_pr_in = 0; //s86_J5_io[5] ? { s86_J5_io[15], s86_J5_io[14], s86_J5_io[13] } : 3'b0;	
	// color - from backcolor latch if no aux
	assign cus43_8n_cl_in = 0; //s86_J5_io[5] ? { s86_J5_io[4], s86_J5_io[17], s86_J5_io[3], s86_J5_io[18], s86_J5_io[2], s86_J5_io[19], s86_J5_io[1], s86_J5_io[20] } : ls374_8h_q;
	// dt - held high if no aux
	assign cus43_8n_dt_in = 0; //s86_J5_io[5] ? { s86_J5_io[8], s86_J5_io[9], s86_J5_io[10] } : 3'b1;		
	
	// tile generator
	cus43 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK[1:0]),
			.LAYER_A_PRIORITY(BACKGROUND_LAYER_PRIORITY),
			.LAYER_B_PRIORITY(FOREGROUND_LAYER_PRIORITY)
		)
		cus43_8n
		(
			._rst_ni(_rst_ni),
			
			.s86_6M_i(s86_6M_i),
			.s86_2H_i(s86_2H_i),
			.PRI( cus43_8n_pr_in ),
			.CLI( cus43_8n_cl_in ),
			.DTI( cus43_8n_dt_in ),
			.GDI( { ls158_7u_y, eprom_7r_data } ),
			.MDI( sram_7n_data ),
			.CA(s86_A_i[2:0]),
			.s86_RbW_i(s86_RbW_i),
			.nLATCH(s86_bLATCH0_i),
			.s86_FLIP_i(s86_FLIP_i),
			.PRO(PR),
			.CLO(CL),
			.DTO(DT),
			.HA2(cus42_7k_ha2),
			.HB2(cus42_7k_hb2)
		);
		
	// == Layer 3 & 4 =
	
	// tile address generator
	cus42 CUS42_5K(
			._rst_ni(_rst_ni),
			
			.s86_6M_i(s86_6M_i), 
			.s86_2H_i(s86_2H_i), 
			.s86_FLIP_i(s86_FLIP_i),
			.s86_bHSYNC_i(s86_bHSYNC_i),
			.s86_bVSYNC_i(s86_bVSYNC_i),
			.nGCS(1'b1),	// held high (inactive) on schematics
			.nRCS(s86_bSCROLL1_i),
			.nLATCH(s86_bLATCH1_i),
			.CA( { 1'b0, s86_A_i[12:0] } ),
			.s86_RbW_i(s86_RbW_i),
			.CD(s86_D_io),
			.GA(cus42_5k_ga),
			.bRWE(sram_4n_we_n),
			.bROE(sram_4n_oe_n),
			.RA(sram_4n_addr),
			.RD(sram_4n_data),
			.HA2(cus42_5k_ha2),
			.HB2(cus42_5k_hb2)
		);
		
	// tile ram 1
	assign sram_4n_ce_n = 1'b0;
	
    // layer 3/4 - red and green channels (4-bit per channel)
	assign eprom_4r_addr = { prom_6u_data[7:5], cus42_5k_ga[11:0] };
   assign eprom_4r_ce_n = 1'b0;
	assign eprom_4r_oe_n = 1'b0;
    
   // layer 3/4 - blue channel (4-bit per channel with two pixels per address)
   assign eprom_4s_addr = { prom_6u_data[7:5], cus42_5k_ga[11:1] };
   assign eprom_4s_ce_n = 1'b0;
	assign eprom_4s_oe_n = 1'b0;
    
	wire [3:0] ls158_5u_y;
	ls158 ls158_5u(
			.nG(prom_6u_data[4]),
			.nSELA(cus42_5k_ga[0]),
			.s86_A_i(eprom_4s_data[7:4]),
			.B(eprom_4s_data[3:0]),
			.Y(ls158_5u_y)
			);
			
	// tile generator
	cus43 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK[3:2]),
			.LAYER_A_PRIORITY(UNKNOWN_LAYER_PRIORITY),
			.LAYER_B_PRIORITY(TEXT_LAYER_PRIORITY)
		)
		cus43_6n
		(
			._rst_ni(_rst_ni),
			
			.s86_6M_i(s86_6M_i),
			.s86_2H_i(s86_2H_i),
			.PRI(PR),
			.CLI(CL),
			.DTI(DT),
			.GDI( { ls158_5u_y, eprom_4r_data } ),
			.MDI( sram_4n_data ),
			.CA(s86_A_i[2:0]),
			.s86_RbW_i(s86_RbW_i),
			.nLATCH(s86_bLATCH1_i),
			.s86_FLIP_i(s86_FLIP_i),
			.PRO(cus43_6n_pro),
			.CLO(cus43_6n_clo),
			.DTO(cus43_6n_dto),
			.HA2(cus42_5k_ha2),
			.HB2(cus42_5k_hb2)
		);
	
	// to auxillary color drivers over s86_J5_io
	assign s86_J5_io[6] = s86_bBACKCOLOR_i;

	assign s86_DOT_o = prom_4v_data;
endmodule
