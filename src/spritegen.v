`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:12:52 06/10/2018 
// Design Name:    SPRITEGEN 
// Module Name:    system86/spritegen.v 
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    Sprite generation subsystem
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:        https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////
module SPRITEGEN(
        input wire CLK_6M,
        input wire CLK_2H,
        input wire OBJECT,
        input wire VRESET,
        input wire [2:0] SPR,
        input wire BLANKING,
        input wire [12:0] A,
        input wire WE,
        inout wire [7:0] D,
        output wire [7:0] DOT,
        output wire SRCWIN
    );
	 
	 // == supply rails ==
	supply1 VCC;
	supply0 GND;
	
	// 1H high == main CPU on bus
	// 1H low == sub CPU on bus
	
	// A12 != 0 then ram A11 = 1 (xxxx1xxxxxxxxxxx)
	// 1H  A12  | A11
	//  0    0  |   0		sub CPU address == 0x0xxx 	=> 0x0000 base
	//  0    1  |   1		sub CPU address == 0x1xxx 	=> 0x0800 base (sprite registers)
	//  1    0  |   1		main CPU address == 0x0xxx => 0x0800 base (sprite registers)
	//  1    1  |   1		main CPU address == 0x1xxx	=> 0x0800 base (sprite registers)
	wire ls32_6e_3y;
	// A0 != 0 then ram A12 = 1 (xxx1xxxxxxxxxxxx)
	// 1H   A0  | A12
	//  0    0  |   0		sub CPU even address 	=> 0x0000 base
	//  0    1  |   1		sub CPU odd address 		=> 0x1000 base
	//  1    0  |   1		main CPU even address 	=> 0x1000 base
	//  1    1  |   1		main CPU odd address 	=> 0x1000 base
	wire ls32_6e_4y;
	
	// 1H   A12  A0  | A12 A11
	//  0    0    0  |  0    0		sub CPU address == 0x0xxx 	=> 0x0000 base	()
	//  0    0    1  |  1    0		sub CPU even address 		=> 0x1000 base	()
	//  0    1    0  |  0    1		sub CPU odd address 			=> 0x0800 base	(sprite registers)
	//  0    1    1  |  1    1		sub CPU address == 0x1xxx 	=> 0x1800 base (sprite registers)
	//  1    0    0  |  1    1		main CPU address == 0x0xxx => 0x1800 base (sprite registers)
	//  1    0    1  |  1    1		main CPU even address 		=> 0x1800 base	(sprite registers)
	//  1    1    0  |  1    1		main CPU address == 0x1xxx	=> 0x1800 base (sprite registers)
	//  1    1    1  |  1    1		main CPU odd address 		=> 0x1800 base	(sprite registers)
	
	LS32 LS32_6E(
		.A3(CLK_2H),
		.B3(A[12]),
		.A4(CLK_2H),
		.B4(A[0]),
		.Y3(ls32_6e_3y),
		.Y4(ls32_6e_4y)
		);
	
	wire ls174_6v_q1;
	wire ls174_6v_q2;
	wire ls174_6v_q3;
	wire ls174_6v_q4;
	wire ls174_6v_q5;
	wire ls174_6v_q6;
	
	wire ls174_9v_q1;
	wire ls174_9v_q2;
	wire ls174_9v_q3;
	wire ls174_9v_q4;
	wire ls174_9v_q5;
	wire ls174_9v_q6;
	
	wire ls174_8v_q1;
	wire ls174_8v_q2;
	wire ls174_8v_q3;
	wire ls174_8v_q4;
	wire ls174_8v_q5;
	wire ls174_8v_q6;
	
	// sprite registers?
	// A != xxx11xxxxxxxxxx0
	// A12 A11  A0  Y1
	//   0   0   0   1
	//   0   0   1   1
	//   0   1   0   1
	//   0   1   1   1
	//   1   0   0   1
	//   1   0   1   1
	//   1   1   0   0
	//   1   1   1   1
	wire ls10_7e_1y;
	wire ls10_7e_2y;
	wire ls10_7e_3y;
	
	wire ls85_7v_agtb;
	
	wire [3:0] cus39_11n_oo;
	wire [7:0] prom_11u_d;	// prom or sram? 2018 (i think it is a sram!)
	
	LS10 LS10_7E(
		.A1(~A[0]),
		.B1(A[12]),
		.C1(A[11] | ls174_6v_q4),
		.A2(VCC),
		.B2(ls174_6v_q5),
		.C2(BLANKING),
		.A3(ls174_6v_q1),
		.B3(ls174_6v_q2),
		.C3(ls174_6v_q3),
		.Y1(ls10_7e_1y),
		.Y2(ls10_7e_2y),
		.Y3(ls10_7e_3y)
		);
	
	LS174 LS174_6V(
		.CLK(cus39_11n_latch),
		.CLR(VCC),
		.D( { ls10_7e_2y, BLANKING, cus39_11n_oo[0], cus39_11n_oo[1], cus39_11n_oo[2], cus39_11n_oo[3] } ),
		.Q( { ls174_6v_q6, ls174_6v_q5, ls174_6v_q4, ls174_6v_q3, ls174_6v_q2, ls174_6v_q1} )
		);
		
	LS174 LS174_9V(
		.CLK(cus39_11n_latch),
		.CLR(VCC),
		.D( { GND, ls85_7v_agtb, GND, GND, GND, GND} ),
		.Q( { ls174_9v_q6, ls174_9v_q5, ls174_9v_q4, ls174_9v_q3, ls174_9v_q2, ls174_9v_q1} )
		);
		
	LS174 LS174_8V(
		.CLK(cus39_11n_latch),
		.CLR(VCC),
		.D( { prom_11u_d[0], prom_11u_d[1], prom_11u_d[2], prom_11u_d[3], GND, GND} ),
		.Q( { ls174_8v_q6, ls174_8v_q5, ls174_8v_q4, ls174_8v_q3, ls174_8v_q2, ls174_8v_q1} )
		);
		
	wire cus35_9m_cs0;
	wire cus35_9m_cs1;
	wire cus35_9m_rwe;
	wire cus35_9m_roe;
	wire [7:0] cus35_9m_bi;
	wire [7:0] cus35_9m_bo;
	
	CUS35 CUS35_9M(
		.CLK_6M(CLK_6M),
		.VRES(VRESET),
		.OCS(OBJECT),
		.A( { GND, A[11:1], ls10_7e_1y } ),
		.WE(WE),
		.D(D[7:0]),
		.CS0(cus35_9m_cs0),
		.CS1(cus35_9m_cs1),
		.ROE(cus35_9m_roe),
		.RWE(cus35_9m_rwe),
		.BI(cus35_9m_bi),
		.BO(cus35_9m_bo)
		);
	
	// sprite ram
	CY6264 CY6264_10M(
		.CE(cus35_9m_cs1),
		.WE(cus35_9m_rwe),
		.OE(cus35_9m_roe),
		.A( { ls32_6e_4y, ls32_6e_3y, A[11:1] } ),
		.D(cus35_9m_bi)
		);

	LS85 LS85_7V(
		.A( { ls10_7e_3y, ls174_9v_q1, ls174_9v_q2, ls174_9v_q3 } ),
		.B( { VCC, SPR } ),
		.AgtBin(VCC),
		.AeqBin(GND),
		.AltBin(GND),
		.AgtBout(ls85_7v_agtb),
		.AltBout(ls85_7v_altb)
		);
		
	wire [7:0] prom_5v_d;
	PROM_7138 #(10, 8, "roms/rt1-4.5v") PROM_5V(
		.E(BLANKING | ls85_7v_agtb), 
		.A( { ls174_9v_q4, ls174_8v_q1, ls174_8v_q3, ls174_8v_q4, ls174_8v_q5, ls174_8v_q6, ls174_6v_q1, ls174_6v_q2, ls174_6v_q3, ls174_6v_q4 } ), 
		.Q(prom_5v_d)
		);
		
endmodule
