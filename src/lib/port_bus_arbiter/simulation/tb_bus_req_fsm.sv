// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_bus_req_fsm
//  File         : tb_bus_req_fsm.sv
//  Author       : Paul Wightmore
//  Created      : 2025-10-07
//  Description  : 
//      <Short description of what this testbench verifies/tests.>
//
//  DUT          : <Design Under Test module(s) and file(s)>
//  Dependencies : 
//      <List any required files or modules>
// 
//  Revision History:
//      Date        By               Version  Change Description
//      ----------  ---------------  -------  ----------------------------------
//      2025-10-07  Paul Wightmore   v0.01    Proof of concepts
//
//  License      : https://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------------------------
//  Copyright (c) 2025 Paul Wightmore. All rights reserved.
// -----------------------------------------------------------------------------

`timescale 1ns/1ps

module tb_bus_req_fsm;

    // DUT signals
    reg clk, rst;
    reg port_cs, port_wr;
    wire port_ready;
    wire bus_req, bus_wr;
    reg bus_grant, bus_valid;

    // Instantiate DUT
    bus_req_fsm #() dut (
        .clk(clk),
        .rst(rst),
        .port_cs(port_cs),
        .port_wr(port_wr),
        .ready(port_ready),
        .bus_req(bus_req),
        .bus_wr(bus_wr),
        .bus_grant(bus_grant),
        .bus_valid(bus_valid)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("Starting tb_bus_req_fsm...");

        // Initialize
        rst = 1;
        port_cs = 0;
        port_wr = 0;
        bus_grant = 0;
        bus_valid = 0;
        #20;

        rst = 0;
        #10;

        // Test 1: Simple Write Transaction
        $display("Test 1: Simple Write Transaction");
        port_wr = 1;
        port_cs = 1;    // Pulse cs
        #10;
        port_cs = 0;
        #10;
        if (!bus_req || !bus_wr)
            $display("FAIL: bus_req or bus_wr not asserted after port_cs on write");

        // Grant after 2 cycles
        #10 bus_grant = 1; #10 bus_grant = 0;
        // Valid after 2 more cycles
        #10 bus_valid = 1; #10 bus_valid = 0;

        // Wait and check port_ready returns
        #10;
        if (!port_ready)
            $display("FAIL: port_ready not asserted after transaction");
        else
            $display("PASS: Write transaction completed");

        // Test 2: Simple Read Transaction
        $display("Test 2: Simple Read Transaction");
        port_wr = 0;
        port_cs = 1; #10; port_cs = 0; #10;
        if (!bus_req || bus_wr)
            $display("FAIL: bus_req not asserted or bus_wr should not be set on read");

        // Grant after 2 cycles
        #10 bus_grant = 1; #10 bus_grant = 0;
        // Valid after 2 more cycles
        #10 bus_valid = 1; #10 bus_valid = 0;

        #10;
        if (!port_ready)
            $display("FAIL: port_ready not asserted after read transaction");
        else
            $display("PASS: Read transaction completed");

        // Test 3: Back-to-back Transactions
        $display("Test 3: Back-to-back Transactions");
        port_wr = 1;
        port_cs = 1; #10; port_cs = 0;
        #10 bus_grant = 1; #10 bus_grant = 0;
        #10 bus_valid = 1; #10 bus_valid = 0;
        #10;
        port_wr = 0;
        port_cs = 1; #10; port_cs = 0;
        #10 bus_grant = 1; #10 bus_grant = 0;
        #10 bus_valid = 1; #10 bus_valid = 0;
        #10;

        $display("PASS: Back-to-back transactions completed");

        $display("All tb_bus_req_fsm tests completed.");
        #20 $finish;
    end

endmodule