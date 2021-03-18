/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

#ifndef XUARTEXT_L_H /* prevent circular inclusions */
#define XUARTEXT_L_H /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files ********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xil_io.h"

#include "xuartext_l.h"


/************************** Constant Definitions ****************************/


/**************************** Type Definitions ******************************/

/***************** Macros (Inline Functions) Definitions ********************/

#define XUartExt_In32  XUartLite_In32
#define XUartExt_Out32 XUartLite_Out32


/****************************************************************************/
/**
*
* Write a value to a UartLite register. A 32 bit write is performed.
*
* @param	BaseAddress is the base address of the UartLite device.
* @param	RegOffset is the register offset from the base to write to.
* @param	Data is the data written to the register.
*
* @return	None.
*
* @note		C-style signature:
*		void XUartExt_WriteReg(u32 BaseAddress, u32 RegOffset,
*					u32 Data)
*
****************************************************************************/
#define XUartExt_WriteReg(BaseAddress, RegOffset, Data) \
	XUartLite_WriteReg(BaseAddress, RegOffset, Data)

/****************************************************************************/
/**
*
* Read a value from a UartLite register. A 32 bit read is performed.
*
* @param	BaseAddress is the base address of the UartLite device.
* @param	RegOffset is the register offset from the base to read from.
*
* @return	Data read from the register.
*
* @note		C-style signature:
*		u32 XUartExt_ReadReg(u32 BaseAddress, u32 RegOffset)
*
****************************************************************************/
#define XUartExt_ReadReg(BaseAddress, RegOffset) \
	XUartLite_ReadReg(BaseAddress, RegOffset)


/****************************************************************************/
/**
*
* Set the contents of the control register. Use the XUL_CR_* constants defined
* above to create the bit-mask to be written to the register.
*
* @param	BaseAddress is the base address of the device
* @param	Mask is the 32-bit value to write to the control register
*
* @return	None.
*
* @note		C-style Signature:
*		void XUartExt_SetControlReg(u32 BaseAddress, u32 Mask);
*
*****************************************************************************/
#define XUartExt_SetControlReg(BaseAddress, Mask) \
	XUartLite_SetControlReg(BaseAddress, Mask)


/****************************************************************************/
/**
*
* Get the contents of the status register. Use the XUL_SR_* constants defined
* above to interpret the bit-mask returned.
*
* @param	BaseAddress is the  base address of the device
*
* @return	A 32-bit value representing the contents of the status register.
*
* @note		C-style Signature:
*		u32 XUartExt_GetStatusReg(u32 BaseAddress);
*
*****************************************************************************/
#define XUartExt_GetStatusReg(BaseAddress) \
		XUartLite_GetStatusReg(BaseAddress)


/****************************************************************************/
/**
*
* Check to see if the receiver has data.
*
* @param	BaseAddress is the  base address of the device
*
* @return	TRUE if the receiver is empty, FALSE if there is data present.
*
* @note		C-style Signature:
*		int XUartExt_IsReceiveEmpty(u32 BaseAddress);
*
*****************************************************************************/
#define XUartExt_IsReceiveEmpty(BaseAddress) \
		XUartLite_IsReceiveEmpty(BaseAddress)


/****************************************************************************/
/**
*
* Check to see if the transmitter is full.
*
* @param	BaseAddress is the  base address of the device
*
* @return	TRUE if the transmitter is full, FALSE otherwise.
*
* @note		C-style Signature:
* 		int XUartExt_IsTransmitFull(u32 BaseAddress);
*
*****************************************************************************/
#define XUartExt_IsTransmitFull(BaseAddress) \
		XUartLite_IsTransmitFull(BaseAddress)


/****************************************************************************/
/**
*
* Check to see if the interrupt is enabled.
*
* @param	BaseAddress is the  base address of the device
*
* @return	TRUE if the interrupt is enabled, FALSE otherwise.
*
* @note		C-style Signature:
*		int XUartExt_IsIntrEnabled(u32 BaseAddress);
*
*****************************************************************************/
#define XUartExt_IsIntrEnabled(BaseAddress) \
		XUartLite_IsIntrEnabled(BaseAddress)


/****************************************************************************/
/**
*
* Enable the device interrupt. We cannot read the control register, so we
* just write the enable interrupt bit and clear all others. Since the only
* other ones are the FIFO reset bits, this works without side effects.
*
* @param	BaseAddress is the  base address of the device
*
* @return	None.
*
* @note		C-style Signature:
* 		void XUartExt_EnableIntr(u32 BaseAddress);
*
*****************************************************************************/
#define XUartExt_EnableIntr(BaseAddress) \
		XUartLite_EnableIntr(BaseAddress)


/****************************************************************************/
/**
*
* Disable the device interrupt. We cannot read the control register, so we
* just clear all bits. Since the only other ones are the FIFO reset bits,
* this works without side effects.
*
* @param	BaseAddress is the  base address of the device
*
* @return	None.
*
* @note		C-style Signature:
* 		void XUartExt_DisableIntr(u32 BaseAddress);
*
*****************************************************************************/
#define XUartExt_DisableIntr(BaseAddress) \
		XUartLite_DisableIntr(BaseAddress)

/************************** Function Prototypes *****************************/

void XUartExt_SendByte(u32 BaseAddress, u8 Data);
u8 XUartExt_RecvByte(u32 BaseAddress);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */


