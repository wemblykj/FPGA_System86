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

`define MC6809_DELIMITER_COMMA	,

`define MC6809_DATA_WIDTH	8
`define MC6809_ADDR_WIDTH	16

`define MC6809_DATA_DEF(name) [`MC6809_DATA_WIDTH-1:0] ``name``_data
`define MC6809_ADDR_DEF(name) [`MC6809_ADDR_WIDTH-1:0] ``name``_addr

/*`define MC6809_E_WIRE_DEFS(name) \
	wire ``name``_e;\
	wire ``name``_q;\
	wire ``name``_avma;\
	wire ``name``_busy;\
	wire ``name``_lic*/

`define MC6809_E_WIRE_TEMPLATE(name, primary_direction, secondary_direction, delimiter) \
	``primary_direction ``name``_avma`delimiter \
	``primary_direction ``name``_busy`delimiter \
	``primary_direction ``name``_lic`delimiter \
	``secondary_direction ``name``_e`delimiter \
	``secondary_direction ``name``_q

`define MC6809_WIRE_TEMPLATE(type, name, primary_direction, secondary_direction, io_direction, delimiter) \
	``primary_direction ``name``_we_n`delimiter \
	``primary_direction ``name``_bs`delimiter \
	``primary_direction ``name``_ba`delimiter \
	``secondary_direction ``name``_reset_n`delimiter \
	``secondary_direction ``name``_irq_n`delimiter \
	``secondary_direction ``name``_firq_n`delimiter \
	``secondary_direction ``name``_nmi_n`delimiter \
	``secondary_direction ``name``_halt_n`delimiter \
	`MC6809_``type``_WIRE_TEMPLATE(name, primary_direction, secondary_direction, delimiter)`delimiter \
	``primary_direction `MC6809_ADDR_DEF(``name``)`delimiter \
	``io_direction `MC6809_DATA_DEF(``name``)
	
`define MC6809_WIRE_DEFS(type, name) \
	`MC6809_WIRE_TEMPLATE(type, name, wire, wire, wire, MC6809_DELIMITER_COMMA)

`define MC6809_OUTPUT_DEFS(type, name) \
	`MC6809_WIRE_TEMPLATE(type, name, output, input, inout, MC6809_DELIMITER_COMMA)

`define MC6809_INPUT_DEFS(type, name) \
	`MC6809_WIRE_TEMPLATE(type, name, input, output, inout, MC6809_DELIMITER_COMMA)

`define MC6809_CONNECTION_DEFS(port, signal) \
	.``port``_reset_n(``signal``_reset_n),\
	.``port``_e(``signal``_e),\
	.``port``_q(``signal``_q),\
	.``port``_we_n(``signal``_we_n),\
	.``port``_irq_n(``signal``_irq_n),\
	.``port``_firq_n(``signal``_firq_n),\
	.``port``_nmi_n(``signal``_nmi_n),\
	.``port``_halt_n(``signal``_halt_n),\
	.``port``_addr(``signal``_addr),\
	.``port``_data(``signal``_data),\
	.``port``_bs(``signal``_bs),\
	.``port``_ba(``signal``_ba),\
	.``port``_avma(``signal``_avma),\
	.``port``_busy(``signal``_busy),\
	.``port``_lic(``signal``_lic)
	
