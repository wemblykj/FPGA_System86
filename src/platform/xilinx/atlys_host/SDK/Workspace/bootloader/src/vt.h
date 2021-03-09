/*
 * Copyright (c) 2021 Paul Wightmore
 * 
 * License: https://www.apache.org/licenses/LICENSE-2.0
 */
 
#ifndef __VT_H__
#define __VT_H__

#pragma pack(push, 8)

typedef struct VectorTableEntry {
	u8 data[8];								///< 8 bytes of arbitrary code
} VectorTableEntry;

/// @brief Definition for the Microblaze vector table
/// https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_2/ug984-vivado-microblaze-ref.pdf
typedef struct VectorTable {
	VectorTableEntry Reset;
	VectorTableEntry UserVector;				///< software exception;
	VectorTableEntry Interrupt;				///< Interrupt handler
	VectorTableEntry Break;					///< Non-maskable
	VectorTableEntry Exception;				///< hardware exception
} VectorTable, *VectorTablePtr;

#pragma pack(pop)

#endif
