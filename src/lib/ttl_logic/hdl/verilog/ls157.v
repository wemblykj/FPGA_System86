`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    21:46:13 05/04/2018 
// Design Name:    LS157
// Module Name:    system86\src\custom\ls157.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    LS157 - Quad 2-Input Multiplexer
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module ls157(
        input wire nG,
        input wire nSELA,
        input wire A1,
		  input wire A2,
		  input wire A3,
		  input wire A4,
        input wire B1,
        input wire B2,
        input wire B3,
        input wire B4,
        output wire Y1,
		  output wire Y2,
		  output wire Y3,
		  output wire Y4
    );

	assign { Y1, Y2, Y3, Y4 } = nG ? 4'b0 : (nSELA ? { B1, B2, B3, B4 } : { A1, A2, A3, A4 } );

endmodule
