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
// The use of 1H clock enabled LS257 chips was initally an enigma to me however
// after starting to look at the role of the CUS35 sprite/object chip it would
// appear that the address bus is shared between the CPUs and CUS35 (for work ram 
// to sprite ram transfers). The sharing must be accomplish by interleaving the bus
// requests using alternate states of the 1H clock
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module address_bus(
		input wire _rst_n,
		input wire s86_2H_i,
		input wire s86_S2H_i,
		input wire s86_1H_i,
		input wire [12:0] s86_MA_i,
		input wire s86_MRbW_i,
		input wire s86_bMBUFEN_i,
		input wire s86_bMLTH0_i,
		input wire s86_bMLTH1_i,
		input wire [12:0] s86_SA_i,
		input wire s86_SRbW_i,
		input wire s86_bSBUFEN_i,
		input wire s86_bSLTH0_i,
		input wire s86_bSLTH1_i,
		output wire [12:0] s86_A_o,
		output wire s86_RbW_o,
		output wire s86_LATCH0_o,
		output wire s86_LATCH1_o
    );

	ls257 ls257_11e
        (
			.nG(s86_1H_i),
			.nSELA(s86_S2H_i),
			.A1(s86_SA_i[3]),
			.A2(s86_SA_i[2]),
			.A3(s86_SA_i[1]),
			.A4(s86_SA_i[0]),
			.B1(s86_MA_i[3]),
			.B2(s86_MA_i[2]),
			.B3(s86_MA_i[1]),
			.B4(s86_MA_i[0]),
			.Y1(s86_A_o[3]),
			.Y2(s86_A_o[2]),
			.Y3(s86_A_o[1]),
			.Y4(s86_A_o[0])
		);
		
	ls257 ls257_11d
        (
			.nG(s86_1H_i),
			.nSELA(s86_S2H_i),
			.A1(s86_SA_i[7]),
			.A2(s86_SA_i[6]),
			.A3(s86_SA_i[5]),
			.A4(s86_SA_i[4]),
			.B1(s86_MA_i[7]),
			.B2(s86_MA_i[6]),
			.B3(s86_MA_i[5]),
			.B4(s86_MA_i[4]),
			.Y1(s86_A_o[7]),
			.Y2(s86_A_o[6]),
			.Y3(s86_A_o[5]),
			.Y4(s86_A_o[4])
		);
		
	ls257 ls257_11f
        (
			.nG(s86_1H_i),
			.nSELA(s86_S2H_i),
			.A1(s86_SA_i[11]),
			.A2(s86_SA_i[10]),
			.A3(s86_SA_i[9]),
			.A4(s86_SA_i[8]),
			.B1(s86_MA_i[11]),
			.B2(s86_MA_i[10]),
			.B3(s86_MA_i[9]),
			.B4(s86_MA_i[8]),
			.Y1(s86_A_o[11]),
			.Y2(s86_A_o[10]),
			.Y3(s86_A_o[9]),
			.Y4(s86_A_o[8])
		);
		
	ls157 ls157_8c
        (
			.nG(1'b0),
			.nSELA(s86_2H_i),
			.A1( s86_bSLTH0_i ),
			.A2( s86_bSLTH1_i ),
			.A3( s86_SRbW_i ),
			.A4( s86_SA_i[12] ),
			.B1( s86_bMLTH0_i ),
			.B2( s86_bMLTH1_i ),
			.B3( s86_MRbW_i ),
			.B4( s86_MA_i[12] ),
			.Y1(s86_LATCH0_o),
			.Y2(s86_LATCH1_o),
			.Y3(s86_RbW_o),
			.Y4(s86_A_o[12])
		);
	
endmodule
