/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

#ifndef XTTLMEMBUS_L_H		/* prevent circular inclusions */
#define XTTLMEMBUS_L_H		/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xil_types.h"
#include "xil_assert.h"
#include "xil_io.h"

/************************** Constant Definitions *****************************/

/** @name Registers
 *
 * Register offsets for this device.
 * @{
 */
#define XTTLMEMBUS_CR_OFFSET			0x0   /**< Control register */
#define XTTLMEMBUS_SR_OFFSET			0x4   /**< Status register */
#define XTTLMEMBUS_BASEADDRESS_OFFSET	0x8   /**< Base address for AXI bus mapping */

/** @name Bitmasks of XTTLMEMBUS_CR_OFFSET register
 * @{
 */
#define XTTLMEMBUS_CR_ENABLE_MASK			0x00000010 	/**< Enable memory bus */
#define XTTLMEMBUS_CR_DYNAMIC_CTRL_MASK     0x00000020  /**< Dynamic mapping control, if supported by hardware */
/*@}*/

/** @name Bitmasks of XTTLMEMBUS_SR_OFFSET register
 * This register reports capabilities and errors
 * @{
 */
#define XTTLMEMBUS_CR_RUNNING_MASK			0x00000010 	/**< Memory bus is running */
#define XTTLMEMBUS_SR_ERR_ALL_MASK      	0x00000F00  /**< All errors */
#define XTTLMEMBUS_SR_ERR_ALL_LSB			9			/**< Least significant bit of error flags */
/*@}*/




/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/

 /*
 * Define the appropriate I/O access method to memory mapped I/O.
 */
#define XTtlMemBus_In32  Xil_In32
#define XTtlMemBus_Out32 Xil_Out32


/****************************************************************************/
/**
*
* Write a value to a GPIO register. A 32 bit write is performed. If the
* GPIO core is implemented in a smaller width, only the least significant data
* is written.
*
* @param	BaseAddress is the base address of the GPIO device.
* @param	RegOffset is the register offset from the base to write to.
* @param	Data is the data written to the register.
*
* @return	None.
*
* @note		C-style signature:
*		void XTtlMemBus_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
****************************************************************************/
#define XTtlMemBus_WriteReg(BaseAddress, RegOffset, Data) \
	XTtlMemBus_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/****************************************************************************/
/**
*
* Read a value from a GPIO register. A 32 bit read is performed. If the
* GPIO core is implemented in a smaller width, only the least
* significant data is read from the register. The most significant data
* will be read as 0.
*
* @param	BaseAddress is the base address of the GPIO device.
* @param	RegOffset is the register offset from the base to read from.
*
* @return	Data read from the register.
*
* @note		C-style signature:
*		u32 XTtlMemBus_ReadReg(u32 BaseAddress, u32 RegOffset)
*
****************************************************************************/
#define XTtlMemBus_ReadReg(BaseAddress, RegOffset) \
	XTtlMemBus_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
