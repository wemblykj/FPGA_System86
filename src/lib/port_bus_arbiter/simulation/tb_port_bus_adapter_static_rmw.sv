// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_port_bus_adapter_static_rmw
//  File         : tb_port_bus_adapter_static_rmw.sv
//  Author       : Paul Wightmore
//  Created      : 2025-10-07
//  Description  : 
//      <Short description of what this testbench verifies/tests.>
//
//  DUT          : port_bus_adapter.sv
//  Dependencies : 
//      - bus_word_cache.sv
//      - element_extractor.sv 
//      - element_inserter.sv
//      - addr_mapper.sv
//      - bus_req_fsm.sv
// 
//  Revision History:
//      Date        By               Version  Change Description
//      ----------  ---------------  -------  ----------------------------------
//      2025-10-07  Paul Wightmore   v0.01    Proof of concepts
//      2025-10-15  Paul Wightmore   v0.02    Fixed data width mismatch in comparisons
//      2025-10-15  Paul Wightmore   v0.03    Enhanced fake memory pattern for better byte identification
//      2025-10-15  Paul Wightmore   v0.04    Added debug output to bus simulation methods
//      2025-10-15  Paul Wightmore   v0.05    Fixed word address calculation in bus simulation routines
//
//  License      : https://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------------------------
//  Copyright (c) 2025 Paul Wightmore. All rights reserved.
// -----------------------------------------------------------------------------

`timescale 1ns/1ps

module tb_port_bus_adapter_static_rmw;

    // Parameters (adjust if needed)
    parameter PORT_ADDR_WIDTH   = 12;
    parameter PORT_DATA_WIDTH   = 8;
    parameter BUS_ADDR_WIDTH    = 32;
    parameter BUS_DATA_WIDTH    = 32;
    parameter BASE_ADDR_STATIC  = 32'h0000_0000;
    parameter USE_DYNAMIC_BASE  = 0;    // 0 = static, 1 = dynamic
    parameter USE_STROBE        = 0; 	// 0 = RMW, 1 = strobe
    parameter DEBUG_ENABLE      = 0;    // Set to 1 to enable debug output

    // Localparams
    localparam int ELEMENTS_PER_WORD   = BUS_DATA_WIDTH / PORT_DATA_WIDTH;
    localparam int BUS_WORD_SHIFT   = $clog2(ELEMENTS_PER_WORD);
    localparam int CACHE_ADDR_WIDTH = PORT_ADDR_WIDTH - BUS_WORD_SHIFT;

    // DUT signals
    reg clk, rst;
    reg port_cs, port_wr;
    reg [PORT_ADDR_WIDTH-1:0] port_addr;
    reg [PORT_DATA_WIDTH-1:0] port_data_i;
    wire [PORT_DATA_WIDTH-1:0] port_data_o;
    wire port_ready;
    reg [BUS_ADDR_WIDTH-1:0] base_addr_dynamic = 0;

    wire bus_req, bus_wr;
    wire [BUS_ADDR_WIDTH-1:0] bus_addr;
    wire [BUS_DATA_WIDTH-1:0] bus_wdata;
    wire [BUS_DATA_WIDTH/8-1:0] bus_wstrb;
    reg bus_grant, bus_valid;
    reg [BUS_DATA_WIDTH-1:0] bus_rdata;

    // DUT instantiation
    port_bus_adapter #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH),
        .BASE_ADDR_STATIC(BASE_ADDR_STATIC),
        .USE_DYNAMIC_BASE(USE_DYNAMIC_BASE),
        .USE_STROBE(USE_STROBE)
    ) dut (
        .clk(clk),
        .rst(rst),
        .port_cs(port_cs),
        .port_wr(port_wr),
        .port_addr(port_addr),
        .port_data_i(port_data_i),
        .port_data_o(port_data_o),
        .port_ready(port_ready),
        .base_addr_dynamic(base_addr_dynamic),
        .bus_req(bus_req),
        .bus_wr(bus_wr),
        .bus_addr(bus_addr),
        .bus_wdata(bus_wdata),
        .bus_wstrb(bus_wstrb),
        .bus_grant(bus_grant),
        .bus_rdata(bus_rdata),
        .bus_valid(bus_valid)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Simple single-word memory model for bus
    reg [BUS_DATA_WIDTH-1:0] fake_mem [0:(1<<CACHE_ADDR_WIDTH)-1];

    // Helper: Get bus word-aligned address from port_addr
    function [CACHE_ADDR_WIDTH-1:0] word_addr(input [PORT_ADDR_WIDTH-1:0] addr);
        word_addr = addr[PORT_ADDR_WIDTH-1:BUS_WORD_SHIFT];
    endfunction

    // Helper: Extract the appropriate element bits from a source word based on address
    function [PORT_DATA_WIDTH-1:0] extract_element(
        input [BUS_DATA_WIDTH-1:0] word, 
        input [PORT_ADDR_WIDTH-1:0] addr
    );
        // Calculate element offset within the word (based on low address bits)
        //int element_offset = addr[BUS_WORD_SHIFT-1:0];
        //logic [BUS_WORD_SHIFT-1:0] element_offset = int'(addr[BUS_WORD_SHIFT-1:0]);
        
        if (DEBUG_ENABLE) $display("DEBUG: extract_element - addr=0x%h, element_offset=%0d, extracting bits [%0d:%0d]", 
                 addr, addr[BUS_WORD_SHIFT-1:0], (addr[BUS_WORD_SHIFT-1:0]*PORT_DATA_WIDTH)+(PORT_DATA_WIDTH-1), addr[BUS_WORD_SHIFT-1:0]*PORT_DATA_WIDTH);
                 
        // Extract and return the appropriate element (PORT_DATA_WIDTH bits)
        return word[addr[BUS_WORD_SHIFT-1:0]*PORT_DATA_WIDTH +: PORT_DATA_WIDTH];
    endfunction

    // Bus response task (simulates latency, grants, and data from memory)
    task automatic bus_read_respond(input [BUS_ADDR_WIDTH-1:0] addr);
        reg [CACHE_ADDR_WIDTH-1:0] waddr;
        begin
            // Just use the lower bits directly - assume addr is already word-aligned
            waddr = addr[CACHE_ADDR_WIDTH-1:0];
            
            if (DEBUG_ENABLE) $display("DEBUG: bus_read_respond - BUS REQUEST to address 0x%h", addr);
            if (DEBUG_ENABLE) $display("DEBUG: bus_read_respond - Word address calculated: 0x%h", waddr);
            
            // grant after 1 cycle, then valid/data after 2 cycles
            @(negedge clk);
            bus_grant = 1;
            @(negedge clk);
            bus_grant = 0;
            // Provide data
            bus_rdata = fake_mem[waddr];
            
            if (DEBUG_ENABLE) begin
                $display("DEBUG: bus_read_respond - Returning word 0x%h from fake_mem[0x%h]", fake_mem[waddr], waddr);
                $display("DEBUG: bus_read_respond - Byte 0: 0x%h, Byte 1: 0x%h, Byte 2: 0x%h, Byte 3: 0x%h", 
                     fake_mem[waddr][7:0], fake_mem[waddr][15:8], 
                     fake_mem[waddr][23:16], fake_mem[waddr][31:24]);
            end
            
            @(negedge clk);
            bus_valid = 1;
            @(negedge clk);
            bus_valid = 0;
        end
    endtask

    // Bus write response (simulate memory write)
    task automatic bus_write_respond(input [BUS_ADDR_WIDTH-1:0] addr, input [BUS_DATA_WIDTH-1:0] data);
        reg [CACHE_ADDR_WIDTH-1:0] waddr;
        reg [BUS_DATA_WIDTH-1:0] old_val;
        begin
            // Just use the lower bits directly - assume addr is already word-aligned
            waddr = addr[CACHE_ADDR_WIDTH-1:0];
            
            if (DEBUG_ENABLE) $display("DEBUG: bus_write_respond - BUS WRITE to address 0x%h", addr);
            if (DEBUG_ENABLE) $display("DEBUG: bus_write_respond - Word address calculated: 0x%h", waddr);
            if (DEBUG_ENABLE) $display("DEBUG: bus_write_respond - Data to write: 0x%h", data);
            
            @(negedge clk);
            bus_grant = 1;
            @(negedge clk);
            bus_grant = 0;
            
            // Store old value for debug
            old_val = fake_mem[waddr];
            fake_mem[waddr] = data;
            
            if (DEBUG_ENABLE) $display("DEBUG: bus_write_respond - Updated word at fake_mem[0x%h]: 0x%h -> 0x%h", 
                     waddr, old_val, data);
            
            // Simulate write response
            @(negedge clk);
            bus_valid = 1;
            @(negedge clk);
            bus_valid = 0;
        end
    endtask

    // Helper function for test validation
    function automatic void check_result(
        input [PORT_ADDR_WIDTH-1:0] addr,
        input [PORT_DATA_WIDTH-1:0] actual,
        input [PORT_DATA_WIDTH-1:0] expected,
        input bit expect_bus_req = 0,
        input string test_name
    );
        if (actual == expected && bus_req == expect_bus_req)
            $display("PASS: %s, data 0x%h", test_name, actual);
        else
            $display("FAIL: %s at addr 0x%h, got 0x%h, expected 0x%h, bus_req=%b", 
                     test_name, addr, actual, expected, bus_req);
    endfunction
    
    // Helper: Get the expected byte value at a given address
    function [PORT_DATA_WIDTH-1:0] get_expected_byte(
        input [PORT_ADDR_WIDTH-1:0] addr
    );
        return extract_element(fake_mem[word_addr(addr)], addr);
    endfunction

    // Test procedure
    initial begin
        integer test_case = 0;
        integer i;
        integer hit_count = 0;
        reg [7:0] b0, b1, b2, b3;
      
        // Init
        rst = 1;
        port_cs = 0; port_wr = 0; port_addr = 0; port_data_i = 0;
        bus_grant = 0; bus_valid = 0; bus_rdata = 0;
        
        // Preload fake memory with known pattern - each byte has a distinct value
        for (i = 0; i < (1<<CACHE_ADDR_WIDTH); i = i+1) begin
            // Calculate each byte separately
            b0 = 8'd0 + (i * ELEMENTS_PER_WORD); // Byte 0 (least significant): 0, 4, 8, ...
            b1 = 8'd1 + (i * ELEMENTS_PER_WORD); // Byte 1: 1, 5, 9, ...
            b2 = 8'd2 + (i * ELEMENTS_PER_WORD); // Byte 2: 2, 6, 10, ...
            b3 = 8'hA0;                       // Byte 3 (most significant): 0xA0 (marker)
            
            // Combine bytes into 32-bit word (concatenate bytes in big-endian order)
            fake_mem[i] = {b3, b2, b1, b0};
            
            // For example:
            // Word 0: 0xA0020100
            // Word 1: 0xA0060504
            // Word 2: 0xA00A0908
            
            if (DEBUG_ENABLE) $display("Memory word %0d initialized to: 0x%08h", i, fake_mem[i]);
        end
        
        @(negedge clk); rst = 0;
        @(negedge clk);

        $display("=== TEST %0d: Read miss/fill/hit on address 0x004 ===", ++test_case);
        // Read from 0x004 (should trigger miss/fill)
        port_addr = 12'h004;
        port_cs = 1; port_wr = 0;
        @(negedge clk); port_cs = 0;
        fork
            bus_read_respond(bus_addr);
        join_none
        wait (port_ready);
        @(negedge clk); // settle
        
        if (DEBUG_ENABLE) begin
            $display("DEBUG: Test %0d - For port_addr=0x%h: ", test_case, port_addr);
            $display("DEBUG: Test %0d - word_addr=%h, byte expected=0x%h, port_data_o=0x%h", test_case,
                 word_addr(port_addr), get_expected_byte(port_addr), port_data_o);
        end
        
        check_result(port_addr, port_data_o, get_expected_byte(port_addr), 
             0, "Read miss/fill");

        // Read from 0x004 again (should be cache hit, no bus access)
        $display("=== TEST %0d: Read hit (cached) on address 0x004 ===", ++test_case);
        port_addr = 12'h004;
        port_cs = 1; port_wr = 0;
        @(negedge clk); port_cs = 0;
        wait (port_ready);
        @(negedge clk);
        
        if (DEBUG_ENABLE) begin
            $display("DEBUG: Test %0d - For port_addr=0x%h: ", test_case, port_addr);
            $display("DEBUG: Test %0d - word_addr=%h, byte expected=0x%h, port_data_o=0x%h", test_case,
                 word_addr(port_addr), get_expected_byte(port_addr), port_data_o);
        end
        
        check_result(port_addr, port_data_o, get_expected_byte(port_addr), 
             0, "Cache hit");
        
        // Read from 0x018 (different word, triggers miss/refill)
        $display("=== TEST %0d: Read miss/refill on address 0x018 ===", ++test_case);
        port_addr = 12'h018;
        port_cs = 1; port_wr = 0;
        @(negedge clk); port_cs = 0;
        fork
            bus_read_respond(bus_addr);
        join_none
        wait (port_ready);
        @(negedge clk);
        
        if (DEBUG_ENABLE) begin
            $display("DEBUG: Test %0d - For port_addr=0x%h: ", test_case, port_addr);
            $display("DEBUG: Test %0d - word_addr=%h, byte expected=0x%h, port_data_o=0x%h", test_case,
                 word_addr(port_addr), get_expected_byte(port_addr), port_data_o);
        end
        
        check_result(port_addr, port_data_o, get_expected_byte(port_addr),
             0, "Read miss/refill");
        
        // Read from 0x018 again (should be cache hit)
        $display("=== TEST %0d: Read hit (cached) on address 0x018 ===", ++test_case);
        port_addr = 12'h018;
        port_cs = 1; port_wr = 0;
        @(negedge clk); port_cs = 0;
        wait (port_ready);
        @(negedge clk);
        
        if (DEBUG_ENABLE) begin
            $display("DEBUG: Test %0d - For port_addr=0x%h: ", test_case, port_addr);
            $display("DEBUG: Test %0d - word_addr=%h, byte expected=0x%h, port_data_o=0x%h", test_case,
                 word_addr(port_addr), get_expected_byte(port_addr), port_data_o);
        end
        
        check_result(port_addr, port_data_o, get_expected_byte(port_addr),
             0, "Cache hit #2");

        // Write to 0x018 (should invalidate cache)
        $display("=== TEST %0d: Write to 0x018 (should invalidate cache) ===", ++test_case);
        port_addr = 12'h018;
        port_data_i = 8'hFE;
        port_cs = 1; port_wr = 1;
        @(negedge clk); port_cs = 0;
        fork
            bus_write_respond(bus_addr, 32'hBAD0_00FF);
        join_none
        wait (port_ready);
        @(negedge clk);
        $display("Write complete - cache should now be invalidated for addr 0x%h", port_addr);

        // Read from 0x018 (should be a miss/refill after invalidation)
        $display("=== TEST %0d: Read after write (should be miss/refill) on 0x018 ===", ++test_case);
        port_addr = 12'h018;
        port_cs = 1; port_wr = 0;
        @(negedge clk); port_cs = 0;
        fork
            bus_read_respond(bus_addr);
        join_none
        wait (port_ready);
        @(negedge clk);
        
        if (DEBUG_ENABLE) begin
            $display("DEBUG: Test %0d - For port_addr=0x%h: ", test_case, port_addr);
            $display("DEBUG: Test %0d - word_addr=%h, byte expected=0x%h, port_data_o=0x%h", test_case,
                 word_addr(port_addr), get_expected_byte(port_addr), port_data_o);
        end
        
        check_result(port_addr, port_data_o, get_expected_byte(port_addr),
             0, "Read after write");
       
        // Test bitslicing: read from addresses that differ only in lower bits (should hit same word)
        $display("=== TEST %0d: Bitslice test: 0x01C through 0x01F (in same word) ===", ++test_case);

        // First load the word into cache with a regular read
        port_addr = 12'h01C;
        port_cs = 1; port_wr = 0;
        @(negedge clk); port_cs = 0;
        fork
            bus_read_respond(bus_addr);
        join_none
        wait (port_ready);
        @(negedge clk);
        
        if (DEBUG_ENABLE) begin
            $display("DEBUG: Test %0d - Initial cache load with addr 0x%h", test_case, port_addr);
            $display("DEBUG: Test %0d - word_addr=%h, byte expected=0x%h, port_data_o=0x%h", test_case,
                 word_addr(port_addr), get_expected_byte(port_addr), port_data_o);
        end
        
        // Now check if each byte in the word can be accessed without triggering a bus request
        hit_count = 0;
        for (i = 0; i < ELEMENTS_PER_WORD; i=i+1) begin
            port_addr = 12'h01C + i;
            
            if (DEBUG_ENABLE) begin
                $display("\nDEBUG: Test %0d - Iteration %0d: port_addr=0x%h", test_case, i, port_addr);
                $display("DEBUG: Test %0d - word_addr=%h, byte offset=%0d", test_case, word_addr(port_addr), port_addr[BUS_WORD_SHIFT-1:0]);
                $display("DEBUG: Test %0d - Expected data: 0x%h", test_case, get_expected_byte(port_addr));
            
                // Check bus_req before asserting port_cs
                $display("DEBUG: Test %0d - bus_req before port_cs: %b", test_case, bus_req);
            end
            
            port_cs = 1; port_wr = 0;
            @(negedge clk); port_cs = 0;
            
            // Give some time to see if bus_req is asserted
            repeat(2) @(posedge clk);
            if (DEBUG_ENABLE) $display("DEBUG: Test %0d - bus_req after port_cs: %b", test_case, bus_req);
            
            // If bus_req is asserted, we need to respond
            if (bus_req) begin
                if (DEBUG_ENABLE) $display("DEBUG: Test %0d - Bus request detected, providing response", test_case);
                fork
                    bus_read_respond(bus_addr);
                join_none
            end
            
            wait (port_ready);
            @(negedge clk);
            
            if (DEBUG_ENABLE) $display("DEBUG: Test %0d - port_addr=0x%03X word_addr=0x%03X port_data_o=0x%h", test_case, port_addr, word_addr(port_addr), port_data_o);
            
            check_result(port_addr, port_data_o, get_expected_byte(port_addr),
                         0, $sformatf("Bitslice byte %0d", i));
            if (port_data_o == get_expected_byte(port_addr))
                hit_count++;
        end
        
        if (hit_count == ELEMENTS_PER_WORD)
            $display("PASS: All addresses in same word hit cache (bitslicing correct)");
        else
            $display("FAIL: Bitslice test failed, %0d/%0d hits", hit_count, ELEMENTS_PER_WORD);

        $display("All tests complete.");
        #40 $finish;
    end

endmodule