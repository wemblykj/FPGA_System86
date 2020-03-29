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
// Description:		 Macro helpers for working with TTL MB7138 prom chips
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`define DATA_WIDTH_MB7138		8
`define ADDR_WIDTH_MB7138		11
`define PINS_MB7138				1:24
`define DATA_MB7138(pins)		{ pins[17 -: 5], pins[11 -: 3] }
`define ADDR_MB7138(pins)		{ pins[21 +: 3], pins[1 +: 8] }
`define nCE_MB7138(pins)		{ pins[20] }
`define CE_MB7138(pins)			{ ~pins[20] }
`define CE2_MB7138(pins)		{ pins[19] }
`define CE3_MB7138(pins)		{ pins[18] }
`define GND_MB7138(pins)		{ pins[22] }
`define VCC_MB7138(pins)		{ pins[24] }
