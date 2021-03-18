/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

/***************************** Include Files ********************************/

#include "xuartext.h"
#include "xuartext_i.h"
#include "xil_io.h"

/************************** Constant Definitions ****************************/


/**************************** Type Definitions ******************************/


/***************** Macros (Inline Functions) Definitions ********************/


/************************** Variable Definitions ****************************/
/************************** Function Prototypes *****************************/

static void StubDataHandler(void *CallBackRef, unsigned int ByteCount);
static void StubCommandHandler(void *CallBackRef, const char* Command, const char* Data);

/****************************************************************************/
/**
*
* Initialize a XUartExt instance. The receive and transmit FIFOs of the
* UART are not flushed, so the user may want to flush them. The hardware
* device does not have any way to disable the receiver such that any valid
* data may be present in the receive FIFO.  This function disables the UART
* interrupt. The baudrate and format of the data are fixed in the hardware
* at hardware build time.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	Config is a reference to a structure containing information
*		about a specific UART Lite device. This function initializes an
*		InstancePtr object for a specific device specified by the
*		contents of Config. This function can initialize multiple
*		instance objects with the use of multiple calls giving different
*		Config information on each call.
* @param 	EffectiveAddr is the device base address in the virtual memory
*		address space. The caller is responsible for keeping the address
*		mapping from EffectiveAddr to the device physical base address
*		unchanged once this function is invoked. Unexpected errors may
*		occur if the address mapping changes after this function is
*		called. If address translation is not used, use
*		Config->BaseAddress for this parameters, passing the physical
*		address instead.
*
* @return
* 		- XST_SUCCESS if everything starts up as expected.
*
* @note		The Config pointer argument is not used by this function,
*		but is provided to keep the function signature consistent
*		with other drivers.
*
*****************************************************************************/
int XUartExt_CfgInitialize(XUartExt *InstancePtr, XUartExt_Config *Config,
				u32 EffectiveAddr)
{
	/*
	 * Assert validates the input arguments
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);


	InstancePtr->RecvHandler = StubDataHandler;
	InstancePtr->SendHandler = StubDataHandler;
	InstancePtr->CommandHandler = StubCommandHandler;

	XUartLite_CfgInitialize(InstancePtr->UartLite, Config->UartLite, EffectiveAddr);

	return XST_SUCCESS;
}

/****************************************************************************/
/**
*
* This functions sends the specified buffer of data using the UART in either
* polled or interrupt driven modes. This function is non-blocking such that it
* will return before the data has been sent by the UART. If the UART is busy
* sending data, it will return and indicate zero bytes were sent.
*
* In a polled mode, this function will only send as much data as the UART can
* buffer in the FIFO. The application may need to call it repeatedly to
* send a buffer.
*
* In interrupt mode, this function will start sending the specified buffer and
* then the interrupt handler of the driver will continue sending data until the
* buffer has been sent. A callback function, as specified by the application,
* will be called to indicate the completion of sending the buffer.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	DataBufferPtr is pointer to a buffer of data to be sent.
* @param	NumBytes contains the number of bytes to be sent. A value of
*		zero will stop a previous send operation that is in progress
*		in interrupt mode. Any data that was already put into the
*		transmit FIFO will be sent.
*
* @return	The number of bytes actually sent.
*
* @note		The number of bytes is not asserted so that this function may
*		be called with a value of zero to stop an operation that is
*		already in progress.
*
******************************************************************************/
unsigned int XUartExt_Send(XUartExt *InstancePtr, u8 *DataBufferPtr,
				unsigned int NumBytes)
{
	Xil_AssertNonvoid(InstancePtr != NULL);

	return XUartLite_Send(InstancePtr->UartLite, DataBufferPtr, NumBytes);
}


/****************************************************************************/
/**
*
* This function will attempt to receive a specified number of bytes of data
* from the UART and store it into the specified buffer. This function is
* designed for either polled or interrupt driven modes. It is non-blocking
* such that it will return if no data has already received by the UART.
*
* In a polled mode, this function will only receive as much data as the UART
* can buffer in the FIFO. The application may need to call it repeatedly to
* receive a buffer. Polled mode is the default mode of operation for the driver.
*
* In interrupt mode, this function will start receiving and then the interrupt
* handler of the driver will continue receiving data until the buffer has been
* received. A callback function, as specified by the application, will be called
* to indicate the completion of receiving the buffer or when any receive errors
* or timeouts occur.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	DataBufferPtr is pointer to buffer for data to be received into.
* @param	NumBytes is the number of bytes to be received. A value of zero
*		will stop a previous receive operation that is in progress in
*		interrupt mode.
*
* @return	The number of bytes received.
*
* @note 	The number of bytes is not asserted so that this function
*		may be called with a value of zero to stop an operation
*		that is already in progress.
*
*****************************************************************************/
unsigned int XUartExt_Recv(XUartExt *InstancePtr, u8 *DataBufferPtr,
				unsigned int NumBytes)
{
	/*
	 * Assert validates the input arguments
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);

	return XUartLite_Recv(InstancePtr->UartLite, DataBufferPtr, NumBytes);
}

/****************************************************************************/
/**
*
* This function resets the FIFOs, both transmit and receive, of the UART such
* that they are emptied.  Since the UART does not have any way to disable it
* from receiving data, it may be necessary for the application to reset the
* FIFOs to get rid of any unwanted data.
*
* @param	InstancePtr is a pointer to the XUartExt instance .
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XUartExt_ResetFifos(XUartExt *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	return XUartLite_ResetFifos(InstancePtr->UartLite);
}

/****************************************************************************/
/**
*
* This function determines if the specified UART is sending data. If the
* transmitter register is not empty, it is sending data.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
*
* @return	A value of TRUE if the UART is sending data, otherwise FALSE.
*
* @note		None.
*
*****************************************************************************/
int XUartExt_IsSending(XUartExt *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	return XUartLite_IsSending(InstancePtr->UartLite);
}


/****************************************************************************
*
* This function provides a stub handler such that if the application does not
* define a handler but enables interrupts, this function will be called.
*
* @param	CallBackRef has no purpose but is necessary to match the
*		interface for a handler.
* @param	ByteCount has no purpose but is necessary to match the
*		interface for a handler.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
static void StubHandler(void *CallBackRef, unsigned int ByteCount)
{
	(void) CallBackRef;
	(void) ByteCount;
	/*
	 * Assert occurs always since this is a stub and should never be called
	 */
	Xil_AssertVoidAlways();
}

/****************************************************************************
*
* This function provides a stub handler such that if the application does not
* define a handler but enables interrupts, this function will be called.
*
* @param	CallBackRef has no purpose but is necessary to match the
*		interface for a handler.
* @param	ByteCount has no purpose but is necessary to match the
*		interface for a handler.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
static void StubCommandHandler(void *CallBackRef, const char* Command, const char* Data)
{
	(void) CallBackRef;
	(void) Command;
	(void) Data;
	/*
	 * Assert occurs always since this is a stub and should never be called
	 */
	Xil_AssertVoidAlways();
}




