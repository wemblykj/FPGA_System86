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
// Description:		 Macro helpers for working with TTL MB7116 prom chips
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`define DATA_WIDTH_MB7116		4
`define ADDR_WIDTH_MB7116		9
`define PINS_MB7116				1:16
`define DATA_MB7116(pins)		{ pins[9 +: 4] }
`define ADDR_MB7116(pins)		{ pins[14 +: 1], pins[1 +: 7] }
`define nCE_MB7116(pins)		{ pins[13] }
`define CE_MB7116(pins)			{ ~pins[13] }
`define GND_MB7116(pins)		{ pins[8] }
`define VCC_MB7116(pins)		{ pins[16] }
