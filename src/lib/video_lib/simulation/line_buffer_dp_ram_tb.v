`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    March 2026
// Design Name:    line_buffer_dp_ram_tb
// Module Name:    line_buffer_dp_ram_tb.v 
// Project Name:   Video Library
// Target Devices: 
// Tool versions: 
// Description:    Scanline buffer memory testbench
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module line_buffer_dp_ram_tb;

  parameter AddrWidth = 4;
  parameter DataWidth = 8;

  logic clk_a;
  logic clk_b;
  logic we_a;
  logic [AddrWidth-1:0] addr_a;
  logic [DataWidth-1:0] wdata_a;
  logic [AddrWidth-1:0] addr_b;
  logic [DataWidth-1:0] rdata_b;

  line_buffer_dp_ram #(
    .AddrWidth(AddrWidth),
    .DataWidth(DataWidth)
  ) dut (
    .clk_a_i   (clk_a),
    .we_a_i    (we_a),
    .addr_a_i  (addr_a),
    .wdata_a_i (wdata_a),
    .clk_b_i   (clk_b),
    .addr_b_i  (addr_b),
    .rdata_b_o (rdata_b)
  );

  // Clock generation
  initial begin
    clk_a = 1'b0;
    forever #4 clk_a = ~clk_a;
  end
  initial begin
    clk_b = 1'b0;
    forever #2 clk_b = ~clk_b;
  end

  // Single write/read checker
  task automatic check_write_read(
    input [AddrWidth-1:0] addr,
    input [DataWidth-1:0] data
  );
    // Write phase: write on clk_a
    @(posedge clk_a);
    we_a   = 1'b1;
    addr_a = addr;
    wdata_a = data;
    @(posedge clk_a);
    we_a = 1'b0; // esure only single-cycle write

    // Read phase (port b)
    addr_b = addr;
    @(posedge clk_b); // Present address
    @(posedge clk_b); // Wait for synchronous read pipeline if RAM registers the output
    if (rdata_b !== data)
      $display("FAIL: Addr %0d | Expected: %0h, Got: %0h", addr, data, rdata_b);
    else
      $display("PASS: Addr %0d | Data: %0h", addr, rdata_b);
  endtask

  // Test sequence
  integer i;
  initial begin
    // Initialize signals
    we_a = 1'b0;
    addr_a = '0;
    wdata_a = '0;
    addr_b = '0;

    // Wait for clocks to stabilize
    repeat(2) @(posedge clk_a);
    repeat(2) @(posedge clk_b);

    // Write and read a handful of values
    check_write_read(4'd0, 8'h12);
    check_write_read(4'd3, 8'hAB);
    check_write_read(4'd7, 8'hFF);
    check_write_read(4'd15, 8'h01);

    // Optional: Loop through a pattern
    for (i = 0; i < 16; i = i + 1) begin
      check_write_read(i[AddrWidth-1:0], (i * 7) & 8'hFF);
    end

    $display("All tests completed.");
    $finish;
  end
endmodule
