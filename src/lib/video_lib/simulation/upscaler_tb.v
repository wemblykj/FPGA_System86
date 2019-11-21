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

module upscaler_tb;

	// Namco System86 timings 288x224 (384x264) 6Mhz pixel clock
	parameter c_TOTAL_COLS = 384;
	parameter c_TOTAL_ROWS  = 264;
	parameter c_ACTIVE_COLS = 288;
	parameter c_ACTIVE_ROWS = 224;
	  
	  
	parameter c_SYNC_PULSE_HORZ = 32;
	parameter c_SYNC_PULSE_VERT = 8;
	  
	parameter c_FRONT_PORCH_HORZ = 32;	// Mame has a 3 pixel offset on these horizontal timings
	parameter c_BACK_PORCH_HORZ  = 32;	// - this works out as 29 f.p. and 32 b.p.
	parameter c_FRONT_PORCH_VERT = 24;
	parameter c_BACK_PORCH_VERT  = 8;
	  
	parameter c_USE_BLANKING = 1;
	
	parameter c_VIDEO_WIDTH = 8;
	parameter c_NAMCO_PERIOD = 81.3802;
	parameter c_VGA_PERIOD = 19.5313;
	
	// Inputs
	reg rst = 0;
	
	reg clk_6m = 0;
	reg clk_25m = 0;
	
	wire pixel_clk_a;
	wire hsync_a;
	wire vsync_a;
	wire hblank_a;
	wire vblank_a;
	
	wire pixel_clk_b;
	wire hsync_b;
	wire vsync_b;
	wire hblank_b;
	wire vblank_b;
	
	//reg [c_VIDEO_WIDTH-1:0] red_a = 0;
	//reg [c_VIDEO_WIDTH-1:0] green_a = 0;
	//reg [c_VIDEO_WIDTH-1:0] blue_a = 0;
	wire [c_VIDEO_WIDTH-1:0] red_a;
	wire [c_VIDEO_WIDTH-1:0] green_a;
	wire [c_VIDEO_WIDTH-1:0] blue_a;
	
	// Outputs
	wire [c_VIDEO_WIDTH-1:0] red_b;
	wire [c_VIDEO_WIDTH-1:0] green_b;
	wire [c_VIDEO_WIDTH-1:0] blue_b;
	
	// Instantiate the Unit Under Test (UUT)
	upscaler 
	#( 
		.C_COMPONENT_DEPTH(c_VIDEO_WIDTH),
		.C_LINE_BUFFER_SIZE(c_TOTAL_COLS),
		.C_LINE_BUFFER_COUNT(2))
	uut (
		.rst(rst), 
		.pixel_clk_a(pixel_clk_a), 
		.hsync_a(hsync_a), 
		.vsync_a(vsync_a), 
		.hblank_a(hblank_a), 
		.vblank_a(vblank_a), 
		.red_a(red_a), 
		.green_a(green_a), 
		.blue_a(blue_a), 
		.pixel_clk_b(pixel_clk_b), 
		.hsync_b(hsync_b), 
		.vsync_b(vsync_b), 
		.hblank_b(hblank_b), 
		.vblank_b(vblank_b), 
		.red_b(red_b), 
		.green_b(green_b), 
		.blue_b(blue_b)
	);
	
	vga_logger #( 
		.C_COMPONENT_DEPTH(c_VIDEO_WIDTH),
		.C_FILE_NAME("vga_vid.txt"))
		vga_logger
		(
			.pixel_clk(pixel_clk_b),
			.output_enable(1'b1),
			.red(red_b),
			.green(green_b),
			.blue(blue_b),
			.hsync(hsync_b),
			.vsync(vsync_b)
		);
		
	wire sg_a_hsync;
	wire sg_a_vsync;
	VGA_Sync_Pulses
		#(	.TOTAL_COLS(c_TOTAL_COLS),
         .TOTAL_ROWS(c_TOTAL_ROWS),
         .SYNC_PULSE_HORZ(c_SYNC_PULSE_HORZ),
			.SYNC_PULSE_VERT(c_SYNC_PULSE_VERT))
		sync_gen_a (
			.i_Clk(clk_6m),
			.o_HSync(sg_a_hsync),
			.o_VSync(sg_a_vsync)
		);
		
	wire s2b_a_hsync;
	wire s2b_a_vsync;
	wire s2b_a_hblank;
	wire s2b_a_vblank;
	Sync_To_Blanking 
		#(	.TOTAL_COLS(c_TOTAL_COLS),
         .TOTAL_ROWS(c_TOTAL_ROWS),
         .SYNC_PULSE_HORZ(c_SYNC_PULSE_HORZ),
			.SYNC_PULSE_VERT(c_SYNC_PULSE_VERT),
			.FRONT_PORCH_HORZ(c_FRONT_PORCH_HORZ),
			.BACK_PORCH_HORZ(c_BACK_PORCH_HORZ),
			.FRONT_PORCH_VERT(c_FRONT_PORCH_VERT),
			.BACK_PORCH_VERT(c_BACK_PORCH_VERT))
		sync2blank4_a (
			.i_Clk(clk_6m),
			.i_HSync(sg_a_hsync),
			.i_VSync(sg_a_vsync),
			.o_HSync(s2b_a_hsync),
			.o_VSync(s2b_a_vsync),
			.o_HBlank(s2b_a_hblank),
			.o_VBlank(s2b_a_vblank)
		);	
	
	// Drives Red/Grn/Blue video - Test Pattern 5 (Color Bars)
	wire tpg_a_hsync;
	wire tpg_a_vsync;
	wire tpg_a_hblank;
	wire tpg_a_vblank;
	wire [c_VIDEO_WIDTH-1:0] tpg_a_red;
	wire [c_VIDEO_WIDTH-1:0] tpg_a_green;
	wire [c_VIDEO_WIDTH-1:0] tpg_a_blue;
	Test_Pattern_Gen  
		#( .VIDEO_WIDTH(c_VIDEO_WIDTH),
			.TOTAL_COLS(c_TOTAL_COLS),
         .TOTAL_ROWS(c_TOTAL_ROWS),
         .ACTIVE_COLS(c_ACTIVE_COLS),
         .ACTIVE_ROWS(c_ACTIVE_ROWS),
			.USE_BLANKING(c_USE_BLANKING),
			.SYNC_PULSE_HORZ(c_SYNC_PULSE_HORZ),
			.SYNC_PULSE_VERT(c_SYNC_PULSE_VERT),
			.FRONT_PORCH_HORZ(c_FRONT_PORCH_HORZ),
			.BACK_PORCH_HORZ(c_BACK_PORCH_HORZ),
			.FRONT_PORCH_VERT(c_FRONT_PORCH_VERT),
			.BACK_PORCH_VERT(c_BACK_PORCH_VERT))							 
		tpg_a (
			.i_Clk(clk_6m),
			.i_Pattern(4'b0101), // 0101 = color bars
			.i_HSync(sg_a_hsync),
			.i_VSync(sg_a_vsync),
			.o_HSync(tpg_a_hsync),
			.o_VSync(tpg_a_vsync),
			.o_HBlank(tpg_a_hblank),
			.o_VBlank(tpg_a_vblank),
			.o_Red_Video(tpg_a_red),
			.o_Grn_Video(tpg_a_green),
			.o_Blu_Video(tpg_a_blue)
			);
	
	vga_logger #( 
		.C_COMPONENT_DEPTH(c_VIDEO_WIDTH),
		.C_FILE_NAME("namco_vid.txt"))
		namco_logger
		(
			.pixel_clk(pixel_clk_a),
			.output_enable(1'b1),
			.red(tpg_a_red),
			.green(tpg_a_green),
			.blue(tpg_a_blue),
			.hsync(tpg_a_hsync),
			.vsync(tpg_a_vsync)
		);
			
	wire sg_b_hsync;
	wire sg_b_vsync;
	VGA_Sync_Pulses
		sync_gen_b (
			.i_Clk(clk_25m),
			.o_HSync(sg_b_hsync),
			.o_VSync(sg_b_vsync)
		);
		
	wire s2b_b_hsync;
	wire s2b_b_vsync;
	wire s2b_b_hblank;
	wire s2b_b_vblank;
	Sync_To_Blanking 
		sync2blank4_b (
			.i_Clk(clk_25m),
			.i_HSync(sg_b_hsync),
			.i_VSync(sg_b_vsync),
			.o_HSync(s2b_b_hsync),
			.o_VSync(s2b_b_vsync),
			.o_HBlank(s2b_b_hblank),
			.o_VBlank(s2b_b_vblank)
	);	

	assign pixel_clk_a = clk_6m;
	assign hsync_a = tpg_a_hsync;
	assign vsync_a = tpg_a_vsync;
	assign hblank_a = tpg_a_hblank;
	assign vblank_a = tpg_a_vblank;

	/*assign pixel_clk_b = clk_6m;
	assign hsync_b = tpg_a_hsync;
	assign vsync_b = tpg_a_vsync;
	assign hblank_b = tpg_a_hblank;
	assign vblank_b = tpg_a_vblank;*/
	
	assign pixel_clk_b = clk_25m;
	assign hsync_b = s2b_b_hsync;
	assign vsync_b = s2b_b_vsync;
	assign hblank_b = s2b_b_hblank;
	assign vblank_b = s2b_b_vblank;
	
	assign red_a = tpg_a_red;
	assign green_a = tpg_a_green;
	assign blue_a = tpg_a_blue;
	
	integer frame_count = 0;
	
	initial begin
		// Initialize Inputs
		rst = 1;
		clk_6m = 0;
		clk_25m = 0;
		
		//red_a = 8'b1;
		//green_a = 8'b1;
		//blue_a = 8'b1;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		rst = 0;
		
		// Add stimulus here
		
		

	end

	always @(posedge vsync_b) frame_count = frame_count + 1;

	// generate our 6Mhz  clock
	always #c_NAMCO_PERIOD clk_6m = ~clk_6m;
	
	// generate our 25Mhz VGA clock
	always #c_VGA_PERIOD begin
		if (frame_count == 8) $finish();
		
		clk_25m = ~clk_25m;      
	end
	
endmodule

