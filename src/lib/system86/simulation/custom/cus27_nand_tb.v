module cus27_nand_tb;

  // Declare testbench signals
  reg A, B, C, D;
  wire Y;
  
  // Instantiate the DUT (Device Under Test)
  cus27_nand dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .Y(Y)
  );

  // Helper function to resolve high-impedance inputs
  function resolve(input sig);
    if (sig === 1'bz) resolve = 1;
    else resolve = sig;
  endfunction

	reg expected;
	
  // Task to apply inputs, check output, and display results
  task test_case(input tA, tB, tC, tD);
    begin
      
      A = tA;
      B = tB;
      C = tC;
      D = tD;
      #10; // Wait for the DUT to process the inputs

      // Expected output calculation
      expected = ~(resolve(A) & resolve(B) & resolve(C) & resolve(D));

      // Display the results
      $display("%4t | %b %b %b %b | %b | %b | %s", 
        $time, A, B, C, D, Y, expected, (Y === expected) ? "PASS" : "FAIL");

    end
  endtask

  // Begin testing
  initial begin
    // Display header for readability in simulation output
    $display("Time | A B C D | Y | EXPECTED | RESULT");
    $display("-----|---------|---|----------|-------");

    // Test all possible combinations of A, B, C, D
    test_case(0, 0, 0, 0);
    test_case(0, 0, 0, 1);
    test_case(0, 0, 1, 0);
    test_case(0, 0, 1, 1);
    test_case(0, 1, 0, 0);
    test_case(0, 1, 0, 1);
    test_case(0, 1, 1, 0);
    test_case(0, 1, 1, 1);
    test_case(1, 0, 0, 0);
    test_case(1, 0, 0, 1);
    test_case(1, 0, 1, 0);
    test_case(1, 0, 1, 1);
    test_case(1, 1, 0, 0);
    test_case(1, 1, 0, 1);
    test_case(1, 1, 1, 0);
    test_case(1, 1, 1, 1);

    // Test high-impedance (z) inputs
    test_case(1'bz, 1, 1, 1);
    test_case(1, 1'bz, 1, 1);
    test_case(1, 1, 1'bz, 1);
    test_case(1, 1, 1, 1'bz);
    test_case(1'bz, 1'bz, 1'bz, 1'bz);

    // End simulation
    $finish;
  end

endmodule