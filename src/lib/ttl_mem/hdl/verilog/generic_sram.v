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
module GENERIC_SRAM
    #(
        parameter ADDR_WIDTH = 0,
        parameter DATA_WIDTH = 0,
        parameter FILE_NAME = "",
        // CY6264 timing and naming conventions (or thereabouts)
        parameter tAA = "0",		// address access time
        parameter tOHA = "0",   	// output data hold time from address change
        parameter tACE = "0",	    // CE access time
        parameter tLZCE = "0",	    // CE to output low-Z
        parameter tHZCE = "0",	    // CE to output high-Z
        parameter tDOE = "0",	    // OE access time
        parameter tLZOE = "0",	    // OE to output low-Z
        parameter tHZOE = "0"    // OE to output high-Z
    )
    (
        input wire nCE,
        input wire nOE,	 
        input wire nWE,
        input wire [ADDR_WIDTH-1:0] A,
        inout wire [DATA_WIDTH-1:0] D
    );
	
	reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
	reg [DATA_WIDTH-1:0] DOut;
	
	reg CE;
	reg WE;
	reg DOE;
	reg LZOE;
	
	integer fd;
    integer i;
	integer count;
    integer read;

	reg [7:0] byte_read;
	
	initial begin
		fd = $fopen(FILE_NAME, "rb");
		if (!fd) begin
			$display("Failed to open ROM snapshot: %s\n", FILE_NAME);
			$stop;
		end

		$display("successfully read ROM snapshot: %s\n", FILE_NAME);
		
		count = 2**ADDR_WIDTH;
		// works in isim but not modelsim
		//read = $fread(mem, fd, count);
		
		// reading individual bytes seems to work in modelsim
		for (i=0; i < count; i=i+1) begin
			read = $fread(byte_read, fd);
			mem[i]=byte_read;
		end
		
		$fclose(fd);
	end

	always @(nCE) begin
		if (!nCE)
			#tACE CE <= 1;
		else
			#tLZCE CE <= 0;
	end
	
	always @(nOE) begin
		if (!nOE) begin
			#tLZOE LZOE <= 1;
			#(tDOE-tLZOE) DOE <= 1;
		end else begin
			#tHZOE LZOE <= 0; DOE <= 0;
		end
	end
	
	always @(nWE) begin
		if (!nWE)
			WE <= 1;
		else
			WE <= 0;
	end
	
	always @(A or D or CE or WE) 
	begin : MEM_WRITE
		// TODO: timings
		if (CE && WE) begin
			mem[A] = D;
		end
	end

	always @(CE or WE or A) 
	begin : MEM_READ
		if (!WE && CE) begin
			// nullify D after OHA
			#tOHA DOut <= {(DATA_WIDTH){1'bX}};
			// Assign new value after TAA
			
			// layer debugging
			//if (A[ADDR_WIDTH-1])
			#(tAA-tOHA) DOut <= mem[A];
		end
	end

	assign D = CE ? ((WE || !LZOE) ? {(DATA_WIDTH){1'bZ}} : DOE ? DOut : {(DATA_WIDTH){1'bX}}) : {(DATA_WIDTH){1'bZ}};
		
endmodule
