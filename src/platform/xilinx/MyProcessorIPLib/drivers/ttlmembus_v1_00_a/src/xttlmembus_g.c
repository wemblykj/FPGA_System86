/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

/***************************** Include Files *********************************/

#include "xttlmembus.h"
#include "xparameters.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/************************** Variable Prototypes ******************************/

/**
 * This table contains configuration information for each TTLMEMBUS device
 * in the system.
 */
XTtlMemBus_Config XTtlMemBus_ConfigTable[] = {
	{
	 XPAR_TTLMEMBUS_0_DEVICE_ID,
	 XPAR_TTLMEMBUS_0_BASEADDR,
	 XPAR_TTLMEMBUS_0_MAPPED_ADDRESS
	 XPAR_TTLMEMBUS_0_USE_DYNAMIC_MAPPING,
	 XPAR_TTLMEMBUS_0_READONLY}
};
