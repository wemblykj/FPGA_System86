`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:02:48 05/28/2018 
// Design Name: 
// Module Name:    tile_generator 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module TILEGEN(
    input CLK_6M,
    input CLK_2H,
    input SCROLL0,
    input SCROLL1,
    input LATCH0,
    input LATCH1,
    input HSYNC,
    input VSYNC,
    input FLIP,
	 input SRCWIN,
	 input BACKCOLOR,
	 input [12:0] A,
	 input WE,
    input [7:0] MD,
	 inout [7:0] D,
    inout [20:1] J5,
    output [2:0] SPR,
    output [7:0] DOT
    );

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
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
	
	wire [7:0] prom_6u_d;
	
	// plane 1 (bit 0) & 2 (bit 1)
	// b7 - Pixel 4 bit 1
	// b6 - Pixel 3 bit 1
	// b5 - Pixel 2 bit 1
	// b4 - Pixel 1 bit 1
	// b3 - Pixel 4 bit 0
	// b2 - Pixel 3 bit 0
	// b1 - Pixel 2 bit 0
	// b0 - Pixel 1 bit 0
	wire [7:0] prom_7r_d;
	
	// plane 2 (bit 2)
	// b7 - Pixel 8 bit 2
	// b6 - Pixel 7 bit 2
	// b5 - Pixel 6 bit 2
	// b4 - Pixel 5 bit 2
	// b3 - Pixel 4 bit 2
	// b2 - Pixel 3 bit 2
	// b1 - Pixel 2 bit 2
	// b0 - Pixel 1 bit 2
	wire [7:0] prom_7s_d;
	
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
	wire [7:0] prom_4r_d;	
	// plane 2 (bit 2)
	// b7 - Pixel 8 bit 2
	// b6 - Pixel 7 bit 2
	// b5 - Pixel 6 bit 2
	// b4 - Pixel 5 bit 2
	// b3 - Pixel 4 bit 2
	// b2 - Pixel 3 bit 2
	// b1 - Pixel 2 bit 2
	// b0 - Pixel 1 bit 2
	wire [7:0] prom_4s_d;	
	// tile map color index
	wire [7:0] prom_4v_d;	
	
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
	PROM_FILE #(5, 8, "roms/rt1-5.6u") EEPROM_6U(
		.OE(VCC),
		.CE(VCC), 
		.A( { CLK_2H, cus42_7k_ga[13:12], cus42_5k_ga[13:12] } ), 
		.Q(prom_6u_d));
	
	// tile map palette prom
	PROM_FILE #(11, 8, "roms/rt1-3.4v") PROM_4V(
		.OE(VCC),
		.CE(VCC), //.CE(SCRWIN), 
		.A( { cus43_6n_clo, cus43_6n_dto } ), 
		.Q(prom_4v_d));
	
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
		.CE(VCC),
		.WE(cus42_7k_rwe),
		.OE(cus42_7k_roe),
		.A(cus42_7k_ra),
		.D(cus42_7k_rd)
		);
	
	// plane 1/2 0x00000 0x10000
	PROM_FILE #(15, 8, "roms/rt1_7.7r") EEPROM_7R(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[3:1], cus42_7k_ga[11:0] } ), 
		.Q(prom_7r_d));
		
	LS158 ls158();
	
	// plane 3 0x10000 0x80000
	PROM_FILE #(14, 8, "roms/rt1_8.7s") EEPROM_7S(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[3:1], cus42_7k_ga[11:1] } ), 
		.Q(prom_7s_d));	
	
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
		.CE(VCC),
		.WE(cus42_5k_rwe),
		.OE(cus42_5k_roe),
		.A(cus42_5k_ra),
		.D(cus42_5k_rd)
		);
	
	// plane 1/2 0x00000 (0x08000)
	PROM_FILE #(15, 8, "roms/rt1_5.4r") EEPROM_4R(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[7:5], cus42_5k_ga[11:0] } ), 
		.Q(prom_4r_d));
		
	// plane 3 0x08000 (0x04000) 
	PROM_FILE #(14, 8, "roms/rt1_6.4s") EEPROM_4S(
		.OE(VCC),
		.CE(VCC), 
		.A( { prom_6u_d[7:5], cus42_5k_ga[11:1] } ), 
		.Q(prom_4s_d));
	
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
