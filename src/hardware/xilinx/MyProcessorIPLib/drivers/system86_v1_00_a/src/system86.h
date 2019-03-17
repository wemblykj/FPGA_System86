/*****************************************************************************
* Filename:          C:\Users\Wembly\Development\System86\src\hardware\xilinx\MyProcessorIPLib\drivers/system86_v1_00_a/src/system86.h
* Version:           1.00.a
* Description:       system86 () Driver Header File
* Date:              Sun Mar 17 10:56:28 2019 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef SYSTEM86_H
#define SYSTEM86_H

#include "xstatus.h"

#include "fsl.h" 
#define write_into_fsl(val, id)  putfsl(val, id)
#define read_from_fsl(val, id)  getfsl(val, id)

/*
* A macro for accessing AXI4STREAM peripheral.
*
* This example driver writes all the data in the input arguments
* into the input AXI4STREAM bus through blocking writes. AXI4STREAM peripheral will
* automatically read from the AXI4STREAM bus. Once all the inputs
* have been written, the output from the AXI4STREAM peripheral is read
* into output arguments through blocking reads.
*
* Arguments:
*	 input_slot_id
*		 Compile time constant indicating AXI4STREAM (FSL) slot from
*		 which coprocessor read the input data. Defined in
*		 xparameters.h .
*	 output_slot_id
*		 Compile time constant indicating AXI4STREAM (FSL) slot into
*		 which the coprocessor write output data. Defined in
*		 xparameters.h .
*	 input_0    An array of unsigned integers. Array size is 8
*	 output_0   An array of unsigned integers. Array size is 8
*
* Caveats:
*    The output_slot_id and input_slot_id arguments must be
*    constants available at compile time. Do not pass
*    variables for these arguments.
*
*    Since this is a macro, using it too many times will
*    increase the size of your application. In such cases,
*    or when this macro is too simplistic for your
*    application you may want to create your own instance
*    specific driver function (not a macro) using the 
*    macros defined in this file and the slot
*    identifiers defined in xparameters.h .  Please see the
*    example code (system86_selftest.c) for details.
*/

#define  system86(\
		 input_slot_id,\
		 output_slot_id,\
		 input_0,      \
		 output_0       \
		 )\
{\
   int i;\
\
   for (i=0; i<8; i++)\
   {\
      write_into_fsl(input_0[i], input_slot_id);\
   }\
\
   for (i=0; i<8; i++)\
   {\
      read_from_fsl(output_0[i], output_slot_id);\
   }\
}

XStatus SYSTEM86_SelfTest();

#endif 
