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
// Description:		 Macro helpers for working with TTL MB7124 prom chips
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`define DATA_WIDTH_MB7124		8
`define ADDR_WIDTH_MB7124		9
`define PINS_MB7124				1:20
`define DATA_MB7124(pins)		{ pins[14 -: 4], pins[9 -: 4] }
`define ADDR_MB7124(pins)		{ pins[19 -: 4], pins[5 -: 5] }
`define nCE_MB7124(pins)		{ pins[15] }
`define CE_MB7124(pins)			{ ~pins[15] }
`define GND_MB7124(pins)		{ pins[10] }
`define VCC_MB7124(pins)		{ pins[20] }
