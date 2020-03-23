`timescale 1ns/1fs
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:57:30 04/12/2018
// Design Name:    system86_tb
// Module Name:    system86/simulation/test_bench/system86_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description:   Top-level Namco System86 board simulation - test bench
//
// Verilog Test Fixture created by ISE for module: system86
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module system86_tb;

	parameter C_VIDEO_COMPONENT_DEPTH = 4;

	// Inputs
	reg clk_48m;
	reg rst;

	reg clk_25m;
		
	wire s86_vid_clk;
	wire [3:0] s86_vid_red;
	wire [3:0] s86_vid_green;
	wire [3:0] s86_vid_blue;
	wire s86_hsync;
	wire s86_hblank;
	wire s86_vsync;
	wire s86_vblank;
	
	//wire x2_vid_clk;
	wire [3:0] out_vid_red;
	wire [3:0] out_vid_green;
	wire [3:0] out_vid_blue;
	wire out_hsync;
	wire out_hblank;
	wire out_vsync;
	wire out_vblank;
	
	assign out_hsync_n = ~out_hsync;
	assign out_vsync_n = ~out_vsync;
	
	// Instantiate the Unit Under Test (UUT)
	system86 
		#(
			.C_USE_HARDWARE_CLOCKS(0),
			.C_VIDEO_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		uut (
			.clk_48m(clk_48m), 
			.rst(rst),
			.vid_clk(s86_vid_clk),
			.vid_red(s86_vid_red),
			.vid_green(s86_vid_green),
			.vid_blue(s86_vid_blue),
			.vid_hsync(s86_hsync),
			.vid_hblank(s86_hblank),
			.vid_vsync(s86_vsync),
			.vid_vblank(s86_vblank)
		);

	/*scan_doubler
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		doubler (
			.pixel_clk_in(s86_vid_clk),
			.pixel_clk_out_ref(clk_24m),
			
			.red_in(s86_vid_red),
			.green_in(s86_vid_green),
			.blue_in(s86_vid_blue),
			.hsync_in(s86_hsync),
			.vsync_in(s86_vsync),
			
			.red_out(x2_vid_red),
			.green_out(x2_vid_green),
			.blue_out(x2_vid_blue),
			.hsync_out(x2_hsync),
			.vsync_out(x2_vsync)
		);*/
		
	VGA_Sync_Pulses
		//#(
		//)
		output_sync_gen (
			.i_Clk(clk_25m),
			.i_Rst(rst),
			.o_HSync(out_hsync),
			.o_VSync(out_vsync)
		);
		
	Upscaler
		#(
			.COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.LINE_BUFFER_COUNT(8),
			.SCALE_PRECISION_WIDTH(12),
			.SCALE_PRECISION_HEIGHT(12)
		)
		Upscaler (
			.i_Rst(rst),
			
			.i_ClkA(s86_vid_clk),
			
			.i_RedA(s86_vid_red),
			.i_GreenA(s86_vid_green),
			.i_BlueA(s86_vid_blue),
			.i_HSyncA(s86_hsync),
			.i_VSyncA(s86_vsync),
			.i_HBlankA(s86_hblank),
			.i_VBlankA(s86_vblank),
			
			.i_ClkB(clk_25m),
			.i_HSyncB(out_hsync),
			.i_VSyncB(out_vsync),
			.i_HBlankB(out_hblank),
			.i_VBlankB(out_vblank),
			
			.o_RedB(out_vid_red),
			.o_GreenB(out_vid_green),
			.o_BlueB(out_vid_blue)
		);
		
	Video_Logger
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		logger (
			.i_Rst(rst),
			.i_Clk(clk_25m),
			.i_OutputEnable(~rst),
			.i_Red(out_vid_red),
			.i_Green(out_vid_green),
			.i_Blue(out_vid_blue),
			.i_HSync(out_hsync),
			.i_VSync(out_vsync)
		);
		
	initial begin
		// Initialize Inputs
		//clk_6m = 0;
		clk_25m = 0;
		rst = 1;

		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
      
	// generate our 6Mhz input clock
	//always #81.38 clk_6m = ~clk_6m;

	// generate our 25Mhz VGA clock
	always #19.5313 clk_25m = ~clk_25m;
	
endmodule

