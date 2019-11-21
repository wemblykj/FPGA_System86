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

	reg clk_24m;
		
	wire s86_vid_clk;
	wire [3:0] s86_vid_red;
	wire [3:0] s86_vid_green;
	wire [3:0] s86_vid_blue;
	wire s86_hsync;
	wire s86_hblank;
	wire s86_vsync;
	wire s86_vblank;
	
	//wire x2_vid_clk;
	wire [3:0] x2_vid_red;
	wire [3:0] x2_vid_green;
	wire [3:0] x2_vid_blue;
	wire x2_hsync;
	wire x2_hblank;
	wire x2_vsync;
	wire x2_vblank;
	
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
		
	upscaler
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH),
			.C_LINE_BUFFER_COUNT(2),
			.C_DELTA_WIDTH(8)
		)
		upscaler (
			.rst(rst),
			
			.pixel_clk_a(s86_vid_clk),
			
			.red_a(s86_vid_red),
			.green_a(s86_vid_green),
			.blue_a(s86_vid_blue),
			.hsync_a(s86_hsync),
			.vsync_a(s86_vsync),
			.hblank_a(s86_hblank),
			.vblank_a(s86_vblank),
			
			.pixel_clk_b(s86_vid_clk),
			.hsync_b(s86_hsync),
			.vsync_b(s86_hsync),
			.hblank_b(s86_hblank),
			.vblank_b(s86_vblank),
			
			.red_b(x2_vid_red),
			.green_b(x2_vid_green),
			.blue_b(x2_vid_blue)
		);
		
	vga_logger
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		logger (
			.pixel_clk(clk_24m),
			.output_enable(~rst),
			.red(x2_vid_red),
			.green(x2_vid_green),
			.blue(x2_vid_blue),
			.hsync(x2_hsync),
			.vsync(x2_vsync)
		);
		
	initial begin
		// Initialize Inputs
		clk_48m = 0;
		clk_24m = 0;
		rst = 1;

		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
      
	always #10.1725 clk_48m = ~clk_48m;

	// generate our 24mhz output clock
	always @(posedge clk_48m) clk_24m = ~clk_24m;
		
	
endmodule

