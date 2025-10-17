// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Module       : port_bus_adapter
//  File         : port_bus_adapter.sv
//  Author       : Paul Wightmore
//  Created      : 2025-10-07
//  Description  : 
//      <Short description of what this module does.>
//
//  Parameters   :
//      - <PARAM1> : <Description>
//      - <PARAM2> : <Description>
//
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
module port_bus_adapter #(
    parameter PORT_ADDR_WIDTH = 8,
    parameter PORT_DATA_WIDTH = 8,
    parameter BUS_ADDR_WIDTH = 32,
    parameter BUS_DATA_WIDTH = 32,
    parameter BASE_ADDR_STATIC = 32'h0000_0000,
    parameter USE_DYNAMIC_BASE = 0,                 // 0 = static, 1 = dynamic
    parameter USE_STROBE = 0                        // 0 = RMW, 1 = strobe
)(
    input  wire                  clk,
    input  wire                  rst,
    // Port interface
    input  wire                  port_cs,               // Chip select (pulse for access)
    input  wire                  port_wr,               // Write enable (1=write, 0=read)
    input  wire [PORT_ADDR_WIDTH-1:0] port_addr,        // Address bus
    input  wire [PORT_DATA_WIDTH-1:0] port_data_i,      // Data in (for write)
    output reg  [PORT_DATA_WIDTH-1:0] port_data_o,      // Data out (for read)
    output reg                   port_ready,            // Transaction complete
    // Mapping
    input  wire [BUS_ADDR_WIDTH-1:0] base_addr_dynamic,
    // External bus interface
    output reg                          bus_req,        // Request to bus
    output reg                          bus_wr,         // Write/read indicator
    output reg  [BUS_ADDR_WIDTH-1:0]    bus_addr,       // Address to bus
    output reg  [BUS_DATA_WIDTH-1:0]    bus_wdata,      // Data to bus (for write)
    output reg  [BUS_DATA_WIDTH/8-1:0]  bus_wstrb,      //
    input  wire                         bus_grant,      // Bus access granted
    input  wire [BUS_DATA_WIDTH-1:0]    bus_rdata,      // Data from bus (for read)
    input  wire                         bus_valid       // Response valid pulse
);
  	wire port_read_req = port_cs && !port_wr;           // port read if cs and not write
  	wire port_write_req = port_cs && port_wr;           // port write if cs and write
    
    wire [BUS_DATA_WIDTH-1:0] cache_word;               // the last read word [from cache]
    wire cache_port_ready;
    wire cache_valid;                                   // the cache is valid
    wire cache_bus_req;                                 // cache [read] bus request
  	wire cache_invalidate = port_write_req;             // invalidate cache if any write occurs
    
  	wire do_bus_req = cache_bus_req || port_write_req;  // read (via cache) or direct write
    
    // Address mapping
    addr_mapper #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH),
        .BASE_ADDR_STATIC(BASE_ADDR_STATIC),
        .USE_DYNAMIC_BASE(USE_DYNAMIC_BASE)
    ) addrmap (
        .port_addr(port_addr),
        .bus_addr(bus_addr),
        .base_addr_dynamic(base_addr_dynamic)
    );

    bus_word_cache #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH)
    ) cache (
        .clk(clk),
        .rst(rst),
        .req_addr(bus_addr),
        .req_valid(port_read_req),
        .cache_word(cache_word),
        .cache_valid(cache_valid),
        .invalidate(cache_invalidate),
        .bus_req(cache_bus_req),
        .bus_grant(bus_grant),
        .bus_valid(bus_valid),
        .bus_rdata(bus_rdata)
    );
    
    // Byte extraction (read)
    element_extractor #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),        
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH)
    ) bytextr (
        .bus_rdata(cache_word),
        .port_addr(port_addr),
        .port_data_o(port_data_o)
    );

    // Byte insertion (write)
    element_inserter #(
        .PORT_ADDR_WIDTH(PORT_ADDR_WIDTH),
        .PORT_DATA_WIDTH(PORT_DATA_WIDTH),
        .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH),
        .USE_STROBE(USE_STROBE)
    ) byteins (
        .port_data_i(port_data_i),
        .port_addr(port_addr),
        .bus_rdata(bus_rdata),
        .bus_wdata(bus_wdata),
        .bus_wstrb(bus_wstrb)
    );

    // External bus request FSM
    bus_req_fsm #(
    ) fsm (
        .clk(clk),
        .rst(rst),
        .port_cs(do_bus_req),
        .port_wr(port_wr),
        .ready(port_ready),
        .bus_req(bus_req),
        .bus_wr(bus_wr),
        .bus_grant(bus_grant),
        .bus_valid(bus_valid)
    );
endmodule