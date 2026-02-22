`timescale 1ns / 100ps
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

module mb111_gate_tb;

	// Inputs
	reg A;
	reg B;
	reg C;
	reg D;
	reg AND_IN;
	reg NAND_IN;

	// Outputs
	wire F;
	wire AND_OUT;
	wire NAND_OUT;

	// Instantiate the Unit Under Test (UUT)
	mb111_gate uut (
		.A(A), 
		.B(B), 
		.C(C), 
		//.D(D), test as unconnected
		.AND_IN(AND_IN),
		.NAND_IN(NAND_IN), 
		.AND_OUT(AND_OUT),
		.NAND_OUT(NAND_OUT),
		.F(F)
	);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C = 0;
		D = 0;
		AND_IN = 1'bz;
		NAND_IN = 1'bz;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		
		// divide-by-2 (TFF)
		
		write_header("MB111 basic cell (standard speed grade)");
		
		apply_test("Single gate 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("Single gate 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		
		AND_IN = 1'b0;
		
		apply_test("AND inhibit 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("AND inhibit 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		
		AND_IN = 1'b1;
		
		apply_test("AND inactive 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("AND inactive 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		
		AND_IN = 1'bz;
		NAND_IN = 1'b1;
		
		apply_test("NAND inactive 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b1, test_result);
		apply_test("NAND inactive 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		
		NAND_IN = 1'b0;
		
		apply_test("NAND override 1", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 2", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b0, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 3", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 4", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b0, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 5", /*A=*/1'b0, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 6", /*A=*/1'b1, /*B=*/1'b0, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 7", /*A=*/1'b0, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		apply_test("NAND override 8", /*A=*/1'b1, /*B=*/1'b1, /*C=*/1'b1, /*F_exp=*/1'b0, test_result);
		
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | A    | B | C | F_exp | bRES  | F_exp  | F    | RESULT", set_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input A_in,
	 input B_in,
	 input C_in,
	 input F_exp,
	 input F_out,
	 input reg [5*8:1] result
	);
	begin
		$display("%s | %b | %b | %b | %b | %b | %s",
					  test_name, A_in, B_in, C_in, F_exp, F_out, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input A_in,
	 input B_in,
	 input C_in,
	 input F_exp,
	 output reg result
	);
	begin
		A = A_in;
		B = B_in;
		C = C_in;

		#5;
		
		if (F === F_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, A_in, B_in, C_in, F_exp, F, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, A_in, B_in, C_in, F_exp, F, "FAIL");
		end
	end
	endtask
	
endmodule
