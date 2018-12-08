`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:37 04/15/2018 
// Design Name: 
// Module Name:   System86\PROM_FILE
// Project Name:  Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:   PROM simulation based on binary file
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module PROM_FILE(
    OE,
    CE,
    A,
    Q
    );
	 
parameter ADDR_WIDTH = 0;
parameter DATA_WIDTH = 0;
parameter FILE_NAME = "";

input wire CE;
input wire OE;
input wire [ADDR_WIDTH-1:0] A;
output wire [DATA_WIDTH-1:0] Q;

//reg [DATA_WIDTH-1:0] data [0:2**ADDR_WIDTH-1];

reg [DATA_WIDTH-1:0] data;
reg [DATA_WIDTH-1:0] mem [1:2**ADDR_WIDTH];

assign Q = (CE && OE) ? data : {(DATA_WIDTH){1'bZ}};

integer fd;
integer index;
integer read;

initial begin
	fd = $fopen(FILE_NAME, "rb");
	read = $fread(mem, fd, 0, 2**ADDR_WIDTH);
	$fclose(fd);
end
	
always @(A or OE or CE) begin : MEM_READ
	if (CE && OE) begin
		data = mem[A+1];
	end
end

endmodule
