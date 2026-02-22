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

module furrtek_horizontal_tb;
			
	// Inputs
	reg sig_6MIN2_i;
	reg sig_bHRESET3_i;

	// Outputs
	wire sig_b1H_o;
   wire sig_b2H_o;
	wire sig_b4H_o;		// internal routing outputs
	wire sig_bPIN_6_o;	// presuming this is equivalent to 8Hwire sig_24M;

	// internal routing ouputs
	wire sig_J5Q_o;
	wire sig_J5bQ_o;
	
	// Instantiate the Unit Under Test (UUT)
	furrtek_horizontal
		uut (
			.sig_6MIN2_i(sig_6MIN2_i),
			.sig_bHRESET3_i(sig_bHRESET3_i),
			.sig_b1H_o(sig_b1H_o),
			.sig_b2H_o(sig_b2H_o), 
			.sig_b4H_o(sig_b4H_o),
			.sig_bPIN_6_o(sig_bPIN_6_o), 
			.sig_J5Q_o(sig_J5Q_o), 
			.sig_J5bQ_o(sig_J5bQ_o)
		);

	reg hres3;
	reg test_result;
	
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 1);
		apply_inputs(0, 0);
		
		hres3 = 1'b0;

		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("CUS27 Horizontal Timings");

		apply_test("HRESET3", /*HRESET3=*/1'b1, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tick", /*HRESET3=*/1'b1, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b1, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("HRESET3", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);		
		
		write_divider();
	
		hres3 = 1'b0;
					
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		
		apply_test("tick", /*HRESET3=*/1'b0, /*6MIN=*/1'b1, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
		apply_test("tock", /*HRESET3=*/1'b0, /*6MIN=*/1'b0, /*1H_exp=*/1'b0, /*2H_exp=*/1'b0, /*4H_exp=*/1'b0, /*8H_exp=*/1'b0, /*J5Q_exp=*/1'b0, /*J5~Q_exp=*/1'b0, test_result);
				
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
	 input iHRESET3,
	 input i6MIN2,
	 input o1H_exp,
	 input o2H_exp, 
	 input o4H_exp,
	 input o8H_exp,
	 input oJ5Q_exp,
	 input oJ5bQ_exp,
	 input o1H,
	 input o2H, 
	 input o4H,
	 input o8H,
	 input oJ5Q,
	 input oJ5bQ,
	 input reg [5*8:1] result
	);
	begin
	   //           | HRESET3  | 6MIN   | 1H _exp| 2H_exp | 4H_exp | 8H_exp | J5Q_exp | J5bQ_exp | 1H | 2H | 4H | 8H | J5Q | J5bQ | RESULT
		$display("%s |   %b  |  %b |   %b |   %b |  %b |  %b |  %b |  %b |  %b |  %b |  %b |   %b  |  %b |  %b  |  %s",
					  test_name, iHRESET3, i6MIN2, o1H_exp, o2H_exp, o4H_exp, o8H_exp, oJ5Q_exp, oJ5bQ_exp, o1H, o2H, o4H, o8H, oJ5Q, oJ5bQ, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input iHRESET3,
	 input i6MIN2,
	 input o1H_exp,
	 input o2H_exp, 
	 input o4H_exp,
	 input o8H_exp,
	 input oJ5Q_exp,
	 input oJ5bQ_exp,
	 output reg result
	);
	begin
		apply_inputs(iHRESET3, i6MIN2);
		
		#5;
		
		if (~sig_b1H_o === o1H_exp && ~sig_b2H_o === o2H_exp && ~sig_b4H_o === o4H_exp && ~sig_bPIN_6_o === o8H_exp && ~sig_J5Q_o === oJ5Q_exp && ~sig_J5bQ_o === oJ5bQ_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, iHRESET3, i6MIN2, o1H_exp, o2H_exp, o4H_exp, o8H_exp, oJ5Q_exp, oJ5bQ_exp, sig_b1H_o, sig_b2H_o, sig_b4H_o, sig_bPIN_6_o, sig_J5Q_o, sig_J5bQ_o, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, iHRESET3, i6MIN2, o1H_exp, o2H_exp, o4H_exp, o8H_exp, oJ5Q_exp, oJ5bQ_exp, sig_b1H_o, sig_b2H_o, sig_b4H_o, sig_bPIN_6_o, sig_J5Q_o, sig_J5bQ_o, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input iHRESET3,
	 input i6MIN2
	);
	begin
	   sig_bHRESET3_i = ~iHRESET3;
		sig_6MIN2_i = i6MIN2;

		#5;
	end
	endtask
	
endmodule
