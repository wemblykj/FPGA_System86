`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:51:42 07/02/2018 
// Design Name:    27512
// Module Name:    system86\mem\eprom_27512.v
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
module eprom_m27512
    #(
        parameter FILE_NAME = "",
        // timings (250ns - blank, -25) 
        parameter tAVQV = 250,
        parameter tAXQX = 0,
        parameter tELQV = 250,
        parameter tEHQZ = 0:60:60,  // (using worst case for typical)
        parameter tGLQV = 100,
        parameter tGHQZ = 0:60:60   // (using worst case for typical)
    )
    (
        input wire nG,
        input wire nE,
        input wire [15:0] A,
        output wire [7:0] Q,
		  output wire data_valid
    );
        
    GENERIC_PROM #(16, 8, FILE_NAME, tAVQV, tAXQX, tELQV, tEHQZ, tGLQV, tGHQZ) fprom(
        .nG(nG),
        .nE(nE),
        .A(A),
        .Q(Q),
		  .data_valid(data_valid)
    );
	
endmodule
