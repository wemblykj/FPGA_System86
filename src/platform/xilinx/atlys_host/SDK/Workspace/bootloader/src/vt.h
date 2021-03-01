/*
 * Copyright (c) 2021 Paul Wightmore
 * 
 * License: https://www.apache.org/licenses/LICENSE-2.0
 */
 
#ifndef __VT_H__
#define __VT_H__

/// @brief Definition for the Microblaze vector table
/// https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_2/ug984-vivado-microblaze-ref.pdf
typedef struct VectorTable {
	u32 Reset;
	u32 UserVector;				///< software exception;
	u32 Interrupt;				///< Interrupt handler 
	u32 Break;					///< Non-maskable
	u32 Exception;				///< hardware exception
	u32 Reserved[10];				
} VectorTable, *VectorTablePtr;

#endif