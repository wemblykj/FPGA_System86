module cus27_jkff_tb;

  // Declare testbench signals
  reg CLK, J, K, bSET, bRES; // Standard JK inputs
  wire Q, bQ;

  // Instantiate the DUT (Device Under Test)
  cus27_jkff dut (
    .CLK(CLK),
    .bJ(~J),  // Invert J input into the DUT
    .K(K),
    .bSET(bSET),
    .bRES(bRES),
    .Q(Q),
    .bQ(bQ)
  );

  // Task to explicitly set the initial state of the JK flip-flop
  task automatic set_initial_state(input logic initial_Q);
    if (initial_Q == 1'b1) begin
      bSET = 1'b0; // Set condition
      bRES = 1'b1;
      CLK = 0; #5;
      CLK = 1; #5;
      bSET = 1'b1; // Release set
    end else begin
      bRES = 1'b0; // Reset condition
      bSET = 1'b1;
      CLK = 0; #5;
      CLK = 1; #5;
      bRES = 1'b1; // Release reset
    end
  endtask

  // Task to initialize test inputs
  task automatic initialize_inputs(input logic tJ, input logic tK, input logic tSET, input logic tRES);
    J = tJ;      // Standard J input
    K = tK;      // Standard K input
    bSET = tSET; // Active-low set input
    bRES = tRES; // Active-low reset input
  endtask

  // Task to apply a test case and manually tick the clock
  task automatic apply_test(
    input string test_name,
    input logic tJ,
    input logic tK,
    input logic initial_Q,  // Explicit initial state for the Q
    input logic tSET,
    input logic tRES,
    input logic expected_Q,
    input logic handle_unstable, // Flag for handling the unstable {Q, bQ} == {1, 1} state
    output logic result
  );
    // First, set the desired initial state of Q
    set_initial_state(initial_Q);

    // Initialize inputs
    initialize_inputs(tJ, tK, tSET, tRES);

    // Manually tick the clock for the test
    CLK = 0; #5;
    CLK = 1; #5;

    // Check results
    if (handle_unstable && tSET == 1'b0 && tRES == 1'b0) begin
      // Special case: Unstable state when both bSET and bRES are active-low
      if (Q === 1'b1 && bQ === 1'b1) begin
        result = 1; // Test passed
        $display("%-25s | %b    | %b | %b   | %b     | Unstable || %b   | %b    | PASS (Unstable State)",
                 test_name, tJ, tK, tSET, tRES, Q, bQ);
      end else begin
        result = 0; // Test failed
        $display("%-25s | %b    | %b | %b   | %b     | Unstable || %b   | %b    | FAIL (Unstable State)",
                 test_name, tJ, tK, tSET, tRES, Q, bQ);
      end
    end else begin
      // Normal cases
      if (Q === expected_Q && bQ === ~expected_Q) begin
        result = 1; // Test passed
        $display("%-25s | %b    | %b | %b   | %b     | %b     || %b   | %b    | PASS",
                 test_name, tJ, tK, tSET, tRES, expected_Q, Q, bQ);
      end else begin
        result = 0; // Test failed
        $display("%-25s | %b    | %b | %b   | %b     | %b     || %b   | %b    | FAIL",
                 test_name, tJ, tK, tSET, tRES, expected_Q, Q, bQ);
      end
    end
  endtask

  // Run simulation testbench
  initial begin
    // Signal result tracking
    logic test_result;

    // Display table header
    $display("------------------------------------------------------------------------------------------");
    $display("%-25s | J    | K | bSET | bRES  | Q_exp  || Q   | bQ    | RESULT", "Test Case");
    $display("------------------------------------------------------------------------------------------");

    // Test: Active-low Set
    apply_test("Async Set: bSET=0", 1'b0, 1'b0, /*initial_Q=*/1'b0, 1'b0, 1'b1, 1'b1, 0, test_result);

    // Test: Active-low Reset
    apply_test("Async Reset: bRES=0", 1'b0, 1'b0, /*initial_Q=*/1'b0, 1'b1, 1'b0, 1'b0, 0, test_result);

    // Test: Unstable state
    apply_test("Unstable State", 1'b0, 1'b0, /*initial_Q=*/1'bX, 1'b0, 1'b0, 1'bX, 1 /*handle_unstable*/, test_result);

    // Tests for hold functionality
    apply_test("J=0, K=0, Q=0: Hold", 1'b0, 1'b0, /*initial_Q=*/1'b0, 1'b1, 1'b1, 1'b0, 0, test_result);
    apply_test("J=0, K=0, Q=1: Hold", 1'b0, 1'b0, /*initial_Q=*/1'b1, 1'b1, 1'b1, 1'b1, 0, test_result);

    // Tests for toggle functionality
    apply_test("J=1, K=1, Q=0: Toggle", 1'b1, 1'b1, /*initial_Q=*/1'b0, 1'b1, 1'b1, 1'b1, 0, test_result);
    apply_test("J=1, K=1, Q=1: Toggle", 1'b1, 1'b1, /*initial_Q=*/1'b1, 1'b1, 1'b1, 1'b0, 0, test_result);

    // Tests for reset and set
    apply_test("J=0, K=1: Reset", 1'b0, 1'b1, /*initial_Q=*/1'b1, 1'b1, 1'b1, 1'b0, 0, test_result);
    apply_test("J=1, K=0: Set", 1'b1, 1'b0, /*initial_Q=*/1'b0, 1'b1, 1'b1, 1'b1, 0, test_result);

    // Finish simulation
    $display("------------------------------------------------------------------------------------------");
    $finish;
  end

endmodule