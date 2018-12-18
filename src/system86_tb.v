`timescale 1ns/1fs
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:57:30 04/12/2018
// Design Name:    system86_tb
// Module Name:    system86/system86_tb.v
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

module System86_tb;

	// Inputs
	reg clk_in;
	reg rst;
	wire [7:0] R;
	wire [7:0] G;
	wire [7:0] B;
	wire HSYNC;
	wire VSYNC;
	
	// Instantiate the Unit Under Test (UUT)
	system86 uut (
		.CLK_48M(clk_in), 
		.RST(rst),
		.R(R),
		.G(G),
		.B(B),
		.HSYNC(HSYNC),
		.VSYNC(VSYNC)
	);

	integer rgb_fd;
	reg [2:0] counter = 0;
	initial begin
		// Initialize Inputs
		clk_in = 0;
		rst = 1;

		#10
		rgb_fd = $fopen("tilemap_single_rgb.log", "w");
		
		// Wait 1000 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
      
	always begin
		#10.1725 clk_in = ~clk_in;
		
		if (!rst) begin
			if (counter[2])
				$fwrite(rgb_fd, "%0d ns: %b %b %b %b %b\n", $time, HSYNC, VSYNC, R, G, B);
				
			if (clk_in)
				counter = counter + 1;
		end
	end
	
endmodule

