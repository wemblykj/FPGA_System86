/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

/***************************** Include Files ********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xuartext.h"
#include "xuartext_i.h"
#include "xil_io.h"

/************************** Constant Definitions ****************************/


/**************************** Type Definitions ******************************/


/***************** Macros (Inline Functions) Definitions ********************/


/************************** Variable Definitions ****************************/


/************************** Function Prototypes *****************************/


/****************************************************************************/
/**
*
* Runs a self-test on the device hardware. Since there is no way to perform a
* loopback in the hardware, this test can only check the state of the status
* register to verify it is correct. This test assumes that the hardware
* device is still in its reset state, but has been initialized with the
* Initialize function.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
*
* @return
* 		- XST_SUCCESS if the self-test was successful.
* 		- XST_FAILURE if the self-test failed, the status register
*			value was not correct
*
* @note		None.
*
******************************************************************************/
int XUartExt_SelfTest(XUartExt *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	return XUartLite_SelfTest(InstancePtr->UartLite)
}


