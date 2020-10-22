
/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 14.7 EDK_P.20131013
* DO NOT EDIT.
*
* Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.

* 
* Description: Driver configuration
*
*******************************************************************/

#include "xparameters.h"
#include "xintc.h"


extern void XNullHandler (void *);

/*
* The configuration table for devices
*/

XIntc_Config XIntc_ConfigTable[] =
{
	{
		XPAR_MICROBLAZE_0_INTC_DEVICE_ID,
		XPAR_MICROBLAZE_0_INTC_BASEADDR,
		XPAR_MICROBLAZE_0_INTC_KIND_OF_INTR,
		XPAR_MICROBLAZE_0_INTC_HAS_FAST,
		XPAR_MICROBLAZE_0_INTC_IVAR_RESET_VALUE,
		XPAR_MICROBLAZE_0_INTC_NUM_INTR_INPUTS,
		XIN_SVC_SGL_ISR_OPTION,
		XPAR_MICROBLAZE_0_INTC_TYPE,
		{
			{
				XNullHandler,
				(void *) XNULL
			},
			{
				XNullHandler,
				(void *) XNULL
			},
			{
				XNullHandler,
				(void *) XNULL
			},
			{
				XNullHandler,
				(void *) XNULL
			},
			{
				XNullHandler,
				(void *) XNULL
			},
			{
				XNullHandler,
				(void *) XNULL
			}
		}

	}
};

