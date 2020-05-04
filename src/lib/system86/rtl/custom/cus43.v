`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Paul Wightmore
// 
// Create Date:    20:11:05 05/15/2018 
// Design Name:    CUS43
// Module Name:    system86\src\custom\cus43.v
// Project Name:   Namco System86 simulation
// Target Devices: 
// Tool versions: 
// Description:    CUS43 - Dual tilemap generator
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cus43
	#(
			parameter LAYER_DISABLE_MASK = 0,
			parameter LAYER_A_PRIORITY = 0,
			parameter LAYER_B_PRIORITY = 0
	)
	(
		  input rst,
		
        input wire [2:0] PRI,
        input wire [7:0] CLI,
        input wire [2:0] DTI,
        input wire [11:0] GDI,
        input wire nOE,			// hard to decipher text from schematics (held at logic high)
        input wire [2:0] CA,
        input wire nWE,
        input wire [7:0] MDI, // hard to decipher text from schematics
        input wire [2:0] HA, 	// hard to decipher text from schematics
        input wire CLK_6M,
        input wire CLK_2H,
        input wire nLATCH,
        input wire FLIP,
        input wire HA2,
        input wire HB2,
        output wire [2:0] PRO,
        output wire [7:0] CLO,
        output wire [2:0] DTO,
        output wire CLE			// hard to decipher text from schematics (not used)
    );

	wire [2:0] PR_A;
	wire [7:0] CL_A;
	wire [2:0] DT_A;
	
	cus43_layer 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK[0]),
			.LAYER_PRIORITY(LAYER_A_PRIORITY)
		)
		layer_a
		(
			.rst(rst),
			
			.CLK_6M(CLK_6M),
			.CLK_2H(CLK_2H),
			.PRI( PRI ),
			.CLI( CLI ),
			.DTI( DTI ),
			.GDI( GDI ),
			.MDI( MDI ),
			.CA(CA),
			.nLATCH(nLATCH),
			.FLIP(FLIP),
			.PRO(PR_A),
			.CLO(CL_A),
			.DTO(DT_A),
			.H2(HA2)
		);

		cus43_layer 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK[1]),
			.LAYER_PRIORITY(LAYER_B_PRIORITY)
		)
		layer_b
		(
			.rst(rst),
			
			.CLK_6M(CLK_6M),
			.CLK_2H(~CLK_2H),
			.PRI( PR_A ),
			.CLI( CL_A ),
			.DTI( DT_A ),
			.GDI( GDI ),
			.MDI( MDI ),
			.CA(CA),
			.nLATCH(nLATCH),
			.FLIP(FLIP),
			.PRO(PRO),
			.CLO(CLO),
			.DTO(DTO),
			.H2(HB2)
		);
	
endmodule
