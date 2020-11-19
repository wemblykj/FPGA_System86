`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:06 11/19/2020 
// Design Name: 
// Module Name:    bus_subsystem 
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
module bus_subsystem(
		input wire rst,
		input wire CLK_2H,
		input wire CLK_S2H,
      input wire CLK_1H,
		input wire [12:0] MA,
      inout wire [7:0] MD,
		input wire MRnW,
		input wire nMBUFEN,
		input wire nMLTH0,
		input wire nMLTH1,
		input wire [12:0] SA,
      inout wire [7:0] SD,
		input wire SRnW,
		input wire nSBUFEN,
		input wire nSLTH0,
		input wire nSLTH1,
		output wire [12:0] A,
      inout wire [7:0] D,
      output wire nWE,
		output wire nLATCH0,
		output wire nLATCH1
    );

	// to simplify HDL these are in reverse order of schematics [3:0] -> [4Y:1Y]
	wire ls257_11e_1y;
	wire ls257_11e_2y;
	wire ls257_11e_3y;
	wire ls257_11e_4y;
	wire ls257_11d_1y;
	wire ls257_11d_2y;
	wire ls257_11d_3y;
	wire ls257_11d_4y;
	wire ls257_11f_1y;
	wire ls257_11f_2y;
	wire ls257_11f_3y;
	wire ls257_11f_4y;
	wire ls157_8c_1y;
	wire ls157_8c_2y;
	wire ls157_8c_3y;
	wire ls157_8c_4y;
	
	ls245 ls245_9e
        (
			.DIR(SRnW),
			.nOE(nSBUFEN),	// not accessing program ROM - driven directly by CUS47 nBUFEN
			.A(D),
			.B(SD)
		);
		
	ls245 ls245_12e
        (
			.DIR(MRnW),
			.nOE(nMBUFEN),	// not accessing program ROM - driven indirectly by multiplexing around rom access
			.A(D),
			.B(MD)
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
			.Y1(ls257_11e_1y),
			.Y2(ls257_11e_2y),
			.Y3(ls257_11e_3y),
			.Y4(ls257_11e_4y)
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
			.Y1(ls257_11d_1y),
			.Y2(ls257_11d_2y),
			.Y3(ls257_11d_3y),
			.Y4(ls257_11d_4y)
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
			.Y1(ls257_11f_1y),
			.Y2(ls257_11f_2y),
			.Y3(ls257_11f_3y),
			.Y4(ls257_11f_4y)
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
			.Y1(ls157_8c_1y),
			.Y2(ls157_8c_2y),
			.Y3(ls157_8c_3y),
			.Y4(ls157_8c_4y)
		);
		
	assign nLATCH0 = ls157_8c_1y;
	assign nLATCH1 = ls157_8c_2y;
	assign nWE = ls157_8c_3y;
	
endmodule
