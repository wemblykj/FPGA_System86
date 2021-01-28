/*
 * Empty C++ Application
 */

//#include "platform.h"

//#include "xaxivdma.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"

#include "xintc.h"

/*
 * The following constants map to the names of the hardware instances that
 * were created in the EDK XPS system.  They are only defined here such that
 * a user can easily change all the needed device IDs in one place.
 */
#define LEDS_DEVICE_ID				XPAR_LEDS_8BITS_DEVICE_ID

#define BUTTONS_DEVICE_ID			XPAR_PUSH_BUTTONS_5BITS_DEVICE_ID
#define BUTTONS_INTC_INTERRUPT_ID	XPAR_MICROBLAZE_0_INTC_PUSH_BUTTONS_5BITS_IP2INTC_IRPT_INTR
#define BUTTONS_INTERRUPT_MASK	 	XPAR_PUSH_BUTTONS_5BITS_IP2INTC_IRPT_MASK

#define INTC_DEVICE_ID	XPAR_INTC_0_DEVICE_ID
#define INTC		XIntc
#define INTC_HANDLER	XIntc_InterruptHandler


#define DDR_BASE_ADDR		XPAR_S6DDR_0_S0_AXI_BASEADDR
#define DDR_HIGH_ADDR		XPAR_S6DDR_0_S0_AXI_HIGHADDR

#define BUTTONS_CHANNEL		1
#define LEDS_CHANNEL		1

/************************** Function Prototypes ******************************/

void ButtonsIsr(void *InstancePtr);

int SetupInterruptSystem();

/************************** Variable Definitions *****************************/

static XGpio ButtonsGpio; 	/* The Instance of the Buttons GPIO Driver */
static XGpio LedsGpio; 		/* The Instance of the LEDs GPIO Driver */

static XIntc Intc; /* The Instance of the Interrupt Controller Driver */

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

	Status = XGpio_Initialize(&LedsGpio, LEDS_DEVICE_ID);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

	/*
	 * Setup direction register so the switch is an input and the LED is
	 * an output of the GPIO
	 */
	XGpio_SetDataDirection(&LedsGpio, LEDS_CHANNEL, 0x0000);

	/*
	 * Perform a self-test on the GPIO.  This is a minimal test and only
	 * verifies that there is not any bus error when reading the data
	 * register
	 */
	XGpio_SelfTest(&LedsGpio);

	// Turn on all lights so that we know something is happening

	XGpio_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, 0xFFFFFFFF);
	for (u32 i = 0; i < 0xFFFFF; ++i) {
		if (i&0x10000)
		{
			XGpio_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, 0xA5A5A5A5);
		}
		else
		{
			XGpio_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, 0x5A5A5A5A);
		}
	}

	/* Initialize the GPIO driver. If an error occurs then exit */

	Status = XGpio_Initialize(&ButtonsGpio, BUTTONS_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test on the GPIO.  This is a minimal test and only
	 * verifies that there is not any bus error when reading the data
	 * register
	 */
	XGpio_SelfTest(&ButtonsGpio);

	/*
	 * Setup direction register so the switch is an input and the LED is
	 * an output of the GPIO
	 */
	XGpio_SetDataDirection(&ButtonsGpio, BUTTONS_CHANNEL, 0xFFFF);

		/*
	 * Setup the interrupts such that interrupt processing can occur. If
	 * an error occurs then exit
	 */
	Status = SetupInterruptSystem();
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XGpio_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, 0x0000);

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

	/* Hook up interrupt service routine */
	XIntc_Connect(IntcInstancePtr, BUTTONS_INTC_INTERRUPT_ID,
		      (Xil_ExceptionHandler)ButtonsIsr, &ButtonsGpio);

	/* Enable the interrupt vector at the interrupt controller */

	XIntc_Enable(IntcInstancePtr, BUTTONS_INTC_INTERRUPT_ID);

	/*
	 * Start the interrupt controller such that interrupts are recognized
	 * and handled by the processor
	 */
	Result = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Result != XST_SUCCESS) {
		return Result;
	}

	/*
	 * Enable the GPIO channel interrupts so that push button can be
	 * detected and enable interrupts for the GPIO device
	 */
	XGpio_InterruptEnable(&ButtonsGpio, BUTTONS_CHANNEL);
	XGpio_InterruptGlobalEnable(&ButtonsGpio);

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
void ButtonsIsr(void *InstancePtr)
{
	XGpio *GpioPtr = (XGpio *)InstancePtr;
	//u32 Led;
	//u32 LedState;
	u32 Buttons;
	//u32 ButtonFound;
	u32 ButtonsChanged = 0;
	static u32 PreviousButtons;

	int status = XGpio_InterruptGetStatus(GpioPtr);
	XGpio_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, status);

	/*
	 * Disable the interrupt
	 */
	XGpio_InterruptDisable(GpioPtr, BUTTONS_CHANNEL);

	/* Keep track of the number of interrupts that occur */

	//InterruptCount++;

	/*
	 * There should not be any other interrupts occurring other than the
	 * the button changes
	 */
	if ((XGpio_InterruptGetStatus(GpioPtr) & BUTTONS_CHANNEL) !=
			BUTTONS_CHANNEL) {
		return;
	}


	/*
	 * Read state of push buttons and determine which ones changed
	 * states from the previous interrupt. Save a copy of the buttons
	 * for the next interrupt
	 */
	Buttons = XGpio_DiscreteRead(GpioPtr, BUTTONS_CHANNEL);
	ButtonsChanged = Buttons ^ PreviousButtons;
	PreviousButtons = Buttons;

	/*
	 * Handle all button state changes that occurred since the last
	 * interrupt
	 */
	while (ButtonsChanged != 0) {
		XGpio_DiscreteWrite(&LedsGpio, LEDS_CHANNEL, Buttons);

		/*
		 * Determine which button changed state and then get
		 * the current state of the associated LED
		 */
		 //Led = MapButton2Led(ButtonsChanged, &ButtonFound);
		 //LedState = XGpio_DiscreteRead(GpioPtr, LED_CHANNEL) & Led;

		 /*
		  * Clear the button that is being processed so that it is
		  * done and others can be handled also
		  */
		 //ButtonsChanged &= ~ButtonFound;

		 /* Toggle the state of the LED */
		 //if (LedState) {
		//	 XGpio_DiscreteClear(GpioPtr, LED_CHANNEL, Led);
		 //} else {
		//	 XGpio_DiscreteSet(GpioPtr, LED_CHANNEL, Led);
		 //}
	 }

	 /* Clear the interrupt such that it is no longer pending in the GPIO */

	 (void)XGpio_InterruptClear(GpioPtr, BUTTONS_CHANNEL);

	 /*
	  * Enable the interrupt
	  */
	 XGpio_InterruptEnable(GpioPtr, BUTTONS_CHANNEL);

}
