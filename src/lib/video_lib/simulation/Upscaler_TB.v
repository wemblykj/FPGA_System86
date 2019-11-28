`timescale 1ns/1fs

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:17:46 11/21/2019
// Design Name:   upscaler
// Module Name:   C:/Users/paulw/Development/Arcade/FPGA_System86/src/lib/video_lib/simulation/upscaler_tb.v
// Project Name:  video_lib
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: upscaler
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Upscaler_TB;

	// Namco System86 timings 288x224 (384x264) 6Mhz pixel clock
	parameter TOTAL_COLS = 384;
	parameter TOTAL_ROWS  = 264;
	parameter ACTIVE_COLS = 288;
	parameter ACTIVE_ROWS = 224;
	  
	parameter SYNC_PULSE_HORZ = 32;
	parameter SYNC_PULSE_VERT = 8;
	  
	parameter FRONT_PORCH_HORZ = 32;	// Mame has a 3 pixel offset on these horizontal timings
	parameter BACK_PORCH_HORZ  = 32;	// - this works out as 29 f.p. and 32 b.p.
	parameter FRONT_PORCH_VERT = 24;
	parameter BACK_PORCH_VERT  = 8;
	  
	parameter USE_BLANKING = 1;
	parameter TEST_PATTERN = 4'd4;
	
	parameter LINE_BUFFER_COUNT = 32;
	parameter VERTICAL_SYNC_DELAY = 1;
	parameter SCALE_PRECISION = 6;
	
	parameter COMPONENT_DEPTH = 8;
	parameter NAMCO_PERIOD = 164.569030145202/2.0;//81.3802;
	parameter VGA_PERIOD = 39.7222619047619/2.0; //19.5313; 
	
	// Inputs
	reg rst = 0;
	
	reg clk_6m = 0;
	reg clk_25m = 0;
	
	wire pixel_clk_a;
	wire hsyna;
	wire vsyna;
	wire hblank_a;
	wire vblank_a;
	
	wire pixel_clk_b;
	wire hsynb;
	wire vsynb;
	wire hblank_b;
	wire vblank_b;
	
	wire [COMPONENT_DEPTH-1:0] red_a;
	wire [COMPONENT_DEPTH-1:0] green_a;
	wire [COMPONENT_DEPTH-1:0] blue_a;
	
	// Outputs
	wire o_locked_a;
	wire [11:0] o_width_a;
	wire [11:0] o_height_a;
	wire o_hsynb;
	wire o_vsynb;
	wire o_hblank_b;
	wire o_vblank_b;
	wire o_locked_b;
	wire [11:0] o_width_b;
	wire [11:0] o_height_b;
	wire [COMPONENT_DEPTH-1:0] red_b;
	wire [COMPONENT_DEPTH-1:0] green_b;
	wire [COMPONENT_DEPTH-1:0] blue_b;
	
	// Instantiate the Unit Under Test (UUT)
	Upscaler 
	#( 
		.COMPONENT_DEPTH(COMPONENT_DEPTH),
		.USE_BLANKING_A(USE_BLANKING),
		.USE_BLANKING_B(USE_BLANKING),
		.LINE_BUFFER_SIZE(TOTAL_COLS),
		.LINE_BUFFER_COUNT(LINE_BUFFER_COUNT),
		.VERTICAL_SYNC_DELAY(VERTICAL_SYNC_DELAY),
		.SCALE_PRECISION_WIDTH(SCALE_PRECISION),
		.SCALE_PRECISION_HEIGHT(SCALE_PRECISION))
	uut (
		.i_Rst(rst), 
		.i_ClkA(pixel_clk_a), 
		.i_HSyncA(hsyna), 
		.i_VSyncA(vsyna), 
		.i_HBlankA(hblank_a), 
		.i_VBlankA(vblank_a), 
		.i_RedA(red_a), 
		.i_GreenA(green_a), 
		.i_BlueA(blue_a), 
		.i_ClkB(pixel_clk_b), 
		.i_HSyncB(hsynb), 
		.i_VSyncB(vsynb), 
		.i_HBlankB(hblank_b), 
		.i_VBlankB(vblank_b),
		.o_LockedA(o_locked_a),
		.o_WidthA(o_width_a),
		.o_HeightA(o_height_a),
		.o_HSyncB(o_hsynb), 
		.o_VSyncB(o_vsynb), 
		.o_HBlankB(o_hblank_b), 
		.o_VBlankB(o_vblank_b),
		.o_LockedB(o_locked_b), 
		.o_WidthB(o_width_b),
		.o_HeightB(o_height_b),
		.o_RedB(red_b), 
		.o_GreenB(green_b), 
		.o_BlueB(blue_b)
	);
	
	Video_Logger #( 
		.COMPONENT_DEPTH(COMPONENT_DEPTH),
		.FILE_NAME("vga_vid.txt"))
		vga_logger
		(
			.i_Rst(rst),
			.i_Clk(pixel_clk_b),
			.i_OutputEnable(o_locked_b),
			.i_HSync(o_hsynb),
			.i_VSync(o_vsynb),
			.i_Red(red_b),
			.i_Green(green_b),
			.i_Blue(blue_b)
		);
		
	wire sg_a_locked;
	wire sg_a_hsync;
	wire sg_a_vsync;
	VGA_Sync_Pulses
		#(	.TOTAL_COLS(TOTAL_COLS),
         .TOTAL_ROWS(TOTAL_ROWS),
         .SYNC_PULSE_HORZ(SYNC_PULSE_HORZ),
			.SYNC_PULSE_VERT(SYNC_PULSE_VERT))
		syngen_a (
			.i_Rst(rst),
			.i_Clk(clk_6m),
			.o_Locked(locked),
			.o_HSync(sg_a_hsync),
			.o_VSync(sg_a_vsync)
		);
	
	wire s2b_a_locked;	
	wire s2b_a_hsync;
	wire s2b_a_vsync;
	wire s2b_a_hblank;
	wire s2b_a_vblank;
	Sync_To_Blanking 
		#(	.TOTAL_COLS(TOTAL_COLS),
         .TOTAL_ROWS(TOTAL_ROWS),
         .SYNC_PULSE_HORZ(SYNC_PULSE_HORZ),
			.SYNC_PULSE_VERT(SYNC_PULSE_VERT),
			.FRONT_PORCH_HORZ(FRONT_PORCH_HORZ),
			.BACK_PORCH_HORZ(BACK_PORCH_HORZ),
			.FRONT_PORCH_VERT(FRONT_PORCH_VERT),
			.BACK_PORCH_VERT(BACK_PORCH_VERT))
		sync2blank4_a (
			.i_Rst(rst),
			.i_Clk(clk_6m),
			.i_HSync(sg_a_hsync),
			.i_VSync(sg_a_vsync),
			.o_Locked(s2b_a_locked),
			.o_HSync(s2b_a_hsync),
			.o_VSync(s2b_a_vsync),
			.o_HBlank(s2b_a_hblank),
			.o_VBlank(s2b_a_vblank)
		);	
	
	// Drives Red/Grn/Blue video - Test Pattern 5 (Color Bars)
	wire tpg_a_locked;
	wire tpg_a_hsync;
	wire tpg_a_vsync;
	wire tpg_a_hblank;
	wire tpg_a_vblank;
	wire [COMPONENT_DEPTH-1:0] tpg_a_red;
	wire [COMPONENT_DEPTH-1:0] tpg_a_green;
	wire [COMPONENT_DEPTH-1:0] tpg_a_blue;
	Test_Pattern_Gen  
		#( .COMPONENT_DEPTH(COMPONENT_DEPTH),
			.TOTAL_COLS(TOTAL_COLS),
         .TOTAL_ROWS(TOTAL_ROWS),
         .ACTIVE_COLS(ACTIVE_COLS),
         .ACTIVE_ROWS(ACTIVE_ROWS),
			.USE_BLANKING(USE_BLANKING),
			.SYNC_PULSE_HORZ(SYNC_PULSE_HORZ),
			.SYNC_PULSE_VERT(SYNC_PULSE_VERT),
			.FRONT_PORCH_HORZ(FRONT_PORCH_HORZ),
			.BACK_PORCH_HORZ(BACK_PORCH_HORZ),
			.FRONT_PORCH_VERT(FRONT_PORCH_VERT),
			.BACK_PORCH_VERT(BACK_PORCH_VERT))							 
		tpg_a (
			.i_Rst(rst),
			.i_Clk(clk_6m),
			.i_Pattern(TEST_PATTERN), // 0101 = color bars
			.i_HSync(sg_a_hsync),
			.i_VSync(sg_a_vsync),
			.o_Locked(tpg_a_locked),
			.o_HSync(tpg_a_hsync),
			.o_VSync(tpg_a_vsync),
			.o_HBlank(tpg_a_hblank),
			.o_VBlank(tpg_a_vblank),
			.o_Red_Video(tpg_a_red),
			.o_Grn_Video(tpg_a_green),
			.o_Blu_Video(tpg_a_blue)
			);
	
	Video_Logger #( 
		.COMPONENT_DEPTH(COMPONENT_DEPTH),
		.FILE_NAME("namco_vid.txt"))
		namco_logger
		(
			.i_Rst(rst),
			.i_Clk(pixel_clk_a),
			.i_OutputEnable(tpg_a_locked),
			.i_HSync(tpg_a_hsync),
			.i_VSync(tpg_a_vsync),
			.i_Red(tpg_a_red),
			.i_Green(tpg_a_green),
			.i_Blue(tpg_a_blue)
		);
			
	wire sg_b_locked;
	wire sg_b_hsync;
	wire sg_b_vsync;
	VGA_Sync_Pulses
		syngen_b (
			.i_Rst(rst),
			.i_Clk(clk_25m),
			.o_Locked(sg_b_locked),
			.o_HSync(sg_b_hsync),
			.o_VSync(sg_b_vsync)
		);
		
	wire s2b_b_locked;
	wire s2b_b_hsync;
	wire s2b_b_vsync;
	wire s2b_b_hblank;
	wire s2b_b_vblank;
	Sync_To_Blanking 
		sync2blank4_b (
			.i_Rst(rst),
			.i_Clk(clk_25m),
			.i_HSync(sg_b_hsync),
			.i_VSync(sg_b_vsync),
			.o_Locked(s2b_b_locked),
			.o_HSync(s2b_b_hsync),
			.o_VSync(s2b_b_vsync),
			.o_HBlank(s2b_b_hblank),
			.o_VBlank(s2b_b_vblank)
	);	

	wire tpg_vga_ref_locked;
	wire tpg_vga_ref_hsync;
	wire tpg_vga_ref_vsync;
	wire tpg_vga_ref_hblank;
	wire tpg_vga_ref_vblank;
	wire [COMPONENT_DEPTH-1:0] tpg_vga_ref_red;
	wire [COMPONENT_DEPTH-1:0] tpg_vga_ref_green;
	wire [COMPONENT_DEPTH-1:0] tpg_vga_ref_blue;
	Test_Pattern_Gen  
		#( .COMPONENT_DEPTH(COMPONENT_DEPTH),
			.USE_BLANKING(USE_BLANKING))						 
		tpg_vga_ref (
			.i_Rst(rst),
			.i_Clk(clk_25m),
			.i_Pattern(TEST_PATTERN), // 0101 = color bars
			.i_HSync(s2b_b_hsync),
			.i_VSync(s2b_b_vsync),
			.o_Locked(tpg_vga_ref_locked),
			.o_HSync(tpg_vga_ref_hsync),
			.o_VSync(tpg_vga_ref_vsync),
			.o_HBlank(tpg_vga_ref_hblank),
			.o_VBlank(tpg_vga_ref_vblank),
			.o_Red_Video(tpg_vga_ref_red),
			.o_Grn_Video(tpg_vga_ref_green),
			.o_Blu_Video(tpg_vga_ref_blue)
			);
	
	Video_Logger #( 
		.COMPONENT_DEPTH(COMPONENT_DEPTH),
		.FILE_NAME("vga_ref_vid.txt"))
		vga_ref_logger
		(
			.i_Rst(rst),
			.i_Clk(clk_25m),
			.i_OutputEnable(tpg_vga_ref_locked),
			.i_HSync(tpg_vga_ref_hsync),
			.i_VSync(tpg_vga_ref_vsync),
			.i_Red(tpg_vga_ref_red),
			.i_Green(tpg_vga_ref_green),
			.i_Blue(tpg_vga_ref_blue)
		);
		
	assign pixel_clk_a = clk_6m;
	assign hsyna = tpg_a_hsync;
	assign vsyna = tpg_a_vsync;
	assign hblank_a = tpg_a_hblank;
	assign vblank_a = tpg_a_vblank;

	/*assign pixel_clk_b = clk_6m;
	assign hsynb = tpg_a_hsync;
	assign vsynb = tpg_a_vsync;
	assign hblank_b = tpg_a_hblank;
	assign vblank_b = tpg_a_vblank;
	*/
	
	assign pixel_clk_b = clk_25m;
	assign hsynb = s2b_b_hsync;
	assign vsynb = s2b_b_vsync;
	assign hblank_b = s2b_b_hblank;
	assign vblank_b = s2b_b_vblank;
	
	assign red_a = tpg_a_red;
	assign green_a = tpg_a_green;
	assign blue_a = tpg_a_blue;
	
	integer frame_count = 0;
	
	initial begin
		// Initialize Inputs
		frame_count = 0;
		clk_6m = 0;
		clk_25m = 0;
		rst = 1;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		rst = 0;
		
		// Add stimulus here
		
		

	end

	always @(posedge vsynb) begin
		if (o_locked_b)
			frame_count = frame_count + 1;
	end

	// generate our 6Mhz  clock
	always #NAMCO_PERIOD clk_6m = ~clk_6m;
	
	// generate our 25Mhz VGA clock
	always #VGA_PERIOD begin
		if (frame_count > 4) $finish();
		
		clk_25m = ~clk_25m;      
	end
	
endmodule

