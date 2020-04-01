//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:			 Paul Wightmore
// 
// Create Date:		 28/03/2020 
// Design Name: 
// Module Name:		 ttl_mem.vh
// Project Name:	 	 Namco System86 top-level simulation module
// Target Devices: 
// Tool versions: 
// Description:		 Macro helpers for working with TTL memory chips 
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`define DATA_WIDTH(type)	`DATA_WIDTH_``type``
`define ADDR_WIDTH(type)	`ADDR_WIDTH_``type``
/*`define PINS(type)			`PINS_``type``
`define WIRE(type, name)	wire [`PINS_``type``] name
`define PORT(type, name)	inout `WIRE(``type``, ``name``)
`define DATA(type, pins) 	`DATA_``type``(pins)
`define ADDR(type, pins) 	`ADDR_``type``(pins)
`define nCE(type, pins) 	`nCE_``type``(pins)
`define CE(type, pins) 		`CE_``type``(pins)
`define nOE(type, pins) 	`nOE_``type``(pins)
`define OE(type, pins) 		`OE_``type``(pins)
*/

`define DATA_DEF(type, name) [`DATA_WIDTH(``type``)-1:0] ``name``_data
`define ADDR_DEF(type, name) [`ADDR_WIDTH(``type``)-1:0] ``name``_addr

`define PROM_WIRE_DEFS(type, name) \
	wire ``name``_ce_n = 1'b0;\
	wire `ADDR_DEF(``type``, ``name``);\
	wire `DATA_DEF(``type``, ``name``)
	
`define PROM_OUTPUT_DEFS(type, name) \
	output wire ``name``_ce_n,\
	output wire `ADDR_DEF(``type``, ``name``),\
	input wire `DATA_DEF(``type``, ``name``)\

`define PROM_INPUT_DEFS(type, name) \
	input wire ``name``_ce_n,\
	input wire `ADDR_DEF(``type``, ``name``),\
	output wire `DATA_DEF(``type``, ``name``)

`define EPROM_WIRE_DEFS(type, name) \
	wire ``name``_ce_n = 1'b0;\
	wire ``name``_oe_n = 1'b0;\
	wire `ADDR_DEF(``type``, ``name``);\
	wire `DATA_DEF(``type``, ``name``)

`define EPROM_OUTPUT_DEFS(type, name) \
	output wire ``name``_ce_n,\
	output wire ``name``_oe_n,\
	output wire `ADDR_DEF(``type``, ``name``),\
	input wire `DATA_DEF(``type``, ``name``)\

`define EPROM_INPUT_DEFS(type, name) \
	input wire ``name``_ce_n,\
	input wire ``name``_oe_n,\
	input wire `ADDR_DEF(``type``, ``name``),\
	output wire `DATA_DEF(``type``, ``name``)

`define SRAM_WIRE_DEFS(type, name) \
	wire ``name``_ce_n = 1'b0;\
	wire ``name``_oe_n = 1'b0;\
	wire ``name``_we_n = 1'b0;\
	wire `ADDR_DEF(``type``, ``name``);\
	wire `DATA_DEF(``type``, ``name``)\
	
`define SRAM_OUTPUT_DEFS(type, name) \
	output wire ``name``_ce_n,\
	output wire ``name``_oe_n,\
	output wire ``name``_we_n,\
	output wire `ADDR_DEF(``type``, ``name``),\
	inout wire `DATA_DEF(``type``, ``name``)\

`define SRAM_INPUT_DEFS(type, name) \
	input wire ``name``_ce_n,\
	input wire ``name``_oe_n,\
	input wire ``name``_we_n,\
	input wire `ADDR_DEF(``type``, ``name``),\
	inout wire `DATA_DEF(``type``, ``name``)

`define MEM_CONNECTION_DEFS(port, signal) \
	.``port``_addr(``signal``_addr),\
	.``port``_data(``signal``_data)

`define PROM_CONNECTION_DEFS(port, signal) \
	`MEM_CONNECTION_DEFS(``port``, ``signal``),\
	.``port``_ce_n(``signal``_ce_n)
	
`define EPROM_CONNECTION_DEFS(port, signal) \
	`PROM_CONNECTION_DEFS(``port``, ``signal``),\
	.``port``_oe_n(``signal``_ce_n)

`define SRAM_CONNECTION_DEFS(port, signal) \
	`MEM_CONNECTION_DEFS(``port``, ``signal``),\
	.``port``_ce_n(``signal``_ce_n),\
	.``port``_oe_n(``signal``_oe_n),\
	.``port``_we_n(``signal``_we_n)