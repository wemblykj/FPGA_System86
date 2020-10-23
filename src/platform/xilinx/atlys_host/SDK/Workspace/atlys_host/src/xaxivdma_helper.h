#ifndef __PLATFORM_H_
#define __PLATFORM_H_

#include <stdbool.h>

typedef struct _Frame
{
	int Width;
	int Height;
	int HorizontalStride;
	int VerticalStride;
} Frame;

typedef struct _InterruptHandler
{
	u16 IntrId;
	XInterruptHandler Handler;
} InterruptHandler;

typedef struct _VdmaChannel
{
	XAxiVdma *InstancePtr;


	Frame Frame;
	u32 AddressBase;
	int NumberOfFrames;

	bool EnableInterrupts;
	InterruptHandler InterruptHandler;
	XAxiVdma_DmaSetup Cfg;

} VdmaChannel;

int XAxiVdmaHelper_ReadSetup(VdmaChannel *channel);
int XAxiVdmaHelper_WriteSetup(VdmaChannel *channel);
int XAxiVdmaHelper_StartTransfer(VdmaChannel *channel);

int XAxiVdmaHelper_SetupIntrSystem(XIntc *IntcInstancePtr, VdmaChannel *channel);

void XAxiVdmaHelper_EnableIntrSystem(XIntc *IntcInstancePtr,  VdmaChannel *channel);
void XAxiVdmaHelper_DisableIntrSystem(XIntc *IntcInstancePtr,  VdmaChannel *channel);

#endif
