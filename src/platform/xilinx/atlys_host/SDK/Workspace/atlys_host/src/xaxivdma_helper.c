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

#include "xaxivdma_helper.h"
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

/*
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
*/

/* Memory space for the frame buffers
 *
 * This example only needs one set of frame buffers, because one video IP is
 * to write to the frame buffers, and the other video IP is to read from the
 * frame buffers.
 *
 * For 16 frames of 1080p, it needs 0x07E90000 memory for frame buffers
 */
//#define MEM_BASE_ADDR		(DDR_BASE_ADDR + 0x01000000)
//#define MEM_HIGH_ADDR		DDR_HIGH_ADDR
//#define MEM_SPACE		(MEM_HIGH_ADDR - MEM_BASE_ADDR)

/* Read channel and write channel start from the same place
 *
 * One video IP write to the memory region, the other video IP read from it
 */
//#define READ_ADDRESS_BASE	MEM_BASE_ADDR
//#define WRITE_ADDRESS_BASE	MEM_BASE_ADDR

/* Frame size related constants
 */
//#define FRAME_HORIZONTAL_LEN  0x1E00   /* 1920 pixels, each pixel 4 bytes */
//#define FRAME_VERTICAL_LEN    0x438    /* 1080 pixels */

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
//#define SUBFRAME_START_OFFSET    (FRAME_HORIZONTAL_LEN * 5 + 32)
//#define SUBFRAME_HORIZONTAL_SIZE 100
//#define SUBFRAME_VERTICAL_SIZE   100

/* Number of frames to work on, this is to set the frame count threshold
 *
 * We multiply 15 to the num stores is to increase the intervals between
 * interrupts. If you are using fsync, then it is not necessary.
 */
//#define NUMBER_OF_READ_FRAMES	8
//#define NUMBER_OF_WRITE_FRAMES	8

/* Number of frames to transfer
 *
 * This is used to monitor the progress of the test, test purpose only
 */
//#define NUM_TEST_FRAME_SETS	10

/* Delay timer counter
 *
 * WARNING: If you are using fsync, please increase the delay counter value
 * to be 255. Because with fsync, the inter-frame delay is long. If you do not
 * care about inactivity of the hardware, set this counter to be 0, which
 * disables delay interrupt.
 */
//#define DELAY_TIMER_COUNTER	10

/*
 * Device instance definitions
 */
//XAxiVdma AxiVdma;

//static XIntc Intc;	/* Instance of the Interrupt Controller */

/* Data address
 *
 * Read and write sub-frame use the same settings
 */
//static u32 ReadFrameAddr;
//static u32 WriteFrameAddr;
//static u32 BlockStartOffset;
//static u32 BlockHoriz;
//static u32 BlockVert;

/* DMA channel setup
 */
//static XAxiVdma_DmaSetup ReadCfg;
//static XAxiVdma_DmaSetup WriteCfg;

/* Transfer statics
 */
//static int ReadDone;
//static int ReadError;
//static int WriteDone;
//static int WriteError;

/******************* Function Prototypes ************************************/

/*****************************************************************************/
/**
*
* This function sets up the channel
*
* @param	InstancePtr is the instance pointer to the DMA engine.
*
* @return	XST_SUCCESS if the setup is successful, XST_FAILURE otherwise.
*
* @note		None.
*
******************************************************************************/
static int XAxiVdmaHelper_Initialize(VdmaChannel *channel)
{
	int Index;
	u32 Addr;
	int Status;

	XAxiVdma_DmaSetup& cfg = channel.Cfg;

	Status = XAxiVdma_DmaConfig(channel->device->InstancePtr, channel->Direction, cfg);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Channel config failed %d\r\n", Status);

		return XST_FAILURE;
	}

	/* Initialize buffer addresses
	 *
	 * These addresses are physical addresses
	 */
	Addr = channel->AddressBase + BlockStartOffset;
	for(Index = 0; Index < channel->NumberOfFrames; Index++) {
		ReadCfg.FrameStoreStartAddr[Index] = Addr;

		Addr += channel->VerticalStride * cfg.Stride;
	}

	/* Set the buffer addresses for transfer in the DMA engine
	 * The buffer addresses are physical addresses
	 */
	Status = XAxiVdma_DmaSetBufferAddr(channel->device->InstancePtr, channel->Direction,
			ReadCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Channel set buffer address failed %d\r\n", Status);

		return XST_FAILURE;
	}

	if (channel->Direction == XAXIVDMA_WRITE)
	{
		/* Clear data buffer
		 */
		memset((void *)WriteFrameAddr, 0,
				channel->NumberOfFrames * channel->VerticalStride * cfg.Stride);

	}

	return XST_SUCCESS;
}

int XAxiVdmaHelper_SetupDevice(u16 DeviceId, VdmaDevice* device)
{
	XAxiVdma_Config *Config;

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
	Status = XAxiVdma_CfgInitialize(&device->InstancePtr, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {

		xil_printf(
			"Configuration Initialization failed %d\r\n", Status);

		return XST_FAILURE;
	}
}

static int XAxiVdmaHelper_SetFrmStore(VdmaChannel* channel)
{
	Status = XAxiVdma_SetFrmStore(&AxiVdma, channel->NumberOfFrames,
							channel->Direction);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Setting Frame Store Number Failed in Read Channel"
		    					" %d\r\n", Status);

		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

static int XAxiVdmaHelper_SetFrameCounter(VdmaChannel* channel)
{
	int Status;
	XAxiVdma_Channel *Channel;
	XAxiVdma& InstancePtr = channel->Device->InstancePtr;

	/* Validate parameters */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XAXIVDMA_DEVICE_READY);

	if (channel->NumberOfFrames == 0) {

		return XST_INVALID_PARAM;
	}

	Channel = XAxiVdma_GetChannel(InstancePtr, channel->Direction);

	if (Channel->IsValid) {

		Status = XAxiVdma_ChannelSetFrmCnt(Channel, channel->NumberOfFrames,
				channel->DelayTimerCount);
		if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,
				"Setting channel frame counter "
				"failed with %d\r\n", Status);

			return Status;
		}
	}
}

int XAxiVdmaHelper_SetupChannel(VdmaDevice* device, u16 direction, u32 baseAddress, int numberOfFrames, Frame* frame, u16 intrId, VdmaChannel* channel)
{
	XAxiVdma_DmaSetup& cfg = channel.Cfg;

	cfg.VertSizeInput = frame.Height;
	cfg.HoriSizeInput = frame.Width;

	cfg.Stride = frame.HorizontalStride;
	cfg.FrameDelay = 0;  /* This example does not test frame delay */

	cfg.EnableCircularBuf = 1;
	cfg.EnableSync = 0;  /* No Gen-Lock */

	cfg.PointNum = 0;    /* No Gen-Lock */
	cfg.EnableFrameCounter = 0; /* Endless transfers */

	cfg.FixedFrameStoreAddr = 0; /* We are not doing parking */

	channel.DevicePtr = device;
	channel.VerticalStride = frame->VerticalStride;
	channel.Direction = direction;
	channel.AddressBase = baseAddress;
	channel.IntrId = intrId;

	Status = XAxiVdmaHelper_SetFrmStore(channel);
	if (Status != XST_SUCCESS) {

		xil_printf(
			"Configuration Initialization failed %d\r\n", Status);

		return XST_FAILURE;
	}

	Status = XAxiVdmaHelper_SetFrameCounter(channel);
	if (Status != XST_SUCCESS) {

		xil_printf(
			"Configuration Initialization failed %d\r\n", Status);

		return XST_FAILURE;
	}

	return XAxiVdmaHelper_Initialize(channel);
}

 int XAxiVdmaHelper_SetupReadChannel(VdmaDevice* device, u16 direction, u32 baseAddress, int numberOfFrames, Frame* frame, u16 intrId, VdmaChannel* channel)
 {
	 return XAxiVdmaHelper_CreateChannel(device, XAXIVDMA_READ, baseAddress, numberOfFrames, frame, intrId, channel);
 }

 /*****************************************************************************/
 /**
 *
 * This function creates a channel structure
 *
 * @param	InstancePtr is the instance pointer to the DMA engine.
 *
 * @return	XST_SUCCESS if the setup is successful, XST_FAILURE otherwise.
 *
 * @note		None.
 *
 ******************************************************************************/
 int XAxiVdmaHelper_SetupWriteChannel(VdmaDevice* device, u16 direction, u32 baseAddress, int numberOfFrames, Frame* frame, u16 intrId, VdmaChannel* channel)
 {
	 return XAxiVdmaHelper_CreateChannel(device, XAXIVDMA_WRITE, baseAddress, numberOfFrames, frame, intrId, channel);
 }


#ifdef 0
/*****************************************************************************/
/**
*
* This function sets up the read channel
*
* @param	InstancePtr is the instance pointer to the DMA engine.
*
* @return	XST_SUCCESS if the setup is successful, XST_FAILURE otherwise.
*
* @note		None.
*
******************************************************************************/
static int XAxiVdmaHelper_ReadSetup(VdmaChannel *channel)
{
	int Index;
	u32 Addr;
	int Status;
	XAxiVdma_DmaSetup ReadCfg;

	ReadCfg.VertSizeInput = channel->Frame.Height;
	ReadCfg.HoriSizeInput = channel->Frame.Width;

	ReadCfg.Stride = channel->Frame.HorizontalStride;
	ReadCfg.FrameDelay = 0;  /* This example does not test frame delay */

	ReadCfg.EnableCircularBuf = 1;
	ReadCfg.EnableSync = 0;  /* No Gen-Lock */

	ReadCfg.PointNum = 0;    /* No Gen-Lock */
	ReadCfg.EnableFrameCounter = 0; /* Endless transfers */

	ReadCfg.FixedFrameStoreAddr = 0; /* We are not doing parking */

	Status = XAxiVdma_DmaConfig(channel->device->InstancePtr, XAXIVDMA_READ, &ReadCfg);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Read channel config failed %d\r\n", Status);

		return XST_FAILURE;
	}

	/* Initialize buffer addresses
	 *
	 * These addresses are physical addresses
	 */
	Addr = channel->AddressBase + BlockStartOffset;
	for(Index = 0; Index < channel->NumberOfFrames; Index++) {
		ReadCfg.FrameStoreStartAddr[Index] = Addr;

		Addr += channel->Frame.VerticalStride * channel->Frame.HorizontalStride;
	}

	/* Set the buffer addresses for transfer in the DMA engine
	 * The buffer addresses are physical addresses
	 */
	Status = XAxiVdma_DmaSetBufferAddr(channel->device->InstancePtr, XAXIVDMA_READ,
			ReadCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Read channel set buffer address failed %d\r\n", Status);

		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function sets up the write channel
*
* @param	InstancePtr is the instance pointer to the DMA engine.
*
* @return	XST_SUCCESS if the setup is successful, XST_FAILURE otherwise.
*
* @note		None.
*
******************************************************************************/
static int XAxiVdmaHelper_WriteSetup(VdmaChannel *channel)
{
	int Index;
	u32 Addr;
	int Status;
	XAxiVdma_DmaSetup WriteCfg;

	WriteCfg.VertSizeInput = channel->Frame.Height;
	WriteCfg.HoriSizeInput = channel->Frame.Width;

	WriteCfg.Stride = channel->Frame.HorizontalStride;
	WriteCfg.FrameDelay = 0;  /* This example does not test frame delay */

	WriteCfg.EnableCircularBuf = 1;
	WriteCfg.EnableSync = 0;  /* No Gen-Lock */

	WriteCfg.PointNum = 0;    /* No Gen-Lock */
	WriteCfg.EnableFrameCounter = 0; /* Endless transfers */

	WriteCfg.FixedFrameStoreAddr = 0; /* We are not doing parking */

	Status = XAxiVdma_DmaConfig(channel->device->InstancePtr, XAXIVDMA_WRITE, &WriteCfg);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Write channel config failed %d\r\n", Status);

		return XST_FAILURE;
	}

	/* Initialize buffer addresses
	 *
	 * Use physical addresses
	 */
	Addr = channel->AddressBase + BlockStartOffset;
	for(Index = 0; Index < channel->NumberOfFrames; Index++) {
		WriteCfg.FrameStoreStartAddr[Index] = Addr;

		Addr += channel->Frame.VerticalStride * channel->Frame.HorizontalStride;
	}

	/* Set the buffer addresses for transfer in the DMA engine
	 */
	Status = XAxiVdma_DmaSetBufferAddr(channel->device->InstancePtr, XAXIVDMA_WRITE,
	        WriteCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Write channel set buffer address failed %d\r\n", Status);

		return XST_FAILURE;
	}

	/* Clear data buffer
	 */
	memset((void *)WriteFrameAddr, 0,
			channel->NumberOfFrames * channel->Frame.VerticalStride * channel->Frame.HorizontalStride);

	return XST_SUCCESS;
}
#endif

/*****************************************************************************/
/**
*
* This function starts the DMA transfers. Since the DMA engine is operating
* in circular buffer mode, video frames will be transferred continuously.
*
* @param	InstancePtr points to the DMA engine instance
*
* @return	XST_SUCCESS if both read and write start succesfully
*		XST_FAILURE if one or both directions cannot be started
*
* @note		None.
*
******************************************************************************/
int XAxiVdmaHelper_StartTransfer(VdmaChannel *channel)
{
	int Status;

	Status = XAxiVdma_DmaStart(channel->device->InstancePtr, channel->Direction);
	if (Status != XST_SUCCESS) {
		xil_printf(
		    "Start transfer failed %d\r\n", Status);

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
int XAxiVdmaHelper_SetupInterrupts(XIntc *IntcInstancePtr, VdmaChannel *channel, XAxiVdma_CallBack completionHandler, XAxiVdma_ErrorCallBack errorHandler)
{
	int Status;

	Status = XIntc_Connect(IntcInstancePtr, channel->InterruptHandler.IntrId,
			channel->InterruptHandler.Handler, channel->device->InstancePtr);
	if (Status != XST_SUCCESS) {

		xil_printf(
		    "Failed read channel connect intc %d\r\n", Status);
		return XST_FAILURE;
	}

	/* Enable interrupts from the hardware */
	XIntc_Enable(IntcInstancePtr, channel->InterruptHandler.IntrId);

	/* Register callback functions
	*/
	XAxiVdma_SetCallBack(&AxiVdma, XAXIVDMA_HANDLER_GENERAL, completionHandler,
			    (void *)&channel, channel->Direction);

	XAxiVdma_SetCallBack(&AxiVdma, XAXIVDMA_HANDLER_ERROR,
			errorHandler, (void *)&channel, channel->Direction);


	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function disables the interrupts
*
* @param	ReadIntrId is interrupt ID associated w/ DMA read channel
* @param	WriteIntrId is interrupt ID associated w/ DMA write channel
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void XAxiVdmaHelper_EnableInterrupts(XIntc *IntcInstancePtr, VdmaChannel *channel)
{

	/* Connect the interrupts for the DMA channel */
	XIntc_Enable(IntcInstancePtr, channel->InterruptHandler.IntrId);

	XAxiVdma_IntrEnable(channel->device->InstancePtr, XAXIVDMA_IXR_ALL_MASK, channel->Direction);
}


/*****************************************************************************/
/**
*
* This function disables the interrupts
*
* @param	ReadIntrId is interrupt ID associated w/ DMA read channel
* @param	WriteIntrId is interrupt ID associated w/ DMA write channel
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void XAxiVdmaHelper_DisableInterrupts(XIntc *IntcInstancePtr, VdmaChannel *channel)
{
	XAxiVdma_IntrDisable(channel->device->InstancePtr, XAXIVDMA_IXR_ALL_MASK, channel->Direction);

	/* Disconnect the interrupts for the DMA channel */
	XIntc_Disconnect(IntcInstancePtr, channel->InterruptHandler.IntrId);
}


