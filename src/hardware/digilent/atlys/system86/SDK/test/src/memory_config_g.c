/* This file is automatically generated based on your hardware design. */
#include "memory_config.h"

struct memory_range_s memory_ranges[] = {
	/* microblaze_0_d_bram_ctrl_0 memory will not be tested since application resides in the same memory */
	{
		"microblaze_0_d_bram_ctrl_1",
		"lmb_bram_if_cntlr",
		0x00010000,
		65536,
	},
	{
		"microblaze_0_d_bram_cntlr_2",
		"lmb_bram_if_cntlr",
		0x00020000,
		8192,
	},
	{
		"mcb_ddr2",
		"axi_s6_ddrx",
		0xc0000000,
		134217728,
	},
};

int n_memory_ranges = 3;
