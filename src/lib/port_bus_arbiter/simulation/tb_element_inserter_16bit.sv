// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_element_inserter_16bit
//  File         : tb_element_inserter_16bit.sv
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

module tb_element_inserter_16bit;

    parameter PORT_ADDR_WIDTH = 8;
    parameter PORT_DATA_WIDTH = 16;
    parameter BUS_DATA_WIDTH = 64;
    parameter USE_STROBE = 0; // RMW mode

    reg  [PORT_ADDR_WIDTH-1:0] port_addr;
    reg  [PORT_DATA_WIDTH-1:0] port_data_i;
    reg  [BUS_DATA_WIDTH-1:0] bus_rdata;
    wire [BUS_DATA_WIDTH-1:0] bus_wdata;
    wire [BUS_DATA_WIDTH/8-1:0] bus_wstrb;

    localparam ELEMENTS_PER_WORD = BUS_DATA_WIDTH / PORT_DATA_WIDTH;
    localparam ELEMENT_SEL_BITS = $clog2(ELEMENTS_PER_WORD);

    // Instantiate DUT
    element_inserter #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH),
        .USE_STROBE(USE_STROBE)
    ) dut (
        .port_addr(port_addr),
        .port_data_i(port_data_i),
        .bus_rdata(bus_rdata),
        .bus_wdata(bus_wdata),
        .bus_wstrb(bus_wstrb)
    );

    initial begin
		int i;
		
        reg [BUS_DATA_WIDTH-1:0] expected;
        reg [PORT_DATA_WIDTH-1:0] test_data [0:3];
        reg [PORT_ADDR_WIDTH-1:0] test_addr [0:3];

        $display("Starting tb_element_inserter_16bit (RMW mode)...");
        bus_rdata = 64'hF00D_BEEF_CAFE_1234;   // Initial word
        
        // Prepare test vectors
        test_data[0] = 16'h4321; test_addr[0] = 0; // LSW
        test_data[1] = 16'hFACE; test_addr[1] = 1;
        test_data[2] = 16'hDEAD; test_addr[2] = 2;
        test_data[3] = 16'hBEEF; test_addr[3] = 3; // MSW

        for (i = 0; i < 4; i = i + 1) begin
            port_addr = test_addr[i];
            port_data_i = test_data[i];
            #1;
            // Calculate expected
            expected = bus_rdata;
            expected[PORT_DATA_WIDTH*port_addr +: PORT_DATA_WIDTH] = port_data_i;
            $display("port_addr=%0d port_data_i=0x%04X bus_wdata=0x%016X (expected=0x%016X)", port_addr, port_data_i, bus_wdata, expected);
            if (bus_wdata !== expected) begin
                $display("FAIL: bus_wdata mismatch at port_addr %0d", port_addr);
                $fatal;
            end
        end

        $display("All 16-bit element_inserter tests passed.");
        #10 $finish;
    end

endmodule