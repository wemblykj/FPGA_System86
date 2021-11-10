/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/
#ifndef TTLMEMBUS_INTR_HEADER_H		/* prevent circular inclusions */
#define TTLMEMBUS_INTR_HEADER_H		/* by using protection macros */

#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"


int TtlMemBusIntrExample(XIntc* IntcInstancePtr,
                        XTtlMemBus* InstancePtr,
                        u16 DeviceId,
                        u16 IntrId,
                        u16 IntrMask);


#endif

