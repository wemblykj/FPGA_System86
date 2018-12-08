`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:      Paul Wightmore
// 
// Create Date:   18:08:25 05/06/2018 
// Design Name:   SRAM
// Module Name:   system86/simulation/sram.v 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:   Static RAM simulation
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
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
	parameter FILE_NAME = "";
	
	input wire CE;
	input wire OE;
	input wire WE;
	input wire [ADDR_WIDTH-1:0] A;
	inout wire [DATA_WIDTH-1:0] D;

	reg [DATA_WIDTH-1:0] DOut;
	reg [DATA_WIDTH-1:0] DOutLatched;
	
	reg [DATA_WIDTH-1:0] mem [1:(2**ADDR_WIDTH)];
	
	assign D = DOutLatched;
	
	integer fd;
	integer index;
	integer read;

	initial begin
		if (FILE_NAME != "") begin
			fd = $fopen(FILE_NAME, "rb");
			read = $fread(mem, fd, 0, 2**ADDR_WIDTH);
			$fclose(fd);
		end
	end

	always @(A or D or CE or WE or !WE) 
	begin : MEM_WRITE
		if (CE && WE) begin
			mem[A+1] = D;
		end
	end

	always @(A or OE or CE) 
	begin : MEM_READ
		if (CE && OE) begin
			DOut = mem[A+1];
		end else begin
			DOut = {(DATA_WIDTH){1'bZ}};
		end
		
		DOutLatched = DOut;
	end

endmodule
