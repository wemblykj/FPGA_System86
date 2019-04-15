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

	wire vid_clk;
	wire [3:0] vid_red;
	wire [3:0] vid_green;
	wire [3:0] vid_blue;
	wire hsync;
	wire hblank;
	wire vsync;
	wire vblank;
	
	// Instantiate the Unit Under Test (UUT)
	system86 
		#(
			.C_USE_HARDWARE_CLOCKS(0),
			.C_VIDEO_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		uut (
			.clk_48m(clk_48m), 
			.rst(rst),
			.vid_clk(vid_clk),
			.vid_red(vid_red),
			.vid_green(vid_green),
			.vid_blue(vid_blue),
			.vid_hsync(hsync),
			.vid_hblank(hblank),
			.vid_vsync(vsync),
			.vid_vblank(vblank)
		);

	vga_logger
		#(
			.C_COMPONENT_DEPTH(C_VIDEO_COMPONENT_DEPTH)
		)
		logger (
			.pixel_clk(vid_clk),
			.output_enable(~rst),
			.red(vid_red),
			.green(vid_green),
			.blue(vid_blue),
			.hsync(hsync),
			.vsync(vsync)
		);
		
	initial begin
		// Initialize Inputs
		clk_48m = 0;
		rst = 1;

		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
      
	always #10.1725 clk_48m = ~clk_48m;
	
endmodule

