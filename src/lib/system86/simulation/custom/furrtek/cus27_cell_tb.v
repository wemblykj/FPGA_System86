`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:09:51 02/02/2026
// Design Name:   cus27_cell
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/cus27_cell_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_cell
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cus27_cell_tb;

	// Inputs
	reg D1;
	reg D2;
	reg D3;
	reg D4;
	reg Q_IN;

	// Outputs
	wire bQ;
	wire Q;

	// Instantiate the Unit Under Test (UUT)
	cus27_cell uut (
		.D1(D1), 
		.D2(D2), 
		.D3(D3), 
		.D4(D4), 
		.Q_IN(Q_IN), 
		.bQ(bQ), 
		.Q(Q)
	);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		D1 = 0;
		D2 = 0;
		D3 = 0;
		D4 = 0;
		Q_IN = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		// divide-by-2 (TFF)
		
		write_header("CUS27 primitive");
		
		apply_test("test 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*Y_exp=*/1'b0, test_result);
		apply_test("test 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*Y_exp=*/1'b1, test_result);
		apply_test("test 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		apply_test("test 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		apply_test("test 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		apply_test("test 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*Y_exp=*/1'b1, test_result);
		
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | A    | B | C | Y_exp | bRES  | Q_exp  | Y    | RESULT", set_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input A,
	 input B,
	 input C,
	 input expected_Y,
	 input Y,
	 input reg [5*8:1] result
	);
	begin
		$display("%s | %b | %b | %b | %b | %b | %s",
					  test_name, A, B, C, expected_Y, Y, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input A,
	 input B,
	 input C,
	 input expected_Y,
	 output reg result
	);
	begin
		D4 = A;
		D3 = B;
		D2 = C;

		#5;
		
		if (bQ === expected_Y && Q !== expected_Y) begin
		  result = 1; // Test passed
		  write_result(test_name, A, B, C, expected_Y, bQ, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, A, B, C, expected_Y, bQ, "FAIL");
		end
	end
	endtask
	
endmodule
