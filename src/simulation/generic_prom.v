`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:30:37 04/15/2018 
// Design Name:    GENERIC_PROM
// Module Name:    system86\simulation\generic_prom.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    PROM simulation based on binary file
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module GENERIC_PROM
    #(
        parameter ADDR_WIDTH = 0,
        parameter DATA_WIDTH = 0,
        parameter FILE_NAME = "",
        // timings
        parameter tAVQV = 0,
        parameter tAXQX = 0,
        parameter tELQV = 0,
        parameter tEHQZ = 0,
        parameter tGLQV = 0,
        parameter tGHQZ = 0
    )
    (
        input wire E,
        input wire G,
        input wire [ADDR_WIDTH-1:0] A,
        output wire [DATA_WIDTH-1:0] Q
    );
 
    reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
    reg [DATA_WIDTH-1:0] DOut;
    wire [ADDR_WIDTH-1:0] AV;

    // retaining datasheet's naming convention due to active low signals
    assign #(tAVQV, tAXQX) AV = A;	
    assign #(tELQV, tEHQZ) ELQV = E;	
    assign #(tGLQV, tGHQZ) GLQV = G;
    assign QV = ELQV && GLQV;

    assign Q = QV ? DOut : {(DATA_WIDTH){1'bZ}};

    integer fd;
    integer i;
	integer count;
    integer read;

	reg [7:0] byte_read;
	
    initial begin
		fd = $fopen(FILE_NAME, "rb");
		if (!fd) begin
			$display("Failed to open prom image: %s\n", FILE_NAME);
			$stop;
		end

		$display("successfully read prom image: %s\n", FILE_NAME);
		
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
        
    always @(*) begin
        if (QV)
            // latch data on [delayed] change in address
            DOut = mem[AV];
    end

endmodule
