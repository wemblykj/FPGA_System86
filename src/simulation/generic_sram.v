`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:      Paul Wightmore
// 
// Create Date:   18:08:25 05/06/2018 
// Design Name:   GENERIC_SRAM
// Module Name:   system86/simulation/generic_sram.v 
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
module GENERIC_SRAM(
    input wire CE,
    input wire OE,	 
    input wire WE,
    input wire [ADDR_WIDTH-1:0] A,
    inout wire [DATA_WIDTH-1:0] D
    );
	 
	parameter ADDR_WIDTH = 0;
	parameter DATA_WIDTH = 0;
	parameter FILE_NAME = "";
	// CY6264 timing and naming conventions (or thereabouts)
	parameter tAA = "0";		// address access time
	parameter tOHA = "0";	// output data hold time from address change
	parameter tACE = "0";	// CE access time
	parameter tLZCE = "0";	// CE to output low-Z
	parameter tHZCE = "0";	// CE to output high-Z
	parameter tDOE = "0";	// OE access time
	parameter tLZOE = "0";	// OE to output low-Z
	parameter tHZOE = "0";	// OE to output high-Z
	
	reg [DATA_WIDTH-1:0] mem [1:(2**ADDR_WIDTH)];
	reg [DATA_WIDTH-1:0] DOut;
	wire [ADDR_WIDTH-1:0] ACC;
	
	assign #(tAA, tOHA) ACC = A;
	assign #(tLZCE, tACE) LZCE = CE;
	assign #(tACE, tHZCE) ACE = CE;
	assign #(tLZOE, tDOE) LZOE = OE;
	assign #(tDOE, tHZOE) OEV = OE;
	
	assign DLZ = LZCE && tLZOE;
	assign DV = ACE && OEV;
	
	assign D = WE ? {(DATA_WIDTH){1'bZ}} : DV ? DOut : DLZ ? {(DATA_WIDTH){1'bX}} : {(DATA_WIDTH){1'bZ}};
	
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

	always @(A or D or ACE or WE or !WE) 
	begin : MEM_WRITE
		if (ACE && WE) begin
			mem[A+1] = D;
		end
	end

	always @(*) 
	begin : MEM_READ
		if (!WE && DV) begin
			DOut = mem[ACC+1];
		end
	end

endmodule
