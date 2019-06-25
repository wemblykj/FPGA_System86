/*
 * Copyright (c) 2010 Xilinx, Inc.  All rights reserved.
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

#include "xparameters.h"
#include "xil_cache.h"

#include "platform_config.h"

#ifdef __arm__
#include "xuartps.h"
#elif defined(STDOUT_IS_16550)
#include "xuartns550_l.h"
#endif

#define UART_BAUD 9600

void
enable_caches()
{
#ifdef __PPC__
    Xil_ICacheEnableRegion(CACHEABLE_REGION_MASK);
    Xil_DCacheEnableRegion(CACHEABLE_REGION_MASK);
#elif __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_ICACHE 
    Xil_ICacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE 
    Xil_DCacheEnable();
#endif
#endif
}

void
disable_caches()
{
    Xil_DCacheDisable();
    Xil_ICacheDisable();
}

void
init_uart()
{
#ifdef __arm__
    /* Use the PS UART for Zynq devices */
    XUartPs Uart_Ps_0;
    XUartPs_Config *Config_0 = XUartPs_LookupConfig(XPAR_XUARTPS_0_DEVICE_ID);
    XUartPs_CfgInitialize(&Uart_Ps_0, Config_0, Config_0->BaseAddress);
    XUartPs_SetBaudRate(&Uart_Ps_0, UART_BAUD);
#elif defined(STDOUT_IS_16550)
    XUartNs550_SetBaud(STDOUT_BASEADDR, XPAR_XUARTNS550_CLOCK_HZ, UART_BAUD);
    XUartNs550_SetLineControlReg(STDOUT_BASEADDR, XUN_LCR_8_DATA_BITS);
#endif
}

void
init_platform()
{
    enable_caches();
    init_uart();
}

void
cleanup_platform()
{
    disable_caches();
}
