module mb111_fj3_jxkff_tb;
	
	// Inputs
	reg sig_CLK;
	reg sig_J;
	reg sig_XK;
	reg sig_bSET;
	reg sig_bRES;

	// Outputs
	wire sig_Q;
	wire sig_XQ;

	// Instantiate the Unit Under Test (UUT)
	mb111_fj3_jxkff
		uut (
			.CLK(sig_CLK), 
			.J(sig_J),
			.XK(sig_XK),
			.Q(sig_Q), 
			.XQ(sig_XQ), 
			.bSET(sig_bSET), 
			.bRES(sig_bRES)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 1, 1, 1);
		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("JXK Flip-flop");
		
		apply_test("reset (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("reset (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("reset (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("reset (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		
		write_divider();
		
		apply_test("set (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("set (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("set (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b0, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("set (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);

		write_divider();

		apply_test("reset (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("reset (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("reset (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("reset (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b0, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1, 1, 0);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// this appears to provide the toggle functionality (standard logic only J is inverted as per Furrtek schematics)
		
		// J = 0, XK = 1 (toggle)
		
		apply_test("J=0 XK=1", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=0 XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);		
		apply_test("J=0 XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=0 XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1, 1, 0);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J = 0, XK = 0 (set)
		apply_test("J=0 XK=0", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=0 XK=0 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=0 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=0 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=0 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1, 1, 0);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J = 1, XK = 1 (reset)
		apply_test("J=1, XK=1", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1, XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1, XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1, XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1, XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 1, 1, 0);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J = 1, XK = 0 (latch)
		apply_test("J=1 XK =0", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1 XK =0 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1 XK =0 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);		
		apply_test("J=1 XK =0 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1 XK =0 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
	
		// set
		#5;
		apply_inputs(0, 0, 1, 0, 1);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J=0 XK=1 (toggle)
		
		apply_test("J=0 XK=1", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=0 XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);		
		apply_test("J=0 XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);

		// set
		#5;
		apply_inputs(0, 0, 1, 0, 1);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J=0 XK=0 (set)
		
		apply_test("J=0 XK=0", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=0 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=0 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);	
		apply_test("J=0 XK=0 (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=0 XK=0 (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);

		// set
		#5;
		apply_inputs(0, 0, 1, 0, 1);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J=1 XK=1 (reset)
		
		apply_test("J=1 XK=1", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=1 XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1 XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);	
		apply_test("J=1 XK=1 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);
		apply_test("J=1 XK=1 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b1, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b0, /*XQ_exp=*/1'b1, test_result);

		// set
		#5;
		apply_inputs(0, 0, 1, 0, 1);
		apply_inputs(0, 0, 1, 1, 1);
		#5;
		
		write_divider();
		
		// J=1 XK=0 (latch)
		
		apply_test("J=1 XK=0", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=1 XK=0 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=1 XK=0 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);	
		apply_test("J=1 XK=0 (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);
		apply_test("J=1 XK=0 (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*XK=*/1'b0, /*bSET=*/1'b1, /*bRES=*/1'b1, /*Q_exp=*/1'b1, /*XQ_exp=*/1'b0, test_result);

		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		write_divider();
		$display("%s | CLK    | J   | XK   | bSET | bRES | Q_exp  | XQ_exp  | Q  | XQ    | bRESULT", set_name);
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
	 input XK,
	 input bSET,
	 input bRES, 
	 input Q_exp,
	 input XQ_exp,
	 input Q,
	 input XQ,
	 input reg [5*8:1] result
	);
	begin
	   //           | CLK | J   | XK   | bSET | bRES | Q_exp | XQ_exp | Q |  XQ | bRESULT
		$display("%s |   %b |   %b    %b |   %b |   %b |      %b |     %b |  %b |  %b |  %s",
					  test_name, CLK, J, XK, bSET, bRES, Q_exp, XQ_exp, Q, XQ, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input J,
	 input XK,	 
	 input bSET,
	 input bRES,
	 input Q_exp,
	 input XQ_exp,
	 output reg result
	);
	begin
		apply_inputs(CLK, J, XK, bSET, bRES);
		
		#5;
		
		if (sig_Q === Q_exp && sig_XQ === XQ_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, CLK, J, XK, bSET, bRES, Q_exp, XQ_exp, sig_Q, sig_XQ, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, CLK, J, XK, bSET, bRES, Q_exp, XQ_exp, sig_Q, sig_XQ, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input CLK,
	 input J,
	 input XK,
	 input bSET,
	 input bRES
	);
	begin
		sig_CLK = CLK;
		sig_J = J;
		sig_XK = XK;
		sig_bSET = bSET;
		sig_bRES = bRES;

		#5;
	end
	endtask
	
endmodule
