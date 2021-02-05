/******************************************************************************
* XSpi Numonyx flash quad IO routines taken from:
* xspi_numonyx_flash_quad_example.c
*
* Copyright (C) 2012 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

/*
 * elf32.h and ELF parsing code taken from elf-bootloader.c
 *
 * TBD: find link to source
 *
 * Copyright (c) 2015-2017 Henrik Brix Andersen <henrik@brixandersen.dk>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

/***************************** Include Files *********************************/

#include "xparameters.h"		/* EDK generated parameters */
#include "xspi.h"				/* SPI device driver */
#include "xil_exception.h"
#include "xintc.h"

//#include "mb_interface.h"		/* Microblaze */
#include "xil_cache.h"
#include "xil_printf.h"

#include "platform.h"

#include "elf32.h"				/* ELF header definitions */

#include <stdio.h>
#include <string.h>

#define USE_TEST 1

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define SPI_FLASH_DEVICE_ID			XPAR_QSPI_FLASH_DEVICE_ID

#define INTC_DEVICE_ID			XPAR_INTC_0_DEVICE_ID
#define SPI_INTR_ID				XPAR_INTC_0_SPI_0_VEC_ID



#define INTC		    static XIntc
#define INTC_HANDLER	XIntc_InterruptHandler

/*
 * The following constant defines the slave select signal that is used to
 * to select the Flash device on the SPI bus, this signal is typically
 * connected to the chip select of the device.
 */
#define SPI_SLAVE_SELECT 			0x01

/*
 * Definitions of the commands shown in this example.
 */
#define COMMAND_PAGE_PROGRAM		0x02 /* Page Program command */
#define COMMAND_QUAD_WRITE		0x32 /* Quad Input Fast Program */
#define COMMAND_RANDOM_READ		0x03 /* Random read command */
#define COMMAND_DUAL_READ		0x3B /* Dual Output Fast Read */
#define COMMAND_DUAL_IO_READ		0xBB /* Dual IO Fast Read */
#define COMMAND_QUAD_READ		0x6B /* Quad Output Fast Read */
#define COMMAND_QUAD_IO_READ		0xEB /* Quad IO Fast Read */
#define	COMMAND_WRITE_ENABLE		0x06 /* Write Enable command */
#define COMMAND_SECTOR_ERASE		0xD8 /* Sector Erase command */
#define COMMAND_BULK_ERASE		0xC7 /* Bulk Erase command */
#define COMMAND_STATUSREG_READ		0x05 /* Status read command */

/**
 * This definitions specify the EXTRA bytes in each of the command
 * transactions. This count includes Command byte, address bytes and any
 * don't care bytes needed.
 */
#define READ_WRITE_EXTRA_BYTES		4 /* Read/Write extra bytes */
#define	WRITE_ENABLE_BYTES		1 /* Write Enable bytes */
#define SECTOR_ERASE_BYTES		4 /* Sector erase extra bytes */
#define BULK_ERASE_BYTES		1 /* Bulk erase extra bytes */
#define STATUS_READ_BYTES		2 /* Status read bytes count */
#define STATUS_WRITE_BYTES		2 /* Status write bytes count */

/*
 * Flash not busy mask in the ret register of the flash device.
 */
#define FLASH_SR_IS_READY_MASK		0x01 /* Ready mask */

/*
 * Number of bytes per page in the flash device.
 */
#define PAGE_SIZE			256

/*
 * Byte Positions.
 */
#define BYTE1				0 /* Byte 1 position */
#define BYTE2				1 /* Byte 2 position */
#define BYTE3				2 /* Byte 3 position */
#define BYTE4				3 /* Byte 4 position */
#define BYTE5				4 /* Byte 5 position */
#define BYTE6				5 /* Byte 6 position */
#define BYTE7				6 /* Byte 7 position */
#define BYTE8				7 /* Byte 8 position */

/*
 * The following definitions specify the number of dummy bytes to ignore in the
 * data read from the flash, through various Read commands. This is apart from
 * the dummy bytes returned in response to the command and address transmitted.
 */
/*
 * After transmitting Dual Read command and address on DIO0,the quad spi device
 * configures DIO0 and DIO1 in input mode and receives data on both DIO0 and
 * DIO1 for 8 dummy clock cycles. So we end up with 16 dummy bits in DRR. The
 * same logic applies Quad read command, so we end up with 4 dummy bytes in
 * that case.
 */
#define DUAL_READ_DUMMY_BYTES		2
#define QUAD_READ_DUMMY_BYTES		4

#define DUAL_IO_READ_DUMMY_BYTES	2
#define QUAD_IO_READ_DUMMY_BYTES	5


#define SPI_VALID_DATA_OFFSET (READ_WRITE_EXTRA_BYTES+DUAL_READ_DUMMY_BYTES)
#define EFFECTIVE_READ_BUFFER_SIZE PAGE_SIZE

/*
 * Base address of the ELF image in the SPI flash
 */
#define ELF_IMAGE_BASEADDR		0x00FF0000
//#define ELF_IMAGE_BASEADDR		0x00000000

/*S
 * Enable debug for the ELF loader
 */
#define DEBUG_ELF_LOADER

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

int SpiFlashWriteEnable(XSpi *SpiPtr);
int SpiFlashWrite(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 WriteCmd);
int SpiFlashRead(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 ReadCmd);
int SpiFlashBulkErase(XSpi *SpiPtr);
int SpiFlashSectorErase(XSpi *SpiPtr, u32 Addr);
int SpiFlashGetStatus(XSpi *SpiPtr);
int SpiFlashQuadEnable(XSpi *SpiPtr);
int SpiFlashEnableHPM(XSpi *SpiPtr);
static int SpiFlashWaitForFlashReady(void);
void SpiHandler(void *CallBackRef, u32 retEvent, unsigned int ByteCount);
static int SetupInterruptSystem(XSpi *SpiPtr);

int (*boot_app) (void);

/************************** Variable Definitions *****************************/

/*
 * The instances to support the device drivers are global such that they
 * are initialized to zero each time the program runs. They could be local
 * but should at least be static so they are zeroed.
 */
static XSpi Spi;
INTC InterruptController;

/*
 * The following variables are shared between non-interrupt processing and
 * interrupt processing such that they must be global.
 */
volatile static int TransferInProgress;

/*
 * The following variable tracks any errors that occur during interrupt
 * processing.
 */
static int ErrorCount;

/*
 * Buffers used during read and write transactions.
 */
static u8 ReadBuffer[PAGE_SIZE + READ_WRITE_EXTRA_BYTES + 4];

#ifndef USE_TEST
static u8 WriteBuffer[READ_WRITE_EXTRA_BYTES];
#else
static u8 WriteBuffer[PAGE_SIZE + READ_WRITE_EXTRA_BYTES];
#endif

/*
 * Byte offset value written to Flash. This needs to be redefined for writing
 * different patterns of data to the Flash device.
 */
static u8 TestByte = 0x65;

/************************** Function Definitions *****************************/

/*****************************************************************************/
/**
*
* Main function to run the quad flash example.
*
* @param	None
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int main(void)
{
	XSpi_Config *ConfigPtr;	/* Pointer to Configuration data */

#ifndef USE_TEST
	int ret, i, j;
	u32 addr;
	elf32_hdr hdr;
	elf32_phdr phdr;
#else
	int ret, i;
#endif

	init_uart();

	xil_printf("Spi Numonyx flash Quad SPI bootloader\r\n");
	xil_printf("%s - %d\r\n", __DATE__, __TIME__);

	/*
	 * Disable caches
	 */
	disable_caches();

	/*
	 * Initialize the SPI driver so that it's ready to use,
	 * specify the device ID that is generated in xparameters.h.
	 */
	ConfigPtr = XSpi_LookupConfig(SPI_FLASH_DEVICE_ID);
	if (ConfigPtr == NULL) {
		return XST_DEVICE_NOT_FOUND;
	}

	ret = XSpi_CfgInitialize(&Spi, ConfigPtr,
				  ConfigPtr->BaseAddress);
	if (ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	//Perform a self-test to ensure that the hardware was built correctly.
	xil_printf("test\r\n");
	ret = XSpi_SelfTest(&Spi);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the SPI driver to the interrupt subsystem such that
	 * interrupts can occur. This function is application specific.
	 */
	ret = SetupInterruptSystem(&Spi);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the handler for the SPI that will be called from the interrupt
	 * context when an SPI ret occurs, specify a pointer to the SPI
	 * driver instance as the callback reference so the handler is able to
	 * access the instance data.
	 */
	xil_printf("set status handler\r\n");
	XSpi_SetStatusHandler(&Spi, &Spi, (XSpi_StatusHandler)SpiHandler);

	/*
	 * Set the SPI device as a master and in manual slave select mode such
	 * that the slave select signal does not toggle for every byte of a
	 * transfer, this must be done before the slave select is set.
	 */
	xil_printf("set options\r\n");
	ret = XSpi_SetOptions(&Spi, XSP_MASTER_OPTION |
				 XSP_MANUAL_SSELECT_OPTION);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Start the SPI driver so that interrupts and the device are enabled.
	 */
	xil_printf("start\r\n");
	ret = XSpi_Start(&Spi);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Select the quad flash device on the SPI bus, so that it can be
	 * read and written using the SPI bus.
	 *
	 * Been having problems with reading nothing but zeros...
	 * apparently must be done after device has started
	 */
	xil_printf("select\r\n");
	ret = XSpi_SetSlaveSelect(&Spi, SPI_SLAVE_SELECT);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

#ifdef USE_TEST
	xil_printf("TEST MODE\r\n");

	/*
	 * Perform the Write Enable operation.
	 */
	ret = SpiFlashWriteEnable(&Spi);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	xil_printf("erase\r\n");

	/*
	 * Perform the Sector Erase operation.
	 */
	ret = SpiFlashSectorErase(&Spi, ELF_IMAGE_BASEADDR /*Address*/);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	/*
	 * Perform the Write Enable operation.
	 */
	ret = SpiFlashWriteEnable(&Spi);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	xil_printf("write\r\n");

	/*
	 * Write the data to the Page using Page Program command.
	 */
	ret = SpiFlashWrite(&Spi, ELF_IMAGE_BASEADDR/*Address*/, PAGE_SIZE, COMMAND_PAGE_PROGRAM);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	/*
	 * Clear the read Buffer.
	 */
	for(i = 0; i < PAGE_SIZE + READ_WRITE_EXTRA_BYTES; i++) {
		ReadBuffer[i] = 0x0;
	}

	/*
	 * Read the data from the Page using Random Read command.
	 */
	/*ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR / *Address* /, PAGE_SIZE, COMMAND_RANDOM_READ);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}*/

		/*
	 * Compare the data read against the data written.
	 */
	/*for(i = 0; i < PAGE_SIZE; i++) {
		if(ReadBuffer[i + READ_WRITE_EXTRA_BYTES] !=
					(u8)(i + TestByte)) {
			return XST_FAILURE;
		}
	}*/



	/*
	 * Clear the Read Buffer.
	 */
	for(i = 0; i < PAGE_SIZE + READ_WRITE_EXTRA_BYTES +
	    DUAL_READ_DUMMY_BYTES; i++) {
		ReadBuffer[i] = 0x0;
	}

	xil_printf("read\r\n");

	/*
	 * Read the data from the Page using Dual Output Fast Read command.
	 */
	ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR /*Address*/, PAGE_SIZE, COMMAND_DUAL_READ);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	xil_printf("compare:\r\n");

	/*
	 * Compare the data read against the data written.
	 */
	for(i = 0; i < PAGE_SIZE; i++) {
		const u8 read =ReadBuffer[i + READ_WRITE_EXTRA_BYTES + DUAL_READ_DUMMY_BYTES];
		const u8 expected = (u8)(i + TestByte);

		if(read != expected) {
			xil_printf("failed: 0x%06x expected 0x%x but got 0x%x\r\n", ELF_IMAGE_BASEADDR+i, expected, read);
			return XST_FAILURE;
		}
	}

	xil_printf("done\r\n");
	/*
	 * Clear the read Buffer.
	 */
	/*for(Index = 0; Index < PAGE_SIZE + READ_WRITE_EXTRA_BYTES +
			  QUAD_READ_DUMMY_BYTES; Index++) {
		ReadBuffer[Index] = 0x0;
	}*/
#else
	/*
	 * Read the data from the Page using Quad Output Fast Read command.
	 *
	 * unable to configure COMMAND_QUAD_READ hardware, possibly due to HDMI resource
	 * requirements conflicting with the QSPI flash's IO2 and IO3 - DUAL seems to work though
	 */
	xil_printf("read\r\n");
	ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR, sizeof(hdr), COMMAND_DUAL_READ/*COMMAND_QUAD_READ*/);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	xil_printf("process\r\n");
	// Extract the elf header
	if (ret == XST_SUCCESS) {
		memcpy(&hdr, ReadBuffer + SPI_VALID_DATA_OFFSET, sizeof(hdr));

#ifdef DEBUG_ELF_LOADER
		xil_printf("hdr.ident:\r\n");
		for (i = 0; i < HDR_IDENT_NBYTES; i++) {
			putnum(hdr.ident[i]);
			xil_printf("\r\n");
		}
#endif
	} else {
		xil_printf("Failed to read ELF header");
		return -1;
	}

	/*
	 * Validate ELF header
	 */
	if (hdr.ident[0] != HDR_IDENT_MAGIC_0 ||
			hdr.ident[1] != HDR_IDENT_MAGIC_1 ||
			hdr.ident[2] != HDR_IDENT_MAGIC_2 ||
			hdr.ident[3] != HDR_IDENT_MAGIC_3) {
		xil_printf("Invalid ELF header");
		return -1;
	}

	/**
	 * Read ELF program headers
	 */
	for (i = 0; i < hdr.phnum; i++) {
		ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR + hdr.phoff + i * sizeof(phdr), sizeof(phdr), COMMAND_QUAD_READ);
		if(ret != XST_SUCCESS) {
			xil_printf("Failed to read ELF program header");
			return XST_FAILURE;
		}

		memcpy(&phdr, ReadBuffer + SPI_VALID_DATA_OFFSET, sizeof(phdr));

		if (phdr.type == PHDR_TYPE_LOAD) {
			/*
			 * Copy program segment from flash to RAM
			 */
			for (addr = 0; addr < phdr.filesz; addr += EFFECTIVE_READ_BUFFER_SIZE) {
				if (addr + EFFECTIVE_READ_BUFFER_SIZE > phdr.filesz) {

					ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR + phdr.offset + addr,
							phdr.filesz - addr, COMMAND_QUAD_READ);
					if(ret != XST_SUCCESS) {
						xil_printf("Failed to read ELF program section");
						return XST_FAILURE;
					}

#ifdef DEBUG_ELF_LOADER
					xil_printf("End of section: %d\r\n", i);

					xil_printf("filesz: %d\r\n", phdr.filesz);

					xil_printf("addr: 0x%x\r\n", addr);

					xil_printf("segment end:\r\n");
					for (j = 15; j >= 0; j--) {
						xil_printf("0x%x ", ReadBuffer[SPI_VALID_DATA_OFFSET + phdr.filesz - addr - j]);
					}
					xil_printf("\r\n");
#endif

				} else {
					ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR + phdr.offset + addr,
							EFFECTIVE_READ_BUFFER_SIZE, COMMAND_QUAD_READ);
					if(ret != XST_SUCCESS) {
						xil_printf("Failed to read ELF program segment");
						return XST_FAILURE;
					}

#ifdef DEBUG_ELF_LOADER
					if (addr == 0) {
						xil_printf("segment start:\r\n");
						for (j = 0; j < EFFECTIVE_READ_BUFFER_SIZE; j++) {
							xil_printf("0x%x ", ReadBuffer[SPI_VALID_DATA_OFFSET + j]);
						}
						xil_printf("\r\n");
					}
#endif
				}

				if (ret == XST_SUCCESS) {
					if (addr + EFFECTIVE_READ_BUFFER_SIZE > phdr.filesz) {
						memcpy((void*)phdr.paddr + addr, ReadBuffer + SPI_VALID_DATA_OFFSET, phdr.filesz - addr);
					} else {
						memcpy((void*)phdr.paddr + addr, ReadBuffer + SPI_VALID_DATA_OFFSET, EFFECTIVE_READ_BUFFER_SIZE);
					}

					if (addr % 1024 == 0) {
						xil_printf(".");
					}
				} else {
					xil_printf("Failed to read ELF program segment");
					return -1;
				}
			}

			/*
			 * Fill remaining segment in RAM with zeros
			 */
			if (phdr.memsz > phdr.filesz) {
				memset((void*)(phdr.paddr + phdr.filesz), 0, phdr.memsz - phdr.filesz);
			}
		}
	}

	enable_caches();

	/**
	 * Jump to ELF entry address
	 */
	//xil_printf("\r\nTransferring execution to program @ 0x%x\r\n", hdr.entry);

	((void (*)())hdr.entry)();
#endif // USE_TEST

	// Never reached
	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function enables writes to the Numonyx Serial Flash memory.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int SpiFlashWriteEnable(XSpi *SpiPtr)
{
	int ret;

	/*
	 * Wait while the Flash is busy.
	 */
	xil_printf("wait for flash\r\n");
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = COMMAND_WRITE_ENABLE;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	xil_printf("xfer\r\n");
	ret = XSpi_Transfer(SpiPtr, WriteBuffer, NULL,
				WRITE_ENABLE_BYTES);
	if(ret != XST_SUCCESS) {
		xil_printf("failed\r\n");
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	xil_printf("wait for interrupt\r\n");
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function writes the data to the specified locations in the Numonyx Serial
* Flash memory.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the address in the Buffer, where to write the data.
* @param	ByteCount is the number of bytes to be written.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
#ifdef USE_TEST
int SpiFlashWrite(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 WriteCmd)
{
	u32 Index;
	int ret;

	/*
	 * Wait while the Flash is busy.
	 */
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = WriteCmd;
	WriteBuffer[BYTE2] = (u8) (Addr >> 16);
	WriteBuffer[BYTE3] = (u8) (Addr >> 8);
	WriteBuffer[BYTE4] = (u8) Addr;


	/*
	 * Fill in the TEST data that is to be written into the Numonyx Serial
	 * Flash device.
	 */
	for(Index = 4; Index < ByteCount + READ_WRITE_EXTRA_BYTES; Index++) {
		WriteBuffer[Index] = (u8)((Index - 4) + TestByte);
	}

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	ret = XSpi_Transfer(SpiPtr, WriteBuffer, NULL,
				(ByteCount + READ_WRITE_EXTRA_BYTES));
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction.
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}
#endif

/*****************************************************************************/
/**
*
* This function reads the data from the Numonyx Serial Flash Memory
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the starting address in the Flash Memory from which the
*		data is to be read.
* @param	ByteCount is the number of bytes to be read.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int SpiFlashRead(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 ReadCmd)
{
	int ret;

	/*
	 * Wait while the Flash is busy.
	 */
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = ReadCmd;
	WriteBuffer[BYTE2] = (u8) (Addr >> 16);
	WriteBuffer[BYTE3] = (u8) (Addr >> 8);
	WriteBuffer[BYTE4] = (u8) Addr;

	if (ReadCmd == COMMAND_DUAL_READ) {
		ByteCount += DUAL_READ_DUMMY_BYTES;
	} else if (ReadCmd == COMMAND_DUAL_IO_READ) {
		ByteCount += DUAL_READ_DUMMY_BYTES;
	} else if (ReadCmd == COMMAND_QUAD_IO_READ) {
		ByteCount += QUAD_IO_READ_DUMMY_BYTES;
	} else if (ReadCmd==COMMAND_QUAD_READ) {
		ByteCount += QUAD_READ_DUMMY_BYTES;
	}

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	ret = XSpi_Transfer( SpiPtr, WriteBuffer, ReadBuffer,
				(ByteCount + READ_WRITE_EXTRA_BYTES));
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction.
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

#ifdef USE_TEST
/*****************************************************************************/
/**
*
* This function erases the entire contents of the Numonyx Serial Flash device.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The erased bytes will read as 0xFF.
*
******************************************************************************/
int SpiFlashBulkErase(XSpi *SpiPtr)
{
	int ret;

	/*
	 * Wait while the Flash is busy.
	 */
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = COMMAND_BULK_ERASE;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	ret = XSpi_Transfer(SpiPtr, WriteBuffer, NULL,
						BULK_ERASE_BYTES);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function erases the contents of the specified Sector in the Numonyx
* Serial Flash device.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the address within a sector of the Buffer, which is to
*		be erased.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The erased bytes will be read back as 0xFF.
*
******************************************************************************/
int SpiFlashSectorErase(XSpi *SpiPtr, u32 Addr)
{
	int ret;

	/*
	 * Wait while the Flash is busy.
	 */
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = COMMAND_SECTOR_ERASE;
	WriteBuffer[BYTE2] = (u8) (Addr >> 16);
	WriteBuffer[BYTE3] = (u8) (Addr >> 8);
	WriteBuffer[BYTE4] = (u8) (Addr);

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	ret = XSpi_Transfer(SpiPtr, WriteBuffer, NULL,
					SECTOR_ERASE_BYTES);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}
#endif // USE_TEST

/*****************************************************************************/
/**
*
* This function reads the ret register of the Numonyx Flash.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The ret register content is stored at the second byte
*		pointed by the ReadBuffer.
*
******************************************************************************/
int SpiFlashGetStatus(XSpi *SpiPtr)
{
	int ret;

	/*
	 * Prepare the Write Buffer.
	 */
	WriteBuffer[BYTE1] = COMMAND_STATUSREG_READ;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	ret = XSpi_Transfer(SpiPtr, WriteBuffer, ReadBuffer,
						STATUS_READ_BYTES);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}



/*****************************************************************************/
/**
*
* This function waits till the Numonyx serial Flash is ready to accept next
* command.
*
* @param	None
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		This function reads the ret register of the Buffer and waits
*.		till the WIP bit of the ret register becomes 0.
*
******************************************************************************/
int SpiFlashWaitForFlashReady(void)
{
	int ret;
	u8 retReg;

	while(1) {

		/*
		 * Get the ret Register. The ret register content is
		 * stored at the second byte pointed by the ReadBuffer.
		 */
		ret = SpiFlashGetStatus(&Spi);
		if(ret != XST_SUCCESS) {
			return XST_FAILURE;
		}

		/*
		 * Check if the flash is ready to accept the next command.
		 * If so break.
		 */
		retReg = ReadBuffer[1];
		if((retReg & FLASH_SR_IS_READY_MASK) == 0) {
			break;
		}
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function is the handler which performs processing for the SPI driver.
* It is called from an interrupt context such that the amount of processing
* performed should be minimized. It is called when a transfer of SPI data
* completes or an error occurs.
*
* This handler provides an example of how to handle SPI interrupts and
* is application specific.
*
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
* @param	retEvent is the event that just occurred.
* @param	ByteCount is the number of bytes transferred up until the event
*		occurred.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void SpiHandler(void *CallBackRef, u32 retEvent, unsigned int ByteCount)
{
	//xil_printf("interrupt received\r\n");
	/*
	 * Indicate the transfer on the SPI bus is no longer in progress
	 * regardless of the ret event.
	 */
	TransferInProgress = FALSE;

	/*
	 * If the event was not transfer done, then track it as an error.
	 */
	if (retEvent != XST_SPI_TRANSFER_DONE) {
		ErrorCount++;
	}
}

/*****************************************************************************/
/**
*
* This function setups the interrupt system such that interrupts can occur
* for the Spi device. This function is application specific since the actual
* system may or may not have an interrupt controller. The Spi device could be
* directly connected to a processor without an interrupt controller.  The
* user should modify this function to fit the application.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None
*
******************************************************************************/
static int SetupInterruptSystem(XSpi *SpiPtr)
{

	int ret;

	/*
	 * Initialize the interrupt controller driver so that
	 * it's ready to use, specify the device ID that is generated in
	 * xparameters.h
	 */
	ret = XIntc_Initialize(&InterruptController, INTC_DEVICE_ID);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect a device driver handler that will be called when an
	 * interrupt for the device occurs, the device driver handler
	 * performs the specific interrupt processing for the device
	 */
	ret = XIntc_Connect(&InterruptController,
				SPI_INTR_ID,
				(XInterruptHandler)XSpi_InterruptHandler,
				(void *)SpiPtr);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Start the interrupt controller such that interrupts are enabled for
	 * all devices that cause interrupts, specific real mode so that
	 * the SPI can cause interrupts through the interrupt controller.
	 */
	ret = XIntc_Start(&InterruptController, XIN_REAL_MODE);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Enable the interrupt for the SPI.
	 */
	XIntc_Enable(&InterruptController, SPI_INTR_ID);

	/*
	 * Initialize the exception table.
	 */
	Xil_ExceptionInit();

	/*
	 * Register the interrupt controller handler with the exception table.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler)INTC_HANDLER,
				&InterruptController);

	/*
	 * Enable non-critical exceptions.
	 */
	Xil_ExceptionEnable();

	return XST_SUCCESS;
}
