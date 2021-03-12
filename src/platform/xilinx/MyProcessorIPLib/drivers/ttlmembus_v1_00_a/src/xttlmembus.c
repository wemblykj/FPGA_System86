/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

/***************************** Include Files ********************************/

#include "xttlmembus.h"
#include "xstatus.h"

/************************** Constant Definitions ****************************/

/**************************** Type Definitions ******************************/

/***************** Macros (Inline Functions) Definitions ********************/

/************************** Variable Definitions ****************************/


/************************** Function Prototypes *****************************/

u16 RegisterToBus(XTtlMemBus_BusAttr *BusAttr, u32 RegValue);
u32 BusToRegister(XTtlMemBus_BusAttr *BusAttr, u16 BusValue);

/****************************************************************************/
/**
* Initialize the XTtlMemBus instance provided by the caller based on the
* given configuration data.
*
* Nothing is done except to initialize the InstancePtr.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance. The memory the
*		pointer references must be pre-allocated by the caller. Further
*		calls to manipulate the driver through the XTtlMemBus API must be
*		made with this pointer.
* @param	Config is a reference to a structure containing information
*		about a specific TTLMEMBUS device. This function initializes an
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
int XTtlMemBus_CfgInitialize(XTtlMemBus * InstancePtr, XTtlMemBus_Config * Config,
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
	int ctrlWidth = InstancePtr->CtrlBusAttr.Width;
	InstancePtr->CtrlBusAttr.Width = (Config->ReadOnly == TRUE) ? 3 : 2;
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
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_WriteRegMasked(XTtlMemBus *InstancePtr, u32 RegOffset, u32 Data, u32 Mask)
{
	Xil_AssertVoid(InstancePtr != NULL);

	u32 value = XTtMemBus_ReadReg(InstancePtr->BaseAddress);
	value &= ~Mask;
	value |= (value & Mask);

	XTtlMemBus_WriteReg(InstancePtr->BaseAddress, RegOffset, value);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
int XTtlMemBus_GetSupportsDynamicMapping(XTtlMemBus *InstancePtr)
{
	return InstancePtr->SupportsDynamicMapping;
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XTtlMemBus_GetStatus(XTtlMemBus *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_SR_OFFSET);
}

/****************************************************************************/
/**
* Get whether the memory bus is running.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
int XTtlMemBus_GetEnabled(XTtlMemBus *InstancePtr)
{
	u32 status = XTtlMemBus_GetStatus(InstancePtr);
	
	return (status & XTTLMEMBUS_SR_RUNNING_MASK) == XTTLMEMBUS_SR_RUNNING_MASK;
}
	
/****************************************************************************/
/**
* Start the memory bus running.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return
*		- XST_SUCCESS for success
*		- XST_FAILURE for failure to start
*
*****************************************************************************/
int XTtlMemBus_Start(XTtlMemBus *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	u32 control = XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_CR_OFFSET);
	control = control | XTTLMEMBUS_CR_ENABLE_MASK;
	
	XTtlMemBus_WriteReg(InstancePtr->BaseAddress, XTTLMEMBUS_CR_OFFSET, control);
	
	if (!XTtlMemBus_GetEnabled(InstancePtr))
		return (XST_FAILURE);
		
	return (XST_SUCCESS);
}

/****************************************************************************/
/**
* Stop the memory bus from running.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
*****************************************************************************/
void XTtlMemBus_Stop(XTtlMemBus *InstancePtr)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	u32 control = XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_CR_OFFSET);
	control = control & ~XTTLMEMBUS_CR_ENABLE_MASK;
	
	XTtlMemBus_WriteReg(InstancePtr->BaseAddress, XTTLMEMBUS_CR_OFFSET, control);
	
	Xil_AssertVoid(!XTtlMemBus_GetEnabled(InstancePtr));
		
	return;
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetBaseAddress(XTtlMemBus * InstancePtr, u32 BaseAddress)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertVoid(InstancePtr->SupportsDynamicMapping == TRUE);

	XTtlMemBus_WriteReg(InstancePtr->BaseAddress, XTTLMEMBUS_BASEADDRESS_OFFSET, BaseAddress);
}

/****************************************************************************/
/**
* Get the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The base address on the AXI bus to which the memory bus is mapped.
*
* @note
*
* If the hardware is not configured for dynamic mapping then the hardware configured base address will always be returned.
*
*****************************************************************************/
u32 XTtlMemBus_GetBaseAddress(XTtlMemBus *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_BASEADDRESS_OFFSET);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XTtlMemBus_GetErrors(XTtlMemBus *InstancePtr)
{
	u32 status = XTtlMemBus_GetStatus(InstancePtr);
	
	return (status & XTTLMEMBUS_SR_ERR_ALL_MASK) >> XTTLMEMBUS_SR_ERR_ALL_LSB;
}

/****************************************************************************/
/**
* Set the tate of the entire TTL memory bus.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	BusRegValue is the state to which the entire TTL bus will be set.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetMemBusState(XTtlMemBus *InstancePtr, u32 BusRegValue, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	XTtlMemBus_WriteRegMasked(InstancePtr, XTTLMEMBUS_BUS_OFFSET, BusRegValue, BusMask);
}

/****************************************************************************/
/**
* Get the state of the entire TTL memory bus.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The value of the bus state.
*
*****************************************************************************/
u32 XTtlMemBus_GetMemBusState(XTtlMemBus *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_BUS_OFFSET);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_WriteBus(XTtlMemBus *InstancePtr, u32 RegOffset, XTtlMemBus_BusAttr *Attr, u16 BusValue)
{
	Xil_AssertVoid(InstancePtr != NULL);

	u32 busRegValue = BusToRegister(Attr, BusValue);
	XTtlMemBus_WriteRegMasked(InstancePtr, RegOffset, busRegValue, Attr->Mask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
u16 XTtlMemBus_ReadBus(XTtlMemBus *InstancePtr, u32 RegOffset, XTtlMemBus_BusAttr *Attr)
{
	Xil_AssertVoid(InstancePtr != NULL);

	u32 reg = XTtlMemBus_ReadReg(InstancePtr->BaseAddress, RegOffset);
	return RegisterToBus(Attr, reg); 
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetBusAddress(XTtlMemBus *InstancePtr, u32 BusAddress)
{
	WriteBus(InstancePtr, XTTLMEMBUS_BUS_OFFSET, InstancePtr->AddrBusAttr, BusAddress);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XTtlMemBus_GetBusAddress(XTtlMemBus *InstancePtr)
{
	return ReadBus(InstancePtr, XTTLMEMBUS_BUS_OFFSET, InstancePtr->AddrBusAttr);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetBusData(XTtlMemBus *InstancePtr, u32 BusData)
{
	WriteBus(InstancePtr, XTTLMEMBUS_BUS_OFFSET, InstancePtr->DataBusAttr, BusData);
}

/****************************************************************************/
/**
* Get the error status.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
*
* @return	The error flags.
*
*****************************************************************************/
u32 XTtlMemBus_GetBusData(XTtlMemBus *InstancePtr)
{
	return ReadBus(InstancePtr, XTTLMEMBUS_BUS_OFFSET, InstancePtr->DataBusAttr);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetBusFaultValue(XTtlMemBus *InstancePtr, u32 FaultValue, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	XTtlMemBus_WriteRegMasked(InstancePtr, XTTLMEMBUS_LINE_FAULT_VALUE_OFFSET, FaultValue, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
u32 XTtlMemBus_GetBusFaultValue(XTtlMemBus *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_LINE_FAULT_VALUE_OFFSET);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetBusFaultEnabled(XTtlMemBus *InstancePtr, u32 FaultEnable, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	XTtlMemBus_WriteRegMasked(InstancePtr, XTTLMEMBUS_LINE_FAULT_ENABLE_OFFSET, FaultEnable, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
u32 XTtlMemBus_GetBusFaultEnabled(XTtlMemBus *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	
	return XTtlMemBus_ReadReg(InstancePtr->BaseAddress, XTTLMEMBUS_LINE_FAULT_ENABLE_OFFSET);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetBusFault(XTtlMemBus *InstancePtr, u32 Value, u32 BusMask)
{
	Xil_AssertVoid(InstancePtr != NULL);

	XTtlMemBus_SetBusFaultValue(InstancePtr, Value, BusMask);
	XTtlMemBus_EnableBusFault(InstancePtr, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_EnableBusFault(XTtlMemBus *InstancePtr, u32 BusMask)
{
	XTtlMemBus_SetBusFaultEnabled(InstancePtr, BusMask, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_DisableBusFault(XTtlMemBus *InstancePtr, u32 BusMask)
{
	XTtlMemBus_SetBusFaultEnabled(InstancePtr, 0, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_ClearBusFault(XTtlMemBus *InstancePtr, u32 BusMask)
{
	XTtMemBus_DisableBusFault(InstancePtr, BusMask);
	XTtlMemBus_SetBusFaultValue(InstancePtr, 0, BusMask);
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetWriteEnableFault(XTtlMemBus *InstancePtr, int Logic)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_ClearWriteEnableFault(XTtlMemBus *InstancePtr)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetOutputEnableFault(XTtlMemBus *InstancePtr, int Logic)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_ClearOutputEnableFault(XTtlMemBus *InstancePtr)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetAddressFault(XTtlMemBus *InstancePtr, u32 Address, u32 BusMask)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_ClearAddressFault(XTtlMemBus *InstancePtr, u32 BusMask)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
* @param	BusMask specifies with parts of the bus state will be affected and changed
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_SetDataFault(XTtlMemBus *InstancePtr, u32 BusData, u32 BusMask)
{
}

/****************************************************************************/
/**
* Set the base address on the AXI bus to which the memory bus is mapped.
*
* @param	InstancePtr is a pointer to an XTtlMemBus instance to be worked on.
* @param	The base address on the AXI bus to which the memory bus is to be mapped.
*
* @return	None.
*
* @note		The hardware must be built for dynamic mapping otherwise this
*		function will assert.
*
*****************************************************************************/
void XTtlMemBus_ClearDataFault(XTtlMemBus *InstancePtr, u32 BusMask)
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
void XTtlMemBus_DumpRegisters(XTtlMemBus *InstancePtr)
{
	u32 RegBase;

	RegBase = InstancePtr->BaseAddress;

	xil_printf("Dump registers:\r\n");
	xil_printf("Control register: %x\r\n",
		XTtlMemBus_ReadReg(RegBase, XTTLMEMBUS_CR_OFFSET));
	xil_printf("Status register: %x\r\n",
		XTtlMemBus_ReadReg(RegBase, XTTLMEMBUS_SR_OFFSET));
	xil_printf("Bus register: %x\r\n",
		XTtlMemBus_ReadReg(RegBase, XTTLMEMBUS_BUS_OFFSET));
	xil_printf("Fault value register: %x\r\n",
		XTtlMemBus_ReadReg(RegBase, XTTLMEMBUS_LINE_FAULT_VALUE_OFFSET));
	xil_printf("Fault enable register: %x\r\n",
		XTtlMemBus_ReadReg(RegBase, XTTLMEMBUS_LINE_FAULT_ENABLE_OFFSET));
	xil_printf("Base address: %x\r\n",
		XTtlMemBus_ReadReg(RegBase, XTTLMEMBUS_BASEADDRESS_OFFSET));

	return;
}

u16 RegisterToBus(XTtlMemBus_BusAttr *BusAttr, u32 RegValue)
{
	return (RegValue & BusAttr->Mask) >> BusAttr->Lsb;
}

u32 BusToRegister(XTtlMemBus_BusAttr *BusAttr, u16 BusValue)
{
	return (BusValue << BusAttr->Lsb) & BusAttr->Mask;
}
