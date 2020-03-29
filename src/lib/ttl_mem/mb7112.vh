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
// Description:		 Macro helpers for working with TTL MB7112 prom chips
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`define DATA_WIDTH_MB7112		8
`define ADDR_WIDTH_MB7112		5
`define PINS_MB7112				1:16
`define DATA_MB7112(pins)		{ pins[9], pins[7 -: 7] }
`define ADDR_MB7112(pins)		{ pins[14 -: 5] }
`define nCE_MB7112(pins)		{ pins[15] }
`define CE_MB7112(pins)			{ ~pins[15] }
`define GND_MB7112(pins)		{ pins[8] }
`define VCC_MB7112(pins)		{ pins[16] }
