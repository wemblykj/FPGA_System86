/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

/***************************** Include Files ********************************/
#include "xsystem86.h"


/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/***************** Macros (Inline Functions) Definitions ********************/

/************************** Variable Definitions ****************************/

/************************** Function Prototypes *****************************/


/****************************************************************************/
/**
* Enable the interrupt output signal. Interrupts enabled through
* XSystem86_InterruptEnable() will not be passed through until the global enable
* bit is set by this function. This function is designed to allow all
* interrupts (both channels) to be enabled easily for exiting a critical
* section. This function will assert if the hardware device has not been
* built with interrupt capabilities.
*
* @param	InstancePtr is the GPIO instance to operate on.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XSystem86_InterruptGlobalEnable(XSystem86 * InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->InterruptPresent == TRUE);

	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_GIE_OFFSET,
			XSYSTEM86_GIE_GINTR_ENABLE_MASK);
}


/****************************************************************************/
/**
* Disable the interrupt output signal. Interrupts enabled through
* XSystem86_InterruptEnable() will no longer be passed through until the global
* enable bit is set by XSystem86_InterruptGlobalEnable(). This function is
* designed to allow all interrupts (both channels) to be disabled easily for
* entering a critical section. This function will assert if the hardware
* device has not been built with interrupt capabilities.
*
* @param	InstancePtr is the GPIO instance to operate on.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XSystem86_InterruptGlobalDisable(XSystem86 * InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->InterruptPresent == TRUE);
	
	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_GIE_OFFSET, 0x0);

}


/****************************************************************************/
/**
* Enable interrupts. The global interrupt must also be enabled by calling
* XSystem86_InterruptGlobalEnable() for interrupts to occur. This function will
* assert if the hardware device has not been built with interrupt capabilities.
*
* @param	InstancePtr is the GPIO instance to operate on.
* @param	Mask is the mask to enable. Bit positions of 1 are enabled.
*		This mask is formed by OR'ing bits from XSYSTEM86_IR* bits which
*		are contained in xsystem86_l.h.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XSystem86_InterruptEnable(XSystem86 * InstancePtr, u32 Mask)
{
	u32 Register;

	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->InterruptPresent == TRUE);

	/*
	 * Read the interrupt enable register and only enable the specified
	 * interrupts without disabling or enabling any others.
	 */

	Register = XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_IER_OFFSET);
	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_IER_OFFSET,
			Register | Mask);
}


/****************************************************************************/
/**
* Disable interrupts. This function allows specific interrupts for each
* channel to be disabled. This function will assert if the hardware device
* has not been built with interrupt capabilities.
*
* @param	InstancePtr is the GPIO instance to operate on.
* @param 	Mask is the mask to disable. Bits set to 1 are disabled. This
*		mask is formed by OR'ing bits from XSYSTEM86_IR* bits which are
*		contained in xsystem86_l.h.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XSystem86_InterruptDisable(XSystem86 * InstancePtr, u32 Mask)
{
	u32 Register;

	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->InterruptPresent == TRUE);

	/*
	 * Read the interrupt enable register and only disable the specified
	 * interrupts without enabling or disabling any others.
	 */
	Register = XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_IER_OFFSET);
	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_IER_OFFSET,
			Register & (~Mask));
}

/****************************************************************************/
/**
* Clear pending interrupts with the provided mask. This function should be
* called after the software has serviced the interrupts that are pending.
* This function will assert if the hardware device has not been built with
* interrupt capabilities.
*
* @param 	InstancePtr is the GPIO instance to operate on.
* @param 	Mask is the mask to clear pending interrupts for. Bit positions
*		of 1 are cleared. This mask is formed by OR'ing bits from
*		XSYSTEM86_IR* bits which are contained in xsystem86_l.h.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XSystem86_InterruptClear(XSystem86 * InstancePtr, u32 Mask)
{
	u32 Register;

	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->InterruptPresent == TRUE);

	/*
	 * Read the interrupt status register and only clear the interrupts
	 * that are specified without affecting any others.  Since the register
	 * is a toggle on write, make sure any bits to be written are already
	 * set.
	 */
	Register = XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_ISR_OFFSET);
	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_ISR_OFFSET,
			Register & Mask);
}


/****************************************************************************/
/**
* Returns the interrupt enable mask. This function will assert if the
* hardware device has not been built with interrupt capabilities.
*
* @param	InstancePtr is the GPIO instance to operate on.
*
* @return	A mask of bits made from XSYSTEM86_IR* bits which are contained in
*		xsystem86_l.h.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
u32 XSystem86_InterruptGetEnabled(XSystem86 * InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertNonvoid(InstancePtr->InterruptPresent == TRUE);

	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_IER_OFFSET);
}


/****************************************************************************/
/**
* Returns the status of interrupt signals. Any bit in the mask set to 1
* indicates that the channel associated with the bit has asserted an interrupt
* condition. This function will assert if the hardware device has not been
* built with interrupt capabilities.
*
* @param	InstancePtr is the GPIO instance to operate on.
*
* @return	A pointer to a mask of bits made from XSYSTEM86_IR* bits which are
*		 contained in xsystem86_l.h.
*
* @note
*
* The interrupt status indicates the status of the device irregardless if
* the interrupts from the devices have been enabled or not through
* XSystem86_InterruptEnable().
*
*****************************************************************************/
u32 XSystem86_InterruptGetStatus(XSystem86 * InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertNonvoid(InstancePtr->InterruptPresent == TRUE);


	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_ISR_OFFSET);
}
