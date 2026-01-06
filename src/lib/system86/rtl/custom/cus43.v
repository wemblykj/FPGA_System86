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
		  input _rst_n,
		
        input wire [2:0] pin_PRI_i,
        input wire [7:0] pin_CLI_i,
        input wire [2:0] pin_DTI_i,
        input wire [11:0] pin_GDI_i,
        input wire pin_bOE,			// hard to decipher text from schematics (held at logic high)
        input wire [2:0] pin_CA_i,
        input wire pin_RbW_i,
        input wire [7:0] pin_MDI_i, // hard to decipher text from schematics
        input wire [2:0] pin_HA_i, 	// hard to decipher text from schematics
        input wire pin_6M_i,
        input wire pin_2H_i,
        input wire pin_bLATCH_i,
        input wire pin_FLIP_i,
        input wire pin_HA2_i,
        input wire pin_HB2_i,
        output wire [2:0] pin_PRO_o,
        output wire [7:0] pin_CLO_o,
        output wire [2:0] pin_DTO_o,
        output wire pin_CLE_o			// hard to decipher text from schematics (not used)
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
			._rst_n(_rst_n),
			
			.sig_6M_i(pin_6M_i),
			.sig_2H_i(pin_2H_i),
			.sig_PRI_i( pin_PRI_i ),
			.sig_CLI_i( pin_CLI_i ),
			.sig_DTI_i( pin_DTI_i ),
			.sig_GDI_i( pin_GDI_i ),
			.sig_MDI_i( pin_MDI_i ),
			.sig_CA_i(pin_CA_i),
			.sig_bLATCH_i(pin_bLATCH_i || !pin_CA_i[2]),
			.sig_FLIP_i(pin_FLIP_i),
			.sig_H2_i(pin_HA2_i),
			.sig_PRO_o(PR_A),
			.sig_CLO_o(CL_A),
			.sig_DTO_o(DT_A)
		);

		cus43_layer 
		#(
			.LAYER_DISABLE_MASK(LAYER_DISABLE_MASK[1]),
			.LAYER_PRIORITY(LAYER_B_PRIORITY)
		)
		layer_b
		(
			._rst_n(_rst_n),
			
			.sig_6M_i(pin_6M_i),
			.sig_2H_i(~pin_2H_i),
			.sig_PRI_i( PR_A ),
			.sig_CLI_i( CL_A ),
			.sig_DTI_i( DT_A ),
			.sig_GDI_i( pin_GDI_i ),
			.sig_MDI_i( pin_MDI_i ),
			.sig_CA_i(pin_CA_i),
			.sig_bLATCH_i(pin_bLATCH_i || !pin_CA_i[2]),
			.sig_FLIP_i(pin_FLIP_i),
			.sig_H2_i(pin_HB2_i),
			.sig_PRO_o(pin_PRO_o),
			.sig_CLO_o(pin_CLO_o),
			.sig_DTO_o(pin_DTO_o)
		);
	
endmodule
