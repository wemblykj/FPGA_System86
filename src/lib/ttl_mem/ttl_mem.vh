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

`define WIRE_DEFS(type, name) \
	`define TYPE_DEF_``name`` ``type``;\
	wire ``name``_ce_n = 0;\
	wire `ADDR_DEF(``type``, ``name``);\
	wire `DATA_DEF(``type``, ``name``)
	
`define OUTPUT_DEFS(type, name) \
	`define TYPE_DEF_``name`` ``type``;\
	output wire ``name``_ce_n,\
	output wire `ADDR_DEF(``type``, ``name``),\
	input wire `DATA_DEF(``type``, ``name``)\

`define INPUT_DEFS(type, name) \
	`define TYPE_DEF_``name`` ``type``;\
	input wire ``name``_ce_n,\
	input wire `ADDR_DEF(``type``, ``name``),\
	output wire `DATA_DEF(``type``, ``name``)

`define CONNECTION_DEFS(port, signal) \
	.``port``_ce_n(``signal``_ce_n),\
	.``port``_addr(``signal``_addr),\
	.``port``_data(``signal``_data)
