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
module cus27_jkff_tb;
	
	// Inputs
	reg sig_48M;
	reg sig_bHRESET1;
	reg sig_E7BOT;

	// Outputs
	wire sig_24M;
	wire sig_12M;
	wire sig_b6M_OUT;
	wire sig_bS1H;
	wire sig_bS2H;

	// Instantiate the Unit Under Test (UUT)
	furrtek_clock_divider
		uut (
			.sig_48M_i(sig_48M), 
			.sig_bHRESET1_i(sig_bHRESET1),
			.sig_E7BOT_i(sig_E7BOT),
			.sig_24M_o(sig_24M), 
			.sig_12M_o(sig_12M), 
			.sig_b6M_OUT_o(sig_b6M_OUT), 
			.sig_bS1H_o(sig_bS1H),
			.sig_bS2H_o(sig_bS2H)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0, 0, 0);
		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("JK Flip-flop");
		
		apply_test("reset (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("reset (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("reset (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("reset (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		write_divider();
		
		apply_test("set (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// this appears to provide the toggle functionality (standard logic only J is inverted as per Furrtek schematics)
		
		// toggle
		// ~J = 1, K = 0 (toggle)
		
		apply_test("~JK", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// set
		// ~J = 0, K = 0 (set)
		apply_test("J", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// reset
		
		apply_test("K", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// latch
		// JK = 1, ~J = 0, K = 1 (latch)
		apply_test("JK", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
	
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// toggle
		
		apply_test("~JK", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// set
		
		apply_test("J", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// this appears to provide the toggle functionality (standard logic only J is inverted as per Furrtek schematics)
		// set
		
		apply_test("K", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);

		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// JK = 1 - no change
		apply_test("JK", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		write_divider();
		$display("%s | CLK    | J   | K   | SET | RES | Q_exp  | bQ_exp  | Q  | bQ    | RESULT", set_name);
		write_divider();
	end
	endtask
	
	task write_divider();
		$display("------------------------------------------------------------------------------------------");
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input J,
	 input K,
	 input SET,
	 input RES, 
	 input Q_exp,
	 input bQ_exp,
	 input Q,
	 input bQ,
	 input reg [5*8:1] result
	);
	begin
	   //           | CLK | J   | K   | SET | RES | Q_exp | bQ_exp | Q |  bQ | RESULT
		$display("%s |   %b |   %b    %b |   %b |   %b |      %b |     %b |  %b |  %b |  %s",
					  test_name, CLK, J, K, SET, RES, Q_exp, bQ_exp, Q, bQ, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input J,
	 input K,	 
	 input SET,
	 input RES,
	 input Q_exp,
	 input bQ_exp,
	 output reg result
	);
	begin
		apply_inputs(CLK, J, K, SET, RES);
		
		#5;
		
		if (sig_Q === Q_exp && sig_bQ === bQ_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, CLK, J, K, SET, RES, Q_exp, bQ_exp, sig_Q, sig_bQ, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, CLK, J, K, SET, RES, Q_exp, bQ_exp, sig_Q, sig_bQ, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input CLK,
	 input J,
	 input K,
	 input SET,
	 input RES
	);
	begin
		sig_CLK = CLK;
		sig_bJ = ~J;
		sig_K = K;
		sig_SET = SET;
		sig_RES = RES;

		#5;
	end
	endtask
	
endmodule
  
endmodule

