// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_bus_word_cache
//  File         : tb_bus_word_cache.sv
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

module tb_bus_word_cache;

    // Parameters
    parameter PORT_ADDR_WIDTH = 16;
    parameter BUS_ADDR_WIDTH  = 32;
    parameter BUS_DATA_WIDTH  = 32;
  
  	// Signals
    reg clk, rst;
    reg [BUS_ADDR_WIDTH-1:0] req_addr;
    reg req_valid;
    reg invalidate;
    wire [BUS_DATA_WIDTH-1:0] cache_word;
    wire cache_valid;
    wire busy;
    wire bus_req;
    reg  bus_grant;
    reg  bus_valid;
    reg  [BUS_DATA_WIDTH-1:0] bus_rdata;

    // Instantiate DUT
    bus_word_cache #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .req_addr(req_addr),
        .req_valid(req_valid),
        .invalidate(invalidate),
        .cache_word(cache_word),
        .cache_valid(cache_valid),
        .busy(busy),
        .bus_req(bus_req),
        .bus_grant(bus_grant),
        .bus_valid(bus_valid),
        .bus_rdata(bus_rdata)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test vectors
    // For simplicity, use port addresses that only ever use the lower PORT_ADDR_WIDTH bits
    localparam [PORT_ADDR_WIDTH-1:0] PORT_ADDR0 = 16'h0004;
    localparam [PORT_ADDR_WIDTH-1:0] PORT_ADDR1 = 16'h0008;
    localparam [BUS_DATA_WIDTH-1:0] DATA0 = 32'hDEADBEEF;
    localparam [BUS_DATA_WIDTH-1:0] DATA1 = 32'hCAFEBABE;

    // Task to simulate a bus read transaction
    task simulate_bus_read(input [BUS_DATA_WIDTH-1:0] return_data);
        begin
            bus_grant = 1;
            #10;
            bus_grant = 0;
            #10;
            bus_rdata = return_data;
            bus_valid = 1;
            #10;
            bus_valid = 0;
        end
    endtask

    // Main stimulus
    initial begin
        rst = 1;
        req_addr = 0;
        req_valid = 0;
        invalidate = 0;
        bus_grant = 0;
        bus_valid = 0;
        bus_rdata = 0;
        #25;
        rst = 0;
        #10;

        // 1. Read ADDR0 (expect miss, bus read, cache update)
        $display("TEST 1: Cache miss, request ADDR0");
        req_addr = PORT_ADDR0;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (cache_valid)
            $display("FAIL: Cache should not be valid for ADDR0 before refill.");
        else
            $display("PASS: Cache not valid for ADDR0 before refill.");
        wait (bus_req);
        $display("Bus request detected (miss).");
        simulate_bus_read(DATA0); // Simulate returning DATA0

        // After refill, issue a NEW read to check for cache hit
        #10;
        req_addr = PORT_ADDR0;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (cache_valid && cache_word == DATA0 && !bus_req)
            $display("PASS: Cache updated with DATA0 and valid.");
        else
            $display("FAIL: Cache did not update correctly or not valid.");

        // 2. Read ADDR0 again (expect hit, no bus read)
        $display("TEST 2: Cache hit, request ADDR0 again");
        req_addr = PORT_ADDR0;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (cache_valid && cache_word == DATA0 && !bus_req)
            $display("PASS: Cache hit, no bus request, correct data.");
        else
            $display("FAIL: Cache hit logic failed.");

        // 3. Read ADDR1 (different word, expect miss, bus read)
        $display("TEST 3: Cache miss, request ADDR1");
        req_addr = PORT_ADDR1;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (cache_valid)
            $display("FAIL: Cache should not be valid for ADDR1 before refill.");
        else
            $display("PASS: Cache not valid for ADDR1 before refill.");
        wait (bus_req);
        $display("Bus request detected (miss on ADDR1).");
        simulate_bus_read(DATA1); // Simulate returning DATA1

        // After refill, issue a NEW read to check for cache hit
        #10;
        req_addr = PORT_ADDR1;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (cache_valid && cache_word == DATA1 && !bus_req)
            $display("PASS: Cache updated with DATA1.");
        else
            $display("FAIL: Cache did not update correctly for ADDR1.");

        // 4. Cache invalidation
        $display("TEST 4: Invalidate cache, then request ADDR1 (should miss)");
        invalidate = 1;
        #10;
        invalidate = 0;
        req_addr = PORT_ADDR1;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (!cache_valid)
            $display("PASS: Cache correctly invalidated.");
        else
            $display("FAIL: Cache was not invalidated.");

        wait (bus_req);
        simulate_bus_read(DATA1); // Refill with DATA1

        // After refill, check for cache hit again
        #10;
        req_addr = PORT_ADDR1;
        req_valid = 1;
        #10;
        req_valid = 0;
        #1;
        if (cache_valid && cache_word == DATA1)
            $display("PASS: Cache hit after refill post-invalidate.");
        else
            $display("FAIL: Cache hit not detected after refill post-invalidate.");

        $display("All tests complete.");
        #20 $finish;
    end
endmodule