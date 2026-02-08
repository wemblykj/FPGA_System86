`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:10:47 01/08/2026
// Design Name:   cus27_furrtek_ref
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/furrtek/furrtek_clock_divider_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_furrtek_ref
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module furrtek_video_reset_tb;
	
	// Inputs
	reg sig_b48M_2_i;
	reg sig_bHRES_IN_i;
	reg sig_bVRES_IN_i;
	reg sig_E5TOP_i;
	
	// Outputs
   wire sig_HRESET_o;
	wire sig_bHRESET1_o;
	wire sig_bHRESET2_o;
	wire sig_bHRESET3_o;
	wire sig_bVRESET1_o;
	wire sig_bVRESET2_o;
	wire sig_bVRESET3_o;
	
	// Instantiate the Unit Under Test (UUT)
	furrtek_video_reset
		uut (
			.sig_b48M_2_i(sig_b48M_2_i),
			.sig_bHRES_IN_i(sig_bHRES_IN_i),
			.sig_bVRES_IN_i(sig_bVRES_IN_i),
			.sig_E5TOP_i(sig_E5TOP_i), 
			.sig_HRESET_o(sig_HRESET_o),
			.sig_bHRESET1_o(sig_bHRESET1_o), 
			.sig_bHRESET2_o(sig_bHRESET2_o), 
			.sig_bHRESET3_o(sig_bHRESET3_o), 
			.sig_bVRESET1_o(sig_bVRESET1_o),
			.sig_bVRESET2_o(sig_bVRESET2_o),
			.sig_bVRESET3_o(sig_bVRESET3_o)
		);

	reg hres;
	reg vres;
	reg e5top;
	reg test_result;
	
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0);
		
		hres = 1'b0;
		vres = 1'b0;
		e5top = 1'b0;
		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("CUS27 Video Reset");

		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		hres = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		hres = 1'b0;
		vres = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		hres = 1'b1;
		vres = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		write_divider();
		
		e5top = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		hres = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		hres = 1'b0;
		vres = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		hres = 1'b1;
		vres = 1'b1;
		
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tick", hres, vres, e5top, /*48M=*/1'b0, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		apply_test("tock", hres, vres, e5top, /*48M=*/1'b1, /*HRESET_exp=*/1'b0, /*HRESET1_exp=*/1'b0, /*HRESET2_exp=*/1'b0, /*HRESET3_exp=*/1'b0, /*VRESET1_exp=*/1'b0, /*VRESET2_exp=*/1'b0, /*VRESET3_exp=*/1'b0, test_result);
		
		write_divider();
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		write_divider();
		$display("%s | HRES_IN | VRES_IN | E5TOP | 48M    | HRESET   | HRESET1   | HRESET2 | HRESET3 | VRESET1  | VRESET2  | VRESET3 | RESULT", set_name);
		write_divider();
	end
	endtask
	
	task write_divider();
		$display("------------------------------------------------------------------------------------------");
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input iHRES_IN,
	 input iVRES_IN,
	 input iE5TOP,
	 input i48M,
	 input oHRESET_exp,
	 input obHRESET1_exp,
	 input obHRESET2_exp,
	 input obHRESET3_exp, 
	 input obVRESET1_exp,
	 input obVRESET2_exp,
	 input obVRESET3_exp,
	 input oHRESET,
	 input obHRESET1,
	 input obHRESET2, 
	 input obHRESET3,
	 input obVRESET1,
	 input obVRESET2,
	 input obVRESET3,
	 input reg [5*8:1] result
	);
	begin
	   //           | HRES_IN | VRES_IN | E5TOP | 48M    | HRESET   | HRESET1   | HRESET2 | HRESET3 | VRESET1  | VRESET2  | VRESET3 | RESULT
		$display("%s |   %b |   %b  |   %b |   %b  |  %b |   %b |   %b |  %b |  %b |  %b |  %b |  %b |  %b |  %b |   %b  |  %b |   %b |  %s",
					  test_name, iHRES_IN, iVRES_IN, iE5TOP, oHRESET_exp, obHRESET1_exp, obHRESET2_exp, obHRESET3_exp, obVRESET1_exp, obVRESET2_exp, obVRESET3_exp, oHRESET, obHRESET1, obHRESET2, obHRESET3, obVRESET1, obVRESET2, obVRESET3, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input iHRES_IN,
	 input iVRES_IN,
	 input iE5TOP,
	 input i48M,
	 input oHRESET_exp,
	 input obHRESET1_exp,
	 input obHRESET2_exp,
	 input obHRESET3_exp, 
	 input obVRESET1_exp,
	 input obVRESET2_exp,
	 input obVRESET3_exp,
	 output reg result
	);
	begin
		apply_inputs(iHRES_IN, iVRES_IN, iE5TOP, i48M);
		
		#5;
		
		if (~sig_HRESET_o === oHRESET_exp && ~sig_bHRESET1_o === obHRESET1_exp && ~sig_bHRESET2_o === obHRESET2_exp && ~sig_bHRESET3_o === obHRESET3_exp && ~sig_bVRESET1_o === obVRESET1_exp && sig_bVRESET2_o === obVRESET2_exp && sig_bVRESET3_o === obVRESET3_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, iHRES_IN, iVRES_IN, iE5TOP, i48M, oHRESET_exp, obHRESET1_exp, obHRESET2_exp, obHRESET3_exp, obVRESET1_exp, obVRESET2_exp, obVRESET3_exp, sig_HRESET_o, sig_bHRESET1_o, sig_bHRESET2_o, sig_bHRESET3_o, sig_bVRESET1_o, sig_bVRESET2_o, sig_bVRESET3_o, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, iHRES_IN, iVRES_IN, iE5TOP, i48M, oHRESET_exp, obHRESET1_exp, obHRESET2_exp, obHRESET3_exp, obVRESET1_exp, obVRESET2_exp, obVRESET3_exp, sig_HRESET_o, sig_bHRESET1_o, sig_bHRESET2_o, sig_bHRESET3_o, sig_bVRESET1_o, sig_bVRESET2_o, sig_bVRESET3_o, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input iHRES_IN,
	 input iVRES_IN,
	 input iE5TOP,
	 input i48M
	);
	begin
	   sig_bHRES_IN_i = ~iHRES_IN;
		sig_bVRES_IN_i = ~iVRES_IN;
		sig_E5TOP_i = iE5TOP;
		sig_b48M_2_i = ~i48M;

		#5;
	end
	endtask
	
endmodule
