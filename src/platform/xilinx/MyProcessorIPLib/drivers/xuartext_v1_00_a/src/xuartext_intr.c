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

/************************** Function Prototypes *****************************/

static void ReceiveDataHandler(void* CallBackRef, unsigned int ByteCount);
static void SendDataHandler(void* CallBackRef, unsigned int ByteCount);

/************************** Variable Definitions ****************************/

typedef void (*Handler)(XUartExt *InstancePtr);

/****************************************************************************/
/**
*
* This function sets the handler that will be called when an event (interrupt)
* occurs in the driver. The purpose of the handler is to allow application
* specific processing to be performed.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	FuncPtr is the pointer to the callback function.
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
*
* @return	None.
*
* @note		There is no assert on the CallBackRef since the driver doesn't
*		know what it is (nor should it)
*
*****************************************************************************/
void XUartExt_SetRecvHandler(XUartExt *InstancePtr,
				XUartExt_DataHandler FuncPtr, void *CallBackRef)
{
	/*
	 * Assert validates the input arguments
	 * CallBackRef not checked, no way to know what is valid
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(FuncPtr != NULL);
	Xil_AssertVoid(InstancePtr->Uart.IsReady == XIL_COMPONENT_IS_READY);

	InstancePtr->RecvHandler = FuncPtr;
	InstancePtr->RecvCallBackRef = CallBackRef;

	InstancePtr->Uart.RecvHandler = ReceiveDataHandler;
	InstancePtr->Uart.RecvCallBackRef = InstancePtr;
}

/****************************************************************************/
/**
*
* This function sets the handler that will be called when an event (interrupt)
* occurs in the driver. The purpose of the handler is to allow application
* specific processing to be performed.
*
* @param	InstancePtr is a pointer to the XUartExt instance .
* @param	FuncPtr is the pointer to the callback function.
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
*
* @return 	None.
*
* @note		There is no assert on the CallBackRef since the driver doesn't
*		know what it is (nor should it)
*
*****************************************************************************/
void XUartExt_SetSendHandler(XUartExt *InstancePtr,
				XUartExt_DataHandler FuncPtr, void *CallBackRef)
{
	/*
	 * Assert validates the input arguments
	 * CallBackRef not checked, no way to know what is valid
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(FuncPtr != NULL);
	Xil_AssertVoid(InstancePtr->Uart.IsReady == XIL_COMPONENT_IS_READY);

	InstancePtr->SendHandler = FuncPtr;
	InstancePtr->SendCallBackRef = CallBackRef;

	InstancePtr->Uart.SendHandler = SendDataHandler;
	InstancePtr->Uart.SendCallBackRef = InstancePtr;
}

/****************************************************************************/
/**
*
* This function sets the handler that will be called when an event (interrupt)
* occurs in the driver. The purpose of the handler is to allow application
* specific processing to be performed.
*
* @param	InstancePtr is a pointer to the XUartExt instance .
* @param	FuncPtr is the pointer to the callback function.
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
*
* @return 	None.
*
* @note		There is no assert on the CallBackRef since the driver doesn't
*		know what it is (nor should it)
*
*****************************************************************************/
void XUartExt_SetCommandHandler(XUartExt *InstancePtr,
				XUartExt_CommandHandler FuncPtr, void *CallBackRef)
{
	/*
	 * Assert validates the input arguments
	 * CallBackRef not checked, no way to know what is valid
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(FuncPtr != NULL);
	Xil_AssertVoid(InstancePtr->Uart.IsReady == XIL_COMPONENT_IS_READY);

	InstancePtr->CommandHandler = FuncPtr;
	InstancePtr->CommandCallBackRef = CallBackRef;
}

/****************************************************************************/
/**
*
* This function handles the interrupt when data is received, either a single
* byte when FIFOs are not enabled, or multiple bytes with the FIFO.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
static void ReceiveDataHandler(void *CallBackRef, unsigned int ByteCount)
{
	XUartExt *InstancePtr = CallBackRef;
	InstancePtr->RecvHandler(InstancePtr->RecvCallBackRef, ByteCount);
}

/****************************************************************************/
/**
*
* This function handles the interrupt when data has been sent, the transmit
* FIFO is empty (transmitter holding register).
*
* @param	InstancePtr is a pointer to the XUartExt instance .
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
static void SendDataHandler(void *CallBackRef, unsigned int ByteCount)
{
	XUartExt *InstancePtr = CallBackRef;
	InstancePtr->SendHandler(InstancePtr->SendCallBackRef, ByteCount);
}


/*****************************************************************************/
/**
*
* This function disables the UART interrupt. After calling this function,
* data may still be received by the UART but no interrupt will be generated
* since the hardware device has no way to disable the receiver.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XUartExt_DisableInterrupt(XUartExt *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	XUartLite_DisableInterrupt(&InstancePtr->Uart);
}

/*****************************************************************************/
/**
*
* This function enables the UART interrupt such that an interrupt will occur
* when data is received or data has been transmitted. The device contains
* 16 byte receive and transmit FIFOs such that an interrupt is generated
* anytime there is data in the receive FIFO and when the transmit FIFO
* transitions from not empty to empty.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XUartExt_EnableInterrupt(XUartExt *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	XUartLite_EnableInterrupt(&InstancePtr->Uart);
}

