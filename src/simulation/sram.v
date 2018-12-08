`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:25 05/06/2018 
// Design Name: 
// Module Name:    SRAM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SRAM(
	 OE,
	 CE,
	 WE,
    A,
    D
    );
	 
	parameter ADDR_WIDTH = 0;
	parameter DATA_WIDTH = 0;
	
	input wire CE;
	input wire OE;
	input wire WE;
	input wire [ADDR_WIDTH-1:0] A;
	inout wire [DATA_WIDTH-1:0] D;

	reg [DATA_WIDTH-1:0] data;
	reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
	
	assign D = (CE && OE && ~WE) ? data : {(DATA_WIDTH){1'bZ}};
	
	always @(A or D or OE or CE or WE) 
	begin : MEM_WRITE
		if (CE && WE)
			mem[A] = D;
	end

	always @(A or OE or CE or WE) 
	begin : MEM_READ
		if (CE && !WE && OE) begin
			data = mem[A];
		end
	end

endmodule
