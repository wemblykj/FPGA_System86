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
`define PINS(type)			`PINS_``type``
`define WIRE(type, name)	wire [`PINS_``type``] name
`define PORT(type, name)	inout `WIRE(``type``, ``name``)
`define DATA(type, pins) 	`DATA_``type``(pins)
`define ADDR(type, pins) 	`ADDR_``type``(pins)
`define nCE(type, pins) 	`nCE_``type``(pins)
`define CE(type, pins) 		`CE_``type``(pins)
`define nOE(type, pins) 	`nOE_``type``(pins)
`define OE(type, pins) 		`OE_``type``(pins)

`define BREAKOUT_ADDR(type, pins) \
	wire [`ADDR_WIDTH(``type``)-1:0] ``pins``_addr;\
	assign ``pins``_addr = `ADDR(``type``, ``pins``)

`define BREAKOUT_DATA(type, pins) \
	wire [`DATA_WIDTH(``type``)-1:0] ``pins``_data;\
	assign ``pins``_data = `DATA(``type``, ``pins``)

`define BREAKOUT_CE(type, pins) \
	wire ``pins``_ce;\
	assign ``pins``_ce = `CE(``type``, ``pins``)
	
`define BREAKOUT(type, pins) \
	`BREAKOUT_ADDR(``type``, ``pins``);\
	`BREAKOUT_DATA(``type``, ``pins``)