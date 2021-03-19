/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

#ifndef XUARTEXT_H /* prevent circular inclusions */
#define XUARTEXT_H /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files ********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"

#include "xuartlite.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/**
 * Callback function for data transmission.  The first argument is a callback reference passed in by
 * the upper layer when setting the callback functions, and passed back to the
 * upper layer when the callback is invoked.
 * The second argument is the ByteCount which is the number of bytes that
 * actually moved from/to the buffer provided in the _Send/_Receive call.
 */
typedef void (*XUartExt_DataHandler)(void *CallBackRef, unsigned int ByteCount);

/**
 * Callback function for AT command.  The first argument is a callback reference passed in by
 * the upper layer when setting the callback functions, and passed back to the
 * upper layer when the callback is invoked.
 * The second argument is the the command proceding the AT command, the third argument is the data
 * associated with theat command.
 */
typedef void (*XUartExt_CommandHandler)(void *CallBackRef, unsigned int CommandCount);

/**
 * Statistics for the XUartExt driver
 */
typedef struct {
	XUartLite_Stats Uart;
} XUartExt_Stats;

/**
 * The following data type is used to manage the buffers that are handled
 * when sending and receiving data in the interrupt mode. It is intended
 * for internal use only.
 */
typedef struct {
	u8 *NextBytePtr;
	unsigned int RequestedBytes;
	unsigned int RemainingBytes;
} XUartExt_Buffer;

/**
 * This typedef contains configuration information for the device.
 */
typedef struct {
	XUartLite_Config Uart;
} XUartExt_Config;

/**
 * The XUartExt driver instance data. The user is required to allocate a
 * variable of this type for every UART Lite device in the system. A pointer
 * to a variable of this type is then passed to the driver API functions.
 */
typedef struct {
	XUartLite Uart;

	XUartExt_Buffer SendBuffer;
	XUartExt_Buffer ReceiveBuffer;

	XUartExt_DataHandler RecvHandler;
	void* RecvCallBackRef;
	XUartExt_DataHandler SendHandler;
	void* SendCallBackRef;
	XUartExt_CommandHandler CommandHandler;
	void* CommandCallBackRef;
} XUartExt;


/***************** Macros (Inline Functions) Definitions ********************/


/************************** Function Prototypes *****************************/

/*
 * Initialization functions in xuartext_sinit.c
 */
int XUartExt_Initialize(XUartExt *InstancePtr, u16 DeviceId);
XUartExt_Config *XUartExt_LookupConfig(u16 DeviceId);

/*
 * Required functions, in file xuart.c
 */
int XUartExt_CfgInitialize(XUartExt *InstancePtr,
				XUartExt_Config *Config,
				u32 EffectiveAddr);

void XUartExt_ResetFifos(XUartExt *InstancePtr);

unsigned int XUartExt_Send(XUartExt *InstancePtr, u8 *DataBufferPtr,
				unsigned int NumBytes);
unsigned int XUartExt_Recv(XUartExt *InstancePtr, u8 *DataBufferPtr,
				unsigned int NumBytes);

int XUartExt_IsSending(XUartExt *InstancePtr);

/*
 * Functions for statistics, in file xuartext_stats.c
 */
void XUartExt_GetStats(XUartExt *InstancePtr, XUartExt_Stats *StatsPtr);
void XUartExt_ClearStats(XUartExt *InstancePtr);

/*
 * Functions for self-test, in file xuartext_selftest.c
 */
int XUartExt_SelfTest(XUartExt *InstancePtr);

/*
 * Functions for interrupts, in file xuartext_intr.c
 */
void XUartExt_EnableInterrupt(XUartExt *InstancePtr);
void XUartExt_DisableInterrupt(XUartExt *InstancePtr);

void XUartExt_SetRecvHandler(XUartExt *InstancePtr, XUartExt_DataHandler FuncPtr,
				void *CallBackRef);
void XUartExt_SetSendHandler(XUartExt *InstancePtr, XUartExt_DataHandler FuncPtr,
				void *CallBackRef);
void XUartExt_SetCommandHandler(XUartExt *InstancePtr, XUartExt_CommandHandler FuncPtr,
				void *CallBackRef);

void XUartExt_InterruptHandler(XUartExt *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif			/* end of protection macro */

