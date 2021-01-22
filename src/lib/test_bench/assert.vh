`ifndef test_bench_assert_vh
`define test_bench_assert_vh

`include "common/common.vh"

`define ASSERT_MSG(cond, msg) \
	if (!(cond)) \
		begin \
			$display(msg); \
			$stop; \
		end

`define ASSERT(cond) ASSERT_MSG(cond, `STRINGIFY(cond))

`define ASSERT_EQUAL(expected, actual) `ASSERT_MSG(expected === actual, `"actual != expected`")

`endif // test_bench_assert_vh
