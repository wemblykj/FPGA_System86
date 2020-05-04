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

`include "../../../ttl_mem/mb7112.vh"
`include "../../../ttl_mem/mb7116.vh"
`include "../../../ttl_mem/mb7138.vh"

`include "../../../ttl_mem/m27512.vh"
`include "../../../ttl_mem/m27256.vh"

`include "../../../ttl_mem/cy6264.vh"

`include "../../../ttl_mem/ttl_mem.vh"

module tilegen_subsystem
	#(
		LAYER_DISABLE_MASK = 0,
		BACKGROUND_LAYER_AUTOSCROLL = 0,
		BACKGROUND_LAYER_PRIORITY = 0,
		FOREGROUND_LAYER_PRIORITY = 0,
		TEXT_LAYER_PRIORITY = 0,
		UNKNOWN_LAYER_PRIORITY = 0
	)
	(
		input wire rst,
	
		input wire CLK_6M,
		input wire CLK_2H,
		input wire nSCROLL0,
		input wire nSCROLL1,
		input wire nLATCH0,
		input wire nLATCH1,
		input wire nHSYNC,
		input wire nVSYNC,
		input wire FLIP,
		input wire SRCWIN,
		input wire BANK,
		input wire nBACKCOLOR,
		input wire [12:0] A,
		input wire nWE,
		input wire [7:0] MD,
		inout wire [7:0] D,
		inout wire [20:1] J5,
		output wire [2:0] SPR,
		output wire [7:0] DOT, 
        
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
	wire [2:0] DT;		// not sure - defaults from J5 and pulled up high - maps to A0-A2 of tilemap clut.
	
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
			.nOC(J5[5]),		// disable background color driver from auxillary driver over J5
			.CLK(nBACKCOLOR),	// latches on negative edge
			.D(MD),
			.Q(ls374_8h_q)
		);
	
    // tile address decoder (used at runtime) 0x1400 - 0x0020
	// possibly similar functionality to system 1 functionality as described in Mame	
    assign prom_6u_addr = { CLK_2H, cus42_7k_ga[13:12], cus42_5k_ga[13:12] };
    assign prom_6u_ce_n = 1'b0;
	
    // tile map palette prom
    assign prom_4v_addr = { cus43_6n_clo, cus43_6n_dto };
	 assign prom_4v_ce_n = 1'b0;  // SCRWIN
    
	// == Layer 1 & 2 =
	
	cus42
		#(
			.LAYER_A_AUTOSCROLL(BACKGROUND_LAYER_AUTOSCROLL),
			.LAYER_B_AUTOSCROLL(BACKGROUND_LAYER_AUTOSCROLL)
		)
		cus42_7k
		(
			.rst(rst),
			
			// inputs
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_2H),
			.FLIP(FLIP),
			.nHSYNC(nHSYNC),
			.nVSYNC(nVSYNC),
			.nRCS(nSCROLL0),
			.nGCS(1'b1),	// held high (inactive) on schematics
			.nLATCH(nLATCH0),
			.CA( { 1'b0, A[12:0] } ),
			.nWE(nWE),
			.CD(D),
			// outputs
			.GA(cus42_7k_ga),
			.RA(sram_7n_addr),
			.nRWE(sram_7n_we_n),
			.nROE(sram_7n_oe_n),
			.RD(sram_7n_data),
			.HA2(cus42_7k_ha2),
			.HB2(cus42_7k_hb2)
		);
	
	// tile ram
	assign sram_7n_ce_n = 1'b0;
	
   // layer 1/2 - red and green channels (4-bit per channel)
	assign eprom_7r_addr = { BANK, prom_6u_data[3:1], cus42_7k_ga[11:0] };
   assign eprom_7r_ce_n = 1'b0;
	assign eprom_7r_oe_n = 1'b0;
    
   // layer 1/2 - blue channel (4-bit per channel with two pixels per address)
   assign eprom_7s_addr = { BANK, prom_6u_data[3:1], cus42_7k_ga[11:1] };
   assign eprom_7s_ce_n = 1'b0;
	assign eprom_7s_oe_n = 1'b0;
    
   wire [3:0] ls158_7u_y;
	ls158 ls158_7u(
			.nG(prom_6u_data[0]),
			.nSELA(cus42_7k_ga[0]),
			.A(eprom_7s_data[7:4]),
			.B(eprom_7s_data[3:0]),
			.Y(ls158_7u_y)
			);
	
	// auxillary select
	wire [2:0] cus43_8n_pr_in;
	wire [7:0] cus43_8n_cl_in;
	wire [2:0] cus43_8n_dt_in;
	// priority - held low if no aux
	assign cus43_8n_pr_in = 0; //J5[5] ? { J5[15], J5[14], J5[13] } : 3'b0;	
	// color - from backcolor latch if no aux
	assign cus43_8n_cl_in = 0; //J5[5] ? { J5[4], J5[17], J5[3], J5[18], J5[2], J5[19], J5[1], J5[20] } : ls374_8h_q;
	// dt - held high if no aux
	assign cus43_8n_dt_in = 0; //J5[5] ? { J5[8], J5[9], J5[10] } : 3'b1;		
	
	// tile generator
	cus43 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK[1:0]),
			.LAYER_A_PRIORITY(BACKGROUND_LAYER_PRIORITY),
			.LAYER_B_PRIORITY(FOREGROUND_LAYER_PRIORITY)
		)
		cus43_8n
		(
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.PRI( cus43_8n_pr_in ),
			.CLI( cus43_8n_cl_in ),
			.DTI( cus43_8n_dt_in ),
			.GDI( { ls158_7u_y, eprom_7r_data } ),
			.MDI( sram_7n_data ),
			.CA(A[2:0]),
			.nWE(nWE),
			.LATCH(nLATCH0),
			.FLIP(FLIP),
			.PRO(PR),
			.CLO(CL),
			.DTO(DT),
			.HA2(cus42_7k_ha2),
			.HB2(cus42_7k_hb2)
		);
		
	// == Layer 3 & 4 =
	
	// tile address generator
	cus42 CUS42_5K(
			.rst(rst),
			
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_2H), 
			.FLIP(FLIP),
			.nHSYNC(nHSYNC),
			.nVSYNC(nVSYNC),
			.nGCS(1'b1),	// held high (inactive) on schematics
			.nRCS(nSCROLL1),
			.nLATCH(nLATCH1),
			.CA( { 1'b0, A[12:0] } ),
			.nWE(nWE),
			.CD(D),
			.GA(cus42_5k_ga),
			.nRWE(sram_4n_we_n),
			.nROE(sram_4n_oe_n),
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
			.A(eprom_4s_data[7:4]),
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
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.PRI(PR),
			.CLI(CL),
			.DTI(DT),
			.GDI( { ls158_5u_y, eprom_4r_data } ),
			.MDI( sram_4n_data ),
			.CA(A[2:0]),
			.nWE(nWE),
			.LATCH(nLATCH1),
			.FLIP(FLIP),
			.PRO(cus43_6n_pro),
			.CLO(cus43_6n_clo),
			.DTO(cus43_6n_dto),
			.HA2(cus42_5k_ha2),
			.HB2(cus42_5k_hb2)
		);
	
	// to auxillary color drivers over J5
	assign J5[6] = nBACKCOLOR;

	//assign sram_7n_ce_n = 1'b0;
	assign DOT = prom_4v_data;
endmodule
