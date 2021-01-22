`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    26/03/2020
// Design Name:    bus_adapter
// Module Name:    bus adapter.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Adapts a TTL logic memory chip to an external bus request
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module bus_adapter
    #(
        parameter ADDR_WIDTH,
	parameter DATA_WIDTH = 8,
	parameter BUS_BASE_ADDR = 0,
	parameter BUS_ADDR_WIDTH = 8,
	parameter BUS_DATA_WIDTH = 32
    )
    (
        input wire CE,
        input wire OE,
        input wire WE,
        input wire [ADDR_WIDTH-1:0 ADDR,
        inout wire [DATA_WIDTH-1:0] DATA,

        input wire bus_req,
        input wire bus_ack,
        input wire bus_we,
        output reg [BUS_ADDR_WIDTH-1:0] bus_address,
        inout wire [BUS_DATA_WIDTH-1:0] bus_data
    );

	always @(posedge CLK1 or nPRE1 or nCLR1) begin
		if (nPRE1 && nCLR1) begin
			Q1 <= D1;
			nQ1 <= ~D1;
		/*else if (!nPRE1 && nCLR1) begin
			Q1 <= 1;
			nQ1 <= 0;
		end else if (nPRE1 && !nCLR1) begin
			Q1 <= 0;
			nQ1 <= 1;
		end else if (!nPRE1 && !nCLR1) begin
			Q1 <= 1;
			nQ1 <= 1;*/
		end else begin
			Q1 <= ~nPRE1;
			nQ1 <= nPRE1 || !nCLR1;
		end
			
	end
	
	always @(posedge CLK2 or nPRE2 or nCLR2) begin
		if (nPRE2 && nCLR2) begin
			Q2 <= D2;
			nQ2 <= ~D2;
		/*end else if (!nPRE2 && nCLR2) begin
			Q2 <= 1;
			nQ2 <= 0;
		end else if (nPRE2 && !nCLR2) begin
			Q2 <= 0;
			nQ2 <= 1;
		end else if (!nPRE2 && !nCLR2) begin
			Q2 <= 1;
			nQ2 <= 1;*/
		end else begin
			Q2 <= ~nPRE2;
			nQ2 <= nPRE2 || !nCLR2;
		end			
	end
	
endmodule
