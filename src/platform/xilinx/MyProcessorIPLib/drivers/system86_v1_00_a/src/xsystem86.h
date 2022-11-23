/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

#ifndef XSYSTEM86_H			/* prevent circular inclusions */
#define XSYSTEM86_H			/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files ********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xsystem86_l.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

typedef struct {
	u8 Width;
	u8 Lsb;
	u16 Mask;
} XSystem86_BusAttr;

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
} XSystem86_Config;

/**
 * The XSystem86 driver instance data. The user is required to allocate a
 * variable of this type for every SYSTEM86 device in the system. A pointer
 * to a variable of this type is then passed to the driver API functions.
 */
typedef struct {
	u32 BaseAddress;			/* Device base address */
	u32 IsReady;				/* Device is initialized and ready */
	int ReadOnly;				/* Memory is read-only (ROM) */
	u32 MappedBaseAddress;			/* The AXI bus address to which the memory bus is mapped */
	XSystem86_BusAttr CtrlBusAttr;		/* Control bus attributes */
	XSystem86_BusAttr AddrBusAttr;		/* Address width of TTL bus */
	XSystem86_BusAttr DataBusAttr;		/* Data width of TTL bus */
	int SupportsDynamicMapping;  		/* The AXI bus address can be configured */
	int InterruptPresent;			/* Are interrups supported in h/w */
} XSystem86;

/***************** Macros (Inline Functions) Definitions ********************/


/************************** Function Prototypes *****************************/

/*
 * Initialization functions in xgpio_sinit.c
 */
int XSystem86_Initialize(XSystem86 *InstancePtr, u16 DeviceId);
XSystem86_Config *XSystem86_LookupConfig(u16 DeviceId);

/*
 * DeviceId centric functions 
 */
XSystem86 *XSystem86_GetInstance(u16 DeviceId);
int XSystem86_DeviceInitialize(u16 DeviceId);
//void XSystem86_RegisterHandler(u32 BaseAddress, int InterruptId,
//			     Xil_InterruptHandler Handler, void *CallBackRef);

/*
 * API Basic functions implemented in xgpio.c
 */
int XSystem86_CfgInitialize(XSystem86 *InstancePtr, XSystem86_Config * Config,
			u32 EffectiveAddr);
void XSystem86_WriteRegMasked(XSystem86 *InstancePtr, u32 RegOffset, u32 Data, u32 Mask);

u32 XSystem86_GetStatus(XSystem86 *InstancePtr);
int XSystem86_GetSupportsDynamicMapping(XSystem86 *InstancePtr);
int XSystem86_GetEnabled(XSystem86 *InstancePtr);
int XSystem86_Start(XSystem86 *InstancePtr);
void XSystem86_Stop(XSystem86 *InstancePtr);
u32 XSystem86_GetErrors(XSystem86 *InstancePtr);

void XSystem86_SetBaseAddress(XSystem86 *InstancePtr, u32 BaseAddress);
u32 XSystem86_GetBaseAddress(XSystem86 *InstancePtr);
void XSystem86_SetBaseAddress(XSystem86 *InstancePtr, u32 BaseAddress);
u32 XSystem86_GetBaseAddress(XSystem86 *InstancePtr);

///< Set the value of the bus state register
void XSystem86_SetMemBusState(XSystem86 *InstancePtr, u32 Bus, u32 BusMask);
///< Get the current value of the bus state register
u32 XSystem86_GetMemBusState(XSystem86 *InstancePtr);

///< Set the value of the bus register
void XSystem86_WriteBus(XSystem86 *InstancePtr, u32 RegOffset, XSystem86_BusAttr *Attr, u16 BusValue);
u16 XSystem86_ReadBus(XSystem86 *InstancePtr, u32 RegOffset, XSystem86_BusAttr *Attr);

///< Set the value of the bus address register
void XSystem86_SetBusAddress(XSystem86 *InstancePtr, u32 BusAddress);
///< Get the current value of the bus address register
u32 XSystem86_GetBusAddress(XSystem86 *InstancePtr);

///< Set the value of the bus data register
void XSystem86_SetBusData(XSystem86 *InstancePtr, u32 BusData);
///< Get the current value of the bus data register
u32 XSystem86_GetBusData(XSystem86 *InstancePtr);

///< Get the current value of the bus fault value register
void XSystem86_SetBusFaultValue(XSystem86 *InstancePtr, u32 FaultValue, u32 BusMask);
///< Get the current value of the bus fault value register
u32 XSystem86_GetBusFaultValue(XSystem86 *InstancePtr);
///< Get the current value of the bus fault enable register
void XSystem86_SetBusFaultEnabled(XSystem86 *InstancePtr, u32 FaultEnabled, u32 BusMask);
///< Get the current value of the bus fault enable register
u32 XSystem86_GetBusFaultEnabled(XSystem86 *InstancePtr);

///< Set the value of the bus fault register and enable the lines identified by \a BusMask
void XSystem86_SetBusFault(XSystem86 *InstancePtr, u32 Value, u32 BusMask);
///< Enable bus faults for the lines identified in \a BusMask
void XSystem86_EnableBusFault(XSystem86 *InstancePtr, u32 BusMask);
///< Disable bus faults for the lines identified in \a BusMask
void XSystem86_DisableBusFault(XSystem86 *InstancePtr, u32 BusMask);
///< Clear the all fault bits in the fault register
void XSystem86_ClearBusFault(XSystem86 *InstancePtr, u32 BusMask);

///< Set the value of the write enable bit in the fault register and enable the write enable fault
void XSystem86_SetWriteEnableFault(XSystem86 *InstancePtr, int Logic);
///< Clear the write enable fault bits in the fault register
void XSystem86_ClearWriteEnableFault(XSystem86 *InstancePtr);

///< Set the value of the output enable bit in the fault register and enable the output enable fault
void XSystem86_SetOutputEnableFault(XSystem86 *InstancePtr, int Logic);
///< Clear the output enable bits in the fault register
void XSystem86_ClearOutputEnableFault(XSystem86 *InstancePtr);

///< Set the value of the bus address in the fault register
void XSystem86_SetAddresFault(XSystem86 *InstancePtr, u32 Address, u32 BusMask);
///< Clear the address bus bits in the fault register
void XSystem86_ClearAddressFault(XSystem86 *InstancePtr, u32 BusMask);

///< Set the value of the bus data fault in the fault register
void XSystem86_SetDataFault(XSystem86 *InstancePtr, u32 BusData, u32 BusMask);
///< Clear the data bus bits in the fault register
void XSystem86_ClearDataFault(XSystem86 *InstancePtr, u32 BusMask);



/*
 * API Functions implemented in xgpio_selftest.c
 */
int XSystem86_SelfTest(XSystem86 *InstancePtr);

/* Debug utility function
 */
void XSystem86_DumpRegisters(XSystem86 *InstancePtr);

/*
 * API Functions implemented in xsystem86_intr.c
 */
void XSystem86_InterruptGlobalEnable(XSystem86 *InstancePtr);
void XSystem86_InterruptGlobalDisable(XSystem86 *InstancePtr);
void XSystem86_InterruptEnable(XSystem86 *InstancePtr, u32 Mask);
void XSystem86_InterruptDisable(XSystem86 *InstancePtr, u32 Mask);
void XSystem86_InterruptClear(XSystem86 *InstancePtr, u32 Mask);
u32 XSystem86_InterruptGetEnabled(XSystem86 *InstancePtr);
u32 XSystem86_InterruptGetStatus(XSystem86 *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
