`timescale 1ns/1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    19:43:02 06/12/2018
// Design Name:    TILEGEN
// Module Name:    system86/tilegen_single_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TILEGEN
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module tilegen_single_tb(

	);

	// Inputs
	reg clk_in;
	reg rst;
	wire [7:0] R;
	wire [7:0] G;
	wire [7:0] B;
	wire HSYNC;
	wire VSYNC;
	
	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire CLK_6M;
	wire CLK_2H;
	
	// Timing subsystem
	TIMING TIMING(
		.CLK_48M(clk_in),
		.CLK_6M(CLK_6M),
		.VSYNC(VSYNC),
		.HSYNC(HSYNC),
		.HBLANK(HBLANK),
		.VBLANK(VBLANK),
		.VRESET(VRESET),
		.COMPSYNC(COMPSYNC),
		.CLK_2H(CLK_2H)
	);
	
	// Inputs
	
	reg SCROLL0;
	//reg SCROLL1;
	reg LATCH0;
	//reg LATCH1;
	reg FLIP;	
	reg BANK;
	reg SRCWIN;
	reg BACKCOLOR;
	reg [12:0] A;
	reg WE;
	
	// Outputs
	wire [2:0] SPR;
	wire [7:0] DOT;

	// Bidirs
	wire [7:0] D;
	
	integer rgb_fd;

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
	wire cus42_7k_ha2;
	wire cus42_7k_hb2;
	
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
	// tile map color index
	wire [7:0] prom_4v_d;	
		
	// tile address decoder (used at runtime) 0x1400 - 0x0020
	// possibly similar functionality to system 1 functionality as described in Mame
	PROM_7112 #("roms/rt1-5.6u") PROM_6U(
		.E(VCC), 
		.A( { CLK_2H, cus42_7k_ga[13:12], GND, GND } ), 
		.Q(prom_6u_d));
	
	// tile map palette prom
	PROM_7138 #("roms/rt1-3.4v") PROM_4V(
		.E(VCC), //.CE(SCRWIN), 
		.A( { CL, DT } ), 
		.Q(prom_4v_d));
	
	CUS42 CUS42_7K(
		// inputs
		.CLK_6M(CLK_6M), 
		.CLK_2H(CLK_2H), 
		.HSYNC(HSYNC),
		.VSYNC(VSYNC),
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
		.ROE(cus42_7k_roe),
		.HA2(cus42_7k_ha2),
		.HB2(cus42_7k_hb2)
		);
	
	// tile ram
	CY6264 #("snapshot/rthunder_videoram1_2.bin") CY6264_7N(
		.CE1(VCC),
		.CE2(VCC),
		.WE(cus42_7k_rwe),
		.OE(cus42_7k_roe),
		.A(cus42_7k_ra),
		.D(cus42_7k_rd)
		);
	
	// plane 1/2 0x00000 0x10000
	EPROM_27512 #("roms/rt1_7.7r") EPROM_7R(
		.E(VCC), 
		.G(VCC), 
		.A( { BANK, prom_6u_d[3:1], cus42_7k_ga[11:0] } ), 
		.Q(prom_7r_d));
		
	// plane 3 0x10000 0x80000
	EPROM_27256 #("roms/rt1_8.7s") EPROM_7S(
		.E(VCC), 
		.G(VCC), 
		.A( { BANK, prom_6u_d[3:1], cus42_7k_ga[11:1] } ), 
		.Q(prom_7s_d));	
	
	wire [3:0] ls158_7u_y;
	LS158 ls158_7u(
			.G( ~prom_6u_d[0]),
			.SELA(~cus42_7k_ga[0]),
			.A(prom_7s_d[7:4]),
			.B(prom_7s_d[3:0]),
			.Y(ls158_7u_y)
		);
	// tile generator
	CUS43 CUS43_8N(
		.CLK_6M(CLK_6M),
		.CLK_2H(CLK_2H),
		.PRI( 3'b0 ),
		.CLI( 8'b0 ),
		.DTI( 3'b0 ),
		.GDI( { ls158_7u_y, prom_7r_d } ),
		.MDI( cus42_7k_rd ),
		.CA(A[2:0]),
		.WE(WE),
		.LATCH(LATCH0),
		.FLIP(FLIP),
		.PRO(PR),
		.CLO(CL),
		.DTO(DT),
		.HA2(cus42_7k_ha2),
		.HB2(cus42_7k_hb2)
		);
		
	CLUT #("roms/rt1-1.3r", "roms/rt1-2.3s") CLUT(
		// input
		.CLK_6M(CLK_6M), 
		.CLR(GND), //.CLR(ls174_6v_q6), 
		.D(prom_4v_d), 
		.BANK(GND), //.BANK(ls174_9v_q5), 
		// output
		.R(R), 
		.G(G), 
		.B(B)
		);
		
	initial begin
		// Initialize Inputs
		clk_in = 0;
		SCROLL0 = 0;
		LATCH0 = 0;
		FLIP = 0;
		BANK = 0;
		SRCWIN = 0;
		BACKCOLOR = 0;
		A = 0;
		WE = 0;
		
		rgb_fd = $fopen("tilegen_single.txt", "w");

		rst = 1;
		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
        
		// Add stimulus here
		#40_000_000;
		rst = 1;
		$fclose(rgb_fd);
		$finish;

	end
	
	always begin
		#10.1725 clk_in = ~clk_in;
	end
      
	always @(posedge CLK_6M) begin
		if (!rst) begin
			$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, HSYNC, VSYNC, R, G, B);
		end
	end
	
endmodule

