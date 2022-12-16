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
#include "xparameters.h"
#include "xstatus.h"
#include "xttlmembus_l.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

typedef struct {
	u8 Width;
	u8 Lsb;
	u16 Mask;
} XTtlMemBus_BusAttr;

/**
 * This typedef contains configuration information for the device.
 */
typedef struct {
	u16 DeviceId;				/* Unique ID  of device */
	u32 BaseAddress;			/* Device base address */
	int AddressWidth;			/* Address width of TTL bus */
	int DataWidth;				/* Data width of TTL bus */
	int ReadOnly;				/* Memory is read-only (ROM) */
	u32 MappedBaseAddress;			/* The AXI bus address to which the memory bus is mapped */
	int SupportsDynamicMapping;  		/* The AXI bus address can be configured */
	int InterruptPresent;			/* Are interrups supported in h/w */
} XTtlMemBus_Config;

/**
 * The XTtlMemBus driver instance data. The user is required to allocate a
 * variable of this type for every TTLMEMBUS device in the system. A pointer
 * to a variable of this type is then passed to the driver API functions.
 */
typedef struct {
	u32 BaseAddress;			/* Device base address */
	u32 IsReady;				/* Device is initialized and ready */
	int ReadOnly;				/* Memory is read-only (ROM) */
	u32 MappedBaseAddress;			/* The AXI bus address to which the memory bus is mapped */
	XTtlMemBus_BusAttr CtrlBusAttr;		/* Control bus attributes */
	XTtlMemBus_BusAttr AddrBusAttr;		/* Address width of TTL bus */
	XTtlMemBus_BusAttr DataBusAttr;		/* Data width of TTL bus */
	int SupportsDynamicMapping;  		/* The AXI bus address can be configured */
	int InterruptPresent;			/* Are interrups supported in h/w */
} XTtlMemBus;

/***************** Macros (Inline Functions) Definitions ********************/


/************************** Function Prototypes *****************************/

/*
 * Initialization functions in xgpio_sinit.c
 */
int XTtlMemBus_Initialize(XTtlMemBus *InstancePtr, u16 DeviceId);
XTtlMemBus_Config *XTtlMemBus_LookupConfig(u16 DeviceId);

/*
 * DeviceId centric functions 
 */
XTtlMemBus *XTtlMemBus_GetInstance(u16 DeviceId);
int XTtlMemBus_DeviceInitialize(u16 DeviceId);
//void XTtlMemBus_RegisterHandler(u32 BaseAddress, int InterruptId,
//			     Xil_InterruptHandler Handler, void *CallBackRef);

/*
 * API Basic functions implemented in xgpio.c
 */
int XTtlMemBus_CfgInitialize(XTtlMemBus *InstancePtr, XTtlMemBus_Config * Config,
			u32 EffectiveAddr);
void XTtlMemBus_WriteRegMasked(XTtlMemBus *InstancePtr, u32 RegOffset, u32 Data, u32 Mask);

u32 XTtlMemBus_GetStatus(XTtlMemBus *InstancePtr);
int XTtlMemBus_GetSupportsDynamicMapping(XTtlMemBus *InstancePtr);
int XTtlMemBus_GetRunning(XTtlMemBus *InstancePtr);
int XTtlMemBus_Start(XTtlMemBus *InstancePtr);
void XTtlMemBus_Stop(XTtlMemBus *InstancePtr);
u32 XTtlMemBus_GetErrors(XTtlMemBus *InstancePtr);

void XTtlMemBus_SetBaseAddress(XTtlMemBus *InstancePtr, u32 BaseAddress);
u32 XTtlMemBus_GetBaseAddress(XTtlMemBus *InstancePtr);
void XTtlMemBus_SetBaseAddress(XTtlMemBus *InstancePtr, u32 BaseAddress);
u32 XTtlMemBus_GetBaseAddress(XTtlMemBus *InstancePtr);

///< Set the value of the bus state register
void XTtlMemBus_SetMemBusState(XTtlMemBus *InstancePtr, u32 Bus, u32 BusMask);
///< Get the current value of the bus state register
u32 XTtlMemBus_GetMemBusState(XTtlMemBus *InstancePtr);

///< Set the value of the bus register
void XTtlMemBus_WriteBus(XTtlMemBus *InstancePtr, u32 RegOffset, XTtlMemBus_BusAttr *Attr, u16 BusValue);
u16 XTtlMemBus_ReadBus(XTtlMemBus *InstancePtr, u32 RegOffset, XTtlMemBus_BusAttr *Attr);

///< Set the value of the bus address register
void XTtlMemBus_SetBusAddress(XTtlMemBus *InstancePtr, u32 BusAddress);
///< Get the current value of the bus address register
u32 XTtlMemBus_GetBusAddress(XTtlMemBus *InstancePtr);

///< Set the value of the bus data register
void XTtlMemBus_SetBusData(XTtlMemBus *InstancePtr, u32 BusData);
///< Get the current value of the bus data register
u32 XTtlMemBus_GetBusData(XTtlMemBus *InstancePtr);

///< Get the current value of the bus fault value register
void XTtlMemBus_SetBusFaultValue(XTtlMemBus *InstancePtr, u32 FaultValue, u32 BusMask);
///< Get the current value of the bus fault value register
u32 XTtlMemBus_GetBusFaultValue(XTtlMemBus *InstancePtr);
///< Get the current value of the bus fault enable register
void XTtlMemBus_SetBusFaultEnabled(XTtlMemBus *InstancePtr, u32 FaultEnabled, u32 BusMask);
///< Get the current value of the bus fault enable register
u32 XTtlMemBus_GetBusFaultEnabled(XTtlMemBus *InstancePtr);

///< Set the value of the bus fault register and enable the lines identified by \a BusMask
void XTtlMemBus_SetBusFault(XTtlMemBus *InstancePtr, u32 Value, u32 BusMask);
///< Enable bus faults for the lines identified in \a BusMask
void XTtlMemBus_EnableBusFault(XTtlMemBus *InstancePtr, u32 BusMask);
///< Disable bus faults for the lines identified in \a BusMask
void XTtlMemBus_DisableBusFault(XTtlMemBus *InstancePtr, u32 BusMask);
///< Clear the all fault bits in the fault register
void XTtlMemBus_ClearBusFault(XTtlMemBus *InstancePtr, u32 BusMask);

///< Set the value of the write enable bit in the fault register and enable the write enable fault
void XTtlMemBus_SetWriteEnableFault(XTtlMemBus *InstancePtr, int Logic);
///< Clear the write enable fault bits in the fault register
void XTtlMemBus_ClearWriteEnableFault(XTtlMemBus *InstancePtr);

///< Set the value of the output enable bit in the fault register and enable the output enable fault
void XTtlMemBus_SetOutputEnableFault(XTtlMemBus *InstancePtr, int Logic);
///< Clear the output enable bits in the fault register
void XTtlMemBus_ClearOutputEnableFault(XTtlMemBus *InstancePtr);

///< Set the value of the bus address in the fault register
void XTtlMemBus_SetAddresFault(XTtlMemBus *InstancePtr, u32 Address, u32 BusMask);
///< Clear the address bus bits in the fault register
void XTtlMemBus_ClearAddressFault(XTtlMemBus *InstancePtr, u32 BusMask);

///< Set the value of the bus data fault in the fault register
void XTtlMemBus_SetDataFault(XTtlMemBus *InstancePtr, u32 BusData, u32 BusMask);
///< Clear the data bus bits in the fault register
void XTtlMemBus_ClearDataFault(XTtlMemBus *InstancePtr, u32 BusMask);



/*
 * API Functions implemented in xgpio_selftest.c
 */
int XTtlMemBus_SelfTest(XTtlMemBus *InstancePtr);

/* Debug utility function
 */
void XTtlMemBus_DumpRegisters(XTtlMemBus *InstancePtr);

/*
 * API Functions implemented in xttlmembus_intr.c
 */
void XTtlMemBus_InterruptGlobalEnable(XTtlMemBus *InstancePtr);
void XTtlMemBus_InterruptGlobalDisable(XTtlMemBus *InstancePtr);
void XTtlMemBus_InterruptEnable(XTtlMemBus *InstancePtr, u32 Mask);
void XTtlMemBus_InterruptDisable(XTtlMemBus *InstancePtr, u32 Mask);
void XTtlMemBus_InterruptClear(XTtlMemBus *InstancePtr, u32 Mask);
u32 XTtlMemBus_InterruptGetEnabled(XTtlMemBus *InstancePtr);
u32 XTtlMemBus_InterruptGetStatus(XTtlMemBus *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
