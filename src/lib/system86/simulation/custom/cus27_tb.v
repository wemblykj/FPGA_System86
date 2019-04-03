`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
//
// Create Date:    20:24:56 04/21/2018
// Design Name:    cus27_tb
// Module Name:    system86/src/custom/cus27_tb.v
// Project Name:   Namco System86 simulation
// Target Device:  
// Tool versions:  
// Description:    Namco CUS42 - System timings generator testbench
//
// Verilog Test Fixture created by ISE for module: cus27
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License:        https://www.apache.org/licenses/LICENSE-2.0
// 
////////////////////////////////////////////////////////////////////////////////

module cus27_tb;

	// Inputs
	reg rst;
	reg clk_48m;
	reg hreset;
	// Outputs
	wire clk_24m_o;
	wire clk_12m_o;
	wire clk_6m_o;
	wire vsync;
	wire hsync;
	wire vblank;
	wire hblank;
	wire vreset;
	wire clk_8v_o;
	wire clk_4v_o;
	wire clk_1v_o;
	wire clk_4h_o;
	wire clk_2h_o;
	wire clk_1h_o;
	wire clk_s2h_o;
	wire clk_s1h_o;

	// Instantiate the Unit Under Test (UUT)
	cus27 uut (
		.rst(rst),
		.clk_48m(clk_48m), 
		.clk_6m(clk_6m_o), 
		.clk_24m_o(clk_24m_o), 
		.clk_12m_o(clk_12m_o), 
		.clk_6m_o(clk_6m_o), 
		.vsync(vsync), 
		.hsync(hsync), 
		.vblank(vblank), 
		.hblank(hblank), 
		.vreset(vreset), 
		.pclk_8v_o(pclk_8v_o), 
		.pclk_4v_o(pclk_4v_o), 
		.pclk_1v_o(pclk_1v_o), 
		.pclk_4h_o(pclk_4h_o), 
		.pclk_2h_o(pclk_2h_o), 
		.pclk_1h_o(pclk_1h_o), 
		.pclk_s2h_o(pclk_s2h_o), 
		.pclk_s1h_o(pclk_s1h_o)
	);

	initial begin
		// Initialize Inputs
		clk_48m = 0;
		
		rst = 1;

		// Wait 1000 ns for global reset to finish
		#400;
        
		// Add stimulus here
		rst = 0;
		
		#61440;	// one full line
		$finish;
	end
      
	always begin
		#10 clk_48m = ~clk_48m;	// more like 50mhz
		
	end
   
endmodule

