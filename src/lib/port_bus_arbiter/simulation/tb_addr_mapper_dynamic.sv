// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_addr_mapper_dynamic
//  File         : tb_addr_mapper_dynamic.sv
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

module tb_addr_mapper_dynamic;
    parameter PORT_ADDR_WIDTH = 16;
    parameter PORT_DATA_WIDTH = 8;
    parameter BUS_ADDR_WIDTH = 32;
    parameter BUS_DATA_WIDTH = 32;
    parameter BASE_ADDR_STATIC = 32'hDEAD_0000;     // Invalid [and ignored] static base address
    
    parameter TEST_BASE_ADDR = 32'h1000_0000;       // Expected base address

    localparam BYTE_SEL_BITS = $clog2(BUS_DATA_WIDTH / PORT_DATA_WIDTH);
  
    reg [PORT_ADDR_WIDTH-1:0] port_addr = 0;
    wire [BUS_ADDR_WIDTH-1:0] bus_addr;

    // Our dynamic base address
    reg [BUS_ADDR_WIDTH-1:0] base_addr_dynamic;

    addr_mapper #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH),
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BASE_ADDR_STATIC(BASE_ADDR_STATIC),
        .USE_DYNAMIC_BASE(1)
    ) dut (
        .port_addr(port_addr),
        .base_addr_dynamic(base_addr_dynamic),
        .bus_addr(bus_addr)
    );

  	reg [PORT_ADDR_WIDTH-1:0] test_addrs [0:5];
  
    // Helper function for word alignment
    localparam integer BUS_WORD_BYTES = BUS_DATA_WIDTH / 8;
    localparam integer BUS_WORD_ADDR_SHIFT = $clog2(BUS_WORD_BYTES); // = 2 for 32-bit bus

    function [BUS_ADDR_WIDTH-1:0] word_aligned_bus_addr(input [PORT_ADDR_WIDTH-1:0] paddr);
        word_aligned_bus_addr = TEST_BASE_ADDR + (paddr >> BUS_WORD_ADDR_SHIFT);
    endfunction
    
    initial begin
        integer i;
      
        // Our dynamic base address
        base_addr_dynamic = TEST_BASE_ADDR;
        
      	// Define the test addresses
      	test_addrs[0] = 16'h0000;
        test_addrs[1] = 16'h0004;
        test_addrs[2] = 16'h0400;
        test_addrs[3] = 16'h0001;
        test_addrs[4] = 16'h0002;
        test_addrs[5] = 16'h007F;
      
        $display("Starting dynamic addr_mapper testbench...");

        for (i = 0; i < 6; i = i + 1) begin
            port_addr = test_addrs[i];
            #1;
          	if (bus_addr !== word_aligned_bus_addr(port_addr)) begin
                $display("FAIL: bus_addr = %08X, expected = %08X", bus_addr, word_aligned_bus_addr(port_addr));
            end else
                $display("PASS: port_addr 0x%04X mapped to bus_addr = %08X", port_addr, word_aligned_bus_addr(port_addr));
        end

        $display("All dynamic addr_mapper tests completed.");
        #10 $finish;
    end
endmodule