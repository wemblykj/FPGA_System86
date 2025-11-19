#include "xttlmembus.h"

/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

int XTtlMemBus_SelfTest(XTtlMemBus * InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Read from the data register of channel 1 which is always guaranteed
	 * to be in the hardware device. Since the data may be configured as
	 * all inputs, there is not way to guarantee the value read so don't
	 * test it.
	 */
	//(void) XTtlMemBus_DiscreteRead(InstancePtr, 1);

	return (XST_SUCCESS);
}
