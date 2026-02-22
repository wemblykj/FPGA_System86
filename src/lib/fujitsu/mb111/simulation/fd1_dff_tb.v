`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:13:36 01/07/2026
// Design Name:   cus27_dff_tb
// Module Name:   C:/Users/paulw/Development/FPGA/FPGA_System86/src/lib/system86/simulation/custom/furrtek/cus27_dff_tb.v
// Project Name:  rthunder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cus27_dff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mb111_fd1_dff_tb;
	
	// Inputs
	reg sig_CLK;
	reg sig_D;
	reg sig_bSET;
	reg sig_bRES;

	// Outputs
	wire sig_Q;
	wire sig_bQ;

	// Instantiate the Unit Under Test (UUT)
	mb111_fd1_dff
		uut (
			.CLK(sig_CLK), 
			.D(sig_D),
			.Q(sig_Q),
			.bQ(sig_bQ), 
			.bSET(sig_bSET), 
			.bRES(sig_bRES)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 1, 0);	// reset
		apply_inputs(0, 0, 1, 1);
		
		// Wait 10 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("D-type Flip-flop");
		
		write_divider();
		
		apply_test("set (leading)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("set (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("set (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("set (trailing)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);

		write_divider();

		apply_test("reset (leading)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("reset (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("reset (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("reset (trailing)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		write_divider();
		
		apply_test("set (leading)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("set (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("set (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("set (trailing)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1, 0);
		apply_inputs(0, 0, 1, 1);
		#5;
		
		write_divider();
		
		// Initial low, D low - no change
		
		apply_test("~D", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~D (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~D (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~D (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~D (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1, 0);
		apply_inputs(0, 0, 1, 1);
		#5;
		
		write_divider();
		
		// Initial low, D high - latch high on tick
		
		apply_test("D", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("D (tick)", /*CLK=*/1'b1, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("D (tock)", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("D (tick)", /*CLK=*/1'b1, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("D (tock)", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
			
		// bSET
		#5;
		apply_inputs(0, 0, 0, 1);
		apply_inputs(0, 0, 1, 1);
		#5;
		
		write_divider();
		
		// Initial high, D low - latch low on tick
		
		apply_test("~D", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~D (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~D (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~D (tick)", /*CLK=*/1'b1, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~D (tock)", /*CLK=*/1'b0, /*D=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		// set
		#5;
		apply_inputs(0, 0, 0, 1);
		apply_inputs(0, 0, 1, 1);
		#5;
		
		write_divider();
		
		// Initial high, D high - no change
		
		apply_test("D", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("D (tick)", /*CLK=*/1'b1, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("D (tock)", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("D (tick)", /*CLK=*/1'b1, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("D (tock)", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("D (tick)", /*CLK=*/1'b1, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("D (tock)", /*CLK=*/1'b0, /*D=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] bSET_name
	);
	begin
		write_divider();
		$display("%s | CLK    | D   | bSET | bRES | Q_exp  | bQ_exp  | Q  | bQ    | result", bSET_name);
		write_divider();
	end
	endtask
	
	task write_divider();
		$display("------------------------------------------------------------------------------------------");
	endtask
	
	task write_result(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input D,
	 input bSET,
	 input bRES, 
	 input Q_exp,
	 input bQ_exp,
	 input Q,
	 input bQ,
	 input reg [5*8:1] result
	);
	begin
	   //           | CLK | D   | bSET | bRES | Q_exp | bQ_exp | Q |  bQ | result
		$display("%s |   %b |   %b |   %b |   %b |      %b |     %b |  %b |  %b |  %s",
					  test_name, CLK, D, bSET, bRES, Q_exp, bQ_exp, Q, bQ, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input D,	 
	 input bSET,
	 input bRES,
	 input Q_exp,
	 input bQ_exp,
	 output reg result
	);
	begin
		apply_inputs(CLK, D, bSET, bRES);
		
		#5;
		
		if (sig_Q === Q_exp && sig_bQ === bQ_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, CLK, D, bSET, bRES, Q_exp, bQ_exp, sig_Q, sig_bQ, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, CLK, D, bSET, bRES, Q_exp, bQ_exp, sig_Q, sig_bQ, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input CLK,
	 input D,
	 input bSET,
	 input bRES
	);
	begin
		sig_CLK = CLK;
		sig_D = D;
		sig_bSET = bSET;
		sig_bRES = bRES;

		#5;
	end
	endtask
	
endmodule
