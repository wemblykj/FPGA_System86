`timescale 1ns/1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    19:43:02 06/12/2018
// Design Name:    tilegen_single_tb
// Module Name:    system86/simulation/test_bench/tilegen_single_tb.v
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

`include "ttl_mem/mb7112.vh"
`include "ttl_mem/mb7116.vh"
`include "ttl_mem/mb7124.vh"
`include "ttl_mem/mb7138.vh"

`include "ttl_mem/m27512.vh"
`include "ttl_mem/m27256.vh"

`include "ttl_mem/cy6264.vh"
`include "ttl_mem/m58725.vh"

`include "ttl_mem/ttl_mem.vh"

//`define ROM_PATH "../../../../../../../../roms"
`define ROM_PATH "../../../../roms"

`include "roms/rthunder.vh"

module tilegen_single_tb
	(
	);

	`PROM_WIRE_DEFS(MB7124, prom_3r);
	`PROM_WIRE_DEFS(MB7116, prom_3s);
	`PROM_WIRE_DEFS(MB7138, prom_4v);
	`PROM_WIRE_DEFS(MB7112, prom_6u);
	
	`EPROM_WIRE_DEFS(M27512, eprom_4r);
	`EPROM_WIRE_DEFS(M27256, eprom_4s);
	`EPROM_WIRE_DEFS(M27512, eprom_7r);
	`EPROM_WIRE_DEFS(M27256, eprom_7s);
	
	`EPROM_WIRE_DEFS(M27256, eprom_9c);
	`EPROM_WIRE_DEFS(M27256, eprom_9d);
	`EPROM_WIRE_DEFS(M27256, eprom_12c);
	`EPROM_WIRE_DEFS(M27256, eprom_12d);
	
	`SRAM_WIRE_DEFS(CY6264, sram_4n);
	`SRAM_WIRE_DEFS(CY6264, sram_7n);
	
	`SRAM_WIRE_DEFS(CY6264, sram_10m);
	`SRAM_WIRE_DEFS(M58725, sram_11k);
	
	// Inputs
	reg clk_in;
	reg _rst_n;
	
	wire [3:0] R;
	wire [3:0] G;
	wire [3:0] B;
	wire bHSYNC;
	wire bVSYNC;
	
	reg [8:0] hScrollOffset = 0;
	
	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire s86_6M;
	wire s86_1H;
	wire s86_2H;
	
	// Timing subsystem
	timing_subsystem timing(
	   ._rst_n(_rst_n),
		.CLK_48M(clk_in),
		.s86_6M(s86_6M),
		.bVSYNC(bVSYNC),
		.bHSYNC(bHSYNC),
		.bHBLANK(bHBLANK),
		.bVBLANK(bVBLANK),
		.nVRESET(nVRESET),
		.nCOMPSYNC(nCOMPSYNC),
		.s86_1H(s86_1H),
		.s86_2H(s86_2H)
	);
	
	/*VIDGEN vidgen(
		.RIn(R),
		.GIn(G),
		.BIn(B),
		.R(ROut),
		.G(GOut),
		.B(BOut)
	);*/
	
	// Inputs
	
	reg nSCROLL0;
	//reg SCROLL1;
	reg nLATCH0;
	//reg LATCH1;
	reg FLIP;	
	reg BANK;
	reg SRCWIN;
	reg BACKCOLOR;
	reg [12:0] A;
	reg bWE;
	
	// Outputs
	wire [2:0] SPR;
	wire [7:0] DOT;

	// Bidirs
	reg [7:0] DIn;
	wire [7:0] D = DIn;
	
	integer rgb_fd;

	// CUS43 inter-connects
	wire [2:0] PR;		// 'attr' in MAME - transparancy - default can be overridden from diagnosics P5?
	wire [7:0] CL;		//	not sure maybe color - certainly defaulted to background color
	wire [2:0] DT;		// not sure - defaults from J5 and pulled up high - maps to A0-A2 of tilemap clut.
	
	// == Layer 1 & 2 =
	
	wire layer = s86_2H;
	wire [13:0] cus42_7k_ga;
	wire cus42_7k_rwe_n;
	wire cus42_7k_roe_n;
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
	
	cus42 CUS42_7K(
		// inputs
		.s86_6M(s86_6M), 
		.s86_2H(s86_2H), 
		.bHSYNC(bHSYNC),
		.bVSYNC(bVSYNC),
		.nRCS(nSCROLL0),
		.nGCS(GND),	// held high (inactive) on schematics
		.nLATCH(nLATCH0),
		.CA( { GND, A[12:0] } ),
		.s86_RbW(bWE),
		.CD(D),
		// outputs
		.GA(cus42_7k_ga),
		.RA(cus42_7k_ra),
		.bRWE(cus42_7k_rwe_n),
		.RD(cus42_7k_rd),
		.bROE(cus42_7k_roe_n),
		.HA2(cus42_7k_ha2),
		.HB2(cus42_7k_hb2)
		);
	
	wire [3:0] ls158_7u_y;
	ls158 ls158_7u(
			.nG(prom_6u_d[0]),
			.nSELA(cus42_7k_ga[0]),
			.A(prom_7s_d[7:4]),
			.B(prom_7s_d[3:0]),
			.Y(ls158_7u_y)
		);
	// tile generator
	cus43 CUS43_8N(
		.s86_6M(s86_6M),
		.s86_2H(s86_2H),
		.PRI( 3'b0 ),
		.CLI( 8'b0 ),
		.DTI( 3'b0 ),
		.GDI( { ls158_7u_y, prom_7r_d } ),
		.MDI( cus42_7k_rd ),
		.CA(A[2:0]),
		.s86_RbW(bWE),
		.nLATCH(nLATCH0),
		.FLIP(FLIP),
		.PRO(PR),
		.CLO(CL),
		.DTO(DT),
		.HA2(cus42_7k_ha2),
		.HB2(cus42_7k_hb2)
		);
		
	videogen_subsystem 
		//#() 
		clut(
		// input
		.s86_6MD(s86_6M), 
		.nCLR(VCC), //.CLR(ls174_6v_q6), 
		.D(prom_4v_d), 
		.BANK(GND), //.BANK(ls174_9v_q5), 
		// output
		.RED(R), 
		.GREEN(G), 
		.BLUE(B),
		
		// == hardware abstraction - memory buses ==
		`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
		`PROM_CONNECTION_DEFS(prom_3s, prom_3s)
		);
		
		prom_mb7116 
		#(
			`ROM_3S
		) 
			prom_3s
		(
			.bE(prom_3s_ce_n), 
			.A(prom_3s_addr), 
			.Q(prom_3s_data)
		);
			
	prom_mb7124 
		#(
			`ROM_3R
		)
		prom_3r
		(
			.bE(prom_3r_ce_n), 
			.A(prom_3r_addr), 
			.Q(prom_3r_data)
		);	
		
	prom_mb7138 
		#(
			`ROM_4V
		) 
		prom_4v
		(
			.bE(1'b0), 
			.A(prom_4v_addr), 
			.Q(prom_4v_data)
		);	
		
	prom_mb7112 
		#(
			`ROM_6U
		) 
		prom_6u
		(
			.bE(1'b0), 
			.A(prom_6u_addr), 
			.Q(prom_6u_data)
		);	
	
	// trying 200ns as per GnG instead of 250ns as documented in Rolling Thunder operators manual
	eprom_m27512 
		#(
			.FILE_NAME(`ROM_4R),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_4r
		(
			.bE(1'b0), 
			.nG(1'b0), 
			.A(eprom_4r_addr), 
			.Q(eprom_4r_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_4S),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_4s
		(
			.bE(1'b0), 
			.nG(1'b0), 
			.A(eprom_4s_addr), 
			.Q(eprom_4s_data)
		);	
	
	eprom_m27512 
		#(
			.FILE_NAME(`ROM_7R),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_7r
		(
			.bE(1'b0), 
			.nG(1'b0), 
			.A(eprom_7r_addr), 
			.Q(eprom_7r_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_7S),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_7s
		(
			.bE(1'b0), 
			.nG(1'b0), 
			.A(eprom_7s_addr), 
			.Q(eprom_7s_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_9C),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_9c
		(
			.bE(eprom_9c_ce_n), 
			.nG(eprom_9c_oe_n), 
			.A(eprom_9c_addr), 
			.Q(eprom_9c_data)
		);	
		
	/* not used for rthunder
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_9D),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_9d
		(
			.bE(eprom_9d_ce_n), 
			.nG(eprom_9d_oe_n), 
			.A(eprom_9d_addr), 
			.Q(eprom_9d_data)
		);	
	*/
	
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_12C),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_12c
		(
			.bE(eprom_12c_ce_n), 
			.nG(eprom_12c_oe_n), 
			.A(eprom_12c_addr), 
			.Q(eprom_12c_data)
		);	
		
	eprom_m27256 
		#(
			.FILE_NAME(`ROM_12D),
			.tAVQV(200),
			.tAXQX(10)
		) 
		eprom_12d
		(
			.bE(eprom_12d_ce_n), 
			.nG(eprom_12d_oe_n), 
			.A(eprom_12d_addr), 
			.Q(eprom_12d_data)
		);	
			
		// tile ram
	sram_cy6264 
		#(
			"../../../../snapshots/rthunder_gfx2_002.bin"
		)
		sram_4n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_4n_we_n),
			.bOE(sram_4n_oe_n),
			.A(sram_4n_addr),
			.D(sram_4n_data)
		);
		
	sram_cy6264 
		#(
			//"../snapshots/rthunder_videoram1_2.bin"
			"../../../../snapshots/rthunder_gfx1_002.bin"
		)
		sram_7n
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_7n_we_n),
			.bOE(sram_7n_oe_n),
			.A(sram_7n_addr),
			.D(sram_7n_data)
		);

	// sprite ram
	sram_cy6264 
		#(
			"../../../../snapshots/rthunder_gfx2_002.bin"
		)
		sram_10m
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_10m_we_n),
			.bOE(sram_10m_oe_n),
			.A(sram_10m_addr),
			.D(sram_10m_data)
		);
		
	sram_m58725 
		#(
			"../../../../snapshots/rthunder_gfx1_002.bin"
		)
		sram_11k
		(
			.nCE1(1'b0),
			.CE2(1'b1),
			.bWE(sram_11k_we_n),
			.bOE(sram_11k_oe_n),
			.A(sram_11k_addr),
			.D(sram_11k_data)
		);
		
	integer frame_count = 0;
	
	initial begin
		// Initialize Inputs
		_rst_n = 0;
		clk_in = 0;
		nSCROLL0 = 0;
		nLATCH0 = 0;
		FLIP = 0;
		BANK = 0;
		SRCWIN = 0;
		BACKCOLOR = 0;
		A = 0;
		bWE = 0;
		
		rgb_fd = $fopen("tilegen_single.txt", "w");
		
		// Wait 100 ns for global reset to finish
		#100;
		_rst_n = 1;
        
		// Add stimulus here
		
		

	end
	
	always begin
		#10.1725 clk_in = ~clk_in;
	end
      
	always @(posedge s86_6M) begin
		if (_rst_n) begin
			$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, bHSYNC, bVSYNC, R, G, B);
		end
	end
	
	always @(negedge bVBLANK) begin
		if (_rst_n) begin
			frame_count <= frame_count + 1;
			
			hScrollOffset = hScrollOffset + 1;
			
			DIn = hScrollOffset[7:0];
			A = 0;
			#10 nLATCH0 = 1;
			#10 nLATCH0 = 0;
			
			DIn = { 7'b0, hScrollOffset[8] };
			A = 1;
			#10 nLATCH0 = 1;
			#10 nLATCH0 = 0;
			
			if (frame_count > 16) begin
				_rst_n = 0;
				$fclose(rgb_fd);
				$stop;
			end
		end
	end
	
endmodule

