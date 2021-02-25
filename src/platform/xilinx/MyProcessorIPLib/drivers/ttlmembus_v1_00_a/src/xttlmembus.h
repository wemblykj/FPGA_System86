/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
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
#include "xttlmembus_l.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/**
 * This typedef contains configuration information for the device.
 */
typedef struct {
	u16 DeviceId;					/* Unique ID  of device */
	u32 BaseAddress;				/* Device base address */
	u32 MappedBaseAddress;			/* The AXI bus address to which the memory bus is mapped */
	int SupportsDynamicMapping;  	/* The AXI bus address can be configured */
	int ReadOnly;					/* Memory is read-only (ROM) */
} XTtlMemBus_Config;

/**
 * The XTtlMemBus driver instance data. The user is required to allocate a
 * variable of this type for every TTLMEMBUS device in the system. A pointer
 * to a variable of this type is then passed to the driver API functions.
 */
typedef struct {
	u32 BaseAddress;				/* Device base address */
	u32 IsReady;					/* Device is initialized and ready */
	u32 MappedBaseAddress;			/* The AXI bus address to which the memory bus is mapped */
	int SupportsDynamicMapping;  	/* The AXI bus address can be configured */
	int ReadOnly;					/* Memory is read-only (ROM) */
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
u32 XTtlMemBus_GetStatus(XTtlMemBus *InstancePtr);
int XTtlMemBus_GetSupportsDynamicMapping(XTtlMemBus *InstancePtr);
int XTtlMemBus_GetEnabled(XTtlMemBus *InstancePtr);
int XTtlMemBus_Start(XTtlMemBus *InstancePtr);
void XTtlMemBus_Stop(XTtlMemBus *InstancePtr);
void XTtlMemBus_SetBaseAddress(XTtlMemBus *InstancePtr, u32 BaseAddress);
u32 XTtlMemBus_GetBaseAddress(XTtlMemBus *InstancePtr);
u32 XTtlMemBus_GetErrors(XTtlMemBus *InstancePtr);


/*
 * API Functions implemented in xgpio_selftest.c
 */
int XTtlMemBus_SelfTest(XTtlMemBus *InstancePtr);

/* Debug utility function
 */
void XTtlMemBus_DumpRegisters(XTtlMemBus *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
