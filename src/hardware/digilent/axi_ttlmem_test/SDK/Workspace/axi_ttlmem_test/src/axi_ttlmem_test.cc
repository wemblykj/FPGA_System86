/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include "platform.h"

#include "xparameters.h"

#include "xintc.h"

#include "xttlmembus.h"

#include "xil_exception.h"
#include "xil_assert.h"
#include "xil_printf.h"

#define INTC_DEVICE_ID	XPAR_INTC_0_DEVICE_ID
#define INTC			XIntc
#define INTC_HANDLER	XIntc_InterruptHandler

#define MEMBUS_ADDR_IR		XTTLMEMBUS_IR_ADDR_MASK
#define MEMBUS_READ_IR		XTTLMEMBUS_IR_ADDR_MASK
#define MEMBUS_WRITE_IR		XTTLMEMBUS_IR_READ_MASK
#define MEMBUS_ALL_IR		MEMBUS_ADDR_IR | MEMBUS_READ_IR | MEMBUS_WRITE_IR


typedef enum MemBusEventTypeTag
{
	MemBusEventType_Addr,
	MemBusEventType_Read,
	MemBusEventType_Write,
} MemBusEventType;


typedef struct MemBusEventTag
{
	u32 BaseAddress;
	MemBusEventType Type;
	u32 BusData;
} MemBusEvent;

/************************** Function Prototypes ******************************/

void TtlMemBusIsr(void *InstancePtr);

int Initialise();
int SetupInterruptSystem();

int InitialiseMemoryBus(u16 DeviceId);
int InitialiseMemoryBusses();

int SetupMemBusInterrupt(INTC *IntcInstancePtr, u16 DeviceId);
int SetupMemBusInterrupts(INTC *IntcInstancePtr);
int EnableMemBusInterrupts(INTC *IntcInstancePtr);

int GetMemBusEventQueueSize();
void PushMemBusEvent(const MemBusEvent& event);
const MemBusEvent& PopMemBusEvent();
bool TryPopMemBusEvent(MemBusEvent& event);

/************************** Variable Definitions *****************************/

static XIntc Intc; /* The Instance of the Interrupt Controller Driver */

const int MemBusEventQueueSize = 10;
MemBusEvent MemBusEventQueue[MemBusEventQueueSize];
volatile int MemBusEventQueueHead = 0;
volatile int MemBusEventQueueTail = 0;

/****************************************************************************/
/**
* This function is the main function of the GPIO example.  It is responsible
* for initializing the GPIO device, setting up interrupts and providing a
* foreground loop such that interrupt can occur in the background.
*
* @param	None.
*
* @return
*		- XST_SUCCESS to indicate success.
*		- XST_FAILURE to indicate Failure.
*
* @note		None.
*
*
*****************************************************************************/

int main()
{
	int Status;

    init_platform();

    xil_printf("Hello World\n\r");

    Status = Initialise();
    if (Status != XST_SUCCESS) {
		xil_printf("E_%08x", Status);
		return XST_FAILURE;
	}

    /*
	 * Loop forever while the button changes are handled by the interrupt
	 * level processing
	 */
	MemBusEvent event;
	while (1) {
		if (TryPopMemBusEvent(event)) {
			xil_printf("%08x: %s - %08x\r\n", event.BaseAddress, event.Type, event.BusData);
		}
	}

	cleanup_platform();

    return 0;
}

/****************************************************************************/
/**
* This function is the Interrupt Service Routine for the GPIO device.  It
* will be called by the processor whenever an interrupt is asserted by the
* device.
*
* This function will detect the push button on the board has changed state
* and then turn on or off the LED.
*
* @param	InstancePtr is the GPIO instance pointer to operate on.
*		It is a void pointer to meet the interface of an interrupt
*		processing function.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void TtlMemBusIsr(void *InstancePtr)
{
	XTtlMemBus *MemBusPtr = (XTtlMemBus *)InstancePtr;
	//u32 Led;
	//u32 LedState;
	//u32 Buttons;
	//u32 ButtonFound;
	//u32 ButtonsChanged = 0;
	//static u32 PreviousButtons;

	//int status = XTtlMemBus_InterruptGetStatus(MemBusPtr);
	//XTtlMemBus_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, status);

	/*
	 * Disable the interrupt
	 */
	XTtlMemBus_InterruptDisable(MemBusPtr, XTTLMEMBUS_IR_MASK);

	/* Keep track of the number of interrupts that occur */

	//InterruptCount++;

	/*
	 * There should not be any other interrupts occurring other than the
	 * the button changes
	 */
	u32 status = XTtlMemBus_InterruptGetStatus(MemBusPtr);
	if ((status & XTTLMEMBUS_IR_MASK) ==
			0) {
		return;
	}

	MemBusEvent event = { MemBusPtr->BaseAddress };

	if ((status & XTTLMEMBUS_IR_ADDR_MASK) == XTTLMEMBUS_IR_ADDR_MASK)
	{
		event.Type = MemBusEventType_Addr;
		event.BusData = XTtlMemBus_GetBusAddress(MemBusPtr);
	}

	if ((status & XTTLMEMBUS_IR_READ_MASK) == XTTLMEMBUS_IR_READ_MASK)
	{
		event.Type = MemBusEventType_Read;
		event.BusData = XTtlMemBus_GetBusData(MemBusPtr);
	}

	if ((status & XTTLMEMBUS_IR_WRITE_MASK) == XTTLMEMBUS_IR_WRITE_MASK)
	{
		event.Type = MemBusEventType_Write;
		event.BusData = XTtlMemBus_GetBusData(MemBusPtr);
	}

	PushMemBusEvent(event);

	/* Clear the interrupt such that it is no longer pending in the GPIO */

	(void)XTtlMemBus_InterruptClear(MemBusPtr, XTTLMEMBUS_IR_MASK);

	/*
	 * Enable the interrupt
	 */
	XTtlMemBus_InterruptEnable(MemBusPtr, XTTLMEMBUS_IR_MASK);

}


int Initialise() {
	int Status;

	Status = InitialiseMemoryBusses();
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the interrupts such that interrupt processing can occur. If
	 * an error occurs then exit
	 */
	Status = SetupInterruptSystem();
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int InitialiseMemoryBus(u16 DeviceId)
{
	int Status;
	XTtlMemBus * InstancePtr;

	Status = XTtlMemBus_DeviceInitialize(DeviceId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	InstancePtr = XTtlMemBus_GetInstance(DeviceId);
	if (InstancePtr == XNULL)
		return XST_FAILURE;

	/*
	 * Perform a self-test on the IP.  This is a minimal test and only
	 * verifies that there is not any bus error when reading the data
	 * register
	 */
	XTtlMemBus_SelfTest(InstancePtr);

	return XST_SUCCESS;
}

int InitialiseMemoryBusses()
{
	int Status;
	int i;
	extern XTtlMemBus_Config XTtlMemBus_ConfigTable[];

	for (i = 0; i < XPAR_XTTLMEMBUS_NUM_INSTANCES; i++) {
		Status = InitialiseMemoryBus(XTtlMemBus_ConfigTable[i].DeviceId);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}
	}

	return XST_SUCCESS;
}

/****************************************************************************/
/**
* This function sets up the interrupt system for the example.  The processing
* contained in this funtion assumes the hardware system was built with
* and interrupt controller.
*
* @param	None.
*
* @return	A status indicating XST_SUCCESS or a value that is contained in
*		xstatus.h.
*
* @note		None.
*
*****************************************************************************/
int SetupInterruptSystem()
{
	int Result;
	INTC *IntcInstancePtr = &Intc;

	/*
	 * Initialize the interrupt controller driver so that it's ready to use.
	 * specify the device ID that was generated in xparameters.h
	 */
	Result = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	Result = SetupMemBusInterrupts(IntcInstancePtr);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	/*
	 * Start the interrupt controller such that interrupts are recognized
	 * and handled by the processor
	 */
	Result = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	Result = EnableMemBusInterrupts(IntcInstancePtr);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	/*
	 * Initialize the exception table and register the interrupt
	 * controller handler with the exception table
	 */
	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)INTC_HANDLER, IntcInstancePtr);

	/* Enable non-critical exceptions */
	Xil_ExceptionEnable();

	return XST_SUCCESS;
}

int SetupMemBusInterrupt(INTC *IntcInstancePtr, u16 DeviceId)
{
	Xil_AssertNonvoid(IntcInstancePtr != NULL);
	Xil_AssertNonvoid(IntcInstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	XTtlMemBus * InstancePtr;

	InstancePtr = XTtlMemBus_GetInstance(DeviceId);
	if (InstancePtr == XNULL)
		return XST_FAILURE;

	XIntc_Connect(IntcInstancePtr, DeviceId,
				(Xil_ExceptionHandler)TtlMemBusIsr, &InstancePtr);

	XIntc_Enable(IntcInstancePtr, DeviceId);

	return XST_SUCCESS;
}

int SetupMemBusInterrupts(INTC *IntcInstancePtr)
{
	Xil_AssertNonvoid(IntcInstancePtr != NULL);
	Xil_AssertNonvoid(IntcInstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	SetupMemBusInterrupt(IntcInstancePtr, XPAR_TEST_ROM_DEVICE_ID);
	SetupMemBusInterrupt(IntcInstancePtr, XPAR_TEST_RAM_DEVICE_ID);

	return XST_SUCCESS;
}

int EnableMemBusInterrupt(INTC *IntcInstancePtr, u16 DeviceId)
{
	Xil_AssertNonvoid(IntcInstancePtr != NULL);
	Xil_AssertNonvoid(IntcInstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertNonvoid(IntcInstancePtr->IsStarted == XIL_COMPONENT_IS_STARTED);

	XTtlMemBus * InstancePtr;

	InstancePtr = XTtlMemBus_GetInstance(DeviceId);
	if (InstancePtr == XNULL)
		return XST_FAILURE;

	XTtlMemBus_InterruptEnable(InstancePtr, MEMBUS_ALL_IR);
	XTtlMemBus_InterruptGlobalEnable(InstancePtr);

	return XST_SUCCESS;
}

int EnableMemBusInterrupts(INTC *IntcInstancePtr)
{
	Xil_AssertNonvoid(IntcInstancePtr != NULL);
	Xil_AssertNonvoid(IntcInstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	Xil_AssertNonvoid(IntcInstancePtr->IsStarted == XIL_COMPONENT_IS_STARTED);

	/*
	 * Enable the various TtlMemBus interrupts so that memory access can be
	 * detected and enable interrupts for the TtlMemBus device
	 */
	EnableMemBusInterrupt(IntcInstancePtr, XPAR_TEST_ROM_DEVICE_ID);
	EnableMemBusInterrupt(IntcInstancePtr, XPAR_TEST_RAM_DEVICE_ID);


	return XST_SUCCESS;
}

int GetMemBusEventQueueSize()
{
	return (MemBusEventQueueHead - MemBusEventQueueTail) % MemBusEventQueueSize;
}

void PushMemBusEvent(const MemBusEvent& event)
{
	MemBusEventQueue[MemBusEventQueueHead] = event;
	MemBusEventQueueHead = (MemBusEventQueueHead + 1) % MemBusEventQueueSize;
}

const MemBusEvent& PopMemBusEvent()
{
	MemBusEvent& event = MemBusEventQueue[MemBusEventQueueTail];
	MemBusEventQueueTail = (MemBusEventQueueTail + 1) % MemBusEventQueueSize;

	return event;
}

bool TryPopMemBusEvent(MemBusEvent& event)
{
	if (GetMemBusEventQueueSize() > 0)
	{
		event = PopMemBusEvent();
		return true;
	}

	return false;
}
