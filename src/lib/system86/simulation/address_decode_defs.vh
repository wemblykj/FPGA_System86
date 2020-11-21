`ifndef _address_decode_defs_vh_
`define _address_decode_defs_vh_

`include "../common.vh"

`define test_address_decode_range(expected, signal, address_bus, from, size, msb, lsb) \
	$display("Testing %s is %d over range 0x%H to 0x%H", `STRINGIFY(signal), expected, from, from+size-1); \
	for (address_msb = {{from}[msb+1:lsb]}; address_msb < {{(from+size)}[msb+1:lsb]}; address_msb = address_msb + 1) \
		begin \
			address_bus = address_msb[msb-lsb:0]; \
			address_low = (address_msb << lsb); \
			address_high = address_low | {{from+size-1}[lsb-1:0]}; \
			$write("\ttesting %s is %d over range 0x%H to 0x%H, %s <= %b: ", `STRINGIFY(signal), expected, address_low, address_high, `STRINGIFY(address_bus), address_bus); \
			#100 \
			if(signal != expected) \
				begin \
					$display("FAILED"); \
					$display("%s had value %d, expected %d for address 0x%H", `STRINGIFY(signal), signal, expected, address_low); \
					$finish(); \
				end \
			$display("PASSED"); \
		end
	
`endif //_address_decode_defs_vh_