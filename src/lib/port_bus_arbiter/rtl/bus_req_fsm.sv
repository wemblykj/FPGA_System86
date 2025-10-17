// -----------------------------------------------------------------------------
//  Project      : TTL Memory Arbiter
//  Module       : bus_req_fsm
//  File         : bus_req_fsm.sv
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
module bus_req_fsm #()
(
    input  wire                  clk,
    input  wire                  rst,
    // Port interface
    input  wire                  port_cs,           // Chip select (pulse for access)
    input  wire                  port_wr,           // Write enable (1=write, 0=read)
    // Status
    output reg                   ready,             // Ready for new port request
    // External bus interface
    output reg                   bus_req,           // Request to bus
    output reg                   bus_wr,            // Write/read indicator
    input  wire                  bus_grant,         // Bus grants request
    input  wire                  bus_valid          // Response valid pulse
);
    typedef enum logic [1:0] {
        IDLE,
        REQ,
        WAIT_GRANT,
        WAIT_RESP
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Defaults
        next_state = state;

        case (state)
            IDLE: begin
                if (port_cs)
                    next_state = REQ;
            end
            REQ: begin
                next_state = WAIT_GRANT;
            end
            WAIT_GRANT: begin
                if (bus_grant)
                    next_state = WAIT_RESP;
            end
            WAIT_RESP: begin
                if (bus_valid)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_comb begin
        // Defaults
        ready = 0;
        bus_req    = 0;
        bus_wr     = 0;

        case (state)
            IDLE: begin
                ready = 1; // Ready for new command
            end
            REQ: begin
                bus_req = 1;
                bus_wr  = port_wr;
            end
            WAIT_GRANT: begin
                bus_req = 1;
                bus_wr  = port_wr;
            end
            WAIT_RESP: begin
                // Hold bus_req low, wait for bus_valid
            end
        endcase
    end

endmodule