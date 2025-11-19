/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/
#ifndef system86_INTR_HEADER_H		/* prevent circular inclusions */
#define system86_INTR_HEADER_H		/* by using protection macros */

#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"


int system86IntrExample(XIntc* IntcInstancePtr,
                        Xsystem86* InstancePtr,
                        u16 DeviceId,
                        u16 IntrId,
                        u16 IntrMask);


#endif

