/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
******************************************************************************/

#ifndef XUARTEXT_I_H /* prevent circular inclusions */
#define XUARTEXT_I_H /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files ********************************/

#include "xuartext.h"
#include "xuartext_l.h"

#include "xuartlite_i"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/***************** Macros (Inline Functions) Definitions ********************/

/****************************************************************************
*
* Update the statistics of the instance.
*
* @param	InstancePtr is a pointer to the XUartExt instance.
* @param	StatusRegister contains the contents of the UART status
*		register to update the statistics with.
*
* @return	None.
*
* @note
*
* Signature: void XUartExt_UpdateStats(XUartExt *InstancePtr,
*						u32 StatusRegister)
*
*****************************************************************************/
#define XUartExt_UpdateStats(InstancePtr, StatusRegister)	\
	XUartLite_UpdateStats(InstancePtr, StatusRegister)

/************************** Variable Definitions ****************************/

/* the configuration table */
extern XUartExt_Config XUartExt_ConfigTable[];

/************************** Function Prototypes *****************************/

//unsigned int XUartExt_SendBuffer(XUartExt *InstancePtr);
//unsigned int XUartExt_ReceiveBuffer(XUartExt *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif		/* end of protection macro */

