`timescale 1ns / 1ps
module mb111_an32_and_nor32_tb;
	// Declare testbench signals
	reg sig_A1, sig_A2, sig_A3, sig_B1, sig_B2, sig_B3;
	wire sig_Y;

	// Instantiate the DUT (Device Under Test)
	mb111_an32_and_nor32
		dut (
			.A1(sig_A1),
			.A2(sig_A2),
			.A3(sig_A3),
			.B1(sig_B1),
			.B2(sig_B2),
			.B3(sig_B3),
			.Y(sig_Y)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0, 0, 0, 0);

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		
		write_header("CUS27 3-input 2-wide AND-NOR");
		
		apply_test("test 1", /*A1=*/1'b0, /*A2=*/1'b0, /*A3=*/1'b0, /*B1=*/1'b0, /*B2=*/1'b0, /*B3=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 2", /*A1=*/1'b1, /*A2=*/1'b0, /*A3=*/1'b0, /*B1=*/1'b0, /*B2=*/1'b0, /*B3=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 3", /*A1=*/1'b0, /*A2=*/1'b1, /*A3=*/1'b0, /*B1=*/1'b0, /*B2=*/1'b0, /*B3=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 4", /*A1=*/1'b0, /*A2=*/1'b0, /*A3=*/1'b1, /*B1=*/1'b0, /*B2=*/1'b0, /*B3=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 5", /*A1=*/1'b1, /*A2=*/1'b1, /*A3=*/1'b1, /*B1=*/1'b0, /*B2=*/1'b0, /*B3=*/1'b0, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 6", /*A1=*/1'b0, /*A2=*/1'b0, /*A3=*/1'b0, /*B1=*/1'b1, /*B2=*/1'b0, /*B3=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 7", /*A1=*/1'b0, /*A2=*/1'b0, /*A3=*/1'b0, /*B1=*/1'b0, /*B2=*/1'b1, /*B3=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 8", /*A1=*/1'b0, /*A2=*/1'b0, /*A3=*/1'b0, /*B1=*/1'b0, /*B2=*/1'b0, /*B3=*/1'b1, /*Y_exp=*/1'b1, test_result);
		apply_test("test 9", /*A1=*/1'b0, /*A2=*/1'b0, /*A3=*/1'b0, /*B1=*/1'b1, /*B2=*/1'b1, /*B3=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		apply_test("test 10", /*A1=*/1'b1, /*A2=*/1'b1, /*A3=*/1'b1, /*B1=*/1'b1, /*B2=*/1'b1, /*B3=*/1'b1, /*Y_exp=*/1'b0, test_result);
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | A1  | A2  | A3  | B1  |B2  | B3  | Y_exp | Y    | RESULT", set_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_result(
		input reg [25*8:1] test_name,
		input A1_in,
		input A2_in,
		input A3_in,
		input B1_in,
		input B2_in,
		input B3_in,
		input Y_exp,
		input Y_out,
		input reg [5*8:1] result
	);
	begin
		$display("%s | %b | %b | %b | %b | %b | %b | %b | %b | %s",
					  test_name, A1_in, A2_in, A3_in, B1_in, B2_in, B3_in, Y_exp, Y_out, result);
	end
	endtask
	
	task apply_test(
		input reg [25*8:1] test_name,
		input A1_in,
		input A2_in,
		input A3_in,
		input B1_in,
		input B2_in,
		input B3_in,
		input Y_exp,
		output reg result
	);
	begin
		apply_inputs(A1_in, A2_in, A3_in, B1_in, B2_in, B3_in);
		
		if (sig_Y === Y_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, A1_in, A2_in, A3_in, B1_in, B2_in, B3_in, Y_exp, sig_Y, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, A1_in, A2_in, A3_in, B1_in, B2_in, B3_in, Y_exp, sig_Y, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
		input A1_in,
		input A2_in,
		input A3_in,
		input B1_in,
		input B2_in,
		input B3_in
	);
	begin
		sig_A1 = A1_in;
		sig_A2 = A2_in;
		sig_A3 = A3_in;
		sig_B1 = B1_in;
		sig_B2 = B2_in;
		sig_B3 = B3_in;
		
		#5;
	end
	endtask
	 
endmodule
