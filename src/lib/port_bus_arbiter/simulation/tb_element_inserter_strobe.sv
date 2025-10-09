// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Testbench    : tb_element_inserter_strobe
//  File         : tb_element_inserter_strobes.sv
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

module tb_element_inserter_strobe;

    parameter PORT_ADDR_WIDTH = 8;
    parameter PORT_DATA_WIDTH = 16; // Example: strobe per 2 bytes
    parameter BUS_DATA_WIDTH = 64;
    parameter USE_STROBE = 1; // Strobe mode

    reg  [PORT_ADDR_WIDTH-1:0] port_addr;
    reg  [PORT_DATA_WIDTH-1:0] port_data_i;
    reg  [BUS_DATA_WIDTH-1:0] bus_rdata; // Unused in strobe mode
    wire [BUS_DATA_WIDTH-1:0] bus_wdata;
    wire [BUS_DATA_WIDTH/8-1:0] bus_wstrb;

    localparam ELEMENTS_PER_WORD = BUS_DATA_WIDTH / PORT_DATA_WIDTH;
    localparam ELEMENT_SEL_BITS = $clog2(ELEMENTS_PER_WORD);
    localparam BYTES_PER_ELEMENT = PORT_DATA_WIDTH/8;

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
		int i, b;
		
        reg [BUS_DATA_WIDTH-1:0] expected_data;
        reg [BUS_DATA_WIDTH/8-1:0] expected_strobe;
        reg [PORT_DATA_WIDTH-1:0] test_data [0:3];
        reg [PORT_ADDR_WIDTH-1:0] test_addr [0:3];

        $display("Starting tb_element_inserter_strobe...");
        
        // Prepare test vectors
        test_data[0] = 16'h1234; test_addr[0] = 0; // LSW
        test_data[1] = 16'hFACE; test_addr[1] = 1;
        test_data[2] = 16'hBEEF; test_addr[2] = 2;
        test_data[3] = 16'hF00D; test_addr[3] = 3; // MSW

        for (i = 0; i < 4; i = i + 1) begin
            port_addr = test_addr[i];
            port_data_i = test_data[i];
            #1;
            // Expected: only selected element's field is set, others zero
            expected_data = {BUS_DATA_WIDTH{1'b0}};
            expected_data[PORT_DATA_WIDTH*port_addr +: PORT_DATA_WIDTH] = port_data_i;
            // Expected strobe: only corresponding bytes are set
            expected_strobe = {BUS_DATA_WIDTH/8{1'b0}};
            for (b = 0; b < BYTES_PER_ELEMENT; b = b + 1)
                expected_strobe[port_addr*BYTES_PER_ELEMENT + b] = 1'b1;

            $display("port_addr=%0d port_data_i=0x%04X bus_wdata=0x%016X (exp=0x%016X) bus_wstrb=0x%02X (exp=0x%02X)",
                port_addr, port_data_i, bus_wdata, expected_data, bus_wstrb, expected_strobe);

            if (bus_wdata !== expected_data) begin
                $display("FAIL: bus_wdata mismatch at port_addr %0d", port_addr);
                $fatal;
            end
            if (bus_wstrb !== expected_strobe) begin
                $display("FAIL: bus_wstrb mismatch at port_addr %0d", port_addr);
                $fatal;
            end
        end

        $display("All element_inserter strobe mode tests passed.");
        #10 $finish;
    end

endmodule