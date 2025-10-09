// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Module       : element_inserter
//  File         : element_inserter.sv
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
//      ----------  ---------------  -------  ---------------------------------------
//      2025-10-07  Paul Wightmore   v0.01    Proof of concepts
//
//  License      : https://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------------------------
//  Copyright (c) 2025 Paul Wightmore. All rights reserved.
// -----------------------------------------------------------------------------
module element_inserter #(
    parameter PORT_ADDR_WIDTH = 8,
    parameter PORT_DATA_WIDTH = 8,
  	parameter BUS_ADDR_WIDTH = 32,
  	parameter BUS_DATA_WIDTH = 32,
	parameter USE_STROBE = 0 // 0 = RMW, 1 = strobe
)(
    // Legacy chip interface
    input  wire [PORT_ADDR_WIDTH-1:0] port_addr,       // Address bus
    input  wire [PORT_DATA_WIDTH-1:0] port_data_i,    // Data in (for write)
    // Arbiter/memory interface
    input  wire [BUS_DATA_WIDTH-1:0] bus_rdata,  // Data from arbiter (for read)
    output reg  [BUS_DATA_WIDTH-1:0] bus_wdata,   // Data to arbiter (for write)
	output reg  [BUS_DATA_WIDTH/8-1:0] bus_wstrb  
);
// Compile-time check (optional, SystemVerilog)
    initial begin
        if (BUS_DATA_WIDTH % PORT_DATA_WIDTH != 0)
            $error("BUS_DATA_WIDTH (%0d) must be a multiple of PORT_DATA_WIDTH (%0d)", BUS_DATA_WIDTH, PORT_DATA_WIDTH);
			
		if (USE_STROBE && (PORT_DATA_WIDTH % 8 != 0))
			$error("PORT_DATA_WIDTH (%0d) must be a multiple of 8 when using strobe", PORT_DATA_WIDTH);
    end
	
  	// Calculate elements per word and element select bits
    localparam ELEMENTS_PER_WORD = BUS_DATA_WIDTH / PORT_DATA_WIDTH;
    localparam ELEMENT_SEL_BITS = $clog2(ELEMENTS_PER_WORD);

    wire [ELEMENT_SEL_BITS-1:0] element_sel = port_addr[ELEMENT_SEL_BITS-1:0];

	always @(*) begin
        if (USE_STROBE) begin
            // Write strobe mode: Only supports element widths that are multiples of 8 bits (bytes)
            bus_wdata = {BUS_DATA_WIDTH{1'b0}};
            bus_wstrb = {BUS_DATA_WIDTH/8{1'b0}};
            bus_wdata[PORT_DATA_WIDTH*element_sel +: PORT_DATA_WIDTH] = port_data_i;
            bus_wstrb[element_sel] = 1'b1;
        end else begin
            // Read-modify-write mode: can support arbitrary element widths
            bus_wdata = bus_rdata;
            bus_wstrb = {BUS_DATA_WIDTH/8{1'b1}}; // Not used, but can be all enabled for compatibility
            bus_wdata[PORT_DATA_WIDTH*element_sel +: PORT_DATA_WIDTH] = port_data_i;
        end
    end

endmodule