// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Module       : element_extractor
//  File         : element_extractor.sv
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
module element_extractor #(
    parameter PORT_ADDR_WIDTH = 8,
    parameter PORT_DATA_WIDTH = 8,
  	parameter BUS_ADDR_WIDTH = 32,
  	parameter BUS_DATA_WIDTH = 32,
  	parameter DEBUG_ENABLE = 0  	// Set to 1 to enable debug output
)(
    // Port interface
    input  wire [PORT_ADDR_WIDTH-1:0] port_addr,        // Address bus
    output wire  [PORT_DATA_WIDTH-1:0] port_data_o,     // Data out (for read)
    // Bus interface
    input  wire [BUS_DATA_WIDTH-1:0] bus_rdata          // Data from bus (for read)  
);

	// Compile-time check (optional, SystemVerilog)
    initial begin
        if (BUS_DATA_WIDTH % PORT_DATA_WIDTH != 0)
            $error("BUS_DATA_WIDTH (%0d) must be a multiple of PORT_DATA_WIDTH (%0d)", BUS_DATA_WIDTH, PORT_DATA_WIDTH);
    end
	
  	// Calculate elements per word and element select bits
    localparam ELEMENTS_PER_WORD = BUS_DATA_WIDTH / PORT_DATA_WIDTH;
	localparam ELEMENT_SEL_BITS = $clog2(ELEMENTS_PER_WORD);

    wire [ELEMENT_SEL_BITS-1:0] element_sel = port_addr[ELEMENT_SEL_BITS-1:0];
	assign port_data_o = bus_rdata[PORT_DATA_WIDTH*element_sel +: PORT_DATA_WIDTH];
  
  	generate
      	if (DEBUG_ENABLE) begin: debug_block
            always_comb begin
                $display("Element extractor: input word=0x%h, port_addr=0x%h, offset=%0d, output=0x%h",
                   bus_rdata, port_addr, port_addr[ELEMENT_SEL_BITS-1:0], port_data_o);
            end
        end
    endgenerate
endmodule