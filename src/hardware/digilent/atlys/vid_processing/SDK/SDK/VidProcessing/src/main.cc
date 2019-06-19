/*
 * Empty C++ Application
 */

#include "AxiHdmi.h"
#include "TestPatternGenerator.h"

#include <stdio.h>

#include "xparameters.h"

int main()
{
	TestPatternGenerator<XPAR_TPG_0_BASEADDR> tpg_0;
	AxiHdmi<XPAR_AXI_HDMI_0_BASEADDR> hdmi_0;

	hdmi_0.Dump();
	tpg_0.Dump();

	hdmi_0.SetOutputResolution(1280, 720);

	tpg_0.SetResolution(1280, 720);
	tpg_0.SetEnabled(true);



	xil_printf("Press Space to continue!\r\n");

	getchar();
	//unsigned char inchar=0;
	//while (inchar != ' ') inchar = inbyte();

	return 0;
}
