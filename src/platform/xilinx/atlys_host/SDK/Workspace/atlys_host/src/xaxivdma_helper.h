#ifndef __XAXIVDMA_HELPER_H_
#define __XAXIVDMA_HELPER_H_

typedef struct _VdmaDevice
{
	u16 DeviceId;
	XAxiVdma *InstancePtr;
} VdmaDevice;

typedef struct _Frame
{
	int Width;
	int Height;
	int HorizontalStride;
	int VerticalStride;
} Frame;

typedef struct _VdmaChannel
{
	u16 Direction;
	VdmaDevice *Device;

	u32 AddressBase;
	u8 NumberOfFrames;
	int VerticalStride;

	u8 DelayTimerCount;

	u16 IntrId;
	XAxiVdma_DmaSetup Cfg;

} VdmaChannel;

//int XAxiVdmaHelper_SetFrmStore(VdmaChannel* channel);

int XAxiVdmaHelper_SetupDevice(u16 DeviceId, VdmaDevice* device);

int XAxiVdmaHelper_SetupChannel(VdmaDevice *devicePtr, u16 Direction, u32 BaseAddress, int NumberOfFrames, Frame* frame, u16 IntrId, VdmaChannel* channel);
int XAxiVdmaHelper_SetupReadChannel(VdmaDevice *devicePtr, u32 BaseAddress, int NumberOfFrames, Frame* frame, u16 IntrId, VdmaChannel* channel);
int XAxiVdmaHelper_SetupWriteChannel(VdmaDevice *devicePtr, u32 BaseAddress, int NumberOfFrames, Frame* frame, u16 IntrId, VdmaChannel* channel);



//int XAxiVdmaHelper_Initialize(VdmaChannel *channel);
int XAxiVdmaHelper_StartTransfer(VdmaChannel *channel);

int XAxiVdmaHelper_SetupInterrupts(XIntc *intcInstancePtr, VdmaChannel *channel, XAxiVdma_CallBack completionHandler, XAxiVdma_ErrorCallBack errorHandler);
void XAxiVdmaHelper_EnableInterrupts(XIntc *intcInstancePtr,  VdmaChannel *channel);
void XAxiVdmaHelper_DisableInterrupts(XIntc *intcInstancePtr,  VdmaChannel *channel);

#endif
