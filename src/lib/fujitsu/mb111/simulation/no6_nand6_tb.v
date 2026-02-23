`timescale 1ns / 1ps
module mb111_n06_nand6_tb;
	// Declare testbench signals
	reg sig_A, sig_B, sig_C, sig_D;
	wire sig_Y;

	// Instantiate the DUT (Device Under Test)
	mb111_n06_nand6
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
		#10;
        
		// Add stimulus here
		
		// 4 input NAND over two cells
		
		write_header("CUS27 N06 6-input NAND");
		
		apply_test("test 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);		
		apply_test("test 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_test("test 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);	
		apply_test("test 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_test("test 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);	
		apply_test("test 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*D=*/1'b0, /*Y_exp=*/1'b1, test_result);
		
		apply_test("test 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b1, test_result);	
		apply_test("test 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*D=*/1'b1, /*Y_exp=*/1'b1, test_result);
	
		apply_test("test 9", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*D=*/1'b1, /*Y_exp=*/1'b1, test_result);		
		apply_test("test 10", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*D=*/1'b1, /*Y_exp=*/1'b1, test_result);
		
		apply_test("test 11", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*D=*/1'b1, /*Y_exp=*/1'b1, test_result);	
		apply_test("test 12", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*D=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
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
		input A_in,
		input B_in,
		input C_in,
		input D_in,
		input Y_exp,
		input Y,
		input reg [5*8:1] result
	);
	begin
		$display("%s | %b | %b | %b | %b | %b | %b | %s",
					  test_name, A_in, B_in, C_in, D_in, Y_exp, Y, result);
	end
	endtask
	
	task apply_test(
		input reg [25*8:1] test_name,
		input A_in,
		input B_in,
		input C_in,
		input D_in,
		input Y_exp,
		output reg result
	);
	begin
		apply_inputs(A_in, B_in, C_in, D_in);
		
		if (sig_Y === Y_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, A_in, B_in, C_in, D_in, Y_exp, sig_Y, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, A_in, B_in, C_in, D_in, Y_exp, sig_Y, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
		input A_in,
		input B_in,
		input C_in,
		input D_in
	);
	begin
		sig_A = A_in;
		sig_B = B_in;
		sig_C = C_in;
		sig_D = D_in;
		
		#5;
	end
	endtask
	 
endmodule
