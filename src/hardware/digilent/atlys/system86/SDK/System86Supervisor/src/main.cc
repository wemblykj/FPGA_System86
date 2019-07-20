/*
 * Empty C++ Application
 */

#include "AxiHdmi.h"
#include "TestPatternGenerator.h"

#include <stdio.h>
#include "platform.h"  		//Contains Cache initializing function
#include "xparameters.h"  	//The hardware configuration describing constants
#include "xgpio.h"      	//GPIO API functions
#include "xintc.h"      	//Interrupt Controller API functions
#include "mb_interface.h" 	//Contains the functions for registering the
                          	//interrupt controller with the microblaze MP

/* ------------------------------------------------------------ */
/*					Constant Definitions						*/
/* ------------------------------------------------------------ */

#define lDeBncCntMax (XPAR_MICROBLAZE_0_FREQ / 75) //number of cycles to wait
#define lBtnChannel	1//GPIO channel of the push buttons

/*
 * These constants refer to the configuration of the hdmi_out core parameters.
 */
#define pFrame 0x49000000 //frame base address
#define xcoFrameMax 1280  //frame width
#define ycoFrameMax 720   //frame height
#define lLineStride 0x800  //line stride

/*
 * hdmi_in bit definitions
 */
#define bitHdmiEn 0x00000001

/*
 * IIC bit definitions
 */
#define bitAasFlag 0x00000020
#define bitTxEmptyFlag 0x00000004
#define bitTxDoneFlag 0x00000002

/*
 * Push Button bit definitions
 */
#define bitBtnC 0x00000010
#define bitBtnR 0x00000008
#define bitBtnD 0x00000004
#define bitBtnL 0x00000002
#define bitBtnU 0x00000001

/*
 * IIC Register offsets
 */
#define bIicGIE 0x001C
#define bIicISR 0x0020
#define bIicIER 0x0028
#define bIicCR  0x0100
#define bIicSR  0x0104
#define bIicTX  0x0108
#define bIicRX  0x010C
#define bIicADR 0x0110
#define bIicTXOCY 0x0114


/*
 * HDMI Transmitter register offsets
 */
#define bHdmiOutRes 0x00

/*
 * EDID array definition. Changing these values changes the EDID
 * packet that is sent over the E-DDC wires. It contains information on which
 * resolutions the device supports. Currently, this packet provides fairly
 * generic resolution support. Note that using resolutions with widths larger
 * than the line stride of the hdmi_output core results in a choppy picture.
 */
/* I think EDID is handled by the AXI HDMI implementation
static const u8 rgbEdid[256] =
{0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00,0x11,0x27,0x00,0x00,0x00,0x00,0x00,0x00,
 0x2C,0x15,0x01,0x03,0x80,0x26,0x1E,0x78,0x2A,0xE5,0xC5,0xA4,0x56,0x4A,0x9C,0x23,
 0x12,0x50,0x54,0xBF,0xEF,0x80,0x8B,0xC0,0x95,0x00,0x95,0x0F,0x81,0x80,0x81,0x40,
 0x81,0xC0,0x71,0x4F,0x61,0x4F,0x6B,0x35,0xA0,0xF0,0x51,0x84,0x2A,0x30,0x60,0x98,
 0x36,0x00,0x78,0x2D,0x11,0x00,0x00,0x1C,0x00,0x00,0x00,0xFD,0x00,0x38,0x4B,0x1F,
 0x50,0x0E,0x0A,0x0A,0x20,0x20,0x20,0x20,0x20,0x20,0x00,0x00,0x00,0xFC,0x00,0x41,
 0x54,0x4C,0x59,0x53,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00,0x00,0x00,0xFE,
 0x00,0x44,0x49,0x47,0x49,0x4C,0x45,0x4E,0x54,0x52,0x4F,0x43,0x4B,0x53,0x00,0x12};
*/

/* ------------------------------------------------------------ */
/*					Procedure Declarations						*/
/* ------------------------------------------------------------ */

void PushBtnHandler(void *CallBackRef);
//void IicHandler(void *CallBackRef);

/* ------------------------------------------------------------ */
/* ------------------------------------------------------------ */
/*				XPAR Constants									*/
/* ------------------------------------------------------------ */
/* All constants used from xparameters.h are located here so 	*/
/* that they may be easily accessed.							*/
/**/

#define IIC_BASEADDR XPAR_INTC_0_BASEADDR
#define INTC_DEVICE_ID XPAR_INTC_0_DEVICE_ID

#define BTNS_BASEADDR XPAR_PUSH_BUTTONS_5BITS_BASEADDR
#define BTNS_DEVICE_ID XPAR_PUSH_BUTTONS_5BITS_DEVICE_ID
#define BTNS_IRPT_ID XPAR_MICROBLAZE_0_INTC_PUSH_BUTTONS_5BITS_IP2INTC_IRPT_INTR

#define LEDS_BASEADDR XPAR_LEDS_8BITS_BASEADDR
#define LEDS_DEVICE_ID XPAR_LEDS_8BITS_DEVICE_ID

//#define IIC_IRPT_ID XPAR_AXI_INTC_0_XPS_IIC_0_IIC2INTC_IRPT_INTR
#define HDMIOUT_BASEADDR XPAR_AXI_HDMI_0_BASEADDR

/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

volatile u32 lBtnStateOld;
//volatile int ibEdid;
volatile int lDeBncCnt;

/* ------------------------------------------------------------ */
/*				Procedure Definitions							*/
/* ------------------------------------------------------------ */

int main()
{
	init_platform();

	static XGpio ledsCtrl;
	static XGpio pshBtns;
	static XIntc intCtrl;

	//ibEdid = 0;
	lBtnStateOld = 0x00000000;
	lDeBncCnt = lDeBncCntMax;

	/*
	 *Initialize the driver structs for the LEDs
	 */
	XGpio_Initialize(&ledsCtrl, LEDS_DEVICE_ID);
	Xil_Out32(LEDS_BASEADDR, 0x00000001);  // Set first LED

	/*
	 *Initialize the driver structs for the Push button and interrupt cores.
	 *This allows the API functions to be used with these cores.
	 */
	XGpio_Initialize(&pshBtns, BTNS_DEVICE_ID);
	//XIntc_Initialize(&intCtrl, INTC_DEVICE_ID);


	/*
	 * Connect the function PushBtnHandler to the interrupt controller so that
	 * it is called whenever the Push button GPIO core signals an interrupt.
	 */
	XIntc_Connect(&intCtrl, BTNS_IRPT_ID, PushBtnHandler, &pshBtns);

	/*
	 * Connect the function IicHandler to the interrupt controller so that
	 * it is called whenever the IIC core signals an interrupt.
	 */
	//XIntc_Connect(&intCtrl, IIC_IRPT_ID, IicHandler, NULL);

	/*
	 * Enable both interrupts at the interrupt controller
	 */
	XIntc_Enable(&intCtrl, BTNS_IRPT_ID);
	//XIntc_Enable(&intCtrl, IIC_IRPT_ID);

	/*
	 * Register the interrupt controller with the microblaze
	 * processor and then start the Interrupt controller so that it begins
	 * listening to the push buttons and IIC core for triggers.
	 */
	microblaze_register_handler(XIntc_DeviceInterruptHandler, INTC_DEVICE_ID);
	microblaze_enable_interrupts();
	XIntc_Start(&intCtrl, XIN_REAL_MODE);

	/*
	 * Enable the push button GPIO core to begin sending interrupts to the
	 * interrupt controller in response to changes in the button states
	 */
	XGpio_InterruptEnable(&pshBtns, lBtnChannel);
	XGpio_InterruptGlobalEnable(&pshBtns);

	/*
	 * Enable the IIC core to begin sending interrupts to the
	 * interrupt controller.
	 */
	Xil_Out32(IIC_BASEADDR + bIicIER, 0x00000026);  //Enable AAS, TxFifo empty
													//and Tx done interrupts
	Xil_Out32(IIC_BASEADDR + bIicADR, 0x000000A0);  //Set slave address for E-DDC
	Xil_Out32(IIC_BASEADDR + bIicGIE, 0x80000000);  //Enable global interrupts
	Xil_Out32(IIC_BASEADDR + bIicCR, 0x00000001);   //Enable IIC core

	TestPatternGenerator<XPAR_TPG_0_BASEADDR> tpg_0;
	AxiHdmi<HDMIOUT_BASEADDR> hdmi_0;

	Xil_Out32(LEDS_BASEADDR, 0x00000002);  // Set second LED

#ifndef SIMULATION
	hdmi_0.Dump();
	tpg_0.Dump();
#endif

	Xil_Out32(LEDS_BASEADDR, 0x00000003);  // Set third LED

	hdmi_0.SetOutputResolution(1280, 720);

	tpg_0.SetResolution(1280, 720);
	tpg_0.SetEnabled(true);


	Xil_Out32(LEDS_BASEADDR, 0x00000000);  // Clear LEDs

	volatile u32 leds;
	while (1)
	{
		/*
		 * This loop helps to debounce Stop/Start button presses
		 */
		while (lDeBncCnt < lDeBncCntMax)
		{
				lDeBncCnt++;
				leds = ~leds;
				Xil_Out32(LEDS_BASEADDR, leds);  // Clear LEDs
		}
	}

	return 0;
}

/***	IicHandler
**
**	Parameters:
**		CallBackRef - Pointer to NULL
**
**	Return Value:
**		None
**
**	Errors:
**		None
**
**	Description:
**		This function is connected to the interrupt handler such that it is
**		called whenever an interrupt is triggered by the IIC core. It is
**		designed to behave like a monitor on an E-DDC interface. It outputs
**		the data held in rgbEdid as its EDID.
*/
/* I think EDID is handled by the AXI HDMI implementation
void IicHandler(void *CallBackRef)
{
	if ((Xil_In32(IIC_BASEADDR + bIicISR) & bitAasFlag))
	{
		Xil_In32(IIC_BASEADDR + bIicRX);  //Clear the receive FIFO
	}
	if ((Xil_In32(IIC_BASEADDR + bIicISR) & bitTxEmptyFlag))
	{
		while(((Xil_In32(IIC_BASEADDR + bIicTXOCY) & 0x0000000F) < 15) &&
			  (ibEdid < 128))
		{
			Xil_Out32(IIC_BASEADDR + bIicTX, 0x000000FF & rgbEdid[ibEdid]);
			ibEdid++;
		}
	}
	if (Xil_In32(IIC_BASEADDR + bIicISR) & bitTxDoneFlag)
	{
		Xil_Out32(IIC_BASEADDR + bIicCR, 0x00000003);   //Enable IIC core
		Xil_Out32(IIC_BASEADDR + bIicCR, 0x00000001);   //Enable IIC core
		ibEdid = 0;
	}

	/ *
	 * Clear Interrupt Status Register in IIC core
	 * /
	Xil_Out32(IIC_BASEADDR + bIicISR, Xil_In32(IIC_BASEADDR + bIicISR));
}*/

/***	PushBtnHandler
**
**	Parameters:
**		CallBackRef - Pointer to the push button struct (pshBtns) initialized
**		in main.
**
**	Return Value:
**		None
**
**	Errors:
**		None
**
**	Description:
**		This function is connected to the interrupt handler such that it is
**		called whenever an interrupt is triggered by the push buttons. It
**		responds to button presses by either stopping/starting the input
**		feed, printing a test pattern, inverting the framebuffer, or outputting
**		the input frame dimensions over UART.
*/
void PushBtnHandler(void *CallBackRef)
{
	XGpio *pPushBtn = (XGpio *)CallBackRef;
	u32 lBtnStateNew = XGpio_DiscreteRead(pPushBtn, lBtnChannel);
	u32 lBtnChanges = lBtnStateNew ^ lBtnStateOld;
	//int xcoi;
	//int ycoi;
	//u16 wColor;

	lBtnStateOld = lBtnStateNew;
	/*
	 * Stop/Start Video feed into framebuffer
	 */
	if (lDeBncCnt >= lDeBncCntMax)
	{
		if ((lBtnChanges & bitBtnC) && (lBtnStateNew & bitBtnC))
		{
			/*Xil_Out32(HDMIIN_BASEADDR + bHdmiInLS, lLineStride);
			Xil_Out32(HDMIIN_BASEADDR + bHdmiInADR, pFrame);
			Xil_Out32(HDMIIN_BASEADDR + bHdmiInCR, (Xil_In32(HDMIIN_BASEADDR + bHdmiInCR) ^ bitHdmiEn));
			*/
			lDeBncCnt = 0;
		}
	}
	/*
	 * Invert screen
	 */
	if ((lBtnChanges & bitBtnD) && (lBtnStateNew & bitBtnD))
	{
		/*for(xcoi = 0; xcoi<xcoFrameMax; xcoi++)
		{
			for(ycoi = 0; ycoi<ycoFrameMax; ycoi++)
			{
				Xil_Out16(pFrame + ycoi*(lLineStride*2) + xcoi*2,
						  ~(Xil_In16(pFrame + ycoi*(lLineStride*2) + xcoi*2)));
			}
		}*/
	}
	/*
	 * Print Test Bars
	 */
	if ((lBtnChanges & bitBtnR) && (lBtnStateNew & bitBtnR))
	{
		/*for(xcoi = 0; xcoi<xcoFrameMax; xcoi++)
		{
			for(ycoi = 0; ycoi<ycoFrameMax; ycoi++)
			{
				wColor = 0x0001 << (xcoi / (xcoFrameMax / 16));
				Xil_Out16(pFrame + ycoi*(lLineStride*2) + xcoi*2, wColor);
			}
		}*/
	}
	/*
	 * Output Frame dimensions
	 */
	if ((lBtnChanges & bitBtnL) && (lBtnStateNew & bitBtnL))
	{
		xil_printf("\n\rOutput Resolution Code = %x\n\r",
				Xil_In32(HDMIOUT_BASEADDR + bHdmiOutRes) );
	}

	XGpio_InterruptClear(pPushBtn, lBtnChannel);
}
