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
// Description:		 Macro helpers for working with TTL M27128 eprom chips 
//
// Dependencies:	 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// License:				 https://www.apache.org/licenses/LICENSE-2.0
//
//////////////////////////////////////////////////////////////////////////////////

`define DATA_WIDTH_M27128		8
`define ADDR_WIDTH_M27128		14
`define PINS_M27128				1:28
`define DATA_M27128(pins)		{ pins[19 -: 5], pins[13 -: 3] }
`define ADDR_M27128(pins)		{ pin[26], pin[2], pin[23], pin[21], pins[24 +: 2], pins[3 +: 8] }
`define nCE_M27128(pins)		{ pins[20] }
`define CE_M27128(pins)			{ ~pins[20] }
`define nOE_M27128(pins)		{ pins[22] }
`define OE_M27128(pins)			{ ~pins[22] }
`define GND_M27128(pins)		{ pins[14] }
`define VCC_M27128(pins)		{ pins[28] }
