// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Module       : addr_mapper
//  File         : addr_mapper.sv
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
module addr_mapper #(
    parameter PORT_ADDR_WIDTH = 8,
    parameter PORT_DATA_WIDTH = 8,
    parameter BUS_ADDR_WIDTH = 32,
    parameter BUS_DATA_WIDTH = 32,
    parameter BASE_ADDR_STATIC = 32'h0000_0000,
    parameter USE_DYNAMIC_BASE = 0,	// 0 = static, 1 = dynamic
  	parameter DEBUG_ENABLE = 0  	// Set to 1 to enable debug output
)(
    input wire [PORT_ADDR_WIDTH-1:0] port_addr,             // Chip address bus
    input wire [BUS_ADDR_WIDTH-1:0] base_addr_dynamic,      // Used if USE_DYNAMIC_BASE=1
    output wire [BUS_ADDR_WIDTH-1:0] bus_addr               // Global memory address
);
    // Calculate word size and shift for alignment
    localparam integer BUS_WORD_BYTES = BUS_DATA_WIDTH / 8;
    localparam integer BUS_WORD_ADDR_SHIFT = $clog2(BUS_WORD_BYTES); // = 2 for 32-bit bus
    
    // Select base address
    wire [BUS_ADDR_WIDTH-1:0] base_addr = (USE_DYNAMIC_BASE) ? base_addr_dynamic : BASE_ADDR_STATIC;

    // Calculate word-aligned bus address
    assign bus_addr = base_addr + (port_addr >> BUS_WORD_ADDR_SHIFT);

  	generate
    	if (DEBUG_ENABLE) begin: debug_block
      		always_comb begin
          		$display("DEBUG: addr_mapper - port_addr=0x%h -> bus_addr=0x%h", 
              		port_addr, bus_addr);
            end
      	end
    endgenerate
endmodule