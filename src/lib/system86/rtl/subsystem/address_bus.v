`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:06 11/19/2020 
// Design Name: 
// Module Name:    address_bus 
// Project Name: 
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
module address_bus(
		input wire rst,
		input wire CLK_2H,
		input wire CLK_S2H,
      input wire CLK_1H,
		input wire [12:0] MA,
      input wire MRnW,
		input wire nMBUFEN,
		input wire nMLTH0,
		input wire nMLTH1,
		input wire [12:0] SA,
      input wire SRnW,
		input wire nSBUFEN,
		input wire nSLTH0,
		input wire nSLTH1,
		output wire [12:0] A,
      output wire nWE,
		output wire nLATCH0,
		output wire nLATCH1
    );

	ls257 ls257_11e
        (
			.nG(CLK_1H),
			.nSELA(CLK_S2H),
			.A1(SA[3]),
			.A2(SA[2]),
			.A3(SA[1]),
			.A4(SA[0]),
			.B1(MA[3]),
			.B2(MA[2]),
			.B3(MA[1]),
			.B4(MA[0]),
			.Y1(A[3]),
			.Y2(A[2]),
			.Y3(A[1]),
			.Y4(A[0])
		);
		
	ls257 ls257_11d
        (
			.nG(CLK_1H),
			.nSELA(CLK_S2H),
			.A1(SA[7]),
			.A2(SA[6]),
			.A3(SA[5]),
			.A4(SA[4]),
			.B1(MA[7]),
			.B2(MA[6]),
			.B3(MA[5]),
			.B4(MA[4]),
			.Y1(A[7]),
			.Y2(A[6]),
			.Y3(A[5]),
			.Y4(A[4])
		);
		
	ls257 ls257_11f
        (
			.nG(CLK_1H),
			.nSELA(CLK_S2H),
			.A1(SA[11]),
			.A2(SA[10]),
			.A3(SA[9]),
			.A4(SA[8]),
			.B1(MA[11]),
			.B2(MA[10]),
			.B3(MA[9]),
			.B4(MA[8]),
			.Y1(A[11]),
			.Y2(A[10]),
			.Y3(A[9]),
			.Y4(A[8])
		);
		
	ls157 ls157_8c
        (
			.nG(1'b0),
			.nSELA(CLK_2H),
			.A1( nSLTH0 ),
			.A2( nSLTH1 ),
			.A3( MRnW ),
			.A4( SA[12] ),
			.B1( nMLTH0 ),
			.B2( nMLTH1 ),
			.B3( MRnW ),
			.B4( MA[12] ),
			.Y1(nLATCH0),
			.Y2(nLATCH1),
			.Y3(nWE),
			.Y4(A[12])
		);
	
endmodule
