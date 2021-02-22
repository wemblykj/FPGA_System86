/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
*****************************************************************************/

#ifndef XTTLMEMBUS_H			/* prevent circular inclusions */
#define XTTLMEMBUS_H			/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files ********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
//#include "xgpio_l.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/**
 * This typedef contains configuration information for the device.
 */
typedef struct {
	u16 DeviceId;		/* Unique ID  of device */
	u32 BaseAddress;	/* Device base address */
	int Readonly;		/* Memory is read-only (ROM) */
} XTtlMemBus_Config;

/**
 * The XTtlMemBus driver instance data. The user is required to allocate a
 * variable of this type for every TTLMEMBUS device in the system. A pointer
 * to a variable of this type is then passed to the driver API functions.
 */
typedef struct {
	u32 BaseAddress;	/* Device base address */
	u32 IsReady;		/* Device is initialized and ready */
	int Readonly;		/* Memory is read-only (ROM) */
} XTtlMemBus;

/***************** Macros (Inline Functions) Definitions ********************/


/************************** Function Prototypes *****************************/

/*
 * Initialization functions in xgpio_sinit.c
 */
int XTtlMemBus_Initialize(XTtlMemBus *InstancePtr, u16 DeviceId);
XTtlMemBus_Config *XTtlMemBus_LookupConfig(u16 DeviceId);

/*
 * API Basic functions implemented in xgpio.c
 */
int XTtlMemBus_CfgInitialize(XTtlMemBus *InstancePtr, XTtlMemBus_Config * Config,
			u32 EffectiveAddr);
void XTtlMemBus_SetDataDirection(XTtlMemBus *InstancePtr, unsigned Channel,
			    u32 DirectionMask);
u32 XTtlMemBus_GetDataDirection(XTtlMemBus *InstancePtr, unsigned Channel);
u32 XTtlMemBus_DiscreteRead(XTtlMemBus *InstancePtr, unsigned Channel);
void XTtlMemBus_DiscreteWrite(XTtlMemBus *InstancePtr, unsigned Channel, u32 Mask);


/*
 * API Functions implemented in xgpio_extra.c
 */
void XTtlMemBus_DiscreteSet(XTtlMemBus *InstancePtr, unsigned Channel, u32 Mask);
void XTtlMemBus_DiscreteClear(XTtlMemBus *InstancePtr, unsigned Channel, u32 Mask);

/*
 * API Functions implemented in xgpio_selftest.c
 */
int XTtlMemBus_SelfTest(XTtlMemBus *InstancePtr);

/*
 * API Functions implemented in xgpio_intr.c
 */
// void XTtlMemBus_InterruptGlobalEnable(XTtlMemBus *InstancePtr);
// void XTtlMemBus_InterruptGlobalDisable(XTtlMemBus *InstancePtr);
// void XTtlMemBus_InterruptEnable(XTtlMemBus *InstancePtr, u32 Mask);
// void XTtlMemBus_InterruptDisable(XTtlMemBus *InstancePtr, u32 Mask);
// void XTtlMemBus_InterruptClear(XTtlMemBus *InstancePtr, u32 Mask);
// u32 XTtlMemBus_InterruptGetEnabled(XTtlMemBus *InstancePtr);
// u32 XTtlMemBus_InterruptGetStatus(XTtlMemBus *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
