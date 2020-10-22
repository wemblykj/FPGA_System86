/******************************************************************************
*
* (c) Copyright 2012-2013 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
******************************************************************************/
/*****************************************************************************/
/**
 *
 * @file xaxivdma_example_intr.c
 *
 * This example demonstrates how to use the AXI Video DMA with other video IPs
 * to do video frame transfers. This example does not work by itself. It needs
 * two other Video IPs, one for writing video frames to the memory and one for
 * reading video frames from the memory.
 *
 * To see the debug print, you need a Uart16550 or uartlite in your system,
 * and please set "-DDEBUG" in your compiler options. You need to rebuild your
 * software executable.
 *
 * @note
 * The values of DDR_BASE_ADDR and DDR_HIGH_ADDR should be as per the HW system.
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 1.00a jz   07/26/10 First release
 * 1.01a jz   09/26/10 Updated callback function signature
 * 2.00a jz   12/10/10 Added support for direct register access mode, v3 core
 * 2.01a rvp  01/22/11 Renamed the example file to be consistent
 * 		       Added support to the example to use SCU GIC interrupt
 *		       controller for ARM, some functions in this example have
 *		       changed.
 *       rkv  03/28/11 Updated to support for frame store register.
 * 3.00a srt  08/26/11 Added support for Flush on Frame Sync Feature.
 * 4.00a srt  03/06/12 Modified interrupt support for Zynq.
 * 4.02a srt  09/25/12 Fixed CR 677704
 *		       Description - Arguments misused in function
 *                     XAxiVdma_IntrEnable().
 * 4.03a srt  03/01/13 Updated DDR base address for IPI designs (CR 703656).
 * </pre>
 *
 * ***************************************************************************
 */

#include "platform.h"
#include "xaxivdma.h"
#include "xparameters.h"
#include "xil_exception.h"

#include "xintc.h"

#ifndef __MICROBLAZE__
#include "xpseudo_asm_gcc.h"
#include "xreg_cortexa9.h"
#endif

/******************** Constant Definitions **********************************/

/*
 * Device related constants. These need to defined as per the HW system.
 */
#define DMA_DEVICE_ID		XPAR_AXIVDMA_0_DEVICE_ID

#define INTC_DEVICE_ID		XPAR_INTC_0_DEVICE_ID
#define WRITE_INTR_ID		XPAR_INTC_0_AXIVDMA_0_S2MM_INTROUT_VEC_ID
#define READ_INTR_ID		XPAR_INTC_0_AXIVDMA_0_MM2S_INTROUT_VEC_ID

#ifdef XPAR_V6DDR_0_S_AXI_BASEADDR
#define DDR_BASE_ADDR		XPAR_V6DDR_0_S_AXI_BASEADDR
#define DDR_HIGH_ADDR		XPAR_V6DDR_0_S_AXI_HIGHADDR
#elif XPAR_S6DDR_0_S0_AXI_BASEADDR
#define DDR_BASE_ADDR		XPAR_S6DDR_0_S0_AXI_BASEADDR
#define DDR_HIGH_ADDR		XPAR_S6DDR_0_S0_AXI_HIGHADDR
#elif XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#define DDR_BASE_ADDR		XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#define DDR_HIGH_ADDR		XPAR_AXI_7SDDR_0_S_AXI_HIGHADDR
#elif XPAR_MIG7SERIES_0_BASEADDR
#define DDR_BASE_ADDR		XPAR_MIG7SERIES_0_BASEADDR
#define DDR_HIGH_ADDR	 	XPAR_MIG7SERIES_0_HIGHADDR
#else
#warning CHECK FOR THE VALID DDR ADDRESS IN XPARAMETERS.H, \
			DEFAULT SET TO 0x01000000
#define DDR_BASE_ADDR		0x01000000
#define DDR_HIGH_ADDR		0x0F000000
#endif

/* Memory space for the frame buffers
 *
 * This example only needs one set of frame buffers, because one video IP is
 * to write to the frame buffers, and the other video IP is to read from the
 * frame buffers.
 *
 * For 16 frames of 1080p, it needs 0x07E90000 memory for frame buffers
 */
#define MEM_BASE_ADDR		(DDR_BASE_ADDR + 0x01000000)
#define MEM_HIGH_ADDR		DDR_HIGH_ADDR
#define MEM_SPACE		(MEM_HIGH_ADDR - MEM_BASE_ADDR)

/* Read channel and write channel start from the same place
 *
 * One video IP write to the memory region, the other video IP read from it
 */
#define READ_ADDRESS_BASE	MEM_BASE_ADDR
#define WRITE_ADDRESS_BASE	MEM_BASE_ADDR

/* Frame size related constants
 */
#define FRAME_HORIZONTAL_LEN  0x1E00   /* 1920 pixels, each pixel 4 bytes */
#define FRAME_VERTICAL_LEN    0x438    /* 1080 pixels */

/* Subframe to be transferred by Video DMA
 *
 *|<----------------- FRAME_HORIZONTAL_LEN ---------------------->|
 * --------------------------------------------------------------------
 *|                                                                | ^
 *|                                                                | |
 *|               |<-SUBFRAME_HORIZONTAL_SIZE ->|                  | FRAME_
 *|               -----------------------------------              | VERTICAL_
 *|               |/////////////////////////////|  ^               | LEN
 *|               |/////////////////////////////|  |               | |
 *|               |/////////////////////////////|  |               | |
 *|               |/////////////////////////////| SUBFRAME_        | |
 *|               |/////////////////////////////| VERTICAL_        | |
 *|               |/////////////////////////////| SIZE             | |
 *|               |/////////////////////////////|  |               | |
 *|               |/////////////////////////////|  v               | |
 *|                ----------------------------------              | |
 *|                                                                | v
 *--------------------------------------------------------------------
 *
 * Note that SUBFRAME_HORIZONTAL_SIZE and SUBFRAME_VERTICAL_SIZE must ensure
 * to be inside the frame.
 */
#define SUBFRAME_START_OFFSET    (FRAME_HORIZONTAL_LEN * 5 + 32)
#define SUBFRAME_HORIZONTAL_SIZE 100
#define SUBFRAME_VERTICAL_SIZE   100

/* Number of frames to work on, this is to set the frame count threshold
 *
 * We multiply 15 to the num stores is to increase the intervals between
 * interrupts. If you are using fsync, then it is not necessary.
 */
#define NUMBER_OF_READ_FRAMES	8
#define NUMBER_OF_WRITE_FRAMES	8

/* Number of frames to transfer
 *
 * This is used to monitor the progress of the test, test purpose only
 */
#define NUM_TEST_FRAME_SETS	10

/* Delay timer counter
 *
 * WARNING: If you are using fsync, please increase the delay counter value
 * to be 255. Because with fsync, the inter-frame delay is long. If you do not
 * care about inactivity of the hardware, set this counter to be 0, which
 * disables delay interrupt.
 */
#define DELAY_TIMER_COUNTER	10

/*
 * Device instance definitions
 */
XAxiVdma AxiVdma;

static XIntc Intc;	/* Instance of the Interrupt Controller */

/* Data address
 *
 * Read and write sub-frame use the same settings
 */
static u32 ReadFrameAddr;
static u32 WriteFrameAddr;
static u32 BlockStartOffset;
static u32 BlockHoriz;
static u32 BlockVert;

/* DMA channel setup
 */
static XAxiVdma_DmaSetup ReadCfg;
static XAxiVdma_DmaSetup WriteCfg;

/* Transfer statics
 */
static int ReadDone;
static int ReadError;
static int WriteDone;
static int WriteError;

/******************* Function Prototypes ************************************/



static int SetupIntrSystem();

static void EnableIntrSystem();
static void DisableIntrSystem();

/* Interrupt call back functions
 */
static void ReadCallBack(void *CallbackRef, u32 Mask);
static void ReadErrorCallBack(void *CallbackRef, u32 Mask);
static void WriteCallBack(void *CallbackRef, u32 Mask);
static void WriteErrorCallBack(void *CallbackRef, u32 Mask);


/*****************************************************************************/
/**
*
* Main function
*
* This function is the main entry point of the example on DMA core. It sets up
* DMA engine to be ready to receive and send frames, and start the transfers.
* It waits for the transfer of the specified number of frame sets, and check
* for transfer errors.
*
* @return
*		- XST_SUCCESS if example finishes successfully
*		- XST_FAILURE if example fails.
*
* @note		None.
*
******************************************************************************/
int main(void)
{
	int Status;
	XAxiVdma_Config *Config;
	XAxiVdma_FrameCounter FrameCfg;

	init_platform();

	WriteDone = 0;
	ReadDone = iu 0;
	WriteError = 0;
	ReadError = 0;

	ReadFrameAddr = READ_ADDRESS_BASE;
	WriteFrameAddr = WRITE_ADDRESS_BASE;
	BlockStartOffset = SUBFRAME_START_OFFSET;
	BlockHoriz = SUBFRAME_HORIZONTAL_SIZE;
	BlockVert = SUBFRAME_VERTICAL_SIZE;

	xil_printf("\r\n--- Entering main() --- \r\n");

	/* The information of the XAxiVdma_Config comes from hardware build.
	 * The user IP should pass this information to the AXI DMA core.
	 */
	Config = XAxiVdma_LookupConfig(DMA_DEVICE_ID);
	if (!Config) {
		xil_printf(
		    "No video DMA found for ID %d\r\n", DMA_DEVICE_ID);

		return XST_FAILURE;
	}

	/* Initialize DMA engine */
	Status = XAxiVdma_CfgInitialize(&AxiVdma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Configuration Initialization failed %d\r\n", Status);

		return XST_FAILURE;
	}

	Status = XAxiVdma_SetFrmStore(&AxiVdma, NUMBER_OF_READ_FRAMES,
							XAXIVDMA_READ);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Setting Frame Store Number Failed in Read Channel"
		    					" %d\r\n", Status);

		return XST_FAILURE;
	}

	Status = XAxiVdma_SetFrmStore(&AxiVdma, NUMBER_OF_WRITE_FRAMES,
							XAXIVDMA_WRITE);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Setting Frame Store Number Failed in Write Channel"
		    					" %d\r\n", Status);

		return XST_FAILURE;
	}

	/* Setup frame counter and delay counter for both channels
	 *
	 * This is to monitor the progress of the test only
	 *
	 * WARNING: In free-run mode, interrupts may overwhelm the system.
	 * In that case, it is better to disable interrupts.
	 */
	FrameCfg.ReadFrameCount = NUMBER_OF_READ_FRAMES;
	FrameCfg.WriteFrameCount = NUMBER_OF_WRITE_FRAMES;
	FrameCfg.ReadDelayTimerCount = DELAY_TIMER_COUNTER;
	FrameCfg.WriteDelayTimerCount = DELAY_TIMER_COUNTER;

	Status = XAxiVdma_SetFrameCounter(&AxiVdma, &FrameCfg);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    	"Set frame counter failed %d\r\n", Status);

		if(Status == XST_VDMA_MISMATCH_ERROR)
			xil_printf("DMA Mismatch Error\r\n");

		return XST_FAILURE;
	}

	/*
	 * Setup your video IP that writes to the memory
	 */


	/* Setup the write channel
	 */
	Status = WriteSetup(&AxiVdma);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    	"Write channel setup failed %d\r\n", Status);
		if(Status == XST_VDMA_MISMATCH_ERROR)
			xil_printf("DMA Mismatch Error\r\n");

		return XST_FAILURE;
	}


	/*
	 * Setup your video IP that reads from the memory
	 */

	/* Setup the read channel
	 */
	Status = ReadSetup(&AxiVdma);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    	"Read channel setup failed %d\r\n", Status);
		if(Status == XST_VDMA_MISMATCH_ERROR)
			xil_printf("DMA Mismatch Error\r\n");

		return XST_FAILURE;
	}

	Status = SetupIntrSystem(&AxiVdma, READ_INTR_ID, WRITE_INTR_ID);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Setup interrupt system failed %d\r\n", Status);

		return XST_FAILURE;
	}

	/* Register callback functions
	 */
	XAxiVdma_SetCallBack(&AxiVdma, XAXIVDMA_HANDLER_GENERAL, ReadCallBack,
	    (void *)&AxiVdma, XAXIVDMA_READ);

	XAxiVdma_SetCallBack(&AxiVdma, XAXIVDMA_HANDLER_ERROR,
	    ReadErrorCallBack, (void *)&AxiVdma, XAXIVDMA_READ);

	XAxiVdma_SetCallBack(&AxiVdma, XAXIVDMA_HANDLER_GENERAL,
	    WriteCallBack, (void *)&AxiVdma, XAXIVDMA_WRITE);

	XAxiVdma_SetCallBack(&AxiVdma, XAXIVDMA_HANDLER_ERROR,
	    WriteErrorCallBack, (void *)&AxiVdma, XAXIVDMA_WRITE);

	/* Enable your video IP interrupts if needed
	 */

	/* Start the DMA engine to transfer
	 */
	Status = StartTransfer(&AxiVdma);
	if (Status != XST_SUCCESS) {
		if(Status == XST_VDMA_MISMATCH_ERROR)
			xil_printf("DMA Mismatch Error\r\n");
		return XST_FAILURE;
	}

	/* Enable DMA read and write channel interrupts
	 *
	 * If interrupts overwhelms the system, please do not enable interrupt
	 */
	XAxiVdma_IntrEnable(&AxiVdma, XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_WRITE);
	XAxiVdma_IntrEnable(&AxiVdma, XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_READ);

	/* Every set of frame buffer finish causes a completion interrupt
	 */
	while ((WriteDone < NUM_TEST_FRAME_SETS) && !ReadError &&
	      (ReadDone < NUM_TEST_FRAME_SETS) && !WriteError) {
 		/* NOP */
	}

	if (ReadError || WriteError) {
		xil_printf("Test has transfer error %d/%d\r\n",
		    ReadError, WriteError);

		Status = XST_FAILURE;
	}
	else {
		xil_printf("Test passed\r\n");
	}

	xil_printf("--- Exiting main() --- \r\n");

	DisableIntrSystem(READ_INTR_ID, WRITE_INTR_ID);

	if (Status != XST_SUCCESS) {
		if(Status == XST_VDMA_MISMATCH_ERROR)
			xil_printf("DMA Mismatch Error\r\n");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}


/*****************************************************************************/
/*
*
* This function setups the interrupt system so interrupts can occur for the
* DMA.  This function assumes INTC component exists in the hardware system.
*
* @param	AxiDmaPtr is a pointer to the instance of the DMA engine
* @param	ReadIntrId is the read channel Interrupt ID.
* @param	WriteIntrId is the write channel Interrupt ID.
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None.
*
******************************************************************************/
static int SetupIntrSystem()
{
	int Status;

	XIntc *IntcInstancePtr =&Intc;


	/* Initialize the interrupt controller and connect the ISRs */
	Status = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS) {

		xil_printf( "Failed init intc\r\n");
		return XST_FAILURE;
	}
}

/*****************************************************************************/
/**
*
* This function disables the interrupts
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void StartIntrSystem()
{
	XIntc *IntcInstancePtr =&Intc;

	/* Start the interrupt controller */
	Status = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Status != XST_SUCCESS) {

		xil_printf( "Failed to start intc\r\n");
		return XST_FAILURE;
	}

	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			(Xil_ExceptionHandler)XIntc_InterruptHandler,
			(void *)IntcInstancePtr);

	Xil_ExceptionEnable();

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function disables the interrupts
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void DisableIntrSystem()
{

	XIntc *IntcInstancePtr =&Intc;
}

/*****************************************************************************/
/*
 * Call back function for read channel
 *
 * This callback only clears the interrupts and updates the transfer status.
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
*
******************************************************************************/
static void ReadCallBack(void *CallbackRef, u32 Mask)
{

	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK) {
		ReadDone += 1;
	}
}

/*****************************************************************************/
/*
 * Call back function for read channel error interrupt
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
*
******************************************************************************/
static void ReadErrorCallBack(void *CallbackRef, u32 Mask)
{

	if (Mask & XAXIVDMA_IXR_ERROR_MASK) {
		ReadError += 1;
	}
}

/*****************************************************************************/
/*
 * Call back function for write channel
 *
 * This callback only clears the interrupts and updates the transfer status.
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
*
******************************************************************************/
static void WriteCallBack(void *CallbackRef, u32 Mask)
{

	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK) {
		WriteDone += 1;
	}
}

/*****************************************************************************/
/*
* Call back function for write channel error interrupt
*
* @param	CallbackRef is the call back reference pointer
* @param	Mask is the interrupt mask passed in from the driver
*
* @return	None
*
******************************************************************************/
static void WriteErrorCallBack(void *CallbackRef, u32 Mask)
{

	if (Mask & XAXIVDMA_IXR_ERROR_MASK) {
		WriteError += 1;
	}
}


