// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_port_bus_adapter_static_rmw
//  File         : tb_port_bus_adapter_static_rmw.sv
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

module tb_port_bus_adapter_static_rmw;

    // Parameters
    parameter PORT_ADDR_WIDTH = 16;
    parameter PORT_DATA_WIDTH = 8;
    parameter BUS_ADDR_WIDTH = 32;
    parameter BUS_DATA_WIDTH = 32;
    parameter BASE_ADDR_STATIC = 32'h1000_0000;     // Non-zero base address
    parameter USE_DYNAMIC_BASE = 0;                 // 0 = static, 1 = dynamic
    parameter USE_STROBE = 0;                       // 0 = RMW, 1 = strobe

    // DUT signals
    reg clk, rst;
    reg port_cs, port_wr;
    reg [PORT_ADDR_WIDTH-1:0] port_addr;
    reg [PORT_DATA_WIDTH-1:0] port_data_i;
    wire [PORT_DATA_WIDTH-1:0] port_data_o;
    wire port_ready;
    reg [BUS_ADDR_WIDTH-1:0] base_addr_dynamic;

    // Bus interface signals
    wire bus_req, bus_wr;
    wire [BUS_ADDR_WIDTH-1:0] bus_addr;
    wire [BUS_DATA_WIDTH-1:0] bus_wdata;
    wire [BUS_DATA_WIDTH/8-1:0] bus_wstrb;
    reg  bus_grant;
    reg  [BUS_DATA_WIDTH-1:0] bus_rdata;
    reg  bus_valid;

    // Instantiate DUT
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

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Address array for testing
    localparam NUM_TESTS = 10;
    reg [PORT_ADDR_WIDTH-1:0] test_addrs [0:NUM_TESTS-1];
    reg [PORT_DATA_WIDTH-1:0] test_data  [0:NUM_TESTS-1];
    reg [BUS_DATA_WIDTH-1:0] test_bus_data  [0:NUM_TESTS-1];
    
    integer i;

    initial begin
        // Word-aligned: 0x0000, 0x0004, 0x0400
        // Non-aligned:  0x0001, 0x0002, 0x007F
        test_addrs[0] = 16'h0000; test_data[0] = 8'hA1; test_bus_data[0] = 32'hDEADBEA1;
        test_addrs[1] = 16'h0001; test_data[1] = 8'hB2; test_bus_data[1] = 32'hDEADB2EF;
        test_addrs[2] = 16'h0002; test_data[2] = 8'hC3; test_bus_data[2] = 32'hDEC3BEEF;
        test_addrs[3] = 16'h0003; test_data[3] = 8'hD4; test_bus_data[3] = 32'hD4ADBEEF;
        test_addrs[4] = 16'h0005; test_data[4] = 8'h22; test_bus_data[4] = 32'hDEAD22EF;
        test_addrs[5] = 16'h0007; test_data[5] = 8'h44; test_bus_data[5] = 32'h44ADBEEF;
        test_addrs[6] = 16'h007F; test_data[6] = 8'h44; test_bus_data[6] = 32'h44ADBEEF;
        test_addrs[7] = 16'h0400; test_data[7] = 8'h21; test_bus_data[7] = 32'hDEADBE21;
        test_addrs[8] = 16'h0401; test_data[8] = 8'h32; test_bus_data[8] = 32'hDEAD32EF;
        test_addrs[9] = 16'hF400; test_data[9] = 8'hA2; test_bus_data[9] = 32'hDEADBEA2;
        test_addrs[9] = 16'hF404; test_data[9] = 8'h21; test_bus_data[9] = 32'hDEADBE21;
    end

    // Simulated memory: only responds with valid data if address matches correct offset from BASE_ADDR_STATIC
    task simulate_bus_read(input [BUS_ADDR_WIDTH-1:0] expected_bus_addr, input [BUS_DATA_WIDTH-1:0] expected_bus_data);
        begin
            if (bus_addr == expected_bus_addr) begin
                bus_rdata = expected_bus_data;
            end else begin
                bus_rdata = 32'hDEADBEEF; // Invalid data indication
            end
        end
    endtask

    // Helper function for word alignment
    localparam integer BUS_WORD_BYTES = BUS_DATA_WIDTH / 8;
    localparam integer BUS_WORD_ADDR_SHIFT = $clog2(BUS_WORD_BYTES); // = 2 for 32-bit bus

    function [BUS_ADDR_WIDTH-1:0] word_aligned_bus_addr(input [PORT_ADDR_WIDTH-1:0] paddr);
        word_aligned_bus_addr = BASE_ADDR_STATIC + (paddr >> BUS_WORD_ADDR_SHIFT);
    endfunction

    // Stimulus
    initial begin
        $display("Starting tb_port_iface (16-bit port address, non-zero base address, bus word-aligned)...");
        // Initialize
        rst = 1;
        port_cs = 0;
        port_wr = 0;
        port_addr = 0;
        port_data_i = 0;
        base_addr_dynamic = 0;
        bus_grant = 0;
        bus_rdata = 0;
        bus_valid = 0;
        #20;

        rst = 0;
        #10;

        // Test all addresses: write then read
        for (i = 0; i < NUM_TESTS; i = i + 1) begin
            //$display("Iteration %d test_addr=0x%04X test_data=0x%02X test_bus_data=0x%08X", i+1, test_addrs[i], test_data[i], test_bus_data[i]);
            
            // ---- WRITE ----
            port_addr = test_addrs[i];
            port_data_i = test_data[i];
            port_wr = 1;
            port_cs = 1;
            #10;
            port_cs = 0;
            // Wait for bus_req
            wait (bus_req == 1);
            #5;
            // Check that bus_addr is correct (word aligned)
            if (bus_addr !== word_aligned_bus_addr(test_addrs[i]))
                $display("FAIL: bus_addr=0x%08X (expected 0x%08X) during write to port_addr=0x%04X", bus_addr, word_aligned_bus_addr(test_addrs[i]), port_addr);
            else
                $display("PASS: Bus address alignment at port_addr 0x%04X mapped to bus_addr=0x%08X", test_addrs[i], bus_addr);


            // Simulate RMW by assigning a known value to the bus data, as if read from memory
            bus_rdata = 32'hDEADBEEF;
            
            // Simulate bus_grant
            bus_grant = 1;
            #10;
            bus_grant = 0;
            
            if (bus_wdata !== test_bus_data[i])
                $display("FAIL: bus_wdata=0x%08X written to bus_addr 0x%08X (expected 0x%08X)", bus_wdata, bus_addr, test_bus_data[i]);
            else
                $display("PASS: Bus write completed at bus_addr 0x%08X (bus_wdata=0x%08X bus_wstrb=0b%04b)", bus_addr, bus_wdata, bus_wstrb);
            
            // Simulate bus_valid (response)
            #10;
            bus_valid = 1;
            #10;
            bus_valid = 0;
            #10;
            if (!port_ready)
                $display("FAIL: port_ready not asserted after write to port_addr 0x%04X", port_addr);
            else
                $display("PASS: Write completed at port_addr 0x%04X (data=0x%02X)", port_addr, port_data_i);

            // ---- READ ----
            port_wr = 0;
            port_addr = test_addrs[i];
            port_cs = 1;
            #10;
            port_cs = 0;
            wait (bus_req == 1);
            #5;
            // Check bus_addr for read (word aligned)
            if (bus_addr !== word_aligned_bus_addr(test_addrs[i]))
                $display("FAIL: bus_addr=0x%08X (expected 0x%08X) during read from port_addr=0x%04X", bus_addr, word_aligned_bus_addr(test_addrs[i]), port_addr);
            else
                $display("PASS: Bus address alignment at port_addr 0x%04X mapped to bus_addr=0x%08X", test_addrs[i], bus_addr);

            // Simulate bus_grant
            bus_grant = 1;
            #10;
            bus_grant = 0;
            
            // Provide only valid data if address matches expected offset
            simulate_bus_read(word_aligned_bus_addr(test_addrs[i]), test_bus_data[i]);
            
            // Simulate bus_valid (response)
            #10;
            bus_valid = 1;
            #10;
            bus_valid = 0;
            #10;
            if (bus_addr == word_aligned_bus_addr(test_addrs[i])) begin
                if (port_data_o !== test_data[i])
                    $display("FAIL: port_data_o=0x%02X after read from port_addr 0x%04X (expected 0x%02X)", port_data_o, port_addr, test_data[i]);
                else
                    $display("PASS: Read completed at port_addr 0x%04X (data=0x%02X)", port_addr, port_data_o);
            end else begin
                if (port_data_o !== 8'hEF) // 0xDEADBEEF lower byte
                    $display("FAIL: port_data_o=0x%02X after invalid read (expected 0xEF)", port_data_o);
                else
                    $display("PASS: Read at invalid bus address returned default value (0xDEADBEEF)");
            end
            #10;
        end

        $display("All tb_port_iface address offset and data checks completed.");
        #20 $finish;
    end

endmodule