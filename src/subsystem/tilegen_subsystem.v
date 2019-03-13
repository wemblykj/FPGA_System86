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

`include "common/defines.vh"

module tilegen_subsystem
	#(
	)
	(
		input wire CLK_6M,
		input wire CLK_2H,
		input wire SCROLL0,
		input wire SCROLL1,
		input wire LATCH0,
		input wire LATCH1,
		input wire HSYNC,
		input wire VSYNC,
		input wire FLIP,
		input wire SRCWIN,
		input wire BANK,
		input wire BACKCOLOR,
		input wire [12:0] A,
		input wire WE,
		input wire [7:0] MD,
		inout wire [7:0] D,
		inout wire [20:1] J5,
		output wire [2:0] SPR,
		output wire [7:0] DOT, 
        
        // == hardware abstraction - memory buses ==
        
        input wire [7:0] eeprom_4r_data,
        output wire [15:0] eeprom_4r_addr,
        output wire eeprom_4r_ce,
        
        input wire [7:0] eeprom_4s_data,
        output wire [14:0] eeprom_4s_addr,
        output wire eeprom_4s_ce,
        
        input wire [7:0] prom_4v_data,
        output wire [10:0] prom_4v_addr,
        output wire prom_4v_ce,
        
        input wire [7:0] prom_6u_data,
        output wire [4:0] prom_6u_addr,
        output wire prom_6u_ce,
        
        input wire [7:0] eeprom_7r_data,
        output wire [16:0] eeprom_7r_addr,
        output wire eeprom_7r_ce,
        
        input wire [7:0] eeprom_7s_data,
        output wire [15:0] eeprom_7s_addr,
        output wire eeprom_7s_ce,
        
        inout wire [7:0] sram_4n_data,
        output wire [12:0] sram_4n_addr,
        output wire sram_4n_ce,
        output wire sram_4n_we,
        output wire sram_4n_oe,
        
        inout wire [7:0] sram_7n_data,
        output wire [12:0] sram_7n_addr,
        output wire sram_7n_ce,
        output wire sram_7n_we,
        output wire sram_7n_oe
    );

	
	// CUS43 inter-connects
	wire [2:0] PR;		// 'attr' in MAME - transparancy - default can be overridden from diagnosics P5?
	wire [7:0] CL;		//	not sure maybe color - certainly defaulted to background color
	wire [2:0] DT;		// not sure - defaults from J5 and pulled up high - maps to A0-A2 of tilemap clut.
	
	// == Layer 1 & 2 =
	
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
	LS374 LS374_8H(
			.OC(~J5[5]),		// disable background color driver from auxillary driver over J5
			.CLK(~BACKCOLOR),	// latches on negative edge
			.D(MD),
			.Q(ls374_8h_q)
		);
	
    // tile address decoder (used at runtime) 0x1400 - 0x0020
	// possibly similar functionality to system 1 functionality as described in Mame	
    assign prom_6u_addr = { CLK_2H, cus42_7k_ga[13:12], cus42_5k_ga[13:12] };
    assign prom_6u_ce = VCC;
	
    // tile map palette prom
    assign prom_4v_addr = { cus43_6n_clo, cus43_6n_dto };
    assign prom_4v_ce = VCC;  // SCRWIN
    
	// == Layer 1 & 2 =
	
	CUS42 CUS42_7K(
			// inputs
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_2H), 
			.RCS(SCROLL0),
			.GCS(GND),	// held high (inactive) on schematics
			.LATCH(LATCH0),
			.CA( { GND, A[12:0] } ),
			.WE(WE),
			.CD(D),
			// outputs
			.GA(cus42_7k_ga),
			.RA(cus42_7k_ra),
			.RWE(cus42_7k_rwe),
			.RD(cus42_7k_rd),
			.ROE(cus42_7k_roe)
		);
	
	// tile ram
	CY6264 CY6264_7N(
			.CE1(VCC),
			.CE2(VCC),
			.WE(cus42_7k_rwe),
			.OE(cus42_7k_roe),
			.A(cus42_7k_ra),
			.D(cus42_7k_rd)
		);
	
    // layer 1/2 - red and green channels (4-bit per channel)
	assign eeprom_7r_addr = { BANK, prom_6u_data[3:1], cus42_7k_ga[11:0] };
    assign eeprom_7r_ce = VCC;
    
    // layer 1/2 - blue channel (4-bit per channel with two pixels per address)
    assign eeprom_7s_addr = { BANK, prom_6u_data[3:1], cus42_7k_ga[11:1] };
    assign eeprom_7s_ce = VCC;
    
    LS158 ls158();
	
	// auxillary select
	wire [2:0] cus43_8n_pr_in;
	wire [7:0] cus43_8n_cl_in;
	wire [2:0] cus43_8n_dt_in;
	// priority - held low if no aux
	assign cus43_8n_pr_in = J5[5] ? { J5[15], J5[14], J5[13] } : 3'b0;	
	// color - from backcolor latch if no aux
	assign cus43_8n_cl_in = J5[5] ? { J5[4], J5[17], J5[3], J5[18], J5[2], J5[19], J5[1], J5[20] } : ls374_8h_q;
	// dt - held high if no aux
	assign cus43_8n_dt_in = J5[5] ? { J5[8], J5[9], J5[10] } : 3'b1;		
	
	// tile generator
	CUS43 CUS43_8N(
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.PRI( cus43_8n_pr_in ),
			.CLI( cus43_8n_cl_in ),
			.DTI( cus43_8n_dt_in ),
			.CA(A[2:0]),
			.WE(WE),
			.LATCH(LATCH0),
			.FLIP(FLIP),
			.PRO(PR),
			.CLO(CL),
			.DTO(DT)
		);
		
	// == Layer 3 & 4 =
	
	// tile address generator
	CUS42 CUS42_5K(
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_2H), 
			.HSYNC(HSYNC),
			.VSYNC(VSYNC),
			.GCS(GND),	// held high (inactive) on schematics
			.RCS(SCROLL1),
			.LATCH(LATCH1),
			.CA( { GND, A[12:0] } ),
			.WE(WE),
			.CD(D),
			.GA(cus42_5k_ga),
			.RWE(cus42_5k_rwe),
			.ROE(cus42_5k_roe),
			.RA(cus42_5k_ra),
			.RD(cus42_5k_rd)
		);
		
	// tile ram 1
	CY6264 CY6264_4N(
			.CE1(VCC),
			.CE2(VCC),
			.WE(cus42_5k_rwe),
			.OE(cus42_5k_roe),
			.A(cus42_5k_ra),
			.D(cus42_5k_rd)
		);
	
    // layer 3/4 - red and green channels (4-bit per channel)
	assign eeprom_4r_addr = { prom_6u_data[7:5], cus42_5k_ga[11:0] };
    assign eeprom_4r_ce = VCC;
    
    // layer 3/4 - blue channel (4-bit per channel with two pixels per address)
    assign eeprom_4s_addr = { prom_6u_data[7:5], cus42_5k_ga[11:1] };
    assign eeprom_4s_ce = VCC;
    
	// tile generator
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
	
	// to auxillary color drivers over J5
	assign J5[6] = ~BACKCOLOR;

endmodule
