`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:   20:57:30 04/12/2018
// Design Name:   system86/system86.v
// Module Name:   C:/Development/Xilinx/system86/system86_tb.v
// Project Name:  Namco System86 simulation
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
// 
////////////////////////////////////////////////////////////////////////////////

module system86_tb;

	// Inputs
	reg clk_in;
	reg rst;
	reg [7:0] R;
	reg [7:0] G;
	reg [7:0] B;
	reg HSYNC;
	reg VSYNC;
	
	// Instantiate the Unit Under Test (UUT)
	system86 uut (
		.clk(clk_in), 
		.rst(rst),
		.R(R),
		.G(G),
		.B(B),
		.HSYNC(HSYNC),
		.VSYNC(VSYNC)
	);

	integer rgb_fd;
	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 1;

		#10
		rgb_fd = $fopen("rgb.log", "w");
		
		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
      
	always begin
		#2 clk_in = ~clk_in;
		if (!rst && clk_in)
			$fwrite(rgb_fd, "%d ns: %b %b %b %b %b\n", $time, HSYNC, VSYNC, R, G, B);
	end
	
endmodule

