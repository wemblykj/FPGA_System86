`timescale 1ns/1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:43:02 06/12/2018
// Design Name:   TILEGEN
// Module Name:   C:/Development/Xilinx/system86/tilegen_single_tb.v
// Project Name:  system86
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
// 
////////////////////////////////////////////////////////////////////////////////

module CUS43_tb(

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
	
	reg BANK = 0;
	reg [2:0] A = 0;
	wire [11:0] GD;
	// Outputs
	wire [2:0] PR;		// 'attr' in MAME - transparancy - default can be overridden from diagnosics P5?
	wire [7:0] CL;		//	not sure maybe color - certainly defaulted to background color
	wire [2:0] DT;		// not sure - defaults from J5 and pulled up high - maps to A0-A2 of tilemap clut.

	integer rgb_fd;

	// == Layer 1 & 2 =
	
	wire [13:0] cus42_7k_ga;
	wire cus42_7k_rwe;
	wire cus42_7k_roe;
	wire [12:0] cus42_7k_ra;
	wire [7:0] MD;
	wire HA2;
	wire cus42_7k_hb2;
	
	// tile map color index
	wire [7:0] prom_4v_d;	
	
		// tile map palette prom
	FPROM_7138 #("roms/rt1-3.4v") PROM_4V(
		.E(VCC), //.CE(SCRWIN), 
		.A( { CL, DT } ), 
		.Q(prom_4v_d));
		
	// tile generator
	CUS43 CUS43_8N(
		.CLK_6M(CLK_6M),
		.CLK_2H(GND),
		.PRI( 3'b0 ),
		.CLI( 8'b0 ),
		.DTI( 3'b0 ),
		.GDI( GD ),
		.MDI( MD ),
		.CA(A[2:0]),
		.WE(GND),
		.LATCH(GND),
		.FLIP(GND),
		.PRO(PR),
		.CLO(CL),
		.DTO(DT),
		.HA2(HA2),
		.HB2(GND)
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
		BANK = 0;
		
		rgb_fd = $fopen("cus43.txt", "w");

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
   
	reg hsyncLast = 0;
	reg vsyncLast = 0;
	reg [9:0] hCounter = 0;
	reg [8:0] vCounter = 0;
	
	wire [3:0] p1 = vCounter[3:0];
	wire [3:0] p2 = vCounter[7:4];
	wire [3:0] p3 = vCounter[11:8];
	
	assign HA2 = hCounter[1:0] === 3'b10;
	// bit plane
	assign GD = { p3, p2, p1 };
	// color
	assign MD = { vCounter[8:3], hCounter[4:3] };
	
	always @(posedge CLK_6M) begin   
		if (!rst) begin
			if (HSYNC && !hsyncLast) begin
				hCounter = 0;
				vCounter = vCounter + 1;
			end else begin
				hCounter = hCounter + 1;
			end
				
			if (VSYNC && !vsyncLast) begin
				vCounter = 0;
			end
			
			hsyncLast = HSYNC;
			vsyncLast = VSYNC;
		end
	end
	
	always @(posedge CLK_6M) begin
		if (!rst) begin
			$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, HSYNC, VSYNC, R, G, B);
		end
	end
	
endmodule

