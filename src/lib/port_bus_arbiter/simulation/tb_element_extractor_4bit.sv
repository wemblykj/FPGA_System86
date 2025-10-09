// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_element_extractor_4bit
//  File         : tb_element_extractor_4bit.sv
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

module tb_element_extractor_4bit;

    parameter PORT_ADDR_WIDTH = 8;
    parameter PORT_DATA_WIDTH = 4;
    parameter BUS_DATA_WIDTH = 16;

    reg  [PORT_ADDR_WIDTH-1:0] port_addr;
    reg  [BUS_DATA_WIDTH-1:0] bus_rdata;
    wire [PORT_DATA_WIDTH-1:0] data_out;

    localparam ELEMENTS_PER_WORD = BUS_DATA_WIDTH / PORT_DATA_WIDTH;
    localparam ELEMENT_SEL_BITS = $clog2(ELEMENTS_PER_WORD);

    // Instantiate DUT
    element_extractor #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH)
    ) dut (
        .port_addr(port_addr),
        .data_out(data_out),
        .bus_rdata(bus_rdata)
    );

    initial begin
		int i;
        
		reg [PORT_DATA_WIDTH-1:0] expected;
        reg [PORT_ADDR_WIDTH-1:0] test_addr [0:3];
		
        $display("Starting tb_element_extractor_4bit...");
        bus_rdata = 16'hA9B3; // 1010 1001 1011 0011
        
        // Test all nibbles
        test_addr[0] = 0; // rightmost nibble = 0x3
        test_addr[1] = 1; // next nibble = 0xB
        test_addr[2] = 2; // next nibble = 0x9
        test_addr[3] = 3; // leftmost nibble = 0xA

        for (i = 0; i < 4; i = i + 1) begin
            port_addr = test_addr[i];
            #1;
            expected = bus_rdata[PORT_DATA_WIDTH*port_addr +: PORT_DATA_WIDTH];
            $display("port_addr=%0d data_out=0x%01X (expected=0x%01X)", port_addr, data_out, expected);
            if (data_out !== expected) begin
                $display("FAIL: data_out mismatch at port_addr %0d", port_addr);
                $fatal;
            end
        end

        $display("All 4-bit element_extractor tests passed.");
        #10 $finish;
    end

endmodule