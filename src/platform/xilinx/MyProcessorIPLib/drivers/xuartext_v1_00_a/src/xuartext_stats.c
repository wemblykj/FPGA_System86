/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

/***************************** Include Files ********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xuartext.h"
#include "xuartext_i.h"

/************************** Constant Definitions ****************************/


/**************************** Type Definitions ******************************/


/***************** Macros (Inline Functions) Definitions ********************/


/************************** Variable Definitions ****************************/


/************************** Function Prototypes *****************************/


/****************************************************************************/
/**
*
* Returns a snapshot of the current statistics in the structure specified.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	StatsPtr is a pointer to a XUartExtStats structure to where the
*		statistics are to be copied.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XUartExt_GetStats(XUartExt *InstancePtr, XUartExt_Stats *StatsPtr)
{
	/*
	 * Assert validates the input arguments
	 */
	Xil_AssertVoid(InstancePtr != NULL);

	return XUartLite_GetStats(InstancePtr->UartLite, StatsPtr);
}

/****************************************************************************/
/**
*
* This function zeros the statistics for the given instance.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XUartExt_ClearStats(XUartExt *InstancePtr)
{
	/*
	 * Assert validates the input arguments
	 */
	Xil_AssertVoid(InstancePtr != NULL);

	return XUartLite_ClearStats(InstancePtr->UartLite);
}

