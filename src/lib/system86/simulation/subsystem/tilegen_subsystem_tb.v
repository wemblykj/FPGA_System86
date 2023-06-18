`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    18:27:25 05/30/2018
// Design Name:    tilegen_tb
// Module Name:    system86/simulation/test_bench/tilegen_tb.v
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

module tilegen_subsystem_tb;

	reg clk_in;
	reg rst_n;
	
	// Inputs
	reg nSCROLL0;
	reg nSCROLL1;
	reg nLATCH0;
	reg nLATCH1;
	reg BANK;
	reg FLIP;
	reg SRCWIN;
	reg nBACKCOLOR;
	reg [12:0] A;
	reg RnW;
	reg [7:0] MD;	// sub CPU data bus

	// Outputs
	wire [2:0] SPR;
	wire [7:0] DOT;

	// Bidirs
	reg [7:0] DIn;			// mutliplexed CPU databus
	wire [7:0] D = DIn;	// multiplexed databus	
	wire [20:1] J5;

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire CLK_6M;
	wire CLK_1H;
	wire CLK_2H;
	
	wire [3:0] R;
	wire [3:0] G;
	wire [3:0] B;
	wire nHSYNC;
	wire nVSYNC;
	wire nHBLANK;
	wire nVBLANK;
	
	`PROM_WIRE_DEFS(MB7124, prom_3r);
	`PROM_WIRE_DEFS(MB7116, prom_3s);
	
	`PROM_WIRE_DEFS(MB7138, prom_4v);
	`PROM_WIRE_DEFS(MB7112, prom_6u);
	
	`EPROM_WIRE_DEFS(M27512, eprom_4r);
	`EPROM_WIRE_DEFS(M27256, eprom_4s);
	`EPROM_WIRE_DEFS(M27512, eprom_7r);
	`EPROM_WIRE_DEFS(M27256, eprom_7s);
	
	`SRAM_WIRE_DEFS(CY6264, sram_4n);
	`SRAM_WIRE_DEFS(CY6264, sram_7n);
	
	prom_mb7116 
		#(
			`ROM_3S
		) 
			prom_3s
		(
			.nE(prom_3s_ce_n), 
			.A(prom_3s_addr), 
			.Q(prom_3s_data)
		);
			
	prom_mb7124 
		#(
			`ROM_3R
		)
		prom_3r
		(
			.nE(prom_3r_ce_n), 
			.A(prom_3r_addr), 
			.Q(prom_3r_data)
		);	
		
	prom_mb7112 
		#(
			`ROM_6U
		) 
		prom_6u
		(
			.nE(1'b0), 
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
			.nE(1'b0), 
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
			.nE(1'b0), 
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
			.nE(1'b0), 
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
			.nE(1'b0), 
			.nG(1'b0), 
			.A(eprom_7s_addr), 
			.Q(eprom_7s_data)
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
			.nWE(sram_4n_we_n),
			.nOE(sram_4n_oe_n),
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
			.nWE(sram_7n_we_n),
			.nOE(sram_7n_oe_n),
			.A(sram_7n_addr),
			.D(sram_7n_data)
		);
	
	// Timing subsystem
	timing_subsystem timing(
	   .rst_n(rst_n),
		.CLK_48M(clk_in),
		.CLK_6M(CLK_6M),
		.nVSYNC(nVSYNC),
		.nHSYNC(nHSYNC),
		.nHBLANK(nHBLANK),
		.nVBLANK(nVBLANK),
		.nVRESET(nVRESET),
		.nCOMPSYNC(nCOMPSYNC),
		.CLK_1H(CLK_1H),
		.CLK_2H(CLK_2H)
	);
	
	videogen_subsystem 
		//#() 
		clut(
		.rst_n(rst_n),
		// input
		.CLK_6MD(CLK_6M), 
		.nCLR(VCC), //.CLR(ls174_6v_q6), 
		.D(DOT), 
		.BANK(BANK), //.BANK(ls174_9v_q5) // sprite/tile select, 
		// output
		.RED(R), 
		.GREEN(G), 
		.BLUE(B),
		
		// == hardware abstraction - memory buses ==
		`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
		`PROM_CONNECTION_DEFS(prom_3s, prom_3s)
		);
		
		
	// Instantiate the Unit Under Test (UUT)
	tilegen_subsystem 
		uut
		(
			.rst_n(rst_n),
			.CLK_6M(CLK_6M), 
			.CLK_2H(CLK_2H), 
			.nSCROLL0(nSCROLL0), 
			.nSCROLL1(nSCROLL1), 
			.nLATCH0(nLATCH0), 
			.nLATCH1(nLATCH1), 
			.nHSYNC(nHSYNC), 
			.nVSYNC(nVSYNC), 
			.FLIP(FLIP), 
			.SRCWIN(SRCWIN), 
			.nBACKCOLOR(nBACKCOLOR), 
			.A(A), 
			.RnW(RnW),
			.MD(MD), 
			.D(D), 
			.J5(J5), 
			.SPR(SPR), 
			.DOT(DOT),
			
			// == hardware abstraction - memory buses ==
			`EPROM_CONNECTION_DEFS(eprom_4r, eprom_4r),
			`EPROM_CONNECTION_DEFS(eprom_4s, eprom_4s),
			`PROM_CONNECTION_DEFS(prom_4v, prom_4v),
			`PROM_CONNECTION_DEFS(prom_6u, prom_6u),
			`EPROM_CONNECTION_DEFS(eprom_7r, eprom_7r),
			`EPROM_CONNECTION_DEFS(eprom_7s, eprom_7s),
			`SRAM_CONNECTION_DEFS(sram_4n, sram_4n),
			`SRAM_CONNECTION_DEFS(sram_7n, sram_7n)
		);
	
	Video_Logger
		#(
			.C_COMPONENT_DEPTH(4),
			.C_FILE_NAME("tileget_subsystem.txt")
		)
		vga_logger (
			.i_nRst(~rst_n),
			.i_Clk(CLK_6M),
			.i_OutputEnable(rst_n),
			.i_Red(R),
			.i_Green(G),
			.i_Blue(B),
			.i_nHSync(nHSYNC),
			.i_nVSync(nVSYNC)
		);
	
	reg [8:0] hScrollOffset = 0;
	integer frame_count = 0;
	
	initial begin
		rst_n = 0;
		clk_in = 0;
		hScrollOffset = 0;
		frame_count = 0;
		
		// Initialize Inputs
		nSCROLL0 = 1;
		nSCROLL1 = 1;
		nLATCH0 = 1;
		nLATCH1 = 1;
		FLIP = 0;
		BANK = 0;
		SRCWIN = 0;
		nBACKCOLOR = 1;
		A = 0;
		RnW = 1;
		DIn = 0;
		MD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		rst_n = 1;
	end
    
	always begin
		#10.1725 clk_in = ~clk_in;
	end
	
	always @(negedge nVBLANK) begin
		if (rst_n) begin
			frame_count <= frame_count + 1;
			
			hScrollOffset = hScrollOffset + 1;
			
			DIn = hScrollOffset[7:0];
			A = 0;
			#10 nLATCH0 = 0;
			#10 nLATCH0 = 1;
			
			DIn = { 7'b0, hScrollOffset[8] };
			A = 1;
			#10 nLATCH0 = 0;
			#10 nLATCH0 = 1;
			
			if (frame_count > 16) begin
				rst_n = 0;
				#10
				$stop;
			end
		end
	end
	
endmodule

