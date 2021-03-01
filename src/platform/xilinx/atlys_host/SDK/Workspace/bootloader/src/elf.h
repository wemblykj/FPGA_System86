/*
 * Copyright (c) 2021 Paul Wightmore
 * 
 * License: https://www.apache.org/licenses/LICENSE-2.0
 */
 
#ifndef __ELF_HEADER_H__
#define __ELF_HEADER_H__

// Written purely based on information from Wikipedia
// https://en.wikipedia.org/wiki/Executable_and_Linkable_Format

typedef u32 SizeT;			///< Platform specific size type
typedef SizeT *PtrT;		///< Platform specific pointer type

typedef enum PrgHdrType {
	PrgHdrType_Load = 1
} PrgHdrType;

typedef enum SectHdrType {
	SectHdrType_StrTbl = 3
} SectHdrType;

#pragma pack(push, 4)

typedef union ElfMagicType {
	u8 data[4];				///< Raw bytes of magic number
	u32 asUint;				///< As a 32-bt unsigned int
} ElfMagicType;

#pragma pack(pop)

#pragma pack(push, 8)

/// @brief The ELF identification information
typedef struct ElfIdent {
	ElfMagicType Magic;
	u8 Class;				///< Platform (1 = 32-bit, 2 = 64-bit)
	u8 Data;				///< Endiness (1 = little, 2 = big)
	u8 Version;				///< 1 = Original ELF 
	u8 OSAbi;				///< Target O/S
	u8 ABIVersion;			///< Depends on target O/S
	//u8 Pad[7];				///< Padding for alignment
} ElfIdent, *ElfIdentPtr;

typedef struct ElfHeader {
	ElfIdent Ident;		///< Te ELFs identification info
	u16 Type;				///< Object file type
	u16 Machine;			///< Target ISA
	u32 Version;			///< 1 = Original ELF 
	PtrT Entry;				///< Entry point
	SizeT PrgHdrOfs;		///< Program header table offset
	SizeT SectHdrOfs;		///< Section header table offset
	u32 Flags;				///< Flags - architecture specific
	u16 ElfHdrSize;			///< Size of this header (52 bytes for 32-bit)
	u16 PrgHdrEntSize;		///< Size of a program header table entry
	u16 PrgHdrNum;			///< Number of entries in the program heaser table
	u16 SectHdrEntSize;		///< Size of a section header table entry
	u16 SectHdrNum;			///< Number of entries in the section heaser table
	u16 SectNameIdx;		///< Index of section entry that contains section names
} ElfHeader, *ElfHeaderPtr;

/// @brief A program header entry
typedef struct ElfProgramHeader {
	PrgHdrType Type;		///< Program header type
	//u32 Flags;			///< Segment-dependent flags (position in 64-bit)
	SizeT Offset;			///< Offset of the segment in the image
	PtrT VirtAddr;			///< Virtual address of segment in memory
	PtrT PhysAddr;			///< Pysical address of segment in memory
	SizeT FileSize;			///< Size in bytes of segment in image
	SizeT MemSize;			///< Size in bytes of segment in memory
	u32 Flags;				///< Segment-dependent flags (position in 32-bit)
	SizeT Alignment;		///< 
} ElfProgramHeader, *ElfProgramHeaderPtr;

/// @brief A section header entry
typedef struct ElfSectionHeader {
	u32 Name;				///< Offset of name of this section in .shstrtab section
	SectHdrType Type;		///< Section header type
	SizeT Flags;			///< Section attributes
	PtrT VirtAddr;			///< Virtual address of section in memory
	SizeT Offset;			///< Offset of the section in the image
	SizeT FileSize;			///< Size in bytes of segment in image
	u32 Link;				///< Link to an associated section
	u32 Info;				///< Additional information for the section
	SizeT Alignment;		///< 
	SizeT EntrySize;		///< Contains size, in bytes, of each [section] entry
} ElfSectionHeader, *ElfSectionHeaderPtr;

#pragma pack(pop)

const ElfMagicType ElfMagic = {};
#endif