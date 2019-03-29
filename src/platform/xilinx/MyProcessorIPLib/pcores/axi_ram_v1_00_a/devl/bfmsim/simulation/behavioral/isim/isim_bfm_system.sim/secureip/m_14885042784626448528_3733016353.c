/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "burst_type";
static const char *ng1 = "length";
static const char *ng2 = "lock_type";
static const char *ng3 = "ok";
static const char *ng4 = "size";
static const char *ng5 = "cache_type";
static const char *ng6 = "address";
static const char *ng7 = "address_offset";
static const char *ng8 = "trans_size_in_bytes";
static const char *ng9 = "level";
static const char *ng10 = "task_reset_handling";
static const char *ng11 = "clk_delay";
static const char *ng12 = "disable_value";
static const char *ng13 = "print_message";
static const char *ng14 = "id";
static const char *ng15 = "response";
static const char *ng16 = "buser";
static const char *ng17 = "rd_data";
static const char *ng18 = "last";
static const char *ng19 = "ruser";
static const char *ng20 = "idvalid";
static const char *ng21 = "protection_type";
static const char *ng22 = "region";
static const char *ng23 = "qos";
static const char *ng24 = "awuser";
static const char *ng25 = "idtag";
static const char *ng26 = "timeout_counter";
static const char *ng27 = "trigger_condition";
static const char *ng28 = "aruser";
static const char *ng29 = "wr_data";
static const char *ng30 = "strb";
static const char *ng31 = "user";
static const char *ng32 = "v_ruser";
static const char *ng33 = "rd_data_slice";
static const char *ng34 = "strobe";
static const char *ng35 = "rd_transfer_count";
static const char *ng36 = "byte_number";
static const char *ng37 = "slice_byte_number";
static const char *ng38 = "strobe_index";
static const char *ng39 = "transfer_response";
static const char *ng40 = "datasize";
static const char *ng41 = "v_wuser";
static const char *ng42 = "wr_data_slice";
static const char *ng43 = "wuser";
static const char *ng44 = "wr_transfer_count";
static const char *ng45 = "bit_slice_index";
static const char *ng46 = "byte_count";
static const char *ng47 = "gap_length";
static const char *ng48 = "burst_length";
static const char *ng49 = "address_max";
static const char *ng50 = "transfer_number";
static const char *ng51 = "calculated_strobe";
static const char *ng52 = "/build/xfndry/isimco/hipsBuilds/P_hips_v23.0/rst/hips/axi_bfm/cdn_axi4_slave_bfm.v";
static const char *ng53 = "*********************************************************";
static const char *ng54 = "* CONFIGURATION: ";
static const char *ng55 = "* NAME = %s";
static int ng56[] = {1447386928, 0, 5459009, 0};
static const char *ng57 = "* DATA_BUS_WIDTH = %0d";
static const char *ng58 = "* ADDRESS_BUS_WIDTH = %0d";
static const char *ng59 = "* ID_BUS_WIDTH = %0d";
static const char *ng60 = "* AWUSER_BUS_WIDTH = %0d";
static const char *ng61 = "* ARUSER_BUS_WIDTH = %0d";
static const char *ng62 = "* RUSER_BUS_WIDTH = %0d";
static const char *ng63 = "* WUSER_BUS_WIDTH = %0d";
static const char *ng64 = "* BUSER_BUS_WIDTH = %0d";
static const char *ng65 = "* SLAVE_ADDRESS = 0x%0h";
static unsigned int ng66[] = {1073741824U, 0U};
static const char *ng67 = "* SLAVE_MEM_SIZE = 0x%0h";
static unsigned int ng68[] = {65536U, 0U};
static const char *ng69 = "* MAX_OUTSTANDING_TRANSACTIONS = %0d";
static const char *ng70 = "* MEMORY_MODEL_MODE = %0d";
static const char *ng71 = "* EXCLUSIVE_ACCESS_SUPPORTED = %0d";
static const char *ng72 = "* READ_BURST_DATA_TRANSFER_GAP = %0d";
static const char *ng73 = "* WRITE_RESPONSE_GAP = %0d";
static const char *ng74 = "* READ_RESPONSE_GAP = %0d";
static const char *ng75 = "* RESPONSE_TIMEOUT = %0d";
static const char *ng76 = "* DISABLE_RESET_VALUE_CHECKS = %0d";
static const char *ng77 = "* STOP_ON_ERROR = %0d";
static const char *ng78 = "* CHANNEL_LEVEL_INFO = %0d";
static const char *ng79 = "* FUNCTION_LEVEL_INFO = %0d";
static const char *ng80 = "/build/xfndry/isimco/hipsBuilds/P_hips_v23.0/rst/hips/axi_bfm/cdn_axi4_bfm_checkers.v";
static unsigned int ng81[] = {3U, 0U};
static const char *ng82 = "[%0d] : %s : ERROR : Burst type cannot be equal to 2'b11 as this is RESERVED - AMBA AXI SPEC V2 - Section 4.4 Burst type";
static int ng83[] = {1, 0};
static const char *ng84 = "*** TEST FAILED";
static unsigned int ng85[] = {2U, 0U};
static unsigned int ng86[] = {1U, 0U};
static unsigned int ng87[] = {7U, 0U};
static unsigned int ng88[] = {15U, 0U};
static const char *ng89 = "[%0d] : %s : *ERROR : Burst length cannot be equal to %0d when the burst type is WRAP. It must be either 2,4,8 or 16 - AMBA AXI SPEC V2 - Section 4.2 Burst length";
static int ng90[] = {16, 0};
static const char *ng91 = "[%0d] : %s : *ERROR : Burst length cannot be greater than 16 when the burst type is not INCR. - AMBA AXI SPEC V2 - AXI 4 Section 13.1.3 Burst Support - Limitations of use";
static const char *ng92 = "[%0d] : %s : *ERROR : Burst length cannot be greater than 16 when the burst is an exclusive accesses. - AMBA AXI SPEC V2 - AXI 4 Section 13.1.3 Burst Support - Limitations of use";
static int ng93[] = {8, 0};
static const char *ng94 = "[%0d] : %s : *ERROR : Burst size cannot be greater than the data bus width - AMBA AXI SPEC V2 - Section 4.3 Burst size";
static const char *ng95 = "[%0d] : %s : *ERROR : Lock type cannot be greater than 1 as this should be implemented as a single bit in AXI 4. - AMBA AXI SPEC V2 - Section 13.15.1 AWLOCK and ARLOCK changes";
static unsigned int ng96[] = {4U, 0U};
static unsigned int ng97[] = {0U, 0U};
static unsigned int ng98[] = {5U, 0U};
static unsigned int ng99[] = {8U, 0U};
static unsigned int ng100[] = {9U, 0U};
static unsigned int ng101[] = {12U, 0U};
static unsigned int ng102[] = {13U, 0U};
static const char *ng103 = "[%0d] : %s : *ERROR : CACHE type cannot be equal to %4b as this is RESERVED - AMBA AXI SPEC V2 - AXI 4 Section 13.8 Cache support";
static int ng104[] = {0, 0};
static const char *ng105 = "[%0d] : %s : *ERROR : When the burst type is equal to WRAP the start address must be aligned to the size of the transfer - AMBA AXI SPEC V2 - Section 4.4.3 Burst length";
static int ng106[] = {2, 0};
static int ng107[] = {4, 0};
static int ng108[] = {32, 0};
static unsigned int ng109[] = {6U, 0U};
static int ng110[] = {64, 0};
static int ng111[] = {128, 0};
static const char *ng112 = "[%0d] : %s : *INFO : Setting CHANNEL_LEVEL_INFO to %0d";
static const char *ng113 = "[%0d] : %s : *INFO : Setting FUNCTION_LEVEL_INFO to %0d";
static const char *ng114 = "[%0d] : %s : *INFO : Setting STOP_ON_ERROR to %0d";
static const char *ng115 = "[%0d] : %s : *INFO : Setting CLEAR_SIGNALS_AFTER_HANDSHAKE to %0d";
static const char *ng116 = "[%0d] : %s : *INFO : Setting RESPONSE_TIMEOUT to %0d";
static const char *ng117 = "[%0d] : %s : *INFO : Setting TASK_RESET_HANDLING to %0d";
static const char *ng118 = "[%0d] : %s : *INFO : Channel Level Task called during reset - Waiting until reset is clear before continuing task call.";
static const char *ng119 = "[%0d] : %s : *ERROR : Channel Level Task called during reset";
static int ng120[] = {3, 0};
static const char *ng121 = "[%0d] : %s : *WARNING : Channel Level Task called during reset - ignoring reset and continuing task execution.";
static const char *ng122 = "[%0d] : %s : *INFO : Setting BFM_CLK_DELAY to %0d";
static const char *ng123 = "[%0d] : %s : *INFO : Setting DISABLE_RESET_VALUE_CHECKS to %0d";
static const char *ng124 = "[%0d] : %s : *INFO : REPORT_STATUS : errors = %0d, warnings = %0d, pending transactions = %0d";
static const char *ng125 = "[%0d] : %s : *INFO : Reached the maximum outstanding transactions limit (%0d). Blocking all future transactions until at least 1 of the outstanding transactions has completed.";
static const char *ng126 = "[%0d] : %s : *INFO : SEND_WRITE_RESPONSE Task Call - ";
static const char *ng127 = "id = 0x%0h";
static const char *ng128 = ", response = 0x%0h";
static const char *ng129 = ", buser = 0x%0h";
static const char *ng130 = "[%0d] : %s : *INFO : SEND_READ_DATA Task Call - ";
static const char *ng131 = ", data = 0x%0h";
static const char *ng132 = ", last = 0x%0h";
static const char *ng133 = ", ruser = 0x%0h";
static const char *ng134 = "[%0d] : %s : *INFO : RECEIVE_WRITE_ADDRESS Task Call - ";
static const char *ng135 = ", id valid = 1'b%0b";
static const char *ng136 = "id valid = 1'b%0b";
static const char *ng137 = "[%0d] : %s : *ERROR : RECEIVE_WRITE_ADDRESS Task TIMEOUT - ";
static const char *ng138 = " TASK timed out waiting for a WRITE ADDRESS transfer with the id = 0x%0h";
static const char *ng139 = " TASK timed out waiting for a WRITE ADDRESS transfer";
static const char *ng140 = "[%0d] : %s : *INFO : RECEIVE_WRITE_ADDRESS Task - ";
static const char *ng141 = ", address = 0x%0h";
static const char *ng142 = ", length = %0d";
static const char *ng143 = ", size = %0d";
static const char *ng144 = ", burst_type = 0x%0h";
static const char *ng145 = ", lock_type = 0x%0h";
static const char *ng146 = ", cache_type = 0x%0h";
static const char *ng147 = ", protection_type = 0x%0h";
static const char *ng148 = ", region = 0x%0h";
static const char *ng149 = ", qos = 0x%0h";
static const char *ng150 = ", awuser = 0x%0h";
static const char *ng151 = "[%0d] : %s : *INFO : RECEIVE_READ_ADDRESS Task Call - ";
static const char *ng152 = "[%0d] : %s : *ERROR : RECEIVE_READ_ADDRESS Task TIMEOUT - ";
static const char *ng153 = " TASK timed out waiting for a READ ADDRESS transfer with the id = 0x%0h";
static const char *ng154 = " TASK timed out waiting for a READ ADDRESS transfer";
static const char *ng155 = "[%0d] : %s : *INFO : RECEIVE_READ_ADDRESS Task - ";
static const char *ng156 = ", aruser = 0x%0h";
static const char *ng157 = "[%0d] : %s : *INFO : RECEIVE_WRITE_DATA Task Call - ";
static const char *ng158 = "[%0d] : %s : *ERROR : RECEIVE_WRITE_DATA Task TIMEOUT - ";
static const char *ng159 = "TASK timed out waiting for a WRITE DATA transfer";
static const char *ng160 = "[%0d] : %s : *INFO : RECEIVE_WRITE_DATA Task - ";
static const char *ng161 = "wr_data = 0x%0h";
static const char *ng162 = ", strobe = 0x%0h";
static const char *ng163 = ", wuser = 0x%0h";
static const char *ng164 = "[%0d] : %s : *INFO : SEND_READ_BURST Task Call - ";
static const char *ng165 = "[%0d] : %s : *INFO : SEND_READ_BURST_RESP_CTRL Task Call - ";
static const char *ng166 = "[%0d] : %s : *INFO : RECEIVE_WRITE_BURST Task Call - ";
static const char *ng167 = "[%0d] : %s : *ERROR : RECEIVE_WRITE_BURST Task - ";
static const char *ng168 = " The number of WRITE transfers is greater than the burst length i.e. length = %0d";
static const char *ng169 = " != # of transfers = %0d";
static const char *ng170 = " The number of WRITE transfers is less than the burst length i.e. length = %0d";
static const char *ng171 = "[%0d] : %s : *INFO : READ_BURST_RESPOND Task Call - ";
static const char *ng172 = "[%0d] : %s : *INFO : READ_BURST_RESP_CTRL Task Call - ";
static const char *ng173 = "[%0d] : %s : *INFO : WRITE_BURST_RESPOND Task Call - ";
static const char *ng174 = "[%0d] : %s : *INFO : WRITE_BURST_RESP_CTRL Task Call - ";
static const char *ng175 = "[%0d] : %s : *INFO : Setting READ_BURST_DATA_TRANSFER_GAP to %0d";
static const char *ng176 = "[%0d] : %s : *INFO : Setting WRITE_RESPONSE_GAP to %0d";
static const char *ng177 = "[%0d] : %s : *INFO : Setting READ_RESPONSE_GAP to %0d";
static const char *ng178 = "[%0d] : %s : *ERROR : Address not in range! Address = 0x%0h but base address of slave is 0x%0h and the size is %0d bytes. The max address of this slave is 0x%0h.";
static const char *ng179 = "[%0d] : %s : *ERROR : Burst is too large for slave address and size configuration. Burst address is 0x%0h and burst length = %0d bytes. Base address of slave is 0x%0h and the size is %0d bytes. The max address of this slave is 0x%0h.";
static const char *ng180 = "[%0d] : %s : *INFO : Address range check passed.";
static const char *ng181 = "[%0d] : %s : *ERROR : The received strobe signal (0x%0h) is not valid (0x%0h)!";
static const char *ng182 = "[%0d] : %s : *INFO : Strobe check passed.";
static const char *ng183 = "Xilinx_AXI_BFM";
static const char *ng184 = "BFM Xilinx: License succeeded for %s, version %f";
static int ng185[] = {1598178893, 0, 1598117961, 0, 1818848888, 0, 22633, 0};
static const char *ng186 = "BFM Xilinx: License failed for %s, version %f";
static const char *ng187 = "* Cadence AXI 4 SLAVE BFM                               *";
static const char *ng188 = "* VERSION NUMBER : ";
static const char *ng189 = "3.0";
static const char *ng190 = "[%0d] : %s : *INFO : Reset detected - setting output signals to reset values and checking input signals for correct reset values.";
static const char *ng191 = "[%0d] : %s : *ERROR : ARVALID from master is not zero (reset value) - AMBA AXI SPEC V2 - Section 11.1.2 Reset";
static const char *ng192 = "[%0d] : %s : *ERROR : AWVALID from master is not zero (reset value) - AMBA AXI SPEC V2 - Section 11.1.2 Reset";
static const char *ng193 = "[%0d] : %s : *ERROR : WVALID from master is not zero (reset value) - AMBA AXI SPEC V2 - Section 11.1.2 Reset";
static const char *ng194 = "[%0d] : %s : *INFO : Reset Checks Complete";
static const char *ng195 = "[%0d] : %s : *ERROR : Invalid release of reset. Reset can be asserted asyncronously but must be deasserted on the rising edge of the clock - AMBA AXI SPEC V2 - Section 11.1.2 Reset";
static const char *ng196 = "[%0d] : %s : *INFO : MEMORY MODEL MODE ENABLED : Sizes in bytes : memory size = %0d memory depth = %0d, memory width = %0d";
static unsigned int ng197[] = {65535U, 0U};
static const char *ng198 = "[%0d] : %s : *INFO : MEMORY MODEL MODE DISABLED";
static int ng199[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static int ng200[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};



static void check_burst_type_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng0, 2, 1, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void check_burst_length_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng0, 2, 1, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng1, 2, 7, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng2, 2, 0, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng3, 2, 0, 0, 0, t20, 0, 1, 0);

LAB1:    return;
}

static void check_burst_size_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng4, 2, 2, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void check_lock_type_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng2, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void check_cache_type_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng5, 2, 3, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng3, 2, 0, 0, 0, t10, 0, 1, 0);

LAB1:    return;
}

static void check_address_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng6, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng0, 2, 1, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng4, 2, 2, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng7, 2, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng8, 0, 31, 0, 0, t25, 0, 1, 0);

LAB1:    return;
}

static void set_channel_level_info_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng9, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_function_level_info_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng9, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_stop_on_error_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng9, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_clear_signals_after_handshake_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng9, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_response_timeout_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng9, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_task_call_and_reset_handling_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng10, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void task_reset_handling_varinit(char *t0)
{

LAB0:
LAB1:    return;
}

static void set_bfm_clk_delay_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng11, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_disable_reset_value_checks_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng12, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void add_pending_transaction_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng13, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void remove_pending_transaction_varinit(char *t0)
{

LAB0:
LAB1:    return;
}

static void SEND_WRITE_RESPONSE_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng15, 2, 1, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng16, 2, 0, 0, 0, t15, 0, 1, 0);

LAB1:    return;
}

static void SEND_READ_DATA_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng17, 2, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng15, 2, 1, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng18, 2, 0, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng19, 2, 0, 0, 0, t25, 0, 1, 0);

LAB1:    return;
}

static void RECEIVE_WRITE_ADDRESS_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 0, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng6, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng1, 2, 7, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng4, 2, 2, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng0, 2, 1, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng2, 2, 0, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng5, 2, 3, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng21, 2, 2, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng22, 2, 3, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng23, 2, 3, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng24, 2, 0, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng25, 2, 0, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng26, 0, 31, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng27, 2, 0, 0, 0, t75, 0, 1, 0);

LAB1:    return;
}

static void RECEIVE_READ_ADDRESS_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 0, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng6, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng1, 2, 7, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng4, 2, 2, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng0, 2, 1, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng2, 2, 0, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng5, 2, 3, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng21, 2, 2, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng22, 2, 3, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng23, 2, 3, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng28, 2, 0, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng25, 2, 0, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng26, 0, 31, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng27, 2, 0, 0, 0, t75, 0, 1, 0);

LAB1:    return;
}

static void RECEIVE_WRITE_DATA_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng29, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng30, 2, 3, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng18, 2, 0, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng31, 2, 0, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng26, 0, 31, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng27, 2, 0, 0, 0, t30, 0, 1, 0);

LAB1:    return;
}

static void SEND_READ_BURST_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng6, 2, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng1, 2, 7, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng4, 2, 2, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng0, 2, 1, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng2, 2, 0, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng17, 2, 8191, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng32, 2, 255, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng33, 2, 31, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng19, 2, 0, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng15, 2, 1, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng18, 2, 0, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng34, 2, 3, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng35, 0, 31, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng8, 0, 31, 0, 0, t75, 0, 1, 0);
    t76 = (t0 + 96U);
    t77 = *((char **)t76);
    t78 = (t77 + 2400U);
    t79 = (t0 + 80U);
    t80 = *((char **)t79);
    xsi_vlogvar_initialize(t78, ng36, 0, 31, 0, 0, t80, 0, 1, 0);
    t81 = (t0 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 2560U);
    t84 = (t0 + 80U);
    t85 = *((char **)t84);
    xsi_vlogvar_initialize(t83, ng37, 0, 31, 0, 0, t85, 0, 1, 0);
    t86 = (t0 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 2720U);
    t89 = (t0 + 80U);
    t90 = *((char **)t89);
    xsi_vlogvar_initialize(t88, ng38, 0, 31, 0, 0, t90, 0, 1, 0);

LAB1:    return;
}

static void SEND_READ_BURST_RESP_CTRL_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng6, 2, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng1, 2, 7, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng4, 2, 2, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng0, 2, 1, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng17, 2, 8191, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng15, 2, 511, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng32, 2, 255, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng33, 2, 31, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng19, 2, 0, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng18, 2, 0, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng34, 2, 3, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng39, 2, 1, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng35, 0, 31, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng8, 0, 31, 0, 0, t75, 0, 1, 0);
    t76 = (t0 + 96U);
    t77 = *((char **)t76);
    t78 = (t77 + 2400U);
    t79 = (t0 + 80U);
    t80 = *((char **)t79);
    xsi_vlogvar_initialize(t78, ng36, 0, 31, 0, 0, t80, 0, 1, 0);
    t81 = (t0 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 2560U);
    t84 = (t0 + 80U);
    t85 = *((char **)t84);
    xsi_vlogvar_initialize(t83, ng37, 0, 31, 0, 0, t85, 0, 1, 0);
    t86 = (t0 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 2720U);
    t89 = (t0 + 80U);
    t90 = *((char **)t89);
    xsi_vlogvar_initialize(t88, ng38, 0, 31, 0, 0, t90, 0, 1, 0);

LAB1:    return;
}

static void RECEIVE_WRITE_BURST_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng6, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng1, 2, 7, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng4, 2, 2, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng0, 2, 1, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng29, 2, 8191, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng40, 0, 31, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng41, 2, 255, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng42, 2, 31, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng43, 2, 0, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng18, 2, 0, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng34, 2, 3, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng44, 0, 31, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng8, 0, 31, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng37, 0, 31, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng38, 0, 31, 0, 0, t75, 0, 1, 0);

LAB1:    return;
}

static void READ_BURST_RESPOND_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng17, 2, 8191, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng32, 2, 255, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng6, 2, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng1, 2, 7, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng4, 2, 2, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng0, 2, 1, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng2, 2, 0, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng5, 2, 3, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng21, 2, 2, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng22, 2, 3, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng23, 2, 3, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng28, 2, 0, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng25, 2, 0, 0, 0, t70, 0, 1, 0);

LAB1:    return;
}

static void READ_BURST_RESP_CTRL_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng17, 2, 8191, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng15, 2, 511, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng32, 2, 255, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng6, 2, 31, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng1, 2, 7, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng4, 2, 2, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng0, 2, 1, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng2, 2, 0, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng5, 2, 3, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng21, 2, 2, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng22, 2, 3, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng23, 2, 3, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng28, 2, 0, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng25, 2, 0, 0, 0, t75, 0, 1, 0);

LAB1:    return;
}

static void WRITE_BURST_RESPOND_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng16, 2, 0, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng29, 2, 8191, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng40, 0, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng41, 2, 255, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng6, 2, 31, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng1, 2, 7, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng4, 2, 2, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng0, 2, 1, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng2, 2, 0, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng5, 2, 3, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng21, 2, 2, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng15, 2, 1, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng22, 2, 3, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng23, 2, 3, 0, 0, t75, 0, 1, 0);
    t76 = (t0 + 96U);
    t77 = *((char **)t76);
    t78 = (t77 + 2400U);
    t79 = (t0 + 80U);
    t80 = *((char **)t79);
    xsi_vlogvar_initialize(t78, ng24, 2, 0, 0, 0, t80, 0, 1, 0);
    t81 = (t0 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 2560U);
    t84 = (t0 + 80U);
    t85 = *((char **)t84);
    xsi_vlogvar_initialize(t83, ng25, 2, 0, 0, 0, t85, 0, 1, 0);

LAB1:    return;
}

static void WRITE_BURST_RESP_CTRL_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng15, 2, 1, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng16, 2, 0, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng29, 2, 8191, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng40, 0, 31, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng41, 2, 255, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng6, 2, 31, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1120U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng1, 2, 7, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1280U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng4, 2, 2, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1440U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng0, 2, 1, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1600U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng2, 2, 0, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1760U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng5, 2, 3, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 1920U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng21, 2, 2, 0, 0, t65, 0, 1, 0);
    t66 = (t0 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 2080U);
    t69 = (t0 + 80U);
    t70 = *((char **)t69);
    xsi_vlogvar_initialize(t68, ng22, 2, 3, 0, 0, t70, 0, 1, 0);
    t71 = (t0 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 2240U);
    t74 = (t0 + 80U);
    t75 = *((char **)t74);
    xsi_vlogvar_initialize(t73, ng23, 2, 3, 0, 0, t75, 0, 1, 0);
    t76 = (t0 + 96U);
    t77 = *((char **)t76);
    t78 = (t77 + 2400U);
    t79 = (t0 + 80U);
    t80 = *((char **)t79);
    xsi_vlogvar_initialize(t78, ng24, 2, 0, 0, 0, t80, 0, 1, 0);
    t81 = (t0 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 2560U);
    t84 = (t0 + 80U);
    t85 = *((char **)t84);
    xsi_vlogvar_initialize(t83, ng44, 0, 31, 0, 0, t85, 0, 1, 0);
    t86 = (t0 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 2720U);
    t89 = (t0 + 80U);
    t90 = *((char **)t89);
    xsi_vlogvar_initialize(t88, ng45, 0, 31, 0, 0, t90, 0, 1, 0);
    t91 = (t0 + 96U);
    t92 = *((char **)t91);
    t93 = (t92 + 2880U);
    t94 = (t0 + 80U);
    t95 = *((char **)t94);
    xsi_vlogvar_initialize(t93, ng46, 0, 31, 0, 0, t95, 0, 1, 0);
    t96 = (t0 + 96U);
    t97 = *((char **)t96);
    t98 = (t97 + 3040U);
    t99 = (t0 + 80U);
    t100 = *((char **)t99);
    xsi_vlogvar_initialize(t98, ng34, 2, 3, 0, 0, t100, 0, 1, 1, 7, 0);
    t101 = (t0 + 96U);
    t102 = *((char **)t101);
    t103 = (t102 + 3200U);
    t104 = (t0 + 80U);
    t105 = *((char **)t104);
    xsi_vlogvar_initialize(t103, ng25, 2, 0, 0, 0, t105, 0, 1, 0);

LAB1:    return;
}

static void set_read_burst_data_transfer_gap_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng47, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_write_response_gap_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng47, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void set_read_response_gap_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng47, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void check_address_range_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng6, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng1, 2, 7, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng0, 2, 1, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng48, 0, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng49, 2, 31, 0, 0, t25, 0, 1, 0);

LAB1:    return;
}

static void check_strobe_varinit(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 0U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng34, 2, 3, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng50, 0, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng6, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng1, 2, 7, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng4, 2, 2, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng0, 2, 1, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng51, 2, 3, 0, 0, t35, 0, 1, 0);

LAB1:    return;
}

static int sp_report_config(char *t1, char *t2)
{
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 3480);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(195, ng52);

LAB5:    xsi_set_current_line(196, ng52);
    t5 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng53, 1, t5);
    xsi_set_current_line(197, ng52);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng54, 1, t4);
    xsi_set_current_line(198, ng52);
    t4 = ((char*)((ng56)));
    t5 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng55, 2, t5, (char)118, t4, 56);
    xsi_set_current_line(199, ng52);
    t4 = (t1 + 1200);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng57, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(200, ng52);
    t4 = (t1 + 1336);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng58, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(201, ng52);
    t4 = (t1 + 1472);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng59, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(202, ng52);
    t4 = (t1 + 1608);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng60, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(203, ng52);
    t4 = (t1 + 1744);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng61, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(204, ng52);
    t4 = (t1 + 1880);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng62, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(205, ng52);
    t4 = (t1 + 2016);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng63, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(206, ng52);
    t4 = (t1 + 2152);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng64, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(207, ng52);
    t4 = ((char*)((ng66)));
    t5 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng65, 2, t5, (char)118, t4, 32);
    xsi_set_current_line(208, ng52);
    t4 = ((char*)((ng68)));
    t5 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng67, 2, t5, (char)118, t4, 32);
    xsi_set_current_line(209, ng52);
    t4 = (t1 + 2560);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng69, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(211, ng52);
    t4 = (t1 + 2696);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng70, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(212, ng52);
    t4 = (t1 + 2832);
    t5 = *((char **)t4);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng71, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(214, ng52);
    t4 = (t1 + 26960);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng72, 2, t7, (char)119, t6, 32);
    xsi_set_current_line(216, ng52);
    t4 = (t1 + 27120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng73, 2, t7, (char)119, t6, 32);
    xsi_set_current_line(217, ng52);
    t4 = (t1 + 27280);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng74, 2, t7, (char)119, t6, 32);
    xsi_set_current_line(218, ng52);
    t4 = (t1 + 27440);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng75, 2, t7, (char)119, t6, 32);
    xsi_set_current_line(219, ng52);
    t4 = (t1 + 27600);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng76, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(220, ng52);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng77, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(221, ng52);
    t4 = (t1 + 27920);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng78, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(222, ng52);
    t4 = (t1 + 28080);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng79, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(223, ng52);
    t4 = (t1 + 3480);
    xsi_vlogfile_write(1, 0, 0, ng53, 1, t4);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_check_burst_type(char *t1, char *t2)
{
    char t11[8];
    char t20[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 3912);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(27, ng80);

LAB5:    xsi_set_current_line(28, ng80);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng81)));
    memset(t11, 0, 8);
    if (*((unsigned int *)t9) != *((unsigned int *)t10))
        goto LAB8;

LAB6:    t12 = (t9 + 4);
    t13 = (t10 + 4);
    if (*((unsigned int *)t12) != *((unsigned int *)t13))
        goto LAB8;

LAB7:    *((unsigned int *)t11) = 1;

LAB8:    t14 = (t11 + 4);
    t15 = *((unsigned int *)t14);
    t16 = (~(t15));
    t17 = *((unsigned int *)t11);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB9;

LAB10:
LAB11:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    xsi_set_current_line(28, ng80);

LAB12:    xsi_set_current_line(29, ng80);
    t21 = xsi_vlog_time(t20, 10000.000000000000, 1000.0000000000000);
    t22 = ((char*)((ng56)));
    t23 = (t1 + 3912);
    xsi_vlogfile_write(1, 0, 0, ng82, 3, t23, (char)118, t20, 64, (char)118, t22, 56);
    xsi_set_current_line(30, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t15 = *((unsigned int *)t6);
    t16 = *((unsigned int *)t7);
    t17 = (t15 ^ t16);
    t18 = *((unsigned int *)t8);
    t19 = *((unsigned int *)t9);
    t24 = (t18 ^ t19);
    t25 = (t17 | t24);
    t26 = *((unsigned int *)t8);
    t27 = *((unsigned int *)t9);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB16;

LAB13:    if (t28 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t11) = 1;

LAB16:    t12 = (t11 + 4);
    t31 = *((unsigned int *)t12);
    t32 = (~(t31));
    t33 = *((unsigned int *)t11);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB17;

LAB18:
LAB19:    xsi_set_current_line(34, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB11;

LAB15:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB16;

LAB17:    xsi_set_current_line(30, ng80);

LAB20:    xsi_set_current_line(31, ng80);
    t13 = (t1 + 3912);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t13);
    xsi_set_current_line(32, ng80);
    xsi_vlog_stop(1);
    goto LAB19;

}

static int sp_check_burst_length(char *t1, char *t2)
{
    char t11[8];
    char t31[16];
    char t52[8];
    char t58[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 4344);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(56, ng80);

LAB5:    xsi_set_current_line(57, ng80);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng85)));
    memset(t11, 0, 8);
    if (*((unsigned int *)t9) != *((unsigned int *)t10))
        goto LAB8;

LAB6:    t12 = (t9 + 4);
    t13 = (t10 + 4);
    if (*((unsigned int *)t12) != *((unsigned int *)t13))
        goto LAB8;

LAB7:    *((unsigned int *)t11) = 1;

LAB8:    t14 = (t11 + 4);
    t15 = *((unsigned int *)t14);
    t16 = (~(t15));
    t17 = *((unsigned int *)t11);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB9;

LAB10:
LAB11:    xsi_set_current_line(75, ng80);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t12 = (t1 + 6936);
    t13 = xsi_create_subprogram_invocation(t10, 0, t1, t12, 0, t2);
    t14 = (t1 + 32080);
    xsi_vlogvar_assign_value(t14, t8, 0, 0, 8);

LAB37:    t20 = (t2 + 64U);
    t21 = *((char **)t20);
    t22 = (t21 + 80U);
    t23 = *((char **)t22);
    t25 = (t23 + 272U);
    t27 = *((char **)t25);
    t28 = (t27 + 0U);
    t29 = *((char **)t28);
    t26 = ((int  (*)(char *, char *))t29)(t1, t21);
    if (t26 != 0)
        goto LAB39;

LAB38:    t21 = (t2 + 64U);
    t30 = *((char **)t21);
    t21 = (t1 + 31920);
    t32 = (t21 + 56U);
    t33 = *((char **)t32);
    memcpy(t11, t33, 8);
    t34 = (t1 + 6936);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_delete_subprogram_invocation(t34, t30, t1, t36, t2);
    t37 = ((char*)((ng90)));
    memset(t52, 0, 8);
    xsi_vlog_signed_greater(t52, 32, t11, 32, t37, 32);
    t38 = (t52 + 4);
    t15 = *((unsigned int *)t38);
    t16 = (~(t15));
    t17 = *((unsigned int *)t52);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB40;

LAB41:
LAB42:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    xsi_set_current_line(57, ng80);

LAB12:    xsi_set_current_line(58, ng80);
    t20 = (t2 + 96U);
    t21 = *((char **)t20);
    t22 = (t21 + 160U);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);

LAB13:    t25 = ((char*)((ng86)));
    t26 = xsi_vlog_unsigned_case_compare(t24, 8, t25, 8);
    if (t26 == 1)
        goto LAB14;

LAB15:    t4 = ((char*)((ng81)));
    t26 = xsi_vlog_unsigned_case_compare(t24, 8, t4, 8);
    if (t26 == 1)
        goto LAB16;

LAB17:    t4 = ((char*)((ng87)));
    t26 = xsi_vlog_unsigned_case_compare(t24, 8, t4, 8);
    if (t26 == 1)
        goto LAB18;

LAB19:    t4 = ((char*)((ng88)));
    t26 = xsi_vlog_unsigned_case_compare(t24, 8, t4, 8);
    if (t26 == 1)
        goto LAB20;

LAB21:
LAB23:
LAB22:    xsi_set_current_line(63, ng80);

LAB25:    xsi_set_current_line(64, ng80);
    t4 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng56)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t2 + 56U);
    t13 = *((char **)t12);
    t14 = (t1 + 6936);
    t20 = xsi_create_subprogram_invocation(t13, 0, t1, t14, 0, t2);
    t21 = (t1 + 32080);
    xsi_vlogvar_assign_value(t21, t10, 0, 0, 8);

LAB26:    t22 = (t2 + 64U);
    t23 = *((char **)t22);
    t25 = (t23 + 80U);
    t27 = *((char **)t25);
    t28 = (t27 + 272U);
    t29 = *((char **)t28);
    t30 = (t29 + 0U);
    t32 = *((char **)t30);
    t26 = ((int  (*)(char *, char *))t32)(t1, t23);
    if (t26 != 0)
        goto LAB28;

LAB27:    t23 = (t2 + 64U);
    t33 = *((char **)t23);
    t23 = (t1 + 31920);
    t34 = (t23 + 56U);
    t35 = *((char **)t34);
    memcpy(t11, t35, 8);
    t36 = (t1 + 6936);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    xsi_delete_subprogram_invocation(t36, t33, t1, t38, t2);
    t39 = (t1 + 4344);
    xsi_vlogfile_write(1, 0, 0, ng89, 4, t39, (char)118, t31, 64, (char)118, t5, 56, (char)119, t11, 32);
    xsi_set_current_line(65, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t15 = *((unsigned int *)t6);
    t16 = *((unsigned int *)t7);
    t17 = (t15 ^ t16);
    t18 = *((unsigned int *)t8);
    t19 = *((unsigned int *)t9);
    t40 = (t18 ^ t19);
    t41 = (t17 | t40);
    t42 = *((unsigned int *)t8);
    t43 = *((unsigned int *)t9);
    t44 = (t42 | t43);
    t45 = (~(t44));
    t46 = (t41 & t45);
    if (t46 != 0)
        goto LAB32;

LAB29:    if (t44 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t11) = 1;

LAB32:    t12 = (t11 + 4);
    t47 = *((unsigned int *)t12);
    t48 = (~(t47));
    t49 = *((unsigned int *)t11);
    t50 = (t49 & t48);
    t51 = (t50 != 0);
    if (t51 > 0)
        goto LAB33;

LAB34:
LAB35:    xsi_set_current_line(69, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);

LAB24:    goto LAB11;

LAB14:    xsi_set_current_line(59, ng80);
    t27 = ((char*)((ng86)));
    t28 = (t2 + 96U);
    t29 = *((char **)t28);
    t30 = (t29 + 480U);
    xsi_vlogvar_assign_value(t30, t27, 0, 0, 1);
    goto LAB24;

LAB16:    xsi_set_current_line(60, ng80);
    t5 = ((char*)((ng86)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 480U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB24;

LAB18:    xsi_set_current_line(61, ng80);
    t5 = ((char*)((ng86)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 480U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB24;

LAB20:    xsi_set_current_line(62, ng80);
    t5 = ((char*)((ng86)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 480U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB24;

LAB28:    t22 = (t2 + 48U);
    *((char **)t22) = &&LAB26;
    goto LAB1;

LAB31:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB32;

LAB33:    xsi_set_current_line(65, ng80);

LAB36:    xsi_set_current_line(66, ng80);
    t13 = (t1 + 4344);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t13);
    xsi_set_current_line(67, ng80);
    xsi_vlog_stop(1);
    goto LAB35;

LAB39:    t20 = (t2 + 48U);
    *((char **)t20) = &&LAB37;
    goto LAB1;

LAB40:    xsi_set_current_line(75, ng80);

LAB43:    xsi_set_current_line(76, ng80);
    t39 = (t2 + 96U);
    t53 = *((char **)t39);
    t54 = (t53 + 0U);
    t55 = (t54 + 56U);
    t56 = *((char **)t55);
    t57 = ((char*)((ng86)));
    memset(t58, 0, 8);
    if (*((unsigned int *)t56) != *((unsigned int *)t57))
        goto LAB45;

LAB44:    t59 = (t56 + 4);
    t60 = (t57 + 4);
    if (*((unsigned int *)t59) != *((unsigned int *)t60))
        goto LAB45;

LAB46:    t61 = (t58 + 4);
    t40 = *((unsigned int *)t61);
    t41 = (~(t40));
    t42 = *((unsigned int *)t58);
    t43 = (t42 & t41);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB47;

LAB48:
LAB49:    xsi_set_current_line(84, ng80);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng86)));
    memset(t11, 0, 8);
    if (*((unsigned int *)t8) != *((unsigned int *)t9))
        goto LAB61;

LAB59:    t10 = (t8 + 4);
    t12 = (t9 + 4);
    if (*((unsigned int *)t10) != *((unsigned int *)t12))
        goto LAB61;

LAB60:    *((unsigned int *)t11) = 1;

LAB61:    t13 = (t11 + 4);
    t15 = *((unsigned int *)t13);
    t16 = (~(t15));
    t17 = *((unsigned int *)t11);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB62;

LAB63:
LAB64:    goto LAB42;

LAB45:    *((unsigned int *)t58) = 1;
    goto LAB46;

LAB47:    xsi_set_current_line(76, ng80);

LAB50:    xsi_set_current_line(77, ng80);
    t62 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t63 = ((char*)((ng56)));
    t64 = (t1 + 4344);
    xsi_vlogfile_write(1, 0, 0, ng91, 3, t64, (char)118, t31, 64, (char)118, t63, 56);
    xsi_set_current_line(78, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t15 = *((unsigned int *)t6);
    t16 = *((unsigned int *)t7);
    t17 = (t15 ^ t16);
    t18 = *((unsigned int *)t8);
    t19 = *((unsigned int *)t9);
    t40 = (t18 ^ t19);
    t41 = (t17 | t40);
    t42 = *((unsigned int *)t8);
    t43 = *((unsigned int *)t9);
    t44 = (t42 | t43);
    t45 = (~(t44));
    t46 = (t41 & t45);
    if (t46 != 0)
        goto LAB54;

LAB51:    if (t44 != 0)
        goto LAB53;

LAB52:    *((unsigned int *)t11) = 1;

LAB54:    t12 = (t11 + 4);
    t47 = *((unsigned int *)t12);
    t48 = (~(t47));
    t49 = *((unsigned int *)t11);
    t50 = (t49 & t48);
    t51 = (t50 != 0);
    if (t51 > 0)
        goto LAB55;

LAB56:
LAB57:    xsi_set_current_line(82, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB49;

LAB53:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB54;

LAB55:    xsi_set_current_line(78, ng80);

LAB58:    xsi_set_current_line(79, ng80);
    t13 = (t1 + 4344);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t13);
    xsi_set_current_line(80, ng80);
    xsi_vlog_stop(1);
    goto LAB57;

LAB62:    xsi_set_current_line(84, ng80);

LAB65:    xsi_set_current_line(85, ng80);
    t14 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t20 = ((char*)((ng56)));
    t21 = (t1 + 4344);
    xsi_vlogfile_write(1, 0, 0, ng92, 3, t21, (char)118, t31, 64, (char)118, t20, 56);
    xsi_set_current_line(86, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t15 = *((unsigned int *)t6);
    t16 = *((unsigned int *)t7);
    t17 = (t15 ^ t16);
    t18 = *((unsigned int *)t8);
    t19 = *((unsigned int *)t9);
    t40 = (t18 ^ t19);
    t41 = (t17 | t40);
    t42 = *((unsigned int *)t8);
    t43 = *((unsigned int *)t9);
    t44 = (t42 | t43);
    t45 = (~(t44));
    t46 = (t41 & t45);
    if (t46 != 0)
        goto LAB69;

LAB66:    if (t44 != 0)
        goto LAB68;

LAB67:    *((unsigned int *)t11) = 1;

LAB69:    t12 = (t11 + 4);
    t47 = *((unsigned int *)t12);
    t48 = (~(t47));
    t49 = *((unsigned int *)t11);
    t50 = (t49 & t48);
    t51 = (t50 != 0);
    if (t51 > 0)
        goto LAB70;

LAB71:
LAB72:    xsi_set_current_line(90, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB64;

LAB68:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB69;

LAB70:    xsi_set_current_line(86, ng80);

LAB73:    xsi_set_current_line(87, ng80);
    t13 = (t1 + 4344);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t13);
    xsi_set_current_line(88, ng80);
    xsi_vlog_stop(1);
    goto LAB72;

}

static int sp_check_burst_size(char *t1, char *t2)
{
    char t27[8];
    char t33[8];
    char t34[8];
    char t41[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    int t23;
    char *t24;
    char *t25;
    char *t26;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t42;
    char *t43;
    char *t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 4776);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(108, ng80);

LAB5:    xsi_set_current_line(109, ng80);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t1 + 6504);
    t13 = xsi_create_subprogram_invocation(t11, 0, t1, t12, 0, t2);
    t14 = (t1 + 31760);
    xsi_vlogvar_assign_value(t14, t9, 0, 0, 3);

LAB6:    t15 = (t2 + 64U);
    t16 = *((char **)t15);
    t17 = (t16 + 80U);
    t18 = *((char **)t17);
    t19 = (t18 + 272U);
    t20 = *((char **)t19);
    t21 = (t20 + 0U);
    t22 = *((char **)t21);
    t23 = ((int  (*)(char *, char *))t22)(t1, t16);
    if (t23 != 0)
        goto LAB8;

LAB7:    t16 = (t2 + 64U);
    t24 = *((char **)t16);
    t16 = (t1 + 31600);
    t25 = (t16 + 56U);
    t26 = *((char **)t25);
    memcpy(t27, t26, 8);
    t28 = (t1 + 6504);
    t29 = (t2 + 56U);
    t30 = *((char **)t29);
    xsi_delete_subprogram_invocation(t28, t24, t1, t30, t2);
    t31 = (t1 + 1200);
    t32 = *((char **)t31);
    t31 = ((char*)((ng93)));
    memset(t33, 0, 8);
    xsi_vlog_signed_divide(t33, 32, t32, 32, t31, 32);
    memset(t34, 0, 8);
    xsi_vlog_signed_greater(t34, 32, t27, 32, t33, 32);
    t35 = (t34 + 4);
    t36 = *((unsigned int *)t35);
    t37 = (~(t36));
    t38 = *((unsigned int *)t34);
    t39 = (t38 & t37);
    t40 = (t39 != 0);
    if (t40 > 0)
        goto LAB9;

LAB10:
LAB11:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t15 = (t2 + 48U);
    *((char **)t15) = &&LAB6;
    goto LAB1;

LAB9:    xsi_set_current_line(109, ng80);

LAB12:    xsi_set_current_line(110, ng80);
    t42 = xsi_vlog_time(t41, 10000.000000000000, 1000.0000000000000);
    t43 = ((char*)((ng56)));
    t44 = (t1 + 4776);
    xsi_vlogfile_write(1, 0, 0, ng94, 3, t44, (char)118, t41, 64, (char)118, t43, 56);
    xsi_set_current_line(111, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t27, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t36 = *((unsigned int *)t6);
    t37 = *((unsigned int *)t7);
    t38 = (t36 ^ t37);
    t39 = *((unsigned int *)t8);
    t40 = *((unsigned int *)t9);
    t45 = (t39 ^ t40);
    t46 = (t38 | t45);
    t47 = *((unsigned int *)t8);
    t48 = *((unsigned int *)t9);
    t49 = (t47 | t48);
    t50 = (~(t49));
    t51 = (t46 & t50);
    if (t51 != 0)
        goto LAB16;

LAB13:    if (t49 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t27) = 1;

LAB16:    t11 = (t27 + 4);
    t52 = *((unsigned int *)t11);
    t53 = (~(t52));
    t54 = *((unsigned int *)t27);
    t55 = (t54 & t53);
    t56 = (t55 != 0);
    if (t56 > 0)
        goto LAB17;

LAB18:
LAB19:    xsi_set_current_line(115, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t27, 0, 8);
    xsi_vlog_signed_add(t27, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t27, 0, 0, 32);
    goto LAB11;

LAB15:    t10 = (t27 + 4);
    *((unsigned int *)t27) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB16;

LAB17:    xsi_set_current_line(111, ng80);

LAB20:    xsi_set_current_line(112, ng80);
    t12 = (t1 + 4776);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t12);
    xsi_set_current_line(113, ng80);
    xsi_vlog_stop(1);
    goto LAB19;

}

static int sp_check_lock_type(char *t1, char *t2)
{
    char t11[8];
    char t21[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 5208);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(131, ng80);

LAB5:    xsi_set_current_line(132, ng80);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng83)));
    memset(t11, 0, 8);
    t12 = (t9 + 4);
    if (*((unsigned int *)t12) != 0)
        goto LAB7;

LAB6:    t13 = (t10 + 4);
    if (*((unsigned int *)t13) != 0)
        goto LAB7;

LAB10:    if (*((unsigned int *)t9) > *((unsigned int *)t10))
        goto LAB8;

LAB9:    t15 = (t11 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (~(t16));
    t18 = *((unsigned int *)t11);
    t19 = (t18 & t17);
    t20 = (t19 != 0);
    if (t20 > 0)
        goto LAB11;

LAB12:
LAB13:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    t14 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t14) = 1;
    goto LAB9;

LAB8:    *((unsigned int *)t11) = 1;
    goto LAB9;

LAB11:    xsi_set_current_line(132, ng80);

LAB14:    xsi_set_current_line(133, ng80);
    t22 = xsi_vlog_time(t21, 10000.000000000000, 1000.0000000000000);
    t23 = ((char*)((ng56)));
    t24 = (t1 + 5208);
    xsi_vlogfile_write(1, 0, 0, ng95, 3, t24, (char)118, t21, 64, (char)118, t23, 56);
    xsi_set_current_line(134, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t7);
    t18 = (t16 ^ t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t9);
    t25 = (t19 ^ t20);
    t26 = (t18 | t25);
    t27 = *((unsigned int *)t8);
    t28 = *((unsigned int *)t9);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB18;

LAB15:    if (t29 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t11) = 1;

LAB18:    t12 = (t11 + 4);
    t32 = *((unsigned int *)t12);
    t33 = (~(t32));
    t34 = *((unsigned int *)t11);
    t35 = (t34 & t33);
    t36 = (t35 != 0);
    if (t36 > 0)
        goto LAB19;

LAB20:
LAB21:    xsi_set_current_line(138, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB13;

LAB17:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(134, ng80);

LAB22:    xsi_set_current_line(135, ng80);
    t13 = (t1 + 5208);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t13);
    xsi_set_current_line(136, ng80);
    xsi_vlog_stop(1);
    goto LAB21;

}

static int sp_check_cache_type(char *t1, char *t2)
{
    char t16[8];
    char t34[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 5640);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(160, ng80);

LAB5:    xsi_set_current_line(161, ng80);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);

LAB6:    t10 = ((char*)((ng96)));
    t11 = xsi_vlog_unsigned_case_compare(t9, 4, t10, 4);
    if (t11 == 1)
        goto LAB7;

LAB8:    t4 = ((char*)((ng98)));
    t11 = xsi_vlog_unsigned_case_compare(t9, 4, t4, 4);
    if (t11 == 1)
        goto LAB9;

LAB10:    t4 = ((char*)((ng99)));
    t11 = xsi_vlog_unsigned_case_compare(t9, 4, t4, 4);
    if (t11 == 1)
        goto LAB11;

LAB12:    t4 = ((char*)((ng100)));
    t11 = xsi_vlog_unsigned_case_compare(t9, 4, t4, 4);
    if (t11 == 1)
        goto LAB13;

LAB14:    t4 = ((char*)((ng101)));
    t11 = xsi_vlog_unsigned_case_compare(t9, 4, t4, 4);
    if (t11 == 1)
        goto LAB15;

LAB16:    t4 = ((char*)((ng102)));
    t11 = xsi_vlog_unsigned_case_compare(t9, 4, t4, 4);
    if (t11 == 1)
        goto LAB17;

LAB18:
LAB20:
LAB19:    xsi_set_current_line(168, ng80);
    t4 = ((char*)((ng86)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 160U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);

LAB21:    xsi_set_current_line(171, ng80);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng97)));
    memset(t16, 0, 8);
    t12 = (t8 + 4);
    t13 = (t10 + 4);
    t17 = *((unsigned int *)t8);
    t18 = *((unsigned int *)t10);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t12);
    t21 = *((unsigned int *)t13);
    t22 = (t20 ^ t21);
    t23 = (t19 | t22);
    t24 = *((unsigned int *)t12);
    t25 = *((unsigned int *)t13);
    t26 = (t24 | t25);
    t27 = (~(t26));
    t28 = (t23 & t27);
    if (t28 != 0)
        goto LAB25;

LAB22:    if (t26 != 0)
        goto LAB24;

LAB23:    *((unsigned int *)t16) = 1;

LAB25:    t15 = (t16 + 4);
    t29 = *((unsigned int *)t15);
    t30 = (~(t29));
    t31 = *((unsigned int *)t16);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB26;

LAB27:
LAB28:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    xsi_set_current_line(162, ng80);
    t12 = ((char*)((ng97)));
    t13 = (t2 + 96U);
    t14 = *((char **)t13);
    t15 = (t14 + 160U);
    xsi_vlogvar_assign_value(t15, t12, 0, 0, 1);
    goto LAB21;

LAB9:    xsi_set_current_line(163, ng80);
    t5 = ((char*)((ng97)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB21;

LAB11:    xsi_set_current_line(164, ng80);
    t5 = ((char*)((ng97)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB21;

LAB13:    xsi_set_current_line(165, ng80);
    t5 = ((char*)((ng97)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB21;

LAB15:    xsi_set_current_line(166, ng80);
    t5 = ((char*)((ng97)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB21;

LAB17:    xsi_set_current_line(167, ng80);
    t5 = ((char*)((ng97)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    goto LAB21;

LAB24:    t14 = (t16 + 4);
    *((unsigned int *)t16) = 1;
    *((unsigned int *)t14) = 1;
    goto LAB25;

LAB26:    xsi_set_current_line(171, ng80);

LAB29:    xsi_set_current_line(172, ng80);
    t35 = xsi_vlog_time(t34, 10000.000000000000, 1000.0000000000000);
    t36 = ((char*)((ng56)));
    t37 = (t2 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    t40 = (t39 + 56U);
    t41 = *((char **)t40);
    t42 = (t1 + 5640);
    xsi_vlogfile_write(1, 0, 0, ng103, 4, t42, (char)118, t34, 64, (char)118, t36, 56, (char)118, t41, 4);
    xsi_set_current_line(173, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t16, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t7);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t8);
    t21 = *((unsigned int *)t10);
    t22 = (t20 ^ t21);
    t23 = (t19 | t22);
    t24 = *((unsigned int *)t8);
    t25 = *((unsigned int *)t10);
    t26 = (t24 | t25);
    t27 = (~(t26));
    t28 = (t23 & t27);
    if (t28 != 0)
        goto LAB33;

LAB30:    if (t26 != 0)
        goto LAB32;

LAB31:    *((unsigned int *)t16) = 1;

LAB33:    t13 = (t16 + 4);
    t29 = *((unsigned int *)t13);
    t30 = (~(t29));
    t31 = *((unsigned int *)t16);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB34;

LAB35:
LAB36:    xsi_set_current_line(177, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t16, 0, 8);
    xsi_vlog_signed_add(t16, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t16, 0, 0, 32);
    goto LAB28;

LAB32:    t12 = (t16 + 4);
    *((unsigned int *)t16) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB33;

LAB34:    xsi_set_current_line(173, ng80);

LAB37:    xsi_set_current_line(174, ng80);
    t14 = (t1 + 5640);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t14);
    xsi_set_current_line(175, ng80);
    xsi_vlog_stop(1);
    goto LAB36;

}

static int sp_check_address(char *t1, char *t2)
{
    char t27[8];
    char t34[8];
    char t35[8];
    char t44[8];
    char t50[8];
    char t81[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    int t23;
    char *t24;
    char *t25;
    char *t26;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    char *t82;
    char *t83;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 6072);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(196, ng80);

LAB5:    xsi_set_current_line(197, ng80);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 320U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t1 + 6504);
    t13 = xsi_create_subprogram_invocation(t11, 0, t1, t12, 0, t2);
    t14 = (t1 + 31760);
    xsi_vlogvar_assign_value(t14, t9, 0, 0, 3);

LAB6:    t15 = (t2 + 64U);
    t16 = *((char **)t15);
    t17 = (t16 + 80U);
    t18 = *((char **)t17);
    t19 = (t18 + 272U);
    t20 = *((char **)t19);
    t21 = (t20 + 0U);
    t22 = *((char **)t21);
    t23 = ((int  (*)(char *, char *))t22)(t1, t16);
    if (t23 != 0)
        goto LAB8;

LAB7:    t16 = (t2 + 64U);
    t24 = *((char **)t16);
    t16 = (t1 + 31600);
    t25 = (t16 + 56U);
    t26 = *((char **)t25);
    memcpy(t27, t26, 8);
    t28 = (t1 + 6504);
    t29 = (t2 + 56U);
    t30 = *((char **)t29);
    xsi_delete_subprogram_invocation(t28, t24, t1, t30, t2);
    t31 = (t2 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 640U);
    xsi_vlogvar_assign_value(t33, t27, 0, 0, 32);
    xsi_set_current_line(198, ng80);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 96U);
    t10 = *((char **)t9);
    t11 = (t10 + 0U);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t2 + 96U);
    t15 = *((char **)t14);
    t16 = (t15 + 640U);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memset(t27, 0, 8);
    xsi_vlog_unsigned_divide(t27, 32, t13, 32, t18, 32);
    t19 = (t2 + 96U);
    t20 = *((char **)t19);
    t21 = (t20 + 640U);
    t22 = (t21 + 56U);
    t24 = *((char **)t22);
    memset(t34, 0, 8);
    xsi_vlog_unsigned_multiply(t34, 32, t27, 32, t24, 32);
    memset(t35, 0, 8);
    xsi_vlog_unsigned_minus(t35, 32, t8, 32, t34, 32);
    t25 = (t2 + 96U);
    t26 = *((char **)t25);
    t28 = (t26 + 480U);
    xsi_vlogvar_assign_value(t28, t35, 0, 0, 32);
    xsi_set_current_line(199, ng80);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng85)));
    memset(t27, 0, 8);
    if (*((unsigned int *)t8) != *((unsigned int *)t9))
        goto LAB11;

LAB9:    t10 = (t8 + 4);
    t11 = (t9 + 4);
    if (*((unsigned int *)t10) != *((unsigned int *)t11))
        goto LAB11;

LAB10:    *((unsigned int *)t27) = 1;

LAB11:    memset(t34, 0, 8);
    t12 = (t27 + 4);
    t36 = *((unsigned int *)t12);
    t37 = (~(t36));
    t38 = *((unsigned int *)t27);
    t39 = (t38 & t37);
    t40 = (t39 & 1U);
    if (t40 != 0)
        goto LAB12;

LAB13:    if (*((unsigned int *)t12) != 0)
        goto LAB14;

LAB15:    t14 = (t34 + 4);
    t41 = *((unsigned int *)t34);
    t42 = *((unsigned int *)t14);
    t43 = (t41 || t42);
    if (t43 > 0)
        goto LAB16;

LAB17:    memcpy(t50, t34, 8);

LAB18:    t32 = (t50 + 4);
    t76 = *((unsigned int *)t32);
    t77 = (~(t76));
    t78 = *((unsigned int *)t50);
    t79 = (t78 & t77);
    t80 = (t79 != 0);
    if (t80 > 0)
        goto LAB29;

LAB30:
LAB31:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t15 = (t2 + 48U);
    *((char **)t15) = &&LAB6;
    goto LAB1;

LAB12:    *((unsigned int *)t34) = 1;
    goto LAB15;

LAB14:    t13 = (t34 + 4);
    *((unsigned int *)t34) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB15;

LAB16:    t15 = (t2 + 96U);
    t16 = *((char **)t15);
    t17 = (t16 + 480U);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = ((char*)((ng104)));
    memset(t35, 0, 8);
    if (*((unsigned int *)t19) != *((unsigned int *)t20))
        goto LAB20;

LAB19:    t21 = (t19 + 4);
    t22 = (t20 + 4);
    if (*((unsigned int *)t21) != *((unsigned int *)t22))
        goto LAB20;

LAB21:    memset(t44, 0, 8);
    t24 = (t35 + 4);
    t45 = *((unsigned int *)t24);
    t46 = (~(t45));
    t47 = *((unsigned int *)t35);
    t48 = (t47 & t46);
    t49 = (t48 & 1U);
    if (t49 != 0)
        goto LAB22;

LAB23:    if (*((unsigned int *)t24) != 0)
        goto LAB24;

LAB25:    t51 = *((unsigned int *)t34);
    t52 = *((unsigned int *)t44);
    t53 = (t51 & t52);
    *((unsigned int *)t50) = t53;
    t26 = (t34 + 4);
    t28 = (t44 + 4);
    t29 = (t50 + 4);
    t54 = *((unsigned int *)t26);
    t55 = *((unsigned int *)t28);
    t56 = (t54 | t55);
    *((unsigned int *)t29) = t56;
    t57 = *((unsigned int *)t29);
    t58 = (t57 != 0);
    if (t58 == 1)
        goto LAB26;

LAB27:
LAB28:    goto LAB18;

LAB20:    *((unsigned int *)t35) = 1;
    goto LAB21;

LAB22:    *((unsigned int *)t44) = 1;
    goto LAB25;

LAB24:    t25 = (t44 + 4);
    *((unsigned int *)t44) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB25;

LAB26:    t59 = *((unsigned int *)t50);
    t60 = *((unsigned int *)t29);
    *((unsigned int *)t50) = (t59 | t60);
    t30 = (t34 + 4);
    t31 = (t44 + 4);
    t61 = *((unsigned int *)t34);
    t62 = (~(t61));
    t63 = *((unsigned int *)t30);
    t64 = (~(t63));
    t65 = *((unsigned int *)t44);
    t66 = (~(t65));
    t67 = *((unsigned int *)t31);
    t68 = (~(t67));
    t23 = (t62 & t64);
    t69 = (t66 & t68);
    t70 = (~(t23));
    t71 = (~(t69));
    t72 = *((unsigned int *)t29);
    *((unsigned int *)t29) = (t72 & t70);
    t73 = *((unsigned int *)t29);
    *((unsigned int *)t29) = (t73 & t71);
    t74 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t74 & t70);
    t75 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t75 & t71);
    goto LAB28;

LAB29:    xsi_set_current_line(199, ng80);

LAB32:    xsi_set_current_line(200, ng80);
    t33 = xsi_vlog_time(t81, 10000.000000000000, 1000.0000000000000);
    t82 = ((char*)((ng56)));
    t83 = (t1 + 6072);
    xsi_vlogfile_write(1, 0, 0, ng105, 3, t83, (char)118, t81, 64, (char)118, t82, 56);
    xsi_set_current_line(201, ng80);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t27, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t36 = *((unsigned int *)t6);
    t37 = *((unsigned int *)t7);
    t38 = (t36 ^ t37);
    t39 = *((unsigned int *)t8);
    t40 = *((unsigned int *)t9);
    t41 = (t39 ^ t40);
    t42 = (t38 | t41);
    t43 = *((unsigned int *)t8);
    t45 = *((unsigned int *)t9);
    t46 = (t43 | t45);
    t47 = (~(t46));
    t48 = (t42 & t47);
    if (t48 != 0)
        goto LAB36;

LAB33:    if (t46 != 0)
        goto LAB35;

LAB34:    *((unsigned int *)t27) = 1;

LAB36:    t11 = (t27 + 4);
    t49 = *((unsigned int *)t11);
    t51 = (~(t49));
    t52 = *((unsigned int *)t27);
    t53 = (t52 & t51);
    t54 = (t53 != 0);
    if (t54 > 0)
        goto LAB37;

LAB38:
LAB39:    xsi_set_current_line(205, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t27, 0, 8);
    xsi_vlog_signed_add(t27, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t27, 0, 0, 32);
    goto LAB31;

LAB35:    t10 = (t27 + 4);
    *((unsigned int *)t27) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB36;

LAB37:    xsi_set_current_line(201, ng80);

LAB40:    xsi_set_current_line(202, ng80);
    t12 = (t1 + 6072);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t12);
    xsi_set_current_line(203, ng80);
    xsi_vlog_stop(1);
    goto LAB39;

}

static int sp_transfer_size_in_bytes(char *t1, char *t2)
{
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int t7;
    char *t8;
    char *t9;

LAB0:    t0 = 1;
    xsi_set_current_line(220, ng80);

LAB2:    xsi_set_current_line(221, ng80);
    t3 = (t1 + 31760);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);

LAB3:    t6 = ((char*)((ng97)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t6, 3);
    if (t7 == 1)
        goto LAB4;

LAB5:    t3 = ((char*)((ng86)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB6;

LAB7:    t3 = ((char*)((ng85)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB8;

LAB9:    t3 = ((char*)((ng81)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB10;

LAB11:    t3 = ((char*)((ng96)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB12;

LAB13:    t3 = ((char*)((ng98)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB14;

LAB15:    t3 = ((char*)((ng109)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB16;

LAB17:    t3 = ((char*)((ng87)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 3, t3, 3);
    if (t7 == 1)
        goto LAB18;

LAB19:
LAB20:    t0 = 0;

LAB1:    return t0;
LAB4:    xsi_set_current_line(222, ng80);
    t8 = ((char*)((ng83)));
    t9 = (t1 + 31600);
    xsi_vlogvar_assign_value(t9, t8, 0, 0, 32);
    goto LAB20;

LAB6:    xsi_set_current_line(223, ng80);
    t4 = ((char*)((ng106)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

LAB8:    xsi_set_current_line(224, ng80);
    t4 = ((char*)((ng107)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

LAB10:    xsi_set_current_line(225, ng80);
    t4 = ((char*)((ng93)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

LAB12:    xsi_set_current_line(226, ng80);
    t4 = ((char*)((ng90)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

LAB14:    xsi_set_current_line(227, ng80);
    t4 = ((char*)((ng108)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

LAB16:    xsi_set_current_line(228, ng80);
    t4 = ((char*)((ng110)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

LAB18:    xsi_set_current_line(229, ng80);
    t4 = ((char*)((ng111)));
    t6 = (t1 + 31600);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    goto LAB20;

}

static int sp_decode_burst_length(char *t1, char *t2)
{
    char t6[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;

LAB0:    t0 = 1;
    xsi_set_current_line(244, ng80);

LAB2:    xsi_set_current_line(246, ng80);
    t3 = (t1 + 32080);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memcpy(t6, t5, 8);
    t7 = (t1 + 31920);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    xsi_set_current_line(247, ng80);
    t3 = (t1 + 31920);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = ((char*)((ng83)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t5, 32, t7, 32);
    t8 = (t1 + 31920);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 32);
    t0 = 0;

LAB1:    return t0;
}

static int sp_calculate_strobe(char *t1, char *t2)
{
    char t7[8];
    char t28[8];
    char t38[8];
    char t51[8];
    char t57[8];
    char t87[8];
    char t94[8];
    char t95[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    char *t84;
    char *t85;
    char *t86;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t96;

LAB0:    t0 = 1;
    xsi_set_current_line(282, ng80);

LAB2:    xsi_set_current_line(284, ng80);
    t3 = (t1 + 32400);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_signed_add(t7, 32, t5, 32, t6, 32);
    t8 = (t1 + 32400);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 32);
    xsi_set_current_line(286, ng80);
    t3 = (t1 + 32560);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 33200);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    xsi_set_current_line(287, ng80);
    t3 = (t1 + 32880);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t8 = *((char **)t6);
    t9 = (t1 + 6504);
    t10 = xsi_create_subprogram_invocation(t8, 0, t1, t9, 0, t2);
    t11 = (t1 + 31760);
    xsi_vlogvar_assign_value(t11, t5, 0, 0, 3);

LAB3:    t12 = (t2 + 64U);
    t13 = *((char **)t12);
    t14 = (t13 + 80U);
    t15 = *((char **)t14);
    t16 = (t15 + 272U);
    t17 = *((char **)t16);
    t18 = (t17 + 0U);
    t19 = *((char **)t18);
    t20 = ((int  (*)(char *, char *))t19)(t1, t13);
    if (t20 != 0)
        goto LAB5;

LAB4:    t13 = (t2 + 64U);
    t21 = *((char **)t13);
    t13 = (t1 + 31600);
    t22 = (t13 + 56U);
    t23 = *((char **)t22);
    memcpy(t7, t23, 8);
    t24 = (t1 + 6504);
    t25 = (t2 + 56U);
    t26 = *((char **)t25);
    xsi_delete_subprogram_invocation(t24, t21, t1, t26, t2);
    t27 = (t1 + 33360);
    xsi_vlogvar_assign_value(t27, t7, 0, 0, 32);
    xsi_set_current_line(288, ng80);
    t3 = (t1 + 32720);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t8 = *((char **)t6);
    t9 = (t1 + 6936);
    t10 = xsi_create_subprogram_invocation(t8, 0, t1, t9, 0, t2);
    t11 = (t1 + 32080);
    xsi_vlogvar_assign_value(t11, t5, 0, 0, 8);

LAB6:    t12 = (t2 + 64U);
    t13 = *((char **)t12);
    t14 = (t13 + 80U);
    t15 = *((char **)t14);
    t16 = (t15 + 272U);
    t17 = *((char **)t16);
    t18 = (t17 + 0U);
    t19 = *((char **)t18);
    t20 = ((int  (*)(char *, char *))t19)(t1, t13);
    if (t20 != 0)
        goto LAB8;

LAB7:    t13 = (t2 + 64U);
    t21 = *((char **)t13);
    t13 = (t1 + 31920);
    t22 = (t13 + 56U);
    t23 = *((char **)t22);
    memcpy(t7, t23, 8);
    t24 = (t1 + 6936);
    t25 = (t2 + 56U);
    t26 = *((char **)t25);
    xsi_delete_subprogram_invocation(t24, t21, t1, t26, t2);
    t27 = (t1 + 33840);
    xsi_vlogvar_assign_value(t27, t7, 0, 0, 32);
    xsi_set_current_line(289, ng80);
    t3 = (t1 + 33200);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 33360);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_divide(t7, 32, t5, 32, t9, 32);
    t10 = (t1 + 33360);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_multiply(t28, 32, t7, 32, t12, 32);
    t13 = (t1 + 33680);
    xsi_vlogvar_assign_value(t13, t28, 0, 0, 32);
    xsi_set_current_line(290, ng80);
    t3 = (t1 + 1200);
    t4 = *((char **)t3);
    t3 = ((char*)((ng93)));
    memset(t7, 0, 8);
    xsi_vlog_signed_divide(t7, 32, t4, 32, t3, 32);
    t5 = (t1 + 33520);
    xsi_vlogvar_assign_value(t5, t7, 0, 0, 32);
    xsi_set_current_line(294, ng80);
    t3 = (t1 + 32400);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_signed_equal(t7, 32, t5, 32, t6, 32);
    memset(t28, 0, 8);
    t8 = (t7 + 4);
    t29 = *((unsigned int *)t8);
    t30 = (~(t29));
    t31 = *((unsigned int *)t7);
    t32 = (t31 & t30);
    t33 = (t32 & 1U);
    if (t33 != 0)
        goto LAB9;

LAB10:    if (*((unsigned int *)t8) != 0)
        goto LAB11;

LAB12:    t10 = (t28 + 4);
    t34 = *((unsigned int *)t28);
    t35 = (!(t34));
    t36 = *((unsigned int *)t10);
    t37 = (t35 || t36);
    if (t37 > 0)
        goto LAB13;

LAB14:    memcpy(t57, t28, 8);

LAB15:    t26 = (t57 + 4);
    t79 = *((unsigned int *)t26);
    t80 = (~(t79));
    t81 = *((unsigned int *)t57);
    t82 = (t81 & t80);
    t83 = (t82 != 0);
    if (t83 > 0)
        goto LAB27;

LAB28:    xsi_set_current_line(305, ng80);

LAB31:    xsi_set_current_line(307, ng80);
    t3 = (t1 + 33680);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 32400);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_minus(t7, 32, t9, 32, t10, 32);
    t11 = (t1 + 33360);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_multiply(t28, 32, t7, 32, t13, 32);
    memset(t38, 0, 8);
    xsi_vlog_unsigned_add(t38, 32, t5, 32, t28, 32);
    t14 = (t1 + 34000);
    xsi_vlogvar_assign_value(t14, t38, 0, 0, 32);
    xsi_set_current_line(310, ng80);
    t3 = (t1 + 33040);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng85)));
    memset(t7, 0, 8);
    t8 = (t5 + 4);
    t9 = (t6 + 4);
    t29 = *((unsigned int *)t5);
    t30 = *((unsigned int *)t6);
    t31 = (t29 ^ t30);
    t32 = *((unsigned int *)t8);
    t33 = *((unsigned int *)t9);
    t34 = (t32 ^ t33);
    t35 = (t31 | t34);
    t36 = *((unsigned int *)t8);
    t37 = *((unsigned int *)t9);
    t39 = (t36 | t37);
    t40 = (~(t39));
    t41 = (t35 & t40);
    if (t41 != 0)
        goto LAB35;

LAB32:    if (t39 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t7) = 1;

LAB35:    t11 = (t7 + 4);
    t42 = *((unsigned int *)t11);
    t43 = (~(t42));
    t44 = *((unsigned int *)t7);
    t45 = (t44 & t43);
    t46 = (t45 != 0);
    if (t46 > 0)
        goto LAB36;

LAB37:
LAB38:    xsi_set_current_line(323, ng80);
    t3 = (t1 + 34000);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 34000);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 33520);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_divide(t7, 32, t9, 32, t12, 32);
    t13 = (t1 + 33520);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_multiply(t28, 32, t7, 32, t15, 32);
    memset(t38, 0, 8);
    xsi_vlog_unsigned_minus(t38, 32, t5, 32, t28, 32);
    t16 = (t1 + 34320);
    xsi_vlogvar_assign_value(t16, t38, 0, 0, 32);
    xsi_set_current_line(324, ng80);
    t3 = (t1 + 34320);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 33360);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 32, t9, 32);
    t10 = ((char*)((ng83)));
    memset(t28, 0, 8);
    xsi_vlog_unsigned_minus(t28, 32, t7, 32, t10, 32);
    t11 = (t1 + 34480);
    xsi_vlogvar_assign_value(t11, t28, 0, 0, 32);

LAB29:    xsi_set_current_line(331, ng80);
    t3 = ((char*)((ng104)));
    t4 = (t1 + 32240);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 4);
    xsi_set_current_line(333, ng80);
    xsi_set_current_line(333, ng80);
    t3 = (t1 + 34320);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 34640);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);

LAB58:    t3 = (t1 + 34640);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 34480);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memset(t7, 0, 8);
    t10 = (t5 + 4);
    if (*((unsigned int *)t10) != 0)
        goto LAB60;

LAB59:    t11 = (t9 + 4);
    if (*((unsigned int *)t11) != 0)
        goto LAB60;

LAB63:    if (*((unsigned int *)t5) > *((unsigned int *)t9))
        goto LAB62;

LAB61:    *((unsigned int *)t7) = 1;

LAB62:    t13 = (t7 + 4);
    t29 = *((unsigned int *)t13);
    t30 = (~(t29));
    t31 = *((unsigned int *)t7);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB64;

LAB65:    t0 = 0;

LAB1:    return t0;
LAB5:    t12 = (t2 + 48U);
    *((char **)t12) = &&LAB3;
    goto LAB1;

LAB8:    t12 = (t2 + 48U);
    *((char **)t12) = &&LAB6;
    goto LAB1;

LAB9:    *((unsigned int *)t28) = 1;
    goto LAB12;

LAB11:    t9 = (t28 + 4);
    *((unsigned int *)t28) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB12;

LAB13:    t11 = (t1 + 33040);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = ((char*)((ng97)));
    memset(t38, 0, 8);
    t15 = (t13 + 4);
    t16 = (t14 + 4);
    t39 = *((unsigned int *)t13);
    t40 = *((unsigned int *)t14);
    t41 = (t39 ^ t40);
    t42 = *((unsigned int *)t15);
    t43 = *((unsigned int *)t16);
    t44 = (t42 ^ t43);
    t45 = (t41 | t44);
    t46 = *((unsigned int *)t15);
    t47 = *((unsigned int *)t16);
    t48 = (t46 | t47);
    t49 = (~(t48));
    t50 = (t45 & t49);
    if (t50 != 0)
        goto LAB19;

LAB16:    if (t48 != 0)
        goto LAB18;

LAB17:    *((unsigned int *)t38) = 1;

LAB19:    memset(t51, 0, 8);
    t18 = (t38 + 4);
    t52 = *((unsigned int *)t18);
    t53 = (~(t52));
    t54 = *((unsigned int *)t38);
    t55 = (t54 & t53);
    t56 = (t55 & 1U);
    if (t56 != 0)
        goto LAB20;

LAB21:    if (*((unsigned int *)t18) != 0)
        goto LAB22;

LAB23:    t58 = *((unsigned int *)t28);
    t59 = *((unsigned int *)t51);
    t60 = (t58 | t59);
    *((unsigned int *)t57) = t60;
    t21 = (t28 + 4);
    t22 = (t51 + 4);
    t23 = (t57 + 4);
    t61 = *((unsigned int *)t21);
    t62 = *((unsigned int *)t22);
    t63 = (t61 | t62);
    *((unsigned int *)t23) = t63;
    t64 = *((unsigned int *)t23);
    t65 = (t64 != 0);
    if (t65 == 1)
        goto LAB24;

LAB25:
LAB26:    goto LAB15;

LAB18:    t17 = (t38 + 4);
    *((unsigned int *)t38) = 1;
    *((unsigned int *)t17) = 1;
    goto LAB19;

LAB20:    *((unsigned int *)t51) = 1;
    goto LAB23;

LAB22:    t19 = (t51 + 4);
    *((unsigned int *)t51) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB23;

LAB24:    t66 = *((unsigned int *)t57);
    t67 = *((unsigned int *)t23);
    *((unsigned int *)t57) = (t66 | t67);
    t24 = (t28 + 4);
    t25 = (t51 + 4);
    t68 = *((unsigned int *)t24);
    t69 = (~(t68));
    t70 = *((unsigned int *)t28);
    t20 = (t70 & t69);
    t71 = *((unsigned int *)t25);
    t72 = (~(t71));
    t73 = *((unsigned int *)t51);
    t74 = (t73 & t72);
    t75 = (~(t20));
    t76 = (~(t74));
    t77 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t77 & t75);
    t78 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t78 & t76);
    goto LAB26;

LAB27:    xsi_set_current_line(294, ng80);

LAB30:    xsi_set_current_line(296, ng80);
    t27 = (t1 + 33200);
    t84 = (t27 + 56U);
    t85 = *((char **)t84);
    t86 = (t1 + 34000);
    xsi_vlogvar_assign_value(t86, t85, 0, 0, 32);
    xsi_set_current_line(301, ng80);
    t3 = (t1 + 33200);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 33200);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 33520);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_divide(t7, 32, t9, 32, t12, 32);
    t13 = (t1 + 33520);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_multiply(t28, 32, t7, 32, t15, 32);
    memset(t38, 0, 8);
    xsi_vlog_unsigned_minus(t38, 32, t5, 32, t28, 32);
    t16 = (t1 + 34320);
    xsi_vlogvar_assign_value(t16, t38, 0, 0, 32);
    xsi_set_current_line(302, ng80);
    t3 = (t1 + 33680);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 33360);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_minus(t7, 32, t9, 32, t10, 32);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_add(t28, 32, t5, 32, t7, 32);
    t11 = (t1 + 33200);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t1 + 33520);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memset(t38, 0, 8);
    xsi_vlog_unsigned_divide(t38, 32, t13, 32, t16, 32);
    t17 = (t1 + 33520);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t51, 0, 8);
    xsi_vlog_unsigned_multiply(t51, 32, t38, 32, t19, 32);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_minus(t57, 32, t28, 32, t51, 32);
    t21 = (t1 + 34480);
    xsi_vlogvar_assign_value(t21, t57, 0, 0, 32);
    goto LAB29;

LAB34:    t10 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB35;

LAB36:    xsi_set_current_line(310, ng80);

LAB39:    xsi_set_current_line(311, ng80);
    t12 = (t1 + 33200);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t1 + 33360);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t1 + 33840);
    t19 = (t18 + 56U);
    t21 = *((char **)t19);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_multiply(t28, 32, t17, 32, t21, 32);
    memset(t38, 0, 8);
    xsi_vlog_unsigned_divide(t38, 32, t14, 32, t28, 32);
    t22 = (t1 + 33360);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t1 + 33840);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    memset(t51, 0, 8);
    xsi_vlog_unsigned_multiply(t51, 32, t24, 32, t27, 32);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_multiply(t57, 32, t38, 32, t51, 32);
    t84 = (t1 + 34160);
    xsi_vlogvar_assign_value(t84, t57, 0, 0, 32);
    xsi_set_current_line(312, ng80);
    t3 = (t1 + 34000);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 34160);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 33360);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 33840);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_multiply(t7, 32, t12, 32, t15, 32);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_add(t28, 32, t9, 32, t7, 32);
    memset(t38, 0, 8);
    t16 = (t5 + 4);
    t17 = (t28 + 4);
    t29 = *((unsigned int *)t5);
    t30 = *((unsigned int *)t28);
    t31 = (t29 ^ t30);
    t32 = *((unsigned int *)t16);
    t33 = *((unsigned int *)t17);
    t34 = (t32 ^ t33);
    t35 = (t31 | t34);
    t36 = *((unsigned int *)t16);
    t37 = *((unsigned int *)t17);
    t39 = (t36 | t37);
    t40 = (~(t39));
    t41 = (t35 & t40);
    if (t41 != 0)
        goto LAB43;

LAB40:    if (t39 != 0)
        goto LAB42;

LAB41:    *((unsigned int *)t38) = 1;

LAB43:    t19 = (t38 + 4);
    t42 = *((unsigned int *)t19);
    t43 = (~(t42));
    t44 = *((unsigned int *)t38);
    t45 = (t44 & t43);
    t46 = (t45 != 0);
    if (t46 > 0)
        goto LAB44;

LAB45:    xsi_set_current_line(315, ng80);

LAB48:    xsi_set_current_line(317, ng80);
    t3 = (t1 + 34000);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t1 + 34160);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 33360);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 33840);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_multiply(t7, 32, t12, 32, t15, 32);
    memset(t28, 0, 8);
    xsi_vlog_unsigned_add(t28, 32, t9, 32, t7, 32);
    memset(t38, 0, 8);
    t16 = (t5 + 4);
    if (*((unsigned int *)t16) != 0)
        goto LAB50;

LAB49:    t17 = (t28 + 4);
    if (*((unsigned int *)t17) != 0)
        goto LAB50;

LAB53:    if (*((unsigned int *)t5) > *((unsigned int *)t28))
        goto LAB51;

LAB52:    t19 = (t38 + 4);
    t29 = *((unsigned int *)t19);
    t30 = (~(t29));
    t31 = *((unsigned int *)t38);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB54;

LAB55:
LAB56:
LAB46:    goto LAB38;

LAB42:    t18 = (t38 + 4);
    *((unsigned int *)t38) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB43;

LAB44:    xsi_set_current_line(312, ng80);

LAB47:    xsi_set_current_line(313, ng80);
    t21 = (t1 + 34160);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t1 + 34000);
    xsi_vlogvar_assign_value(t24, t23, 0, 0, 32);
    goto LAB46;

LAB50:    t18 = (t38 + 4);
    *((unsigned int *)t38) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB52;

LAB51:    *((unsigned int *)t38) = 1;
    goto LAB52;

LAB54:    xsi_set_current_line(317, ng80);

LAB57:    xsi_set_current_line(318, ng80);
    t21 = (t1 + 33200);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t1 + 32400);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = ((char*)((ng83)));
    memset(t51, 0, 8);
    xsi_vlog_unsigned_minus(t51, 32, t26, 32, t27, 32);
    t84 = (t1 + 33360);
    t85 = (t84 + 56U);
    t86 = *((char **)t85);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_multiply(t57, 32, t51, 32, t86, 32);
    memset(t87, 0, 8);
    xsi_vlog_unsigned_add(t87, 32, t23, 32, t57, 32);
    t88 = (t1 + 33360);
    t89 = (t88 + 56U);
    t90 = *((char **)t89);
    t91 = (t1 + 33840);
    t92 = (t91 + 56U);
    t93 = *((char **)t92);
    memset(t94, 0, 8);
    xsi_vlog_unsigned_multiply(t94, 32, t90, 32, t93, 32);
    memset(t95, 0, 8);
    xsi_vlog_unsigned_minus(t95, 32, t87, 32, t94, 32);
    t96 = (t1 + 34000);
    xsi_vlogvar_assign_value(t96, t95, 0, 0, 32);
    goto LAB56;

LAB60:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB62;

LAB64:    xsi_set_current_line(333, ng80);

LAB66:    xsi_set_current_line(334, ng80);
    t14 = ((char*)((ng83)));
    t15 = (t1 + 32240);
    t16 = (t1 + 32240);
    t17 = (t16 + 72U);
    t18 = *((char **)t17);
    t19 = (t1 + 34640);
    t21 = (t19 + 56U);
    t22 = *((char **)t21);
    xsi_vlog_generic_convert_bit_index(t28, t18, 2, t22, 32, 1);
    t23 = (t28 + 4);
    t34 = *((unsigned int *)t23);
    t20 = (!(t34));
    if (t20 == 1)
        goto LAB67;

LAB68:    xsi_set_current_line(333, ng80);
    t3 = (t1 + 34640);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_signed_add(t7, 32, t5, 32, t6, 32);
    t8 = (t1 + 34640);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 32);
    goto LAB58;

LAB67:    xsi_vlogvar_assign_value(t15, t14, 0, *((unsigned int *)t28), 1);
    goto LAB68;

}

static int sp_calculate_response(char *t1, char *t2)
{
    char t10[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int t7;
    char *t8;
    char *t9;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;

LAB0:    t0 = 1;
    xsi_set_current_line(352, ng80);

LAB2:    xsi_set_current_line(353, ng80);
    t3 = (t1 + 34960);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);

LAB3:    t6 = ((char*)((ng97)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 1, t6, 1);
    if (t7 == 1)
        goto LAB4;

LAB5:    t3 = ((char*)((ng86)));
    t7 = xsi_vlog_unsigned_case_compare(t5, 1, t3, 1);
    if (t7 == 1)
        goto LAB6;

LAB7:
LAB9:
LAB8:    xsi_set_current_line(363, ng80);
    t3 = ((char*)((ng85)));
    t4 = (t1 + 34800);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 2);

LAB10:    t0 = 0;

LAB1:    return t0;
LAB4:    xsi_set_current_line(354, ng80);
    t8 = ((char*)((ng97)));
    t9 = (t1 + 34800);
    xsi_vlogvar_assign_value(t9, t8, 0, 0, 2);
    goto LAB10;

LAB6:    xsi_set_current_line(355, ng80);

LAB11:    xsi_set_current_line(356, ng80);
    t4 = (t1 + 2832);
    t6 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t10, 0, 8);
    xsi_vlog_signed_equal(t10, 32, t6, 32, t4, 32);
    t8 = (t10 + 4);
    t11 = *((unsigned int *)t8);
    t12 = (~(t11));
    t13 = *((unsigned int *)t10);
    t14 = (t13 & t12);
    t15 = (t14 != 0);
    if (t15 > 0)
        goto LAB12;

LAB13:    xsi_set_current_line(359, ng80);

LAB16:    xsi_set_current_line(360, ng80);
    t3 = ((char*)((ng97)));
    t4 = (t1 + 34800);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 2);

LAB14:    goto LAB10;

LAB12:    xsi_set_current_line(356, ng80);

LAB15:    xsi_set_current_line(357, ng80);
    t9 = ((char*)((ng86)));
    t16 = (t1 + 34800);
    xsi_vlogvar_assign_value(t16, t9, 0, 0, 2);
    goto LAB14;

}

static int sp_set_channel_level_info(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 8232);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(382, ng80);

LAB5:    xsi_set_current_line(383, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 8232);
    xsi_vlogfile_write(1, 0, 0, ng112, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)118, t12, 1);
    xsi_set_current_line(384, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 27920);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_function_level_info(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 8664);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(398, ng80);

LAB5:    xsi_set_current_line(399, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 8664);
    xsi_vlogfile_write(1, 0, 0, ng113, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)118, t12, 1);
    xsi_set_current_line(400, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 28080);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_stop_on_error(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 9096);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(414, ng80);

LAB5:    xsi_set_current_line(415, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 9096);
    xsi_vlogfile_write(1, 0, 0, ng114, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)118, t12, 1);
    xsi_set_current_line(416, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 27760);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_clear_signals_after_handshake(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 9528);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(430, ng80);

LAB5:    xsi_set_current_line(431, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 9528);
    xsi_vlogfile_write(1, 0, 0, ng115, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)118, t12, 1);
    xsi_set_current_line(432, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 28240);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_response_timeout(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 9960);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(446, ng80);

LAB5:    xsi_set_current_line(447, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 9960);
    xsi_vlogfile_write(1, 0, 0, ng116, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)119, t12, 32);
    xsi_set_current_line(448, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 27440);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_task_call_and_reset_handling(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 10392);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(468, ng80);

LAB5:    xsi_set_current_line(469, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 10392);
    xsi_vlogfile_write(1, 0, 0, ng117, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)119, t12, 32);
    xsi_set_current_line(470, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 26800);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_task_reset_handling(char *t1, char *t2)
{
    char t5[8];
    char t25[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int t24;
    char *t26;
    char *t27;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 10824);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(485, ng80);

LAB5:    xsi_set_current_line(486, ng80);
    t6 = (t1 + 21120U);
    t7 = *((char **)t6);
    memset(t5, 0, 8);
    t6 = (t7 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t7);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t6) == 0)
        goto LAB6;

LAB8:    t13 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t13) = 1;

LAB9:    t14 = (t5 + 4);
    t15 = *((unsigned int *)t14);
    t16 = (~(t15));
    t17 = *((unsigned int *)t5);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB10;

LAB11:
LAB12:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB6:    *((unsigned int *)t5) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(486, ng80);

LAB13:    xsi_set_current_line(487, ng80);
    t20 = (t1 + 26800);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);

LAB14:    t23 = ((char*)((ng83)));
    t24 = xsi_vlog_signed_case_compare(t22, 32, t23, 32);
    if (t24 == 1)
        goto LAB15;

LAB16:    t4 = ((char*)((ng106)));
    t24 = xsi_vlog_signed_case_compare(t22, 32, t4, 32);
    if (t24 == 1)
        goto LAB17;

LAB18:    t4 = ((char*)((ng120)));
    t24 = xsi_vlog_signed_case_compare(t22, 32, t4, 32);
    if (t24 == 1)
        goto LAB19;

LAB20:
LAB21:    goto LAB12;

LAB15:    xsi_set_current_line(488, ng80);

LAB22:    xsi_set_current_line(489, ng80);
    t26 = xsi_vlog_time(t25, 10000.000000000000, 1000.0000000000000);
    t27 = ((char*)((ng56)));
    t28 = (t1 + 10824);
    xsi_vlogfile_write(1, 0, 0, ng118, 3, t28, (char)118, t25, 64, (char)118, t27, 56);
    xsi_set_current_line(490, ng80);

LAB23:    t4 = (t1 + 21120U);
    t6 = *((char **)t4);
    memset(t5, 0, 8);
    t4 = (t6 + 4);
    t8 = *((unsigned int *)t4);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB27;

LAB25:    if (*((unsigned int *)t4) == 0)
        goto LAB24;

LAB26:    t7 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t7) = 1;

LAB27:    t13 = (t5 + 4);
    t15 = *((unsigned int *)t13);
    t16 = (~(t15));
    t17 = *((unsigned int *)t5);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB28;

LAB29:    goto LAB21;

LAB17:    xsi_set_current_line(492, ng80);

LAB31:    xsi_set_current_line(493, ng80);
    t6 = xsi_vlog_time(t25, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t13 = (t1 + 10824);
    xsi_vlogfile_write(1, 0, 0, ng119, 3, t13, (char)118, t25, 64, (char)118, t7, 56);
    xsi_set_current_line(494, ng80);
    t4 = (t1 + 27760);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t13 = ((char*)((ng83)));
    memset(t5, 0, 8);
    t14 = (t7 + 4);
    t20 = (t13 + 4);
    t8 = *((unsigned int *)t7);
    t9 = *((unsigned int *)t13);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t14);
    t12 = *((unsigned int *)t20);
    t15 = (t11 ^ t12);
    t16 = (t10 | t15);
    t17 = *((unsigned int *)t14);
    t18 = *((unsigned int *)t20);
    t19 = (t17 | t18);
    t29 = (~(t19));
    t30 = (t16 & t29);
    if (t30 != 0)
        goto LAB35;

LAB32:    if (t19 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t5) = 1;

LAB35:    t23 = (t5 + 4);
    t31 = *((unsigned int *)t23);
    t32 = (~(t31));
    t33 = *((unsigned int *)t5);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB36;

LAB37:
LAB38:    xsi_set_current_line(498, ng80);
    t4 = (t1 + 30800);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t13 = ((char*)((ng83)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t7, 32, t13, 32);
    t14 = (t1 + 30800);
    xsi_vlogvar_assign_value(t14, t5, 0, 0, 32);
    goto LAB21;

LAB19:    xsi_set_current_line(500, ng80);

LAB40:    xsi_set_current_line(501, ng80);
    t6 = xsi_vlog_time(t25, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t13 = (t1 + 10824);
    xsi_vlogfile_write(1, 0, 0, ng121, 3, t13, (char)118, t25, 64, (char)118, t7, 56);
    xsi_set_current_line(502, ng80);
    t4 = (t1 + 30960);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t13 = ((char*)((ng83)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t7, 32, t13, 32);
    t14 = (t1 + 30960);
    xsi_vlogvar_assign_value(t14, t5, 0, 0, 32);
    goto LAB21;

LAB24:    *((unsigned int *)t5) = 1;
    goto LAB27;

LAB28:    xsi_set_current_line(490, ng80);
    t14 = (t2 + 88U);
    t20 = *((char **)t14);
    t21 = (t20 + 0U);
    xsi_wp_set_status(t21, 1);
    *((char **)t3) = &&LAB30;
    goto LAB1;

LAB30:    goto LAB23;

LAB34:    t21 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB35;

LAB36:    xsi_set_current_line(494, ng80);

LAB39:    xsi_set_current_line(495, ng80);
    t26 = (t1 + 10824);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t26);
    xsi_set_current_line(496, ng80);
    xsi_vlog_stop(1);
    goto LAB38;

}

static int sp_set_bfm_clk_delay(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 11256);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(517, ng80);

LAB5:    xsi_set_current_line(518, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 11256);
    xsi_vlogfile_write(1, 0, 0, ng122, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)119, t12, 32);
    xsi_set_current_line(519, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 26640);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_disable_reset_value_checks(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 11688);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(535, ng80);

LAB5:    xsi_set_current_line(536, ng80);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 11688);
    xsi_vlogfile_write(1, 0, 0, ng123, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)118, t12, 1);
    xsi_set_current_line(537, ng80);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 27600);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_report_status(char *t1, char *t2)
{
    char t3[16];
    char t16[8];
    char t17[8];
    int t0;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    t0 = 1;
    xsi_set_current_line(552, ng80);

LAB2:    xsi_set_current_line(553, ng80);
    t4 = xsi_vlog_time(t3, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng56)));
    t6 = (t1 + 30800);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t1 + 30960);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t1 + 31120);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t1 + 12120);
    xsi_vlogfile_write(1, 0, 0, ng124, 6, t15, (char)118, t3, 64, (char)118, t5, 56, (char)119, t8, 32, (char)119, t11, 32, (char)119, t14, 32);
    xsi_set_current_line(554, ng80);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 30960);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t16, 0, 8);
    xsi_vlog_signed_add(t16, 32, t6, 32, t9, 32);
    t10 = (t1 + 31120);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memset(t17, 0, 8);
    xsi_vlog_signed_add(t17, 32, t16, 32, t12, 32);
    t13 = (t1 + 35120);
    xsi_vlogvar_assign_value(t13, t17, 0, 0, 32);
    t0 = 0;

LAB1:    return t0;
}

static int sp_add_pending_transaction(char *t1, char *t2)
{
    char t9[8];
    char t21[8];
    char t43[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 12552);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(570, ng80);

LAB5:    xsi_set_current_line(571, ng80);
    t5 = ((char*)((ng83)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    xsi_set_current_line(572, ng80);

LAB6:    t4 = (t1 + 31120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 2560);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t6, 32, t8, 32);
    t7 = (t9 + 4);
    t10 = *((unsigned int *)t7);
    t11 = (~(t10));
    t12 = *((unsigned int *)t9);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB7;

LAB8:    xsi_set_current_line(579, ng80);
    t4 = (t1 + 31120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t6, 32, t7, 32);
    t8 = (t1 + 31120);
    xsi_vlogvar_assign_value(t8, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    xsi_set_current_line(572, ng80);

LAB9:    xsi_set_current_line(573, ng80);
    t15 = (t2 + 96U);
    t16 = *((char **)t15);
    t17 = (t16 + 0U);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = ((char*)((ng83)));
    memset(t21, 0, 8);
    t22 = (t19 + 4);
    t23 = (t20 + 4);
    t24 = *((unsigned int *)t19);
    t25 = *((unsigned int *)t20);
    t26 = (t24 ^ t25);
    t27 = *((unsigned int *)t22);
    t28 = *((unsigned int *)t23);
    t29 = (t27 ^ t28);
    t30 = (t26 | t29);
    t31 = *((unsigned int *)t22);
    t32 = *((unsigned int *)t23);
    t33 = (t31 | t32);
    t34 = (~(t33));
    t35 = (t30 & t34);
    if (t35 != 0)
        goto LAB13;

LAB10:    if (t33 != 0)
        goto LAB12;

LAB11:    *((unsigned int *)t21) = 1;

LAB13:    t37 = (t21 + 4);
    t38 = *((unsigned int *)t37);
    t39 = (~(t38));
    t40 = *((unsigned int *)t21);
    t41 = (t40 & t39);
    t42 = (t41 != 0);
    if (t42 > 0)
        goto LAB14;

LAB15:
LAB16:    xsi_set_current_line(577, ng80);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB18;
    goto LAB1;

LAB12:    t36 = (t21 + 4);
    *((unsigned int *)t21) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB13;

LAB14:    xsi_set_current_line(573, ng80);

LAB17:    xsi_set_current_line(574, ng80);
    t44 = xsi_vlog_time(t43, 10000.000000000000, 1000.0000000000000);
    t45 = ((char*)((ng56)));
    t46 = (t1 + 31120);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t1 + 12552);
    xsi_vlogfile_write(1, 0, 0, ng125, 4, t49, (char)118, t43, 64, (char)118, t45, 56, (char)119, t48, 32);
    xsi_set_current_line(575, ng80);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    goto LAB16;

LAB18:    goto LAB6;

}

static int sp_remove_pending_transaction(char *t1, char *t2)
{
    char t9[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 12984);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(591, ng80);

LAB5:    xsi_set_current_line(592, ng80);
    t5 = (t1 + 31120);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_minus(t9, 32, t7, 32, t8, 32);
    t10 = (t1 + 31120);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_SEND_WRITE_RESPONSE(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t54[8];
    char t72[8];
    char t73[8];
    char t74[8];
    char t75[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    int t53;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 13416);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(363, ng52);

LAB5:    xsi_set_current_line(367, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(375, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB16:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t53 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t53 == -1)
        goto LAB17;

LAB18:    if (t53 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 10824);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(382, ng52);
    t4 = (t1 + 30480);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng86)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB23;

LAB20:    if (t21 != 0)
        goto LAB22;

LAB21:    *((unsigned int *)t9) = 1;

LAB23:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB24;

LAB25:
LAB26:    xsi_set_current_line(385, ng52);
    t4 = ((char*)((ng86)));
    t5 = (t1 + 30480);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(390, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 28720);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 1, 0LL);
    xsi_set_current_line(391, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 28880);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 2, 0LL);
    xsi_set_current_line(392, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 29200);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 1, 0LL);
    xsi_set_current_line(393, ng52);
    t4 = ((char*)((ng83)));
    t5 = (t1 + 29040);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(399, ng52);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 16U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB35;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(367, ng52);

LAB13:    xsi_set_current_line(368, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 13416);
    xsi_vlogfile_write(0, 0, 0, ng126, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 13416);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 13416);
    xsi_vlogfile_write(0, 0, 0, ng128, 2, t46, (char)118, t45, 2);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 320U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 13416);
    xsi_vlogfile_write(1, 0, 0, ng129, 2, t52, (char)118, t51, 1);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB22:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB23;

LAB24:    xsi_set_current_line(382, ng52);

LAB27:    xsi_set_current_line(383, ng52);

LAB28:    t25 = (t1 + 30480);
    t32 = (t25 + 56U);
    t33 = *((char **)t32);
    t34 = ((char*)((ng97)));
    memset(t54, 0, 8);
    t35 = (t33 + 4);
    t36 = (t34 + 4);
    t55 = *((unsigned int *)t33);
    t56 = *((unsigned int *)t34);
    t57 = (t55 ^ t56);
    t58 = *((unsigned int *)t35);
    t59 = *((unsigned int *)t36);
    t60 = (t58 ^ t59);
    t61 = (t57 | t60);
    t62 = *((unsigned int *)t35);
    t63 = *((unsigned int *)t36);
    t64 = (t62 | t63);
    t65 = (~(t64));
    t66 = (t61 & t65);
    if (t66 != 0)
        goto LAB32;

LAB29:    if (t64 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t54) = 1;

LAB32:    t38 = (t54 + 4);
    t67 = *((unsigned int *)t38);
    t68 = (~(t67));
    t69 = *((unsigned int *)t54);
    t70 = (t69 & t68);
    t71 = (t70 != 0);
    if (t71 > 0)
        goto LAB34;

LAB33:    t39 = (t2 + 88U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    xsi_wp_set_status(t41, 1);
    t42 = (t2 + 48U);
    *((char **)t42) = &&LAB28;
    goto LAB1;

LAB31:    t37 = (t54 + 4);
    *((unsigned int *)t54) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB32;

LAB34:    t43 = (t2 + 88U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    xsi_wp_set_status(t45, 0);
    goto LAB26;

LAB35:    xsi_set_current_line(400, ng52);

LAB36:    t4 = (t1 + 24160U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t54, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB39;

LAB37:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB39;

LAB38:    *((unsigned int *)t54) = 1;

LAB39:    memset(t72, 0, 8);
    t8 = (t54 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t54);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB40;

LAB41:    if (*((unsigned int *)t8) != 0)
        goto LAB42;

LAB43:    t11 = (t72 + 4);
    t17 = *((unsigned int *)t72);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB44;

LAB45:    memcpy(t75, t72, 8);

LAB46:    memset(t9, 0, 8);
    t43 = (t75 + 4);
    t80 = *((unsigned int *)t43);
    t81 = (~(t80));
    t82 = *((unsigned int *)t75);
    t83 = (t82 & t81);
    t84 = (t83 & 1U);
    if (t84 != 0)
        goto LAB60;

LAB58:    if (*((unsigned int *)t43) == 0)
        goto LAB57;

LAB59:    t44 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t44) = 1;

LAB60:    t45 = (t9 + 4);
    t85 = *((unsigned int *)t45);
    t86 = (~(t85));
    t87 = *((unsigned int *)t9);
    t88 = (t87 & t86);
    t89 = (t88 != 0);
    if (t89 > 0)
        goto LAB61;

LAB62:    xsi_set_current_line(401, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 29040);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(406, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB64);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 12984);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB66:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t53 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t53 == -1)
        goto LAB67;

LAB68:    if (t53 != 0)
        goto LAB69;

LAB64:    t32 = (t1 + 12984);
    xsi_vlog_subprogram_popinvocation(t32);

LAB65:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 12984);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(411, ng52);
    t4 = ((char*)((ng97)));
    t5 = (t1 + 30480);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(416, ng52);
    t4 = (t1 + 46608);
    xsi_trigger(t4, -1, -1);
    goto LAB4;

LAB40:    *((unsigned int *)t72) = 1;
    goto LAB43;

LAB42:    t10 = (t72 + 4);
    *((unsigned int *)t72) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB43;

LAB44:    t24 = (t1 + 29040);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng83)));
    memset(t73, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t33))
        goto LAB49;

LAB47:    t34 = (t32 + 4);
    t35 = (t33 + 4);
    if (*((unsigned int *)t34) != *((unsigned int *)t35))
        goto LAB49;

LAB48:    *((unsigned int *)t73) = 1;

LAB49:    memset(t74, 0, 8);
    t36 = (t73 + 4);
    t20 = *((unsigned int *)t36);
    t21 = (~(t20));
    t22 = *((unsigned int *)t73);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t36) != 0)
        goto LAB52;

LAB53:    t27 = *((unsigned int *)t72);
    t28 = *((unsigned int *)t74);
    t29 = (t27 & t28);
    *((unsigned int *)t75) = t29;
    t38 = (t72 + 4);
    t39 = (t74 + 4);
    t40 = (t75 + 4);
    t30 = *((unsigned int *)t38);
    t55 = *((unsigned int *)t39);
    t56 = (t30 | t55);
    *((unsigned int *)t40) = t56;
    t57 = *((unsigned int *)t40);
    t58 = (t57 != 0);
    if (t58 == 1)
        goto LAB54;

LAB55:
LAB56:    goto LAB46;

LAB50:    *((unsigned int *)t74) = 1;
    goto LAB53;

LAB52:    t37 = (t74 + 4);
    *((unsigned int *)t74) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB53;

LAB54:    t59 = *((unsigned int *)t75);
    t60 = *((unsigned int *)t40);
    *((unsigned int *)t75) = (t59 | t60);
    t41 = (t72 + 4);
    t42 = (t74 + 4);
    t61 = *((unsigned int *)t72);
    t62 = (~(t61));
    t63 = *((unsigned int *)t41);
    t64 = (~(t63));
    t65 = *((unsigned int *)t74);
    t66 = (~(t65));
    t67 = *((unsigned int *)t42);
    t68 = (~(t67));
    t53 = (t62 & t64);
    t76 = (t66 & t68);
    t69 = (~(t53));
    t70 = (~(t76));
    t71 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t71 & t69);
    t77 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t77 & t70);
    t78 = *((unsigned int *)t75);
    *((unsigned int *)t75) = (t78 & t69);
    t79 = *((unsigned int *)t75);
    *((unsigned int *)t75) = (t79 & t70);
    goto LAB56;

LAB57:    *((unsigned int *)t9) = 1;
    goto LAB60;

LAB61:    xsi_set_current_line(400, ng52);
    t46 = (t2 + 88U);
    t47 = *((char **)t46);
    t48 = (t47 + 32U);
    xsi_wp_set_status(t48, 1);
    *((char **)t3) = &&LAB63;
    goto LAB1;

LAB63:    goto LAB36;

LAB67:    t0 = -1;
    goto LAB1;

LAB69:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB66;
    goto LAB1;

}

static int sp_SEND_READ_DATA(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t66[8];
    char t84[8];
    char t85[8];
    char t86[8];
    char t87[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    int t65;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 13848);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(450, ng52);

LAB5:    xsi_set_current_line(454, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(464, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB16:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t65 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t65 == -1)
        goto LAB17;

LAB18:    if (t65 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 10824);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(471, ng52);
    t4 = (t1 + 30640);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng86)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB23;

LAB20:    if (t21 != 0)
        goto LAB22;

LAB21:    *((unsigned int *)t9) = 1;

LAB23:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB24;

LAB25:
LAB26:    xsi_set_current_line(474, ng52);
    t4 = ((char*)((ng86)));
    t5 = (t1 + 30640);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(479, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 29520);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 1, 0LL);
    xsi_set_current_line(480, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 29680);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 32, 0LL);
    xsi_set_current_line(481, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 29840);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 2, 0LL);
    xsi_set_current_line(482, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 480U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 30000);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 1, 0LL);
    xsi_set_current_line(483, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 640U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 30160);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 1, 0LL);
    xsi_set_current_line(484, ng52);
    t4 = ((char*)((ng83)));
    t5 = (t1 + 30320);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(490, ng52);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 16U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB35;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(454, ng52);

LAB13:    xsi_set_current_line(455, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 13848);
    xsi_vlogfile_write(0, 0, 0, ng130, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 13848);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 13848);
    xsi_vlogfile_write(0, 0, 0, ng131, 2, t46, (char)118, t45, 32);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 320U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 13848);
    xsi_vlogfile_write(0, 0, 0, ng128, 2, t52, (char)118, t51, 2);
    t53 = (t2 + 96U);
    t54 = *((char **)t53);
    t55 = (t54 + 480U);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    t58 = (t1 + 13848);
    xsi_vlogfile_write(0, 0, 0, ng132, 2, t58, (char)118, t57, 1);
    t59 = (t2 + 96U);
    t60 = *((char **)t59);
    t61 = (t60 + 640U);
    t62 = (t61 + 56U);
    t63 = *((char **)t62);
    t64 = (t1 + 13848);
    xsi_vlogfile_write(1, 0, 0, ng133, 2, t64, (char)118, t63, 1);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB22:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB23;

LAB24:    xsi_set_current_line(471, ng52);

LAB27:    xsi_set_current_line(472, ng52);

LAB28:    t25 = (t1 + 30640);
    t32 = (t25 + 56U);
    t33 = *((char **)t32);
    t34 = ((char*)((ng97)));
    memset(t66, 0, 8);
    t35 = (t33 + 4);
    t36 = (t34 + 4);
    t67 = *((unsigned int *)t33);
    t68 = *((unsigned int *)t34);
    t69 = (t67 ^ t68);
    t70 = *((unsigned int *)t35);
    t71 = *((unsigned int *)t36);
    t72 = (t70 ^ t71);
    t73 = (t69 | t72);
    t74 = *((unsigned int *)t35);
    t75 = *((unsigned int *)t36);
    t76 = (t74 | t75);
    t77 = (~(t76));
    t78 = (t73 & t77);
    if (t78 != 0)
        goto LAB32;

LAB29:    if (t76 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t66) = 1;

LAB32:    t38 = (t66 + 4);
    t79 = *((unsigned int *)t38);
    t80 = (~(t79));
    t81 = *((unsigned int *)t66);
    t82 = (t81 & t80);
    t83 = (t82 != 0);
    if (t83 > 0)
        goto LAB34;

LAB33:    t39 = (t2 + 88U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    xsi_wp_set_status(t41, 1);
    t42 = (t2 + 48U);
    *((char **)t42) = &&LAB28;
    goto LAB1;

LAB31:    t37 = (t66 + 4);
    *((unsigned int *)t66) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB32;

LAB34:    t43 = (t2 + 88U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    xsi_wp_set_status(t45, 0);
    goto LAB26;

LAB35:    xsi_set_current_line(491, ng52);

LAB36:    t4 = (t1 + 26240U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t66, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB39;

LAB37:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB39;

LAB38:    *((unsigned int *)t66) = 1;

LAB39:    memset(t84, 0, 8);
    t8 = (t66 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t66);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB40;

LAB41:    if (*((unsigned int *)t8) != 0)
        goto LAB42;

LAB43:    t11 = (t84 + 4);
    t17 = *((unsigned int *)t84);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB44;

LAB45:    memcpy(t87, t84, 8);

LAB46:    memset(t9, 0, 8);
    t43 = (t87 + 4);
    t92 = *((unsigned int *)t43);
    t93 = (~(t92));
    t94 = *((unsigned int *)t87);
    t95 = (t94 & t93);
    t96 = (t95 & 1U);
    if (t96 != 0)
        goto LAB60;

LAB58:    if (*((unsigned int *)t43) == 0)
        goto LAB57;

LAB59:    t44 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t44) = 1;

LAB60:    t45 = (t9 + 4);
    t97 = *((unsigned int *)t45);
    t98 = (~(t97));
    t99 = *((unsigned int *)t9);
    t100 = (t99 & t98);
    t101 = (t100 != 0);
    if (t101 > 0)
        goto LAB61;

LAB62:    xsi_set_current_line(492, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 30320);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(493, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 30000);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(495, ng52);
    t4 = (t1 + 28240);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng86)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB67;

LAB64:    if (t21 != 0)
        goto LAB66;

LAB65:    *((unsigned int *)t9) = 1;

LAB67:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB68;

LAB69:
LAB70:    xsi_set_current_line(506, ng52);
    t4 = ((char*)((ng97)));
    t5 = (t1 + 30640);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(511, ng52);
    t4 = (t1 + 45936);
    xsi_trigger(t4, -1, -1);
    goto LAB4;

LAB40:    *((unsigned int *)t84) = 1;
    goto LAB43;

LAB42:    t10 = (t84 + 4);
    *((unsigned int *)t84) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB43;

LAB44:    t24 = (t1 + 30320);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng83)));
    memset(t85, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t33))
        goto LAB49;

LAB47:    t34 = (t32 + 4);
    t35 = (t33 + 4);
    if (*((unsigned int *)t34) != *((unsigned int *)t35))
        goto LAB49;

LAB48:    *((unsigned int *)t85) = 1;

LAB49:    memset(t86, 0, 8);
    t36 = (t85 + 4);
    t20 = *((unsigned int *)t36);
    t21 = (~(t20));
    t22 = *((unsigned int *)t85);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t36) != 0)
        goto LAB52;

LAB53:    t27 = *((unsigned int *)t84);
    t28 = *((unsigned int *)t86);
    t29 = (t27 & t28);
    *((unsigned int *)t87) = t29;
    t38 = (t84 + 4);
    t39 = (t86 + 4);
    t40 = (t87 + 4);
    t30 = *((unsigned int *)t38);
    t67 = *((unsigned int *)t39);
    t68 = (t30 | t67);
    *((unsigned int *)t40) = t68;
    t69 = *((unsigned int *)t40);
    t70 = (t69 != 0);
    if (t70 == 1)
        goto LAB54;

LAB55:
LAB56:    goto LAB46;

LAB50:    *((unsigned int *)t86) = 1;
    goto LAB53;

LAB52:    t37 = (t86 + 4);
    *((unsigned int *)t86) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB53;

LAB54:    t71 = *((unsigned int *)t87);
    t72 = *((unsigned int *)t40);
    *((unsigned int *)t87) = (t71 | t72);
    t41 = (t84 + 4);
    t42 = (t86 + 4);
    t73 = *((unsigned int *)t84);
    t74 = (~(t73));
    t75 = *((unsigned int *)t41);
    t76 = (~(t75));
    t77 = *((unsigned int *)t86);
    t78 = (~(t77));
    t79 = *((unsigned int *)t42);
    t80 = (~(t79));
    t65 = (t74 & t76);
    t88 = (t78 & t80);
    t81 = (~(t65));
    t82 = (~(t88));
    t83 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t83 & t81);
    t89 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t89 & t82);
    t90 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t90 & t81);
    t91 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t91 & t82);
    goto LAB56;

LAB57:    *((unsigned int *)t9) = 1;
    goto LAB60;

LAB61:    xsi_set_current_line(491, ng52);
    t46 = (t2 + 88U);
    t47 = *((char **)t46);
    t48 = (t47 + 32U);
    xsi_wp_set_status(t48, 1);
    *((char **)t3) = &&LAB63;
    goto LAB1;

LAB63:    goto LAB36;

LAB66:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB67;

LAB68:    xsi_set_current_line(495, ng52);

LAB71:    xsi_set_current_line(496, ng52);
    t25 = ((char*)((ng104)));
    t32 = (t1 + 29520);
    xsi_vlogvar_wait_assign_value(t32, t25, 0, 0, 1, 0LL);
    xsi_set_current_line(497, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 29680);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 32, 0LL);
    xsi_set_current_line(498, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 29840);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 2, 0LL);
    xsi_set_current_line(499, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 30000);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(500, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 30160);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    goto LAB70;

}

static int sp_RECEIVE_WRITE_ADDRESS(char *t1, char *t2)
{
    char t9[8];
    char t37[8];
    char t46[16];
    char t63[8];
    char t64[8];
    char t65[8];
    char t66[8];
    char t88[8];
    char t102[8];
    char t105[8];
    char t113[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t38;
    char *t39;
    char *t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    int t62;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    char *t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t103;
    char *t104;
    char *t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    char *t112;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    char *t117;
    char *t118;
    char *t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    char *t127;
    char *t128;
    unsigned int t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    unsigned int t136;
    int t137;
    int t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    char *t145;
    char *t146;
    char *t147;
    char *t148;
    char *t149;
    char *t150;
    char *t151;
    char *t152;
    char *t153;
    char *t154;
    char *t155;
    char *t156;
    char *t157;
    char *t158;
    char *t159;
    char *t160;
    char *t161;
    char *t162;
    char *t163;
    char *t164;
    char *t165;
    char *t166;
    char *t167;
    char *t168;
    char *t169;
    char *t170;
    char *t171;
    char *t172;
    char *t173;
    char *t174;
    char *t175;
    char *t176;
    char *t177;
    char *t178;
    char *t179;
    char *t180;
    char *t181;
    char *t182;
    char *t183;
    char *t184;
    char *t185;
    char *t186;
    char *t187;
    char *t188;
    char *t189;
    char *t190;
    char *t191;
    char *t192;
    char *t193;
    char *t194;
    char *t195;
    char *t196;
    char *t197;
    char *t198;
    char *t199;
    char *t200;
    char *t201;
    char *t202;
    char *t203;
    char *t204;
    char *t205;
    char *t206;
    char *t207;
    char *t208;
    char *t209;
    char *t210;
    char *t211;
    char *t212;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 14280);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(559, ng52);

LAB5:    xsi_set_current_line(563, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(577, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB22);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB24:    t25 = (t2 + 64U);
    t31 = *((char **)t25);
    t32 = (t31 + 80U);
    t33 = *((char **)t32);
    t34 = (t33 + 272U);
    t35 = *((char **)t34);
    t36 = (t35 + 0U);
    t38 = *((char **)t36);
    t62 = ((int  (*)(char *, char *))t38)(t1, t31);
    if (t62 == -1)
        goto LAB25;

LAB26:    if (t62 != 0)
        goto LAB27;

LAB22:    t31 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t31);

LAB23:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 10824);
    t47 = (t2 + 56U);
    t48 = *((char **)t47);
    xsi_delete_subprogram_invocation(t39, t40, t1, t48, t2);
    xsi_set_current_line(582, ng52);
    t4 = (t1 + 2696);
    t5 = *((char **)t4);
    t4 = ((char*)((ng104)));
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t5, 32, t4, 32);
    t6 = (t9 + 4);
    t12 = *((unsigned int *)t6);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB28;

LAB29:
LAB30:    xsi_set_current_line(594, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2240U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(595, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2080U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(596, ng52);
    t4 = ((char*)((ng83)));
    t5 = (t1 + 28400);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(597, ng52);

LAB38:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2240U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    t10 = (t8 + 4);
    t12 = *((unsigned int *)t10);
    t13 = (~(t12));
    t14 = *((unsigned int *)t8);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB42;

LAB40:    if (*((unsigned int *)t10) == 0)
        goto LAB39;

LAB41:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;

LAB42:    t24 = (t9 + 4);
    t17 = *((unsigned int *)t24);
    t18 = (~(t17));
    t19 = *((unsigned int *)t9);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB43;

LAB44:    xsi_set_current_line(623, ng52);
    t4 = (t1 + 21600U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 320U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 32);
    xsi_set_current_line(624, ng52);
    t4 = (t1 + 21760U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 480U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 8);
    xsi_set_current_line(625, ng52);
    t4 = (t1 + 21920U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 640U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 3);
    xsi_set_current_line(626, ng52);
    t4 = (t1 + 22080U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 800U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 2);
    xsi_set_current_line(627, ng52);
    t4 = (t1 + 22240U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 960U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(628, ng52);
    t4 = (t1 + 22400U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1120U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(629, ng52);
    t4 = (t1 + 22560U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1280U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 3);
    xsi_set_current_line(630, ng52);
    t4 = (t1 + 22720U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1440U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(631, ng52);
    t4 = (t1 + 22880U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1600U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(632, ng52);
    t4 = (t1 + 23040U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1760U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(633, ng52);
    t4 = (t1 + 21440U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1920U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(635, ng52);
    t4 = (t1 + 2696);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t5, 32, t4, 32);
    t6 = (t9 + 4);
    t12 = *((unsigned int *)t6);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB128;

LAB129:
LAB130:    xsi_set_current_line(642, ng52);
    t4 = (t1 + 27920);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB141;

LAB138:    if (t21 != 0)
        goto LAB140;

LAB139:    *((unsigned int *)t9) = 1;

LAB141:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB142;

LAB143:
LAB144:    xsi_set_current_line(661, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB152);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 3912);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 2);

LAB154:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB155;

LAB156:    if (t62 != 0)
        goto LAB157;

LAB152:    t40 = (t1 + 3912);
    xsi_vlog_subprogram_popinvocation(t40);

LAB153:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 3912);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(662, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 960U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t47 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB158);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 4344);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 2);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t31, 0, 0, 8);
    t58 = (t51 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t36, 0, 0, 1);

LAB160:    t61 = (t2 + 64U);
    t94 = *((char **)t61);
    t98 = (t94 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t103 = (t101 + 0U);
    t104 = *((char **)t103);
    t62 = ((int  (*)(char *, char *))t104)(t1, t94);
    if (t62 == -1)
        goto LAB161;

LAB162:    if (t62 != 0)
        goto LAB163;

LAB158:    t94 = (t1 + 4344);
    xsi_vlog_subprogram_popinvocation(t94);

LAB159:    t106 = (t2 + 64U);
    t112 = *((char **)t106);
    t106 = (t1 + 4344);
    t117 = (t2 + 56U);
    t118 = *((char **)t117);
    xsi_delete_subprogram_invocation(t106, t112, t1, t118, t2);
    xsi_set_current_line(663, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 640U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB164);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 4776);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 3);

LAB166:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB167;

LAB168:    if (t62 != 0)
        goto LAB169;

LAB164:    t40 = (t1 + 4776);
    xsi_vlog_subprogram_popinvocation(t40);

LAB165:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 4776);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(664, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB170);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 5208);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 1);

LAB172:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB173;

LAB174:    if (t62 != 0)
        goto LAB175;

LAB170:    t40 = (t1 + 5208);
    xsi_vlog_subprogram_popinvocation(t40);

LAB171:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 5208);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(665, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1120U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB176);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 5640);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 4);

LAB178:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB179;

LAB180:    if (t62 != 0)
        goto LAB181;

LAB176:    t40 = (t1 + 5640);
    xsi_vlog_subprogram_popinvocation(t40);

LAB177:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 5640);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(666, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 800U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t47 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB182);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 19896);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 32);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t31, 0, 0, 8);
    t58 = (t51 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t36, 0, 0, 2);

LAB184:    t61 = (t2 + 64U);
    t94 = *((char **)t61);
    t98 = (t94 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t103 = (t101 + 0U);
    t104 = *((char **)t103);
    t62 = ((int  (*)(char *, char *))t104)(t1, t94);
    if (t62 == -1)
        goto LAB185;

LAB186:    if (t62 != 0)
        goto LAB187;

LAB182:    t94 = (t1 + 19896);
    xsi_vlog_subprogram_popinvocation(t94);

LAB183:    t106 = (t2 + 64U);
    t112 = *((char **)t106);
    t106 = (t1 + 19896);
    t117 = (t2 + 56U);
    t118 = *((char **)t117);
    xsi_delete_subprogram_invocation(t106, t112, t1, t118, t2);
    xsi_set_current_line(667, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 800U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 640U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t47 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB188);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 6072);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 32);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t31, 0, 0, 2);
    t58 = (t51 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t36, 0, 0, 3);

LAB190:    t61 = (t2 + 64U);
    t94 = *((char **)t61);
    t98 = (t94 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t103 = (t101 + 0U);
    t104 = *((char **)t103);
    t62 = ((int  (*)(char *, char *))t104)(t1, t94);
    if (t62 == -1)
        goto LAB191;

LAB192:    if (t62 != 0)
        goto LAB193;

LAB188:    t94 = (t1 + 6072);
    xsi_vlog_subprogram_popinvocation(t94);

LAB189:    t106 = (t2 + 64U);
    t112 = *((char **)t106);
    t106 = (t1 + 6072);
    t117 = (t2 + 56U);
    t118 = *((char **)t117);
    xsi_delete_subprogram_invocation(t106, t112, t1, t118, t2);
    xsi_set_current_line(672, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 28400);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(677, ng52);
    t4 = (t1 + 45768);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(563, ng52);

LAB13:    xsi_set_current_line(564, ng52);
    t31 = (t2 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 160U);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = ((char*)((ng86)));
    memset(t37, 0, 8);
    if (*((unsigned int *)t35) != *((unsigned int *)t36))
        goto LAB16;

LAB14:    t38 = (t35 + 4);
    t39 = (t36 + 4);
    if (*((unsigned int *)t38) != *((unsigned int *)t39))
        goto LAB16;

LAB15:    *((unsigned int *)t37) = 1;

LAB16:    t40 = (t37 + 4);
    t41 = *((unsigned int *)t40);
    t42 = (~(t41));
    t43 = *((unsigned int *)t37);
    t44 = (t43 & t42);
    t45 = (t44 != 0);
    if (t45 > 0)
        goto LAB17;

LAB18:    xsi_set_current_line(570, ng52);

LAB21:    xsi_set_current_line(571, ng52);
    t4 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng56)));
    t6 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng134, 3, t6, (char)118, t46, 64, (char)118, t5, 56);
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t10 = (t8 + 160U);
    t11 = (t10 + 56U);
    t24 = *((char **)t11);
    t25 = (t1 + 14280);
    xsi_vlogfile_write(1, 0, 0, ng136, 2, t25, (char)118, t24, 1);

LAB19:    goto LAB12;

LAB17:    xsi_set_current_line(564, ng52);

LAB20:    xsi_set_current_line(565, ng52);
    t47 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t48 = ((char*)((ng56)));
    t49 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng134, 3, t49, (char)118, t46, 64, (char)118, t48, 56);
    t50 = (t2 + 96U);
    t51 = *((char **)t50);
    t52 = (t51 + 0U);
    t53 = (t52 + 56U);
    t54 = *((char **)t53);
    t55 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t55, (char)118, t54, 1);
    t56 = (t2 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 160U);
    t59 = (t58 + 56U);
    t60 = *((char **)t59);
    t61 = (t1 + 14280);
    xsi_vlogfile_write(1, 0, 0, ng135, 2, t61, (char)118, t60, 1);
    goto LAB19;

LAB25:    t0 = -1;
    goto LAB1;

LAB27:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB24;
    goto LAB1;

LAB28:    xsi_set_current_line(582, ng52);

LAB31:    xsi_set_current_line(583, ng52);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t11, &&LAB32);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    t31 = (t1 + 12552);
    t32 = xsi_create_subprogram_invocation(t25, 0, t1, t31, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t31, t32);

LAB34:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t36 = *((char **)t35);
    t38 = (t36 + 272U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t47 = *((char **)t40);
    t62 = ((int  (*)(char *, char *))t47)(t1, t34);
    if (t62 == -1)
        goto LAB35;

LAB36:    if (t62 != 0)
        goto LAB37;

LAB32:    t34 = (t1 + 12552);
    xsi_vlog_subprogram_popinvocation(t34);

LAB33:    t48 = (t2 + 64U);
    t49 = *((char **)t48);
    t48 = (t1 + 12552);
    t50 = (t2 + 56U);
    t51 = *((char **)t50);
    xsi_delete_subprogram_invocation(t48, t49, t1, t51, t2);
    goto LAB30;

LAB35:    t0 = -1;
    goto LAB1;

LAB37:    t33 = (t2 + 48U);
    *((char **)t33) = &&LAB34;
    goto LAB1;

LAB39:    *((unsigned int *)t9) = 1;
    goto LAB42;

LAB43:    xsi_set_current_line(597, ng52);
    t25 = (t2 + 88U);
    t31 = *((char **)t25);
    t32 = (t31 + 0U);
    xsi_wp_set_status(t32, 1);
    *((char **)t3) = &&LAB45;
    goto LAB1;

LAB45:    xsi_set_current_line(597, ng52);

LAB46:    xsi_set_current_line(598, ng52);
    t33 = ((char*)((ng83)));
    t34 = (t1 + 28400);
    xsi_vlogvar_wait_assign_value(t34, t33, 0, 0, 1, 0LL);
    xsi_set_current_line(599, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng86)));
    memset(t9, 0, 8);
    if (*((unsigned int *)t8) != *((unsigned int *)t10))
        goto LAB49;

LAB47:    t11 = (t8 + 4);
    t24 = (t10 + 4);
    if (*((unsigned int *)t11) != *((unsigned int *)t24))
        goto LAB49;

LAB48:    *((unsigned int *)t9) = 1;

LAB49:    t25 = (t9 + 4);
    t12 = *((unsigned int *)t25);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB50;

LAB51:    xsi_set_current_line(602, ng52);

LAB91:    xsi_set_current_line(603, ng52);
    t4 = (t1 + 23200U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t9, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB94;

LAB92:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB94;

LAB93:    *((unsigned int *)t9) = 1;

LAB94:    memset(t37, 0, 8);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB95;

LAB96:    if (*((unsigned int *)t8) != 0)
        goto LAB97;

LAB98:    t11 = (t37 + 4);
    t17 = *((unsigned int *)t37);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB99;

LAB100:    memcpy(t65, t37, 8);

LAB101:    t49 = (t2 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 2240U);
    xsi_vlogvar_assign_value(t51, t65, 0, 0, 1);

LAB52:    xsi_set_current_line(606, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2080U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(607, ng52);
    t4 = (t1 + 27440);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng104)));
    memset(t9, 0, 8);
    xsi_vlog_signed_not_equal(t9, 32, t6, 32, t7, 32);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB112;

LAB113:
LAB114:    goto LAB38;

LAB50:    xsi_set_current_line(599, ng52);

LAB53:    xsi_set_current_line(600, ng52);
    t31 = (t1 + 23200U);
    t32 = *((char **)t31);
    t31 = ((char*)((ng83)));
    memset(t37, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t31))
        goto LAB56;

LAB54:    t33 = (t32 + 4);
    t34 = (t31 + 4);
    if (*((unsigned int *)t33) != *((unsigned int *)t34))
        goto LAB56;

LAB55:    *((unsigned int *)t37) = 1;

LAB56:    memset(t63, 0, 8);
    t35 = (t37 + 4);
    t17 = *((unsigned int *)t35);
    t18 = (~(t17));
    t19 = *((unsigned int *)t37);
    t20 = (t19 & t18);
    t21 = (t20 & 1U);
    if (t21 != 0)
        goto LAB57;

LAB58:    if (*((unsigned int *)t35) != 0)
        goto LAB59;

LAB60:    t38 = (t63 + 4);
    t22 = *((unsigned int *)t63);
    t23 = *((unsigned int *)t38);
    t26 = (t22 || t23);
    if (t26 > 0)
        goto LAB61;

LAB62:    memcpy(t66, t63, 8);

LAB63:    memset(t88, 0, 8);
    t60 = (t66 + 4);
    t89 = *((unsigned int *)t60);
    t90 = (~(t89));
    t91 = *((unsigned int *)t66);
    t92 = (t91 & t90);
    t93 = (t92 & 1U);
    if (t93 != 0)
        goto LAB74;

LAB75:    if (*((unsigned int *)t60) != 0)
        goto LAB76;

LAB77:    t94 = (t88 + 4);
    t95 = *((unsigned int *)t88);
    t96 = *((unsigned int *)t94);
    t97 = (t95 || t96);
    if (t97 > 0)
        goto LAB78;

LAB79:    memcpy(t113, t88, 8);

LAB80:    t145 = (t2 + 96U);
    t146 = *((char **)t145);
    t147 = (t146 + 2240U);
    xsi_vlogvar_assign_value(t147, t113, 0, 0, 1);
    goto LAB52;

LAB57:    *((unsigned int *)t63) = 1;
    goto LAB60;

LAB59:    t36 = (t63 + 4);
    *((unsigned int *)t63) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB60;

LAB61:    t39 = (t1 + 21440U);
    t40 = *((char **)t39);
    t39 = (t2 + 96U);
    t47 = *((char **)t39);
    t48 = (t47 + 0U);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    memset(t64, 0, 8);
    if (*((unsigned int *)t40) != *((unsigned int *)t50))
        goto LAB66;

LAB64:    t51 = (t40 + 4);
    t52 = (t50 + 4);
    if (*((unsigned int *)t51) != *((unsigned int *)t52))
        goto LAB66;

LAB65:    *((unsigned int *)t64) = 1;

LAB66:    memset(t65, 0, 8);
    t53 = (t64 + 4);
    t27 = *((unsigned int *)t53);
    t28 = (~(t27));
    t29 = *((unsigned int *)t64);
    t30 = (t29 & t28);
    t41 = (t30 & 1U);
    if (t41 != 0)
        goto LAB67;

LAB68:    if (*((unsigned int *)t53) != 0)
        goto LAB69;

LAB70:    t42 = *((unsigned int *)t63);
    t43 = *((unsigned int *)t65);
    t44 = (t42 & t43);
    *((unsigned int *)t66) = t44;
    t55 = (t63 + 4);
    t56 = (t65 + 4);
    t57 = (t66 + 4);
    t45 = *((unsigned int *)t55);
    t67 = *((unsigned int *)t56);
    t68 = (t45 | t67);
    *((unsigned int *)t57) = t68;
    t69 = *((unsigned int *)t57);
    t70 = (t69 != 0);
    if (t70 == 1)
        goto LAB71;

LAB72:
LAB73:    goto LAB63;

LAB67:    *((unsigned int *)t65) = 1;
    goto LAB70;

LAB69:    t54 = (t65 + 4);
    *((unsigned int *)t65) = 1;
    *((unsigned int *)t54) = 1;
    goto LAB70;

LAB71:    t71 = *((unsigned int *)t66);
    t72 = *((unsigned int *)t57);
    *((unsigned int *)t66) = (t71 | t72);
    t58 = (t63 + 4);
    t59 = (t65 + 4);
    t73 = *((unsigned int *)t63);
    t74 = (~(t73));
    t75 = *((unsigned int *)t58);
    t76 = (~(t75));
    t77 = *((unsigned int *)t65);
    t78 = (~(t77));
    t79 = *((unsigned int *)t59);
    t80 = (~(t79));
    t62 = (t74 & t76);
    t81 = (t78 & t80);
    t82 = (~(t62));
    t83 = (~(t81));
    t84 = *((unsigned int *)t57);
    *((unsigned int *)t57) = (t84 & t82);
    t85 = *((unsigned int *)t57);
    *((unsigned int *)t57) = (t85 & t83);
    t86 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t86 & t82);
    t87 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t87 & t83);
    goto LAB73;

LAB74:    *((unsigned int *)t88) = 1;
    goto LAB77;

LAB76:    t61 = (t88 + 4);
    *((unsigned int *)t88) = 1;
    *((unsigned int *)t61) = 1;
    goto LAB77;

LAB78:    t98 = (t1 + 28400);
    t99 = (t98 + 56U);
    t100 = *((char **)t99);
    t101 = ((char*)((ng83)));
    memset(t102, 0, 8);
    if (*((unsigned int *)t100) != *((unsigned int *)t101))
        goto LAB83;

LAB81:    t103 = (t100 + 4);
    t104 = (t101 + 4);
    if (*((unsigned int *)t103) != *((unsigned int *)t104))
        goto LAB83;

LAB82:    *((unsigned int *)t102) = 1;

LAB83:    memset(t105, 0, 8);
    t106 = (t102 + 4);
    t107 = *((unsigned int *)t106);
    t108 = (~(t107));
    t109 = *((unsigned int *)t102);
    t110 = (t109 & t108);
    t111 = (t110 & 1U);
    if (t111 != 0)
        goto LAB84;

LAB85:    if (*((unsigned int *)t106) != 0)
        goto LAB86;

LAB87:    t114 = *((unsigned int *)t88);
    t115 = *((unsigned int *)t105);
    t116 = (t114 & t115);
    *((unsigned int *)t113) = t116;
    t117 = (t88 + 4);
    t118 = (t105 + 4);
    t119 = (t113 + 4);
    t120 = *((unsigned int *)t117);
    t121 = *((unsigned int *)t118);
    t122 = (t120 | t121);
    *((unsigned int *)t119) = t122;
    t123 = *((unsigned int *)t119);
    t124 = (t123 != 0);
    if (t124 == 1)
        goto LAB88;

LAB89:
LAB90:    goto LAB80;

LAB84:    *((unsigned int *)t105) = 1;
    goto LAB87;

LAB86:    t112 = (t105 + 4);
    *((unsigned int *)t105) = 1;
    *((unsigned int *)t112) = 1;
    goto LAB87;

LAB88:    t125 = *((unsigned int *)t113);
    t126 = *((unsigned int *)t119);
    *((unsigned int *)t113) = (t125 | t126);
    t127 = (t88 + 4);
    t128 = (t105 + 4);
    t129 = *((unsigned int *)t88);
    t130 = (~(t129));
    t131 = *((unsigned int *)t127);
    t132 = (~(t131));
    t133 = *((unsigned int *)t105);
    t134 = (~(t133));
    t135 = *((unsigned int *)t128);
    t136 = (~(t135));
    t137 = (t130 & t132);
    t138 = (t134 & t136);
    t139 = (~(t137));
    t140 = (~(t138));
    t141 = *((unsigned int *)t119);
    *((unsigned int *)t119) = (t141 & t139);
    t142 = *((unsigned int *)t119);
    *((unsigned int *)t119) = (t142 & t140);
    t143 = *((unsigned int *)t113);
    *((unsigned int *)t113) = (t143 & t139);
    t144 = *((unsigned int *)t113);
    *((unsigned int *)t113) = (t144 & t140);
    goto LAB90;

LAB95:    *((unsigned int *)t37) = 1;
    goto LAB98;

LAB97:    t10 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB98;

LAB99:    t24 = (t1 + 28400);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = ((char*)((ng83)));
    memset(t63, 0, 8);
    if (*((unsigned int *)t31) != *((unsigned int *)t32))
        goto LAB104;

LAB102:    t33 = (t31 + 4);
    t34 = (t32 + 4);
    if (*((unsigned int *)t33) != *((unsigned int *)t34))
        goto LAB104;

LAB103:    *((unsigned int *)t63) = 1;

LAB104:    memset(t64, 0, 8);
    t35 = (t63 + 4);
    t20 = *((unsigned int *)t35);
    t21 = (~(t20));
    t22 = *((unsigned int *)t63);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB105;

LAB106:    if (*((unsigned int *)t35) != 0)
        goto LAB107;

LAB108:    t27 = *((unsigned int *)t37);
    t28 = *((unsigned int *)t64);
    t29 = (t27 & t28);
    *((unsigned int *)t65) = t29;
    t38 = (t37 + 4);
    t39 = (t64 + 4);
    t40 = (t65 + 4);
    t30 = *((unsigned int *)t38);
    t41 = *((unsigned int *)t39);
    t42 = (t30 | t41);
    *((unsigned int *)t40) = t42;
    t43 = *((unsigned int *)t40);
    t44 = (t43 != 0);
    if (t44 == 1)
        goto LAB109;

LAB110:
LAB111:    goto LAB101;

LAB105:    *((unsigned int *)t64) = 1;
    goto LAB108;

LAB107:    t36 = (t64 + 4);
    *((unsigned int *)t64) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB108;

LAB109:    t45 = *((unsigned int *)t65);
    t67 = *((unsigned int *)t40);
    *((unsigned int *)t65) = (t45 | t67);
    t47 = (t37 + 4);
    t48 = (t64 + 4);
    t68 = *((unsigned int *)t37);
    t69 = (~(t68));
    t70 = *((unsigned int *)t47);
    t71 = (~(t70));
    t72 = *((unsigned int *)t64);
    t73 = (~(t72));
    t74 = *((unsigned int *)t48);
    t75 = (~(t74));
    t62 = (t69 & t71);
    t81 = (t73 & t75);
    t76 = (~(t62));
    t77 = (~(t81));
    t78 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t78 & t76);
    t79 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t79 & t77);
    t80 = *((unsigned int *)t65);
    *((unsigned int *)t65) = (t80 & t76);
    t82 = *((unsigned int *)t65);
    *((unsigned int *)t65) = (t82 & t77);
    goto LAB111;

LAB112:    xsi_set_current_line(607, ng52);

LAB115:    xsi_set_current_line(608, ng52);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 2080U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t1 + 27440);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memset(t37, 0, 8);
    xsi_vlog_signed_equal(t37, 32, t31, 32, t34, 32);
    t35 = (t37 + 4);
    t17 = *((unsigned int *)t35);
    t18 = (~(t17));
    t19 = *((unsigned int *)t37);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB116;

LAB117:
LAB118:    goto LAB114;

LAB116:    xsi_set_current_line(608, ng52);

LAB119:    xsi_set_current_line(609, ng52);
    t36 = (t2 + 96U);
    t38 = *((char **)t36);
    t39 = (t38 + 160U);
    t40 = (t39 + 56U);
    t47 = *((char **)t40);
    t48 = ((char*)((ng86)));
    memset(t63, 0, 8);
    if (*((unsigned int *)t47) != *((unsigned int *)t48))
        goto LAB122;

LAB120:    t49 = (t47 + 4);
    t50 = (t48 + 4);
    if (*((unsigned int *)t49) != *((unsigned int *)t50))
        goto LAB122;

LAB121:    *((unsigned int *)t63) = 1;

LAB122:    t51 = (t63 + 4);
    t22 = *((unsigned int *)t51);
    t23 = (~(t22));
    t26 = *((unsigned int *)t63);
    t27 = (t26 & t23);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB123;

LAB124:    xsi_set_current_line(613, ng52);

LAB127:    xsi_set_current_line(614, ng52);
    t4 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng56)));
    t6 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng137, 3, t6, (char)118, t46, 64, (char)118, t5, 56);
    t7 = (t1 + 14280);
    xsi_vlogfile_write(1, 0, 0, ng139, 1, t7);

LAB125:    xsi_set_current_line(617, ng52);
    xsi_vlog_stop(1);
    goto LAB118;

LAB123:    xsi_set_current_line(609, ng52);

LAB126:    xsi_set_current_line(610, ng52);
    t52 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t53 = ((char*)((ng56)));
    t54 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng137, 3, t54, (char)118, t46, 64, (char)118, t53, 56);
    t55 = (t2 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 0U);
    t58 = (t57 + 56U);
    t59 = *((char **)t58);
    t60 = (t1 + 14280);
    xsi_vlogfile_write(1, 0, 0, ng138, 2, t60, (char)118, t59, 1);
    goto LAB125;

LAB128:    xsi_set_current_line(635, ng52);

LAB131:    xsi_set_current_line(636, ng52);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t11, &&LAB132);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    t31 = (t1 + 12552);
    t32 = xsi_create_subprogram_invocation(t25, 0, t1, t31, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t31, t32);

LAB134:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t36 = *((char **)t35);
    t38 = (t36 + 272U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t47 = *((char **)t40);
    t62 = ((int  (*)(char *, char *))t47)(t1, t34);
    if (t62 == -1)
        goto LAB135;

LAB136:    if (t62 != 0)
        goto LAB137;

LAB132:    t34 = (t1 + 12552);
    xsi_vlog_subprogram_popinvocation(t34);

LAB133:    t48 = (t2 + 64U);
    t49 = *((char **)t48);
    t48 = (t1 + 12552);
    t50 = (t2 + 56U);
    t51 = *((char **)t50);
    xsi_delete_subprogram_invocation(t48, t49, t1, t51, t2);
    goto LAB130;

LAB135:    t0 = -1;
    goto LAB1;

LAB137:    t33 = (t2 + 48U);
    *((char **)t33) = &&LAB134;
    goto LAB1;

LAB140:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB141;

LAB142:    xsi_set_current_line(642, ng52);

LAB145:    xsi_set_current_line(643, ng52);
    t25 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t31 = ((char*)((ng56)));
    t32 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng140, 3, t32, (char)118, t46, 64, (char)118, t31, 56);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 1920U);
    t36 = (t35 + 56U);
    t38 = *((char **)t36);
    t39 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t39, (char)118, t38, 1);
    t40 = (t2 + 96U);
    t47 = *((char **)t40);
    t48 = (t47 + 320U);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    t51 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng141, 2, t51, (char)118, t50, 32);
    t52 = (t2 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 480U);
    t55 = (t54 + 56U);
    t56 = *((char **)t55);
    t57 = (t2 + 56U);
    t58 = *((char **)t57);
    t59 = (t1 + 6936);
    t60 = xsi_create_subprogram_invocation(t58, 0, t1, t59, 0, t2);
    t61 = (t1 + 32080);
    xsi_vlogvar_assign_value(t61, t56, 0, 0, 8);

LAB146:    t94 = (t2 + 64U);
    t98 = *((char **)t94);
    t99 = (t98 + 80U);
    t100 = *((char **)t99);
    t101 = (t100 + 272U);
    t103 = *((char **)t101);
    t104 = (t103 + 0U);
    t106 = *((char **)t104);
    t62 = ((int  (*)(char *, char *))t106)(t1, t98);
    if (t62 != 0)
        goto LAB148;

LAB147:    t98 = (t2 + 64U);
    t112 = *((char **)t98);
    t98 = (t1 + 31920);
    t117 = (t98 + 56U);
    t118 = *((char **)t117);
    memcpy(t37, t118, 8);
    t119 = (t1 + 6936);
    t127 = (t2 + 56U);
    t128 = *((char **)t127);
    xsi_delete_subprogram_invocation(t119, t112, t1, t128, t2);
    t145 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng142, 2, t145, (char)119, t37, 32);
    t146 = (t2 + 96U);
    t147 = *((char **)t146);
    t148 = (t147 + 640U);
    t149 = (t148 + 56U);
    t150 = *((char **)t149);
    t151 = (t2 + 56U);
    t152 = *((char **)t151);
    t153 = (t1 + 6504);
    t154 = xsi_create_subprogram_invocation(t152, 0, t1, t153, 0, t2);
    t155 = (t1 + 31760);
    xsi_vlogvar_assign_value(t155, t150, 0, 0, 3);

LAB149:    t156 = (t2 + 64U);
    t157 = *((char **)t156);
    t158 = (t157 + 80U);
    t159 = *((char **)t158);
    t160 = (t159 + 272U);
    t161 = *((char **)t160);
    t162 = (t161 + 0U);
    t163 = *((char **)t162);
    t81 = ((int  (*)(char *, char *))t163)(t1, t157);
    if (t81 != 0)
        goto LAB151;

LAB150:    t157 = (t2 + 64U);
    t164 = *((char **)t157);
    t157 = (t1 + 31600);
    t165 = (t157 + 56U);
    t166 = *((char **)t165);
    memcpy(t63, t166, 8);
    t167 = (t1 + 6504);
    t168 = (t2 + 56U);
    t169 = *((char **)t168);
    xsi_delete_subprogram_invocation(t167, t164, t1, t169, t2);
    t170 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng143, 2, t170, (char)119, t63, 32);
    t171 = (t2 + 96U);
    t172 = *((char **)t171);
    t173 = (t172 + 800U);
    t174 = (t173 + 56U);
    t175 = *((char **)t174);
    t176 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng144, 2, t176, (char)118, t175, 2);
    t177 = (t2 + 96U);
    t178 = *((char **)t177);
    t179 = (t178 + 960U);
    t180 = (t179 + 56U);
    t181 = *((char **)t180);
    t182 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng145, 2, t182, (char)118, t181, 1);
    t183 = (t2 + 96U);
    t184 = *((char **)t183);
    t185 = (t184 + 1120U);
    t186 = (t185 + 56U);
    t187 = *((char **)t186);
    t188 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng146, 2, t188, (char)118, t187, 4);
    t189 = (t2 + 96U);
    t190 = *((char **)t189);
    t191 = (t190 + 1280U);
    t192 = (t191 + 56U);
    t193 = *((char **)t192);
    t194 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng147, 2, t194, (char)118, t193, 3);
    t195 = (t2 + 96U);
    t196 = *((char **)t195);
    t197 = (t196 + 1440U);
    t198 = (t197 + 56U);
    t199 = *((char **)t198);
    t200 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng148, 2, t200, (char)118, t199, 4);
    t201 = (t2 + 96U);
    t202 = *((char **)t201);
    t203 = (t202 + 1600U);
    t204 = (t203 + 56U);
    t205 = *((char **)t204);
    t206 = (t1 + 14280);
    xsi_vlogfile_write(0, 0, 0, ng149, 2, t206, (char)118, t205, 4);
    t207 = (t2 + 96U);
    t208 = *((char **)t207);
    t209 = (t208 + 1760U);
    t210 = (t209 + 56U);
    t211 = *((char **)t210);
    t212 = (t1 + 14280);
    xsi_vlogfile_write(1, 0, 0, ng150, 2, t212, (char)118, t211, 1);
    goto LAB144;

LAB148:    t94 = (t2 + 48U);
    *((char **)t94) = &&LAB146;
    goto LAB1;

LAB151:    t156 = (t2 + 48U);
    *((char **)t156) = &&LAB149;
    goto LAB1;

LAB155:    t0 = -1;
    goto LAB1;

LAB157:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB154;
    goto LAB1;

LAB161:    t0 = -1;
    goto LAB1;

LAB163:    t61 = (t2 + 48U);
    *((char **)t61) = &&LAB160;
    goto LAB1;

LAB167:    t0 = -1;
    goto LAB1;

LAB169:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB166;
    goto LAB1;

LAB173:    t0 = -1;
    goto LAB1;

LAB175:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB172;
    goto LAB1;

LAB179:    t0 = -1;
    goto LAB1;

LAB181:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB178;
    goto LAB1;

LAB185:    t0 = -1;
    goto LAB1;

LAB187:    t61 = (t2 + 48U);
    *((char **)t61) = &&LAB184;
    goto LAB1;

LAB191:    t0 = -1;
    goto LAB1;

LAB193:    t61 = (t2 + 48U);
    *((char **)t61) = &&LAB190;
    goto LAB1;

}

static int sp_RECEIVE_READ_ADDRESS(char *t1, char *t2)
{
    char t9[8];
    char t37[8];
    char t46[16];
    char t63[8];
    char t64[8];
    char t65[8];
    char t66[8];
    char t88[8];
    char t102[8];
    char t105[8];
    char t113[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t38;
    char *t39;
    char *t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    int t62;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    char *t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t103;
    char *t104;
    char *t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    char *t112;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    char *t117;
    char *t118;
    char *t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    char *t127;
    char *t128;
    unsigned int t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    unsigned int t136;
    int t137;
    int t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    char *t145;
    char *t146;
    char *t147;
    char *t148;
    char *t149;
    char *t150;
    char *t151;
    char *t152;
    char *t153;
    char *t154;
    char *t155;
    char *t156;
    char *t157;
    char *t158;
    char *t159;
    char *t160;
    char *t161;
    char *t162;
    char *t163;
    char *t164;
    char *t165;
    char *t166;
    char *t167;
    char *t168;
    char *t169;
    char *t170;
    char *t171;
    char *t172;
    char *t173;
    char *t174;
    char *t175;
    char *t176;
    char *t177;
    char *t178;
    char *t179;
    char *t180;
    char *t181;
    char *t182;
    char *t183;
    char *t184;
    char *t185;
    char *t186;
    char *t187;
    char *t188;
    char *t189;
    char *t190;
    char *t191;
    char *t192;
    char *t193;
    char *t194;
    char *t195;
    char *t196;
    char *t197;
    char *t198;
    char *t199;
    char *t200;
    char *t201;
    char *t202;
    char *t203;
    char *t204;
    char *t205;
    char *t206;
    char *t207;
    char *t208;
    char *t209;
    char *t210;
    char *t211;
    char *t212;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 14712);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(725, ng52);

LAB5:    xsi_set_current_line(729, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(743, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB22);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB24:    t25 = (t2 + 64U);
    t31 = *((char **)t25);
    t32 = (t31 + 80U);
    t33 = *((char **)t32);
    t34 = (t33 + 272U);
    t35 = *((char **)t34);
    t36 = (t35 + 0U);
    t38 = *((char **)t36);
    t62 = ((int  (*)(char *, char *))t38)(t1, t31);
    if (t62 == -1)
        goto LAB25;

LAB26:    if (t62 != 0)
        goto LAB27;

LAB22:    t31 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t31);

LAB23:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 10824);
    t47 = (t2 + 56U);
    t48 = *((char **)t47);
    xsi_delete_subprogram_invocation(t39, t40, t1, t48, t2);
    xsi_set_current_line(748, ng52);
    t4 = (t1 + 2696);
    t5 = *((char **)t4);
    t4 = ((char*)((ng104)));
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t5, 32, t4, 32);
    t6 = (t9 + 4);
    t12 = *((unsigned int *)t6);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB28;

LAB29:
LAB30:    xsi_set_current_line(760, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2240U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(761, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2080U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(762, ng52);
    t4 = ((char*)((ng83)));
    t5 = (t1 + 29360);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(764, ng52);

LAB38:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2240U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    t10 = (t8 + 4);
    t12 = *((unsigned int *)t10);
    t13 = (~(t12));
    t14 = *((unsigned int *)t8);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB42;

LAB40:    if (*((unsigned int *)t10) == 0)
        goto LAB39;

LAB41:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;

LAB42:    t24 = (t9 + 4);
    t17 = *((unsigned int *)t24);
    t18 = (~(t17));
    t19 = *((unsigned int *)t9);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB43;

LAB44:    xsi_set_current_line(790, ng52);
    t4 = (t1 + 24480U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 320U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 32);
    xsi_set_current_line(791, ng52);
    t4 = (t1 + 24640U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 480U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 8);
    xsi_set_current_line(792, ng52);
    t4 = (t1 + 24800U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 640U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 3);
    xsi_set_current_line(793, ng52);
    t4 = (t1 + 24960U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 800U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 2);
    xsi_set_current_line(794, ng52);
    t4 = (t1 + 25120U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 960U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(795, ng52);
    t4 = (t1 + 25280U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1120U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(796, ng52);
    t4 = (t1 + 25440U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1280U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 3);
    xsi_set_current_line(797, ng52);
    t4 = (t1 + 25600U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1440U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(798, ng52);
    t4 = (t1 + 25760U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1600U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(799, ng52);
    t4 = (t1 + 25920U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1760U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(800, ng52);
    t4 = (t1 + 24320U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 1920U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(802, ng52);
    t4 = (t1 + 2696);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t5, 32, t4, 32);
    t6 = (t9 + 4);
    t12 = *((unsigned int *)t6);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB128;

LAB129:
LAB130:    xsi_set_current_line(808, ng52);
    t4 = (t1 + 27920);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB141;

LAB138:    if (t21 != 0)
        goto LAB140;

LAB139:    *((unsigned int *)t9) = 1;

LAB141:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB142;

LAB143:
LAB144:    xsi_set_current_line(827, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB152);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 3912);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 2);

LAB154:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB155;

LAB156:    if (t62 != 0)
        goto LAB157;

LAB152:    t40 = (t1 + 3912);
    xsi_vlog_subprogram_popinvocation(t40);

LAB153:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 3912);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(828, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 960U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t47 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB158);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 4344);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 2);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t31, 0, 0, 8);
    t58 = (t51 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t36, 0, 0, 1);

LAB160:    t61 = (t2 + 64U);
    t94 = *((char **)t61);
    t98 = (t94 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t103 = (t101 + 0U);
    t104 = *((char **)t103);
    t62 = ((int  (*)(char *, char *))t104)(t1, t94);
    if (t62 == -1)
        goto LAB161;

LAB162:    if (t62 != 0)
        goto LAB163;

LAB158:    t94 = (t1 + 4344);
    xsi_vlog_subprogram_popinvocation(t94);

LAB159:    t106 = (t2 + 64U);
    t112 = *((char **)t106);
    t106 = (t1 + 4344);
    t117 = (t2 + 56U);
    t118 = *((char **)t117);
    xsi_delete_subprogram_invocation(t106, t112, t1, t118, t2);
    xsi_set_current_line(829, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 640U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB164);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 4776);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 3);

LAB166:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB167;

LAB168:    if (t62 != 0)
        goto LAB169;

LAB164:    t40 = (t1 + 4776);
    xsi_vlog_subprogram_popinvocation(t40);

LAB165:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 4776);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(830, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB170);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 5208);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 1);

LAB172:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB173;

LAB174:    if (t62 != 0)
        goto LAB175;

LAB170:    t40 = (t1 + 5208);
    xsi_vlog_subprogram_popinvocation(t40);

LAB171:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 5208);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(831, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1120U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t25, &&LAB176);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    t33 = (t1 + 5640);
    t34 = xsi_create_subprogram_invocation(t32, 0, t1, t33, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t36 = *((char **)t35);
    t38 = (t36 + 0U);
    xsi_vlogvar_assign_value(t38, t8, 0, 0, 4);

LAB178:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t47 = (t40 + 80U);
    t48 = *((char **)t47);
    t49 = (t48 + 272U);
    t50 = *((char **)t49);
    t51 = (t50 + 0U);
    t52 = *((char **)t51);
    t62 = ((int  (*)(char *, char *))t52)(t1, t40);
    if (t62 == -1)
        goto LAB179;

LAB180:    if (t62 != 0)
        goto LAB181;

LAB176:    t40 = (t1 + 5640);
    xsi_vlog_subprogram_popinvocation(t40);

LAB177:    t53 = (t2 + 64U);
    t54 = *((char **)t53);
    t53 = (t1 + 5640);
    t55 = (t2 + 56U);
    t56 = *((char **)t55);
    xsi_delete_subprogram_invocation(t53, t54, t1, t56, t2);
    xsi_set_current_line(832, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 800U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t47 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB182);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 19896);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 32);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t31, 0, 0, 8);
    t58 = (t51 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t36, 0, 0, 2);

LAB184:    t61 = (t2 + 64U);
    t94 = *((char **)t61);
    t98 = (t94 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t103 = (t101 + 0U);
    t104 = *((char **)t103);
    t62 = ((int  (*)(char *, char *))t104)(t1, t94);
    if (t62 == -1)
        goto LAB185;

LAB186:    if (t62 != 0)
        goto LAB187;

LAB182:    t94 = (t1 + 19896);
    xsi_vlog_subprogram_popinvocation(t94);

LAB183:    t106 = (t2 + 64U);
    t112 = *((char **)t106);
    t106 = (t1 + 19896);
    t117 = (t2 + 56U);
    t118 = *((char **)t117);
    xsi_delete_subprogram_invocation(t106, t112, t1, t118, t2);
    xsi_set_current_line(833, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 800U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 640U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t47 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB188);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 6072);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 32);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t31, 0, 0, 2);
    t58 = (t51 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t36, 0, 0, 3);

LAB190:    t61 = (t2 + 64U);
    t94 = *((char **)t61);
    t98 = (t94 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t103 = (t101 + 0U);
    t104 = *((char **)t103);
    t62 = ((int  (*)(char *, char *))t104)(t1, t94);
    if (t62 == -1)
        goto LAB191;

LAB192:    if (t62 != 0)
        goto LAB193;

LAB188:    t94 = (t1 + 6072);
    xsi_vlog_subprogram_popinvocation(t94);

LAB189:    t106 = (t2 + 64U);
    t112 = *((char **)t106);
    t106 = (t1 + 6072);
    t117 = (t2 + 56U);
    t118 = *((char **)t117);
    xsi_delete_subprogram_invocation(t106, t112, t1, t118, t2);
    xsi_set_current_line(838, ng52);
    t4 = (t1 + 31120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t6, 32, t7, 32);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB194;

LAB195:
LAB196:    xsi_set_current_line(843, ng52);
    t4 = (t1 + 45600);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(729, ng52);

LAB13:    xsi_set_current_line(730, ng52);
    t31 = (t2 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 160U);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = ((char*)((ng86)));
    memset(t37, 0, 8);
    if (*((unsigned int *)t35) != *((unsigned int *)t36))
        goto LAB16;

LAB14:    t38 = (t35 + 4);
    t39 = (t36 + 4);
    if (*((unsigned int *)t38) != *((unsigned int *)t39))
        goto LAB16;

LAB15:    *((unsigned int *)t37) = 1;

LAB16:    t40 = (t37 + 4);
    t41 = *((unsigned int *)t40);
    t42 = (~(t41));
    t43 = *((unsigned int *)t37);
    t44 = (t43 & t42);
    t45 = (t44 != 0);
    if (t45 > 0)
        goto LAB17;

LAB18:    xsi_set_current_line(736, ng52);

LAB21:    xsi_set_current_line(737, ng52);
    t4 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng56)));
    t6 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng151, 3, t6, (char)118, t46, 64, (char)118, t5, 56);
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t10 = (t8 + 160U);
    t11 = (t10 + 56U);
    t24 = *((char **)t11);
    t25 = (t1 + 14712);
    xsi_vlogfile_write(1, 0, 0, ng136, 2, t25, (char)118, t24, 1);

LAB19:    goto LAB12;

LAB17:    xsi_set_current_line(730, ng52);

LAB20:    xsi_set_current_line(731, ng52);
    t47 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t48 = ((char*)((ng56)));
    t49 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng151, 3, t49, (char)118, t46, 64, (char)118, t48, 56);
    t50 = (t2 + 96U);
    t51 = *((char **)t50);
    t52 = (t51 + 0U);
    t53 = (t52 + 56U);
    t54 = *((char **)t53);
    t55 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t55, (char)118, t54, 1);
    t56 = (t2 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 160U);
    t59 = (t58 + 56U);
    t60 = *((char **)t59);
    t61 = (t1 + 14712);
    xsi_vlogfile_write(1, 0, 0, ng135, 2, t61, (char)118, t60, 1);
    goto LAB19;

LAB25:    t0 = -1;
    goto LAB1;

LAB27:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB24;
    goto LAB1;

LAB28:    xsi_set_current_line(748, ng52);

LAB31:    xsi_set_current_line(749, ng52);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t11, &&LAB32);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    t31 = (t1 + 12552);
    t32 = xsi_create_subprogram_invocation(t25, 0, t1, t31, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t31, t32);

LAB34:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t36 = *((char **)t35);
    t38 = (t36 + 272U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t47 = *((char **)t40);
    t62 = ((int  (*)(char *, char *))t47)(t1, t34);
    if (t62 == -1)
        goto LAB35;

LAB36:    if (t62 != 0)
        goto LAB37;

LAB32:    t34 = (t1 + 12552);
    xsi_vlog_subprogram_popinvocation(t34);

LAB33:    t48 = (t2 + 64U);
    t49 = *((char **)t48);
    t48 = (t1 + 12552);
    t50 = (t2 + 56U);
    t51 = *((char **)t50);
    xsi_delete_subprogram_invocation(t48, t49, t1, t51, t2);
    goto LAB30;

LAB35:    t0 = -1;
    goto LAB1;

LAB37:    t33 = (t2 + 48U);
    *((char **)t33) = &&LAB34;
    goto LAB1;

LAB39:    *((unsigned int *)t9) = 1;
    goto LAB42;

LAB43:    xsi_set_current_line(764, ng52);
    t25 = (t2 + 88U);
    t31 = *((char **)t25);
    t32 = (t31 + 0U);
    xsi_wp_set_status(t32, 1);
    *((char **)t3) = &&LAB45;
    goto LAB1;

LAB45:    xsi_set_current_line(764, ng52);

LAB46:    xsi_set_current_line(765, ng52);
    t33 = ((char*)((ng83)));
    t34 = (t1 + 29360);
    xsi_vlogvar_wait_assign_value(t34, t33, 0, 0, 1, 0LL);
    xsi_set_current_line(766, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng86)));
    memset(t9, 0, 8);
    if (*((unsigned int *)t8) != *((unsigned int *)t10))
        goto LAB49;

LAB47:    t11 = (t8 + 4);
    t24 = (t10 + 4);
    if (*((unsigned int *)t11) != *((unsigned int *)t24))
        goto LAB49;

LAB48:    *((unsigned int *)t9) = 1;

LAB49:    t25 = (t9 + 4);
    t12 = *((unsigned int *)t25);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB50;

LAB51:    xsi_set_current_line(769, ng52);

LAB91:    xsi_set_current_line(770, ng52);
    t4 = (t1 + 26080U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t9, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB94;

LAB92:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB94;

LAB93:    *((unsigned int *)t9) = 1;

LAB94:    memset(t37, 0, 8);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB95;

LAB96:    if (*((unsigned int *)t8) != 0)
        goto LAB97;

LAB98:    t11 = (t37 + 4);
    t17 = *((unsigned int *)t37);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB99;

LAB100:    memcpy(t65, t37, 8);

LAB101:    t49 = (t2 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 2240U);
    xsi_vlogvar_assign_value(t51, t65, 0, 0, 1);

LAB52:    xsi_set_current_line(773, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2080U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(774, ng52);
    t4 = (t1 + 27440);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng104)));
    memset(t9, 0, 8);
    xsi_vlog_signed_not_equal(t9, 32, t6, 32, t7, 32);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB112;

LAB113:
LAB114:    goto LAB38;

LAB50:    xsi_set_current_line(766, ng52);

LAB53:    xsi_set_current_line(767, ng52);
    t31 = (t1 + 26080U);
    t32 = *((char **)t31);
    t31 = ((char*)((ng83)));
    memset(t37, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t31))
        goto LAB56;

LAB54:    t33 = (t32 + 4);
    t34 = (t31 + 4);
    if (*((unsigned int *)t33) != *((unsigned int *)t34))
        goto LAB56;

LAB55:    *((unsigned int *)t37) = 1;

LAB56:    memset(t63, 0, 8);
    t35 = (t37 + 4);
    t17 = *((unsigned int *)t35);
    t18 = (~(t17));
    t19 = *((unsigned int *)t37);
    t20 = (t19 & t18);
    t21 = (t20 & 1U);
    if (t21 != 0)
        goto LAB57;

LAB58:    if (*((unsigned int *)t35) != 0)
        goto LAB59;

LAB60:    t38 = (t63 + 4);
    t22 = *((unsigned int *)t63);
    t23 = *((unsigned int *)t38);
    t26 = (t22 || t23);
    if (t26 > 0)
        goto LAB61;

LAB62:    memcpy(t66, t63, 8);

LAB63:    memset(t88, 0, 8);
    t60 = (t66 + 4);
    t89 = *((unsigned int *)t60);
    t90 = (~(t89));
    t91 = *((unsigned int *)t66);
    t92 = (t91 & t90);
    t93 = (t92 & 1U);
    if (t93 != 0)
        goto LAB74;

LAB75:    if (*((unsigned int *)t60) != 0)
        goto LAB76;

LAB77:    t94 = (t88 + 4);
    t95 = *((unsigned int *)t88);
    t96 = *((unsigned int *)t94);
    t97 = (t95 || t96);
    if (t97 > 0)
        goto LAB78;

LAB79:    memcpy(t113, t88, 8);

LAB80:    t145 = (t2 + 96U);
    t146 = *((char **)t145);
    t147 = (t146 + 2240U);
    xsi_vlogvar_assign_value(t147, t113, 0, 0, 1);
    goto LAB52;

LAB57:    *((unsigned int *)t63) = 1;
    goto LAB60;

LAB59:    t36 = (t63 + 4);
    *((unsigned int *)t63) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB60;

LAB61:    t39 = (t1 + 24320U);
    t40 = *((char **)t39);
    t39 = (t2 + 96U);
    t47 = *((char **)t39);
    t48 = (t47 + 0U);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    memset(t64, 0, 8);
    if (*((unsigned int *)t40) != *((unsigned int *)t50))
        goto LAB66;

LAB64:    t51 = (t40 + 4);
    t52 = (t50 + 4);
    if (*((unsigned int *)t51) != *((unsigned int *)t52))
        goto LAB66;

LAB65:    *((unsigned int *)t64) = 1;

LAB66:    memset(t65, 0, 8);
    t53 = (t64 + 4);
    t27 = *((unsigned int *)t53);
    t28 = (~(t27));
    t29 = *((unsigned int *)t64);
    t30 = (t29 & t28);
    t41 = (t30 & 1U);
    if (t41 != 0)
        goto LAB67;

LAB68:    if (*((unsigned int *)t53) != 0)
        goto LAB69;

LAB70:    t42 = *((unsigned int *)t63);
    t43 = *((unsigned int *)t65);
    t44 = (t42 & t43);
    *((unsigned int *)t66) = t44;
    t55 = (t63 + 4);
    t56 = (t65 + 4);
    t57 = (t66 + 4);
    t45 = *((unsigned int *)t55);
    t67 = *((unsigned int *)t56);
    t68 = (t45 | t67);
    *((unsigned int *)t57) = t68;
    t69 = *((unsigned int *)t57);
    t70 = (t69 != 0);
    if (t70 == 1)
        goto LAB71;

LAB72:
LAB73:    goto LAB63;

LAB67:    *((unsigned int *)t65) = 1;
    goto LAB70;

LAB69:    t54 = (t65 + 4);
    *((unsigned int *)t65) = 1;
    *((unsigned int *)t54) = 1;
    goto LAB70;

LAB71:    t71 = *((unsigned int *)t66);
    t72 = *((unsigned int *)t57);
    *((unsigned int *)t66) = (t71 | t72);
    t58 = (t63 + 4);
    t59 = (t65 + 4);
    t73 = *((unsigned int *)t63);
    t74 = (~(t73));
    t75 = *((unsigned int *)t58);
    t76 = (~(t75));
    t77 = *((unsigned int *)t65);
    t78 = (~(t77));
    t79 = *((unsigned int *)t59);
    t80 = (~(t79));
    t62 = (t74 & t76);
    t81 = (t78 & t80);
    t82 = (~(t62));
    t83 = (~(t81));
    t84 = *((unsigned int *)t57);
    *((unsigned int *)t57) = (t84 & t82);
    t85 = *((unsigned int *)t57);
    *((unsigned int *)t57) = (t85 & t83);
    t86 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t86 & t82);
    t87 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t87 & t83);
    goto LAB73;

LAB74:    *((unsigned int *)t88) = 1;
    goto LAB77;

LAB76:    t61 = (t88 + 4);
    *((unsigned int *)t88) = 1;
    *((unsigned int *)t61) = 1;
    goto LAB77;

LAB78:    t98 = (t1 + 29360);
    t99 = (t98 + 56U);
    t100 = *((char **)t99);
    t101 = ((char*)((ng83)));
    memset(t102, 0, 8);
    if (*((unsigned int *)t100) != *((unsigned int *)t101))
        goto LAB83;

LAB81:    t103 = (t100 + 4);
    t104 = (t101 + 4);
    if (*((unsigned int *)t103) != *((unsigned int *)t104))
        goto LAB83;

LAB82:    *((unsigned int *)t102) = 1;

LAB83:    memset(t105, 0, 8);
    t106 = (t102 + 4);
    t107 = *((unsigned int *)t106);
    t108 = (~(t107));
    t109 = *((unsigned int *)t102);
    t110 = (t109 & t108);
    t111 = (t110 & 1U);
    if (t111 != 0)
        goto LAB84;

LAB85:    if (*((unsigned int *)t106) != 0)
        goto LAB86;

LAB87:    t114 = *((unsigned int *)t88);
    t115 = *((unsigned int *)t105);
    t116 = (t114 & t115);
    *((unsigned int *)t113) = t116;
    t117 = (t88 + 4);
    t118 = (t105 + 4);
    t119 = (t113 + 4);
    t120 = *((unsigned int *)t117);
    t121 = *((unsigned int *)t118);
    t122 = (t120 | t121);
    *((unsigned int *)t119) = t122;
    t123 = *((unsigned int *)t119);
    t124 = (t123 != 0);
    if (t124 == 1)
        goto LAB88;

LAB89:
LAB90:    goto LAB80;

LAB84:    *((unsigned int *)t105) = 1;
    goto LAB87;

LAB86:    t112 = (t105 + 4);
    *((unsigned int *)t105) = 1;
    *((unsigned int *)t112) = 1;
    goto LAB87;

LAB88:    t125 = *((unsigned int *)t113);
    t126 = *((unsigned int *)t119);
    *((unsigned int *)t113) = (t125 | t126);
    t127 = (t88 + 4);
    t128 = (t105 + 4);
    t129 = *((unsigned int *)t88);
    t130 = (~(t129));
    t131 = *((unsigned int *)t127);
    t132 = (~(t131));
    t133 = *((unsigned int *)t105);
    t134 = (~(t133));
    t135 = *((unsigned int *)t128);
    t136 = (~(t135));
    t137 = (t130 & t132);
    t138 = (t134 & t136);
    t139 = (~(t137));
    t140 = (~(t138));
    t141 = *((unsigned int *)t119);
    *((unsigned int *)t119) = (t141 & t139);
    t142 = *((unsigned int *)t119);
    *((unsigned int *)t119) = (t142 & t140);
    t143 = *((unsigned int *)t113);
    *((unsigned int *)t113) = (t143 & t139);
    t144 = *((unsigned int *)t113);
    *((unsigned int *)t113) = (t144 & t140);
    goto LAB90;

LAB95:    *((unsigned int *)t37) = 1;
    goto LAB98;

LAB97:    t10 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB98;

LAB99:    t24 = (t1 + 29360);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = ((char*)((ng83)));
    memset(t63, 0, 8);
    if (*((unsigned int *)t31) != *((unsigned int *)t32))
        goto LAB104;

LAB102:    t33 = (t31 + 4);
    t34 = (t32 + 4);
    if (*((unsigned int *)t33) != *((unsigned int *)t34))
        goto LAB104;

LAB103:    *((unsigned int *)t63) = 1;

LAB104:    memset(t64, 0, 8);
    t35 = (t63 + 4);
    t20 = *((unsigned int *)t35);
    t21 = (~(t20));
    t22 = *((unsigned int *)t63);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB105;

LAB106:    if (*((unsigned int *)t35) != 0)
        goto LAB107;

LAB108:    t27 = *((unsigned int *)t37);
    t28 = *((unsigned int *)t64);
    t29 = (t27 & t28);
    *((unsigned int *)t65) = t29;
    t38 = (t37 + 4);
    t39 = (t64 + 4);
    t40 = (t65 + 4);
    t30 = *((unsigned int *)t38);
    t41 = *((unsigned int *)t39);
    t42 = (t30 | t41);
    *((unsigned int *)t40) = t42;
    t43 = *((unsigned int *)t40);
    t44 = (t43 != 0);
    if (t44 == 1)
        goto LAB109;

LAB110:
LAB111:    goto LAB101;

LAB105:    *((unsigned int *)t64) = 1;
    goto LAB108;

LAB107:    t36 = (t64 + 4);
    *((unsigned int *)t64) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB108;

LAB109:    t45 = *((unsigned int *)t65);
    t67 = *((unsigned int *)t40);
    *((unsigned int *)t65) = (t45 | t67);
    t47 = (t37 + 4);
    t48 = (t64 + 4);
    t68 = *((unsigned int *)t37);
    t69 = (~(t68));
    t70 = *((unsigned int *)t47);
    t71 = (~(t70));
    t72 = *((unsigned int *)t64);
    t73 = (~(t72));
    t74 = *((unsigned int *)t48);
    t75 = (~(t74));
    t62 = (t69 & t71);
    t81 = (t73 & t75);
    t76 = (~(t62));
    t77 = (~(t81));
    t78 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t78 & t76);
    t79 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t79 & t77);
    t80 = *((unsigned int *)t65);
    *((unsigned int *)t65) = (t80 & t76);
    t82 = *((unsigned int *)t65);
    *((unsigned int *)t65) = (t82 & t77);
    goto LAB111;

LAB112:    xsi_set_current_line(774, ng52);

LAB115:    xsi_set_current_line(775, ng52);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 2080U);
    t25 = (t24 + 56U);
    t31 = *((char **)t25);
    t32 = (t1 + 27440);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memset(t37, 0, 8);
    xsi_vlog_signed_equal(t37, 32, t31, 32, t34, 32);
    t35 = (t37 + 4);
    t17 = *((unsigned int *)t35);
    t18 = (~(t17));
    t19 = *((unsigned int *)t37);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB116;

LAB117:
LAB118:    goto LAB114;

LAB116:    xsi_set_current_line(775, ng52);

LAB119:    xsi_set_current_line(776, ng52);
    t36 = (t2 + 96U);
    t38 = *((char **)t36);
    t39 = (t38 + 160U);
    t40 = (t39 + 56U);
    t47 = *((char **)t40);
    t48 = ((char*)((ng86)));
    memset(t63, 0, 8);
    if (*((unsigned int *)t47) != *((unsigned int *)t48))
        goto LAB122;

LAB120:    t49 = (t47 + 4);
    t50 = (t48 + 4);
    if (*((unsigned int *)t49) != *((unsigned int *)t50))
        goto LAB122;

LAB121:    *((unsigned int *)t63) = 1;

LAB122:    t51 = (t63 + 4);
    t22 = *((unsigned int *)t51);
    t23 = (~(t22));
    t26 = *((unsigned int *)t63);
    t27 = (t26 & t23);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB123;

LAB124:    xsi_set_current_line(780, ng52);

LAB127:    xsi_set_current_line(781, ng52);
    t4 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng56)));
    t6 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng152, 3, t6, (char)118, t46, 64, (char)118, t5, 56);
    t7 = (t1 + 14712);
    xsi_vlogfile_write(1, 0, 0, ng154, 1, t7);

LAB125:    xsi_set_current_line(784, ng52);
    xsi_vlog_stop(1);
    goto LAB118;

LAB123:    xsi_set_current_line(776, ng52);

LAB126:    xsi_set_current_line(777, ng52);
    t52 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t53 = ((char*)((ng56)));
    t54 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng152, 3, t54, (char)118, t46, 64, (char)118, t53, 56);
    t55 = (t2 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 0U);
    t58 = (t57 + 56U);
    t59 = *((char **)t58);
    t60 = (t1 + 14712);
    xsi_vlogfile_write(1, 0, 0, ng153, 2, t60, (char)118, t59, 1);
    goto LAB125;

LAB128:    xsi_set_current_line(802, ng52);

LAB131:    xsi_set_current_line(803, ng52);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t11, &&LAB132);
    t24 = (t2 + 56U);
    t25 = *((char **)t24);
    t31 = (t1 + 12552);
    t32 = xsi_create_subprogram_invocation(t25, 0, t1, t31, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t31, t32);

LAB134:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t36 = *((char **)t35);
    t38 = (t36 + 272U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t47 = *((char **)t40);
    t62 = ((int  (*)(char *, char *))t47)(t1, t34);
    if (t62 == -1)
        goto LAB135;

LAB136:    if (t62 != 0)
        goto LAB137;

LAB132:    t34 = (t1 + 12552);
    xsi_vlog_subprogram_popinvocation(t34);

LAB133:    t48 = (t2 + 64U);
    t49 = *((char **)t48);
    t48 = (t1 + 12552);
    t50 = (t2 + 56U);
    t51 = *((char **)t50);
    xsi_delete_subprogram_invocation(t48, t49, t1, t51, t2);
    goto LAB130;

LAB135:    t0 = -1;
    goto LAB1;

LAB137:    t33 = (t2 + 48U);
    *((char **)t33) = &&LAB134;
    goto LAB1;

LAB140:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB141;

LAB142:    xsi_set_current_line(808, ng52);

LAB145:    xsi_set_current_line(809, ng52);
    t25 = xsi_vlog_time(t46, 10000.000000000000, 1000.0000000000000);
    t31 = ((char*)((ng56)));
    t32 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng155, 3, t32, (char)118, t46, 64, (char)118, t31, 56);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 1920U);
    t36 = (t35 + 56U);
    t38 = *((char **)t36);
    t39 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t39, (char)118, t38, 1);
    t40 = (t2 + 96U);
    t47 = *((char **)t40);
    t48 = (t47 + 320U);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    t51 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng141, 2, t51, (char)118, t50, 32);
    t52 = (t2 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 480U);
    t55 = (t54 + 56U);
    t56 = *((char **)t55);
    t57 = (t2 + 56U);
    t58 = *((char **)t57);
    t59 = (t1 + 6936);
    t60 = xsi_create_subprogram_invocation(t58, 0, t1, t59, 0, t2);
    t61 = (t1 + 32080);
    xsi_vlogvar_assign_value(t61, t56, 0, 0, 8);

LAB146:    t94 = (t2 + 64U);
    t98 = *((char **)t94);
    t99 = (t98 + 80U);
    t100 = *((char **)t99);
    t101 = (t100 + 272U);
    t103 = *((char **)t101);
    t104 = (t103 + 0U);
    t106 = *((char **)t104);
    t62 = ((int  (*)(char *, char *))t106)(t1, t98);
    if (t62 != 0)
        goto LAB148;

LAB147:    t98 = (t2 + 64U);
    t112 = *((char **)t98);
    t98 = (t1 + 31920);
    t117 = (t98 + 56U);
    t118 = *((char **)t117);
    memcpy(t37, t118, 8);
    t119 = (t1 + 6936);
    t127 = (t2 + 56U);
    t128 = *((char **)t127);
    xsi_delete_subprogram_invocation(t119, t112, t1, t128, t2);
    t145 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng142, 2, t145, (char)119, t37, 32);
    t146 = (t2 + 96U);
    t147 = *((char **)t146);
    t148 = (t147 + 640U);
    t149 = (t148 + 56U);
    t150 = *((char **)t149);
    t151 = (t2 + 56U);
    t152 = *((char **)t151);
    t153 = (t1 + 6504);
    t154 = xsi_create_subprogram_invocation(t152, 0, t1, t153, 0, t2);
    t155 = (t1 + 31760);
    xsi_vlogvar_assign_value(t155, t150, 0, 0, 3);

LAB149:    t156 = (t2 + 64U);
    t157 = *((char **)t156);
    t158 = (t157 + 80U);
    t159 = *((char **)t158);
    t160 = (t159 + 272U);
    t161 = *((char **)t160);
    t162 = (t161 + 0U);
    t163 = *((char **)t162);
    t81 = ((int  (*)(char *, char *))t163)(t1, t157);
    if (t81 != 0)
        goto LAB151;

LAB150:    t157 = (t2 + 64U);
    t164 = *((char **)t157);
    t157 = (t1 + 31600);
    t165 = (t157 + 56U);
    t166 = *((char **)t165);
    memcpy(t63, t166, 8);
    t167 = (t1 + 6504);
    t168 = (t2 + 56U);
    t169 = *((char **)t168);
    xsi_delete_subprogram_invocation(t167, t164, t1, t169, t2);
    t170 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng143, 2, t170, (char)119, t63, 32);
    t171 = (t2 + 96U);
    t172 = *((char **)t171);
    t173 = (t172 + 800U);
    t174 = (t173 + 56U);
    t175 = *((char **)t174);
    t176 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng144, 2, t176, (char)118, t175, 2);
    t177 = (t2 + 96U);
    t178 = *((char **)t177);
    t179 = (t178 + 960U);
    t180 = (t179 + 56U);
    t181 = *((char **)t180);
    t182 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng145, 2, t182, (char)118, t181, 1);
    t183 = (t2 + 96U);
    t184 = *((char **)t183);
    t185 = (t184 + 1120U);
    t186 = (t185 + 56U);
    t187 = *((char **)t186);
    t188 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng146, 2, t188, (char)118, t187, 4);
    t189 = (t2 + 96U);
    t190 = *((char **)t189);
    t191 = (t190 + 1280U);
    t192 = (t191 + 56U);
    t193 = *((char **)t192);
    t194 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng147, 2, t194, (char)118, t193, 3);
    t195 = (t2 + 96U);
    t196 = *((char **)t195);
    t197 = (t196 + 1440U);
    t198 = (t197 + 56U);
    t199 = *((char **)t198);
    t200 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng148, 2, t200, (char)118, t199, 4);
    t201 = (t2 + 96U);
    t202 = *((char **)t201);
    t203 = (t202 + 1600U);
    t204 = (t203 + 56U);
    t205 = *((char **)t204);
    t206 = (t1 + 14712);
    xsi_vlogfile_write(0, 0, 0, ng149, 2, t206, (char)118, t205, 4);
    t207 = (t2 + 96U);
    t208 = *((char **)t207);
    t209 = (t208 + 1760U);
    t210 = (t209 + 56U);
    t211 = *((char **)t210);
    t212 = (t1 + 14712);
    xsi_vlogfile_write(1, 0, 0, ng156, 2, t212, (char)118, t211, 1);
    goto LAB144;

LAB148:    t94 = (t2 + 48U);
    *((char **)t94) = &&LAB146;
    goto LAB1;

LAB151:    t156 = (t2 + 48U);
    *((char **)t156) = &&LAB149;
    goto LAB1;

LAB155:    t0 = -1;
    goto LAB1;

LAB157:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB154;
    goto LAB1;

LAB161:    t0 = -1;
    goto LAB1;

LAB163:    t61 = (t2 + 48U);
    *((char **)t61) = &&LAB160;
    goto LAB1;

LAB167:    t0 = -1;
    goto LAB1;

LAB169:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB166;
    goto LAB1;

LAB173:    t0 = -1;
    goto LAB1;

LAB175:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB172;
    goto LAB1;

LAB179:    t0 = -1;
    goto LAB1;

LAB181:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB178;
    goto LAB1;

LAB185:    t0 = -1;
    goto LAB1;

LAB187:    t61 = (t2 + 48U);
    *((char **)t61) = &&LAB184;
    goto LAB1;

LAB191:    t0 = -1;
    goto LAB1;

LAB193:    t61 = (t2 + 48U);
    *((char **)t61) = &&LAB190;
    goto LAB1;

LAB194:    xsi_set_current_line(838, ng52);
    t10 = ((char*)((ng104)));
    t11 = (t1 + 29360);
    xsi_vlogvar_wait_assign_value(t11, t10, 0, 0, 1, 0LL);
    goto LAB196;

}

static int sp_RECEIVE_WRITE_DATA(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t44[8];
    char t45[8];
    char t46[8];
    char t47[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    int t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 15144);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(876, ng52);

LAB5:    xsi_set_current_line(880, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(885, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB16:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t39 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t39 == -1)
        goto LAB17;

LAB18:    if (t39 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 10824);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);
    xsi_set_current_line(893, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 800U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(894, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 640U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(895, ng52);
    t4 = ((char*)((ng83)));
    t5 = (t1 + 28560);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(897, ng52);

LAB20:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    t10 = (t8 + 4);
    t12 = *((unsigned int *)t10);
    t13 = (~(t12));
    t14 = *((unsigned int *)t8);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB24;

LAB22:    if (*((unsigned int *)t10) == 0)
        goto LAB21;

LAB23:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;

LAB24:    t24 = (t9 + 4);
    t17 = *((unsigned int *)t24);
    t18 = (~(t17));
    t19 = *((unsigned int *)t9);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB25;

LAB26:    xsi_set_current_line(911, ng52);
    t4 = (t1 + 23360U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 32);
    xsi_set_current_line(912, ng52);
    t4 = (t1 + 23520U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 160U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 4);
    xsi_set_current_line(913, ng52);
    t4 = (t1 + 23840U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 480U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(914, ng52);
    t4 = (t1 + 23680U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 320U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 1);
    xsi_set_current_line(919, ng52);
    t4 = (t1 + 27920);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB60;

LAB57:    if (t21 != 0)
        goto LAB59;

LAB58:    *((unsigned int *)t9) = 1;

LAB60:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB61;

LAB62:
LAB63:    xsi_set_current_line(931, ng52);
    t4 = (t1 + 31120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t6, 32, t7, 32);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(936, ng52);
    t4 = (t1 + 46104);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(880, ng52);

LAB13:    xsi_set_current_line(881, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 15144);
    xsi_vlogfile_write(1, 0, 0, ng157, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB21:    *((unsigned int *)t9) = 1;
    goto LAB24;

LAB25:    xsi_set_current_line(897, ng52);
    t25 = (t2 + 88U);
    t32 = *((char **)t25);
    t33 = (t32 + 0U);
    xsi_wp_set_status(t33, 1);
    *((char **)t3) = &&LAB27;
    goto LAB1;

LAB27:    xsi_set_current_line(897, ng52);

LAB28:    xsi_set_current_line(898, ng52);
    t34 = ((char*)((ng83)));
    t35 = (t1 + 28560);
    xsi_vlogvar_wait_assign_value(t35, t34, 0, 0, 1, 0LL);
    xsi_set_current_line(899, ng52);
    t4 = (t1 + 24000U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng83)));
    memset(t9, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB31;

LAB29:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB31;

LAB30:    *((unsigned int *)t9) = 1;

LAB31:    memset(t44, 0, 8);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB32;

LAB33:    if (*((unsigned int *)t8) != 0)
        goto LAB34;

LAB35:    t11 = (t44 + 4);
    t17 = *((unsigned int *)t44);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB36;

LAB37:    memcpy(t47, t44, 8);

LAB38:    t69 = (t2 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 800U);
    xsi_vlogvar_assign_value(t71, t47, 0, 0, 1);
    xsi_set_current_line(901, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 640U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 640U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(902, ng52);
    t4 = (t1 + 27440);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng104)));
    memset(t9, 0, 8);
    xsi_vlog_signed_not_equal(t9, 32, t6, 32, t7, 32);
    t8 = (t9 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB49;

LAB50:
LAB51:    goto LAB20;

LAB32:    *((unsigned int *)t44) = 1;
    goto LAB35;

LAB34:    t10 = (t44 + 4);
    *((unsigned int *)t44) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB35;

LAB36:    t24 = (t1 + 28560);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng83)));
    memset(t45, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t33))
        goto LAB41;

LAB39:    t34 = (t32 + 4);
    t35 = (t33 + 4);
    if (*((unsigned int *)t34) != *((unsigned int *)t35))
        goto LAB41;

LAB40:    *((unsigned int *)t45) = 1;

LAB41:    memset(t46, 0, 8);
    t36 = (t45 + 4);
    t20 = *((unsigned int *)t36);
    t21 = (~(t20));
    t22 = *((unsigned int *)t45);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB42;

LAB43:    if (*((unsigned int *)t36) != 0)
        goto LAB44;

LAB45:    t27 = *((unsigned int *)t44);
    t28 = *((unsigned int *)t46);
    t29 = (t27 & t28);
    *((unsigned int *)t47) = t29;
    t38 = (t44 + 4);
    t40 = (t46 + 4);
    t41 = (t47 + 4);
    t30 = *((unsigned int *)t38);
    t48 = *((unsigned int *)t40);
    t49 = (t30 | t48);
    *((unsigned int *)t41) = t49;
    t50 = *((unsigned int *)t41);
    t51 = (t50 != 0);
    if (t51 == 1)
        goto LAB46;

LAB47:
LAB48:    goto LAB38;

LAB42:    *((unsigned int *)t46) = 1;
    goto LAB45;

LAB44:    t37 = (t46 + 4);
    *((unsigned int *)t46) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB45;

LAB46:    t52 = *((unsigned int *)t47);
    t53 = *((unsigned int *)t41);
    *((unsigned int *)t47) = (t52 | t53);
    t42 = (t44 + 4);
    t43 = (t46 + 4);
    t54 = *((unsigned int *)t44);
    t55 = (~(t54));
    t56 = *((unsigned int *)t42);
    t57 = (~(t56));
    t58 = *((unsigned int *)t46);
    t59 = (~(t58));
    t60 = *((unsigned int *)t43);
    t61 = (~(t60));
    t39 = (t55 & t57);
    t62 = (t59 & t61);
    t63 = (~(t39));
    t64 = (~(t62));
    t65 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t65 & t63);
    t66 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t66 & t64);
    t67 = *((unsigned int *)t47);
    *((unsigned int *)t47) = (t67 & t63);
    t68 = *((unsigned int *)t47);
    *((unsigned int *)t47) = (t68 & t64);
    goto LAB48;

LAB49:    xsi_set_current_line(902, ng52);

LAB52:    xsi_set_current_line(903, ng52);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 640U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t1 + 27440);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memset(t44, 0, 8);
    xsi_vlog_signed_equal(t44, 32, t32, 32, t35, 32);
    t36 = (t44 + 4);
    t17 = *((unsigned int *)t36);
    t18 = (~(t17));
    t19 = *((unsigned int *)t44);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB53;

LAB54:
LAB55:    goto LAB51;

LAB53:    xsi_set_current_line(903, ng52);

LAB56:    xsi_set_current_line(904, ng52);
    t37 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t38 = ((char*)((ng56)));
    t40 = (t1 + 15144);
    xsi_vlogfile_write(0, 0, 0, ng158, 3, t40, (char)118, t31, 64, (char)118, t38, 56);
    t41 = (t1 + 15144);
    xsi_vlogfile_write(1, 0, 0, ng159, 1, t41);
    xsi_set_current_line(906, ng52);
    xsi_vlog_stop(1);
    goto LAB55;

LAB59:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB60;

LAB61:    xsi_set_current_line(919, ng52);

LAB64:    xsi_set_current_line(920, ng52);
    t25 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t32 = ((char*)((ng56)));
    t33 = (t1 + 15144);
    xsi_vlogfile_write(0, 0, 0, ng160, 3, t33, (char)118, t31, 64, (char)118, t32, 56);
    t34 = (t2 + 96U);
    t35 = *((char **)t34);
    t36 = (t35 + 0U);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t40 = (t1 + 15144);
    xsi_vlogfile_write(0, 0, 0, ng161, 2, t40, (char)118, t38, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t69 = (t43 + 56U);
    t70 = *((char **)t69);
    t71 = (t1 + 15144);
    xsi_vlogfile_write(0, 0, 0, ng162, 2, t71, (char)118, t70, 4);
    t72 = (t2 + 96U);
    t73 = *((char **)t72);
    t74 = (t73 + 320U);
    t75 = (t74 + 56U);
    t76 = *((char **)t75);
    t77 = (t1 + 15144);
    xsi_vlogfile_write(0, 0, 0, ng132, 2, t77, (char)118, t76, 1);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 480U);
    t81 = (t80 + 56U);
    t82 = *((char **)t81);
    t83 = (t1 + 15144);
    xsi_vlogfile_write(1, 0, 0, ng163, 2, t83, (char)118, t82, 1);
    goto LAB63;

LAB65:    xsi_set_current_line(931, ng52);
    t10 = ((char*)((ng104)));
    t11 = (t1 + 28560);
    xsi_vlogvar_wait_assign_value(t11, t10, 0, 0, 1, 0LL);
    goto LAB67;

}

static int sp_SEND_READ_BURST(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t51[8];
    char t81[8];
    char t82[8];
    char t83[8];
    char t84[8];
    char t85[8];
    char t86[8];
    char t87[8];
    char t96[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    int t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t97;
    char *t98;
    unsigned int t99;
    char *t100;
    unsigned int t101;
    int t102;
    int t103;
    char *t104;
    unsigned int t105;
    int t106;
    int t107;
    unsigned int t108;
    int t109;
    unsigned int t110;
    unsigned int t111;
    int t112;
    int t113;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 15576);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(983, ng52);

LAB5:    xsi_set_current_line(987, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(993, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB16:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t41 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t41 == -1)
        goto LAB17;

LAB18:    if (t41 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 10824);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t39, t40, t1, t43, t2);
    xsi_set_current_line(1005, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t1 + 7800);
    t25 = xsi_create_subprogram_invocation(t11, 0, t1, t24, 0, t2);
    t32 = (t1 + 34960);
    xsi_vlogvar_assign_value(t32, t8, 0, 0, 1);

LAB20:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t36 = *((char **)t35);
    t37 = (t36 + 272U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    t40 = *((char **)t39);
    t41 = ((int  (*)(char *, char *))t40)(t1, t34);
    if (t41 != 0)
        goto LAB22;

LAB21:    t34 = (t2 + 64U);
    t42 = *((char **)t34);
    t34 = (t1 + 34800);
    t43 = (t34 + 56U);
    t44 = *((char **)t43);
    memcpy(t9, t44, 8);
    t45 = (t1 + 7800);
    t46 = (t2 + 56U);
    t47 = *((char **)t46);
    xsi_delete_subprogram_invocation(t45, t42, t1, t47, t2);
    t48 = (t2 + 96U);
    t49 = *((char **)t48);
    t50 = (t49 + 1600U);
    xsi_vlogvar_assign_value(t50, t9, 0, 0, 2);
    xsi_set_current_line(1008, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2400U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1009, ng52);
    xsi_set_current_line(1009, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2080U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB23:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 320U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    memset(t9, 0, 8);
    t33 = (t8 + 4);
    if (*((unsigned int *)t33) != 0)
        goto LAB25;

LAB24:    t34 = (t32 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB25;

LAB28:    if (*((unsigned int *)t8) > *((unsigned int *)t32))
        goto LAB27;

LAB26:    *((unsigned int *)t9) = 1;

LAB27:    t36 = (t9 + 4);
    t12 = *((unsigned int *)t36);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB29;

LAB30:    xsi_set_current_line(1047, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB83);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 12984);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB85:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t41 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t41 == -1)
        goto LAB86;

LAB87:    if (t41 != 0)
        goto LAB88;

LAB83:    t32 = (t1 + 12984);
    xsi_vlog_subprogram_popinvocation(t32);

LAB84:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 12984);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t39, t40, t1, t43, t2);
    xsi_set_current_line(1052, ng52);
    t4 = (t1 + 46272);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(987, ng52);

LAB13:    xsi_set_current_line(988, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 15576);
    xsi_vlogfile_write(0, 0, 0, ng164, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 15576);
    xsi_vlogfile_write(1, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB22:    t33 = (t2 + 48U);
    *((char **)t33) = &&LAB20;
    goto LAB1;

LAB25:    t35 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t35) = 1;
    goto LAB27;

LAB29:    xsi_set_current_line(1009, ng52);

LAB31:    xsi_set_current_line(1010, ng52);
    t37 = (t2 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 2080U);
    t40 = (t39 + 56U);
    t42 = *((char **)t40);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 320U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memset(t51, 0, 8);
    t48 = (t42 + 4);
    t49 = (t47 + 4);
    t17 = *((unsigned int *)t42);
    t18 = *((unsigned int *)t47);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t48);
    t21 = *((unsigned int *)t49);
    t22 = (t20 ^ t21);
    t23 = (t19 | t22);
    t26 = *((unsigned int *)t48);
    t27 = *((unsigned int *)t49);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t23 & t29);
    if (t30 != 0)
        goto LAB35;

LAB32:    if (t28 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t51) = 1;

LAB35:    t52 = (t51 + 4);
    t53 = *((unsigned int *)t52);
    t54 = (~(t53));
    t55 = *((unsigned int *)t51);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB36;

LAB37:    xsi_set_current_line(1013, ng52);

LAB40:    xsi_set_current_line(1014, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 1760U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);

LAB38:    xsi_set_current_line(1018, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 160U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 320U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 480U);
    t42 = (t40 + 56U);
    t43 = *((char **)t42);
    t44 = (t2 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 640U);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    t52 = (t1 + 7368);
    t58 = xsi_create_subprogram_invocation(t50, 0, t1, t52, 0, t2);
    t59 = (t1 + 32400);
    xsi_vlogvar_assign_value(t59, t8, 0, 0, 32);
    t60 = (t1 + 32560);
    xsi_vlogvar_assign_value(t60, t32, 0, 0, 32);
    t61 = (t1 + 32720);
    xsi_vlogvar_assign_value(t61, t37, 0, 0, 8);
    t62 = (t1 + 32880);
    xsi_vlogvar_assign_value(t62, t43, 0, 0, 3);
    t63 = (t1 + 33040);
    xsi_vlogvar_assign_value(t63, t48, 0, 0, 2);

LAB41:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t66 = (t65 + 80U);
    t67 = *((char **)t66);
    t68 = (t67 + 272U);
    t69 = *((char **)t68);
    t70 = (t69 + 0U);
    t71 = *((char **)t70);
    t41 = ((int  (*)(char *, char *))t71)(t1, t65);
    if (t41 != 0)
        goto LAB43;

LAB42:    t65 = (t2 + 64U);
    t72 = *((char **)t65);
    t65 = (t1 + 32240);
    t73 = (t65 + 56U);
    t74 = *((char **)t73);
    memcpy(t9, t74, 8);
    t75 = (t1 + 7368);
    t76 = (t2 + 56U);
    t77 = *((char **)t76);
    xsi_delete_subprogram_invocation(t75, t72, t1, t77, t2);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 1920U);
    xsi_vlogvar_assign_value(t80, t9, 0, 0, 4);
    xsi_set_current_line(1020, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2560U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1021, ng52);
    xsi_set_current_line(1021, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2720U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB44:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2720U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 1200);
    t11 = *((char **)t10);
    t10 = ((char*)((ng93)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t11, 32, t10, 32);
    memset(t51, 0, 8);
    xsi_vlog_signed_less(t51, 32, t8, 32, t9, 32);
    t24 = (t51 + 4);
    t12 = *((unsigned int *)t24);
    t13 = (~(t12));
    t14 = *((unsigned int *)t51);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB45;

LAB46:    xsi_set_current_line(1033, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1120U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1120U);
    t25 = (t24 + 72U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 2080U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1880);
    t39 = *((char **)t38);
    memset(t51, 0, 8);
    xsi_vlog_signed_multiply(t51, 32, t37, 32, t39, 32);
    t38 = ((char*)((ng83)));
    xsi_vlog_get_indexed_partselect(t9, 1, t8, ((int*)(t32)), 2, t51, 32, 1, t38, 32, 1, 1);
    t40 = (t2 + 96U);
    t42 = *((char **)t40);
    t43 = (t42 + 1440U);
    xsi_vlogvar_assign_value(t43, t9, 0, 0, 1);
    xsi_set_current_line(1035, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1280U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 1600U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 1760U);
    t42 = (t40 + 56U);
    t43 = *((char **)t42);
    t44 = (t2 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 1440U);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    t52 = (t2 + 56U);
    t58 = *((char **)t52);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t58, &&LAB61);
    t59 = (t2 + 56U);
    t60 = *((char **)t59);
    t61 = (t1 + 13848);
    t62 = xsi_create_subprogram_invocation(t60, 0, t1, t61, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t61, t62);
    t63 = (t62 + 96U);
    t64 = *((char **)t63);
    t65 = (t64 + 0U);
    xsi_vlogvar_assign_value(t65, t8, 0, 0, 1);
    t66 = (t62 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 160U);
    xsi_vlogvar_assign_value(t68, t32, 0, 0, 32);
    t69 = (t62 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 320U);
    xsi_vlogvar_assign_value(t71, t37, 0, 0, 2);
    t72 = (t62 + 96U);
    t73 = *((char **)t72);
    t74 = (t73 + 480U);
    xsi_vlogvar_assign_value(t74, t43, 0, 0, 1);
    t75 = (t62 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 640U);
    xsi_vlogvar_assign_value(t77, t48, 0, 0, 1);

LAB63:    t78 = (t2 + 64U);
    t79 = *((char **)t78);
    t80 = (t79 + 80U);
    t88 = *((char **)t80);
    t89 = (t88 + 272U);
    t90 = *((char **)t89);
    t91 = (t90 + 0U);
    t92 = *((char **)t91);
    t41 = ((int  (*)(char *, char *))t92)(t1, t79);
    if (t41 == -1)
        goto LAB64;

LAB65:    if (t41 != 0)
        goto LAB66;

LAB61:    t79 = (t1 + 13848);
    xsi_vlog_subprogram_popinvocation(t79);

LAB62:    t93 = (t2 + 64U);
    t94 = *((char **)t93);
    t93 = (t1 + 13848);
    t95 = (t2 + 56U);
    t97 = *((char **)t95);
    xsi_delete_subprogram_invocation(t93, t94, t1, t97, t2);
    xsi_set_current_line(1037, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1760U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t11 = (t8 + 4);
    t24 = (t10 + 4);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t10);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t11);
    t16 = *((unsigned int *)t24);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t11);
    t20 = *((unsigned int *)t24);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB68;

LAB67:    if (t21 != 0)
        goto LAB69;

LAB70:    t32 = (t9 + 4);
    t26 = *((unsigned int *)t32);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB71;

LAB72:
LAB73:    xsi_set_current_line(1009, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2080U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB23;

LAB34:    t50 = (t51 + 4);
    *((unsigned int *)t51) = 1;
    *((unsigned int *)t50) = 1;
    goto LAB35;

LAB36:    xsi_set_current_line(1010, ng52);

LAB39:    xsi_set_current_line(1011, ng52);
    t58 = ((char*)((ng83)));
    t59 = (t2 + 96U);
    t60 = *((char **)t59);
    t61 = (t60 + 1760U);
    xsi_vlogvar_assign_value(t61, t58, 0, 0, 1);
    goto LAB38;

LAB43:    t64 = (t2 + 48U);
    *((char **)t64) = &&LAB41;
    goto LAB1;

LAB45:    xsi_set_current_line(1021, ng52);

LAB47:    xsi_set_current_line(1022, ng52);
    t25 = (t2 + 96U);
    t32 = *((char **)t25);
    t33 = (t32 + 1920U);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t2 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1920U);
    t39 = (t38 + 72U);
    t40 = *((char **)t39);
    t42 = (t2 + 96U);
    t43 = *((char **)t42);
    t44 = (t43 + 2720U);
    t45 = (t44 + 56U);
    t46 = *((char **)t45);
    xsi_vlog_generic_get_index_select_value(t81, 32, t35, t40, 2, t46, 32, 1);
    t47 = ((char*)((ng83)));
    memset(t82, 0, 8);
    t48 = (t81 + 4);
    t49 = (t47 + 4);
    t17 = *((unsigned int *)t81);
    t18 = *((unsigned int *)t47);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t48);
    t21 = *((unsigned int *)t49);
    t22 = (t20 ^ t21);
    t23 = (t19 | t22);
    t26 = *((unsigned int *)t48);
    t27 = *((unsigned int *)t49);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t23 & t29);
    if (t30 != 0)
        goto LAB51;

LAB48:    if (t28 != 0)
        goto LAB50;

LAB49:    *((unsigned int *)t82) = 1;

LAB51:    t52 = (t82 + 4);
    t53 = *((unsigned int *)t52);
    t54 = (~(t53));
    t55 = *((unsigned int *)t82);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB52;

LAB53:    xsi_set_current_line(1027, ng52);

LAB58:    xsi_set_current_line(1028, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 1280U);
    t8 = (t2 + 96U);
    t10 = *((char **)t8);
    t11 = (t10 + 1280U);
    t24 = (t11 + 72U);
    t25 = *((char **)t24);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 2560U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t37 = ((char*)((ng93)));
    memset(t82, 0, 8);
    xsi_vlog_signed_multiply(t82, 32, t36, 32, t37, 32);
    t38 = ((char*)((ng93)));
    xsi_vlog_convert_indexed_partindices(t9, t51, t81, ((int*)(t25)), 2, t82, 32, 1, t38, 32, 1, 1);
    t39 = (t9 + 4);
    t12 = *((unsigned int *)t39);
    t41 = (!(t12));
    t40 = (t51 + 4);
    t13 = *((unsigned int *)t40);
    t102 = (!(t13));
    t103 = (t41 && t102);
    t42 = (t81 + 4);
    t14 = *((unsigned int *)t42);
    t106 = (!(t14));
    t107 = (t103 && t106);
    if (t107 == 1)
        goto LAB59;

LAB60:
LAB54:    xsi_set_current_line(1030, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2560U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2560U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(1021, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2720U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2720U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB44;

LAB50:    t50 = (t82 + 4);
    *((unsigned int *)t82) = 1;
    *((unsigned int *)t50) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(1022, ng52);

LAB55:    xsi_set_current_line(1023, ng52);
    t58 = (t2 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 960U);
    t61 = (t60 + 56U);
    t62 = *((char **)t61);
    t63 = (t2 + 96U);
    t64 = *((char **)t63);
    t65 = (t64 + 960U);
    t66 = (t65 + 72U);
    t67 = *((char **)t66);
    t68 = (t2 + 96U);
    t69 = *((char **)t68);
    t70 = (t69 + 2400U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = ((char*)((ng93)));
    memset(t84, 0, 8);
    xsi_vlog_signed_multiply(t84, 32, t72, 32, t73, 32);
    t74 = ((char*)((ng93)));
    xsi_vlog_get_indexed_partselect(t83, 8, t62, ((int*)(t67)), 2, t84, 32, 1, t74, 32, 1, 1);
    t75 = (t2 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 1280U);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 1280U);
    t88 = (t80 + 72U);
    t89 = *((char **)t88);
    t90 = (t2 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 2560U);
    t93 = (t92 + 56U);
    t94 = *((char **)t93);
    t95 = ((char*)((ng93)));
    memset(t96, 0, 8);
    xsi_vlog_signed_multiply(t96, 32, t94, 32, t95, 32);
    t97 = ((char*)((ng93)));
    xsi_vlog_convert_indexed_partindices(t85, t86, t87, ((int*)(t89)), 2, t96, 32, 1, t97, 32, 1, 1);
    t98 = (t85 + 4);
    t99 = *((unsigned int *)t98);
    t41 = (!(t99));
    t100 = (t86 + 4);
    t101 = *((unsigned int *)t100);
    t102 = (!(t101));
    t103 = (t41 && t102);
    t104 = (t87 + 4);
    t105 = *((unsigned int *)t104);
    t106 = (!(t105));
    t107 = (t103 && t106);
    if (t107 == 1)
        goto LAB56;

LAB57:    xsi_set_current_line(1025, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2400U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2400U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB54;

LAB56:    t108 = *((unsigned int *)t87);
    t109 = (t108 + 0);
    t110 = *((unsigned int *)t85);
    t111 = *((unsigned int *)t86);
    t112 = (t110 - t111);
    t113 = (t112 + 1);
    xsi_vlogvar_assign_value(t77, t83, t109, *((unsigned int *)t86), t113);
    goto LAB57;

LAB59:    t15 = *((unsigned int *)t81);
    t109 = (t15 + 0);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t51);
    t112 = (t16 - t17);
    t113 = (t112 + 1);
    xsi_vlogvar_assign_value(t7, t4, t109, *((unsigned int *)t51), t113);
    goto LAB60;

LAB64:    t0 = -1;
    goto LAB1;

LAB66:    t78 = (t2 + 48U);
    *((char **)t78) = &&LAB63;
    goto LAB1;

LAB68:    *((unsigned int *)t9) = 1;
    goto LAB70;

LAB69:    t25 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB70;

LAB71:    xsi_set_current_line(1037, ng52);

LAB74:    xsi_set_current_line(1038, ng52);
    t33 = (t1 + 26960);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = ((char*)((ng104)));
    memset(t51, 0, 8);
    xsi_vlog_signed_equal(t51, 32, t35, 32, t36, 32);
    t37 = (t51 + 4);
    t53 = *((unsigned int *)t37);
    t54 = (~(t53));
    t55 = *((unsigned int *)t51);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB75;

LAB76:
LAB77:    xsi_set_current_line(1041, ng52);
    t4 = (t1 + 26960);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t12 = *((unsigned int *)t7);
    t13 = (~(t12));
    t14 = *((unsigned int *)t6);
    t41 = (t14 & t13);
    t8 = (t1 + 55664);
    *((int *)t8) = t41;

LAB79:    t10 = (t1 + 55664);
    if (*((int *)t10) > 0)
        goto LAB80;

LAB81:    goto LAB73;

LAB75:    xsi_set_current_line(1038, ng52);

LAB78:    xsi_set_current_line(1039, ng52);
    t38 = ((char*)((ng83)));
    t39 = (t1 + 30320);
    xsi_vlogvar_wait_assign_value(t39, t38, 0, 0, 1, 0LL);
    goto LAB77;

LAB80:    xsi_set_current_line(1041, ng52);
    t11 = (t2 + 88U);
    t24 = *((char **)t11);
    t25 = (t24 + 0U);
    xsi_wp_set_status(t25, 1);
    *((char **)t3) = &&LAB82;
    goto LAB1;

LAB82:    t4 = (t1 + 55664);
    t41 = *((int *)t4);
    *((int *)t4) = (t41 - 1);
    goto LAB79;

LAB86:    t0 = -1;
    goto LAB1;

LAB88:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB85;
    goto LAB1;

}

static int sp_SEND_READ_BURST_RESP_CTRL(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t48[8];
    char t81[8];
    char t82[8];
    char t83[8];
    char t84[8];
    char t85[8];
    char t86[8];
    char t87[8];
    char t96[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    int t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t97;
    char *t98;
    unsigned int t99;
    char *t100;
    unsigned int t101;
    int t102;
    int t103;
    char *t104;
    unsigned int t105;
    int t106;
    int t107;
    unsigned int t108;
    int t109;
    unsigned int t110;
    unsigned int t111;
    int t112;
    int t113;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 16008);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1099, ng52);

LAB5:    xsi_set_current_line(1103, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(1109, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB16:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t41 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t41 == -1)
        goto LAB17;

LAB18:    if (t41 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 10824);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t39, t40, t1, t43, t2);
    xsi_set_current_line(1121, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2400U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1122, ng52);
    xsi_set_current_line(1122, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2080U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB20:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 320U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    memset(t9, 0, 8);
    t33 = (t8 + 4);
    if (*((unsigned int *)t33) != 0)
        goto LAB22;

LAB21:    t34 = (t32 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB22;

LAB25:    if (*((unsigned int *)t8) > *((unsigned int *)t32))
        goto LAB24;

LAB23:    *((unsigned int *)t9) = 1;

LAB24:    t36 = (t9 + 4);
    t12 = *((unsigned int *)t36);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB26;

LAB27:    xsi_set_current_line(1163, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB80);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 12984);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB82:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t41 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t41 == -1)
        goto LAB83;

LAB84:    if (t41 != 0)
        goto LAB85;

LAB80:    t32 = (t1 + 12984);
    xsi_vlog_subprogram_popinvocation(t32);

LAB81:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 12984);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t39, t40, t1, t43, t2);
    xsi_set_current_line(1168, ng52);
    t4 = (t1 + 46272);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(1103, ng52);

LAB13:    xsi_set_current_line(1104, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 16008);
    xsi_vlogfile_write(0, 0, 0, ng165, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 16008);
    xsi_vlogfile_write(1, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB22:    t35 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t35) = 1;
    goto LAB24;

LAB26:    xsi_set_current_line(1122, ng52);

LAB28:    xsi_set_current_line(1123, ng52);
    t37 = (t2 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 2080U);
    t40 = (t39 + 56U);
    t42 = *((char **)t40);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 320U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memset(t48, 0, 8);
    t49 = (t42 + 4);
    t50 = (t47 + 4);
    t17 = *((unsigned int *)t42);
    t18 = *((unsigned int *)t47);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t49);
    t21 = *((unsigned int *)t50);
    t22 = (t20 ^ t21);
    t23 = (t19 | t22);
    t26 = *((unsigned int *)t49);
    t27 = *((unsigned int *)t50);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t23 & t29);
    if (t30 != 0)
        goto LAB32;

LAB29:    if (t28 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t48) = 1;

LAB32:    t52 = (t48 + 4);
    t53 = *((unsigned int *)t52);
    t54 = (~(t53));
    t55 = *((unsigned int *)t48);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB33;

LAB34:    xsi_set_current_line(1126, ng52);

LAB37:    xsi_set_current_line(1127, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 1600U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);

LAB35:    xsi_set_current_line(1131, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 160U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 320U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 480U);
    t42 = (t40 + 56U);
    t43 = *((char **)t42);
    t44 = (t2 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 640U);
    t47 = (t46 + 56U);
    t49 = *((char **)t47);
    t50 = (t2 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 7368);
    t58 = xsi_create_subprogram_invocation(t51, 0, t1, t52, 0, t2);
    t59 = (t1 + 32400);
    xsi_vlogvar_assign_value(t59, t8, 0, 0, 32);
    t60 = (t1 + 32560);
    xsi_vlogvar_assign_value(t60, t32, 0, 0, 32);
    t61 = (t1 + 32720);
    xsi_vlogvar_assign_value(t61, t37, 0, 0, 8);
    t62 = (t1 + 32880);
    xsi_vlogvar_assign_value(t62, t43, 0, 0, 3);
    t63 = (t1 + 33040);
    xsi_vlogvar_assign_value(t63, t49, 0, 0, 2);

LAB38:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t66 = (t65 + 80U);
    t67 = *((char **)t66);
    t68 = (t67 + 272U);
    t69 = *((char **)t68);
    t70 = (t69 + 0U);
    t71 = *((char **)t70);
    t41 = ((int  (*)(char *, char *))t71)(t1, t65);
    if (t41 != 0)
        goto LAB40;

LAB39:    t65 = (t2 + 64U);
    t72 = *((char **)t65);
    t65 = (t1 + 32240);
    t73 = (t65 + 56U);
    t74 = *((char **)t73);
    memcpy(t9, t74, 8);
    t75 = (t1 + 7368);
    t76 = (t2 + 56U);
    t77 = *((char **)t76);
    xsi_delete_subprogram_invocation(t75, t72, t1, t77, t2);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 1760U);
    xsi_vlogvar_assign_value(t80, t9, 0, 0, 4);
    xsi_set_current_line(1133, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2560U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1134, ng52);
    xsi_set_current_line(1134, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2720U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB41:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2720U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 1200);
    t11 = *((char **)t10);
    t10 = ((char*)((ng93)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t11, 32, t10, 32);
    memset(t48, 0, 8);
    xsi_vlog_signed_less(t48, 32, t8, 32, t9, 32);
    t24 = (t48 + 4);
    t12 = *((unsigned int *)t24);
    t13 = (~(t12));
    t14 = *((unsigned int *)t48);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB42;

LAB43:    xsi_set_current_line(1148, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 960U);
    t25 = (t24 + 72U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 2080U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = ((char*)((ng106)));
    memset(t48, 0, 8);
    xsi_vlog_signed_multiply(t48, 32, t37, 32, t38, 32);
    t39 = ((char*)((ng106)));
    xsi_vlog_get_indexed_partselect(t9, 2, t8, ((int*)(t32)), 2, t48, 32, 1, t39, 32, 1, 1);
    t40 = (t2 + 96U);
    t42 = *((char **)t40);
    t43 = (t42 + 1920U);
    xsi_vlogvar_assign_value(t43, t9, 0, 0, 2);
    xsi_set_current_line(1150, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1120U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1120U);
    t25 = (t24 + 72U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 2080U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1880);
    t39 = *((char **)t38);
    memset(t48, 0, 8);
    xsi_vlog_signed_multiply(t48, 32, t37, 32, t39, 32);
    t38 = ((char*)((ng83)));
    xsi_vlog_get_indexed_partselect(t9, 1, t8, ((int*)(t32)), 2, t48, 32, 1, t38, 32, 1, 1);
    t40 = (t2 + 96U);
    t42 = *((char **)t40);
    t43 = (t42 + 1440U);
    xsi_vlogvar_assign_value(t43, t9, 0, 0, 1);
    xsi_set_current_line(1151, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1280U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 1920U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 1600U);
    t42 = (t40 + 56U);
    t43 = *((char **)t42);
    t44 = (t2 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 1440U);
    t47 = (t46 + 56U);
    t49 = *((char **)t47);
    t50 = (t2 + 56U);
    t51 = *((char **)t50);
    t52 = (t2 + 56U);
    t58 = *((char **)t52);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t58, &&LAB58);
    t59 = (t2 + 56U);
    t60 = *((char **)t59);
    t61 = (t1 + 13848);
    t62 = xsi_create_subprogram_invocation(t60, 0, t1, t61, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t61, t62);
    t63 = (t62 + 96U);
    t64 = *((char **)t63);
    t65 = (t64 + 0U);
    xsi_vlogvar_assign_value(t65, t8, 0, 0, 1);
    t66 = (t62 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 160U);
    xsi_vlogvar_assign_value(t68, t32, 0, 0, 32);
    t69 = (t62 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 320U);
    xsi_vlogvar_assign_value(t71, t37, 0, 0, 2);
    t72 = (t62 + 96U);
    t73 = *((char **)t72);
    t74 = (t73 + 480U);
    xsi_vlogvar_assign_value(t74, t43, 0, 0, 1);
    t75 = (t62 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 640U);
    xsi_vlogvar_assign_value(t77, t49, 0, 0, 1);

LAB60:    t78 = (t2 + 64U);
    t79 = *((char **)t78);
    t80 = (t79 + 80U);
    t88 = *((char **)t80);
    t89 = (t88 + 272U);
    t90 = *((char **)t89);
    t91 = (t90 + 0U);
    t92 = *((char **)t91);
    t41 = ((int  (*)(char *, char *))t92)(t1, t79);
    if (t41 == -1)
        goto LAB61;

LAB62:    if (t41 != 0)
        goto LAB63;

LAB58:    t79 = (t1 + 13848);
    xsi_vlog_subprogram_popinvocation(t79);

LAB59:    t93 = (t2 + 64U);
    t94 = *((char **)t93);
    t93 = (t1 + 13848);
    t95 = (t2 + 56U);
    t97 = *((char **)t95);
    xsi_delete_subprogram_invocation(t93, t94, t1, t97, t2);
    xsi_set_current_line(1153, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1600U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t11 = (t8 + 4);
    t24 = (t10 + 4);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t10);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t11);
    t16 = *((unsigned int *)t24);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t11);
    t20 = *((unsigned int *)t24);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB65;

LAB64:    if (t21 != 0)
        goto LAB66;

LAB67:    t32 = (t9 + 4);
    t26 = *((unsigned int *)t32);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB68;

LAB69:
LAB70:    xsi_set_current_line(1122, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2080U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB20;

LAB31:    t51 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t51) = 1;
    goto LAB32;

LAB33:    xsi_set_current_line(1123, ng52);

LAB36:    xsi_set_current_line(1124, ng52);
    t58 = ((char*)((ng83)));
    t59 = (t2 + 96U);
    t60 = *((char **)t59);
    t61 = (t60 + 1600U);
    xsi_vlogvar_assign_value(t61, t58, 0, 0, 1);
    goto LAB35;

LAB40:    t64 = (t2 + 48U);
    *((char **)t64) = &&LAB38;
    goto LAB1;

LAB42:    xsi_set_current_line(1134, ng52);

LAB44:    xsi_set_current_line(1135, ng52);
    t25 = (t2 + 96U);
    t32 = *((char **)t25);
    t33 = (t32 + 1760U);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t2 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1760U);
    t39 = (t38 + 72U);
    t40 = *((char **)t39);
    t42 = (t2 + 96U);
    t43 = *((char **)t42);
    t44 = (t43 + 2720U);
    t45 = (t44 + 56U);
    t46 = *((char **)t45);
    xsi_vlog_generic_get_index_select_value(t81, 32, t35, t40, 2, t46, 32, 1);
    t47 = ((char*)((ng83)));
    memset(t82, 0, 8);
    t49 = (t81 + 4);
    t50 = (t47 + 4);
    t17 = *((unsigned int *)t81);
    t18 = *((unsigned int *)t47);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t49);
    t21 = *((unsigned int *)t50);
    t22 = (t20 ^ t21);
    t23 = (t19 | t22);
    t26 = *((unsigned int *)t49);
    t27 = *((unsigned int *)t50);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t23 & t29);
    if (t30 != 0)
        goto LAB48;

LAB45:    if (t28 != 0)
        goto LAB47;

LAB46:    *((unsigned int *)t82) = 1;

LAB48:    t52 = (t82 + 4);
    t53 = *((unsigned int *)t52);
    t54 = (~(t53));
    t55 = *((unsigned int *)t82);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB49;

LAB50:    xsi_set_current_line(1140, ng52);

LAB55:    xsi_set_current_line(1141, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 1280U);
    t8 = (t2 + 96U);
    t10 = *((char **)t8);
    t11 = (t10 + 1280U);
    t24 = (t11 + 72U);
    t25 = *((char **)t24);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 2560U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t37 = ((char*)((ng93)));
    memset(t82, 0, 8);
    xsi_vlog_signed_multiply(t82, 32, t36, 32, t37, 32);
    t38 = ((char*)((ng93)));
    xsi_vlog_convert_indexed_partindices(t9, t48, t81, ((int*)(t25)), 2, t82, 32, 1, t38, 32, 1, 1);
    t39 = (t9 + 4);
    t12 = *((unsigned int *)t39);
    t41 = (!(t12));
    t40 = (t48 + 4);
    t13 = *((unsigned int *)t40);
    t102 = (!(t13));
    t103 = (t41 && t102);
    t42 = (t81 + 4);
    t14 = *((unsigned int *)t42);
    t106 = (!(t14));
    t107 = (t103 && t106);
    if (t107 == 1)
        goto LAB56;

LAB57:
LAB51:    xsi_set_current_line(1143, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2560U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2560U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(1134, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2720U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2720U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB41;

LAB47:    t51 = (t82 + 4);
    *((unsigned int *)t82) = 1;
    *((unsigned int *)t51) = 1;
    goto LAB48;

LAB49:    xsi_set_current_line(1135, ng52);

LAB52:    xsi_set_current_line(1136, ng52);
    t58 = (t2 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 800U);
    t61 = (t60 + 56U);
    t62 = *((char **)t61);
    t63 = (t2 + 96U);
    t64 = *((char **)t63);
    t65 = (t64 + 800U);
    t66 = (t65 + 72U);
    t67 = *((char **)t66);
    t68 = (t2 + 96U);
    t69 = *((char **)t68);
    t70 = (t69 + 2400U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = ((char*)((ng93)));
    memset(t84, 0, 8);
    xsi_vlog_signed_multiply(t84, 32, t72, 32, t73, 32);
    t74 = ((char*)((ng93)));
    xsi_vlog_get_indexed_partselect(t83, 8, t62, ((int*)(t67)), 2, t84, 32, 1, t74, 32, 1, 1);
    t75 = (t2 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 1280U);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 1280U);
    t88 = (t80 + 72U);
    t89 = *((char **)t88);
    t90 = (t2 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 2560U);
    t93 = (t92 + 56U);
    t94 = *((char **)t93);
    t95 = ((char*)((ng93)));
    memset(t96, 0, 8);
    xsi_vlog_signed_multiply(t96, 32, t94, 32, t95, 32);
    t97 = ((char*)((ng93)));
    xsi_vlog_convert_indexed_partindices(t85, t86, t87, ((int*)(t89)), 2, t96, 32, 1, t97, 32, 1, 1);
    t98 = (t85 + 4);
    t99 = *((unsigned int *)t98);
    t41 = (!(t99));
    t100 = (t86 + 4);
    t101 = *((unsigned int *)t100);
    t102 = (!(t101));
    t103 = (t41 && t102);
    t104 = (t87 + 4);
    t105 = *((unsigned int *)t104);
    t106 = (!(t105));
    t107 = (t103 && t106);
    if (t107 == 1)
        goto LAB53;

LAB54:    xsi_set_current_line(1138, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2400U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2400U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB51;

LAB53:    t108 = *((unsigned int *)t87);
    t109 = (t108 + 0);
    t110 = *((unsigned int *)t85);
    t111 = *((unsigned int *)t86);
    t112 = (t110 - t111);
    t113 = (t112 + 1);
    xsi_vlogvar_assign_value(t77, t83, t109, *((unsigned int *)t86), t113);
    goto LAB54;

LAB56:    t15 = *((unsigned int *)t81);
    t109 = (t15 + 0);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t48);
    t112 = (t16 - t17);
    t113 = (t112 + 1);
    xsi_vlogvar_assign_value(t7, t4, t109, *((unsigned int *)t48), t113);
    goto LAB57;

LAB61:    t0 = -1;
    goto LAB1;

LAB63:    t78 = (t2 + 48U);
    *((char **)t78) = &&LAB60;
    goto LAB1;

LAB65:    *((unsigned int *)t9) = 1;
    goto LAB67;

LAB66:    t25 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB67;

LAB68:    xsi_set_current_line(1153, ng52);

LAB71:    xsi_set_current_line(1154, ng52);
    t33 = (t1 + 26960);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = ((char*)((ng104)));
    memset(t48, 0, 8);
    xsi_vlog_signed_equal(t48, 32, t35, 32, t36, 32);
    t37 = (t48 + 4);
    t53 = *((unsigned int *)t37);
    t54 = (~(t53));
    t55 = *((unsigned int *)t48);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB72;

LAB73:
LAB74:    xsi_set_current_line(1157, ng52);
    t4 = (t1 + 26960);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t12 = *((unsigned int *)t7);
    t13 = (~(t12));
    t14 = *((unsigned int *)t6);
    t41 = (t14 & t13);
    t8 = (t1 + 55668);
    *((int *)t8) = t41;

LAB76:    t10 = (t1 + 55668);
    if (*((int *)t10) > 0)
        goto LAB77;

LAB78:    goto LAB70;

LAB72:    xsi_set_current_line(1154, ng52);

LAB75:    xsi_set_current_line(1155, ng52);
    t38 = ((char*)((ng83)));
    t39 = (t1 + 30320);
    xsi_vlogvar_wait_assign_value(t39, t38, 0, 0, 1, 0LL);
    goto LAB74;

LAB77:    xsi_set_current_line(1157, ng52);
    t11 = (t2 + 88U);
    t24 = *((char **)t11);
    t25 = (t24 + 0U);
    xsi_wp_set_status(t25, 1);
    *((char **)t3) = &&LAB79;
    goto LAB1;

LAB79:    t4 = (t1 + 55668);
    t41 = *((int *)t4);
    *((int *)t4) = (t41 - 1);
    goto LAB76;

LAB83:    t0 = -1;
    goto LAB1;

LAB85:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB82;
    goto LAB1;

}

static int sp_RECEIVE_WRITE_BURST(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t86[8];
    char t87[8];
    char t88[8];
    char t102[8];
    char t103[8];
    char t104[8];
    char t105[8];
    char t106[8];
    char t107[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    int t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    int t89;
    int t90;
    int t91;
    int t92;
    int t93;
    int t94;
    int t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 16440);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1211, ng52);

LAB5:    xsi_set_current_line(1215, ng52);
    t5 = (t1 + 27920);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(1220, ng52);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 10824);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB16:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t39 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t39 == -1)
        goto LAB17;

LAB18:    if (t39 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 10824);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 10824);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);
    xsi_set_current_line(1229, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 800U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1230, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 1760U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1231, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 1440U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(1232, ng52);

LAB20:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1440U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t11 = (t8 + 4);
    t24 = (t10 + 4);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t10);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t11);
    t16 = *((unsigned int *)t24);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t11);
    t20 = *((unsigned int *)t24);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB22;

LAB21:    if (t21 != 0)
        goto LAB23;

LAB24:    t32 = (t9 + 4);
    t26 = *((unsigned int *)t32);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB25;

LAB26:    xsi_set_current_line(1268, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1760U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_unsigned_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 160U);
    t32 = (t25 + 56U);
    t33 = *((char **)t32);
    memset(t86, 0, 8);
    t34 = (t9 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB76;

LAB75:    t35 = (t33 + 4);
    if (*((unsigned int *)t35) != 0)
        goto LAB76;

LAB79:    if (*((unsigned int *)t9) < *((unsigned int *)t33))
        goto LAB77;

LAB78:    t37 = (t86 + 4);
    t12 = *((unsigned int *)t37);
    t13 = (~(t12));
    t14 = *((unsigned int *)t86);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB80;

LAB81:
LAB82:    xsi_set_current_line(1281, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t1 + 28560);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(1282, ng52);
    t4 = (t1 + 46440);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(1215, ng52);

LAB13:    xsi_set_current_line(1216, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 16440);
    xsi_vlogfile_write(1, 0, 0, ng166, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB22:    *((unsigned int *)t9) = 1;
    goto LAB24;

LAB23:    t25 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB24;

LAB25:    xsi_set_current_line(1232, ng52);

LAB27:    xsi_set_current_line(1233, ng52);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t36, &&LAB28);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    t40 = (t1 + 15144);
    t41 = xsi_create_subprogram_invocation(t38, 0, t1, t40, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t40, t41);

LAB30:    t42 = (t2 + 64U);
    t43 = *((char **)t42);
    t44 = (t43 + 80U);
    t45 = *((char **)t44);
    t46 = (t45 + 272U);
    t47 = *((char **)t46);
    t48 = (t47 + 0U);
    t49 = *((char **)t48);
    t39 = ((int  (*)(char *, char *))t49)(t1, t43);
    if (t39 == -1)
        goto LAB31;

LAB32:    if (t39 != 0)
        goto LAB33;

LAB28:    t43 = (t1 + 15144);
    xsi_vlog_subprogram_popinvocation(t43);

LAB29:    t50 = (t2 + 64U);
    t51 = *((char **)t50);
    t50 = (t51 + 96U);
    t52 = *((char **)t50);
    t53 = (t52 + 0U);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = (t2 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1120U);
    xsi_vlogvar_assign_value(t58, t55, 0, 0, 32);
    t59 = (t51 + 96U);
    t60 = *((char **)t59);
    t61 = (t60 + 160U);
    t62 = (t61 + 56U);
    t63 = *((char **)t62);
    t64 = (t2 + 96U);
    t65 = *((char **)t64);
    t66 = (t65 + 1600U);
    xsi_vlogvar_assign_value(t66, t63, 0, 0, 4);
    t67 = (t51 + 96U);
    t68 = *((char **)t67);
    t69 = (t68 + 320U);
    t70 = (t69 + 56U);
    t71 = *((char **)t70);
    t72 = (t2 + 96U);
    t73 = *((char **)t72);
    t74 = (t73 + 1440U);
    xsi_vlogvar_assign_value(t74, t71, 0, 0, 1);
    t75 = (t51 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 480U);
    t78 = (t77 + 56U);
    t79 = *((char **)t78);
    t80 = (t2 + 96U);
    t81 = *((char **)t80);
    t82 = (t81 + 1280U);
    xsi_vlogvar_assign_value(t82, t79, 0, 0, 1);
    t83 = (t1 + 15144);
    t84 = (t2 + 56U);
    t85 = *((char **)t84);
    xsi_delete_subprogram_invocation(t83, t51, t1, t85, t2);
    xsi_set_current_line(1234, ng52);
    t4 = ((char*)((ng83)));
    t5 = (t1 + 28560);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(1236, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1280U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 960U);
    t25 = (t2 + 96U);
    t32 = *((char **)t25);
    t33 = (t32 + 960U);
    t34 = (t33 + 72U);
    t35 = *((char **)t34);
    t36 = (t2 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1760U);
    t40 = (t38 + 56U);
    t41 = *((char **)t40);
    t42 = (t1 + 2016);
    t43 = *((char **)t42);
    memset(t88, 0, 8);
    xsi_vlog_signed_multiply(t88, 32, t41, 32, t43, 32);
    t42 = ((char*)((ng83)));
    xsi_vlog_convert_indexed_partindices(t9, t86, t87, ((int*)(t35)), 2, t88, 32, 1, t42, 32, 1, 1);
    t44 = (t9 + 4);
    t12 = *((unsigned int *)t44);
    t39 = (!(t12));
    t45 = (t86 + 4);
    t13 = *((unsigned int *)t45);
    t89 = (!(t13));
    t90 = (t39 && t89);
    t46 = (t87 + 4);
    t14 = *((unsigned int *)t46);
    t91 = (!(t14));
    t92 = (t90 && t91);
    if (t92 == 1)
        goto LAB34;

LAB35:    xsi_set_current_line(1239, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1760U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 160U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    memset(t9, 0, 8);
    t33 = (t8 + 4);
    if (*((unsigned int *)t33) != 0)
        goto LAB37;

LAB36:    t34 = (t32 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB37;

LAB40:    if (*((unsigned int *)t8) > *((unsigned int *)t32))
        goto LAB38;

LAB39:    t36 = (t9 + 4);
    t12 = *((unsigned int *)t36);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB41;

LAB42:
LAB43:    xsi_set_current_line(1251, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1600U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1760U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 0U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t40 = *((char **)t38);
    t41 = (t40 + 160U);
    t42 = (t41 + 56U);
    t43 = *((char **)t42);
    t44 = (t2 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 320U);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t2 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 480U);
    t52 = (t51 + 56U);
    t53 = *((char **)t52);
    t54 = (t2 + 56U);
    t55 = *((char **)t54);
    t56 = (t2 + 56U);
    t57 = *((char **)t56);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t57, &&LAB56);
    t58 = (t2 + 56U);
    t59 = *((char **)t58);
    t60 = (t1 + 20328);
    t61 = xsi_create_subprogram_invocation(t59, 0, t1, t60, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t60, t61);
    t62 = (t61 + 96U);
    t63 = *((char **)t62);
    t64 = (t63 + 0U);
    xsi_vlogvar_assign_value(t64, t8, 0, 0, 4);
    t65 = (t61 + 96U);
    t66 = *((char **)t65);
    t67 = (t66 + 160U);
    xsi_vlogvar_assign_value(t67, t32, 0, 0, 32);
    t68 = (t61 + 96U);
    t69 = *((char **)t68);
    t70 = (t69 + 320U);
    xsi_vlogvar_assign_value(t70, t37, 0, 0, 32);
    t71 = (t61 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 480U);
    xsi_vlogvar_assign_value(t73, t43, 0, 0, 8);
    t74 = (t61 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 640U);
    xsi_vlogvar_assign_value(t76, t48, 0, 0, 3);
    t77 = (t61 + 96U);
    t78 = *((char **)t77);
    t79 = (t78 + 800U);
    xsi_vlogvar_assign_value(t79, t53, 0, 0, 2);

LAB58:    t80 = (t2 + 64U);
    t81 = *((char **)t80);
    t82 = (t81 + 80U);
    t83 = *((char **)t82);
    t84 = (t83 + 272U);
    t85 = *((char **)t84);
    t96 = (t85 + 0U);
    t97 = *((char **)t96);
    t39 = ((int  (*)(char *, char *))t97)(t1, t81);
    if (t39 == -1)
        goto LAB59;

LAB60:    if (t39 != 0)
        goto LAB61;

LAB56:    t81 = (t1 + 20328);
    xsi_vlog_subprogram_popinvocation(t81);

LAB57:    t98 = (t2 + 64U);
    t99 = *((char **)t98);
    t98 = (t1 + 20328);
    t100 = (t2 + 56U);
    t101 = *((char **)t100);
    xsi_delete_subprogram_invocation(t98, t99, t1, t101, t2);
    xsi_set_current_line(1254, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2080U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(1255, ng52);
    xsi_set_current_line(1255, ng52);
    t4 = ((char*)((ng104)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 2240U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB62:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2240U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 1200);
    t11 = *((char **)t10);
    t10 = ((char*)((ng93)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t11, 32, t10, 32);
    memset(t86, 0, 8);
    xsi_vlog_signed_less(t86, 32, t8, 32, t9, 32);
    t24 = (t86 + 4);
    t12 = *((unsigned int *)t24);
    t13 = (~(t12));
    t14 = *((unsigned int *)t86);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB63;

LAB64:    xsi_set_current_line(1263, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1760U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 1760U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB20;

LAB31:    t0 = -1;
    goto LAB1;

LAB33:    t42 = (t2 + 48U);
    *((char **)t42) = &&LAB30;
    goto LAB1;

LAB34:    t15 = *((unsigned int *)t87);
    t93 = (t15 + 0);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t86);
    t94 = (t16 - t17);
    t95 = (t94 + 1);
    xsi_vlogvar_assign_value(t24, t8, t93, *((unsigned int *)t86), t95);
    goto LAB35;

LAB37:    t35 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t35) = 1;
    goto LAB39;

LAB38:    *((unsigned int *)t9) = 1;
    goto LAB39;

LAB41:    xsi_set_current_line(1239, ng52);

LAB44:    xsi_set_current_line(1240, ng52);
    t37 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t38 = ((char*)((ng56)));
    t40 = (t1 + 16440);
    xsi_vlogfile_write(0, 0, 0, ng167, 3, t40, (char)118, t31, 64, (char)118, t38, 56);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t2 + 56U);
    t47 = *((char **)t46);
    t48 = (t1 + 6936);
    t49 = xsi_create_subprogram_invocation(t47, 0, t1, t48, 0, t2);
    t50 = (t1 + 32080);
    xsi_vlogvar_assign_value(t50, t45, 0, 0, 8);

LAB45:    t51 = (t2 + 64U);
    t52 = *((char **)t51);
    t53 = (t52 + 80U);
    t54 = *((char **)t53);
    t55 = (t54 + 272U);
    t56 = *((char **)t55);
    t57 = (t56 + 0U);
    t58 = *((char **)t57);
    t39 = ((int  (*)(char *, char *))t58)(t1, t52);
    if (t39 != 0)
        goto LAB47;

LAB46:    t52 = (t2 + 64U);
    t59 = *((char **)t52);
    t52 = (t1 + 31920);
    t60 = (t52 + 56U);
    t61 = *((char **)t60);
    memcpy(t86, t61, 8);
    t62 = (t1 + 6936);
    t63 = (t2 + 56U);
    t64 = *((char **)t63);
    xsi_delete_subprogram_invocation(t62, t59, t1, t64, t2);
    t65 = (t1 + 16440);
    xsi_vlogfile_write(0, 0, 0, ng168, 2, t65, (char)119, t86, 32);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 1760U);
    t69 = (t68 + 56U);
    t70 = *((char **)t69);
    t71 = (t1 + 16440);
    xsi_vlogfile_write(1, 0, 0, ng169, 2, t71, (char)119, t70, 32);
    xsi_set_current_line(1243, ng52);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB51;

LAB48:    if (t21 != 0)
        goto LAB50;

LAB49:    *((unsigned int *)t9) = 1;

LAB51:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(1247, ng52);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t9, 0, 0, 32);
    goto LAB43;

LAB47:    t51 = (t2 + 48U);
    *((char **)t51) = &&LAB45;
    goto LAB1;

LAB50:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(1243, ng52);

LAB55:    xsi_set_current_line(1244, ng52);
    t25 = (t1 + 16440);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t25);
    xsi_set_current_line(1245, ng52);
    xsi_vlog_stop(1);
    goto LAB54;

LAB59:    t0 = -1;
    goto LAB1;

LAB61:    t80 = (t2 + 48U);
    *((char **)t80) = &&LAB58;
    goto LAB1;

LAB63:    xsi_set_current_line(1255, ng52);

LAB65:    xsi_set_current_line(1256, ng52);
    t25 = (t2 + 96U);
    t32 = *((char **)t25);
    t33 = (t32 + 1600U);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t2 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1600U);
    t40 = (t38 + 72U);
    t41 = *((char **)t40);
    t42 = (t2 + 96U);
    t43 = *((char **)t42);
    t44 = (t43 + 2240U);
    t45 = (t44 + 56U);
    t46 = *((char **)t45);
    xsi_vlog_generic_get_index_select_value(t87, 32, t35, t41, 2, t46, 32, 1);
    t47 = ((char*)((ng83)));
    memset(t88, 0, 8);
    if (*((unsigned int *)t87) != *((unsigned int *)t47))
        goto LAB68;

LAB66:    t48 = (t87 + 4);
    t49 = (t47 + 4);
    if (*((unsigned int *)t48) != *((unsigned int *)t49))
        goto LAB68;

LAB67:    *((unsigned int *)t88) = 1;

LAB68:    t50 = (t88 + 4);
    t17 = *((unsigned int *)t50);
    t18 = (~(t17));
    t19 = *((unsigned int *)t88);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB69;

LAB70:
LAB71:    xsi_set_current_line(1261, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2080U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2080U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(1255, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 2240U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 2240U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB62;

LAB69:    xsi_set_current_line(1256, ng52);

LAB72:    xsi_set_current_line(1257, ng52);
    t51 = (t2 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1120U);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = (t2 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1120U);
    t59 = (t58 + 72U);
    t60 = *((char **)t59);
    t61 = (t2 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 2080U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = ((char*)((ng93)));
    memset(t103, 0, 8);
    xsi_vlog_signed_multiply(t103, 32, t65, 32, t66, 32);
    t67 = ((char*)((ng93)));
    xsi_vlog_get_indexed_partselect(t102, 8, t55, ((int*)(t60)), 2, t103, 32, 1, t67, 32, 1, 1);
    t68 = (t2 + 96U);
    t69 = *((char **)t68);
    t70 = (t69 + 640U);
    t71 = (t2 + 96U);
    t72 = *((char **)t71);
    t73 = (t72 + 640U);
    t74 = (t73 + 72U);
    t75 = *((char **)t74);
    t76 = (t2 + 96U);
    t77 = *((char **)t76);
    t78 = (t77 + 800U);
    t79 = (t78 + 56U);
    t80 = *((char **)t79);
    t81 = ((char*)((ng93)));
    memset(t107, 0, 8);
    xsi_vlog_signed_multiply(t107, 32, t80, 32, t81, 32);
    t82 = ((char*)((ng93)));
    xsi_vlog_convert_indexed_partindices(t104, t105, t106, ((int*)(t75)), 2, t107, 32, 1, t82, 32, 1, 1);
    t83 = (t104 + 4);
    t22 = *((unsigned int *)t83);
    t39 = (!(t22));
    t84 = (t105 + 4);
    t23 = *((unsigned int *)t84);
    t89 = (!(t23));
    t90 = (t39 && t89);
    t85 = (t106 + 4);
    t26 = *((unsigned int *)t85);
    t91 = (!(t26));
    t92 = (t90 && t91);
    if (t92 == 1)
        goto LAB73;

LAB74:    xsi_set_current_line(1259, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 800U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB71;

LAB73:    t27 = *((unsigned int *)t106);
    t93 = (t27 + 0);
    t28 = *((unsigned int *)t104);
    t29 = *((unsigned int *)t105);
    t94 = (t28 - t29);
    t95 = (t94 + 1);
    xsi_vlogvar_assign_value(t70, t102, t93, *((unsigned int *)t105), t95);
    goto LAB74;

LAB76:    t36 = (t86 + 4);
    *((unsigned int *)t86) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB78;

LAB77:    *((unsigned int *)t86) = 1;
    goto LAB78;

LAB80:    xsi_set_current_line(1268, ng52);

LAB83:    xsi_set_current_line(1269, ng52);
    t38 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t40 = ((char*)((ng56)));
    t41 = (t1 + 16440);
    xsi_vlogfile_write(0, 0, 0, ng167, 3, t41, (char)118, t31, 64, (char)118, t40, 56);
    t42 = (t2 + 96U);
    t43 = *((char **)t42);
    t44 = (t43 + 160U);
    t45 = (t44 + 56U);
    t46 = *((char **)t45);
    t47 = (t2 + 56U);
    t48 = *((char **)t47);
    t49 = (t1 + 6936);
    t50 = xsi_create_subprogram_invocation(t48, 0, t1, t49, 0, t2);
    t51 = (t1 + 32080);
    xsi_vlogvar_assign_value(t51, t46, 0, 0, 8);

LAB84:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t54 = (t53 + 80U);
    t55 = *((char **)t54);
    t56 = (t55 + 272U);
    t57 = *((char **)t56);
    t58 = (t57 + 0U);
    t59 = *((char **)t58);
    t39 = ((int  (*)(char *, char *))t59)(t1, t53);
    if (t39 != 0)
        goto LAB86;

LAB85:    t53 = (t2 + 64U);
    t60 = *((char **)t53);
    t53 = (t1 + 31920);
    t61 = (t53 + 56U);
    t62 = *((char **)t61);
    memcpy(t87, t62, 8);
    t63 = (t1 + 6936);
    t64 = (t2 + 56U);
    t65 = *((char **)t64);
    xsi_delete_subprogram_invocation(t63, t60, t1, t65, t2);
    t66 = (t1 + 16440);
    xsi_vlogfile_write(0, 0, 0, ng170, 2, t66, (char)119, t87, 32);
    t67 = (t2 + 96U);
    t68 = *((char **)t67);
    t69 = (t68 + 1760U);
    t70 = (t69 + 56U);
    t71 = *((char **)t70);
    t72 = (t1 + 16440);
    xsi_vlogfile_write(1, 0, 0, ng169, 2, t72, (char)119, t71, 32);
    xsi_set_current_line(1272, ng52);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t8 = (t6 + 4);
    t10 = (t7 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t8);
    t16 = *((unsigned int *)t10);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t8);
    t20 = *((unsigned int *)t10);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB90;

LAB87:    if (t21 != 0)
        goto LAB89;

LAB88:    *((unsigned int *)t9) = 1;

LAB90:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB91;

LAB92:
LAB93:    xsi_set_current_line(1276, ng52);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t9, 0, 0, 32);
    goto LAB82;

LAB86:    t52 = (t2 + 48U);
    *((char **)t52) = &&LAB84;
    goto LAB1;

LAB89:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB90;

LAB91:    xsi_set_current_line(1272, ng52);

LAB94:    xsi_set_current_line(1273, ng52);
    t25 = (t1 + 16440);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t25);
    xsi_set_current_line(1274, ng52);
    xsi_vlog_stop(1);
    goto LAB93;

}

static int sp_READ_BURST_RESPOND(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    int t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t106;
    char *t107;
    char *t108;
    char *t109;
    char *t110;
    char *t111;
    char *t112;
    char *t113;
    char *t114;
    char *t115;
    char *t116;
    char *t117;
    char *t118;
    char *t119;
    char *t120;
    char *t121;
    char *t122;
    char *t123;
    char *t124;
    char *t125;
    char *t126;
    char *t127;
    char *t128;
    char *t129;
    char *t130;
    char *t131;
    char *t132;
    char *t133;
    char *t134;
    char *t135;
    char *t136;
    char *t137;
    char *t138;
    char *t139;
    char *t140;
    char *t141;
    char *t142;
    char *t143;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 16872);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1325, ng52);

LAB5:    xsi_set_current_line(1329, ng52);
    t5 = (t1 + 28080);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(1340, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng86)));
    t11 = (t2 + 56U);
    t24 = *((char **)t11);
    t25 = (t2 + 56U);
    t32 = *((char **)t25);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t32, &&LAB14);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t1 + 14712);
    t36 = xsi_create_subprogram_invocation(t34, 0, t1, t35, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t35, t36);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    xsi_vlogvar_assign_value(t39, t8, 0, 0, 1);
    t40 = (t36 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 160U);
    xsi_vlogvar_assign_value(t42, t10, 0, 0, 1);

LAB16:    t43 = (t2 + 64U);
    t44 = *((char **)t43);
    t45 = (t44 + 80U);
    t46 = *((char **)t45);
    t47 = (t46 + 272U);
    t48 = *((char **)t47);
    t49 = (t48 + 0U);
    t50 = *((char **)t49);
    t53 = ((int  (*)(char *, char *))t50)(t1, t44);
    if (t53 == -1)
        goto LAB17;

LAB18:    if (t53 != 0)
        goto LAB19;

LAB14:    t44 = (t1 + 14712);
    xsi_vlog_subprogram_popinvocation(t44);

LAB15:    t51 = (t2 + 64U);
    t52 = *((char **)t51);
    t51 = (t52 + 96U);
    t54 = *((char **)t51);
    t55 = (t54 + 320U);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    t58 = (t2 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 480U);
    xsi_vlogvar_assign_value(t60, t57, 0, 0, 32);
    t61 = (t52 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 480U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 640U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 8);
    t69 = (t52 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 640U);
    t72 = (t71 + 56U);
    t73 = *((char **)t72);
    t74 = (t2 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 800U);
    xsi_vlogvar_assign_value(t76, t73, 0, 0, 3);
    t77 = (t52 + 96U);
    t78 = *((char **)t77);
    t79 = (t78 + 800U);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = (t2 + 96U);
    t83 = *((char **)t82);
    t84 = (t83 + 960U);
    xsi_vlogvar_assign_value(t84, t81, 0, 0, 2);
    t85 = (t52 + 96U);
    t86 = *((char **)t85);
    t87 = (t86 + 960U);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    t90 = (t2 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 1120U);
    xsi_vlogvar_assign_value(t92, t89, 0, 0, 1);
    t93 = (t52 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 1120U);
    t96 = (t95 + 56U);
    t97 = *((char **)t96);
    t98 = (t2 + 96U);
    t99 = *((char **)t98);
    t100 = (t99 + 1280U);
    xsi_vlogvar_assign_value(t100, t97, 0, 0, 4);
    t101 = (t52 + 96U);
    t102 = *((char **)t101);
    t103 = (t102 + 1280U);
    t104 = (t103 + 56U);
    t105 = *((char **)t104);
    t106 = (t2 + 96U);
    t107 = *((char **)t106);
    t108 = (t107 + 1440U);
    xsi_vlogvar_assign_value(t108, t105, 0, 0, 3);
    t109 = (t52 + 96U);
    t110 = *((char **)t109);
    t111 = (t110 + 1440U);
    t112 = (t111 + 56U);
    t113 = *((char **)t112);
    t114 = (t2 + 96U);
    t115 = *((char **)t114);
    t116 = (t115 + 1600U);
    xsi_vlogvar_assign_value(t116, t113, 0, 0, 4);
    t117 = (t52 + 96U);
    t118 = *((char **)t117);
    t119 = (t118 + 1600U);
    t120 = (t119 + 56U);
    t121 = *((char **)t120);
    t122 = (t2 + 96U);
    t123 = *((char **)t122);
    t124 = (t123 + 1760U);
    xsi_vlogvar_assign_value(t124, t121, 0, 0, 4);
    t125 = (t52 + 96U);
    t126 = *((char **)t125);
    t127 = (t126 + 1760U);
    t128 = (t127 + 56U);
    t129 = *((char **)t128);
    t130 = (t2 + 96U);
    t131 = *((char **)t130);
    t132 = (t131 + 1920U);
    xsi_vlogvar_assign_value(t132, t129, 0, 0, 1);
    t133 = (t52 + 96U);
    t134 = *((char **)t133);
    t135 = (t134 + 1920U);
    t136 = (t135 + 56U);
    t137 = *((char **)t136);
    t138 = (t2 + 96U);
    t139 = *((char **)t138);
    t140 = (t139 + 2080U);
    xsi_vlogvar_assign_value(t140, t137, 0, 0, 1);
    t141 = (t1 + 14712);
    t142 = (t2 + 56U);
    t143 = *((char **)t142);
    xsi_delete_subprogram_invocation(t141, t52, t1, t143, t2);
    xsi_set_current_line(1348, ng52);
    t4 = (t1 + 27280);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t12 = *((unsigned int *)t7);
    t13 = (~(t12));
    t14 = *((unsigned int *)t6);
    t53 = (t14 & t13);
    t8 = (t1 + 55672);
    *((int *)t8) = t53;

LAB20:    t10 = (t1 + 55672);
    if (*((int *)t10) > 0)
        goto LAB21;

LAB22:    xsi_set_current_line(1349, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 640U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 800U);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 960U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = (t2 + 96U);
    t49 = *((char **)t48);
    t50 = (t49 + 1120U);
    t51 = (t50 + 56U);
    t52 = *((char **)t51);
    t54 = (t2 + 96U);
    t55 = *((char **)t54);
    t56 = (t55 + 160U);
    t57 = (t56 + 56U);
    t58 = *((char **)t57);
    t59 = (t2 + 96U);
    t60 = *((char **)t59);
    t61 = (t60 + 320U);
    t62 = (t61 + 56U);
    t63 = *((char **)t62);
    t64 = (t2 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 56U);
    t67 = *((char **)t66);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t67, &&LAB24);
    t68 = (t2 + 56U);
    t69 = *((char **)t68);
    t70 = (t1 + 15576);
    t71 = xsi_create_subprogram_invocation(t69, 0, t1, t70, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t70, t71);
    t72 = (t71 + 96U);
    t73 = *((char **)t72);
    t74 = (t73 + 0U);
    xsi_vlogvar_assign_value(t74, t8, 0, 0, 1);
    t75 = (t71 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 160U);
    xsi_vlogvar_assign_value(t77, t32, 0, 0, 32);
    t78 = (t71 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 320U);
    xsi_vlogvar_assign_value(t80, t37, 0, 0, 8);
    t81 = (t71 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 480U);
    xsi_vlogvar_assign_value(t83, t42, 0, 0, 3);
    t84 = (t71 + 96U);
    t85 = *((char **)t84);
    t86 = (t85 + 640U);
    xsi_vlogvar_assign_value(t86, t47, 0, 0, 2);
    t87 = (t71 + 96U);
    t88 = *((char **)t87);
    t89 = (t88 + 800U);
    xsi_vlogvar_assign_value(t89, t52, 0, 0, 1);
    t90 = (t71 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 960U);
    xsi_vlogvar_assign_value(t92, t58, 0, 0, 8192);
    t93 = (t71 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 1120U);
    xsi_vlogvar_assign_value(t95, t63, 0, 0, 256);

LAB26:    t96 = (t2 + 64U);
    t97 = *((char **)t96);
    t98 = (t97 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t102 = (t101 + 0U);
    t103 = *((char **)t102);
    t53 = ((int  (*)(char *, char *))t103)(t1, t97);
    if (t53 == -1)
        goto LAB27;

LAB28:    if (t53 != 0)
        goto LAB29;

LAB24:    t97 = (t1 + 15576);
    xsi_vlog_subprogram_popinvocation(t97);

LAB25:    t104 = (t2 + 64U);
    t105 = *((char **)t104);
    t104 = (t1 + 15576);
    t106 = (t2 + 56U);
    t107 = *((char **)t106);
    xsi_delete_subprogram_invocation(t104, t105, t1, t107, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(1329, ng52);

LAB13:    xsi_set_current_line(1330, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 16872);
    xsi_vlogfile_write(0, 0, 0, ng171, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 16872);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 16872);
    xsi_vlogfile_write(0, 0, 0, ng131, 2, t46, (char)118, t45, 8192);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 320U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 16872);
    xsi_vlogfile_write(1, 0, 0, ng133, 2, t52, (char)118, t51, 256);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t43 = (t2 + 48U);
    *((char **)t43) = &&LAB16;
    goto LAB1;

LAB21:    xsi_set_current_line(1348, ng52);
    t11 = (t2 + 88U);
    t24 = *((char **)t11);
    t25 = (t24 + 0U);
    xsi_wp_set_status(t25, 1);
    *((char **)t3) = &&LAB23;
    goto LAB1;

LAB23:    t4 = (t1 + 55672);
    t53 = *((int *)t4);
    *((int *)t4) = (t53 - 1);
    goto LAB20;

LAB27:    t0 = -1;
    goto LAB1;

LAB29:    t96 = (t2 + 48U);
    *((char **)t96) = &&LAB26;
    goto LAB1;

}

static int sp_READ_BURST_RESP_CTRL(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    int t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t106;
    char *t107;
    char *t108;
    char *t109;
    char *t110;
    char *t111;
    char *t112;
    char *t113;
    char *t114;
    char *t115;
    char *t116;
    char *t117;
    char *t118;
    char *t119;
    char *t120;
    char *t121;
    char *t122;
    char *t123;
    char *t124;
    char *t125;
    char *t126;
    char *t127;
    char *t128;
    char *t129;
    char *t130;
    char *t131;
    char *t132;
    char *t133;
    char *t134;
    char *t135;
    char *t136;
    char *t137;
    char *t138;
    char *t139;
    char *t140;
    char *t141;
    char *t142;
    char *t143;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 17304);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1393, ng52);

LAB5:    xsi_set_current_line(1397, ng52);
    t5 = (t1 + 28080);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(1409, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng86)));
    t11 = (t2 + 56U);
    t24 = *((char **)t11);
    t25 = (t2 + 56U);
    t32 = *((char **)t25);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t32, &&LAB14);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t1 + 14712);
    t36 = xsi_create_subprogram_invocation(t34, 0, t1, t35, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t35, t36);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    xsi_vlogvar_assign_value(t39, t8, 0, 0, 1);
    t40 = (t36 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 160U);
    xsi_vlogvar_assign_value(t42, t10, 0, 0, 1);

LAB16:    t43 = (t2 + 64U);
    t44 = *((char **)t43);
    t45 = (t44 + 80U);
    t46 = *((char **)t45);
    t47 = (t46 + 272U);
    t48 = *((char **)t47);
    t49 = (t48 + 0U);
    t50 = *((char **)t49);
    t59 = ((int  (*)(char *, char *))t50)(t1, t44);
    if (t59 == -1)
        goto LAB17;

LAB18:    if (t59 != 0)
        goto LAB19;

LAB14:    t44 = (t1 + 14712);
    xsi_vlog_subprogram_popinvocation(t44);

LAB15:    t51 = (t2 + 64U);
    t52 = *((char **)t51);
    t51 = (t52 + 96U);
    t53 = *((char **)t51);
    t54 = (t53 + 320U);
    t55 = (t54 + 56U);
    t56 = *((char **)t55);
    t57 = (t2 + 96U);
    t58 = *((char **)t57);
    t60 = (t58 + 640U);
    xsi_vlogvar_assign_value(t60, t56, 0, 0, 32);
    t61 = (t52 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 480U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 800U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 8);
    t69 = (t52 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 640U);
    t72 = (t71 + 56U);
    t73 = *((char **)t72);
    t74 = (t2 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 960U);
    xsi_vlogvar_assign_value(t76, t73, 0, 0, 3);
    t77 = (t52 + 96U);
    t78 = *((char **)t77);
    t79 = (t78 + 800U);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = (t2 + 96U);
    t83 = *((char **)t82);
    t84 = (t83 + 1120U);
    xsi_vlogvar_assign_value(t84, t81, 0, 0, 2);
    t85 = (t52 + 96U);
    t86 = *((char **)t85);
    t87 = (t86 + 960U);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    t90 = (t2 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 1280U);
    xsi_vlogvar_assign_value(t92, t89, 0, 0, 1);
    t93 = (t52 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 1120U);
    t96 = (t95 + 56U);
    t97 = *((char **)t96);
    t98 = (t2 + 96U);
    t99 = *((char **)t98);
    t100 = (t99 + 1440U);
    xsi_vlogvar_assign_value(t100, t97, 0, 0, 4);
    t101 = (t52 + 96U);
    t102 = *((char **)t101);
    t103 = (t102 + 1280U);
    t104 = (t103 + 56U);
    t105 = *((char **)t104);
    t106 = (t2 + 96U);
    t107 = *((char **)t106);
    t108 = (t107 + 1600U);
    xsi_vlogvar_assign_value(t108, t105, 0, 0, 3);
    t109 = (t52 + 96U);
    t110 = *((char **)t109);
    t111 = (t110 + 1440U);
    t112 = (t111 + 56U);
    t113 = *((char **)t112);
    t114 = (t2 + 96U);
    t115 = *((char **)t114);
    t116 = (t115 + 1760U);
    xsi_vlogvar_assign_value(t116, t113, 0, 0, 4);
    t117 = (t52 + 96U);
    t118 = *((char **)t117);
    t119 = (t118 + 1600U);
    t120 = (t119 + 56U);
    t121 = *((char **)t120);
    t122 = (t2 + 96U);
    t123 = *((char **)t122);
    t124 = (t123 + 1920U);
    xsi_vlogvar_assign_value(t124, t121, 0, 0, 4);
    t125 = (t52 + 96U);
    t126 = *((char **)t125);
    t127 = (t126 + 1760U);
    t128 = (t127 + 56U);
    t129 = *((char **)t128);
    t130 = (t2 + 96U);
    t131 = *((char **)t130);
    t132 = (t131 + 2080U);
    xsi_vlogvar_assign_value(t132, t129, 0, 0, 1);
    t133 = (t52 + 96U);
    t134 = *((char **)t133);
    t135 = (t134 + 1920U);
    t136 = (t135 + 56U);
    t137 = *((char **)t136);
    t138 = (t2 + 96U);
    t139 = *((char **)t138);
    t140 = (t139 + 2240U);
    xsi_vlogvar_assign_value(t140, t137, 0, 0, 1);
    t141 = (t1 + 14712);
    t142 = (t2 + 56U);
    t143 = *((char **)t142);
    xsi_delete_subprogram_invocation(t141, t52, t1, t143, t2);
    xsi_set_current_line(1417, ng52);
    t4 = (t1 + 27280);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t12 = *((unsigned int *)t7);
    t13 = (~(t12));
    t14 = *((unsigned int *)t6);
    t59 = (t14 & t13);
    t8 = (t1 + 55676);
    *((int *)t8) = t59;

LAB20:    t10 = (t1 + 55676);
    if (*((int *)t10) > 0)
        goto LAB21;

LAB22:    xsi_set_current_line(1418, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 640U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 800U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 960U);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 1120U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = (t2 + 96U);
    t49 = *((char **)t48);
    t50 = (t49 + 160U);
    t51 = (t50 + 56U);
    t52 = *((char **)t51);
    t53 = (t2 + 96U);
    t54 = *((char **)t53);
    t55 = (t54 + 320U);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    t58 = (t2 + 96U);
    t60 = *((char **)t58);
    t61 = (t60 + 480U);
    t62 = (t61 + 56U);
    t63 = *((char **)t62);
    t64 = (t2 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 56U);
    t67 = *((char **)t66);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t67, &&LAB24);
    t68 = (t2 + 56U);
    t69 = *((char **)t68);
    t70 = (t1 + 16008);
    t71 = xsi_create_subprogram_invocation(t69, 0, t1, t70, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t70, t71);
    t72 = (t71 + 96U);
    t73 = *((char **)t72);
    t74 = (t73 + 0U);
    xsi_vlogvar_assign_value(t74, t8, 0, 0, 1);
    t75 = (t71 + 96U);
    t76 = *((char **)t75);
    t77 = (t76 + 160U);
    xsi_vlogvar_assign_value(t77, t32, 0, 0, 32);
    t78 = (t71 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 320U);
    xsi_vlogvar_assign_value(t80, t37, 0, 0, 8);
    t81 = (t71 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 480U);
    xsi_vlogvar_assign_value(t83, t42, 0, 0, 3);
    t84 = (t71 + 96U);
    t85 = *((char **)t84);
    t86 = (t85 + 640U);
    xsi_vlogvar_assign_value(t86, t47, 0, 0, 2);
    t87 = (t71 + 96U);
    t88 = *((char **)t87);
    t89 = (t88 + 800U);
    xsi_vlogvar_assign_value(t89, t52, 0, 0, 8192);
    t90 = (t71 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 960U);
    xsi_vlogvar_assign_value(t92, t57, 0, 0, 512);
    t93 = (t71 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 1120U);
    xsi_vlogvar_assign_value(t95, t63, 0, 0, 256);

LAB26:    t96 = (t2 + 64U);
    t97 = *((char **)t96);
    t98 = (t97 + 80U);
    t99 = *((char **)t98);
    t100 = (t99 + 272U);
    t101 = *((char **)t100);
    t102 = (t101 + 0U);
    t103 = *((char **)t102);
    t59 = ((int  (*)(char *, char *))t103)(t1, t97);
    if (t59 == -1)
        goto LAB27;

LAB28:    if (t59 != 0)
        goto LAB29;

LAB24:    t97 = (t1 + 16008);
    xsi_vlog_subprogram_popinvocation(t97);

LAB25:    t104 = (t2 + 64U);
    t105 = *((char **)t104);
    t104 = (t1 + 16008);
    t106 = (t2 + 56U);
    t107 = *((char **)t106);
    xsi_delete_subprogram_invocation(t104, t105, t1, t107, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(1397, ng52);

LAB13:    xsi_set_current_line(1398, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 17304);
    xsi_vlogfile_write(0, 0, 0, ng172, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 17304);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 17304);
    xsi_vlogfile_write(0, 0, 0, ng131, 2, t46, (char)118, t45, 8192);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 320U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 17304);
    xsi_vlogfile_write(0, 0, 0, ng128, 2, t52, (char)118, t51, 512);
    t53 = (t2 + 96U);
    t54 = *((char **)t53);
    t55 = (t54 + 480U);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    t58 = (t1 + 17304);
    xsi_vlogfile_write(1, 0, 0, ng133, 2, t58, (char)118, t57, 256);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t43 = (t2 + 48U);
    *((char **)t43) = &&LAB16;
    goto LAB1;

LAB21:    xsi_set_current_line(1417, ng52);
    t11 = (t2 + 88U);
    t24 = *((char **)t11);
    t25 = (t24 + 0U);
    xsi_wp_set_status(t25, 1);
    *((char **)t3) = &&LAB23;
    goto LAB1;

LAB23:    t4 = (t1 + 55676);
    t59 = *((int *)t4);
    *((int *)t4) = (t59 - 1);
    goto LAB20;

LAB27:    t0 = -1;
    goto LAB1;

LAB29:    t96 = (t2 + 48U);
    *((char **)t96) = &&LAB26;
    goto LAB1;

}

static int sp_WRITE_BURST_RESPOND(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    int t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t106;
    char *t107;
    char *t108;
    char *t109;
    char *t110;
    char *t111;
    char *t112;
    char *t113;
    char *t114;
    char *t115;
    char *t116;
    char *t117;
    char *t118;
    char *t119;
    char *t120;
    char *t121;
    char *t122;
    char *t123;
    char *t124;
    char *t125;
    char *t126;
    char *t127;
    char *t128;
    char *t129;
    char *t130;
    char *t131;
    char *t132;
    char *t133;
    char *t134;
    char *t135;
    char *t136;
    char *t137;
    char *t138;
    char *t139;
    char *t140;
    char *t141;
    char *t142;
    char *t143;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 17736);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1459, ng52);

LAB5:    xsi_set_current_line(1463, ng52);
    t5 = (t1 + 28080);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(1474, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng86)));
    t11 = (t2 + 56U);
    t24 = *((char **)t11);
    t25 = (t2 + 56U);
    t32 = *((char **)t25);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t32, &&LAB14);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t1 + 14280);
    t36 = xsi_create_subprogram_invocation(t34, 0, t1, t35, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t35, t36);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    xsi_vlogvar_assign_value(t39, t8, 0, 0, 1);
    t40 = (t36 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 160U);
    xsi_vlogvar_assign_value(t42, t10, 0, 0, 1);

LAB16:    t43 = (t2 + 64U);
    t44 = *((char **)t43);
    t45 = (t44 + 80U);
    t46 = *((char **)t45);
    t47 = (t46 + 272U);
    t48 = *((char **)t47);
    t49 = (t48 + 0U);
    t50 = *((char **)t49);
    t51 = ((int  (*)(char *, char *))t50)(t1, t44);
    if (t51 == -1)
        goto LAB17;

LAB18:    if (t51 != 0)
        goto LAB19;

LAB14:    t44 = (t1 + 14280);
    xsi_vlog_subprogram_popinvocation(t44);

LAB15:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t52 = (t53 + 96U);
    t54 = *((char **)t52);
    t55 = (t54 + 320U);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    t58 = (t2 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 800U);
    xsi_vlogvar_assign_value(t60, t57, 0, 0, 32);
    t61 = (t53 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 480U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 960U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 8);
    t69 = (t53 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 640U);
    t72 = (t71 + 56U);
    t73 = *((char **)t72);
    t74 = (t2 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 1120U);
    xsi_vlogvar_assign_value(t76, t73, 0, 0, 3);
    t77 = (t53 + 96U);
    t78 = *((char **)t77);
    t79 = (t78 + 800U);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = (t2 + 96U);
    t83 = *((char **)t82);
    t84 = (t83 + 1280U);
    xsi_vlogvar_assign_value(t84, t81, 0, 0, 2);
    t85 = (t53 + 96U);
    t86 = *((char **)t85);
    t87 = (t86 + 960U);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    t90 = (t2 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 1440U);
    xsi_vlogvar_assign_value(t92, t89, 0, 0, 1);
    t93 = (t53 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 1120U);
    t96 = (t95 + 56U);
    t97 = *((char **)t96);
    t98 = (t2 + 96U);
    t99 = *((char **)t98);
    t100 = (t99 + 1600U);
    xsi_vlogvar_assign_value(t100, t97, 0, 0, 4);
    t101 = (t53 + 96U);
    t102 = *((char **)t101);
    t103 = (t102 + 1280U);
    t104 = (t103 + 56U);
    t105 = *((char **)t104);
    t106 = (t2 + 96U);
    t107 = *((char **)t106);
    t108 = (t107 + 1760U);
    xsi_vlogvar_assign_value(t108, t105, 0, 0, 3);
    t109 = (t53 + 96U);
    t110 = *((char **)t109);
    t111 = (t110 + 1440U);
    t112 = (t111 + 56U);
    t113 = *((char **)t112);
    t114 = (t2 + 96U);
    t115 = *((char **)t114);
    t116 = (t115 + 2080U);
    xsi_vlogvar_assign_value(t116, t113, 0, 0, 4);
    t117 = (t53 + 96U);
    t118 = *((char **)t117);
    t119 = (t118 + 1600U);
    t120 = (t119 + 56U);
    t121 = *((char **)t120);
    t122 = (t2 + 96U);
    t123 = *((char **)t122);
    t124 = (t123 + 2240U);
    xsi_vlogvar_assign_value(t124, t121, 0, 0, 4);
    t125 = (t53 + 96U);
    t126 = *((char **)t125);
    t127 = (t126 + 1760U);
    t128 = (t127 + 56U);
    t129 = *((char **)t128);
    t130 = (t2 + 96U);
    t131 = *((char **)t130);
    t132 = (t131 + 2400U);
    xsi_vlogvar_assign_value(t132, t129, 0, 0, 1);
    t133 = (t53 + 96U);
    t134 = *((char **)t133);
    t135 = (t134 + 1920U);
    t136 = (t135 + 56U);
    t137 = *((char **)t136);
    t138 = (t2 + 96U);
    t139 = *((char **)t138);
    t140 = (t139 + 2560U);
    xsi_vlogvar_assign_value(t140, t137, 0, 0, 1);
    t141 = (t1 + 14280);
    t142 = (t2 + 56U);
    t143 = *((char **)t142);
    xsi_delete_subprogram_invocation(t141, t53, t1, t143, t2);
    xsi_set_current_line(1479, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 960U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 1120U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 1280U);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t2 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 56U);
    t46 = *((char **)t45);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t46, &&LAB20);
    t47 = (t2 + 56U);
    t48 = *((char **)t47);
    t49 = (t1 + 16440);
    t50 = xsi_create_subprogram_invocation(t48, 0, t1, t49, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t49, t50);
    t52 = (t50 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 32);
    t55 = (t50 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t32, 0, 0, 8);
    t58 = (t50 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t37, 0, 0, 3);
    t61 = (t50 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 480U);
    xsi_vlogvar_assign_value(t63, t42, 0, 0, 2);

LAB22:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t66 = (t65 + 80U);
    t67 = *((char **)t66);
    t68 = (t67 + 272U);
    t69 = *((char **)t68);
    t70 = (t69 + 0U);
    t71 = *((char **)t70);
    t51 = ((int  (*)(char *, char *))t71)(t1, t65);
    if (t51 == -1)
        goto LAB23;

LAB24:    if (t51 != 0)
        goto LAB25;

LAB20:    t65 = (t1 + 16440);
    xsi_vlog_subprogram_popinvocation(t65);

LAB21:    t72 = (t2 + 64U);
    t73 = *((char **)t72);
    t72 = (t73 + 96U);
    t74 = *((char **)t72);
    t75 = (t74 + 640U);
    t76 = (t75 + 56U);
    t77 = *((char **)t76);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 320U);
    xsi_vlogvar_assign_value(t80, t77, 0, 0, 8192);
    t81 = (t73 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 800U);
    t84 = (t83 + 56U);
    t85 = *((char **)t84);
    t86 = (t2 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 480U);
    xsi_vlogvar_assign_value(t88, t85, 0, 0, 32);
    t89 = (t73 + 96U);
    t90 = *((char **)t89);
    t91 = (t90 + 960U);
    t92 = (t91 + 56U);
    t93 = *((char **)t92);
    t94 = (t2 + 96U);
    t95 = *((char **)t94);
    t96 = (t95 + 640U);
    xsi_vlogvar_assign_value(t96, t93, 0, 0, 256);
    t97 = (t1 + 16440);
    t98 = (t2 + 56U);
    t99 = *((char **)t98);
    xsi_delete_subprogram_invocation(t97, t73, t1, t99, t2);
    xsi_set_current_line(1486, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1440U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t1 + 7800);
    t25 = xsi_create_subprogram_invocation(t11, 0, t1, t24, 0, t2);
    t32 = (t1 + 34960);
    xsi_vlogvar_assign_value(t32, t8, 0, 0, 1);

LAB26:    t33 = (t2 + 64U);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t36 = *((char **)t35);
    t37 = (t36 + 272U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    t40 = *((char **)t39);
    t51 = ((int  (*)(char *, char *))t40)(t1, t34);
    if (t51 != 0)
        goto LAB28;

LAB27:    t34 = (t2 + 64U);
    t41 = *((char **)t34);
    t34 = (t1 + 34800);
    t42 = (t34 + 56U);
    t43 = *((char **)t42);
    memcpy(t9, t43, 8);
    t44 = (t1 + 7800);
    t45 = (t2 + 56U);
    t46 = *((char **)t45);
    xsi_delete_subprogram_invocation(t44, t41, t1, t46, t2);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 1920U);
    xsi_vlogvar_assign_value(t49, t9, 0, 0, 2);
    xsi_set_current_line(1487, ng52);
    t4 = (t1 + 27120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t12 = *((unsigned int *)t7);
    t13 = (~(t12));
    t14 = *((unsigned int *)t6);
    t51 = (t14 & t13);
    t8 = (t1 + 55680);
    *((int *)t8) = t51;

LAB29:    t10 = (t1 + 55680);
    if (*((int *)t10) > 0)
        goto LAB30;

LAB31:    xsi_set_current_line(1488, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1920U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 160U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t41 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t41, &&LAB33);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    t44 = (t1 + 13416);
    t45 = xsi_create_subprogram_invocation(t43, 0, t1, t44, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t44, t45);
    t46 = (t45 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 0U);
    xsi_vlogvar_assign_value(t48, t8, 0, 0, 1);
    t49 = (t45 + 96U);
    t50 = *((char **)t49);
    t52 = (t50 + 160U);
    xsi_vlogvar_assign_value(t52, t32, 0, 0, 2);
    t53 = (t45 + 96U);
    t54 = *((char **)t53);
    t55 = (t54 + 320U);
    xsi_vlogvar_assign_value(t55, t37, 0, 0, 1);

LAB35:    t56 = (t2 + 64U);
    t57 = *((char **)t56);
    t58 = (t57 + 80U);
    t59 = *((char **)t58);
    t60 = (t59 + 272U);
    t61 = *((char **)t60);
    t62 = (t61 + 0U);
    t63 = *((char **)t62);
    t51 = ((int  (*)(char *, char *))t63)(t1, t57);
    if (t51 == -1)
        goto LAB36;

LAB37:    if (t51 != 0)
        goto LAB38;

LAB33:    t57 = (t1 + 13416);
    xsi_vlog_subprogram_popinvocation(t57);

LAB34:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t64 = (t1 + 13416);
    t66 = (t2 + 56U);
    t67 = *((char **)t66);
    xsi_delete_subprogram_invocation(t64, t65, t1, t67, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(1463, ng52);

LAB13:    xsi_set_current_line(1464, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 17736);
    xsi_vlogfile_write(0, 0, 0, ng173, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 17736);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 17736);
    xsi_vlogfile_write(1, 0, 0, ng129, 2, t46, (char)118, t45, 1);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t43 = (t2 + 48U);
    *((char **)t43) = &&LAB16;
    goto LAB1;

LAB23:    t0 = -1;
    goto LAB1;

LAB25:    t64 = (t2 + 48U);
    *((char **)t64) = &&LAB22;
    goto LAB1;

LAB28:    t33 = (t2 + 48U);
    *((char **)t33) = &&LAB26;
    goto LAB1;

LAB30:    xsi_set_current_line(1487, ng52);
    t11 = (t2 + 88U);
    t24 = *((char **)t11);
    t25 = (t24 + 0U);
    xsi_wp_set_status(t25, 1);
    *((char **)t3) = &&LAB32;
    goto LAB1;

LAB32:    t4 = (t1 + 55680);
    t51 = *((int *)t4);
    *((int *)t4) = (t51 - 1);
    goto LAB29;

LAB36:    t0 = -1;
    goto LAB1;

LAB38:    t56 = (t2 + 48U);
    *((char **)t56) = &&LAB35;
    goto LAB1;

}

static int sp_WRITE_BURST_RESP_CTRL(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    int t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t106;
    char *t107;
    char *t108;
    char *t109;
    char *t110;
    char *t111;
    char *t112;
    char *t113;
    char *t114;
    char *t115;
    char *t116;
    char *t117;
    char *t118;
    char *t119;
    char *t120;
    char *t121;
    char *t122;
    char *t123;
    char *t124;
    char *t125;
    char *t126;
    char *t127;
    char *t128;
    char *t129;
    char *t130;
    char *t131;
    char *t132;
    char *t133;
    char *t134;
    char *t135;
    char *t136;
    char *t137;
    char *t138;
    char *t139;
    char *t140;
    char *t141;
    char *t142;
    char *t143;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 18168);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1535, ng52);

LAB5:    xsi_set_current_line(1539, ng52);
    t5 = (t1 + 28080);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    t10 = (t7 + 4);
    t11 = (t8 + 4);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t10);
    t16 = *((unsigned int *)t11);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t21 = (t19 | t20);
    t22 = (~(t21));
    t23 = (t18 & t22);
    if (t23 != 0)
        goto LAB9;

LAB6:    if (t21 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t9) = 1;

LAB9:    t25 = (t9 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB10;

LAB11:
LAB12:    xsi_set_current_line(1551, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng86)));
    t11 = (t2 + 56U);
    t24 = *((char **)t11);
    t25 = (t2 + 56U);
    t32 = *((char **)t25);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t32, &&LAB14);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t1 + 14280);
    t36 = xsi_create_subprogram_invocation(t34, 0, t1, t35, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t35, t36);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 0U);
    xsi_vlogvar_assign_value(t39, t8, 0, 0, 1);
    t40 = (t36 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 160U);
    xsi_vlogvar_assign_value(t42, t10, 0, 0, 1);

LAB16:    t43 = (t2 + 64U);
    t44 = *((char **)t43);
    t45 = (t44 + 80U);
    t46 = *((char **)t45);
    t47 = (t46 + 272U);
    t48 = *((char **)t47);
    t49 = (t48 + 0U);
    t50 = *((char **)t49);
    t53 = ((int  (*)(char *, char *))t50)(t1, t44);
    if (t53 == -1)
        goto LAB17;

LAB18:    if (t53 != 0)
        goto LAB19;

LAB14:    t44 = (t1 + 14280);
    xsi_vlog_subprogram_popinvocation(t44);

LAB15:    t51 = (t2 + 64U);
    t52 = *((char **)t51);
    t51 = (t52 + 96U);
    t54 = *((char **)t51);
    t55 = (t54 + 320U);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    t58 = (t2 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 960U);
    xsi_vlogvar_assign_value(t60, t57, 0, 0, 32);
    t61 = (t52 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 480U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 1120U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 8);
    t69 = (t52 + 96U);
    t70 = *((char **)t69);
    t71 = (t70 + 640U);
    t72 = (t71 + 56U);
    t73 = *((char **)t72);
    t74 = (t2 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 1280U);
    xsi_vlogvar_assign_value(t76, t73, 0, 0, 3);
    t77 = (t52 + 96U);
    t78 = *((char **)t77);
    t79 = (t78 + 800U);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = (t2 + 96U);
    t83 = *((char **)t82);
    t84 = (t83 + 1440U);
    xsi_vlogvar_assign_value(t84, t81, 0, 0, 2);
    t85 = (t52 + 96U);
    t86 = *((char **)t85);
    t87 = (t86 + 960U);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    t90 = (t2 + 96U);
    t91 = *((char **)t90);
    t92 = (t91 + 1600U);
    xsi_vlogvar_assign_value(t92, t89, 0, 0, 1);
    t93 = (t52 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 1120U);
    t96 = (t95 + 56U);
    t97 = *((char **)t96);
    t98 = (t2 + 96U);
    t99 = *((char **)t98);
    t100 = (t99 + 1760U);
    xsi_vlogvar_assign_value(t100, t97, 0, 0, 4);
    t101 = (t52 + 96U);
    t102 = *((char **)t101);
    t103 = (t102 + 1280U);
    t104 = (t103 + 56U);
    t105 = *((char **)t104);
    t106 = (t2 + 96U);
    t107 = *((char **)t106);
    t108 = (t107 + 1920U);
    xsi_vlogvar_assign_value(t108, t105, 0, 0, 3);
    t109 = (t52 + 96U);
    t110 = *((char **)t109);
    t111 = (t110 + 1440U);
    t112 = (t111 + 56U);
    t113 = *((char **)t112);
    t114 = (t2 + 96U);
    t115 = *((char **)t114);
    t116 = (t115 + 2080U);
    xsi_vlogvar_assign_value(t116, t113, 0, 0, 4);
    t117 = (t52 + 96U);
    t118 = *((char **)t117);
    t119 = (t118 + 1600U);
    t120 = (t119 + 56U);
    t121 = *((char **)t120);
    t122 = (t2 + 96U);
    t123 = *((char **)t122);
    t124 = (t123 + 2240U);
    xsi_vlogvar_assign_value(t124, t121, 0, 0, 4);
    t125 = (t52 + 96U);
    t126 = *((char **)t125);
    t127 = (t126 + 1760U);
    t128 = (t127 + 56U);
    t129 = *((char **)t128);
    t130 = (t2 + 96U);
    t131 = *((char **)t130);
    t132 = (t131 + 2400U);
    xsi_vlogvar_assign_value(t132, t129, 0, 0, 1);
    t133 = (t52 + 96U);
    t134 = *((char **)t133);
    t135 = (t134 + 1920U);
    t136 = (t135 + 56U);
    t137 = *((char **)t136);
    t138 = (t2 + 96U);
    t139 = *((char **)t138);
    t140 = (t139 + 3200U);
    xsi_vlogvar_assign_value(t140, t137, 0, 0, 1);
    t141 = (t1 + 14280);
    t142 = (t2 + 56U);
    t143 = *((char **)t142);
    xsi_delete_subprogram_invocation(t141, t52, t1, t143, t2);
    xsi_set_current_line(1556, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 1120U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 1280U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 1440U);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t2 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 56U);
    t46 = *((char **)t45);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t46, &&LAB20);
    t47 = (t2 + 56U);
    t48 = *((char **)t47);
    t49 = (t1 + 16440);
    t50 = xsi_create_subprogram_invocation(t48, 0, t1, t49, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t49, t50);
    t51 = (t50 + 96U);
    t52 = *((char **)t51);
    t54 = (t52 + 0U);
    xsi_vlogvar_assign_value(t54, t8, 0, 0, 32);
    t55 = (t50 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t32, 0, 0, 8);
    t58 = (t50 + 96U);
    t59 = *((char **)t58);
    t60 = (t59 + 320U);
    xsi_vlogvar_assign_value(t60, t37, 0, 0, 3);
    t61 = (t50 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 480U);
    xsi_vlogvar_assign_value(t63, t42, 0, 0, 2);

LAB22:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t66 = (t65 + 80U);
    t67 = *((char **)t66);
    t68 = (t67 + 272U);
    t69 = *((char **)t68);
    t70 = (t69 + 0U);
    t71 = *((char **)t70);
    t53 = ((int  (*)(char *, char *))t71)(t1, t65);
    if (t53 == -1)
        goto LAB23;

LAB24:    if (t53 != 0)
        goto LAB25;

LAB20:    t65 = (t1 + 16440);
    xsi_vlog_subprogram_popinvocation(t65);

LAB21:    t72 = (t2 + 64U);
    t73 = *((char **)t72);
    t72 = (t73 + 96U);
    t74 = *((char **)t72);
    t75 = (t74 + 640U);
    t76 = (t75 + 56U);
    t77 = *((char **)t76);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 480U);
    xsi_vlogvar_assign_value(t80, t77, 0, 0, 8192);
    t81 = (t73 + 96U);
    t82 = *((char **)t81);
    t83 = (t82 + 800U);
    t84 = (t83 + 56U);
    t85 = *((char **)t84);
    t86 = (t2 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 640U);
    xsi_vlogvar_assign_value(t88, t85, 0, 0, 32);
    t89 = (t73 + 96U);
    t90 = *((char **)t89);
    t91 = (t90 + 960U);
    t92 = (t91 + 56U);
    t93 = *((char **)t92);
    t94 = (t2 + 96U);
    t95 = *((char **)t94);
    t96 = (t95 + 800U);
    xsi_vlogvar_assign_value(t96, t93, 0, 0, 256);
    t97 = (t1 + 16440);
    t98 = (t2 + 56U);
    t99 = *((char **)t98);
    xsi_delete_subprogram_invocation(t97, t73, t1, t99, t2);
    xsi_set_current_line(1562, ng52);
    t4 = (t1 + 27120);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 4);
    t12 = *((unsigned int *)t7);
    t13 = (~(t12));
    t14 = *((unsigned int *)t6);
    t53 = (t14 & t13);
    t8 = (t1 + 55684);
    *((int *)t8) = t53;

LAB26:    t10 = (t1 + 55684);
    if (*((int *)t10) > 0)
        goto LAB27;

LAB28:    xsi_set_current_line(1563, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 160U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 320U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    t40 = (t2 + 56U);
    t41 = *((char **)t40);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t41, &&LAB30);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    t44 = (t1 + 13416);
    t45 = xsi_create_subprogram_invocation(t43, 0, t1, t44, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t44, t45);
    t46 = (t45 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 0U);
    xsi_vlogvar_assign_value(t48, t8, 0, 0, 1);
    t49 = (t45 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 160U);
    xsi_vlogvar_assign_value(t51, t32, 0, 0, 2);
    t52 = (t45 + 96U);
    t54 = *((char **)t52);
    t55 = (t54 + 320U);
    xsi_vlogvar_assign_value(t55, t37, 0, 0, 1);

LAB32:    t56 = (t2 + 64U);
    t57 = *((char **)t56);
    t58 = (t57 + 80U);
    t59 = *((char **)t58);
    t60 = (t59 + 272U);
    t61 = *((char **)t60);
    t62 = (t61 + 0U);
    t63 = *((char **)t62);
    t53 = ((int  (*)(char *, char *))t63)(t1, t57);
    if (t53 == -1)
        goto LAB33;

LAB34:    if (t53 != 0)
        goto LAB35;

LAB30:    t57 = (t1 + 13416);
    xsi_vlog_subprogram_popinvocation(t57);

LAB31:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t64 = (t1 + 13416);
    t66 = (t2 + 56U);
    t67 = *((char **)t66);
    xsi_delete_subprogram_invocation(t64, t65, t1, t67, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(1539, ng52);

LAB13:    xsi_set_current_line(1540, ng52);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng56)));
    t34 = (t1 + 18168);
    xsi_vlogfile_write(0, 0, 0, ng174, 3, t34, (char)118, t31, 64, (char)118, t33, 56);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 18168);
    xsi_vlogfile_write(0, 0, 0, ng127, 2, t40, (char)118, t39, 1);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 18168);
    xsi_vlogfile_write(0, 0, 0, ng128, 2, t46, (char)118, t45, 2);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 320U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 18168);
    xsi_vlogfile_write(1, 0, 0, ng129, 2, t52, (char)118, t51, 1);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t43 = (t2 + 48U);
    *((char **)t43) = &&LAB16;
    goto LAB1;

LAB23:    t0 = -1;
    goto LAB1;

LAB25:    t64 = (t2 + 48U);
    *((char **)t64) = &&LAB22;
    goto LAB1;

LAB27:    xsi_set_current_line(1562, ng52);
    t11 = (t2 + 88U);
    t24 = *((char **)t11);
    t25 = (t24 + 0U);
    xsi_wp_set_status(t25, 1);
    *((char **)t3) = &&LAB29;
    goto LAB1;

LAB29:    t4 = (t1 + 55684);
    t53 = *((int *)t4);
    *((int *)t4) = (t53 - 1);
    goto LAB26;

LAB33:    t0 = -1;
    goto LAB1;

LAB35:    t56 = (t2 + 48U);
    *((char **)t56) = &&LAB32;
    goto LAB1;

}

static int sp_set_read_burst_data_transfer_gap(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 18600);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1582, ng52);

LAB5:    xsi_set_current_line(1583, ng52);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 18600);
    xsi_vlogfile_write(1, 0, 0, ng175, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)119, t12, 32);
    xsi_set_current_line(1584, ng52);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 26960);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_write_response_gap(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 19032);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1598, ng52);

LAB5:    xsi_set_current_line(1599, ng52);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 19032);
    xsi_vlogfile_write(1, 0, 0, ng176, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)119, t12, 32);
    xsi_set_current_line(1600, ng52);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 27120);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_read_response_gap(char *t1, char *t2)
{
    char t5[16];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 19464);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1614, ng52);

LAB5:    xsi_set_current_line(1615, ng52);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng56)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 19464);
    xsi_vlogfile_write(1, 0, 0, ng177, 4, t13, (char)118, t5, 64, (char)118, t7, 56, (char)119, t12, 32);
    xsi_set_current_line(1616, ng52);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 27280);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_check_address_range(char *t1, char *t2)
{
    char t7[8];
    char t9[8];
    char t37[8];
    char t41[8];
    char t49[8];
    char t83[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t38;
    char *t39;
    char *t40;
    char *t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t48;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    char *t53;
    char *t54;
    char *t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    char *t63;
    char *t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 19896);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1638, ng52);

LAB5:    xsi_set_current_line(1639, ng52);
    t5 = ((char*)((ng66)));
    t6 = ((char*)((ng68)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 32, t6, 32);
    t8 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_unsigned_minus(t9, 32, t7, 32, t8, 32);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t12 = (t11 + 640U);
    xsi_vlogvar_assign_value(t12, t9, 0, 0, 32);
    xsi_set_current_line(1642, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t8 = (t6 + 56U);
    t10 = *((char **)t8);
    t11 = ((char*)((ng66)));
    memset(t7, 0, 8);
    t12 = (t10 + 4);
    if (*((unsigned int *)t12) != 0)
        goto LAB7;

LAB6:    t13 = (t11 + 4);
    if (*((unsigned int *)t13) != 0)
        goto LAB7;

LAB10:    if (*((unsigned int *)t10) < *((unsigned int *)t11))
        goto LAB8;

LAB9:    memset(t9, 0, 8);
    t15 = (t7 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (~(t16));
    t18 = *((unsigned int *)t7);
    t19 = (t18 & t17);
    t20 = (t19 & 1U);
    if (t20 != 0)
        goto LAB11;

LAB12:    if (*((unsigned int *)t15) != 0)
        goto LAB13;

LAB14:    t22 = (t9 + 4);
    t23 = *((unsigned int *)t9);
    t24 = (!(t23));
    t25 = *((unsigned int *)t22);
    t26 = (t24 || t25);
    if (t26 > 0)
        goto LAB15;

LAB16:    memcpy(t49, t9, 8);

LAB17:    t77 = (t49 + 4);
    t78 = *((unsigned int *)t77);
    t79 = (~(t78));
    t80 = *((unsigned int *)t49);
    t81 = (t80 & t79);
    t82 = (t81 != 0);
    if (t82 > 0)
        goto LAB30;

LAB31:
LAB32:    xsi_set_current_line(1651, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t8 = (t6 + 56U);
    t10 = *((char **)t8);
    t11 = (t2 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 6936);
    t14 = xsi_create_subprogram_invocation(t12, 0, t1, t13, 0, t2);
    t15 = (t1 + 32080);
    xsi_vlogvar_assign_value(t15, t10, 0, 0, 8);

LAB42:    t21 = (t2 + 64U);
    t22 = *((char **)t21);
    t27 = (t22 + 80U);
    t28 = *((char **)t27);
    t29 = (t28 + 272U);
    t30 = *((char **)t29);
    t31 = (t30 + 0U);
    t32 = *((char **)t31);
    t68 = ((int  (*)(char *, char *))t32)(t1, t22);
    if (t68 != 0)
        goto LAB44;

LAB43:    t22 = (t2 + 64U);
    t33 = *((char **)t22);
    t22 = (t1 + 31920);
    t34 = (t22 + 56U);
    t35 = *((char **)t34);
    memcpy(t7, t35, 8);
    t36 = (t1 + 6936);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    xsi_delete_subprogram_invocation(t36, t33, t1, t39, t2);
    t40 = (t1 + 1200);
    t42 = *((char **)t40);
    t40 = ((char*)((ng93)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t42, 32, t40, 32);
    memset(t37, 0, 8);
    xsi_vlog_signed_multiply(t37, 32, t7, 32, t9, 32);
    t48 = (t2 + 96U);
    t53 = *((char **)t48);
    t54 = (t53 + 480U);
    xsi_vlogvar_assign_value(t54, t37, 0, 0, 32);
    xsi_set_current_line(1653, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t8 = (t6 + 56U);
    t10 = *((char **)t8);
    t11 = (t2 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 480U);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t10, 32, t15, 32);
    t21 = ((char*)((ng83)));
    memset(t9, 0, 8);
    xsi_vlog_unsigned_minus(t9, 32, t7, 32, t21, 32);
    t22 = (t2 + 96U);
    t27 = *((char **)t22);
    t28 = (t27 + 640U);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    memset(t37, 0, 8);
    t31 = (t9 + 4);
    if (*((unsigned int *)t31) != 0)
        goto LAB46;

LAB45:    t32 = (t30 + 4);
    if (*((unsigned int *)t32) != 0)
        goto LAB46;

LAB49:    if (*((unsigned int *)t9) > *((unsigned int *)t30))
        goto LAB47;

LAB48:    t34 = (t37 + 4);
    t16 = *((unsigned int *)t34);
    t17 = (~(t16));
    t18 = *((unsigned int *)t37);
    t19 = (t18 & t17);
    t20 = (t19 != 0);
    if (t20 > 0)
        goto LAB50;

LAB51:    xsi_set_current_line(1661, ng52);

LAB62:    xsi_set_current_line(1662, ng52);
    t4 = (t1 + 27920);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = ((char*)((ng83)));
    memset(t7, 0, 8);
    t10 = (t6 + 4);
    t11 = (t8 + 4);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t23 = (t19 ^ t20);
    t24 = (t18 | t23);
    t25 = *((unsigned int *)t10);
    t26 = *((unsigned int *)t11);
    t43 = (t25 | t26);
    t44 = (~(t43));
    t45 = (t24 & t44);
    if (t45 != 0)
        goto LAB66;

LAB63:    if (t43 != 0)
        goto LAB65;

LAB64:    *((unsigned int *)t7) = 1;

LAB66:    t13 = (t7 + 4);
    t46 = *((unsigned int *)t13);
    t47 = (~(t46));
    t50 = *((unsigned int *)t7);
    t51 = (t50 & t47);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB67;

LAB68:
LAB69:
LAB52:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    t14 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t14) = 1;
    goto LAB9;

LAB8:    *((unsigned int *)t7) = 1;
    goto LAB9;

LAB11:    *((unsigned int *)t9) = 1;
    goto LAB14;

LAB13:    t21 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB14;

LAB15:    t27 = (t2 + 96U);
    t28 = *((char **)t27);
    t29 = (t28 + 0U);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 640U);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    memset(t37, 0, 8);
    t38 = (t31 + 4);
    if (*((unsigned int *)t38) != 0)
        goto LAB19;

LAB18:    t39 = (t36 + 4);
    if (*((unsigned int *)t39) != 0)
        goto LAB19;

LAB22:    if (*((unsigned int *)t31) > *((unsigned int *)t36))
        goto LAB20;

LAB21:    memset(t41, 0, 8);
    t42 = (t37 + 4);
    t43 = *((unsigned int *)t42);
    t44 = (~(t43));
    t45 = *((unsigned int *)t37);
    t46 = (t45 & t44);
    t47 = (t46 & 1U);
    if (t47 != 0)
        goto LAB23;

LAB24:    if (*((unsigned int *)t42) != 0)
        goto LAB25;

LAB26:    t50 = *((unsigned int *)t9);
    t51 = *((unsigned int *)t41);
    t52 = (t50 | t51);
    *((unsigned int *)t49) = t52;
    t53 = (t9 + 4);
    t54 = (t41 + 4);
    t55 = (t49 + 4);
    t56 = *((unsigned int *)t53);
    t57 = *((unsigned int *)t54);
    t58 = (t56 | t57);
    *((unsigned int *)t55) = t58;
    t59 = *((unsigned int *)t55);
    t60 = (t59 != 0);
    if (t60 == 1)
        goto LAB27;

LAB28:
LAB29:    goto LAB17;

LAB19:    t40 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB21;

LAB20:    *((unsigned int *)t37) = 1;
    goto LAB21;

LAB23:    *((unsigned int *)t41) = 1;
    goto LAB26;

LAB25:    t48 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t48) = 1;
    goto LAB26;

LAB27:    t61 = *((unsigned int *)t49);
    t62 = *((unsigned int *)t55);
    *((unsigned int *)t49) = (t61 | t62);
    t63 = (t9 + 4);
    t64 = (t41 + 4);
    t65 = *((unsigned int *)t63);
    t66 = (~(t65));
    t67 = *((unsigned int *)t9);
    t68 = (t67 & t66);
    t69 = *((unsigned int *)t64);
    t70 = (~(t69));
    t71 = *((unsigned int *)t41);
    t72 = (t71 & t70);
    t73 = (~(t68));
    t74 = (~(t72));
    t75 = *((unsigned int *)t55);
    *((unsigned int *)t55) = (t75 & t73);
    t76 = *((unsigned int *)t55);
    *((unsigned int *)t55) = (t76 & t74);
    goto LAB29;

LAB30:    xsi_set_current_line(1642, ng52);

LAB33:    xsi_set_current_line(1643, ng52);
    t84 = xsi_vlog_time(t83, 10000.000000000000, 1000.0000000000000);
    t85 = ((char*)((ng56)));
    t86 = (t2 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 0U);
    t89 = (t88 + 56U);
    t90 = *((char **)t89);
    t91 = ((char*)((ng66)));
    t92 = ((char*)((ng68)));
    t93 = (t2 + 96U);
    t94 = *((char **)t93);
    t95 = (t94 + 640U);
    t96 = (t95 + 56U);
    t97 = *((char **)t96);
    t98 = (t1 + 19896);
    xsi_vlogfile_write(1, 0, 0, ng178, 7, t98, (char)118, t83, 64, (char)118, t85, 56, (char)118, t90, 32, (char)118, t91, 32, (char)118, t92, 32, (char)118, t97, 32);
    xsi_set_current_line(1644, ng52);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = ((char*)((ng83)));
    memset(t7, 0, 8);
    t10 = (t6 + 4);
    t11 = (t8 + 4);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t23 = (t19 ^ t20);
    t24 = (t18 | t23);
    t25 = *((unsigned int *)t10);
    t26 = *((unsigned int *)t11);
    t43 = (t25 | t26);
    t44 = (~(t43));
    t45 = (t24 & t44);
    if (t45 != 0)
        goto LAB37;

LAB34:    if (t43 != 0)
        goto LAB36;

LAB35:    *((unsigned int *)t7) = 1;

LAB37:    t13 = (t7 + 4);
    t46 = *((unsigned int *)t13);
    t47 = (~(t46));
    t50 = *((unsigned int *)t7);
    t51 = (t50 & t47);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB38;

LAB39:
LAB40:    xsi_set_current_line(1648, ng52);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_signed_add(t7, 32, t6, 32, t8, 32);
    t10 = (t1 + 30800);
    xsi_vlogvar_assign_value(t10, t7, 0, 0, 32);
    goto LAB32;

LAB36:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB37;

LAB38:    xsi_set_current_line(1644, ng52);

LAB41:    xsi_set_current_line(1645, ng52);
    t14 = (t1 + 19896);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t14);
    xsi_set_current_line(1646, ng52);
    xsi_vlog_stop(1);
    goto LAB40;

LAB44:    t21 = (t2 + 48U);
    *((char **)t21) = &&LAB42;
    goto LAB1;

LAB46:    t33 = (t37 + 4);
    *((unsigned int *)t37) = 1;
    *((unsigned int *)t33) = 1;
    goto LAB48;

LAB47:    *((unsigned int *)t37) = 1;
    goto LAB48;

LAB50:    xsi_set_current_line(1653, ng52);

LAB53:    xsi_set_current_line(1654, ng52);
    t35 = xsi_vlog_time(t83, 10000.000000000000, 1000.0000000000000);
    t36 = ((char*)((ng56)));
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t42 = (t40 + 56U);
    t48 = *((char **)t42);
    t53 = (t2 + 96U);
    t54 = *((char **)t53);
    t55 = (t54 + 480U);
    t63 = (t55 + 56U);
    t64 = *((char **)t63);
    t77 = ((char*)((ng66)));
    t84 = ((char*)((ng68)));
    t85 = (t2 + 96U);
    t86 = *((char **)t85);
    t87 = (t86 + 640U);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    t90 = (t1 + 19896);
    xsi_vlogfile_write(1, 0, 0, ng179, 8, t90, (char)118, t83, 64, (char)118, t36, 56, (char)118, t48, 32, (char)119, t64, 32, (char)118, t77, 32, (char)118, t84, 32, (char)118, t89, 32);
    xsi_set_current_line(1655, ng52);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = ((char*)((ng83)));
    memset(t7, 0, 8);
    t10 = (t6 + 4);
    t11 = (t8 + 4);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t11);
    t23 = (t19 ^ t20);
    t24 = (t18 | t23);
    t25 = *((unsigned int *)t10);
    t26 = *((unsigned int *)t11);
    t43 = (t25 | t26);
    t44 = (~(t43));
    t45 = (t24 & t44);
    if (t45 != 0)
        goto LAB57;

LAB54:    if (t43 != 0)
        goto LAB56;

LAB55:    *((unsigned int *)t7) = 1;

LAB57:    t13 = (t7 + 4);
    t46 = *((unsigned int *)t13);
    t47 = (~(t46));
    t50 = *((unsigned int *)t7);
    t51 = (t50 & t47);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB58;

LAB59:
LAB60:    xsi_set_current_line(1659, ng52);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = ((char*)((ng83)));
    memset(t7, 0, 8);
    xsi_vlog_signed_add(t7, 32, t6, 32, t8, 32);
    t10 = (t1 + 30800);
    xsi_vlogvar_assign_value(t10, t7, 0, 0, 32);
    goto LAB52;

LAB56:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB57;

LAB58:    xsi_set_current_line(1655, ng52);

LAB61:    xsi_set_current_line(1656, ng52);
    t14 = (t1 + 19896);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t14);
    xsi_set_current_line(1657, ng52);
    xsi_vlog_stop(1);
    goto LAB60;

LAB65:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB66;

LAB67:    xsi_set_current_line(1662, ng52);

LAB70:    xsi_set_current_line(1663, ng52);
    t14 = xsi_vlog_time(t83, 10000.000000000000, 1000.0000000000000);
    t15 = ((char*)((ng56)));
    t21 = (t1 + 19896);
    xsi_vlogfile_write(1, 0, 0, ng180, 3, t21, (char)118, t83, 64, (char)118, t15, 56);
    goto LAB69;

}

static int sp_check_strobe(char *t1, char *t2)
{
    char t51[8];
    char t79[8];
    char t97[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    int t47;
    char *t48;
    char *t49;
    char *t50;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 20328);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1691, ng52);

LAB5:    xsi_set_current_line(1692, ng52);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 160U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t12 = (t11 + 320U);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t2 + 96U);
    t16 = *((char **)t15);
    t17 = (t16 + 480U);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t2 + 96U);
    t21 = *((char **)t20);
    t22 = (t21 + 640U);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t2 + 96U);
    t26 = *((char **)t25);
    t27 = (t26 + 800U);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t2 + 56U);
    t31 = *((char **)t30);
    t32 = (t1 + 7368);
    t33 = xsi_create_subprogram_invocation(t31, 0, t1, t32, 0, t2);
    t34 = (t1 + 32400);
    xsi_vlogvar_assign_value(t34, t9, 0, 0, 32);
    t35 = (t1 + 32560);
    xsi_vlogvar_assign_value(t35, t14, 0, 0, 32);
    t36 = (t1 + 32720);
    xsi_vlogvar_assign_value(t36, t19, 0, 0, 8);
    t37 = (t1 + 32880);
    xsi_vlogvar_assign_value(t37, t24, 0, 0, 3);
    t38 = (t1 + 33040);
    xsi_vlogvar_assign_value(t38, t29, 0, 0, 2);

LAB6:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t41 = (t40 + 80U);
    t42 = *((char **)t41);
    t43 = (t42 + 272U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    t46 = *((char **)t45);
    t47 = ((int  (*)(char *, char *))t46)(t1, t40);
    if (t47 != 0)
        goto LAB8;

LAB7:    t40 = (t2 + 64U);
    t48 = *((char **)t40);
    t40 = (t1 + 32240);
    t49 = (t40 + 56U);
    t50 = *((char **)t49);
    memcpy(t51, t50, 8);
    t52 = (t1 + 7368);
    t53 = (t2 + 56U);
    t54 = *((char **)t53);
    xsi_delete_subprogram_invocation(t52, t48, t1, t54, t2);
    t55 = (t2 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 960U);
    xsi_vlogvar_assign_value(t57, t51, 0, 0, 4);
    xsi_set_current_line(1693, ng52);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 96U);
    t10 = *((char **)t9);
    t11 = (t10 + 960U);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t58 = *((unsigned int *)t8);
    t59 = *((unsigned int *)t13);
    t60 = (t58 | t59);
    *((unsigned int *)t51) = t60;
    t14 = (t8 + 4);
    t15 = (t13 + 4);
    t16 = (t51 + 4);
    t61 = *((unsigned int *)t14);
    t62 = *((unsigned int *)t15);
    t63 = (t61 | t62);
    *((unsigned int *)t16) = t63;
    t64 = *((unsigned int *)t16);
    t65 = (t64 != 0);
    if (t65 == 1)
        goto LAB9;

LAB10:
LAB11:    t19 = (t2 + 96U);
    t20 = *((char **)t19);
    t21 = (t20 + 960U);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memset(t79, 0, 8);
    t24 = (t51 + 4);
    t25 = (t23 + 4);
    t80 = *((unsigned int *)t51);
    t81 = *((unsigned int *)t23);
    t82 = (t80 ^ t81);
    t83 = *((unsigned int *)t24);
    t84 = *((unsigned int *)t25);
    t85 = (t83 ^ t84);
    t86 = (t82 | t85);
    t87 = *((unsigned int *)t24);
    t88 = *((unsigned int *)t25);
    t89 = (t87 | t88);
    t90 = (~(t89));
    t91 = (t86 & t90);
    if (t91 != 0)
        goto LAB13;

LAB12:    if (t89 != 0)
        goto LAB14;

LAB15:    t27 = (t79 + 4);
    t92 = *((unsigned int *)t27);
    t93 = (~(t92));
    t94 = *((unsigned int *)t79);
    t95 = (t94 & t93);
    t96 = (t95 != 0);
    if (t96 > 0)
        goto LAB16;

LAB17:    xsi_set_current_line(1701, ng52);

LAB28:    xsi_set_current_line(1702, ng52);
    t4 = (t1 + 27920);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t51, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t58 = *((unsigned int *)t6);
    t59 = *((unsigned int *)t7);
    t60 = (t58 ^ t59);
    t61 = *((unsigned int *)t8);
    t62 = *((unsigned int *)t9);
    t63 = (t61 ^ t62);
    t64 = (t60 | t63);
    t65 = *((unsigned int *)t8);
    t66 = *((unsigned int *)t9);
    t67 = (t65 | t66);
    t68 = (~(t67));
    t69 = (t64 & t68);
    if (t69 != 0)
        goto LAB32;

LAB29:    if (t67 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t51) = 1;

LAB32:    t11 = (t51 + 4);
    t70 = *((unsigned int *)t11);
    t71 = (~(t70));
    t72 = *((unsigned int *)t51);
    t73 = (t72 & t71);
    t75 = (t73 != 0);
    if (t75 > 0)
        goto LAB33;

LAB34:
LAB35:
LAB18:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t39 = (t2 + 48U);
    *((char **)t39) = &&LAB6;
    goto LAB1;

LAB9:    t66 = *((unsigned int *)t51);
    t67 = *((unsigned int *)t16);
    *((unsigned int *)t51) = (t66 | t67);
    t17 = (t8 + 4);
    t18 = (t13 + 4);
    t68 = *((unsigned int *)t17);
    t69 = (~(t68));
    t70 = *((unsigned int *)t8);
    t47 = (t70 & t69);
    t71 = *((unsigned int *)t18);
    t72 = (~(t71));
    t73 = *((unsigned int *)t13);
    t74 = (t73 & t72);
    t75 = (~(t47));
    t76 = (~(t74));
    t77 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t77 & t75);
    t78 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t78 & t76);
    goto LAB11;

LAB13:    *((unsigned int *)t79) = 1;
    goto LAB15;

LAB14:    t26 = (t79 + 4);
    *((unsigned int *)t79) = 1;
    *((unsigned int *)t26) = 1;
    goto LAB15;

LAB16:    xsi_set_current_line(1693, ng52);

LAB19:    xsi_set_current_line(1694, ng52);
    t28 = xsi_vlog_time(t97, 10000.000000000000, 1000.0000000000000);
    t29 = ((char*)((ng56)));
    t30 = (t2 + 96U);
    t31 = *((char **)t30);
    t32 = (t31 + 0U);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 960U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 20328);
    xsi_vlogfile_write(1, 0, 0, ng181, 5, t40, (char)118, t97, 64, (char)118, t29, 56, (char)118, t34, 4, (char)118, t39, 4);
    xsi_set_current_line(1695, ng52);
    t4 = (t1 + 27760);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t51, 0, 8);
    t8 = (t6 + 4);
    t9 = (t7 + 4);
    t58 = *((unsigned int *)t6);
    t59 = *((unsigned int *)t7);
    t60 = (t58 ^ t59);
    t61 = *((unsigned int *)t8);
    t62 = *((unsigned int *)t9);
    t63 = (t61 ^ t62);
    t64 = (t60 | t63);
    t65 = *((unsigned int *)t8);
    t66 = *((unsigned int *)t9);
    t67 = (t65 | t66);
    t68 = (~(t67));
    t69 = (t64 & t68);
    if (t69 != 0)
        goto LAB23;

LAB20:    if (t67 != 0)
        goto LAB22;

LAB21:    *((unsigned int *)t51) = 1;

LAB23:    t11 = (t51 + 4);
    t70 = *((unsigned int *)t11);
    t71 = (~(t70));
    t72 = *((unsigned int *)t51);
    t73 = (t72 & t71);
    t75 = (t73 != 0);
    if (t75 > 0)
        goto LAB24;

LAB25:
LAB26:    xsi_set_current_line(1699, ng52);
    t4 = (t1 + 30800);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng83)));
    memset(t51, 0, 8);
    xsi_vlog_signed_add(t51, 32, t6, 32, t7, 32);
    t8 = (t1 + 30800);
    xsi_vlogvar_assign_value(t8, t51, 0, 0, 32);
    goto LAB18;

LAB22:    t10 = (t51 + 4);
    *((unsigned int *)t51) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB23;

LAB24:    xsi_set_current_line(1695, ng52);

LAB27:    xsi_set_current_line(1696, ng52);
    t12 = (t1 + 20328);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t12);
    xsi_set_current_line(1697, ng52);
    xsi_vlog_stop(1);
    goto LAB26;

LAB31:    t10 = (t51 + 4);
    *((unsigned int *)t51) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB32;

LAB33:    xsi_set_current_line(1702, ng52);

LAB36:    xsi_set_current_line(1703, ng52);
    t12 = xsi_vlog_time(t97, 10000.000000000000, 1000.0000000000000);
    t13 = ((char*)((ng56)));
    t14 = (t1 + 20328);
    xsi_vlogfile_write(1, 0, 0, ng182, 3, t14, (char)118, t97, 64, (char)118, t13, 56);
    goto LAB35;

}

static void Cont_152_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t18;
    double t19;
    double t20;
    char *t21;

LAB0:    t1 = (t0 + 41952U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(152, ng52);
    t2 = (t0 + 20960U);
    t3 = *((char **)t2);
    t2 = (t0 + 44472);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 1U;
    t9 = t8;
    t10 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    t16 = (t0 + 26640);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = xsi_vlog_convert_to_real(t18, 32, 1);
    t19 = (t19 * 1000.0000000000000);
    t20 = (t19 < 0.0000000000000000);
    if (t20 == 1)
        goto LAB4;

LAB5:    t19 = (t19 + 0.50000000000000000);
    t19 = ((int64)(t19));

LAB6:    t19 = (t19 * 10.000000000000000);
    xsi_driver_vfirst_trans_delayed(t2, 0, 0, t19, 0);
    t21 = (t0 + 44008);
    *((int *)t21) = 1;

LAB1:    return;
LAB4:    t19 = 0.0000000000000000;
    goto LAB6;

}

static void Initial_157_1(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(157, ng52);

LAB2:    xsi_set_current_line(158, ng52);
    t1 = ((char*)((ng97)));
    t2 = (t0 + 30480);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(159, ng52);
    t1 = ((char*)((ng97)));
    t2 = (t0 + 30640);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(160, ng52);
    t1 = ((char*)((ng104)));
    t2 = (t0 + 30800);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    xsi_set_current_line(161, ng52);
    t1 = ((char*)((ng104)));
    t2 = (t0 + 30960);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    xsi_set_current_line(162, ng52);
    t1 = ((char*)((ng104)));
    t2 = (t0 + 31120);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    xsi_set_current_line(163, ng52);
    t1 = ((char*)((ng97)));
    t2 = (t0 + 31280);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Initial_169_2(char *t0)
{
    char t3[8];
    char t5[8];
    char t28[8];
    char *t1;
    char *t2;
    char *t4;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    int t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    t1 = (t0 + 42448U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(169, ng52);

LAB4:    xsi_set_current_line(170, ng52);
    *((int *)t3) = xsi_xilinx_lic_check(ng183, 2010.0999999999999);
    t2 = (t3 + 4);
    *((int *)t2) = 0;
    t4 = ((char*)((ng104)));
    memset(t5, 0, 8);
    t6 = (t3 + 4);
    t7 = (t4 + 4);
    t8 = *((unsigned int *)t3);
    t9 = *((unsigned int *)t4);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = (t10 | t13);
    t15 = *((unsigned int *)t6);
    t16 = *((unsigned int *)t7);
    t17 = (t15 | t16);
    t18 = (~(t17));
    t19 = (t14 & t18);
    if (t19 != 0)
        goto LAB6;

LAB5:    if (t17 != 0)
        goto LAB7;

LAB8:    t21 = (t5 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t5);
    t25 = (t24 & t23);
    t26 = (t25 != 0);
    if (t26 > 0)
        goto LAB9;

LAB10:    xsi_set_current_line(176, ng52);

LAB13:    xsi_set_current_line(177, ng52);
    t2 = ((char*)((ng185)));
    *((double *)t3) = 2010.0999999999999;
    xsi_vlogfile_write(1, 0, 0, ng186, 3, t0, (char)118, t2, 112, (char)114, t3, 64);
    xsi_set_current_line(179, ng52);
    xsi_vlog_finish(1);

LAB11:    xsi_set_current_line(181, ng52);
    xsi_vlogfile_write(1, 0, 0, ng53, 1, t0);
    xsi_set_current_line(182, ng52);
    xsi_vlogfile_write(1, 0, 0, ng187, 1, t0);
    xsi_set_current_line(183, ng52);
    xsi_vlogfile_write(1, 0, 0, ng53, 1, t0);
    xsi_set_current_line(184, ng52);
    xsi_vlogfile_write(0, 0, 0, ng188, 1, t0);
    xsi_vlogfile_write(1, 0, 0, ng189, 1, t0);
    xsi_set_current_line(185, ng52);
    t2 = (t0 + 42256);
    t4 = (t0 + 3480);
    t6 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t6);

LAB16:    t7 = (t0 + 42352);
    t20 = *((char **)t7);
    t21 = (t20 + 80U);
    t27 = *((char **)t21);
    t29 = (t27 + 272U);
    t30 = *((char **)t29);
    t31 = (t30 + 0U);
    t32 = *((char **)t31);
    t33 = ((int  (*)(char *, char *))t32)(t0, t20);

LAB18:    if (t33 != 0)
        goto LAB19;

LAB14:    t20 = (t0 + 3480);
    xsi_vlog_subprogram_popinvocation(t20);

LAB15:    t34 = (t0 + 42352);
    t35 = *((char **)t34);
    t34 = (t0 + 3480);
    t36 = (t0 + 42256);
    t37 = 0;
    xsi_delete_subprogram_invocation(t34, t35, t0, t36, t37);

LAB1:    return;
LAB6:    *((unsigned int *)t5) = 1;
    goto LAB8;

LAB7:    t20 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB8;

LAB9:    xsi_set_current_line(171, ng52);

LAB12:    xsi_set_current_line(172, ng52);
    t27 = ((char*)((ng185)));
    *((double *)t28) = 2010.0999999999999;
    xsi_vlogfile_write(1, 0, 0, ng184, 3, t0, (char)118, t27, 112, (char)114, t28, 64);
    goto LAB11;

LAB17:;
LAB19:    t7 = (t0 + 42448U);
    *((char **)t7) = &&LAB16;
    goto LAB1;

}

static void Always_242_3(char *t0)
{
    char t4[8];
    char t23[8];
    char t45[16];
    char t48[8];
    char t49[8];
    char t50[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    char *t46;
    char *t47;
    unsigned int t51;
    char *t52;
    char *t53;
    char *t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    char *t62;
    char *t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    int t72;
    int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    char *t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    char *t86;
    char *t87;

LAB0:    t1 = (t0 + 42696U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(242, ng52);
    t2 = (t0 + 44056);
    *((int *)t2) = 1;
    t3 = (t0 + 42728);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(242, ng52);

LAB5:    xsi_set_current_line(243, ng52);
    t5 = (t0 + 21120U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t5) == 0)
        goto LAB6;

LAB8:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB9:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(316, ng52);

LAB138:    xsi_set_current_line(317, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 31280);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(243, ng52);

LAB13:    xsi_set_current_line(247, ng52);
    t19 = (t0 + 31280);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = ((char*)((ng104)));
    memset(t23, 0, 8);
    t24 = (t21 + 4);
    t25 = (t22 + 4);
    t26 = *((unsigned int *)t21);
    t27 = *((unsigned int *)t22);
    t28 = (t26 ^ t27);
    t29 = *((unsigned int *)t24);
    t30 = *((unsigned int *)t25);
    t31 = (t29 ^ t30);
    t32 = (t28 | t31);
    t33 = *((unsigned int *)t24);
    t34 = *((unsigned int *)t25);
    t35 = (t33 | t34);
    t36 = (~(t35));
    t37 = (t32 & t36);
    if (t37 != 0)
        goto LAB17;

LAB14:    if (t35 != 0)
        goto LAB16;

LAB15:    *((unsigned int *)t23) = 1;

LAB17:    t39 = (t23 + 4);
    t40 = *((unsigned int *)t39);
    t41 = (~(t40));
    t42 = *((unsigned int *)t23);
    t43 = (t42 & t41);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB18;

LAB19:
LAB20:    xsi_set_current_line(256, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 28400);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(258, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 28560);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(260, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 28720);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(261, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 28880);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    xsi_set_current_line(262, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29040);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(263, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29200);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(266, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29360);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(269, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29520);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(270, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29680);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(271, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29840);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 2, 0LL);
    xsi_set_current_line(272, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 30000);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(273, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 30160);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(274, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 30320);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(281, ng52);
    t2 = (t0 + 44072);
    *((int *)t2) = 1;
    t3 = (t0 + 42728);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB22;
    goto LAB1;

LAB16:    t38 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t38) = 1;
    goto LAB17;

LAB18:    xsi_set_current_line(247, ng52);

LAB21:    xsi_set_current_line(248, ng52);
    t46 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t47 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng190, 3, t0, (char)118, t45, 64, (char)118, t47, 56);
    goto LAB20;

LAB22:    xsi_set_current_line(283, ng52);
    t2 = (t0 + 26080U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng104)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB24;

LAB23:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB24;

LAB25:    memset(t23, 0, 8);
    t12 = (t4 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB26;

LAB27:    if (*((unsigned int *)t12) != 0)
        goto LAB28;

LAB29:    t19 = (t23 + 4);
    t14 = *((unsigned int *)t23);
    t15 = *((unsigned int *)t19);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB30;

LAB31:    memcpy(t50, t23, 8);

LAB32:    t80 = (t50 + 4);
    t81 = *((unsigned int *)t80);
    t82 = (~(t81));
    t83 = *((unsigned int *)t50);
    t84 = (t83 & t82);
    t85 = (t84 != 0);
    if (t85 > 0)
        goto LAB44;

LAB45:
LAB46:    xsi_set_current_line(292, ng52);
    t2 = (t0 + 23200U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng104)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB57;

LAB56:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB57;

LAB58:    memset(t23, 0, 8);
    t12 = (t4 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB59;

LAB60:    if (*((unsigned int *)t12) != 0)
        goto LAB61;

LAB62:    t19 = (t23 + 4);
    t14 = *((unsigned int *)t23);
    t15 = *((unsigned int *)t19);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB63;

LAB64:    memcpy(t50, t23, 8);

LAB65:    t80 = (t50 + 4);
    t81 = *((unsigned int *)t80);
    t82 = (~(t81));
    t83 = *((unsigned int *)t50);
    t84 = (t83 & t82);
    t85 = (t84 != 0);
    if (t85 > 0)
        goto LAB77;

LAB78:
LAB79:    xsi_set_current_line(301, ng52);
    t2 = (t0 + 24000U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng104)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB90;

LAB89:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB90;

LAB91:    memset(t23, 0, 8);
    t12 = (t4 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB92;

LAB93:    if (*((unsigned int *)t12) != 0)
        goto LAB94;

LAB95:    t19 = (t23 + 4);
    t14 = *((unsigned int *)t23);
    t15 = *((unsigned int *)t19);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB96;

LAB97:    memcpy(t50, t23, 8);

LAB98:    t80 = (t50 + 4);
    t81 = *((unsigned int *)t80);
    t82 = (~(t81));
    t83 = *((unsigned int *)t50);
    t84 = (t83 & t82);
    t85 = (t84 != 0);
    if (t85 > 0)
        goto LAB110;

LAB111:
LAB112:    xsi_set_current_line(309, ng52);
    t2 = (t0 + 27600);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng104)));
    memset(t4, 0, 8);
    t12 = (t5 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = *((unsigned int *)t6);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t18 = (t16 | t17);
    t26 = (~(t18));
    t27 = (t15 & t26);
    if (t27 != 0)
        goto LAB125;

LAB122:    if (t18 != 0)
        goto LAB124;

LAB123:    *((unsigned int *)t4) = 1;

LAB125:    t20 = (t4 + 4);
    t28 = *((unsigned int *)t20);
    t29 = (~(t28));
    t30 = *((unsigned int *)t4);
    t31 = (t30 & t29);
    t32 = (t31 != 0);
    if (t32 > 0)
        goto LAB126;

LAB127:
LAB128:    xsi_set_current_line(314, ng52);
    t2 = ((char*)((ng83)));
    t3 = (t0 + 31280);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB12;

LAB24:    *((unsigned int *)t4) = 1;
    goto LAB25;

LAB26:    *((unsigned int *)t23) = 1;
    goto LAB29;

LAB28:    t13 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB29;

LAB30:    t20 = (t0 + 27600);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t24 = ((char*)((ng104)));
    memset(t48, 0, 8);
    t25 = (t22 + 4);
    t38 = (t24 + 4);
    t17 = *((unsigned int *)t22);
    t18 = *((unsigned int *)t24);
    t26 = (t17 ^ t18);
    t27 = *((unsigned int *)t25);
    t28 = *((unsigned int *)t38);
    t29 = (t27 ^ t28);
    t30 = (t26 | t29);
    t31 = *((unsigned int *)t25);
    t32 = *((unsigned int *)t38);
    t33 = (t31 | t32);
    t34 = (~(t33));
    t35 = (t30 & t34);
    if (t35 != 0)
        goto LAB36;

LAB33:    if (t33 != 0)
        goto LAB35;

LAB34:    *((unsigned int *)t48) = 1;

LAB36:    memset(t49, 0, 8);
    t46 = (t48 + 4);
    t36 = *((unsigned int *)t46);
    t37 = (~(t36));
    t40 = *((unsigned int *)t48);
    t41 = (t40 & t37);
    t42 = (t41 & 1U);
    if (t42 != 0)
        goto LAB37;

LAB38:    if (*((unsigned int *)t46) != 0)
        goto LAB39;

LAB40:    t43 = *((unsigned int *)t23);
    t44 = *((unsigned int *)t49);
    t51 = (t43 & t44);
    *((unsigned int *)t50) = t51;
    t52 = (t23 + 4);
    t53 = (t49 + 4);
    t54 = (t50 + 4);
    t55 = *((unsigned int *)t52);
    t56 = *((unsigned int *)t53);
    t57 = (t55 | t56);
    *((unsigned int *)t54) = t57;
    t58 = *((unsigned int *)t54);
    t59 = (t58 != 0);
    if (t59 == 1)
        goto LAB41;

LAB42:
LAB43:    goto LAB32;

LAB35:    t39 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB36;

LAB37:    *((unsigned int *)t49) = 1;
    goto LAB40;

LAB39:    t47 = (t49 + 4);
    *((unsigned int *)t49) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB40;

LAB41:    t60 = *((unsigned int *)t50);
    t61 = *((unsigned int *)t54);
    *((unsigned int *)t50) = (t60 | t61);
    t62 = (t23 + 4);
    t63 = (t49 + 4);
    t64 = *((unsigned int *)t23);
    t65 = (~(t64));
    t66 = *((unsigned int *)t62);
    t67 = (~(t66));
    t68 = *((unsigned int *)t49);
    t69 = (~(t68));
    t70 = *((unsigned int *)t63);
    t71 = (~(t70));
    t72 = (t65 & t67);
    t73 = (t69 & t71);
    t74 = (~(t72));
    t75 = (~(t73));
    t76 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t76 & t74);
    t77 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t77 & t75);
    t78 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t78 & t74);
    t79 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t79 & t75);
    goto LAB43;

LAB44:    xsi_set_current_line(283, ng52);

LAB47:    xsi_set_current_line(284, ng52);
    t86 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t87 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng191, 3, t0, (char)118, t45, 64, (char)118, t87, 56);
    xsi_set_current_line(285, ng52);
    t2 = (t0 + 27760);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng83)));
    memset(t4, 0, 8);
    t12 = (t5 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = *((unsigned int *)t6);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t18 = (t16 | t17);
    t26 = (~(t18));
    t27 = (t15 & t26);
    if (t27 != 0)
        goto LAB51;

LAB48:    if (t18 != 0)
        goto LAB50;

LAB49:    *((unsigned int *)t4) = 1;

LAB51:    t20 = (t4 + 4);
    t28 = *((unsigned int *)t20);
    t29 = (~(t28));
    t30 = *((unsigned int *)t4);
    t31 = (t30 & t29);
    t32 = (t31 != 0);
    if (t32 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(289, ng52);
    t2 = (t0 + 30800);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng83)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 30800);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB46;

LAB50:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(285, ng52);

LAB55:    xsi_set_current_line(286, ng52);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t0);
    xsi_set_current_line(287, ng52);
    xsi_vlog_stop(1);
    goto LAB54;

LAB57:    *((unsigned int *)t4) = 1;
    goto LAB58;

LAB59:    *((unsigned int *)t23) = 1;
    goto LAB62;

LAB61:    t13 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB62;

LAB63:    t20 = (t0 + 27600);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t24 = ((char*)((ng104)));
    memset(t48, 0, 8);
    t25 = (t22 + 4);
    t38 = (t24 + 4);
    t17 = *((unsigned int *)t22);
    t18 = *((unsigned int *)t24);
    t26 = (t17 ^ t18);
    t27 = *((unsigned int *)t25);
    t28 = *((unsigned int *)t38);
    t29 = (t27 ^ t28);
    t30 = (t26 | t29);
    t31 = *((unsigned int *)t25);
    t32 = *((unsigned int *)t38);
    t33 = (t31 | t32);
    t34 = (~(t33));
    t35 = (t30 & t34);
    if (t35 != 0)
        goto LAB69;

LAB66:    if (t33 != 0)
        goto LAB68;

LAB67:    *((unsigned int *)t48) = 1;

LAB69:    memset(t49, 0, 8);
    t46 = (t48 + 4);
    t36 = *((unsigned int *)t46);
    t37 = (~(t36));
    t40 = *((unsigned int *)t48);
    t41 = (t40 & t37);
    t42 = (t41 & 1U);
    if (t42 != 0)
        goto LAB70;

LAB71:    if (*((unsigned int *)t46) != 0)
        goto LAB72;

LAB73:    t43 = *((unsigned int *)t23);
    t44 = *((unsigned int *)t49);
    t51 = (t43 & t44);
    *((unsigned int *)t50) = t51;
    t52 = (t23 + 4);
    t53 = (t49 + 4);
    t54 = (t50 + 4);
    t55 = *((unsigned int *)t52);
    t56 = *((unsigned int *)t53);
    t57 = (t55 | t56);
    *((unsigned int *)t54) = t57;
    t58 = *((unsigned int *)t54);
    t59 = (t58 != 0);
    if (t59 == 1)
        goto LAB74;

LAB75:
LAB76:    goto LAB65;

LAB68:    t39 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB69;

LAB70:    *((unsigned int *)t49) = 1;
    goto LAB73;

LAB72:    t47 = (t49 + 4);
    *((unsigned int *)t49) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB73;

LAB74:    t60 = *((unsigned int *)t50);
    t61 = *((unsigned int *)t54);
    *((unsigned int *)t50) = (t60 | t61);
    t62 = (t23 + 4);
    t63 = (t49 + 4);
    t64 = *((unsigned int *)t23);
    t65 = (~(t64));
    t66 = *((unsigned int *)t62);
    t67 = (~(t66));
    t68 = *((unsigned int *)t49);
    t69 = (~(t68));
    t70 = *((unsigned int *)t63);
    t71 = (~(t70));
    t72 = (t65 & t67);
    t73 = (t69 & t71);
    t74 = (~(t72));
    t75 = (~(t73));
    t76 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t76 & t74);
    t77 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t77 & t75);
    t78 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t78 & t74);
    t79 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t79 & t75);
    goto LAB76;

LAB77:    xsi_set_current_line(292, ng52);

LAB80:    xsi_set_current_line(293, ng52);
    t86 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t87 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng192, 3, t0, (char)118, t45, 64, (char)118, t87, 56);
    xsi_set_current_line(294, ng52);
    t2 = (t0 + 27760);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng83)));
    memset(t4, 0, 8);
    t12 = (t5 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = *((unsigned int *)t6);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t18 = (t16 | t17);
    t26 = (~(t18));
    t27 = (t15 & t26);
    if (t27 != 0)
        goto LAB84;

LAB81:    if (t18 != 0)
        goto LAB83;

LAB82:    *((unsigned int *)t4) = 1;

LAB84:    t20 = (t4 + 4);
    t28 = *((unsigned int *)t20);
    t29 = (~(t28));
    t30 = *((unsigned int *)t4);
    t31 = (t30 & t29);
    t32 = (t31 != 0);
    if (t32 > 0)
        goto LAB85;

LAB86:
LAB87:    xsi_set_current_line(298, ng52);
    t2 = (t0 + 30800);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng83)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 30800);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB79;

LAB83:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB84;

LAB85:    xsi_set_current_line(294, ng52);

LAB88:    xsi_set_current_line(295, ng52);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t0);
    xsi_set_current_line(296, ng52);
    xsi_vlog_stop(1);
    goto LAB87;

LAB90:    *((unsigned int *)t4) = 1;
    goto LAB91;

LAB92:    *((unsigned int *)t23) = 1;
    goto LAB95;

LAB94:    t13 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB95;

LAB96:    t20 = (t0 + 27600);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t24 = ((char*)((ng104)));
    memset(t48, 0, 8);
    t25 = (t22 + 4);
    t38 = (t24 + 4);
    t17 = *((unsigned int *)t22);
    t18 = *((unsigned int *)t24);
    t26 = (t17 ^ t18);
    t27 = *((unsigned int *)t25);
    t28 = *((unsigned int *)t38);
    t29 = (t27 ^ t28);
    t30 = (t26 | t29);
    t31 = *((unsigned int *)t25);
    t32 = *((unsigned int *)t38);
    t33 = (t31 | t32);
    t34 = (~(t33));
    t35 = (t30 & t34);
    if (t35 != 0)
        goto LAB102;

LAB99:    if (t33 != 0)
        goto LAB101;

LAB100:    *((unsigned int *)t48) = 1;

LAB102:    memset(t49, 0, 8);
    t46 = (t48 + 4);
    t36 = *((unsigned int *)t46);
    t37 = (~(t36));
    t40 = *((unsigned int *)t48);
    t41 = (t40 & t37);
    t42 = (t41 & 1U);
    if (t42 != 0)
        goto LAB103;

LAB104:    if (*((unsigned int *)t46) != 0)
        goto LAB105;

LAB106:    t43 = *((unsigned int *)t23);
    t44 = *((unsigned int *)t49);
    t51 = (t43 & t44);
    *((unsigned int *)t50) = t51;
    t52 = (t23 + 4);
    t53 = (t49 + 4);
    t54 = (t50 + 4);
    t55 = *((unsigned int *)t52);
    t56 = *((unsigned int *)t53);
    t57 = (t55 | t56);
    *((unsigned int *)t54) = t57;
    t58 = *((unsigned int *)t54);
    t59 = (t58 != 0);
    if (t59 == 1)
        goto LAB107;

LAB108:
LAB109:    goto LAB98;

LAB101:    t39 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB102;

LAB103:    *((unsigned int *)t49) = 1;
    goto LAB106;

LAB105:    t47 = (t49 + 4);
    *((unsigned int *)t49) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB106;

LAB107:    t60 = *((unsigned int *)t50);
    t61 = *((unsigned int *)t54);
    *((unsigned int *)t50) = (t60 | t61);
    t62 = (t23 + 4);
    t63 = (t49 + 4);
    t64 = *((unsigned int *)t23);
    t65 = (~(t64));
    t66 = *((unsigned int *)t62);
    t67 = (~(t66));
    t68 = *((unsigned int *)t49);
    t69 = (~(t68));
    t70 = *((unsigned int *)t63);
    t71 = (~(t70));
    t72 = (t65 & t67);
    t73 = (t69 & t71);
    t74 = (~(t72));
    t75 = (~(t73));
    t76 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t76 & t74);
    t77 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t77 & t75);
    t78 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t78 & t74);
    t79 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t79 & t75);
    goto LAB109;

LAB110:    xsi_set_current_line(301, ng52);

LAB113:    xsi_set_current_line(302, ng52);
    t86 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t87 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng193, 3, t0, (char)118, t45, 64, (char)118, t87, 56);
    xsi_set_current_line(303, ng52);
    t2 = (t0 + 27760);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng83)));
    memset(t4, 0, 8);
    t12 = (t5 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = *((unsigned int *)t6);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t18 = (t16 | t17);
    t26 = (~(t18));
    t27 = (t15 & t26);
    if (t27 != 0)
        goto LAB117;

LAB114:    if (t18 != 0)
        goto LAB116;

LAB115:    *((unsigned int *)t4) = 1;

LAB117:    t20 = (t4 + 4);
    t28 = *((unsigned int *)t20);
    t29 = (~(t28));
    t30 = *((unsigned int *)t4);
    t31 = (t30 & t29);
    t32 = (t31 != 0);
    if (t32 > 0)
        goto LAB118;

LAB119:
LAB120:    xsi_set_current_line(307, ng52);
    t2 = (t0 + 30800);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng83)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 30800);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB112;

LAB116:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB117;

LAB118:    xsi_set_current_line(303, ng52);

LAB121:    xsi_set_current_line(304, ng52);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t0);
    xsi_set_current_line(305, ng52);
    xsi_vlog_stop(1);
    goto LAB120;

LAB124:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB125;

LAB126:    xsi_set_current_line(309, ng52);

LAB129:    xsi_set_current_line(310, ng52);
    t21 = (t0 + 31280);
    t22 = (t21 + 56U);
    t24 = *((char **)t22);
    t25 = ((char*)((ng104)));
    memset(t23, 0, 8);
    t38 = (t24 + 4);
    t39 = (t25 + 4);
    t33 = *((unsigned int *)t24);
    t34 = *((unsigned int *)t25);
    t35 = (t33 ^ t34);
    t36 = *((unsigned int *)t38);
    t37 = *((unsigned int *)t39);
    t40 = (t36 ^ t37);
    t41 = (t35 | t40);
    t42 = *((unsigned int *)t38);
    t43 = *((unsigned int *)t39);
    t44 = (t42 | t43);
    t51 = (~(t44));
    t55 = (t41 & t51);
    if (t55 != 0)
        goto LAB133;

LAB130:    if (t44 != 0)
        goto LAB132;

LAB131:    *((unsigned int *)t23) = 1;

LAB133:    t47 = (t23 + 4);
    t56 = *((unsigned int *)t47);
    t57 = (~(t56));
    t58 = *((unsigned int *)t23);
    t59 = (t58 & t57);
    t60 = (t59 != 0);
    if (t60 > 0)
        goto LAB134;

LAB135:
LAB136:    goto LAB128;

LAB132:    t46 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB133;

LAB134:    xsi_set_current_line(310, ng52);

LAB137:    xsi_set_current_line(311, ng52);
    t52 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t53 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng194, 3, t0, (char)118, t45, 64, (char)118, t53, 56);
    goto LAB136;

}

static void Always_328_4(char *t0)
{
    char t6[8];
    char t9[8];
    char t21[8];
    char t24[8];
    char t40[8];
    char t48[8];
    char t86[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t22;
    char *t23;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    char *t53;
    char *t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    char *t62;
    char *t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    int t72;
    int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    char *t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    char *t87;
    char *t88;

LAB0:    t1 = (t0 + 42944U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(328, ng52);
    t2 = (t0 + 44088);
    *((int *)t2) = 1;
    t3 = (t0 + 42976);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(328, ng52);

LAB5:    xsi_set_current_line(329, ng52);
    t4 = (t0 + 20960U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng104)));
    memset(t6, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB8;

LAB6:    t7 = (t5 + 4);
    t8 = (t4 + 4);
    if (*((unsigned int *)t7) != *((unsigned int *)t8))
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB8:    memset(t9, 0, 8);
    t10 = (t6 + 4);
    t11 = *((unsigned int *)t10);
    t12 = (~(t11));
    t13 = *((unsigned int *)t6);
    t14 = (t13 & t12);
    t15 = (t14 & 1U);
    if (t15 != 0)
        goto LAB9;

LAB10:    if (*((unsigned int *)t10) != 0)
        goto LAB11;

LAB12:    t17 = (t9 + 4);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t17);
    t20 = (t18 || t19);
    if (t20 > 0)
        goto LAB13;

LAB14:    memcpy(t48, t9, 8);

LAB15:    t80 = (t48 + 4);
    t81 = *((unsigned int *)t80);
    t82 = (~(t81));
    t83 = *((unsigned int *)t48);
    t84 = (t83 & t82);
    t85 = (t84 != 0);
    if (t85 > 0)
        goto LAB27;

LAB28:
LAB29:    goto LAB2;

LAB9:    *((unsigned int *)t9) = 1;
    goto LAB12;

LAB11:    t16 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t16) = 1;
    goto LAB12;

LAB13:    *((int *)t21) = xsi_vlog_stime(10000.000000000000, 1000.0000000000000);
    t22 = (t21 + 4);
    *((int *)t22) = 0;
    t23 = ((char*)((ng104)));
    memset(t24, 0, 8);
    t25 = (t21 + 4);
    t26 = (t23 + 4);
    t27 = *((unsigned int *)t21);
    t28 = *((unsigned int *)t23);
    t29 = (t27 ^ t28);
    t30 = *((unsigned int *)t25);
    t31 = *((unsigned int *)t26);
    t32 = (t30 ^ t31);
    t33 = (t29 | t32);
    t34 = *((unsigned int *)t25);
    t35 = *((unsigned int *)t26);
    t36 = (t34 | t35);
    t37 = (~(t36));
    t38 = (t33 & t37);
    if (t38 != 0)
        goto LAB17;

LAB16:    if (t36 != 0)
        goto LAB18;

LAB19:    memset(t40, 0, 8);
    t41 = (t24 + 4);
    t42 = *((unsigned int *)t41);
    t43 = (~(t42));
    t44 = *((unsigned int *)t24);
    t45 = (t44 & t43);
    t46 = (t45 & 1U);
    if (t46 != 0)
        goto LAB20;

LAB21:    if (*((unsigned int *)t41) != 0)
        goto LAB22;

LAB23:    t49 = *((unsigned int *)t9);
    t50 = *((unsigned int *)t40);
    t51 = (t49 & t50);
    *((unsigned int *)t48) = t51;
    t52 = (t9 + 4);
    t53 = (t40 + 4);
    t54 = (t48 + 4);
    t55 = *((unsigned int *)t52);
    t56 = *((unsigned int *)t53);
    t57 = (t55 | t56);
    *((unsigned int *)t54) = t57;
    t58 = *((unsigned int *)t54);
    t59 = (t58 != 0);
    if (t59 == 1)
        goto LAB24;

LAB25:
LAB26:    goto LAB15;

LAB17:    *((unsigned int *)t24) = 1;
    goto LAB19;

LAB18:    t39 = (t24 + 4);
    *((unsigned int *)t24) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB19;

LAB20:    *((unsigned int *)t40) = 1;
    goto LAB23;

LAB22:    t47 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB23;

LAB24:    t60 = *((unsigned int *)t48);
    t61 = *((unsigned int *)t54);
    *((unsigned int *)t48) = (t60 | t61);
    t62 = (t9 + 4);
    t63 = (t40 + 4);
    t64 = *((unsigned int *)t9);
    t65 = (~(t64));
    t66 = *((unsigned int *)t62);
    t67 = (~(t66));
    t68 = *((unsigned int *)t40);
    t69 = (~(t68));
    t70 = *((unsigned int *)t63);
    t71 = (~(t70));
    t72 = (t65 & t67);
    t73 = (t69 & t71);
    t74 = (~(t72));
    t75 = (~(t73));
    t76 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t76 & t74);
    t77 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t77 & t75);
    t78 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t78 & t74);
    t79 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t79 & t75);
    goto LAB26;

LAB27:    xsi_set_current_line(329, ng52);

LAB30:    xsi_set_current_line(330, ng52);
    t87 = xsi_vlog_time(t86, 10000.000000000000, 1000.0000000000000);
    t88 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng195, 3, t0, (char)118, t86, 64, (char)118, t88, 56);
    xsi_set_current_line(331, ng52);
    t2 = (t0 + 27760);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng83)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t5);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t7);
    t15 = *((unsigned int *)t8);
    t18 = (t14 ^ t15);
    t19 = (t13 | t18);
    t20 = *((unsigned int *)t7);
    t27 = *((unsigned int *)t8);
    t28 = (t20 | t27);
    t29 = (~(t28));
    t30 = (t19 & t29);
    if (t30 != 0)
        goto LAB34;

LAB31:    if (t28 != 0)
        goto LAB33;

LAB32:    *((unsigned int *)t6) = 1;

LAB34:    t16 = (t6 + 4);
    t31 = *((unsigned int *)t16);
    t32 = (~(t31));
    t33 = *((unsigned int *)t6);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB35;

LAB36:
LAB37:    xsi_set_current_line(335, ng52);
    t2 = (t0 + 30800);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng83)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 30800);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB29;

LAB33:    t10 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB34;

LAB35:    xsi_set_current_line(331, ng52);

LAB38:    xsi_set_current_line(332, ng52);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t0);
    xsi_set_current_line(333, ng52);
    xsi_vlog_stop(1);
    goto LAB37;

}

static void Initial_1726_5(char *t0)
{
    char t3[8];
    char t10[16];
    char t16[8];
    char t19[8];
    char *t1;
    char *t2;
    char *t4;
    unsigned int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(1726, ng52);

LAB2:    xsi_set_current_line(1727, ng52);
    t1 = (t0 + 2696);
    t2 = *((char **)t1);
    t1 = ((char*)((ng83)));
    memset(t3, 0, 8);
    xsi_vlog_signed_equal(t3, 32, t2, 32, t1, 32);
    t4 = (t3 + 4);
    t5 = *((unsigned int *)t4);
    t6 = (~(t5));
    t7 = *((unsigned int *)t3);
    t8 = (t7 & t6);
    t9 = (t8 != 0);
    if (t9 > 0)
        goto LAB3;

LAB4:    xsi_set_current_line(1732, ng52);

LAB7:    xsi_set_current_line(1733, ng52);
    t1 = xsi_vlog_time(t10, 10000.000000000000, 1000.0000000000000);
    t2 = ((char*)((ng56)));
    xsi_vlogfile_write(1, 0, 0, ng198, 3, t0, (char)118, t10, 64, (char)118, t2, 56);

LAB5:
LAB1:    return;
LAB3:    xsi_set_current_line(1727, ng52);

LAB6:    xsi_set_current_line(1728, ng52);
    t11 = xsi_vlog_time(t10, 10000.000000000000, 1000.0000000000000);
    t12 = ((char*)((ng56)));
    t13 = ((char*)((ng68)));
    t14 = ((char*)((ng197)));
    t15 = ((char*)((ng83)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t14, 32, t15, 32);
    t17 = (t0 + 1200);
    t18 = *((char **)t17);
    t17 = ((char*)((ng93)));
    memset(t19, 0, 8);
    xsi_vlog_signed_divide(t19, 32, t18, 32, t17, 32);
    xsi_vlogfile_write(1, 0, 0, ng196, 6, t0, (char)118, t10, 64, (char)118, t12, 56, (char)118, t13, 32, (char)118, t16, 32, (char)119, t19, 32);
    xsi_set_current_line(1730, ng52);
    t1 = ((char*)((ng104)));
    t2 = (t0 + 27440);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    goto LAB5;

}

static void Always_1745_6(char *t0)
{
    char t8[8];
    char t108[8];
    char t109[8];
    char t110[8];
    char t111[8];
    char t112[8];
    char t113[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    int t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t106;
    int t107;
    unsigned int t114;
    unsigned int t115;
    int t116;
    unsigned int t117;
    int t118;
    int t119;
    unsigned int t120;
    int t121;
    unsigned int t122;
    unsigned int t123;
    int t124;
    int t125;

LAB0:    t1 = (t0 + 43440U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(1745, ng52);
    t2 = (t0 + 44344);
    *((int *)t2) = 1;
    t3 = (t0 + 43472);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(1745, ng52);

LAB5:    t4 = (t0 + 280);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 43248);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(1770, ng52);
    t6 = (t0 + 2696);
    t7 = *((char **)t6);
    t6 = ((char*)((ng83)));
    memset(t8, 0, 8);
    xsi_vlog_signed_equal(t8, 32, t7, 32, t6, 32);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB8;

LAB9:
LAB10:    t2 = (t0 + 280);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t3 = (t0 + 43248);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(1770, ng52);

LAB11:    xsi_set_current_line(1772, ng52);
    t15 = (t0 + 35440);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = ((char*)((ng97)));
    t19 = (t0 + 43248);
    t20 = (t0 + 14712);
    t21 = xsi_create_subprogram_invocation(t19, 0, t0, t20, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t20, t21);
    t22 = (t21 + 96U);
    t23 = *((char **)t22);
    t24 = (t23 + 0U);
    xsi_vlogvar_assign_value(t24, t17, 0, 0, 1);
    t25 = (t21 + 96U);
    t26 = *((char **)t25);
    t27 = (t26 + 160U);
    xsi_vlogvar_assign_value(t27, t18, 0, 0, 1);

LAB14:    t28 = (t0 + 43344);
    t29 = *((char **)t28);
    t30 = (t29 + 80U);
    t31 = *((char **)t30);
    t32 = (t31 + 272U);
    t33 = *((char **)t32);
    t34 = (t33 + 0U);
    t35 = *((char **)t34);
    t36 = ((int  (*)(char *, char *))t35)(t0, t29);

LAB16:    if (t36 != 0)
        goto LAB17;

LAB12:    t29 = (t0 + 14712);
    xsi_vlog_subprogram_popinvocation(t29);

LAB13:    t37 = (t0 + 43344);
    t38 = *((char **)t37);
    t37 = (t38 + 96U);
    t39 = *((char **)t37);
    t40 = (t39 + 320U);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t0 + 35600);
    xsi_vlogvar_assign_value(t43, t42, 0, 0, 32);
    t44 = (t38 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 480U);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t0 + 35760);
    xsi_vlogvar_assign_value(t49, t48, 0, 0, 8);
    t50 = (t38 + 96U);
    t51 = *((char **)t50);
    t52 = (t51 + 640U);
    t53 = (t52 + 56U);
    t54 = *((char **)t53);
    t55 = (t0 + 35920);
    xsi_vlogvar_assign_value(t55, t54, 0, 0, 3);
    t56 = (t38 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 800U);
    t59 = (t58 + 56U);
    t60 = *((char **)t59);
    t61 = (t0 + 36080);
    xsi_vlogvar_assign_value(t61, t60, 0, 0, 2);
    t62 = (t38 + 96U);
    t63 = *((char **)t62);
    t64 = (t63 + 960U);
    t65 = (t64 + 56U);
    t66 = *((char **)t65);
    t67 = (t0 + 36240);
    xsi_vlogvar_assign_value(t67, t66, 0, 0, 1);
    t68 = (t38 + 96U);
    t69 = *((char **)t68);
    t70 = (t69 + 1120U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 36400);
    xsi_vlogvar_assign_value(t73, t72, 0, 0, 4);
    t74 = (t38 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 1280U);
    t77 = (t76 + 56U);
    t78 = *((char **)t77);
    t79 = (t0 + 36560);
    xsi_vlogvar_assign_value(t79, t78, 0, 0, 3);
    t80 = (t38 + 96U);
    t81 = *((char **)t80);
    t82 = (t81 + 1440U);
    t83 = (t82 + 56U);
    t84 = *((char **)t83);
    t85 = (t0 + 36720);
    xsi_vlogvar_assign_value(t85, t84, 0, 0, 4);
    t86 = (t38 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 1600U);
    t89 = (t88 + 56U);
    t90 = *((char **)t89);
    t91 = (t0 + 36880);
    xsi_vlogvar_assign_value(t91, t90, 0, 0, 4);
    t92 = (t38 + 96U);
    t93 = *((char **)t92);
    t94 = (t93 + 1760U);
    t95 = (t94 + 56U);
    t96 = *((char **)t95);
    t97 = (t0 + 37040);
    xsi_vlogvar_assign_value(t97, t96, 0, 0, 1);
    t98 = (t38 + 96U);
    t99 = *((char **)t98);
    t100 = (t99 + 1920U);
    t101 = (t100 + 56U);
    t102 = *((char **)t101);
    t103 = (t0 + 37200);
    xsi_vlogvar_assign_value(t103, t102, 0, 0, 1);
    t104 = (t0 + 14712);
    t105 = (t0 + 43248);
    t106 = 0;
    xsi_delete_subprogram_invocation(t104, t38, t0, t105, t106);
    xsi_set_current_line(1773, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 29360);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(1776, ng52);
    t2 = (t0 + 35600);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng66)));
    memset(t8, 0, 8);
    xsi_vlog_unsigned_minus(t8, 32, t4, 32, t5, 32);
    t6 = (t0 + 37520);
    xsi_vlogvar_assign_value(t6, t8, 0, 0, 32);
    xsi_set_current_line(1777, ng52);
    t2 = ((char*)((ng199)));
    t3 = (t0 + 37360);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8192);
    xsi_set_current_line(1779, ng52);
    t2 = (t0 + 35760);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 43248);
    t6 = (t0 + 6936);
    t7 = xsi_create_subprogram_invocation(t5, 0, t0, t6, 0, 0);
    t9 = (t0 + 32080);
    xsi_vlogvar_assign_value(t9, t4, 0, 0, 8);

LAB18:    t15 = (t0 + 43344);
    t16 = *((char **)t15);
    t17 = (t16 + 80U);
    t18 = *((char **)t17);
    t19 = (t18 + 272U);
    t20 = *((char **)t19);
    t21 = (t20 + 0U);
    t22 = *((char **)t21);
    t36 = ((int  (*)(char *, char *))t22)(t0, t16);
    if (t36 != 0)
        goto LAB20;

LAB19:    t16 = (t0 + 43344);
    t23 = *((char **)t16);
    t16 = (t0 + 31920);
    t24 = (t16 + 56U);
    t25 = *((char **)t24);
    memcpy(t8, t25, 8);
    t26 = (t0 + 6936);
    t27 = (t0 + 43248);
    t28 = 0;
    xsi_delete_subprogram_invocation(t26, t23, t0, t27, t28);
    t29 = (t0 + 35920);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t0 + 43248);
    t33 = (t0 + 6504);
    t34 = xsi_create_subprogram_invocation(t32, 0, t0, t33, 0, 0);
    t35 = (t0 + 31760);
    xsi_vlogvar_assign_value(t35, t31, 0, 0, 3);

LAB21:    t37 = (t0 + 43344);
    t38 = *((char **)t37);
    t39 = (t38 + 80U);
    t40 = *((char **)t39);
    t41 = (t40 + 272U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    t44 = *((char **)t43);
    t107 = ((int  (*)(char *, char *))t44)(t0, t38);
    if (t107 != 0)
        goto LAB23;

LAB22:    t38 = (t0 + 43344);
    t45 = *((char **)t38);
    t38 = (t0 + 31600);
    t46 = (t38 + 56U);
    t47 = *((char **)t46);
    memcpy(t108, t47, 8);
    t48 = (t0 + 6504);
    t49 = (t0 + 43248);
    t50 = 0;
    xsi_delete_subprogram_invocation(t48, t45, t0, t49, t50);
    memset(t109, 0, 8);
    xsi_vlog_unsigned_multiply(t109, 32, t8, 32, t108, 32);
    t51 = (t0 + 35600);
    t52 = (t51 + 56U);
    t53 = *((char **)t52);
    t54 = (t0 + 1200);
    t55 = *((char **)t54);
    t54 = ((char*)((ng93)));
    memset(t110, 0, 8);
    xsi_vlog_unsigned_divide(t110, 32, t55, 32, t54, 32);
    memset(t111, 0, 8);
    xsi_vlog_unsigned_mod(t111, 32, t53, 32, t110, 32);
    memset(t112, 0, 8);
    xsi_vlog_unsigned_minus(t112, 32, t109, 32, t111, 32);
    t56 = (t0 + 38000);
    xsi_vlogvar_assign_value(t56, t112, 0, 0, 32);
    xsi_set_current_line(1781, ng52);
    xsi_set_current_line(1781, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 37840);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB24:    t2 = (t0 + 37840);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 38000);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t8, 0, 8);
    xsi_vlog_signed_less(t8, 32, t4, 32, t7, 32);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB25;

LAB26:    xsi_set_current_line(1786, ng52);
    t2 = (t0 + 27280);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (~(t10));
    t12 = *((unsigned int *)t4);
    t36 = (t12 & t11);
    t6 = (t0 + 55688);
    *((int *)t6) = t36;

LAB30:    t7 = (t0 + 55688);
    if (*((int *)t7) > 0)
        goto LAB31;

LAB32:    xsi_set_current_line(1787, ng52);
    t2 = ((char*)((ng200)));
    t3 = (t0 + 37680);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 256);
    xsi_set_current_line(1788, ng52);
    t2 = (t0 + 37200);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 35600);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t0 + 35760);
    t15 = (t9 + 56U);
    t16 = *((char **)t15);
    t17 = (t0 + 35920);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t0 + 36080);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t0 + 36240);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    t26 = (t0 + 37360);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    t29 = (t0 + 37680);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t0 + 43248);
    t33 = (t0 + 15576);
    t34 = xsi_create_subprogram_invocation(t32, 0, t0, t33, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t33, t34);
    t35 = (t34 + 96U);
    t37 = *((char **)t35);
    t38 = (t37 + 0U);
    xsi_vlogvar_assign_value(t38, t4, 0, 0, 1);
    t39 = (t34 + 96U);
    t40 = *((char **)t39);
    t41 = (t40 + 160U);
    xsi_vlogvar_assign_value(t41, t7, 0, 0, 32);
    t42 = (t34 + 96U);
    t43 = *((char **)t42);
    t44 = (t43 + 320U);
    xsi_vlogvar_assign_value(t44, t16, 0, 0, 8);
    t45 = (t34 + 96U);
    t46 = *((char **)t45);
    t47 = (t46 + 480U);
    xsi_vlogvar_assign_value(t47, t19, 0, 0, 3);
    t48 = (t34 + 96U);
    t49 = *((char **)t48);
    t50 = (t49 + 640U);
    xsi_vlogvar_assign_value(t50, t22, 0, 0, 2);
    t51 = (t34 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 800U);
    xsi_vlogvar_assign_value(t53, t25, 0, 0, 1);
    t54 = (t34 + 96U);
    t55 = *((char **)t54);
    t56 = (t55 + 960U);
    xsi_vlogvar_assign_value(t56, t28, 0, 0, 8192);
    t57 = (t34 + 96U);
    t58 = *((char **)t57);
    t59 = (t58 + 1120U);
    xsi_vlogvar_assign_value(t59, t31, 0, 0, 256);

LAB36:    t60 = (t0 + 43344);
    t61 = *((char **)t60);
    t62 = (t61 + 80U);
    t63 = *((char **)t62);
    t64 = (t63 + 272U);
    t65 = *((char **)t64);
    t66 = (t65 + 0U);
    t67 = *((char **)t66);
    t36 = ((int  (*)(char *, char *))t67)(t0, t61);

LAB38:    if (t36 != 0)
        goto LAB39;

LAB34:    t61 = (t0 + 15576);
    xsi_vlog_subprogram_popinvocation(t61);

LAB35:    t68 = (t0 + 43344);
    t69 = *((char **)t68);
    t68 = (t0 + 15576);
    t70 = (t0 + 43248);
    t71 = 0;
    xsi_delete_subprogram_invocation(t68, t69, t0, t70, t71);
    goto LAB10;

LAB15:;
LAB17:    t28 = (t0 + 43440U);
    *((char **)t28) = &&LAB14;
    goto LAB1;

LAB20:    t15 = (t0 + 43440U);
    *((char **)t15) = &&LAB18;
    goto LAB1;

LAB23:    t37 = (t0 + 43440U);
    *((char **)t37) = &&LAB21;
    goto LAB1;

LAB25:    xsi_set_current_line(1781, ng52);

LAB27:    xsi_set_current_line(1782, ng52);
    t15 = (t0 + 31440);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t0 + 31440);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = (t0 + 31440);
    t22 = (t21 + 64U);
    t23 = *((char **)t22);
    t24 = (t0 + 37520);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t0 + 37840);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memset(t109, 0, 8);
    xsi_vlog_unsigned_add(t109, 32, t26, 32, t29, 32);
    xsi_vlog_generic_get_array_select_value(t108, 8, t17, t20, t23, 2, 1, t109, 32, 2);
    t30 = (t0 + 37360);
    t31 = (t0 + 37360);
    t32 = (t31 + 72U);
    t33 = *((char **)t32);
    t34 = (t0 + 37840);
    t35 = (t34 + 56U);
    t37 = *((char **)t35);
    t38 = ((char*)((ng93)));
    memset(t113, 0, 8);
    xsi_vlog_signed_multiply(t113, 32, t37, 32, t38, 32);
    t39 = ((char*)((ng93)));
    xsi_vlog_convert_indexed_partindices(t110, t111, t112, ((int*)(t33)), 2, t113, 32, 1, t39, 32, 1, 1);
    t40 = (t110 + 4);
    t114 = *((unsigned int *)t40);
    t36 = (!(t114));
    t41 = (t111 + 4);
    t115 = *((unsigned int *)t41);
    t107 = (!(t115));
    t116 = (t36 && t107);
    t42 = (t112 + 4);
    t117 = *((unsigned int *)t42);
    t118 = (!(t117));
    t119 = (t116 && t118);
    if (t119 == 1)
        goto LAB28;

LAB29:    xsi_set_current_line(1781, ng52);
    t2 = (t0 + 37840);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng83)));
    memset(t8, 0, 8);
    xsi_vlog_signed_add(t8, 32, t4, 32, t5, 32);
    t6 = (t0 + 37840);
    xsi_vlogvar_assign_value(t6, t8, 0, 0, 32);
    goto LAB24;

LAB28:    t120 = *((unsigned int *)t112);
    t121 = (t120 + 0);
    t122 = *((unsigned int *)t110);
    t123 = *((unsigned int *)t111);
    t124 = (t122 - t123);
    t125 = (t124 + 1);
    xsi_vlogvar_assign_value(t30, t108, t121, *((unsigned int *)t111), t125);
    goto LAB29;

LAB31:    xsi_set_current_line(1786, ng52);
    t9 = (t0 + 44360);
    *((int *)t9) = 1;
    t15 = (t0 + 43472);
    *((char **)t15) = t9;
    *((char **)t1) = &&LAB33;
    goto LAB1;

LAB33:    t2 = (t0 + 55688);
    t36 = *((int *)t2);
    *((int *)t2) = (t36 - 1);
    goto LAB30;

LAB37:;
LAB39:    t60 = (t0 + 43440U);
    *((char **)t60) = &&LAB36;
    goto LAB1;

}

static void Always_1801_7(char *t0)
{
    char t8[8];
    char t107[8];
    char t108[8];
    char t109[8];
    char t110[8];
    char t111[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    int t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t92;
    char *t93;
    char *t94;
    char *t95;
    char *t96;
    char *t97;
    char *t98;
    char *t99;
    char *t100;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t106;
    unsigned int t112;
    unsigned int t113;
    int t114;
    int t115;
    unsigned int t116;
    unsigned int t117;
    int t118;
    int t119;

LAB0:    t1 = (t0 + 43688U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(1801, ng52);
    t2 = (t0 + 44376);
    *((int *)t2) = 1;
    t3 = (t0 + 43720);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(1801, ng52);

LAB5:    t4 = (t0 + 576);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 43496);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(1828, ng52);
    t6 = (t0 + 2696);
    t7 = *((char **)t6);
    t6 = ((char*)((ng83)));
    memset(t8, 0, 8);
    xsi_vlog_signed_equal(t8, 32, t7, 32, t6, 32);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB8;

LAB9:
LAB10:    t2 = (t0 + 576);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t3 = (t0 + 43496);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(1828, ng52);

LAB11:    xsi_set_current_line(1830, ng52);
    t15 = (t0 + 38160);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = ((char*)((ng97)));
    t19 = (t0 + 43496);
    t20 = (t0 + 14280);
    t21 = xsi_create_subprogram_invocation(t19, 0, t0, t20, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t20, t21);
    t22 = (t21 + 96U);
    t23 = *((char **)t22);
    t24 = (t23 + 0U);
    xsi_vlogvar_assign_value(t24, t17, 0, 0, 1);
    t25 = (t21 + 96U);
    t26 = *((char **)t25);
    t27 = (t26 + 160U);
    xsi_vlogvar_assign_value(t27, t18, 0, 0, 1);

LAB14:    t28 = (t0 + 43592);
    t29 = *((char **)t28);
    t30 = (t29 + 80U);
    t31 = *((char **)t30);
    t32 = (t31 + 272U);
    t33 = *((char **)t32);
    t34 = (t33 + 0U);
    t35 = *((char **)t34);
    t36 = ((int  (*)(char *, char *))t35)(t0, t29);

LAB16:    if (t36 != 0)
        goto LAB17;

LAB12:    t29 = (t0 + 14280);
    xsi_vlog_subprogram_popinvocation(t29);

LAB13:    t37 = (t0 + 43592);
    t38 = *((char **)t37);
    t37 = (t38 + 96U);
    t39 = *((char **)t37);
    t40 = (t39 + 320U);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t43 = (t0 + 38320);
    xsi_vlogvar_assign_value(t43, t42, 0, 0, 32);
    t44 = (t38 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 480U);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t0 + 38480);
    xsi_vlogvar_assign_value(t49, t48, 0, 0, 8);
    t50 = (t38 + 96U);
    t51 = *((char **)t50);
    t52 = (t51 + 640U);
    t53 = (t52 + 56U);
    t54 = *((char **)t53);
    t55 = (t0 + 38640);
    xsi_vlogvar_assign_value(t55, t54, 0, 0, 3);
    t56 = (t38 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 800U);
    t59 = (t58 + 56U);
    t60 = *((char **)t59);
    t61 = (t0 + 38800);
    xsi_vlogvar_assign_value(t61, t60, 0, 0, 2);
    t62 = (t38 + 96U);
    t63 = *((char **)t62);
    t64 = (t63 + 960U);
    t65 = (t64 + 56U);
    t66 = *((char **)t65);
    t67 = (t0 + 38960);
    xsi_vlogvar_assign_value(t67, t66, 0, 0, 1);
    t68 = (t38 + 96U);
    t69 = *((char **)t68);
    t70 = (t69 + 1120U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 39120);
    xsi_vlogvar_assign_value(t73, t72, 0, 0, 4);
    t74 = (t38 + 96U);
    t75 = *((char **)t74);
    t76 = (t75 + 1280U);
    t77 = (t76 + 56U);
    t78 = *((char **)t77);
    t79 = (t0 + 39280);
    xsi_vlogvar_assign_value(t79, t78, 0, 0, 3);
    t80 = (t38 + 96U);
    t81 = *((char **)t80);
    t82 = (t81 + 1440U);
    t83 = (t82 + 56U);
    t84 = *((char **)t83);
    t85 = (t0 + 39440);
    xsi_vlogvar_assign_value(t85, t84, 0, 0, 4);
    t86 = (t38 + 96U);
    t87 = *((char **)t86);
    t88 = (t87 + 1600U);
    t89 = (t88 + 56U);
    t90 = *((char **)t89);
    t91 = (t0 + 39600);
    xsi_vlogvar_assign_value(t91, t90, 0, 0, 4);
    t92 = (t38 + 96U);
    t93 = *((char **)t92);
    t94 = (t93 + 1760U);
    t95 = (t94 + 56U);
    t96 = *((char **)t95);
    t97 = (t0 + 39760);
    xsi_vlogvar_assign_value(t97, t96, 0, 0, 1);
    t98 = (t38 + 96U);
    t99 = *((char **)t98);
    t100 = (t99 + 1920U);
    t101 = (t100 + 56U);
    t102 = *((char **)t101);
    t103 = (t0 + 39920);
    xsi_vlogvar_assign_value(t103, t102, 0, 0, 1);
    t104 = (t0 + 14280);
    t105 = (t0 + 43496);
    t106 = 0;
    xsi_delete_subprogram_invocation(t104, t38, t0, t105, t106);
    xsi_set_current_line(1833, ng52);
    t2 = (t0 + 38320);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 38480);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t0 + 38640);
    t15 = (t9 + 56U);
    t16 = *((char **)t15);
    t17 = (t0 + 38800);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t0 + 43496);
    t21 = (t0 + 16440);
    t22 = xsi_create_subprogram_invocation(t20, 0, t0, t21, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t21, t22);
    t23 = (t22 + 96U);
    t24 = *((char **)t23);
    t25 = (t24 + 0U);
    xsi_vlogvar_assign_value(t25, t4, 0, 0, 32);
    t26 = (t22 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 160U);
    xsi_vlogvar_assign_value(t28, t7, 0, 0, 8);
    t29 = (t22 + 96U);
    t30 = *((char **)t29);
    t31 = (t30 + 320U);
    xsi_vlogvar_assign_value(t31, t16, 0, 0, 3);
    t32 = (t22 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 480U);
    xsi_vlogvar_assign_value(t34, t19, 0, 0, 2);

LAB20:    t35 = (t0 + 43592);
    t37 = *((char **)t35);
    t38 = (t37 + 80U);
    t39 = *((char **)t38);
    t40 = (t39 + 272U);
    t41 = *((char **)t40);
    t42 = (t41 + 0U);
    t43 = *((char **)t42);
    t36 = ((int  (*)(char *, char *))t43)(t0, t37);

LAB22:    if (t36 != 0)
        goto LAB23;

LAB18:    t37 = (t0 + 16440);
    xsi_vlog_subprogram_popinvocation(t37);

LAB19:    t44 = (t0 + 43592);
    t45 = *((char **)t44);
    t44 = (t45 + 96U);
    t46 = *((char **)t44);
    t47 = (t46 + 640U);
    t48 = (t47 + 56U);
    t49 = *((char **)t48);
    t50 = (t0 + 40240);
    xsi_vlogvar_assign_value(t50, t49, 0, 0, 8192);
    t51 = (t45 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 800U);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = (t0 + 41040);
    xsi_vlogvar_assign_value(t56, t55, 0, 0, 32);
    t57 = (t45 + 96U);
    t58 = *((char **)t57);
    t59 = (t58 + 960U);
    t60 = (t59 + 56U);
    t61 = *((char **)t60);
    t62 = (t0 + 40720);
    xsi_vlogvar_assign_value(t62, t61, 0, 0, 256);
    t63 = (t0 + 16440);
    t64 = (t0 + 43496);
    t65 = 0;
    xsi_delete_subprogram_invocation(t63, t45, t0, t64, t65);
    xsi_set_current_line(1836, ng52);
    t2 = (t0 + 38320);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng66)));
    memset(t8, 0, 8);
    xsi_vlog_unsigned_minus(t8, 32, t4, 32, t5, 32);
    t6 = (t0 + 40400);
    xsi_vlogvar_assign_value(t6, t8, 0, 0, 32);
    xsi_set_current_line(1838, ng52);
    xsi_set_current_line(1838, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 40880);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB24:    t2 = (t0 + 40880);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 41040);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t8, 0, 8);
    xsi_vlog_signed_less(t8, 32, t4, 32, t7, 32);
    t9 = (t8 + 4);
    t10 = *((unsigned int *)t9);
    t11 = (~(t10));
    t12 = *((unsigned int *)t8);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB25;

LAB26:    xsi_set_current_line(1844, ng52);
    t2 = (t0 + 38960);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 43496);
    t6 = (t0 + 7800);
    t7 = xsi_create_subprogram_invocation(t5, 0, t0, t6, 0, 0);
    t9 = (t0 + 34960);
    xsi_vlogvar_assign_value(t9, t4, 0, 0, 1);

LAB30:    t15 = (t0 + 43592);
    t16 = *((char **)t15);
    t17 = (t16 + 80U);
    t18 = *((char **)t17);
    t19 = (t18 + 272U);
    t20 = *((char **)t19);
    t21 = (t20 + 0U);
    t22 = *((char **)t21);
    t36 = ((int  (*)(char *, char *))t22)(t0, t16);
    if (t36 != 0)
        goto LAB32;

LAB31:    t16 = (t0 + 43592);
    t23 = *((char **)t16);
    t16 = (t0 + 34800);
    t24 = (t16 + 56U);
    t25 = *((char **)t24);
    memcpy(t8, t25, 8);
    t26 = (t0 + 7800);
    t27 = (t0 + 43496);
    t28 = 0;
    xsi_delete_subprogram_invocation(t26, t23, t0, t27, t28);
    t29 = (t0 + 40560);
    xsi_vlogvar_assign_value(t29, t8, 0, 0, 2);
    xsi_set_current_line(1845, ng52);
    t2 = (t0 + 27120);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (~(t10));
    t12 = *((unsigned int *)t4);
    t36 = (t12 & t11);
    t6 = (t0 + 55692);
    *((int *)t6) = t36;

LAB33:    t7 = (t0 + 55692);
    if (*((int *)t7) > 0)
        goto LAB34;

LAB35:    xsi_set_current_line(1846, ng52);
    t2 = ((char*)((ng104)));
    t3 = (t0 + 40080);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(1847, ng52);
    t2 = (t0 + 39920);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 40560);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t0 + 40080);
    t15 = (t9 + 56U);
    t16 = *((char **)t15);
    t17 = (t0 + 43496);
    t18 = (t0 + 13416);
    t19 = xsi_create_subprogram_invocation(t17, 0, t0, t18, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t18, t19);
    t20 = (t19 + 96U);
    t21 = *((char **)t20);
    t22 = (t21 + 0U);
    xsi_vlogvar_assign_value(t22, t4, 0, 0, 1);
    t23 = (t19 + 96U);
    t24 = *((char **)t23);
    t25 = (t24 + 160U);
    xsi_vlogvar_assign_value(t25, t7, 0, 0, 2);
    t26 = (t19 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 320U);
    xsi_vlogvar_assign_value(t28, t16, 0, 0, 1);

LAB39:    t29 = (t0 + 43592);
    t30 = *((char **)t29);
    t31 = (t30 + 80U);
    t32 = *((char **)t31);
    t33 = (t32 + 272U);
    t34 = *((char **)t33);
    t35 = (t34 + 0U);
    t37 = *((char **)t35);
    t36 = ((int  (*)(char *, char *))t37)(t0, t30);

LAB41:    if (t36 != 0)
        goto LAB42;

LAB37:    t30 = (t0 + 13416);
    xsi_vlog_subprogram_popinvocation(t30);

LAB38:    t38 = (t0 + 43592);
    t39 = *((char **)t38);
    t38 = (t0 + 13416);
    t40 = (t0 + 43496);
    t41 = 0;
    xsi_delete_subprogram_invocation(t38, t39, t0, t40, t41);
    goto LAB10;

LAB15:;
LAB17:    t28 = (t0 + 43688U);
    *((char **)t28) = &&LAB14;
    goto LAB1;

LAB21:;
LAB23:    t35 = (t0 + 43688U);
    *((char **)t35) = &&LAB20;
    goto LAB1;

LAB25:    xsi_set_current_line(1838, ng52);

LAB27:    xsi_set_current_line(1839, ng52);
    t15 = (t0 + 40240);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t0 + 40240);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = (t0 + 40880);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = ((char*)((ng93)));
    memset(t108, 0, 8);
    xsi_vlog_signed_multiply(t108, 32, t23, 32, t24, 32);
    t25 = ((char*)((ng93)));
    xsi_vlog_get_indexed_partselect(t107, 8, t17, ((int*)(t20)), 2, t108, 32, 1, t25, 32, 1, 1);
    t26 = (t0 + 31440);
    t27 = (t0 + 31440);
    t28 = (t27 + 72U);
    t29 = *((char **)t28);
    t30 = (t0 + 31440);
    t31 = (t30 + 64U);
    t32 = *((char **)t31);
    t33 = (t0 + 40400);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t37 = (t0 + 40880);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    memset(t111, 0, 8);
    xsi_vlog_unsigned_add(t111, 32, t35, 32, t39, 32);
    xsi_vlog_generic_convert_array_indices(t109, t110, t29, t32, 2, 1, t111, 32, 2);
    t40 = (t109 + 4);
    t112 = *((unsigned int *)t40);
    t36 = (!(t112));
    t41 = (t110 + 4);
    t113 = *((unsigned int *)t41);
    t114 = (!(t113));
    t115 = (t36 && t114);
    if (t115 == 1)
        goto LAB28;

LAB29:    xsi_set_current_line(1838, ng52);
    t2 = (t0 + 40880);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng83)));
    memset(t8, 0, 8);
    xsi_vlog_signed_add(t8, 32, t4, 32, t5, 32);
    t6 = (t0 + 40880);
    xsi_vlogvar_assign_value(t6, t8, 0, 0, 32);
    goto LAB24;

LAB28:    t116 = *((unsigned int *)t109);
    t117 = *((unsigned int *)t110);
    t118 = (t116 - t117);
    t119 = (t118 + 1);
    xsi_vlogvar_assign_value(t26, t107, 0, *((unsigned int *)t110), t119);
    goto LAB29;

LAB32:    t15 = (t0 + 43688U);
    *((char **)t15) = &&LAB30;
    goto LAB1;

LAB34:    xsi_set_current_line(1845, ng52);
    t9 = (t0 + 44392);
    *((int *)t9) = 1;
    t15 = (t0 + 43720);
    *((char **)t15) = t9;
    *((char **)t1) = &&LAB36;
    goto LAB1;

LAB36:    t2 = (t0 + 55692);
    t36 = *((int *)t2);
    *((int *)t2) = (t36 - 1);
    goto LAB33;

LAB40:;
LAB42:    t29 = (t0 + 43688U);
    *((char **)t29) = &&LAB39;
    goto LAB1;

}


extern void secureip_m_14885042784626448528_3733016353_init()
{
	static char *pe[] = {(void *)Cont_152_0,(void *)Initial_157_1,(void *)Initial_169_2,(void *)Always_242_3,(void *)Always_328_4,(void *)Initial_1726_5,(void *)Always_1745_6,(void *)Always_1801_7};
	static char *se[] = {(void *)sp_report_config,(void *)sp_check_burst_type,(void *)sp_check_burst_length,(void *)sp_check_burst_size,(void *)sp_check_lock_type,(void *)sp_check_cache_type,(void *)sp_check_address,(void *)sp_transfer_size_in_bytes,(void *)sp_decode_burst_length,(void *)sp_calculate_strobe,(void *)sp_calculate_response,(void *)sp_set_channel_level_info,(void *)sp_set_function_level_info,(void *)sp_set_stop_on_error,(void *)sp_set_clear_signals_after_handshake,(void *)sp_set_response_timeout,(void *)sp_set_task_call_and_reset_handling,(void *)sp_task_reset_handling,(void *)sp_set_bfm_clk_delay,(void *)sp_set_disable_reset_value_checks,(void *)sp_report_status,(void *)sp_add_pending_transaction,(void *)sp_remove_pending_transaction,(void *)sp_SEND_WRITE_RESPONSE,(void *)sp_SEND_READ_DATA,(void *)sp_RECEIVE_WRITE_ADDRESS,(void *)sp_RECEIVE_READ_ADDRESS,(void *)sp_RECEIVE_WRITE_DATA,(void *)sp_SEND_READ_BURST,(void *)sp_SEND_READ_BURST_RESP_CTRL,(void *)sp_RECEIVE_WRITE_BURST,(void *)sp_READ_BURST_RESPOND,(void *)sp_READ_BURST_RESP_CTRL,(void *)sp_WRITE_BURST_RESPOND,(void *)sp_WRITE_BURST_RESP_CTRL,(void *)sp_set_read_burst_data_transfer_gap,(void *)sp_set_write_response_gap,(void *)sp_set_read_response_gap,(void *)sp_check_address_range,(void *)sp_check_strobe};
	xsi_register_didat("secureip_m_14885042784626448528_3733016353", "isim/isim_bfm_system.sim/secureip/m_14885042784626448528_3733016353.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
	xsi_register_subprogram_init(2, (void *)check_burst_type_varinit);
	xsi_register_subprogram_init(3, (void *)check_burst_length_varinit);
	xsi_register_subprogram_init(4, (void *)check_burst_size_varinit);
	xsi_register_subprogram_init(5, (void *)check_lock_type_varinit);
	xsi_register_subprogram_init(6, (void *)check_cache_type_varinit);
	xsi_register_subprogram_init(7, (void *)check_address_varinit);
	xsi_register_subprogram_init(12, (void *)set_channel_level_info_varinit);
	xsi_register_subprogram_init(13, (void *)set_function_level_info_varinit);
	xsi_register_subprogram_init(14, (void *)set_stop_on_error_varinit);
	xsi_register_subprogram_init(15, (void *)set_clear_signals_after_handshake_varinit);
	xsi_register_subprogram_init(16, (void *)set_response_timeout_varinit);
	xsi_register_subprogram_init(17, (void *)set_task_call_and_reset_handling_varinit);
	xsi_register_subprogram_init(18, (void *)task_reset_handling_varinit);
	xsi_register_subprogram_init(19, (void *)set_bfm_clk_delay_varinit);
	xsi_register_subprogram_init(20, (void *)set_disable_reset_value_checks_varinit);
	xsi_register_subprogram_init(22, (void *)add_pending_transaction_varinit);
	xsi_register_subprogram_init(23, (void *)remove_pending_transaction_varinit);
	xsi_register_subprogram_init(24, (void *)SEND_WRITE_RESPONSE_varinit);
	xsi_register_subprogram_init(25, (void *)SEND_READ_DATA_varinit);
	xsi_register_subprogram_init(26, (void *)RECEIVE_WRITE_ADDRESS_varinit);
	xsi_register_subprogram_init(27, (void *)RECEIVE_READ_ADDRESS_varinit);
	xsi_register_subprogram_init(28, (void *)RECEIVE_WRITE_DATA_varinit);
	xsi_register_subprogram_init(29, (void *)SEND_READ_BURST_varinit);
	xsi_register_subprogram_init(30, (void *)SEND_READ_BURST_RESP_CTRL_varinit);
	xsi_register_subprogram_init(31, (void *)RECEIVE_WRITE_BURST_varinit);
	xsi_register_subprogram_init(32, (void *)READ_BURST_RESPOND_varinit);
	xsi_register_subprogram_init(33, (void *)READ_BURST_RESP_CTRL_varinit);
	xsi_register_subprogram_init(34, (void *)WRITE_BURST_RESPOND_varinit);
	xsi_register_subprogram_init(35, (void *)WRITE_BURST_RESP_CTRL_varinit);
	xsi_register_subprogram_init(36, (void *)set_read_burst_data_transfer_gap_varinit);
	xsi_register_subprogram_init(37, (void *)set_write_response_gap_varinit);
	xsi_register_subprogram_init(38, (void *)set_read_response_gap_varinit);
	xsi_register_subprogram_init(39, (void *)check_address_range_varinit);
	xsi_register_subprogram_init(40, (void *)check_strobe_varinit);
}
