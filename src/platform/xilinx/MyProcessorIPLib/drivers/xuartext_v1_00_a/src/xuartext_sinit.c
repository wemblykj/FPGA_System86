/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

/***************************** Include Files ********************************/

#include "xstatus.h"
#include "xparameters.h"
#include "xuartext_i.h"

/************************** Constant Definitions ****************************/


/**************************** Type Definitions ******************************/


/***************** Macros (Inline Functions) Definitions ********************/


/************************** Variable Definitions ****************************/


/************************** Function Prototypes *****************************/

/****************************************************************************
*
* Looks up the device configuration based on the unique device ID.  The table
* UartliteConfigTable contains the configuration info for each device in the
* system.
*
* @param	DeviceId is the unique device ID to match on.
*
* @return	A pointer to the configuration data for the device, or
*		NULL if no match was found.
*
* @note		None.
*
******************************************************************************/
XUartExt_Config *XUartExt_LookupConfig(u16 DeviceId)
{
	XUartExt_Config *CfgPtr = NULL;
	u32 Index;

	for (Index=0; Index < XPAR_XUARTEXT_NUM_INSTANCES; Index++) {
		if (XUartExt_ConfigTable[Index]->UartLite.DeviceId == DeviceId) {
			CfgPtr = &XUartExt_ConfigTable[Index];
			break;
		}
	}

	return CfgPtr;
}

/****************************************************************************/
/**
*
* Initialize a XUartExt instance.  The receive and transmit FIFOs of the
* UART are not flushed, so the user may want to flush them. The hardware
* device does not have any way to disable the receiver such that any valid
* data may be present in the receive FIFO. This function disables the UART
* interrupt. The baudrate and format of the data are fixed in the hardware
* at hardware build time.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	DeviceId is the unique id of the device controlled by this
*		XUartExt instance.  Passing in a device id associates the
*		generic XUartExt instance to a specific device, as chosen by
*		the caller or application developer.
*
* @return
* 		- XST_SUCCESS if everything starts up as expected.
* 		- XST_DEVICE_NOT_FOUND if the device is not found in the
*			configuration table.
*
* @note		None.
*
*****************************************************************************/
int XUartExt_Initialize(XUartExt *InstancePtr, u16 DeviceId)
{
	XUartExt_Config *ConfigPtr;

	/*
	 * Assert validates the input arguments
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);

	return XUartLite_Initialise(InstancePtr->UartLite, DeviceId);
}

