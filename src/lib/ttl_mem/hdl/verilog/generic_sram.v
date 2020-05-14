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
		  // read
        parameter tAA = "0",		// address to data valid
        parameter tOHA = "0",   	// output data hold time from address change
        parameter tACE = "0",	    // CE access time
        parameter tLZCE = "0",	    // CE to output low-Z
        parameter tHZCE = "0",	    // CE to output high-Z
        parameter tDOE = "0",	    // OE access time
        parameter tLZOE = "0",	    // OE to output low-Z
        parameter tHZOE = "0",    // OE to output high-Z
		  // write
		  parameter tSCE = "0",	    // CE LOW to write end
		  parameter tAW = "0",		// address setup to write end
		  parameter tPWE = "0",	    // WE pulse width
		  parameter tHZWE = "0",		// WE LOW to high
		  parameter tLZWE = "0"		// WE HIGH to low-Z
    )
    (
		  input wire rst,
			
        input wire nCE,
        input wire nOE,	 
        input wire nWE,
        input wire [ADDR_WIDTH-1:0] A,
        inout wire [DATA_WIDTH-1:0] D
    );
	
	reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
	reg [DATA_WIDTH-1:0] DOut;
	
	// read
	reg ACE;
	reg DOE;
	reg ZOE;
	reg AA;
	// write
	reg SCE;
	reg ZWE;
	reg PWE;
	
	integer fd;
   integer i;
	integer MemSize = 2**ADDR_WIDTH;
   integer read;

	reg [7:0] byte_read;
	
	initial begin
		if (FILE_NAME != "") begin
			fd = $fopen(FILE_NAME, "rb");
			if (!fd) begin
				$display("Failed to open ROM snapshot: %s\n", FILE_NAME);
				$stop;
			end

			$display("successfully read ROM snapshot: %s\n", FILE_NAME);
			
			// works in isim but not modelsim
			//read = $fread(mem, fd, count);
			
			// reading individual bytes seems to work in modelsim
			for (i=0; i < MemSize; i=i+1) begin
				read = $fread(byte_read, fd);
				mem[i]=byte_read;
			end
			
			$fclose(fd);
		end else begin
			for (i=0; i < MemSize; i=i+1)
				mem[i]={(DATA_WIDTH){1'b0}};
		end
	end

	// read signals
	always @(nCE or rst) begin
		if (rst)
			ACE <= 0;
		else if (!nCE)
			#tACE ACE <= 1;
		else
			#tLZCE ACE <= 0;
	end
	
	always @(nOE or rst) begin
		if (rst) begin
			DOE <= 0;
		end else if (!nOE) begin
			#(tDOE) DOE <= 1;
		end else begin
			DOE <= 0;
		end
	end
	
	always @(nOE or rst) begin
		if (rst) begin
			ZOE <= 0;
		end else if (!nOE) begin
			#tLZOE ZOE <= 1;
		end else begin
			#tHZOE ZOE <= 0;
		end
	end
	
	always @(A or rst) begin
		if (rst) begin
			AA <= 0;
		end else begin
			AA <= 0;
			#tAA AA <= 1;
		end
	end
	
	// write signals
	always @(nCE or rst) begin
		if (rst)
			SCE <= 0;
		else if (!nCE)
			#tSCE SCE <= 1;
		else
			SCE <= 0;
	end
	
	always @(nWE or nOE or rst) begin
		if (rst) begin
			ZWE <= 0;
		end else if (!nWE && nOE)
			#tHZWE ZWE <= 1;
		else
			#tLZWE ZWE <= 0;
	end
	
	always @(A or rst) begin
		if (rst) begin
			PWE <= 0;
		end else begin
			PWE <= 0;
			#(tAW-tPWE) PWE <= 1;
			#tPWE PWE <= 0;
		end
	end
	
	//always @(SCE or ZWE or PWE) 
	always @(negedge PWE) 
	begin : MEM_WRITE
		if (SCE && ZWE /*&& PWE*/) begin
			mem[A] = D;
		end
	end

	always @(ACE or ZOE or DOE or AA) 
	begin : MEM_READ
		/*if (!nCE || ZWE || !ZOE)
		DOut <= {(DATA_WIDTH){1'bz}};
		else*/
		if (!ACE || !DOE)
			DOut <= {(DATA_WIDTH){1'bx}};	// transient
		else if (AA)
			DOut <= mem[A];
	end

	assign D = (!nCE || ZWE || !ZOE) ? {(DATA_WIDTH){1'bZ}} : DOut;
		
endmodule
