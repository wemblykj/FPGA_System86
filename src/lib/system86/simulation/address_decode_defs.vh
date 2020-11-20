`ifndef _address_decode_defs_vh_
`define _address_decode_defs_vh_

`include "../common.vh"

`define test_address_decode_range(expected, signal, address_bus, lsb, from, to) \
	$write("Testing %s is %d over range 0x%H to 0x%H: ", `STRINGIFY(signal), expected, from << lsb, to << lsb); \
	for (i = from; i < to; i = i + 1) \
		begin \
			address_bus = i; \
			#100 \
			if(signal != expected) \
				begin \
					$display("FAILED"); \
					$display("%s had value %d, expected %d for address 0x%H", `STRINGIFY(signal), signal, expected, i << lsb); \
					$finish(); \
				end \
		end \
	$display("PASSED");
		
	
`endif //_address_decode_defs_vh_