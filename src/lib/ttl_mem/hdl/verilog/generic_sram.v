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
        parameter tAA = 0,			// address to data valid
        parameter tOHA = 0,   	// output data hold time from address change
        parameter tACE = 0,	   // CE access time
        parameter tLZCE = 0,	   // CE to output low-Z
        parameter tHZCE = 0,	   // CE to output high-Z
        parameter tDOE = 0,	   // OE access time
        parameter tLZOE = 0,	   // OE to output low-Z
        parameter tHZOE = 0,    	// OE to output high-Z
		  // write
		  parameter tSCE = 0,	   // CE LOW to write end
		  parameter tSD = 0,			// data setup to write end
		  parameter tHD = 0,			// data hold from write end
		  parameter tAW = 0,			// address setup to write end
		  parameter tPWE = 0,	   // WE pulse width
		  parameter tHZWE = 0,		// WE LOW to high
		  parameter tLZWE = 0		// WE HIGH to low-Z
    )
    (
		  input wire rst_n,
			
        input wire nCE,
        input wire nOE,	 
        input wire nWE,
        input wire [ADDR_WIDTH-1:0] A,
        inout wire [DATA_WIDTH-1:0] D,
		  output wire data_valid
    );
	
	reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
	reg [DATA_WIDTH-1:0] DOut;
	reg DValid;
	
	reg nZCE;
	// read
	reg nACE;
	reg nDOE;
	reg nZOE;
	reg nAA;
	// write
	reg nSCE;
	reg nZWE;
	
	specify
		/* must be a port!
		// read
		(nCE => nZCE) = (tLZCE, tHZCE);
		(nCE => nACE) = (tACE, tHZCE);
		(nOE => nZOE) = (tLZOE, tHZOE);
		(nOE => nDOE) = (tDOE, tHZOE);
		// write
		(nSCE => nSCE) = (tSCE, 0);
		(nWE => nZWE) = (tLZWE, tHZWE);
		*/
		// checks
		$setup(D, posedge nWE, tSD);
		$width(negedge nWE, tPWE);
		$hold(posedge nWE, D, tHD);
	endspecify
		
	integer fd;
   integer i;
	integer MemSize = 2**ADDR_WIDTH;
   integer read;

	reg [7:0] byte_read;
	
	initial begin
		if (FILE_NAME != "") begin
			fd = $fopen(FILE_NAME, "rb");
			if (!fd) begin
				$display("Failed to open RAM snapshot: %s\n", FILE_NAME);
				$stop;
			end

			$display("successfully read RAM snapshot: %s\n", FILE_NAME);
			
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
				mem[i]={(DATA_WIDTH/8){8'hcd}};
		end
	end

	// read signals
	always @(nCE) begin
		if (!nCE)
			#tACE nACE <= 0;
		else
			#tLZCE nACE <= 1;
	end
	
	always @(nCE) begin
		if (!nCE)
			#tHZCE nZCE <= 0;
		else
			#tLZCE nZCE <= 1;
	end
	
	always @(nOE) begin
		if (!nOE)
			#tDOE nDOE <= 0;
		else
			#tLZOE nDOE <= 1;
	end
	
	always @(nOE) begin
		if (!nOE)
			#tHZOE nZOE <= 0;
		else
			#tLZOE nZOE <= 1;
	end
	
	always @(A) begin
			#tOHA nAA <= 1;
			#(tAA-tOHA) nAA <= 0;
	end
	
	// write signals
	always @(nCE) begin
		nSCE <= 1;
		if (!nCE)
			#tSCE nSCE <= 0;
	end
	
	always @(nWE) begin
		if (!nWE)
			#tHZWE nZWE <= 0;
		else
			#tLZWE nZWE <= 1;
	end
	
	always @(posedge nWE or posedge nCE) 
	begin : MEM_WRITE
		if (!nCE)
			mem[A] = D;
	end

	always @(nACE or nDOE or nAA) 
	begin : MEM_READ_VALID
		if (nACE || nDOE || nAA)
			DValid = 0;
		else
			DValid = 1;
	end
	
	always @(DValid) 
	begin : MEM_READ
		DOut <= DValid ? mem[A] : {(DATA_WIDTH){1'bX}};
	end
	
	assign D = (nZCE || !nZWE || nZOE) ? {(DATA_WIDTH){1'bZ}} : DOut;
		
endmodule
