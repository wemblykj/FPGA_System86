`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name:    27256
// Module Name:    system86\mem\eprom_27256.v
// Project Name:   Namco System86 simulation
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
module eprom_m27256
    #(
        parameter FILE_NAME = "",
        // timings (250ns - blank, -25) 
        parameter tAVQV = 250,
        parameter tAXQX = 0,
        parameter tELQV = 250,
        parameter tEHQZ = 0:60:60,  // (using worst case for typical)
        parameter tGLQV = 100,
        parameter tGHQZ = 0:60:60  // (using worst case for typical)
    )
    (
        input wire nE,
        input wire nG,
        input wire [14:0] A,
        output wire [7:0] Q,
		  output wire data_valid
    );
	
	GENERIC_PROM #(15, 8, FILE_NAME, tAVQV, tAXQX, tELQV, tEHQZ, tGLQV, tGHQZ) fprom(
		.nE(nE),
		.nG(nG),
		.A(A),
		.Q(Q),
		.data_valid(data_valid)
	);
	
endmodule
