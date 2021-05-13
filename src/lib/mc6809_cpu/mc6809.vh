//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:			 Paul Wightmore
// 
// Create Date:		 28/03/2020 
// Design Name: 
// Module Name:		 mc6809.vh
// Project Name:	 Namco System86 top-level simulation module
// Target Devices: 
// Tool versions: 
// Description:		 Macro helpers for working with MC6809 cpu chips 
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////


`define MC6809_DATA_WIDTH	8
`define MC6809_ADDR_WIDTH	16

`define MC6809_DATA_DEF(name) [`MC6809_DATA_WIDTH-1:0] ``name``_data
`define MC6809_ADDR_DEF(name) [`MC6809_ADDR_WIDTH-1:0] ``name``_addr

`define MC6809_E_WIRE_DEFS(name) \
	wire ``name``_e;\
	wire ``name``_q;\
	wire ``name``_avma;\
	wire ``name``_lic

`define MC6809_WIRE_DEFS(type, name) \
	wire ``name``_reset;\
	wire ``name``_ce_n;\
	wire ``name``_we_n;\
	wire ``name``_bs;\
	wire ``name``_ba;\
	wire ``name``_irq;\
	wire ``name``_firq;\
	wire ``name``_nmi;\
	wire ``name``_halt;\
	`MC6809_``type``_WIRE_DEFS(name);\
	wire `MC6809_ADDR_DEF(``name``);\
	wire `MC6809_DATA_DEF(``name``)
	
`define MC6809_E_OUTPUT_DEFS(name) \
	output wire ``name``_e,\
	output wire ``name``_q,\
	output wire ``name``_avma,\
	output wire ``name``_lic

`define MC6809_OUTPUT_DEFS(type, name) \
	output wire ``name``_reset,\
	output wire ``name``_ce_n,\
	output wire ``name``_we_n,\
	output wire ``name``_bs,\
	output wire ``name``_ba,\
	output wire ``name``_irq,\
	output wire ``name``_firq,\
	output wire ``name``_nmi,\
	output wire ``name``_halt,\
	`MC6809_``type``_OUTPUT_DEFS(name),\
	output wire `MC6809_ADDR_DEF(``name``),\
	inout wire `MC6809_DATA_DEF(``name``)

`define MC6809_E_INPUT_DEFS(name) \
	input wire ``name``_e,\
	input wire ``name``_q,\
	input wire ``name``_avma,\
	input wire ``name``_lic

`define MC6809_INPUT_DEFS(type, name) \
	input wire ``name``_reset,\
	input wire ``name``_ce_n,\
	input wire ``name``_we_n,\
	input wire ``name``_bs,\
	input wire ``name``_ba,\
	input wire ``name``_irq,\
	input wire ``name``_firq,\
	input wire ``name``_nmi,\
	input wire ``name``_halt,\
	`MC6809_``type``_INPUT_DEFS(name),\
	input wire `MC6809_ADDR_DEF(``name``),\
	inout wire `MC6809_DATA_DEF(``name``)

`define MC6809_CONNECTION_DEFS(port, signal) \
	.``port``_addr(``signal``_addr),\
	.``port``_data(``signal``_data),\
	.``port``_ce_n(``signal``_ce_n)
