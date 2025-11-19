/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

/***************************** Include Files *********************************/

#include "xsystem86.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/************************** Variable Prototypes ******************************/

/**
 * This table contains configuration information for each SYSTEM86 device
 * in the system.
 */
XSystem86_Config XSystem86_ConfigTable[XPAR_XSYSTEM86_NUM_INSTANCES] = {
	{
	 XPAR_SYSTEM86_0_DEVICE_ID,
	 XPAR_SYSTEM86_0_BASEADDR,
	 XPAR_SYSTEM86_0_ADDR_WIDTH,
	 XPAR_SYSTEM86_0_DATA_WIDTH,
	 XPAR_SYSTEM86_0_READONLY,
	 XPAR_SYSTEM86_0_MAPPED_ADDRESS,
	 XPAR_SYSTEM86_0_USE_DYNAMIC_MAPPING,
	 XPAR_SYSTEM86_0_INTERRUPT_PRESENT}
};
