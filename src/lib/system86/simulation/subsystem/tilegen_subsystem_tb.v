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

	reg s86_48M;
	reg _rst_n;
	
	// Inputs
	reg s86_bSCROLL0;
	reg s86_bSCROLL1;
	reg s86_bLATCH0;
	reg s86_bLATCH1;
	reg s86_BANK;
	reg s86_FLIP;
	reg s86_SCRWIN;
	reg s86_bBACKCOLOR;
	reg [12:0] s86_A;
	reg s86_RbW;
	reg [7:0] s86_MD;	// sub CPU data bus

	// Outputs
	wire [2:0] s86_SPR;
	wire [7:0] s86_DOT;

	// Bidirs
	reg [7:0] DIn;			// mutliplexed CPU databus
	wire [7:0] s86_D = DIn;	// multiplexed databus	
	wire [20:1] s86_J5;

	// == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	wire s86_6M;
	wire s86_1H;
	wire s86_2H;
	
	wire [3:0] s86_R;
	wire [3:0] s86_G;
	wire [3:0] s86_B;
	wire s86_bHSYNC;
	wire s86_bVSYNC;
	wire s86_bHBLANK;
	wire s86_bVBLANK;
	
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
	
	// Timing subsystem
	timing_subsystem timing(
	   ._rst_ni(_rst_n),
		.s86_48M_i(s86_48M),
		.s86_6M_o(s86_6M),
		.s86_bVSYNC_o(s86_bVSYNC),
		.s86_bHSYNC_o(s86_bHSYNC),
		.s86_bHBLANK_o(s86_bHBLANK),
		.s86_bVBLANK_o(s86_bVBLANK),
		.s86_bVRESET_o(s86_bVRESET),
		.s86_bCOMPSYNC_o(s86_bCOMPSYNC),
		.s86_1H_o(s86_1H),
		.s86_2H_o(s86_2H)
	);
	
	videogen_subsystem 
		//#() 
		clut(
		._rst_ni(_rst_n),
		// input
		.s86_6MD_i(s86_6M), 
		.s86_bCLR_i(VCC), //.CLR(ls174_6v_q6), 
		.s86_D_i(s86_DOT), 
		.s86_BANK_i(s86_BANK), //.s86_BANK(ls174_9v_q5) // sprite/tile select, 
		// output
		.s86_RED_o(s86_R), 
		.s86_GREEN_o(s86_G), 
		.s86_BLUE_o(s86_B),
		
		// == hardware abstraction - memory buses ==
		`PROM_CONNECTION_DEFS(prom_3r, prom_3r),
		`PROM_CONNECTION_DEFS(prom_3s, prom_3s)
		);
		
		
	// Instantiate the Unit Under Test (UUT)
	tilegen_subsystem 
		uut
		(
			._rst_ni(_rst_n),
			.s86_6M_i(s86_6M), 
			.s86_2H_i(s86_2H), 
			.s86_bSCROLL0_i(s86_bSCROLL0), 
			.s86_bSCROLL1_i(s86_bSCROLL1), 
			.s86_bLATCH0_i(s86_bLATCH0), 
			.s86_bLATCH1_i(s86_bLATCH1), 
			.s86_bHSYNC_i(s86_bHSYNC), 
			.s86_bVSYNC_i(s86_bVSYNC), 
			.s86_FLIP_i(s86_FLIP), 
			.s86_SCRWIN_i(s86_SCRWIN), 
			.s86_bBACKCOLOR_i(s86_bBACKCOLOR), 
			.s86_A_i(A), 
			.s86_RbW_i(s86_RbW),
			.s86_MD_i(s86_MD), 
			.s86_D_o(D), 
			.s86_J5_o(J5), 
			.s86_SPR_o(s86_SPR), 
			.s86_DOT_o(s86_DOT),
			
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
			.i_nRst(~_rst_n),
			.i_Clk(s86_6M),
			.i_OutputEnable(_rst_n),
			.i_Red(R),
			.i_Green(G),
			.i_Blue(B),
			.i_nHSync(bHSYNC),
			.i_nVSync(bVSYNC)
		);
	
	reg [8:0] hScrollOffset = 0;
	integer frame_count = 0;
	
	initial begin
		_rst_n = 0;
		s86_48M = 0;
		hScrollOffset = 0;
		frame_count = 0;
		
		// Initialize Inputs
		s86_bSCROLL0 = 1;
		s86_bSCROLL1 = 1;
		s86_bLATCH0 = 1;
		s86_bLATCH1 = 1;
		s86_FLIP = 0;
		s86_BANK = 0;
		s86_SCRWIN = 0;
		s86_bBACKCOLOR = 1;
		s86_A = 0;
		s86_RbW = 1;
		DIn = 0;
		s86_MD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_n = 1;
	end
    
	always begin
		#10.1725 s86_48M = ~s86_48M;
	end
	
	always @(negedge bVBLANK) begin
		if (_rst_n) begin
			frame_count <= frame_count + 1;
			
			hScrollOffset = hScrollOffset + 1;
			
			DIn = hScrollOffset[7:0];
			s86_A = 0;
			#10 s86_bLATCH0 = 0;
			#10 s86_bLATCH0 = 1;
			
			DIn = { 7'b0, hScrollOffset[8] };
			A = 1;
			#10 s86_bLATCH0 = 0;
			#10 s86_bLATCH0 = 1;
			
			if (frame_count > 16) begin
				_rst_n = 0;
				#10
				$stop;
			end
		end
	end
	
endmodule

