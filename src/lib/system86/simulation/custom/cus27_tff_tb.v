`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:12:52 01/07/2026
// Design Name:   cus27_tff_tb
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/cus27_tff_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_tff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus27_tff_tb;
	
	// Inputs
	reg sig_CLK;
	reg sig_SET;
	reg sig_RES;

	// Outputs
	wire sig_Q;
	wire sig_bQ;

	// Instantiate the Unit Under Test (UUT)
	cus27_tff
		uut (
			.CLK(sig_CLK), 
			.Q(sig_Q), 
			.bQ(sig_bQ), 
			.SET(sig_SET), 
			.RES(sig_RES)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0);
		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("divide-by-2");
		
		apply_test("reset (leading)", /*CLK=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("reset (tick)", /*CLK=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("reset (tock)", /*CLK=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("reset (trailing)", /*CLK=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("set (leading)", /*CLK=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (tick)", /*CLK=*/1'b1, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (tock)", /*CLK=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (trailing)", /*CLK=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1);
		apply_inputs(0, 0, 0);
		#5;
		
		apply_test("tick", /*CLK=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("tock", /*CLK=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		#5;
		
		apply_test("tick", /*CLK=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("tock", /*CLK=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | CLK    | SET | RES | bQ_exp  | Q_exp  | bQ  | Q    | RESULT", set_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input SET,
	 input RES,
	 input Q_exp,
	 input bQ_exp,
	 input Q,
	 input bQ,
	 input reg [5*8:1] result
	);
	begin
	   //           | CLK | SET | RES | Q_exp | bQ_exp | Q |  bQ | RESULT
		$display("%s |   %b |   %b |   %b |      %b |     %b |  %b |  %b |  %s",
					  test_name, CLK, SET, RES, Q_exp, bQ_exp, Q, bQ, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input SET,
	 input RES,
	 input Q_exp,
	 input bQ_exp,
	 output reg result
	);
	begin
		apply_inputs(CLK, SET, RES);
		
		#5;
		
		if (sig_Q === Q_exp && sig_bQ === bQ_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, CLK, SET, RES, Q_exp, bQ_exp, sig_Q, sig_bQ, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, CLK, SET, RES, Q_exp, bQ_exp, sig_Q, sig_bQ, "FAIL");
		end
		
		#10;
	end
	endtask
	
	task apply_inputs(
	 input CLK,
	 input SET,
	 input RES
	);
	begin
		sig_CLK = CLK;
		sig_SET = SET;
		sig_RES = RES;

		#5;
	end
	endtask
	
endmodule
