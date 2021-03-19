/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xuartlite_l.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/************************** Variable Prototypes ******************************/


/****************************************************************************/
/**
*
* This functions sends a single byte using the UART. It is blocking in that it
* waits for the transmitter to become non-full before it writes the byte to
* the transmit register.
*
* @param	BaseAddress is the base address of the device
* @param	Data is the byte of data to send
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void XUartExt_SendByte(u32 BaseAddress, u8 Data)
{
	XUartLite_SendByte(BaseAddress, Data);
}


/****************************************************************************/
/**
*
* This functions receives a single byte using the UART. It is blocking in that
* it waits for the receiver to become non-empty before it reads from the
* receive register.
*
* @param	BaseAddress is the base address of the device
*
* @return	The byte of data received.
*
* @note		None.
*
******************************************************************************/
u8 XUartExt_RecvByte(u32 BaseAddress)
{
	return XUartLite_RecvByte(BaseAddress);
}

