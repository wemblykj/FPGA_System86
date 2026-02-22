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
	reg _rst_n;
	reg s86_48M;
	
	// Outputs
	wire s86_24M_o;
	wire s86_12M_o;
	wire s86_6M_o;

	wire s86_HSYNC;
	wire s86_HBLANK;
	wire s86_HRESET;
	
	wire s86_VSYNC;
	wire s86_VBLANK;
	wire s86_VRESET;
	
	wire s86_8V_o;
	wire s86_4V_o;
	wire s86_1V_o;
	wire s86_4H_o;
	wire s86_2H_o;
	wire s86_1H_o;
	wire s86_s2H_o;
	wire s86_s1H_o;

	// Instantiate the Unit Under Test (UUT)
	cus27 uut (
		._rst_ni(_rst_n),
		.pin_48M_i(s86_48M),
		.pin_6M_i(s86_6M_o),
		.pin_6M_o(s86_6M_o),
		.pin_12M_o(s86_12M_o),
		.pin_24M_o(s86_24M_o),
		
		.pin_HSYNC_o(s86_HSYNC),
		.pin_HBLANK_o(s86_HBLANK),
		.pin_HRESET_o(s86_hreset),
		
		.pin_VSYNC_o(s86_VSYNC),
		.pin_VBLANK_o(s86_VBLANK),
		.pin_VRESET_o(s86_VRESET),
		
		.pin_1H_o(s86_1H_o),
		.pin_2H_o(s86_2H_o),
		.pin_4H_o(s86_4H_o),
		
		.pin_1V_o(s86_1V_o),
		.pin_4V_o(s86_4V_o),
		.pin_8V_o(s86_8V_o),
		
		.pin_s1H_o(s86_s1H_o),
		.pin_s2H_o(s86_s2H_o)
	);

	initial begin
		// Initialize Inputs
		s86_48M = 0;
		
		_rst_n = 0;

		// Wait 1000 ns for global reset to finish
		#400;
        
		// Add stimulus here
		_rst_n = 1;
		
		#61440;	// one full line
		
		#800;	// and then some
		$finish;
	end
      
	always begin
		#10 s86_48M = ~s86_48M;	// more like 50mhz
		
	end
   
endmodule

