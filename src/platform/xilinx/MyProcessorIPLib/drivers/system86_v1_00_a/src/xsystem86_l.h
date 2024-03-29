/******************************************************************************
*
* (c) Copyright 2021 Paul Wightmore. All rights reserved.
*
* Driver stub based on GPIO driver
*
*****************************************************************************/

#ifndef XSYSTEM86_L_H		/* prevent circular inclusions */
#define XSYSTEM86_L_H		/* by using protection macros */

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
#define XSYSTEM86_CR_OFFSET				0x00   /**< Control register */
#define XSYSTEM86_SR_OFFSET				0x00   /**< Status register */
#define XSYSTEM86_BASEADDRESS_OFFSET		0x04   /**< Base address for AXI bus mapping */
#define XSYSTEM86_BUS_OFFSET				0x08   /**< Bus register */
#define XSYSTEM86_LINE_FAULT_VALUE_OFFSET	0x0C   /**< Line fault simulation value register */
#define XSYSTEM86_LINE_FAULT_ENABLE_OFFSET	0x10   /**< Line fault simulation enable register */


#define XSYSTEM86_GIE_OFFSET				0x11C  /**< Global interrupt enable register */
#define XSYSTEM86_ISR_OFFSET				0x120  /**< Interrupt status register */
#define XSYSTEM86_IER_OFFSET				0x128  /**< Interrupt enable register */


/** @name Bitmasks of XSYSTEM86_CR_OFFSET register
 * @{
 */
#define XSYSTEM86_CR_ENABLE_MASK			0x00000010  /**< Enable memory bus */
#define XSYSTEM86_CR_DYNAMIC_CTRL_MASK     0x00000020  /**< Dynamic mapping control, if supported by hardware */
/*@}*/

/** @name Bitmasks of XSYSTEM86_SR_OFFSET register
 * This register reports capabilities and errors
 * @{
 */
#define XSYSTEM86_SR_RUNNING_MASK			0x00000010 	/**< Memory bus is running */
#define XSYSTEM86_SR_ERR_ALL_MASK      	0x00000F00  /**< All errors */
#define XSYSTEM86_SR_ERR_ALL_LSB			9			/**< Least significant bit of error flags */
/*@}*/

/** @name Bitmasks of XSYSTEM86_BUS_OFFSET register
 * @{
 */
#define XSYSTEM86_BUS_CONTROL_MASK			0x00000007  /**< Control signals */
#define XSYSTEM86_BUS_CHIP_ENABLE			0x00000001  /**< Chip enable signal */
#define XSYSTEM86_BUS_OUTPUT_ENABLE		0x00000002  /**< Output enable signal */
#define XSYSTEM86_BUS_WRITE_ENABLE			0x00000004  /**< Write enable signal */
/*@}*/

/** @name Interrupt Status and Enable Register bitmaps and masks
 *
 * Bit definitions for the interrupt status register and interrupt enable
 * registers.
 * @{
 */
#define XSYSTEM86_IR_MASK					0x7 /**< Mask of all bits */
#define XSYSTEM86_IR_ADDR_MASK				0x1 /**< Mask for the address interrupt */
#define XSYSTEM86_IR_READ_MASK				0x2 /**< Mask for the read interrupt */
#define XSYSTEM86_IR_WRITE_MASK			0x4 /**< Mask for the write interrupt */
/*@}*/


/** @name Global Interrupt Enable Register bitmaps and masks
 *
 * Bit definitions for the Global Interrupt  Enable register
 * @{
 */
#define XSYSTEM86_GIE_GINTR_ENABLE_MASK	0x80000000
/*@}*/



/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/

 /*
 * Define the appropriate I/O access method to memory mapped I/O.
 */
#define XSystem86_In32  Xil_In32
#define XSystem86_Out32 Xil_Out32


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
*		void XSystem86_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
****************************************************************************/
#define XSystem86_WriteReg(BaseAddress, RegOffset, Data) \
	XSystem86_Out32((BaseAddress) + (RegOffset), (u32)(Data))

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
*		u32 XSystem86_ReadReg(u32 BaseAddress, u32 RegOffset)
*
****************************************************************************/
#define XSystem86_ReadReg(BaseAddress, RegOffset) \
	XSystem86_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ******************************/


/************************** Variable Definitions *****************************/

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
