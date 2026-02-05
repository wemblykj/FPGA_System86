module cus27_jkff_tb;
	
	// Inputs
	reg sig_CLK;
	reg sig_bJ;
	reg sig_K;
	reg sig_SET;
	reg sig_RES;

	// Outputs
	wire sig_Q;
	wire sig_bQ;

	// Instantiate the Unit Under Test (UUT)
	cus27_jkff
		uut (
			.CLK(sig_CLK), 
			.J(sig_bJ),
			.K(sig_K),
			.Q(sig_Q), 
			.bQ(sig_bQ), 
			.SET(sig_SET), 
			.RES(sig_RES)
		);

	reg test_result;
	
	initial begin
		// Initialize Inputs
		apply_inputs(0, 0, 0, 0, 0);
		
		// Wait 100 ns for global reset to finish
		#10;
		
		// Add stimulus here

		write_header("JK Flip-flop");
		
		apply_test("reset (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("reset (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("reset (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b1, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("reset (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		write_divider();
		
		apply_test("set (leading)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b1, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("set (trailing)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);

		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// this appears to provide the toggle functionality (standard logic only J is inverted as per Furrtek schematics)
		
		// toggle
		// ~J = 1, K = 0 (toggle)
		
		apply_test("~JK", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// set
		// ~J = 0, K = 0 (set)
		apply_test("J", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// reset
		
		apply_test("K", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		// reset
		#5;
		apply_inputs(0, 0, 0, 0, 1);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// latch
		// JK = 1, ~J = 0, K = 1 (latch)
		apply_test("JK", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
	
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// toggle
		
		apply_test("~JK", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("~JK (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("~JK (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// set
		
		apply_test("J", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		apply_test("J (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		apply_test("J (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b0, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b1, /*bQ_exp=*/1'b0, test_result);
		
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// this appears to provide the toggle functionality (standard logic only J is inverted as per Furrtek schematics)
		// set
		
		apply_test("K", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);

		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("K (tick)", /*CLK=*/1'b1, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("K (tock)", /*CLK=*/1'b0, /*J=*/1'b0, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		// set
		#5;
		apply_inputs(0, 0, 0, 1, 0);
		apply_inputs(0, 0, 0, 0, 0);
		#5;
		
		write_divider();
		
		// JK = 1 - no change
		apply_test("JK", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		
		apply_test("JK (tick)", /*CLK=*/1'b1, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
		apply_test("JK (tock)", /*CLK=*/1'b0, /*J=*/1'b1, /*K=*/1'b1, /*SET=*/1'b0, /*RES=*/1'b0, /*Q_exp=*/1'b0, /*bQ_exp=*/1'b1, test_result);
	
		$finish;
	end
	
	task write_header(
	 input reg [25*8:1] set_name
	);
	begin
		write_divider();
		$display("%s | CLK    | J   | K   | SET | RES | Q_exp  | bQ_exp  | Q  | bQ    | RESULT", set_name);
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
	 input K,
	 input SET,
	 input RES, 
	 input Q_exp,
	 input bQ_exp,
	 input Q,
	 input bQ,
	 input reg [5*8:1] result
	);
	begin
	   //           | CLK | J   | K   | SET | RES | Q_exp | bQ_exp | Q |  bQ | RESULT
		$display("%s |   %b |   %b    %b |   %b |   %b |      %b |     %b |  %b |  %b |  %s",
					  test_name, CLK, J, K, SET, RES, Q_exp, bQ_exp, Q, bQ, result);
	end
	endtask
	
	task apply_test(
	 input reg [25*8:1] test_name,
	 input CLK,
	 input J,
	 input K,	 
	 input SET,
	 input RES,
	 input Q_exp,
	 input bQ_exp,
	 output reg result
	);
	begin
		apply_inputs(CLK, J, K, SET, RES);
		
		#5;
		
		if (sig_Q === Q_exp && sig_bQ === bQ_exp) begin
		  result = 1; // Test passed
		  write_result(test_name, CLK, J, K, SET, RES, Q_exp, bQ_exp, sig_Q, sig_bQ, "PASS");
		end else begin
		  result = 0; // Test failed
		  write_result(test_name, CLK, J, K, SET, RES, Q_exp, bQ_exp, sig_Q, sig_bQ, "FAIL");
		end
		
		#5;
	end
	endtask
	
	task apply_inputs(
	 input CLK,
	 input J,
	 input K,
	 input SET,
	 input RES
	);
	begin
		sig_CLK = CLK;
		sig_bJ = ~J;
		sig_K = K;
		sig_SET = SET;
		sig_RES = RES;

		#5;
	end
	endtask
	
endmodule
