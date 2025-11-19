/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
******************************************************************************/
/******************************************************************************/
/**
* @file xsystem86_i.h
*
* This header file contains internal identifiers, which are those shared
* between the files of the driver. It is intended for internal use only.
*
* NOTES:
*
* None.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.00a rmm  03/13/02 First release
* 2.11a mta  03/21/07 Updated to new coding style
* </pre>
******************************************************************************/

#ifndef XSYSTEM86_I_H		/* prevent circular inclusions */
#define XSYSTEM86_I_H		/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xsystem86.h"

/************************** Constant Definitions ****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/************************** Variable Definitions ****************************/

extern XSystem86_Config XSystem86_ConfigTable[];

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
