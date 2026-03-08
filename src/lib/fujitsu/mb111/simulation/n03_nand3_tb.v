`timescale 1ns / 1ps
module mb111_n03_nand3_tb;
	// Declare testbench signals
	reg sig_A, sig_B, sig_C;
	wire sig_Y;

	// Instantiate the DUT (Device Under Test)
	mb111_n03_nand3
		dut (
			.A(sig_A),
			.B(sig_B),
			.C(sig_C),
			.Y(sig_Y)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0);

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		write_header("MB111 N03 3-input NAND");
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_test("test 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0);
		apply_test("test 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | A    | B | C | Y_exp | F    | RESULT", set_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_result(
		input reg [25*8:1] test_name,
		input A_in,
		input B_in,
		input C_in,
		input Y_exp,
		input Y_out,
		input reg [5*8:1] result
	);
	begin
		$display("%s | %b | %b | %b | %b | %b | %s",
					  test_name, A_in, B_in, C_in, Y_exp, Y_out, result);
	end
	endtask
	
	task apply_test(
		input reg [25*8:1] test_name,
		input A_in,
		input B_in,
		input C_in,
		input Y_exp,
		output reg result
	);
	begin
		apply_inputs(A_in, B_in, C_in);
		
		if (sig_Y === Y_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, A_in, B_in, C_in, Y_exp, sig_Y, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, A_in, B_in, C_in, Y_exp, sig_Y, "FAIL");
		end
		
		#10;
	end
	endtask
	
	task apply_inputs(
		input A_in,
		input B_in,
		input C_in
	);
	begin
		sig_A = A_in;
		sig_B = B_in;
		sig_C = C_in;
		
		#5;
	end
	endtask
	 
endmodule
