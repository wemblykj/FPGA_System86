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

module mb111_ft1_tff_tb;
	
	// Inputs
	reg sig_CLK;
	reg sig_bSET;
	reg sig_bRES;

	// Outputs
	wire sig_Q;
	wire sig_XQ;

	// Instantiate the Unit Under Test (UUT)
	mb111_ft1_tff
		uut (
			.CLK(sig_CLK), 
			.Q(sig_Q), 
			.XQ(sig_XQ), 
			.bSET(sig_bSET), 
			.bRES(sig_bRES)
		);

	reg test_bRESult;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 1, 1);
		
		// Wait 100 ns for global rebSET to finish
		#10;
		
		// Add stimulus here

		write_header("divide-by-2");
		
		apply_test("rebSET (leading)", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_bRESult);
		
		apply_test("rebSET (tick)", /*CLK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_bRESult);
		apply_test("rebSET (tock)", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_bRESult);
		
		apply_test("rebSET (trailing)", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_bRESult);
		
		apply_test("bSET (leading)", /*CLK=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		apply_test("bSET (tick)", /*CLK=*/1'b1, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		apply_test("bSET (tock)", /*CLK=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		apply_test("bSET (trailing)", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);

		// rebSET
		#5;
		apply_inputs(0, 1, 0);
		apply_inputs(0, 1, 1);
		
		apply_test("tick", /*CLK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		apply_test("tock", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		apply_test("tick", /*CLK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_bRESult);
		apply_test("tock", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_bRESult);
		apply_test("tick", /*CLK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		apply_test("tock", /*CLK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_bRESult);
		
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] bSET_name
	);
	begin
		$display("------------------------------------------------------------------------------------------");
		$display("%s | CLK    | bSET | bRES | XQ_exp  | Q_exp  | XQ  | Q    | bRESULT", bSET_name);
		$display("------------------------------------------------------------------------------------------");
	end
	endtask
	
	task write_bRESult(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input bSET,
	 input bRES,
	 input Q_exp,
	 input XQ_exp,
	 input Q,
	 input XQ,
	 input reg [5*8:1] bRESult
	);
	begin
	   //           | CLK | bSET | bRES | Q_exp | XQ_exp | Q |  XQ | bRESULT
		$display("%s |   %b |   %b |   %b |      %b |     %b |  %b |  %b |  %s",
					  test_name, CLK, bSET, bRES, Q_exp, XQ_exp, Q, XQ, bRESult);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input bSET,
	 input bRES,
	 input Q_exp,
	 input XQ_exp,
	 output reg bRESult
	);
	begin
		apply_inputs(CLK, bSET, bRES);
		
		if (sig_Q === Q_exp && sig_XQ === XQ_exp) begin
		  bRESult = 1; // Test passed
		  write_bRESult(test_name, CLK, bSET, bRES, Q_exp, XQ_exp, sig_Q, sig_XQ, "PASS");
		end else begin
		  bRESult = 0; // Test failed
		  write_bRESult(test_name, CLK, bSET, bRES, Q_exp, XQ_exp, sig_Q, sig_XQ, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input CLK,
	 input bSET,
	 input bRES
	);
	begin
		sig_CLK = CLK;
		sig_bSET = bSET;
		sig_bRES = bRES;

		#5;
	end
	endtask
	
endmodule
