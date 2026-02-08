module cus27_nand4_tb;
	// Declare testbench signals
	reg sig_A, sig_B, sig_C, sig_D;
	wire sig_Y;

	// Instantiate the DUT (Device Under Test)
	cus27_nand4
		dut (
			.A(sig_A),
			.B(sig_B),
			.C(sig_C),
			.D(sig_D),
			.Y(sig_Y)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0, 0);

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		// 4 input NAND over two cells
		
		write_header("CUS27 'NAND' 4 (physically OR 4)");
		
		apply_inputs(/*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b0);
		
		apply_test("test 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);		
		apply_test("test 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b0, test_result);	
		apply_test("test 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*D=*/1'b0, /*Y_exp=*/1'b0, test_result);	
		apply_test("test 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*D=*/1'b0, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);	
		apply_test("test 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
	
		apply_test("test 9", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);		
		apply_test("test 10", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 11", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);	
		apply_test("test 12", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 13", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);	
		apply_test("test 14", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 15", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
		apply_test("test 16", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | A    | B | C | D  | Y_exp | Y    | RESULT", set_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_result(
		input reg [25*8:1] test_name,
		input A,
		input B,
		input C,
		input D,
		input expected_Y,
		input Y,
		input reg [5*8:1] result
	);
	begin
		$display("%s | %b | %b | %b | %b | %b | %b | %s",
					  test_name, A, B, C, D, expected_Y, Y, result);
	end
	endtask
	
	task apply_test(
		input reg [25*8:1] test_name,
		input A,
		input B,
		input C,
		input D,
		input expected_Y,
		output reg result
	);
	begin
		apply_inputs(A, B, C, D);
		
		if (sig_Y === expected_Y) begin
		  result = 1; // Test passed
		  write_result(test_name, A, B, C, D, expected_Y, sig_Y, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, A, B, C, D, expected_Y, sig_Y, "FAIL");
		end
		
		#10;
	end
	endtask
	
	task apply_inputs(
		input A,
		input B,
		input C,
		input D
	);
	begin
		sig_A = A;
		sig_B = B;
		sig_C = C;
		sig_D = D;
		
		#5;
	end
	endtask
	 
endmodule
