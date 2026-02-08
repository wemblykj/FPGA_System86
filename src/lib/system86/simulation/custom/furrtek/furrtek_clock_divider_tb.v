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

module furrtek_clock_divider_tb;
	
	// Inputs
	reg sig_bMODE1;
	reg sig_MODE0;
	reg sig_FLIP;
	reg sig_48M;
	
	// internal routing inputs
	reg sig_bHRESET1;

	// Outputs
	wire sig_b24M;
	wire sig_b12M;
	wire sig_b6M_OUT;
	wire sig_bS1H;
	wire sig_bS2H;

	// internal routing outputs
	wire sig_24M;
	wire sig_12M;
	wire sig_E5TOP;
	
	// Instantiate the Unit Under Test (UUT)
	furrtek_clock_divider
		uut (
			.sig_bMODE1_i(sig_bMODE1),
			.sig_MODE0_i(sig_MODE0),
			.sig_FLIP_i(sig_FLIP),
			.sig_48M_i(sig_48M), 
			.sig_bHRESET1_i(sig_bHRESET1),
			.sig_b24M_o(sig_b24M), 
			.sig_b12M_o(sig_b12M), 
			.sig_b6M_OUT_o(sig_b6M_OUT), 
			.sig_bS1H_o(sig_bS1H),
			.sig_bS2H_o(sig_bS2H),
			.sig_E5TOP_o(sig_E5TOP),
			.sig_24M_o(sig_24M), 
			.sig_12M_o(sig_12M)
		);

	reg hres;
	reg mode1;
	reg mode0;
	reg flip;
	reg test_result;
	
	
	initial begin
		// Initialize Inputs
		apply_inputs(1, 1, 1, 1, 1);
		apply_inputs(0, 0, 0, 0, 0);
		
		mode1 = 1'b0;
		mode0 = 1'b0;
		flip = 1'b0;
		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("CUS27 Clock Divider");

		apply_test("MODE1", /*MODE1=*/1'b1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", /*MODE1=*/1'b1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", /*MODE1=*/1'b1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", /*MODE1=*/1'b1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", /*MODE1=*/1'b1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("~MODE1", /*MODE1=*/1'b0, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		
		write_divider();
		
		hres = 1'b1;
				
		apply_test("HRESET", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("~HRESET", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
				
		write_divider();
		
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tick", mode1, mode0, flip, /*48M=*/1'b1, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		apply_test("tock", mode1, mode0, flip, /*48M=*/1'b0, hres, /*24M_exp=*/1'b0, /*12M_exp=*/1'b0, /*6M_OUT_exp=*/1'b0, /*S1H_exp=*/1'b0, /*S2H_exp=*/1'b0, /*E5TOP_exp=*/1'b0, test_result);
		
		write_divider();
			
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		write_divider();
		$display("%s | MODE1 | MODE0 | FLIP | 48M    | HRESET1   | E7BOT   | 24M_exp | 12M_exp | 6M_OUT_exp  | S1H_exp  | S2H_exp | E5TOP_exp | 24M  | 12M  | 6M_OUT  | S1H | S2H | E5TOP | RESULT", set_name);
		write_divider();
	end
	endtask
	
	task write_divider();
		$display("------------------------------------------------------------------------------------------");
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input iMODE1,
	 input iMODE0,
	 input iFLIP,
	 input i48M,
	 input iHRESET1,
	 input o24M_exp,
	 input o12M_exp, 
	 input o6M_OUT_exp,
	 input oS1H_exp,
	 input oS2H_exp,
	 input oE5TOP_exp,
	 input o24M,
	 input o12M, 
	 input o6M_OUT,
	 input oS1H,
	 input oS2H,
	 input oE5TOP,
	 input reg [5*8:1] result
	);
	begin
	   //           | MODE1 | MODE0 | FLIP | 48M  | HRESET1   | 24M_exp | 12M_exp | 6M_OUT_exp | S1H_exp | S2H_exp | oE5TOP_exp | | 24M | 12M | 6M_OUT | S1H | S2H | oE5TOP | RESULT
		$display("%s |   %b |   %b  |   %b |   %b  |  %b |   %b |   %b |  %b |  %b |  %b |  %b |  %b |  %b |  %b |   %b  |  %b |   %b |  %s",
					  test_name, iMODE1, iMODE0, iFLIP, i48M, iHRESET1, o24M_exp, o12M_exp, o6M_OUT_exp, oS1H_exp, oS2H_exp, oE5TOP_exp, o24M, o12M, o6M_OUT, oS1H, oS2H, oE5TOP, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input iMODE1,
	 input iMODE0,
	 input iFLIP,
	 input i48M,
	 input iHRESET1,
	 input o24M_exp,
	 input o12M_exp, 
	 input o6M_OUT_exp,
	 input oS1H_exp,
	 input oS2H_exp,
	 input oE5TOP_exp,
	 output reg result
	);
	begin
		apply_inputs(iMODE1, iMODE0, iFLIP, i48M, iHRESET1);
		
		#5;
		
		if (~sig_b24M === o24M_exp && ~sig_b12M === o12M_exp && ~sig_b6M_OUT === o6M_OUT_exp && ~sig_bS1H === oS1H_exp && ~sig_bS2H === oS2H_exp && sig_E5TOP === oE5TOP_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, iMODE1, iMODE0, iFLIP, i48M, iHRESET1, o24M_exp, o12M_exp, o6M_OUT_exp, oS1H_exp, oS2H_exp, oE5TOP_exp, ~sig_b24M, ~sig_b12M, ~sig_b6M_OUT, ~sig_bS1H, ~sig_bS2H, sig_E5TOP, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, iMODE1, iMODE0, iFLIP, i48M, iHRESET1, o24M_exp, o12M_exp, o6M_OUT_exp, oS1H_exp, oS2H_exp, oE5TOP_exp, ~sig_b24M, ~sig_b12M, ~sig_b6M_OUT, ~sig_bS1H, ~sig_bS2H, sig_E5TOP, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input iMODE1,
	 input iMODE0,
	 input iFLIP,
	 input i48M,
	 input iHRESET1
	);
	begin
	   sig_bMODE1 = ~iMODE1;
		sig_MODE0 = iMODE0;
		sig_FLIP = iFLIP;
		sig_48M = i48M;
		sig_bHRESET1 = ~iHRESET1;

		#5;
	end
	endtask
	
endmodule
