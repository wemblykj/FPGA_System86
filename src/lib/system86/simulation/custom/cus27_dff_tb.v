`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:13:36 01/07/2026
// Design Name:   cus27_dff_tb
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/cus27_dff_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_dff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus27_dff_tb;

	reg _rst_n;
	
	// Inputs
	reg CLK;
	reg D;
	reg bSET;
	reg bRES;

	// Outputs
	wire Q;
	wire bQ;

	// Instantiate the Unit Under Test (UUT)
	cus27_dff uut (
	   ._rst_ni(_rst_n),
		.CLK(CLK), 
		.D(D), 
		.Q(Q), 
		.bQ(bQ), 
		.bSET(bSET), 
		.bRES(bRES)
	);

	integer p;

	initial begin
		_rst_n = 0;
		
		// Initialize Inputs
		CLK = 0;
		D = 0;
		bSET = 0;
		bRES = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		_rst_n = 1;
		
		// Add stimulus here
		$display("¬SET\t¬RES\tCLK\tD\tQ\t¬Q");
		
		for (p = 0; p < 16; p=p+1) begin
		   // implementation reset to uninitialised state
			_rst_n = 0;
			#5
			_rst_n = 1;
			
			CLK <= 0;
			
			#5
			bSET <= p[3];
			bRES <= p[2];
			D <= p[0];
			
			#5
			CLK <= p[1];
			
			#5
			$display("%s\t%s\t%s\t%s\t%s\t%s", 
				bSET ? "H" : "L",
				bRES ? "H" : "L", 
				CLK ? "E" : "-",
				D ? "H" : "L",
				(Q === 1'bz) ? "-" : (Q ? "H" : "L"), 
				(bQ === 1'bz) ? "-" : (bQ ? "H" : "L")
				);
			
		end
		
		$finish;

	end
      
endmodule

