/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

/***************************** Include Files ********************************/

#include "xsystem86.h"
#include "xstatus.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/*
 * This typedef contains configuration information for the device.
 */
typedef struct System86Tag
{
    Xuint16 DeviceId;       /* ID to identify the XPci driver */
    int Used;               /* Indicate whether this entry is used */
    XSystem86 System86;     /* XPci driver instance */
} System86Info;

/***************** Macros (Inline Functions) Definitions ********************/

/************************** Variable Definitions ****************************/

extern XSystem86_Config XSystem86_ConfigTable[];

/*
 * Each System86 device gets its own structure which helps the
 * adapter keep track of all device-related information.
 */
static System86Info System86Device[XPAR_XSYSTEM86_NUM_INSTANCES];

/************************** Function Prototypes *****************************/

/*
 * Internal functions
 */
 
static u16 RegisterToBus(XSystem86_BusAttr *BusAttr, u32 RegValue);
static u32 BusToRegister(XSystem86_BusAttr *BusAttr, u16 BusValue);
static System86Info *LookupDevice(u16 DeviceId);

/****************************************************************************/
/**
* Initialize the XSystem86 instance provided by the caller based on the
* given configuration data.
*
* Nothing is done except to initialize the InstancePtr.
*
* @param	InstancePtr is a pointer to an XSystem86 instance. The memory the
*		pointer references must be pre-allocated by the caller. Further
*		calls to manipulate the driver through the XSystem86 API must be
*		made with this pointer.
* @param	Config is a reference to a structure containing information
*		about a specific SYSTEM86 device. This function initializes an
*		InstancePtr object for a specific device specified by the
*		contents of Config. This function can initialize multiple
*		instance objects with the use of multiple calls giving different
*		Config information on each call.
* @param 	EffectiveAddr is the device base address in the virtual memory
*		address space. The caller is responsible for keeping the address
*		mapping from EffectiveAddr to the device physical base address
*		unchanged once this function is invoked. Unexpected errors may
*		occur if the address mapping changes after this function is
*		called. If address translation is not used, use
*		Config->BaseAddress for this parameters, passing the physical
*		address instead.
*
* @return
* 		- XST_SUCCESS	Initialization was successfull.
*
* @note		None.
*
*****************************************************************************/
int XSystem86_CfgInitialize(XSystem86 * InstancePtr, XSystem86_Config * Config,
			u32 EffectiveAddr)
{
	/*
	 * Assert arguments
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);

	InstancePtr->BaseAddress = Config->BaseAddress;

	/*
	 * Set some default values.
	 */
	InstancePtr->ReadOnly = Config->ReadOnly;
	InstancePtr->MappedBaseAddress = Config->MappedBaseAddress;
	InstancePtr->SupportsDynamicMapping = Config->SupportsDynamicMapping;
	InstancePtr->InterruptPresent = Config->InterruptPresent;

	/*
	 * Precalculate some inferred values
	 */

	int lsb = 0;
	const int ctrlWidth = 3; // control signals (WE, OE, CE)
	InstancePtr->CtrlBusAttr.Width = ctrlWidth;
	InstancePtr->CtrlBusAttr.Mask = ((2^ctrlWidth) - 1) << lsb;
	InstancePtr->CtrlBusAttr.Lsb = lsb;
	
	lsb += ctrlWidth;

	InstancePtr->AddrBusAttr.Width = Config->AddressWidth;
	InstancePtr->AddrBusAttr.Mask = ((2^Config->AddressWidth) - 1) << lsb;
	InstancePtr->AddrBusAttr.Lsb =  lsb;
	
	lsb += Config->AddressWidth;

	InstancePtr->DataBusAttr.Width = Config->DataWidth;
	InstancePtr->DataBusAttr.Mask = ((2^Config->DataWidth) - 1) << lsb;
	InstancePtr->DataBusAttr.Lsb = lsb;
	
	lsb += Config->DataWidth;

	/*
	 * Indicate the instance is now ready to use, initialized without error
	 */
	InstancePtr->IsReady = XIL_COMPONENT_IS_READY;
	return (XST_SUCCESS);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_WriteRegMasked(XSystem86 *InstancePtr, u32 RegOffset, u32 Data, u32 Mask)
{
	Xil_AssertVoid(InstancePtr != NULL);

	u32 value = XTtMemBus_ReadReg(InstancePtr->BaseAddress);
	value &= ~Mask;
	value |= (value & Mask);

	XSystem86_WriteReg(InstancePtr->BaseAddress, RegOffset, value);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
int XSystem86_GetSupportsDynamicMapping(XSystem86 *InstancePtr)
{
	return InstancePtr->SupportsDynamicMapping;
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XSystem86_GetStatus(XSystem86 *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_SR_OFFSET);
}

/****************************************************************************/
/**
* Get whether the memory bus is running.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
int XSystem86_GetEnabled(XSystem86 *InstancePtr)
{
	u32 status = XSystem86_GetStatus(InstancePtr);
	
	return (status & XSYSTEM86_SR_RUNNING_MASK) == XSYSTEM86_SR_RUNNING_MASK;
}
	
/****************************************************************************/
/**
* Start the memory bus running.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return
*		- XST_SUCCESS for success
*		- XST_FAILURE for failure to start
*
*****************************************************************************/
int XSystem86_Start(XSystem86 *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	u32 control = XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_CR_OFFSET);
	control = control | XSYSTEM86_CR_ENABLE_MASK;
	
	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_CR_OFFSET, control);
	
	if (!XSystem86_GetEnabled(InstancePtr))
		return (XST_FAILURE);
		
	return (XST_SUCCESS);
}

/****************************************************************************/
/**
* Stop the memory bus from running.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
*****************************************************************************/
void XSystem86_Stop(XSystem86 *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	u32 control = XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_CR_OFFSET);
	control = control & ~XSYSTEM86_CR_ENABLE_MASK;
	
	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_CR_OFFSET, control);
	
	Xil_AssertVoid(!XSystem86_GetEnabled(InstancePtr));
		
	return;
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetBaseAddress(XSystem86 * InstancePtr, u32 BaseAddress)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->SupportsDynamicMapping == TRUE);

	XSystem86_WriteReg(InstancePtr->BaseAddress, XSYSTEM86_BASEADDRESS_OFFSET, BaseAddress);
}

/****************************************************************************/
/**
* Get the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The base address on the AXI bus to which the memory bus is mapped.
*
* @note
*
* If the hardware is not configured for dynamic mapping then the hardware configured base address will always be returned.
*
*****************************************************************************/
u32 XSystem86_GetBaseAddress(XSystem86 *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_BASEADDRESS_OFFSET);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XSystem86_GetErrors(XSystem86 *InstancePtr)
{
	u32 status = XSystem86_GetStatus(InstancePtr);
	
	return (status & XSYSTEM86_SR_ERR_ALL_MASK) >> XSYSTEM86_SR_ERR_ALL_LSB;
}

/****************************************************************************/
/**
* Set the tate of the entire TTL memory bus.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	BusRegValue is the state to which the entire TTL bus will be set.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetMemBusState(XSystem86 *InstancePtr, u32 BusRegValue, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	XSystem86_WriteRegMasked(InstancePtr, XSYSTEM86_BUS_OFFSET, BusRegValue, BusMask);
}

/****************************************************************************/
/**
* Get the state of the entire TTL memory bus.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The value of the bus state.
*
*****************************************************************************/
u32 XSystem86_GetMemBusState(XSystem86 *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_BUS_OFFSET);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_WriteBus(XSystem86 *InstancePtr, u32 RegOffset, XSystem86_BusAttr *Attr, u16 BusValue)
{
	Xil_AssertVoid(InstancePtr != NULL);

	u32 busRegValue = BusToRegister(Attr, BusValue);
	XSystem86_WriteRegMasked(InstancePtr, RegOffset, busRegValue, Attr->Mask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
u16 XSystem86_ReadBus(XSystem86 *InstancePtr, u32 RegOffset, XSystem86_BusAttr *Attr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	u32 reg = XSystem86_ReadReg(InstancePtr->BaseAddress, RegOffset);
	return RegisterToBus(Attr, reg); 
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetBusAddress(XSystem86 *InstancePtr, u32 BusAddress)
{
	XTtlMemBus_WriteBus(InstancePtr, XSYSTEM86_BUS_OFFSET, InstancePtr->AddrBusAttr, BusAddress);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XSystem86_GetBusAddress(XSystem86 *InstancePtr)
{
	return XTtlMemBus_ReadBus(InstancePtr, XSYSTEM86_BUS_OFFSET, InstancePtr->AddrBusAttr);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetBusData(XSystem86 *InstancePtr, u32 BusData)
{
	XTtlMemBus_WriteBus(InstancePtr, XSYSTEM86_BUS_OFFSET, InstancePtr->DataBusAttr, BusData);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XSystem86_GetBusData(XSystem86 *InstancePtr)
{
	return XTtlMemBus_ReadBus(InstancePtr, XSYSTEM86_BUS_OFFSET, InstancePtr->DataBusAttr);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetBusFaultValue(XSystem86 *InstancePtr, u32 FaultValue, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	XSystem86_WriteRegMasked(InstancePtr, XSYSTEM86_LINE_FAULT_VALUE_OFFSET, FaultValue, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
u32 XSystem86_GetBusFaultValue(XSystem86 *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_LINE_FAULT_VALUE_OFFSET);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetBusFaultEnabled(XSystem86 *InstancePtr, u32 FaultEnable, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	XSystem86_WriteRegMasked(InstancePtr, XSYSTEM86_LINE_FAULT_ENABLE_OFFSET, FaultEnable, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
u32 XSystem86_GetBusFaultEnabled(XSystem86 *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XSystem86_ReadReg(InstancePtr->BaseAddress, XSYSTEM86_LINE_FAULT_ENABLE_OFFSET);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetBusFault(XSystem86 *InstancePtr, u32 Value, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);

	XSystem86_SetBusFaultValue(InstancePtr, Value, BusMask);
	XSystem86_EnableBusFault(InstancePtr, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_EnableBusFault(XSystem86 *InstancePtr, u32 BusMask)
{
	XSystem86_SetBusFaultEnabled(InstancePtr, BusMask, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_DisableBusFault(XSystem86 *InstancePtr, u32 BusMask)
{
	XSystem86_SetBusFaultEnabled(InstancePtr, 0, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_ClearBusFault(XSystem86 *InstancePtr, u32 BusMask)
{
	XTtMemBus_DisableBusFault(InstancePtr, BusMask);
	XSystem86_SetBusFaultValue(InstancePtr, 0, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetWriteEnableFault(XSystem86 *InstancePtr, int Logic)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_ClearWriteEnableFault(XSystem86 *InstancePtr)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetOutputEnableFault(XSystem86 *InstancePtr, int Logic)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_ClearOutputEnableFault(XSystem86 *InstancePtr)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetAddressFault(XSystem86 *InstancePtr, u32 Address, u32 BusMask)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_ClearAddressFault(XSystem86 *InstancePtr, u32 BusMask)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_SetDataFault(XSystem86 *InstancePtr, u32 BusData, u32 BusMask)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XSystem86 instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XSystem86_ClearDataFault(XSystem86 *InstancePtr, u32 BusMask)
{
}

/*****************************************************************************/
/**
 * This function dumps the registers of this meory bus instance
 *
 * @param	InstancePtr is the driver instance we are working on
 *
 * @return	None
 *
 * @note	None.
 *
 *****************************************************************************/
void XSystem86_DumpRegisters(XSystem86 *InstancePtr)
{
	u32 RegBase;

	RegBase = InstancePtr->BaseAddress;

	xil_printf("Dump registers:\r\n");
	xil_printf("Control register: %x\r\n",
		XSystem86_ReadReg(RegBase, XSYSTEM86_CR_OFFSET));
	xil_printf("Status register: %x\r\n",
		XSystem86_ReadReg(RegBase, XSYSTEM86_SR_OFFSET));
	xil_printf("Bus register: %x\r\n",
		XSystem86_ReadReg(RegBase, XSYSTEM86_BUS_OFFSET));
	xil_printf("Fault value register: %x\r\n",
		XSystem86_ReadReg(RegBase, XSYSTEM86_LINE_FAULT_VALUE_OFFSET));
	xil_printf("Fault enable register: %x\r\n",
		XSystem86_ReadReg(RegBase, XSYSTEM86_LINE_FAULT_ENABLE_OFFSET));
	xil_printf("Base address: %x\r\n",
		XSystem86_ReadReg(RegBase, XSYSTEM86_BASEADDRESS_OFFSET));

	return;
}

/****************************************************************************/
/**
*
* Get a pointer to the Xilinx device driver instance for the specified devie
* ID. This pointer can be used to access the Xilinx PCI device driver API
* (see xpci.h).
*
* @param DeviceId is the unique device ID of the PCI device being initialized.
*
* @return
*
* A pointer to the XPci driver instance data of the specified device, or XNULL
* if no matching device is found. Note that the XPci driver is not guaranteed
* to be initialized. The user must call XPciAdapter_Init() successfully before
* calling this function to guarantee the driver is initialized.
*
* @note
*
* None.
*
*****************************************************************************/
XSystem86 *XSystem86_GetInstance(u16 DeviceId)
{
    System86Info * DeviceInfo;

    DeviceInfo = LookupDevice((Xuint16)DeviceId);
    if (DeviceInfo == NULL)
    {
        return XNULL;
    }

    return &DeviceInfo->System86;
}

int XSystem86_DeviceInitialize(u16 DeviceId)
{
	System86Info * DeviceInfoPtr;
	XStatus Result;

    /*
     * First get an AceInfo pointer for this device ID. If this device has
     * been previously initialized, we should get the same pointer.
     */
    DeviceInfoPtr = LookupDevice(DeviceId);
    if (DeviceInfoPtr == NULL)
    {
         return XST_DEVICE_NOT_FOUND;
    }
	
	Result = XSystem86_Initialize(&DeviceInfoPtr->System86, DeviceId);
	if (Result != XST_SUCCESS) {
		return Result;
	}
	
	return XST_SUCCESS;
}

u16 RegisterToBus(XSystem86_BusAttr *BusAttr, u32 RegValue)
{
	return (RegValue & BusAttr->Mask) >> BusAttr->Lsb;
}

u32 BusToRegister(XSystem86_BusAttr *BusAttr, u16 BusValue)
{
	return (BusValue << BusAttr->Lsb) & BusAttr->Mask;
}

/*****************************************************************************/
/**
*
* Look in the System86Device table for an existing device that matches the given
* DeviceId, or an empty spot in the table if no match is found. This function
* is used by every public function defined above that takes a DeviceId as
* argument.
*
* @param DeviceId   The devide ID to search for in the System86Device table
*
* @return
*
* Returns a pointer to an existing System86Info element if a match is found, or
* an unused System86Device element if no match is found. Returns NULL if no match
* is found and the System86Device array is full (i.e., all elements have been used).
*
* NOTES:
*
* Assumes that this would never be called with a Device ID of zero!!!!!
*
******************************************************************************/
static System86Info *LookupDevice(u16 DeviceId)
{
    int i;
    System86Info * UnusedPtr = NULL;       /* first unused entry */

    for (i=0; i < XPAR_XSYSTEM86_NUM_INSTANCES; i++)
    {
		if (System86Device[i].Used) 
		{
			if (DeviceId == System86Device[i].DeviceId)
			{
				/* Found a match */
				return &System86Device[i];
			}
		}
		else if (UnusedPtr == NULL)
		{
			/*
			 * Keep track of the first entry in the table that is unused. We
			 * base the unused on the number of partitions set for the device.
			 */
			UnusedPtr = &System86Device[i];
		}  
    }

    /*
     * No match was found, so if there is an unused table entry, use it,
     */
    if (UnusedPtr != NULL)
    {
		UnusedPtr->DeviceId = DeviceId;
		UnusedPtr->Used = 1;
        return UnusedPtr;
    }

    /*
     * All
	 table entries are currently used, so return null
     */
    return NULL;
}
