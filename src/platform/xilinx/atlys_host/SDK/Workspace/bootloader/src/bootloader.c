/*
 * Copyright (c) 2021 Paul Wightmore
 *
 * License: https://www.apache.org/licenses/LICENSE-2.0
 *
 * XSpi Numonyx flash quad IO routines taken from:
 * xspi_numonyx_flash_quad_example.c
 *
 * ELF processing inspired by implementation in
 * elf-bootloader.c by Henrik Brix Andersen
 */

#include "xparameters.h"
#include "xspi.h"
#include "xil_exception.h"
#include "xintc.h"

#include "xil_cache.h"
#include "xil_printf.h"

#include "platform.h"

#include "elf.h"	///< ELF image definitions
#include "vt.h"		///< vector table definition

#include <stdio.h>
#include <string.h>

/************************** Constant Definitions *****************************/

#define MAX_BLOCKSIZE 64		///< Maximum block size for reading from flash

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define SPI_FLASH_DEVICE_ID		XPAR_QSPI_FLASH_DEVICE_ID

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
//#define COMMAND_PAGE_PROGRAM		0x02 /* Page Program command */
//#define COMMAND_QUAD_WRITE		0x32 /* Quad Input Fast Program */
#define COMMAND_RANDOM_READ		0x03 /* Random read command */
#define COMMAND_DUAL_READ		0x3B /* Dual Output Fast Read */
//#define COMMAND_DUAL_IO_READ		0xBB /* Dual IO Fast Read */
#define COMMAND_QUAD_READ		0x6B /* Quad Output Fast Read */
//#define COMMAND_QUAD_IO_READ		0xEB /* Quad IO Fast Read */
//#define	COMMAND_WRITE_ENABLE		0x06 /* Write Enable command */
//#define COMMAND_SECTOR_ERASE		0xD8 /* Sector Erase command */
//#define COMMAND_BULK_ERASE		0xC7 /* Bulk Erase command */
#define COMMAND_STATUSREG_READ		0x05 /* Status read command */

/**
 * This definitions specify the EXTRA bytes in each of the command
 * transactions. This count includes Command byte, address bytes and any
 * don't care bytes needed.
 */
#define READ_WRITE_EXTRA_BYTES 4
//const u8 ReadWriteExtraBytes = 		4; /* Read/Write extra bytes */
//const u8 StatusReadByte =		2; /* Status read bytes count */

/*
 * Flash not busy mask in the ret register of the flash device.
 */
#define FLASH_SR_IS_READY_MASK		0x01 /* Ready mask */

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


//#define SPI_VALID_DATA_OFFSET (ReadWriteExtraBytes+DUAL_READ_DUMMY_BYTES)


/*
 * Base address of the ELF image in the SPI flash
 */
//#define ELF_IMAGE_BASEADDR		0x00FF0000
#define ELF_IMAGE_BASEADDR			0x00000000
#define BASE_VECTORS 				XPAR_MICROBLAZE_BASE_VECTORS

// pretty sure the XSpi is byte based so I'm thinking the Adept address is not be
/*
 * Enable debug for the ELF loader
 */
//#define DEBUG_ELF_HEADER
//#define DEBUG_ELF_PROG_HEADER

/**************************** Type Definitions *******************************/

typedef enum ReadMode {
	ReadMode_Standard,
	ReadMode_Double,
	ReadMode_Quad
} ReadMode;

typedef enum Command {
	Command_Read_Status = COMMAND_STATUSREG_READ,
	Command_Read_Standard = COMMAND_RANDOM_READ,
	Command_Read_Dual = COMMAND_DUAL_READ,
	Command_Read_Quad = COMMAND_QUAD_READ
} Command;

typedef enum ReadCommand {
	ReadCommand_Status = Command_Read_Status,
	ReadCommand_Standard = Command_Read_Standard,
	ReadCommand_Dual = Command_Read_Dual,
	ReadCommand_Quad = Command_Read_Quad
} ReadCommand;

typedef struct _ReadCommandAttr
{
	ReadCommand Command;			///< The read command
	u8 CommandExtraBytes;			///< Additional protocol bytes for the read associated mode
} ReadCommandAttr;

#define READ_STATUS_ATTR \
	{ ReadCommand_Status, 2 }

#define STANDARD_READ_ATTR \
	{ Command_Read_Standard, 0 }

#define DUAL_READ_ATTR \
	{ ReadCommand_Dual, DUAL_READ_DUMMY_BYTES }

#define QUAD_READ_ATTR \
	{ ReadCommand_Quad, QUAD_READ_DUMMY_BYTES }

ReadCommandAttr ReadModes[] = {
		STANDARD_READ_ATTR,
		DUAL_READ_ATTR,
		QUAD_READ_ATTR
};

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

static ReadCommandAttr SpiFlashReadMode(XSpi *SpiPtr);
static int SpiFlashReadRaw(XSpi *SpiPtr, u8* WriteBuffer, u8* ReadBuffer, u32 BufferSize);
static int SpiFlashRead(XSpi *SpiPtr, u32 Addr, u8* Dest, u32 Size);
static int SpiFlashVerify(XSpi *SpiPtr, u32 Addr, const u8* Dest, u32 Size);
static int SpiFlashGetStatus(XSpi *SpiPtr, u8* Status);
static int SpiFlashWaitForFlashReady(void);
static void SpiHandler(void *CallBackRef, u32 retEvent, unsigned int ByteCount);
static int SetupInterruptSystem(XSpi *SpiPtr);
static int ResetInterruptSystem(XSpi *SpiPtr);

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
volatile static int TransferInProgress = FALSE;

/*
 * The following variable tracks any errors that occur during interrupt
 * processing.
 */
volatile static int ErrorCount = 0;

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

	int ret, i;

	init_platform();

	//xil_printf("Spi Numonyx flash Quad SPI bootloader\r\n");
	xil_printf("%s - %d\r\n", __DATE__, __TIME__);

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
	/*ret = XSpi_SelfTest(&Spi);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}*/

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
	XSpi_SetStatusHandler(&Spi, &Spi, (XSpi_StatusHandler)SpiHandler);

	/*
	 * Set the SPI device as a master and in manual slave select mode such
	 * that the slave select signal does not toggle for every byte of a
	 * transfer, this must be done before the slave select is set.
	 */
	ret = XSpi_SetOptions(&Spi, XSP_MASTER_OPTION |
				 XSP_MANUAL_SSELECT_OPTION);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Start the SPI driver so that interrupts and the device are enabled.
	 */
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
	ret = XSpi_SetSlaveSelect(&Spi, SPI_SLAVE_SELECT);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Read the data from the Page using Quad Output Fast Read command.
	 *
	 * unable to configure COMMAND_QUAD_READ hardware, possibly due to HDMI resource
	 * requirements conflicting with the QSPI flash's IO2 and IO3 - DUAL seems to work though
	 */

	ElfHeader eh = {};
	VectorTable vt = {};
	u8 haveVectorTable = FALSE;

	ret = SpiFlashRead(&Spi, ELF_IMAGE_BASEADDR, (u8*)&eh, sizeof(ElfHeader));
	if(ret != XST_SUCCESS) {
		xil_printf("E1");
		return XST_FAILURE;
	}

#ifdef DEBUG_ELF_HEADER
	//xil_printf("Magic: 0x%08x\r\n", eh.Ident.Magic.asUint);
	xil_printf("Entry: 0x%08x\r\n", eh.Entry);
	xil_printf("PrgHdrOfs: 0x%08x\r\n", ELF_IMAGE_BASEADDR + eh.PrgHdrOfs);
	//xil_printf("SectHdrOfs: 0x%08x\r\n", ELF_IMAGE_BASEADDR + eh.SectHdrOfs);
#endif

	/*
	 * Validate ELF header
	 */
	if (memcmp(&eh.Ident.Magic, &ElfMagic, sizeof(ElfMagicType)) != 0) {
		//xil_printf("Invalid ELF header");
		xil_printf("E3");
		return XST_FAILURE;
	}

	// disable memory caches whilst transferring image to DDR
	disable_caches();

	/**
	 * Read ELF program headers
	 */
	u32 progHdrOfs = ELF_IMAGE_BASEADDR + eh.PrgHdrOfs;
	for (i = 0; i < eh.PrgHdrNum; i++) {
		ElfProgramHeader ph = {};

		ret = SpiFlashRead(&Spi, progHdrOfs, (u8*)&ph, sizeof(ph));
		if(ret != XST_SUCCESS) {
			//xil_printf("Failed to read ELF program header");
			xil_printf("E4");
			return XST_FAILURE;
		}

#ifdef DEBUG_ELF_PROG_HEADER
		xil_printf("Start of section: %d\r\n", i);
		xil_printf("Type: %x\r\n", ph.Type);
#endif

		if (ph.Type == PrgHdrType_Load) {
#ifdef DEBUG_ELF_PROG_HEADER
			xil_printf("Offset: %d\r\n", ELF_IMAGE_BASEADDR + ph.Offset);
			//xil_printf("FileSize: %d\r\n", ph.FileSize);
			//xil_printf("MemSize: %d\r\n", ph.MemSize);
			xil_printf("PhysAddr: 0x%08x\r\n", ph.PhysAddr);
#endif
			u32 segmentOffset = ELF_IMAGE_BASEADDR + ph.Offset;

			int bytesToRead = ph.FileSize;
			u8* pDest = (u8*)ph.PhysAddr;

			if (ph.PhysAddr == 0x00000000) {
				// Ensure we have the vector table from its expected size in memory
				Xil_AssertNonvoid(ph.MemSize == sizeof(VectorTable));
				pDest = (u8*)&vt;
				haveVectorTable = TRUE;
			}

			while (bytesToRead > 0)
			{
				int blockSize = (bytesToRead < MAX_BLOCKSIZE) ? bytesToRead : MAX_BLOCKSIZE;

				ret = SpiFlashRead(&Spi, segmentOffset, pDest, blockSize);
				if(ret != XST_SUCCESS) {
					//xil_printf("Failed to read ELF program section");
					xil_printf("E5");
					return XST_FAILURE;
				}

				ret = SpiFlashVerify(&Spi, segmentOffset, pDest, blockSize);
				if(ret != XST_SUCCESS) {
					//xil_printf("Failed to read ELF program section");
					xil_printf("E6");
					return XST_FAILURE;
				}

				segmentOffset += blockSize;
				pDest += blockSize;
				bytesToRead -= blockSize;

				if (bytesToRead % 1024 == 0) {
					xil_printf(".");
				}
			}

			// Pad the end of section with zeros
			if (ph.FileSize < ph.MemSize) {
				memset(pDest, 0, ph.MemSize - ph.FileSize);
			}
		}

		// next program header entry
		progHdrOfs += sizeof(ElfProgramHeader);
	}

	// Must [should?] disable interrupts before updating the vector table
	ResetInterruptSystem(&Spi);

	cleanup_platform();

	// Copy over the vector table for the new image
	if (haveVectorTable == TRUE) {
		//xil_printf("Reset: %x\r\n", vt.Reset);
		//xil_printf("Intr: %x\r\n", vt.Interrupt);
		memcpy(BASE_VECTORS, &vt, sizeof(VectorTable));

		if (memcmp(BASE_VECTORS, &vt, sizeof(VectorTable)) != 0) {
			//xil_printf("Invalid ELF header");
			xil_printf("E7");
			return XST_FAILURE;
		}
	}

	//xil_printf("\r\nCalling entry point at 0x%x\r\n", eh.Entry);
	// Call entry point (in most cases would appear to be a call to the reset vector)
	((EntryPoint)eh.Entry)();

	// Never reached
	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* Get the read mode attributes for the Spi device
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	The read mode attributes for the device
*
* @note		None
*
******************************************************************************/
ReadCommandAttr SpiFlashReadMode(XSpi *SpiPtr)
{
	return ReadModes[SpiPtr->SpiMode];
}

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
int SpiFlashReadRaw(XSpi *SpiPtr, u8* WriteBuffer, u8* ReadBuffer, u32 RawByteCount)
{
	int ret;

	/*
	 * Initiate the Transfer.
	 */
	//xil_printf("ST: %d\r\n", RawByteCount);
	TransferInProgress = TRUE;
	ret = XSpi_Transfer( SpiPtr, WriteBuffer, ReadBuffer, RawByteCount);
	if(ret != XST_SUCCESS) {
		xil_printf("E1");//_SFRR_T");
		return XST_FAILURE;
	}
	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction.
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		xil_printf("E2");//"E_SFRR_E");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function reads the data from the Numonyx Serial Flash Memory
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the starting address in the Flash Memory from which the
*		data is to be read.
* @param	Dest Is the destination into which the data will be written
* @param	Size is the number of bytes to be read.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int SpiFlashRead(XSpi *SpiPtr, u32 Addr, u8* Dest, u32 ByteCount)
{
	int ret;

	ReadCommandAttr rm = SpiFlashReadMode(SpiPtr);
	const int RawByteCount = rm.CommandExtraBytes + ByteCount;

	//xil_printf("CA: %x, %d, %d\r\n", rm.Command, rm.CommandExtraBytes, ByteCount);

	/*
	 * Buffers used during read and write transactions.
	 */
	u8 WriteBuffer[READ_WRITE_EXTRA_BYTES];
	u8 ReadBuffer[READ_WRITE_EXTRA_BYTES + RawByteCount];

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = rm.Command;
	WriteBuffer[BYTE2] = (u8) (Addr >> 16);
	WriteBuffer[BYTE3] = (u8) (Addr >> 8);
	WriteBuffer[BYTE4] = (u8) Addr;

	/*
	 * Wait while the Flash is busy.
	 */
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		//xil_printf("E_SFR_SFWFFR");
		return XST_FAILURE;
	}

	ret = SpiFlashReadRaw(SpiPtr, &WriteBuffer, &ReadBuffer, RawByteCount);
	if(ret != XST_SUCCESS) {
		//xil_printf("E_SFR_SFRR");
		return XST_FAILURE;
	}

	//xil_printf("3");

	memcpy(Dest, &ReadBuffer[rm.CommandExtraBytes], ByteCount);

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function reads the data from the Numonyx Serial Flash Memory
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the starting address in the Flash Memory from which the
*		data is to be read.
* @param	Src Is the source location to be verified
* @param	Size is the number of bytes to be verified.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int SpiFlashVerify(XSpi *SpiPtr, u32 Addr, const u8* Src, u32 ByteCount)
{
	int ret;

	ReadCommandAttr rm = SpiFlashReadMode(SpiPtr);
	const int RawByteCount = rm.CommandExtraBytes + ByteCount;

	/*
	 * Buffers used during read and write transactions.
	 */
	u8 WriteBuffer[READ_WRITE_EXTRA_BYTES];
	u8 ReadBuffer[READ_WRITE_EXTRA_BYTES + RawByteCount];

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = rm.Command;
	WriteBuffer[BYTE2] = (u8) (Addr >> 16);
	WriteBuffer[BYTE3] = (u8) (Addr >> 8);
	WriteBuffer[BYTE4] = (u8) Addr;

	/*
	 * Wait while the Flash is busy.
	 */
	ret = SpiFlashWaitForFlashReady();
	if(ret != XST_SUCCESS) {
		//xil_printf("E_SFV_SFWFFR");
		return XST_FAILURE;
	}

	ret = SpiFlashReadRaw(SpiPtr, &WriteBuffer, &ReadBuffer, RawByteCount);
	if(ret != XST_SUCCESS) {
		//xil_printf("E_SFV_SFRR");
		return XST_FAILURE;
	}

	if (memcmp(Src, &ReadBuffer[rm.CommandExtraBytes], ByteCount) != 0)
		//xil_printf("E_SFV_CP");
		return XST_FAILURE;

	return XST_SUCCESS;
}
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
int SpiFlashGetStatus(XSpi *SpiPtr, u8* Status)
{
	int ret;
	ReadCommandAttr rm = READ_STATUS_ATTR;

	//xil_printf("CA: %x, %d\r\n", rm.Command, rm.CommandExtraBytes);

	/*
	 * Buffers used during read and write transactions.
	 */
	u8 WriteBuffer[READ_WRITE_EXTRA_BYTES];
	u8 ReadBuffer[READ_WRITE_EXTRA_BYTES + rm.CommandExtraBytes];

	/*
	 * Prepare the WriteBuffer.
	 */
	WriteBuffer[BYTE1] = rm.Command;

	//xil_printf("u\r\n");
	ret = SpiFlashReadRaw(SpiPtr, &WriteBuffer, &ReadBuffer, rm.CommandExtraBytes);
	if(ret != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*int i;
	for (i = 0; i < (READ_WRITE_EXTRA_BYTES + rm.CommandExtraBytes); ++i)
	{
		xil_printf("ST[%d]: %x\r\n", i, ReadBuffer[i]);
	}*/

	*Status = ReadBuffer[1];

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

	while(1) {

		/*
		 * Get the ret Register. The ret register content is
		 * stored at the second byte pointed by the ReadBuffer.
		 */
		u8 status;
		ret = SpiFlashGetStatus(&Spi, &status);
		if(ret != XST_SUCCESS) {
			return XST_FAILURE;
		}

		/*
		 * Check if the flash is ready to accept the next command.
		 * If so break.
		 */
		if((status & FLASH_SR_IS_READY_MASK) == 0) {
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
	if (retEvent != XST_SPI_TRANSFER_DONE) {
		ErrorCount++;
	}

	TransferInProgress = FALSE;
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
int SetupInterruptSystem(XSpi *SpiPtr)
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

int ResetInterruptSystem(XSpi *SpiPtr)
{
	Xil_ExceptionDisable();

	return XST_SUCCESS;
}
