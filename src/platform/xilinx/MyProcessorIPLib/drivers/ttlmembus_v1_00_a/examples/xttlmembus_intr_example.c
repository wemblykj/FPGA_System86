/******************************************************************************
*
* (c) Copyright 2002-2013 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
******************************************************************************/
/*****************************************************************************/
/**
* @file xttlmembus_intr_example.c
*
* This file contains a design example using the TTLMEMBUS driver (XTtlMemBus) in an
* interrupt driven mode of operation. This example does assume that there is
* an interrupt controller in the hardware system and the TTLMEMBUS device is
* connected to the interrupt controller.
*
* This example is designed to work on the Xilinx ML300 board using the PowerPC
* 405 processor present in the VirtexIIPro device. The example uses the
* interrupt capability of the TTLMEMBUS to detect push button presses and control the
* LEDs on the board. When a button is pressed it will turn on and LED located
* closest to it. When the button is released it will turn off the LED.
* This examples uses two channels of a TTLMEMBUS such that it is necessary to have
* dual channel capabilities.
*
* The buttons and LEDs are on 2 seperate channels of the TTLMEMBUS so that interrupts
* are not caused when the LEDs are turned on and off.
*
* At the start of execution all LEDs will be turned on, then each one by itself,
* and then all on again followed by all turned off. After this sequence, button
* presses are processed by interrupts.
*
* The following snippet from the UCF file of the hardware build indicates the
* way the TTLMEMBUS channels are connected to the ML300 for the LEDs and buttons.
*
*<pre>
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<0> LOC=C4;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<1> LOC=L8;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<2> LOC=F8;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<3> LOC=J7;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<4> LOC=K7;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<5> LOC=E7;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<6> LOC=D3;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<7> LOC=C6;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<8> LOC=E8;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<9> LOC=B3;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<10> LOC=E9;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<11> LOC=G9;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<12> LOC=A3;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<13> LOC=F9;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<14> LOC=D6;
* Net LEDs_Push_Buttons_TTLMEMBUS_IO<15> LOC=G10;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<0> LOC=G6;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<1> LOC=L7;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<2> LOC=G5;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<3> LOC=M8;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<4> LOC=H6;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<5> LOC=M7;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<6> LOC=H5;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<7> LOC=N8;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<8> LOC=J6;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<9> LOC=M5;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<10> LOC=J5;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<11> LOC=M2;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<12> LOC=K6;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<13> LOC=M1;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<14> LOC=K5;
* Net LEDs_Push_Buttons_TTLMEMBUS2_IO<15> LOC=P6;
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date	 Changes
* ----- ---- -------- -----------------------------------------------
* 2.00a jhl  12/01/03 First release
* 2.00a sv   04/15/05 Minor changes to comply to Doxygen and coding guidelines
* 3.00a ktn  11/21/09 Updated to use HAL Processor APIs and minior changes
*		      as per coding guidelines.
* 3.00a sdm  02/16/11 Updated to support ARM Generic Interrupt Controller
*</pre>
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xttlmembus.h"
#include "xil_exception.h"

#ifdef XPAR_INTC_0_DEVICE_ID
 #include "xintc.h"
#else
 #include "xscugic.h"
#endif

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the names of the hardware instances that
 * were created in the EDK XPS system.  They are only defined here such that
 * a user can easily change all the needed device IDs in one place.
 */
#define TTLMEMBUS_DEVICE_ID		XPAR_PUSH_BUTTONS_4BITS_DEVICE_ID
#define INTC_TTLMEMBUS_INTERRUPT_ID	XPAR_INTC_0_TTLMEMBUS_2_VEC_ID

#ifdef XPAR_INTC_0_DEVICE_ID
 #define INTC_DEVICE_ID	XPAR_INTC_0_DEVICE_ID
 #define INTC		XIntc
 #define INTC_HANDLER	XIntc_InterruptHandler
#else
 #define INTC_DEVICE_ID	XPAR_SCUGIC_SINGLE_DEVICE_ID
 #define INTC		XScuGic
 #define INTC_HANDLER	XScuGic_InterruptHandler
#endif

/*
 * The following constants define the positions of the buttons and LEDs each
 * channel of the TTLMEMBUS
 */
#define TTLMEMBUS_ALL_LEDS		0xFFFF
#define TTLMEMBUS_ALL_BUTTONS	0xFFFF

/*
 * The following constants define the TTLMEMBUS channel that is used for the buttons
 * and the LEDs. They allow the channels to be reversed easily.
 */
#define BUTTON_CHANNEL	 1	/* Channel 1 of the TTLMEMBUS Device */
#define LED_CHANNEL	 2	/* Channel 2 of the TTLMEMBUS Device */
#define BUTTON_INTERRUPT XTTLMEMBUS_IR_CH1_MASK  /* Channel 1 Interrupt Mask */


/*
 * The following constant is used to wait after an LED is turned on to make
 * sure that it is visible to the human eye.  This constant might need to be
 * tuned for faster or slower processor speeds.
 */
#define LED_DELAY	 1000000

/**************************** Type Definitions *******************************/

typedef struct
{
	u32 ButtonMask;	 /* The bit corresponding to the button */
	u32 LedMask;	 /* The bit corresponding to the LED */
} MapButtonTable;

/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

int MapButton2Led(u32 Buttons, u32 *ButtonFoundPtr);

void SequenceLeds();

void TtlMemBusIsr(void *InstancePtr);

int SetupInterruptSystem();

/************************** Variable Definitions *****************************/

/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger
 */
static XTtlMemBus TtlMemBus; /* The Instance of the TTLMEMBUS Driver */

static INTC Intc; /* The Instance of the Interrupt Controller Driver */

volatile int InterruptCount; /* Count of interrupts that have occured */


/*
 * The following table contains the masks for the buttons and LEDS
 * that are connected on the board. It's purpose is to map a button
 * to a specific LED.
 */
 MapButtonTable Button2LedTable[] =
	{ { 0x1, 0x1 },
	  { 0x2, 0x2 },
	  { 0x4, 0x4 },
	  { 0x8, 0x8 },
	  { 0x10, 0x8 },
	  { 0x20, 0x8 },
	  { 0x40, 0x8 },
	  { 0x100, 0x10 },
	  { 0x200, 0x20 },
	  { 0x400, 0x40 },
	  { 0x800, 0x80 },
	  { 0x1000, 0x80 },
	  { 0x2000, 0x80 },
	  { 0x4000, 0x80 } };

/****************************************************************************/
/**
* This function is the main function of the TTLMEMBUS example.  It is responsible
* for initializing the TTLMEMBUS device, setting up interrupts and providing a
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
int main(void)
{
	int Status;

	/* Initialize the TTLMEMBUS driver. If an error occurs then exit */

	Status = XTtlMemBus_Initialize(&TtlMemBus, TTLMEMBUS_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test on the TTLMEMBUS.  This is a minimal test and only
	 * verifies that there is not any bus error when reading the data
	 * register
	 */
	XTtlMemBus_SelfTest(&TtlMemBus);

	/*
	 * Setup direction register so the switch is an input and the LED is
	 * an output of the TTLMEMBUS
	 */
	XTtlMemBus_SetDataDirection(&TtlMemBus, BUTTON_CHANNEL, TTLMEMBUS_ALL_BUTTONS);
	XTtlMemBus_SetDataDirection(&TtlMemBus, LED_CHANNEL, ~TTLMEMBUS_ALL_LEDS);

	/* Sequence the LEDs to show this example is starting to run */

	SequenceLeds();

	/*
	 * Setup the interrupts such that interrupt processing can occur. If
	 * an error occurs then exit
	 */
	Status = SetupInterruptSystem();
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Loop forever while the button changes are handled by the interrupt
	 * level processing
	 */
	while (1) {
	}

	return XST_SUCCESS;
}

/****************************************************************************/
/**
* This function sequences the LEDs by turning them all on, the turning each
* one on individually, then turning them all on, and finally off.
*
* @param	None.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void SequenceLeds()
{
	u32 Mask = 0x8000;
	int Led;
	volatile int Delay;

	/* Turn on all the LEDS to show starting the sequence */

	XTtlMemBus_DiscreteWrite(&TtlMemBus, LED_CHANNEL, TTLMEMBUS_ALL_LEDS);
	for (Delay = 0; Delay < LED_DELAY; Delay++);

	/* Sequence thru turning each LED on one at a time */

	for (Led = 1; Led <= 16; Led++) {
		XTtlMemBus_DiscreteWrite(&TtlMemBus, LED_CHANNEL, Mask);
		Mask >>= 1;

		/* Wait a small amount of time so the LED is visible */

		for (Delay = 0; Delay < LED_DELAY; Delay++);
	}

	/* Turn on all LEDS to show stopping the sequence */

	XTtlMemBus_DiscreteWrite(&TtlMemBus, LED_CHANNEL, TTLMEMBUS_ALL_LEDS);
	for (Delay = 0; Delay < LED_DELAY; Delay++);

	/* Turn off all the LEDs */

	XTtlMemBus_DiscreteWrite(&TtlMemBus, LED_CHANNEL, 0);

	XTtlMemBus_InterruptClear(&TtlMemBus, XTTLMEMBUS_IR_MASK);
}

/****************************************************************************/
/**
* This function maps each button on the board to an LED.
*
* @param	Buttons contains the buttons that have changed.
* @param	ButtonFoundPtr is a pointer to allow this function to indicate
*		the button that was associated with the returned LED. This
*		input is needed to allow muliple buttons to change
*		simulataneously.
*
* @return
*
* The Led that is associated with the first button that was found to be
* changed.  A value of zero indicates no LED was found.
*
* @note		None.
*
*****************************************************************************/
int MapButton2Led(u32 Buttons, u32 *ButtonFoundPtr)
{
	int Index;

	/* Look thru the table to map the button to an LED */

	for (Index = 0; Index < sizeof(Button2LedTable)/ sizeof(MapButtonTable);
		Index++) {

		/*
		 * Determine which LED corresponds to the button being careful
		 * because more than one button could have changed
		 */
		if (Button2LedTable[Index].ButtonMask ==
			(Buttons & Button2LedTable[Index].ButtonMask)) {
			/*
			 * If the button was found then return the
			 * associated LED
			 */
			*ButtonFoundPtr = Button2LedTable[Index].ButtonMask;
			return Button2LedTable[Index].LedMask;
		}
	}

	/* If no button was found in the table, then indicate no LED */

	return 0;
}

/****************************************************************************/
/**
* This function is the Interrupt Service Routine for the TTLMEMBUS device.  It
* will be called by the processor whenever an interrupt is asserted by the
* device.
*
* This function will detect the push button on the board has changed state
* and then turn on or off the LED.
*
* @param	InstancePtr is the TTLMEMBUS instance pointer to operate on.
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
	XTtlMemBus *TtlMemBusPtr = (XTtlMemBus *)InstancePtr;
	u32 Led;
	u32 LedState;
	u32 Buttons;
	u32 ButtonFound;
	u32 ButtonsChanged = 0;
	static u32 PreviousButtons;

	/*
	 * Disable the interrupt
	 */
	XTtlMemBus_InterruptDisable(TtlMemBusPtr, BUTTON_INTERRUPT);

	/* Keep track of the number of interrupts that occur */

	InterruptCount++;

	/*
	 * There should not be any other interrupts occuring other than the
	 * the button changes
	 */
	if ((XTtlMemBus_InterruptGetStatus(TtlMemBusPtr) & BUTTON_INTERRUPT) !=
		BUTTON_INTERRUPT) {
		return;
	}


	/*
	 * Read state of push buttons and determine which ones changed
	 * states from the previous interrupt. Save a copy of the buttons
	 * for the next interrupt
	 */
	Buttons = XTtlMemBus_DiscreteRead(TtlMemBusPtr, BUTTON_CHANNEL);
	ButtonsChanged = Buttons ^ PreviousButtons;
	PreviousButtons = Buttons;

	/*
	 * Handle all button state changes that occurred since the last
	 * interrupt
	 */
	while (ButtonsChanged != 0) {
		/*
		 * Determine which button changed state and then get
		 * the current state of the associated LED
		 */
		 Led = MapButton2Led(ButtonsChanged, &ButtonFound);
		 LedState = XTtlMemBus_DiscreteRead(TtlMemBusPtr, LED_CHANNEL) & Led;

		 /*
		  * Clear the button that is being processed so that it is
		  * done and others can be handled also
		  */
		 ButtonsChanged &= ~ButtonFound;

		 /* Toggle the state of the LED */
		 if (LedState) {
			 XTtlMemBus_DiscreteClear(TtlMemBusPtr, LED_CHANNEL, Led);
		 } else {
			 XTtlMemBus_DiscreteSet(TtlMemBusPtr, LED_CHANNEL, Led);
		 }
	 }

	 /* Clear the interrupt such that it is no longer pending in the TTLMEMBUS */

	 (void)XTtlMemBus_InterruptClear(TtlMemBusPtr, BUTTON_INTERRUPT);

	 /*
	  * Enable the interrupt
	  */
	 XTtlMemBus_InterruptEnable(TtlMemBusPtr, BUTTON_INTERRUPT);

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

#ifdef XPAR_INTC_0_DEVICE_ID
	/*
	 * Initialize the interrupt controller driver so that it's ready to use.
	 * specify the device ID that was generated in xparameters.h
	 */
	Result = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	/* Hook up interrupt service routine */
	XIntc_Connect(IntcInstancePtr, INTC_TTLMEMBUS_INTERRUPT_ID,
		      (Xil_ExceptionHandler)TtlMemBusIsr, &TtlMemBus);

	/* Enable the interrupt vector at the interrupt controller */

	XIntc_Enable(IntcInstancePtr, INTC_TTLMEMBUS_INTERRUPT_ID);

	/*
	 * Start the interrupt controller such that interrupts are recognized
	 * and handled by the processor
	 */
	Result = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Result != XST_SUCCESS) {
		return Result;
	}

#else
	XScuGic_Config *IntcConfig;

	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Result = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Result != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XScuGic_SetPriorityTriggerType(IntcInstancePtr, INTC_TTLMEMBUS_INTERRUPT_ID,
					0xA0, 0x3);

	/*
	 * Connect the interrupt handler that will be called when an
	 * interrupt occurs for the device.
	 */
	Result = XScuGic_Connect(IntcInstancePtr, INTC_TTLMEMBUS_INTERRUPT_ID,
				 (Xil_ExceptionHandler)TtlMemBusIsr, &TtlMemBus);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	/*
	 * Enable the interrupt for the TTLMEMBUS device.
	 */
	XScuGic_Enable(IntcInstancePtr, INTC_TTLMEMBUS_INTERRUPT_ID);
#endif

	/*
	 * Enable the TTLMEMBUS channel interrupts so that push button can be
	 * detected and enable interrupts for the TTLMEMBUS device
	 */
	XTtlMemBus_InterruptEnable(&TtlMemBus, BUTTON_INTERRUPT);
	XTtlMemBus_InterruptGlobalEnable(&TtlMemBus);

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
