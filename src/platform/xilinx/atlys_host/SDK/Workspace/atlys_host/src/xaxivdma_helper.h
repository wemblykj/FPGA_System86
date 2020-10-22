#ifndef __PLATFORM_H_
#define __PLATFORM_H_

int XAxiVdmaHelper_ReadSetup(XAxiVdma *InstancePtr);
int XAxiVdmaHelper_WriteSetup(XAxiVdma * InstancePtr);
int XAxiVdmaHelper_StartTransfer(XAxiVdma *InstancePtr);

int XAxiVdmaHelper_SetupIntrSystem(XAxiVdma *AxiVdmaPtr, u16 ReadIntrId,
				u16 WriteIntrId);

void XAxiVdmaHelper_EnableIntrSystem(u16 ReadIntrId, u16 WriteIntrId);
void XAxiVdmaHelper_DisableIntrSystem(u16 ReadIntrId, u16 WriteIntrId);

#endif
