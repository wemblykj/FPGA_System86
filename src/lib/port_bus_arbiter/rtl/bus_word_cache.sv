// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Module       : bus_word_cache
//  File         : bus_word_cache.sv
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
module bus_word_cache #(
    parameter PORT_ADDR_WIDTH = 16,
    parameter BUS_ADDR_WIDTH = 32,
    parameter BUS_DATA_WIDTH = 32
)(
    input  wire clk,
    input  wire rst,
    input  wire [BUS_DATA_WIDTH-1:0] req_addr,   // port address (byte address)
    input  wire req_valid,                        // pulse for new read request
    input  wire invalidate,                       // invalidate cache (e.g. on write)
    output wire [BUS_DATA_WIDTH-1:0] cache_word,
    output wire cache_valid,
    output wire busy,
    // Bus interface
    output reg        bus_req,
    input  wire       bus_grant,
    input  wire       bus_valid,
    input  wire [BUS_DATA_WIDTH-1:0] bus_rdata
);

    localparam integer BUS_WORD_ADDR_SHIFT = $clog2(BUS_DATA_WIDTH/8);
    localparam integer CACHE_ADDR_WIDTH = PORT_ADDR_WIDTH - BUS_WORD_ADDR_SHIFT;

    wire [CACHE_ADDR_WIDTH-1:0] word_addr = req_addr[PORT_ADDR_WIDTH-1:BUS_WORD_ADDR_SHIFT];

    reg [CACHE_ADDR_WIDTH-1:0] cache_addr_r;
    reg [BUS_DATA_WIDTH-1:0] cache_word_r;
    reg cache_valid_r;
    reg busy_r;

    assign cache_word = cache_word_r;
    assign cache_valid = cache_valid_r;
    assign busy = busy_r;

    typedef enum logic [1:0] {
        IDLE,
        MISS,
        REFILL
    } state_t;
    state_t state, next_state;

    always @* begin
        next_state = state;
        bus_req    = 0;
        busy_r     = 0;
        case (state)
            IDLE: begin
                if (req_valid && !(cache_valid_r && (cache_addr_r == word_addr))) begin
                    bus_req = 1;
                    busy_r = 1;
                    next_state = MISS;
                end
            end
            MISS: begin
                bus_req = 1;
                busy_r = 1;
                if (bus_grant)
                    next_state = REFILL;
            end
            REFILL: begin
                busy_r = 1;
                if (bus_valid)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state        <= IDLE;
            cache_valid_r<= 0;
            cache_word_r <= '0;
            cache_addr_r <= '0;
        end else begin
            state <= next_state;
            if (invalidate)
                cache_valid_r <= 0;
            if (bus_valid && (state == REFILL)) begin
                cache_addr_r  <= word_addr;
                cache_word_r  <= bus_rdata;
                cache_valid_r <= 1;
            end
        end
    end

endmodule