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
static const char *ng0 = "address";
static const char *ng1 = "transfer_number";
static const char *ng2 = "Start_Address";
static const char *ng3 = "Number_Bytes";
static const char *ng4 = "Data_Bus_Bytes";
static const char *ng5 = "Aligned_Address";
static const char *ng6 = "Burst_Length";
static const char *ng7 = "Address_N";
static const char *ng8 = "Wrap_Boundary";
static const char *ng9 = "Lower_Byte_Lane";
static const char *ng10 = "Upper_Byte_Lane";
static const char *ng11 = "strobe_index";
static const char *ng12 = "calculate_strobe";
static const char *ng13 = "level";
static const char *ng14 = "disable_value";
static const char *ng15 = "task_reset_handling";
static const char *ng16 = "clk_delay";
static const char *ng17 = "dummy_bit";
static const char *ng18 = "report_status";
static const char *ng19 = "print_message";
static const char *ng20 = "protection_type";
static const char *ng21 = "strobe";
static const char *ng22 = "wr_data";
static const char *ng23 = "rd_data";
static const char *ng24 = "response";
static const char *ng25 = "timeout_counter";
static const char *ng26 = "trigger_condition";
static const char *ng27 = "datasize";
static const char *ng28 = "i";
static const char *ng29 = "direction";
static const char *ng30 = "/build/xfndry/isimco/hipsBuilds/P_hips_v23.0/rst/hips/axi_bfm/cdn_axi4_lite_master_bfm.v";
static const char *ng31 = "**********************************************************";
static const char *ng32 = "* CONFIGURATION: ";
static const char *ng33 = "* NAME = %s";
static int ng34[] = {1163026224, 0, 1296126804, 0};
static const char *ng35 = "* DATA_BUS_WIDTH = %0d";
static const char *ng36 = "* ADDRESS_BUS_WIDTH = %0d";
static const char *ng37 = "* MAX_OUTSTANDING_TRANSACTIONS = %0d";
static const char *ng38 = "* RESPONSE_TIMEOUT = %0d";
static const char *ng39 = "* CLEAR_SIGNALS_AFTER_HANDSHAKE = %0d";
static const char *ng40 = "* DISABLE_RESET_VALUE_CHECKS = %0d";
static const char *ng41 = "* ERROR_ON_SLVERR = %0d";
static const char *ng42 = "* ERROR_ON_DECERR = %0d";
static const char *ng43 = "* STOP_ON_ERROR = %0d";
static const char *ng44 = "* CHANNEL_LEVEL_INFO = %0d";
static const char *ng45 = "* FUNCTION_LEVEL_INFO = %0d";
static const char *ng46 = "/build/xfndry/isimco/hipsBuilds/P_hips_v23.0/rst/hips/axi_bfm/cdn_axi4_lite_bfm_checkers.v";
static int ng47[] = {1, 0};
static int ng48[] = {8, 0};
static int ng49[] = {0, 0};
static const char *ng50 = "[%0d] : %s : *INFO : Setting CHANNEL_LEVEL_INFO to %0d";
static const char *ng51 = "[%0d] : %s : *INFO : Setting FUNCTION_LEVEL_INFO to %0d";
static const char *ng52 = "[%0d] : %s : *INFO : Setting STOP_ON_ERROR to %0d";
static const char *ng53 = "[%0d] : %s : *INFO : Setting RESPONSE_TIMEOUT to %0d";
static const char *ng54 = "[%0d] : %s : *INFO : Setting CLEAR_SIGNALS_AFTER_HANDSHAKE to %0d";
static const char *ng55 = "[%0d] : %s : *INFO : Setting DISABLE_RESET_VALUE_CHECKS to %0d";
static const char *ng56 = "[%0d] : %s : *INFO : Setting TASK_RESET_HANDLING to %0d";
static const char *ng57 = "[%0d] : %s : *INFO : Channel Level Task called during reset - Waiting until reset is clear before continuing task call.";
static int ng58[] = {2, 0};
static const char *ng59 = "[%0d] : %s : *ERROR : Channel Level Task called during reset";
static const char *ng60 = "*** TEST FAILED";
static int ng61[] = {3, 0};
static const char *ng62 = "[%0d] : %s : *WARNING : Channel Level Task called during reset - ignoring reset and continuing task execution.";
static const char *ng63 = "[%0d] : %s : *INFO : Setting BFM_CLK_DELAY to %0d";
static const char *ng64 = "[%0d] : %s : *INFO : REPORT_STATUS : errors = %0d, warnings = %0d, pending transactions = %0d";
static const char *ng65 = "[%0d] : %s : *INFO : Reached the maximum outstanding transactions limit (%0d). Blocking all future transactions until at least 1 of the outstanding transactions has completed.";
static const char *ng66 = "[%0d] : %s : *INFO : Dropped below the maximum outstanding transactions limit.";
static const char *ng67 = "[%0d] : %s : *INFO : SEND_WRITE_ADDRESS Task Call - ";
static const char *ng68 = "address = 0x%0h";
static const char *ng69 = ", protection_type = 0x%0h";
static unsigned int ng70[] = {1U, 0U};
static unsigned int ng71[] = {0U, 0U};
static const char *ng72 = "[%0d] : %s : *INFO : SEND_WRITE_DATA Task Call - ";
static const char *ng73 = "strobe = 0x%0h";
static const char *ng74 = ", data = 0x%0h";
static const char *ng75 = "[%0d] : %s : *INFO : SEND_READ_ADDRESS Task Call - ";
static const char *ng76 = "[%0d] : %s : *INFO : RECEIVE_READ_DATA Task Call - ";
static const char *ng77 = "[%0d] : %s : *ERROR : RECEIVE_READ_DATA Task TIMEOUT - ";
static const char *ng78 = "TASK timed out waiting for a READ DATA transfer.";
static const char *ng79 = "[%0d] : %s : *INFO : RECEIVE_READ_DATA Task - ";
static const char *ng80 = "rd_data = 0x%0h";
static const char *ng81 = ", response = 0x%0h";
static const char *ng82 = "[%0d] : %s : *INFO : RECEIVE_WRITE_RESPONSE Task Call - ";
static const char *ng83 = "[%0d] : %s : *ERROR : RECEIVE_WRITE_RESPONSE Task TIMEOUT - ";
static const char *ng84 = " TASK timed out waiting for a WRITE RESPONSE transfer.";
static const char *ng85 = "[%0d] : %s : *INFO : RECEIVE_WRITE_RESPONSE Task - ";
static const char *ng86 = "response = 0x%0h";
static const char *ng87 = "[%0d] : %s : *INFO : READ_BURST Task Call - ";
static const char *ng88 = "[%0d] : %s : *INFO : WRITE_BURST Task Call - ";
static const char *ng89 = ", valid data size (in bytes) = %0d";
static const char *ng90 = "[%0d] : %s : *INFO : WRITE_BURST_CONCURRENT Task Call - ";
static const char *ng93 = "[%0d] : %s : *INFO : WRITE_BURST_DATA_FIRST Task Call - ";
static const char *ng94 = "[%0d] : %s : *INFO : Setting ERROR_ON_SLVERR to %0d";
static const char *ng95 = "[%0d] : %s : *INFO : Setting ERROR_ON_DECERR to %0d";
static unsigned int ng96[] = {2U, 0U};
static const char *ng97 = "[%0d] : %s : *ERROR : Write Response = %0d - SLVERR detected.";
static const char *ng98 = "[%0d] : %s : *ERROR : Read Response = %0d - SLVERR detected.";
static const char *ng99 = "[%0d] : %s : *WARNING : Write Response = %0d - SLVERR detected.";
static const char *ng100 = "[%0d] : %s : *WARNING : Read Response = %0d - SLVERR detected.";
static unsigned int ng101[] = {3U, 0U};
static const char *ng102 = "[%0d] : %s : *ERROR : Write Response = %0d - DECERR detected.";
static const char *ng103 = "[%0d] : %s : *ERROR : Read Response = %0d - DECERR detected.";
static const char *ng104 = "[%0d] : %s : *WARNING : Write Response = %0d - DECERR detected.";
static const char *ng105 = "[%0d] : %s : *WARNING : Read Response = %0d - DECERR detected.";
static const char *ng106 = "Xilinx_AXI_BFM";
static const char *ng107 = "BFM Xilinx: License succeeded for %s, version %f";
static int ng108[] = {1598178893, 0, 1598117961, 0, 1818848888, 0, 22633, 0};
static const char *ng109 = "BFM Xilinx: License failed for %s, version %f";
static const char *ng110 = "* Cadence AXI 4 LITE MASTER BFM                          *";
static const char *ng111 = "* VERSION NUMBER : ";
static const char *ng112 = "3.0";
static const char *ng113 = "[%0d] : %s : *INFO : Reset detected - setting output signals to reset values and checking input signals for correct reset values.";
static const char *ng114 = "[%0d] : %s : *ERROR : BVALID from slave is not zero (reset value) - AMBA AXI SPEC V2 - Section 11.1.2 Reset";
static const char *ng115 = "[%0d] : %s : *ERROR : RVALID from slave is not zero (reset value) - AMBA AXI SPEC V2 - Section 11.1.2 Reset";
static const char *ng116 = "[%0d] : %s : *INFO : Reset Checks Complete";
static const char *ng117 = "[%0d] : %s : *ERROR : Invalid release of reset. Reset can be asserted asyncronously but must be deasserted on the rising edge of the clock - AMBA AXI SPEC V2 - Section 11.1.2 Reset";

static void Forked_882_5(char *);
static void Forked_883_6(char *);
void Forked_882_5();
void Forked_883_6();


static void calculate_strobe_varinit(char *t0)
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

LAB0:    t1 = (t0 + 96U);
    t2 = *((char **)t1);
    t3 = (t2 + 160U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 320U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng1, 0, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 480U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng2, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 640U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng3, 0, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 800U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng4, 0, 31, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 960U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng5, 2, 31, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 1120U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng6, 0, 31, 0, 0, t35, 0, 1, 0);
    t36 = (t0 + 96U);
    t37 = *((char **)t36);
    t38 = (t37 + 1280U);
    t39 = (t0 + 80U);
    t40 = *((char **)t39);
    xsi_vlogvar_initialize(t38, ng7, 2, 31, 0, 0, t40, 0, 1, 0);
    t41 = (t0 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 1440U);
    t44 = (t0 + 80U);
    t45 = *((char **)t44);
    xsi_vlogvar_initialize(t43, ng8, 2, 31, 0, 0, t45, 0, 1, 0);
    t46 = (t0 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 1600U);
    t49 = (t0 + 80U);
    t50 = *((char **)t49);
    xsi_vlogvar_initialize(t48, ng9, 2, 31, 0, 0, t50, 0, 1, 0);
    t51 = (t0 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 1760U);
    t54 = (t0 + 80U);
    t55 = *((char **)t54);
    xsi_vlogvar_initialize(t53, ng10, 2, 31, 0, 0, t55, 0, 1, 0);
    t56 = (t0 + 96U);
    t57 = *((char **)t56);
    t58 = (t57 + 1920U);
    t59 = (t0 + 80U);
    t60 = *((char **)t59);
    xsi_vlogvar_initialize(t58, ng11, 0, 31, 0, 0, t60, 0, 1, 0);
    t61 = (t0 + 96U);
    t62 = *((char **)t61);
    t63 = (t62 + 0U);
    t64 = (t0 + 80U);
    t65 = *((char **)t64);
    xsi_vlogvar_initialize(t63, ng12, 2, 3, 0, 0, t65, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng13, 2, 0, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng13, 2, 0, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng13, 2, 0, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng13, 0, 31, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng13, 2, 0, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng14, 2, 0, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng15, 0, 31, 0, 0, t5, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng16, 0, 31, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void report_status_varinit(char *t0)
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
    t3 = (t2 + 160U);
    t4 = (t0 + 80U);
    t5 = *((char **)t4);
    xsi_vlogvar_initialize(t3, ng17, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng18, 0, 31, 0, 0, t10, 0, 1, 0);

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
    xsi_vlogvar_initialize(t3, ng19, 2, 0, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void remove_pending_transaction_varinit(char *t0)
{

LAB0:
LAB1:    return;
}

static void SEND_WRITE_ADDRESS_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 2, 0, 0, t10, 0, 1, 0);

LAB1:    return;
}

static void SEND_WRITE_DATA_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng21, 2, 3, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng22, 2, 31, 0, 0, t10, 0, 1, 0);

LAB1:    return;
}

static void SEND_READ_ADDRESS_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 2, 0, 0, t10, 0, 1, 0);

LAB1:    return;
}

static void RECEIVE_READ_DATA_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng23, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng24, 2, 1, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng25, 0, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng26, 2, 0, 0, 0, t20, 0, 1, 0);

LAB1:    return;
}

static void RECEIVE_WRITE_RESPONSE_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng24, 2, 1, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng25, 0, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng26, 2, 0, 0, 0, t15, 0, 1, 0);

LAB1:    return;
}

static void READ_BURST_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 2, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng23, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng24, 2, 1, 0, 0, t20, 0, 1, 0);

LAB1:    return;
}

static void WRITE_BURST_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 2, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng22, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng27, 0, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng24, 2, 1, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng21, 2, 3, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng28, 0, 31, 0, 0, t35, 0, 1, 0);

LAB1:    return;
}

static void WRITE_BURST_CONCURRENT_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 2, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng22, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng27, 0, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng24, 2, 1, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng21, 2, 3, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng28, 0, 31, 0, 0, t35, 0, 1, 0);

LAB1:    return;
}

static void WRITE_BURST_DATA_FIRST_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng20, 2, 2, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng22, 2, 31, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng27, 0, 31, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng24, 2, 1, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng21, 2, 3, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng28, 0, 31, 0, 0, t35, 0, 1, 0);

LAB1:    return;
}

static void set_error_on_slverr_varinit(char *t0)
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

static void set_error_on_decerr_varinit(char *t0)
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

static void check_response_value_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng24, 2, 1, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng29, 2, 0, 0, 0, t10, 0, 1, 0);

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

LAB2:    t4 = (t1 + 1392);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(157, ng30);

LAB5:    xsi_set_current_line(158, ng30);
    t5 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng31, 1, t5);
    xsi_set_current_line(159, ng30);
    t4 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng32, 1, t4);
    xsi_set_current_line(160, ng30);
    t4 = ((char*)((ng34)));
    t5 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng33, 2, t5, (char)118, t4, 64);
    xsi_set_current_line(161, ng30);
    t4 = (t1 + 608);
    t5 = *((char **)t4);
    t4 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng35, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(162, ng30);
    t4 = (t1 + 744);
    t5 = *((char **)t4);
    t4 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng36, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(163, ng30);
    t4 = (t1 + 880);
    t5 = *((char **)t4);
    t4 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng37, 2, t4, (char)119, t5, 32);
    xsi_set_current_line(165, ng30);
    t4 = (t1 + 15144);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng38, 2, t7, (char)119, t6, 32);
    xsi_set_current_line(166, ng30);
    t4 = (t1 + 15944);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng39, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(167, ng30);
    t4 = (t1 + 15304);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng40, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(168, ng30);
    t4 = (t1 + 16104);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng41, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(169, ng30);
    t4 = (t1 + 16264);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng42, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(170, ng30);
    t4 = (t1 + 15464);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng43, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(171, ng30);
    t4 = (t1 + 15624);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng44, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(172, ng30);
    t4 = (t1 + 15784);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng45, 2, t7, (char)118, t6, 1);
    xsi_set_current_line(173, ng30);
    t4 = (t1 + 1392);
    xsi_vlogfile_write(1, 0, 0, ng31, 1, t4);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_calculate_strobe(char *t1, char *t2)
{
    char t11[8];
    char t19[8];
    char t25[8];
    char t32[8];
    char t33[8];
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
    char *t16;
    char *t17;
    char *t18;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    int t43;

LAB0:    t0 = 1;
    xsi_set_current_line(40, ng46);

LAB2:    xsi_set_current_line(42, ng46);
    t3 = ((char*)((ng47)));
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 32);
    xsi_set_current_line(44, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 160U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 480U);
    xsi_vlogvar_assign_value(t10, t7, 0, 0, 32);
    xsi_set_current_line(45, ng46);
    t3 = (t1 + 608);
    t4 = *((char **)t3);
    t3 = ((char*)((ng48)));
    memset(t11, 0, 8);
    xsi_vlog_signed_divide(t11, 32, t4, 32, t3, 32);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 640U);
    xsi_vlogvar_assign_value(t7, t11, 0, 0, 32);
    xsi_set_current_line(46, ng46);
    t3 = ((char*)((ng47)));
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 1120U);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 32);
    xsi_set_current_line(47, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 480U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 640U);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memset(t11, 0, 8);
    xsi_vlog_unsigned_divide(t11, 32, t7, 32, t13, 32);
    t14 = (t2 + 96U);
    t15 = *((char **)t14);
    t16 = (t15 + 640U);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memset(t19, 0, 8);
    xsi_vlog_unsigned_multiply(t19, 32, t11, 32, t18, 32);
    t20 = (t2 + 96U);
    t21 = *((char **)t20);
    t22 = (t21 + 960U);
    xsi_vlogvar_assign_value(t22, t19, 0, 0, 32);
    xsi_set_current_line(48, ng46);
    t3 = (t1 + 608);
    t4 = *((char **)t3);
    t3 = ((char*)((ng48)));
    memset(t11, 0, 8);
    xsi_vlog_signed_divide(t11, 32, t4, 32, t3, 32);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 800U);
    xsi_vlogvar_assign_value(t7, t11, 0, 0, 32);
    xsi_set_current_line(52, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 480U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 1280U);
    xsi_vlogvar_assign_value(t10, t7, 0, 0, 32);
    xsi_set_current_line(55, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 480U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 480U);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t14 = (t2 + 96U);
    t15 = *((char **)t14);
    t16 = (t15 + 800U);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memset(t11, 0, 8);
    xsi_vlog_unsigned_divide(t11, 32, t13, 32, t18, 32);
    t20 = (t2 + 96U);
    t21 = *((char **)t20);
    t22 = (t21 + 800U);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memset(t19, 0, 8);
    xsi_vlog_unsigned_multiply(t19, 32, t11, 32, t24, 32);
    memset(t25, 0, 8);
    xsi_vlog_unsigned_minus(t25, 32, t7, 32, t19, 32);
    t26 = (t2 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 1600U);
    xsi_vlogvar_assign_value(t28, t25, 0, 0, 32);
    xsi_set_current_line(56, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 960U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 640U);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t14 = ((char*)((ng47)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_minus(t11, 32, t13, 32, t14, 32);
    memset(t19, 0, 8);
    xsi_vlog_unsigned_add(t19, 32, t7, 32, t11, 32);
    t15 = (t2 + 96U);
    t16 = *((char **)t15);
    t17 = (t16 + 480U);
    t18 = (t17 + 56U);
    t20 = *((char **)t18);
    t21 = (t2 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 800U);
    t24 = (t23 + 56U);
    t26 = *((char **)t24);
    memset(t25, 0, 8);
    xsi_vlog_unsigned_divide(t25, 32, t20, 32, t26, 32);
    t27 = (t2 + 96U);
    t28 = *((char **)t27);
    t29 = (t28 + 800U);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memset(t32, 0, 8);
    xsi_vlog_unsigned_multiply(t32, 32, t25, 32, t31, 32);
    memset(t33, 0, 8);
    xsi_vlog_unsigned_minus(t33, 32, t19, 32, t32, 32);
    t34 = (t2 + 96U);
    t35 = *((char **)t34);
    t36 = (t35 + 1760U);
    xsi_vlogvar_assign_value(t36, t33, 0, 0, 32);
    xsi_set_current_line(60, ng46);
    t3 = ((char*)((ng49)));
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 4);
    xsi_set_current_line(62, ng46);
    xsi_set_current_line(62, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 1600U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 1920U);
    xsi_vlogvar_assign_value(t10, t7, 0, 0, 32);

LAB3:    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 1920U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 1760U);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memset(t11, 0, 8);
    t14 = (t7 + 4);
    if (*((unsigned int *)t14) != 0)
        goto LAB5;

LAB4:    t15 = (t13 + 4);
    if (*((unsigned int *)t15) != 0)
        goto LAB5;

LAB8:    if (*((unsigned int *)t7) > *((unsigned int *)t13))
        goto LAB7;

LAB6:    *((unsigned int *)t11) = 1;

LAB7:    t17 = (t11 + 4);
    t37 = *((unsigned int *)t17);
    t38 = (~(t37));
    t39 = *((unsigned int *)t11);
    t40 = (t39 & t38);
    t41 = (t40 != 0);
    if (t41 > 0)
        goto LAB9;

LAB10:    t0 = 0;

LAB1:    return t0;
LAB5:    t16 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t16) = 1;
    goto LAB7;

LAB9:    xsi_set_current_line(62, ng46);

LAB11:    xsi_set_current_line(63, ng46);
    t18 = ((char*)((ng47)));
    t20 = (t2 + 96U);
    t21 = *((char **)t20);
    t22 = (t21 + 0U);
    t23 = (t2 + 96U);
    t24 = *((char **)t23);
    t26 = (t24 + 0U);
    t27 = (t26 + 72U);
    t28 = *((char **)t27);
    t29 = (t2 + 96U);
    t30 = *((char **)t29);
    t31 = (t30 + 1920U);
    t34 = (t31 + 56U);
    t35 = *((char **)t34);
    xsi_vlog_generic_convert_bit_index(t19, t28, 2, t35, 32, 1);
    t36 = (t19 + 4);
    t42 = *((unsigned int *)t36);
    t43 = (!(t42));
    if (t43 == 1)
        goto LAB12;

LAB13:    xsi_set_current_line(62, ng46);
    t3 = (t2 + 96U);
    t4 = *((char **)t3);
    t5 = (t4 + 1920U);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t7, 32, t8, 32);
    t9 = (t2 + 96U);
    t10 = *((char **)t9);
    t12 = (t10 + 1920U);
    xsi_vlogvar_assign_value(t12, t11, 0, 0, 32);
    goto LAB3;

LAB12:    xsi_vlogvar_assign_value(t22, t18, 0, *((unsigned int *)t19), 1);
    goto LAB13;

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

LAB2:    t4 = (t1 + 2256);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(83, ng46);

LAB5:    xsi_set_current_line(84, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 2256);
    xsi_vlogfile_write(1, 0, 0, ng50, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(85, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 15624);
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

LAB2:    t4 = (t1 + 2688);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(99, ng46);

LAB5:    xsi_set_current_line(100, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 2688);
    xsi_vlogfile_write(1, 0, 0, ng51, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(101, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 15784);
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

LAB2:    t4 = (t1 + 3120);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(115, ng46);

LAB5:    xsi_set_current_line(116, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 3120);
    xsi_vlogfile_write(1, 0, 0, ng52, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(117, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 15464);
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

LAB2:    t4 = (t1 + 3552);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(131, ng46);

LAB5:    xsi_set_current_line(132, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 3552);
    xsi_vlogfile_write(1, 0, 0, ng53, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)119, t12, 32);
    xsi_set_current_line(133, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 15144);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

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

LAB2:    t4 = (t1 + 3984);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(147, ng46);

LAB5:    xsi_set_current_line(148, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 3984);
    xsi_vlogfile_write(1, 0, 0, ng54, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(149, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 15944);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

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

LAB2:    t4 = (t1 + 4416);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(165, ng46);

LAB5:    xsi_set_current_line(166, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 4416);
    xsi_vlogfile_write(1, 0, 0, ng55, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(167, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 15304);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

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

LAB2:    t4 = (t1 + 4848);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(187, ng46);

LAB5:    xsi_set_current_line(188, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 4848);
    xsi_vlogfile_write(1, 0, 0, ng56, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)119, t12, 32);
    xsi_set_current_line(189, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 14984);
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

LAB2:    t4 = (t1 + 5280);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(204, ng46);

LAB5:    xsi_set_current_line(205, ng46);
    t6 = (t1 + 12984U);
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

LAB10:    xsi_set_current_line(205, ng46);

LAB13:    xsi_set_current_line(206, ng46);
    t20 = (t1 + 14984);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);

LAB14:    t23 = ((char*)((ng47)));
    t24 = xsi_vlog_signed_case_compare(t22, 32, t23, 32);
    if (t24 == 1)
        goto LAB15;

LAB16:    t4 = ((char*)((ng58)));
    t24 = xsi_vlog_signed_case_compare(t22, 32, t4, 32);
    if (t24 == 1)
        goto LAB17;

LAB18:    t4 = ((char*)((ng61)));
    t24 = xsi_vlog_signed_case_compare(t22, 32, t4, 32);
    if (t24 == 1)
        goto LAB19;

LAB20:
LAB21:    goto LAB12;

LAB15:    xsi_set_current_line(207, ng46);

LAB22:    xsi_set_current_line(208, ng46);
    t26 = xsi_vlog_time(t25, 10000.000000000000, 1000.0000000000000);
    t27 = ((char*)((ng34)));
    t28 = (t1 + 5280);
    xsi_vlogfile_write(1, 0, 0, ng57, 3, t28, (char)118, t25, 64, (char)118, t27, 64);
    xsi_set_current_line(209, ng46);

LAB23:    t4 = (t1 + 12984U);
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

LAB17:    xsi_set_current_line(211, ng46);

LAB31:    xsi_set_current_line(212, ng46);
    t6 = xsi_vlog_time(t25, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t13 = (t1 + 5280);
    xsi_vlogfile_write(1, 0, 0, ng59, 3, t13, (char)118, t25, 64, (char)118, t7, 64);
    xsi_set_current_line(213, ng46);
    t4 = (t1 + 15464);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t13 = ((char*)((ng47)));
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
LAB38:    xsi_set_current_line(217, ng46);
    t4 = (t1 + 18664);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t13 = ((char*)((ng47)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t7, 32, t13, 32);
    t14 = (t1 + 18664);
    xsi_vlogvar_assign_value(t14, t5, 0, 0, 32);
    goto LAB21;

LAB19:    xsi_set_current_line(219, ng46);

LAB40:    xsi_set_current_line(220, ng46);
    t6 = xsi_vlog_time(t25, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t13 = (t1 + 5280);
    xsi_vlogfile_write(1, 0, 0, ng62, 3, t13, (char)118, t25, 64, (char)118, t7, 64);
    xsi_set_current_line(221, ng46);
    t4 = (t1 + 18824);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t13 = ((char*)((ng47)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t7, 32, t13, 32);
    t14 = (t1 + 18824);
    xsi_vlogvar_assign_value(t14, t5, 0, 0, 32);
    goto LAB21;

LAB24:    *((unsigned int *)t5) = 1;
    goto LAB27;

LAB28:    xsi_set_current_line(209, ng46);
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

LAB36:    xsi_set_current_line(213, ng46);

LAB39:    xsi_set_current_line(214, ng46);
    t26 = (t1 + 5280);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t26);
    xsi_set_current_line(215, ng46);
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

LAB2:    t4 = (t1 + 5712);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(236, ng46);

LAB5:    xsi_set_current_line(237, ng46);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 5712);
    xsi_vlogfile_write(1, 0, 0, ng63, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)119, t12, 32);
    xsi_set_current_line(238, ng46);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 14824);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

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
    xsi_set_current_line(253, ng46);

LAB2:    xsi_set_current_line(254, ng46);
    t4 = xsi_vlog_time(t3, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng34)));
    t6 = (t1 + 18664);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t1 + 18824);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t1 + 18984);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t1 + 6144);
    xsi_vlogfile_write(1, 0, 0, ng64, 6, t15, (char)118, t3, 64, (char)118, t5, 64, (char)119, t8, 32, (char)119, t11, 32, (char)119, t14, 32);
    xsi_set_current_line(255, ng46);
    t4 = (t1 + 18664);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 18824);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t16, 0, 8);
    xsi_vlog_signed_add(t16, 32, t6, 32, t9, 32);
    t10 = (t1 + 18984);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memset(t17, 0, 8);
    xsi_vlog_signed_add(t17, 32, t16, 32, t12, 32);
    t13 = (t2 + 96U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    xsi_vlogvar_assign_value(t15, t17, 0, 0, 32);
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

LAB2:    t4 = (t1 + 6576);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(271, ng46);

LAB5:    xsi_set_current_line(272, ng46);
    t5 = ((char*)((ng47)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    xsi_vlogvar_assign_value(t8, t5, 0, 0, 1);
    xsi_set_current_line(273, ng46);

LAB6:    t4 = (t1 + 18984);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 880);
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

LAB8:    xsi_set_current_line(280, ng46);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t15 = ((char*)((ng49)));
    memset(t9, 0, 8);
    t16 = (t8 + 4);
    t17 = (t15 + 4);
    t10 = *((unsigned int *)t8);
    t11 = *((unsigned int *)t15);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t16);
    t14 = *((unsigned int *)t17);
    t24 = (t13 ^ t14);
    t25 = (t12 | t24);
    t26 = *((unsigned int *)t16);
    t27 = *((unsigned int *)t17);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB22;

LAB19:    if (t28 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t9) = 1;

LAB22:    t19 = (t9 + 4);
    t31 = *((unsigned int *)t19);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB23;

LAB24:
LAB25:    xsi_set_current_line(284, ng46);
    t4 = (t1 + 18984);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t6, 32, t7, 32);
    t8 = (t1 + 18984);
    xsi_vlogvar_assign_value(t8, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    xsi_set_current_line(273, ng46);

LAB9:    xsi_set_current_line(274, ng46);
    t15 = (t2 + 96U);
    t16 = *((char **)t15);
    t17 = (t16 + 0U);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = ((char*)((ng47)));
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
LAB16:    xsi_set_current_line(278, ng46);
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

LAB14:    xsi_set_current_line(274, ng46);

LAB17:    xsi_set_current_line(275, ng46);
    t44 = xsi_vlog_time(t43, 10000.000000000000, 1000.0000000000000);
    t45 = ((char*)((ng34)));
    t46 = (t1 + 18984);
    t47 = (t46 + 56U);
    t48 = *((char **)t47);
    t49 = (t1 + 6576);
    xsi_vlogfile_write(1, 0, 0, ng65, 4, t49, (char)118, t43, 64, (char)118, t45, 64, (char)119, t48, 32);
    xsi_set_current_line(276, ng46);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    goto LAB16;

LAB18:    goto LAB6;

LAB21:    t18 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB22;

LAB23:    xsi_set_current_line(280, ng46);

LAB26:    xsi_set_current_line(281, ng46);
    t20 = xsi_vlog_time(t43, 10000.000000000000, 1000.0000000000000);
    t22 = ((char*)((ng34)));
    t23 = (t1 + 6576);
    xsi_vlogfile_write(1, 0, 0, ng66, 3, t23, (char)118, t43, 64, (char)118, t22, 64);
    goto LAB25;

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

LAB2:    t4 = (t1 + 7008);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(296, ng46);

LAB5:    xsi_set_current_line(297, ng46);
    t5 = (t1 + 18984);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_minus(t9, 32, t7, 32, t8, 32);
    t10 = (t1 + 18984);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_SEND_WRITE_ADDRESS(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t48[8];
    char t66[8];
    char t67[8];
    char t68[8];
    char t69[8];
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
    int t47;
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
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    int t70;
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
    char *t84;
    char *t85;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 7440);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(303, ng30);

LAB5:    xsi_set_current_line(307, ng30);
    t5 = (t1 + 15624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(314, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 5280);
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
    t47 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t47 == -1)
        goto LAB17;

LAB18:    if (t47 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 5280);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 5280);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(325, ng30);
    t4 = (t1 + 18344);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng70)));
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
LAB26:    xsi_set_current_line(328, ng30);
    t4 = ((char*)((ng70)));
    t5 = (t1 + 18344);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(330, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB35);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 6576);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB37:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t47 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t47 == -1)
        goto LAB38;

LAB39:    if (t47 != 0)
        goto LAB40;

LAB35:    t32 = (t1 + 6576);
    xsi_vlog_subprogram_popinvocation(t32);

LAB36:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 6576);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(335, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 16424);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 32, 0LL);
    xsi_set_current_line(336, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 16584);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 3, 0LL);
    xsi_set_current_line(337, ng30);
    t4 = ((char*)((ng47)));
    t5 = (t1 + 16744);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(343, ng30);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 16U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB41;

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

LAB10:    xsi_set_current_line(307, ng30);

LAB13:    xsi_set_current_line(308, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 7440);
    xsi_vlogfile_write(0, 0, 0, ng67, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 7440);
    xsi_vlogfile_write(0, 0, 0, ng68, 2, t40, (char)118, t39, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 7440);
    xsi_vlogfile_write(1, 0, 0, ng69, 2, t46, (char)118, t45, 3);
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

LAB24:    xsi_set_current_line(325, ng30);

LAB27:    xsi_set_current_line(326, ng30);

LAB28:    t25 = (t1 + 18344);
    t32 = (t25 + 56U);
    t33 = *((char **)t32);
    t34 = ((char*)((ng71)));
    memset(t48, 0, 8);
    t35 = (t33 + 4);
    t36 = (t34 + 4);
    t49 = *((unsigned int *)t33);
    t50 = *((unsigned int *)t34);
    t51 = (t49 ^ t50);
    t52 = *((unsigned int *)t35);
    t53 = *((unsigned int *)t36);
    t54 = (t52 ^ t53);
    t55 = (t51 | t54);
    t56 = *((unsigned int *)t35);
    t57 = *((unsigned int *)t36);
    t58 = (t56 | t57);
    t59 = (~(t58));
    t60 = (t55 & t59);
    if (t60 != 0)
        goto LAB32;

LAB29:    if (t58 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t48) = 1;

LAB32:    t38 = (t48 + 4);
    t61 = *((unsigned int *)t38);
    t62 = (~(t61));
    t63 = *((unsigned int *)t48);
    t64 = (t63 & t62);
    t65 = (t64 != 0);
    if (t65 > 0)
        goto LAB34;

LAB33:    t39 = (t2 + 88U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    xsi_wp_set_status(t41, 1);
    t42 = (t2 + 48U);
    *((char **)t42) = &&LAB28;
    goto LAB1;

LAB31:    t37 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB32;

LAB34:    t43 = (t2 + 88U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    xsi_wp_set_status(t45, 0);
    goto LAB26;

LAB38:    t0 = -1;
    goto LAB1;

LAB40:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB37;
    goto LAB1;

LAB41:    xsi_set_current_line(344, ng30);

LAB42:    t4 = (t1 + 13304U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng47)));
    memset(t48, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB45;

LAB43:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB45;

LAB44:    *((unsigned int *)t48) = 1;

LAB45:    memset(t66, 0, 8);
    t8 = (t48 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t48);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB46;

LAB47:    if (*((unsigned int *)t8) != 0)
        goto LAB48;

LAB49:    t11 = (t66 + 4);
    t17 = *((unsigned int *)t66);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB50;

LAB51:    memcpy(t69, t66, 8);

LAB52:    memset(t9, 0, 8);
    t43 = (t69 + 4);
    t74 = *((unsigned int *)t43);
    t75 = (~(t74));
    t76 = *((unsigned int *)t69);
    t77 = (t76 & t75);
    t78 = (t77 & 1U);
    if (t78 != 0)
        goto LAB66;

LAB64:    if (*((unsigned int *)t43) == 0)
        goto LAB63;

LAB65:    t44 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t44) = 1;

LAB66:    t45 = (t9 + 4);
    t79 = *((unsigned int *)t45);
    t80 = (~(t79));
    t81 = *((unsigned int *)t9);
    t82 = (t81 & t80);
    t83 = (t82 != 0);
    if (t83 > 0)
        goto LAB67;

LAB68:    xsi_set_current_line(345, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 16744);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(347, ng30);
    t4 = (t1 + 15944);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng70)));
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
        goto LAB73;

LAB70:    if (t21 != 0)
        goto LAB72;

LAB71:    *((unsigned int *)t9) = 1;

LAB73:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB74;

LAB75:
LAB76:    xsi_set_current_line(355, ng30);
    t4 = ((char*)((ng71)));
    t5 = (t1 + 18344);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(360, ng30);
    t4 = (t1 + 23000);
    xsi_trigger(t4, -1, -1);
    goto LAB4;

LAB46:    *((unsigned int *)t66) = 1;
    goto LAB49;

LAB48:    t10 = (t66 + 4);
    *((unsigned int *)t66) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB49;

LAB50:    t24 = (t1 + 16744);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng47)));
    memset(t67, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t33))
        goto LAB55;

LAB53:    t34 = (t32 + 4);
    t35 = (t33 + 4);
    if (*((unsigned int *)t34) != *((unsigned int *)t35))
        goto LAB55;

LAB54:    *((unsigned int *)t67) = 1;

LAB55:    memset(t68, 0, 8);
    t36 = (t67 + 4);
    t20 = *((unsigned int *)t36);
    t21 = (~(t20));
    t22 = *((unsigned int *)t67);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t36) != 0)
        goto LAB58;

LAB59:    t27 = *((unsigned int *)t66);
    t28 = *((unsigned int *)t68);
    t29 = (t27 & t28);
    *((unsigned int *)t69) = t29;
    t38 = (t66 + 4);
    t39 = (t68 + 4);
    t40 = (t69 + 4);
    t30 = *((unsigned int *)t38);
    t49 = *((unsigned int *)t39);
    t50 = (t30 | t49);
    *((unsigned int *)t40) = t50;
    t51 = *((unsigned int *)t40);
    t52 = (t51 != 0);
    if (t52 == 1)
        goto LAB60;

LAB61:
LAB62:    goto LAB52;

LAB56:    *((unsigned int *)t68) = 1;
    goto LAB59;

LAB58:    t37 = (t68 + 4);
    *((unsigned int *)t68) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB59;

LAB60:    t53 = *((unsigned int *)t69);
    t54 = *((unsigned int *)t40);
    *((unsigned int *)t69) = (t53 | t54);
    t41 = (t66 + 4);
    t42 = (t68 + 4);
    t55 = *((unsigned int *)t66);
    t56 = (~(t55));
    t57 = *((unsigned int *)t41);
    t58 = (~(t57));
    t59 = *((unsigned int *)t68);
    t60 = (~(t59));
    t61 = *((unsigned int *)t42);
    t62 = (~(t61));
    t47 = (t56 & t58);
    t70 = (t60 & t62);
    t63 = (~(t47));
    t64 = (~(t70));
    t65 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t65 & t63);
    t71 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t71 & t64);
    t72 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t72 & t63);
    t73 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t73 & t64);
    goto LAB62;

LAB63:    *((unsigned int *)t9) = 1;
    goto LAB66;

LAB67:    xsi_set_current_line(344, ng30);
    t46 = (t2 + 88U);
    t84 = *((char **)t46);
    t85 = (t84 + 32U);
    xsi_wp_set_status(t85, 1);
    *((char **)t3) = &&LAB69;
    goto LAB1;

LAB69:    goto LAB42;

LAB72:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB73;

LAB74:    xsi_set_current_line(347, ng30);

LAB77:    xsi_set_current_line(348, ng30);
    t25 = ((char*)((ng49)));
    t32 = (t1 + 16424);
    xsi_vlogvar_wait_assign_value(t32, t25, 0, 0, 32, 0LL);
    xsi_set_current_line(349, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 16584);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 3, 0LL);
    goto LAB76;

}

static int sp_SEND_WRITE_DATA(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t48[8];
    char t66[8];
    char t67[8];
    char t68[8];
    char t69[8];
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
    int t47;
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
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    int t70;
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
    char *t84;
    char *t85;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 7872);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(387, ng30);

LAB5:    xsi_set_current_line(391, ng30);
    t5 = (t1 + 15624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(398, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 5280);
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
    t47 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t47 == -1)
        goto LAB17;

LAB18:    if (t47 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 5280);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 5280);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(406, ng30);
    t4 = (t1 + 18504);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng70)));
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
LAB26:    xsi_set_current_line(409, ng30);
    t4 = ((char*)((ng70)));
    t5 = (t1 + 18504);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(414, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 17064);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 4, 0LL);
    xsi_set_current_line(415, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 16904);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 32, 0LL);
    xsi_set_current_line(416, ng30);
    t4 = ((char*)((ng47)));
    t5 = (t1 + 17224);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(422, ng30);
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

LAB10:    xsi_set_current_line(391, ng30);

LAB13:    xsi_set_current_line(392, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 7872);
    xsi_vlogfile_write(0, 0, 0, ng72, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 7872);
    xsi_vlogfile_write(0, 0, 0, ng73, 2, t40, (char)118, t39, 4);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 7872);
    xsi_vlogfile_write(1, 0, 0, ng74, 2, t46, (char)118, t45, 32);
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

LAB24:    xsi_set_current_line(406, ng30);

LAB27:    xsi_set_current_line(407, ng30);

LAB28:    t25 = (t1 + 18504);
    t32 = (t25 + 56U);
    t33 = *((char **)t32);
    t34 = ((char*)((ng71)));
    memset(t48, 0, 8);
    t35 = (t33 + 4);
    t36 = (t34 + 4);
    t49 = *((unsigned int *)t33);
    t50 = *((unsigned int *)t34);
    t51 = (t49 ^ t50);
    t52 = *((unsigned int *)t35);
    t53 = *((unsigned int *)t36);
    t54 = (t52 ^ t53);
    t55 = (t51 | t54);
    t56 = *((unsigned int *)t35);
    t57 = *((unsigned int *)t36);
    t58 = (t56 | t57);
    t59 = (~(t58));
    t60 = (t55 & t59);
    if (t60 != 0)
        goto LAB32;

LAB29:    if (t58 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t48) = 1;

LAB32:    t38 = (t48 + 4);
    t61 = *((unsigned int *)t38);
    t62 = (~(t61));
    t63 = *((unsigned int *)t48);
    t64 = (t63 & t62);
    t65 = (t64 != 0);
    if (t65 > 0)
        goto LAB34;

LAB33:    t39 = (t2 + 88U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    xsi_wp_set_status(t41, 1);
    t42 = (t2 + 48U);
    *((char **)t42) = &&LAB28;
    goto LAB1;

LAB31:    t37 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB32;

LAB34:    t43 = (t2 + 88U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    xsi_wp_set_status(t45, 0);
    goto LAB26;

LAB35:    xsi_set_current_line(423, ng30);

LAB36:    t4 = (t1 + 13464U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng47)));
    memset(t48, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB39;

LAB37:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB39;

LAB38:    *((unsigned int *)t48) = 1;

LAB39:    memset(t66, 0, 8);
    t8 = (t48 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t48);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB40;

LAB41:    if (*((unsigned int *)t8) != 0)
        goto LAB42;

LAB43:    t11 = (t66 + 4);
    t17 = *((unsigned int *)t66);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB44;

LAB45:    memcpy(t69, t66, 8);

LAB46:    memset(t9, 0, 8);
    t43 = (t69 + 4);
    t74 = *((unsigned int *)t43);
    t75 = (~(t74));
    t76 = *((unsigned int *)t69);
    t77 = (t76 & t75);
    t78 = (t77 & 1U);
    if (t78 != 0)
        goto LAB60;

LAB58:    if (*((unsigned int *)t43) == 0)
        goto LAB57;

LAB59:    t44 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t44) = 1;

LAB60:    t45 = (t9 + 4);
    t79 = *((unsigned int *)t45);
    t80 = (~(t79));
    t81 = *((unsigned int *)t9);
    t82 = (t81 & t80);
    t83 = (t82 != 0);
    if (t83 > 0)
        goto LAB61;

LAB62:    xsi_set_current_line(425, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 17224);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(427, ng30);
    t4 = (t1 + 15944);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng70)));
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
LAB70:    xsi_set_current_line(435, ng30);
    t4 = ((char*)((ng71)));
    t5 = (t1 + 18504);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(440, ng30);
    t4 = (t1 + 23336);
    xsi_trigger(t4, -1, -1);
    goto LAB4;

LAB40:    *((unsigned int *)t66) = 1;
    goto LAB43;

LAB42:    t10 = (t66 + 4);
    *((unsigned int *)t66) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB43;

LAB44:    t24 = (t1 + 17224);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng47)));
    memset(t67, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t33))
        goto LAB49;

LAB47:    t34 = (t32 + 4);
    t35 = (t33 + 4);
    if (*((unsigned int *)t34) != *((unsigned int *)t35))
        goto LAB49;

LAB48:    *((unsigned int *)t67) = 1;

LAB49:    memset(t68, 0, 8);
    t36 = (t67 + 4);
    t20 = *((unsigned int *)t36);
    t21 = (~(t20));
    t22 = *((unsigned int *)t67);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t36) != 0)
        goto LAB52;

LAB53:    t27 = *((unsigned int *)t66);
    t28 = *((unsigned int *)t68);
    t29 = (t27 & t28);
    *((unsigned int *)t69) = t29;
    t38 = (t66 + 4);
    t39 = (t68 + 4);
    t40 = (t69 + 4);
    t30 = *((unsigned int *)t38);
    t49 = *((unsigned int *)t39);
    t50 = (t30 | t49);
    *((unsigned int *)t40) = t50;
    t51 = *((unsigned int *)t40);
    t52 = (t51 != 0);
    if (t52 == 1)
        goto LAB54;

LAB55:
LAB56:    goto LAB46;

LAB50:    *((unsigned int *)t68) = 1;
    goto LAB53;

LAB52:    t37 = (t68 + 4);
    *((unsigned int *)t68) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB53;

LAB54:    t53 = *((unsigned int *)t69);
    t54 = *((unsigned int *)t40);
    *((unsigned int *)t69) = (t53 | t54);
    t41 = (t66 + 4);
    t42 = (t68 + 4);
    t55 = *((unsigned int *)t66);
    t56 = (~(t55));
    t57 = *((unsigned int *)t41);
    t58 = (~(t57));
    t59 = *((unsigned int *)t68);
    t60 = (~(t59));
    t61 = *((unsigned int *)t42);
    t62 = (~(t61));
    t47 = (t56 & t58);
    t70 = (t60 & t62);
    t63 = (~(t47));
    t64 = (~(t70));
    t65 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t65 & t63);
    t71 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t71 & t64);
    t72 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t72 & t63);
    t73 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t73 & t64);
    goto LAB56;

LAB57:    *((unsigned int *)t9) = 1;
    goto LAB60;

LAB61:    xsi_set_current_line(423, ng30);
    t46 = (t2 + 88U);
    t84 = *((char **)t46);
    t85 = (t84 + 32U);
    xsi_wp_set_status(t85, 1);
    *((char **)t3) = &&LAB63;
    goto LAB1;

LAB63:    goto LAB36;

LAB66:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB67;

LAB68:    xsi_set_current_line(427, ng30);

LAB71:    xsi_set_current_line(428, ng30);
    t25 = ((char*)((ng49)));
    t32 = (t1 + 17064);
    xsi_vlogvar_wait_assign_value(t32, t25, 0, 0, 4, 0LL);
    xsi_set_current_line(429, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 16904);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 32, 0LL);
    goto LAB70;

}

static int sp_SEND_READ_ADDRESS(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t48[8];
    char t66[8];
    char t67[8];
    char t68[8];
    char t69[8];
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
    int t47;
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
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    int t70;
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
    char *t84;
    char *t85;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 8304);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(467, ng30);

LAB5:    xsi_set_current_line(471, ng30);
    t5 = (t1 + 15624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(478, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 5280);
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
    t47 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t47 == -1)
        goto LAB17;

LAB18:    if (t47 != 0)
        goto LAB19;

LAB14:    t32 = (t1 + 5280);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 5280);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(489, ng30);
    t4 = (t1 + 18184);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng70)));
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
LAB26:    xsi_set_current_line(492, ng30);
    t4 = ((char*)((ng70)));
    t5 = (t1 + 18184);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(493, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB35);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 6576);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB37:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t47 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t47 == -1)
        goto LAB38;

LAB39:    if (t47 != 0)
        goto LAB40;

LAB35:    t32 = (t1 + 6576);
    xsi_vlog_subprogram_popinvocation(t32);

LAB36:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t1 + 6576);
    t41 = (t2 + 56U);
    t42 = *((char **)t41);
    xsi_delete_subprogram_invocation(t39, t40, t1, t42, t2);
    xsi_set_current_line(498, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 17544);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 32, 0LL);
    xsi_set_current_line(499, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 17704);
    xsi_vlogvar_wait_assign_value(t10, t8, 0, 0, 3, 0LL);
    xsi_set_current_line(500, ng30);
    t4 = ((char*)((ng47)));
    t5 = (t1 + 17864);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(506, ng30);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 16U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB41;

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

LAB10:    xsi_set_current_line(471, ng30);

LAB13:    xsi_set_current_line(472, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 8304);
    xsi_vlogfile_write(0, 0, 0, ng75, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 8304);
    xsi_vlogfile_write(0, 0, 0, ng68, 2, t40, (char)118, t39, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 8304);
    xsi_vlogfile_write(1, 0, 0, ng69, 2, t46, (char)118, t45, 3);
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

LAB24:    xsi_set_current_line(489, ng30);

LAB27:    xsi_set_current_line(490, ng30);

LAB28:    t25 = (t1 + 18184);
    t32 = (t25 + 56U);
    t33 = *((char **)t32);
    t34 = ((char*)((ng71)));
    memset(t48, 0, 8);
    t35 = (t33 + 4);
    t36 = (t34 + 4);
    t49 = *((unsigned int *)t33);
    t50 = *((unsigned int *)t34);
    t51 = (t49 ^ t50);
    t52 = *((unsigned int *)t35);
    t53 = *((unsigned int *)t36);
    t54 = (t52 ^ t53);
    t55 = (t51 | t54);
    t56 = *((unsigned int *)t35);
    t57 = *((unsigned int *)t36);
    t58 = (t56 | t57);
    t59 = (~(t58));
    t60 = (t55 & t59);
    if (t60 != 0)
        goto LAB32;

LAB29:    if (t58 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t48) = 1;

LAB32:    t38 = (t48 + 4);
    t61 = *((unsigned int *)t38);
    t62 = (~(t61));
    t63 = *((unsigned int *)t48);
    t64 = (t63 & t62);
    t65 = (t64 != 0);
    if (t65 > 0)
        goto LAB34;

LAB33:    t39 = (t2 + 88U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    xsi_wp_set_status(t41, 1);
    t42 = (t2 + 48U);
    *((char **)t42) = &&LAB28;
    goto LAB1;

LAB31:    t37 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB32;

LAB34:    t43 = (t2 + 88U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    xsi_wp_set_status(t45, 0);
    goto LAB26;

LAB38:    t0 = -1;
    goto LAB1;

LAB40:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB37;
    goto LAB1;

LAB41:    xsi_set_current_line(507, ng30);

LAB42:    t4 = (t1 + 13944U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng47)));
    memset(t48, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB45;

LAB43:    t6 = (t5 + 4);
    t7 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB45;

LAB44:    *((unsigned int *)t48) = 1;

LAB45:    memset(t66, 0, 8);
    t8 = (t48 + 4);
    t12 = *((unsigned int *)t8);
    t13 = (~(t12));
    t14 = *((unsigned int *)t48);
    t15 = (t14 & t13);
    t16 = (t15 & 1U);
    if (t16 != 0)
        goto LAB46;

LAB47:    if (*((unsigned int *)t8) != 0)
        goto LAB48;

LAB49:    t11 = (t66 + 4);
    t17 = *((unsigned int *)t66);
    t18 = *((unsigned int *)t11);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB50;

LAB51:    memcpy(t69, t66, 8);

LAB52:    memset(t9, 0, 8);
    t43 = (t69 + 4);
    t74 = *((unsigned int *)t43);
    t75 = (~(t74));
    t76 = *((unsigned int *)t69);
    t77 = (t76 & t75);
    t78 = (t77 & 1U);
    if (t78 != 0)
        goto LAB66;

LAB64:    if (*((unsigned int *)t43) == 0)
        goto LAB63;

LAB65:    t44 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t44) = 1;

LAB66:    t45 = (t9 + 4);
    t79 = *((unsigned int *)t45);
    t80 = (~(t79));
    t81 = *((unsigned int *)t9);
    t82 = (t81 & t80);
    t83 = (t82 != 0);
    if (t83 > 0)
        goto LAB67;

LAB68:    xsi_set_current_line(508, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 17864);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(510, ng30);
    t4 = (t1 + 15944);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng70)));
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
        goto LAB73;

LAB70:    if (t21 != 0)
        goto LAB72;

LAB71:    *((unsigned int *)t9) = 1;

LAB73:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB74;

LAB75:
LAB76:    xsi_set_current_line(518, ng30);
    t4 = ((char*)((ng71)));
    t5 = (t1 + 18184);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(523, ng30);
    t4 = (t1 + 22832);
    xsi_trigger(t4, -1, -1);
    goto LAB4;

LAB46:    *((unsigned int *)t66) = 1;
    goto LAB49;

LAB48:    t10 = (t66 + 4);
    *((unsigned int *)t66) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB49;

LAB50:    t24 = (t1 + 17864);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng47)));
    memset(t67, 0, 8);
    if (*((unsigned int *)t32) != *((unsigned int *)t33))
        goto LAB55;

LAB53:    t34 = (t32 + 4);
    t35 = (t33 + 4);
    if (*((unsigned int *)t34) != *((unsigned int *)t35))
        goto LAB55;

LAB54:    *((unsigned int *)t67) = 1;

LAB55:    memset(t68, 0, 8);
    t36 = (t67 + 4);
    t20 = *((unsigned int *)t36);
    t21 = (~(t20));
    t22 = *((unsigned int *)t67);
    t23 = (t22 & t21);
    t26 = (t23 & 1U);
    if (t26 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t36) != 0)
        goto LAB58;

LAB59:    t27 = *((unsigned int *)t66);
    t28 = *((unsigned int *)t68);
    t29 = (t27 & t28);
    *((unsigned int *)t69) = t29;
    t38 = (t66 + 4);
    t39 = (t68 + 4);
    t40 = (t69 + 4);
    t30 = *((unsigned int *)t38);
    t49 = *((unsigned int *)t39);
    t50 = (t30 | t49);
    *((unsigned int *)t40) = t50;
    t51 = *((unsigned int *)t40);
    t52 = (t51 != 0);
    if (t52 == 1)
        goto LAB60;

LAB61:
LAB62:    goto LAB52;

LAB56:    *((unsigned int *)t68) = 1;
    goto LAB59;

LAB58:    t37 = (t68 + 4);
    *((unsigned int *)t68) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB59;

LAB60:    t53 = *((unsigned int *)t69);
    t54 = *((unsigned int *)t40);
    *((unsigned int *)t69) = (t53 | t54);
    t41 = (t66 + 4);
    t42 = (t68 + 4);
    t55 = *((unsigned int *)t66);
    t56 = (~(t55));
    t57 = *((unsigned int *)t41);
    t58 = (~(t57));
    t59 = *((unsigned int *)t68);
    t60 = (~(t59));
    t61 = *((unsigned int *)t42);
    t62 = (~(t61));
    t47 = (t56 & t58);
    t70 = (t60 & t62);
    t63 = (~(t47));
    t64 = (~(t70));
    t65 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t65 & t63);
    t71 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t71 & t64);
    t72 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t72 & t63);
    t73 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t73 & t64);
    goto LAB62;

LAB63:    *((unsigned int *)t9) = 1;
    goto LAB66;

LAB67:    xsi_set_current_line(507, ng30);
    t46 = (t2 + 88U);
    t84 = *((char **)t46);
    t85 = (t84 + 32U);
    xsi_wp_set_status(t85, 1);
    *((char **)t3) = &&LAB69;
    goto LAB1;

LAB69:    goto LAB42;

LAB72:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB73;

LAB74:    xsi_set_current_line(510, ng30);

LAB77:    xsi_set_current_line(511, ng30);
    t25 = ((char*)((ng49)));
    t32 = (t1 + 17544);
    xsi_vlogvar_wait_assign_value(t32, t25, 0, 0, 32, 0LL);
    xsi_set_current_line(512, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 17704);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 3, 0LL);
    goto LAB76;

}

static int sp_RECEIVE_READ_DATA(char *t1, char *t2)
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

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 8736);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(551, ng30);

LAB5:    xsi_set_current_line(555, ng30);
    t5 = (t1 + 15624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(560, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 5280);
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

LAB14:    t32 = (t1 + 5280);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 5280);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);
    xsi_set_current_line(568, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 480U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(569, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 320U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(570, ng30);

LAB20:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 480U);
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

LAB26:    xsi_set_current_line(582, ng30);
    t4 = (t1 + 14104U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 32);
    xsi_set_current_line(583, ng30);
    t4 = (t1 + 14264U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 160U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 2);
    xsi_set_current_line(588, ng30);
    t4 = (t1 + 15624);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
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
        goto LAB56;

LAB53:    if (t21 != 0)
        goto LAB55;

LAB54:    *((unsigned int *)t9) = 1;

LAB56:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB57;

LAB58:
LAB59:    xsi_set_current_line(598, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng49)));
    t11 = (t2 + 56U);
    t24 = *((char **)t11);
    t25 = (t2 + 56U);
    t32 = *((char **)t25);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t32, &&LAB61);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t1 + 12192);
    t36 = xsi_create_subprogram_invocation(t34, 0, t1, t35, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t35, t36);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t40 = (t38 + 0U);
    xsi_vlogvar_assign_value(t40, t8, 0, 0, 2);
    t41 = (t36 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    xsi_vlogvar_assign_value(t43, t10, 0, 0, 1);

LAB63:    t69 = (t2 + 64U);
    t70 = *((char **)t69);
    t71 = (t70 + 80U);
    t72 = *((char **)t71);
    t73 = (t72 + 272U);
    t74 = *((char **)t73);
    t75 = (t74 + 0U);
    t76 = *((char **)t75);
    t39 = ((int  (*)(char *, char *))t76)(t1, t70);
    if (t39 == -1)
        goto LAB64;

LAB65:    if (t39 != 0)
        goto LAB66;

LAB61:    t70 = (t1 + 12192);
    xsi_vlog_subprogram_popinvocation(t70);

LAB62:    t77 = (t2 + 64U);
    t78 = *((char **)t77);
    t77 = (t1 + 12192);
    t79 = (t2 + 56U);
    t80 = *((char **)t79);
    xsi_delete_subprogram_invocation(t77, t78, t1, t80, t2);
    xsi_set_current_line(603, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 18024);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(604, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB67);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 7008);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB69:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t39 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t39 == -1)
        goto LAB70;

LAB71:    if (t39 != 0)
        goto LAB72;

LAB67:    t32 = (t1 + 7008);
    xsi_vlog_subprogram_popinvocation(t32);

LAB68:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 7008);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);
    xsi_set_current_line(609, ng30);
    t4 = (t1 + 23168);
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

LAB10:    xsi_set_current_line(555, ng30);

LAB13:    xsi_set_current_line(556, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 8736);
    xsi_vlogfile_write(1, 0, 0, ng76, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB21:    *((unsigned int *)t9) = 1;
    goto LAB24;

LAB25:    xsi_set_current_line(570, ng30);
    t25 = (t2 + 88U);
    t32 = *((char **)t25);
    t33 = (t32 + 0U);
    xsi_wp_set_status(t33, 1);
    *((char **)t3) = &&LAB27;
    goto LAB1;

LAB27:    xsi_set_current_line(570, ng30);

LAB28:    xsi_set_current_line(571, ng30);
    t34 = ((char*)((ng47)));
    t35 = (t1 + 18024);
    xsi_vlogvar_wait_assign_value(t35, t34, 0, 0, 1, 0LL);
    xsi_set_current_line(572, ng30);
    t4 = (t1 + 14424U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng47)));
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
    t71 = (t70 + 480U);
    xsi_vlogvar_assign_value(t71, t47, 0, 0, 1);
    xsi_set_current_line(574, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 320U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(575, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 15144);
    t11 = (t10 + 56U);
    t24 = *((char **)t11);
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t8, 32, t24, 32);
    t25 = (t9 + 4);
    t12 = *((unsigned int *)t25);
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

LAB36:    t24 = (t1 + 18024);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng47)));
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

LAB49:    xsi_set_current_line(575, ng30);

LAB52:    xsi_set_current_line(576, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 8736);
    xsi_vlogfile_write(0, 0, 0, ng77, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t1 + 8736);
    xsi_vlogfile_write(1, 0, 0, ng78, 1, t35);
    xsi_set_current_line(578, ng30);
    xsi_vlog_stop(1);
    goto LAB51;

LAB55:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB56;

LAB57:    xsi_set_current_line(588, ng30);

LAB60:    xsi_set_current_line(589, ng30);
    t25 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t32 = ((char*)((ng34)));
    t33 = (t1 + 8736);
    xsi_vlogfile_write(0, 0, 0, ng79, 3, t33, (char)118, t31, 64, (char)118, t32, 64);
    t34 = (t2 + 96U);
    t35 = *((char **)t34);
    t36 = (t35 + 0U);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t40 = (t1 + 8736);
    xsi_vlogfile_write(0, 0, 0, ng80, 2, t40, (char)118, t38, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t69 = (t43 + 56U);
    t70 = *((char **)t69);
    t71 = (t1 + 8736);
    xsi_vlogfile_write(1, 0, 0, ng81, 2, t71, (char)118, t70, 2);
    goto LAB59;

LAB64:    t0 = -1;
    goto LAB1;

LAB66:    t69 = (t2 + 48U);
    *((char **)t69) = &&LAB63;
    goto LAB1;

LAB70:    t0 = -1;
    goto LAB1;

LAB72:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB69;
    goto LAB1;

}

static int sp_RECEIVE_WRITE_RESPONSE(char *t1, char *t2)
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

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 9168);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(638, ng30);

LAB5:    xsi_set_current_line(642, ng30);
    t5 = (t1 + 15624);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(647, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB14);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 5280);
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

LAB14:    t32 = (t1 + 5280);
    xsi_vlog_subprogram_popinvocation(t32);

LAB15:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 5280);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);
    xsi_set_current_line(655, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 320U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(656, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 160U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(657, ng30);

LAB20:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 320U);
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

LAB26:    xsi_set_current_line(668, ng30);
    t4 = (t1 + 13624U);
    t5 = *((char **)t4);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    xsi_vlogvar_assign_value(t7, t5, 0, 0, 2);
    xsi_set_current_line(673, ng30);
    t4 = (t1 + 15624);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
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
        goto LAB56;

LAB53:    if (t21 != 0)
        goto LAB55;

LAB54:    *((unsigned int *)t9) = 1;

LAB56:    t24 = (t9 + 4);
    t26 = *((unsigned int *)t24);
    t27 = (~(t26));
    t28 = *((unsigned int *)t9);
    t29 = (t28 & t27);
    t30 = (t29 != 0);
    if (t30 > 0)
        goto LAB57;

LAB58:
LAB59:    xsi_set_current_line(682, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng47)));
    t11 = (t2 + 56U);
    t24 = *((char **)t11);
    t25 = (t2 + 56U);
    t32 = *((char **)t25);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t32, &&LAB61);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t1 + 12192);
    t36 = xsi_create_subprogram_invocation(t34, 0, t1, t35, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t35, t36);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t40 = (t38 + 0U);
    xsi_vlogvar_assign_value(t40, t8, 0, 0, 2);
    t41 = (t36 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    xsi_vlogvar_assign_value(t43, t10, 0, 0, 1);

LAB63:    t69 = (t2 + 64U);
    t70 = *((char **)t69);
    t71 = (t70 + 80U);
    t72 = *((char **)t71);
    t73 = (t72 + 272U);
    t74 = *((char **)t73);
    t75 = (t74 + 0U);
    t76 = *((char **)t75);
    t39 = ((int  (*)(char *, char *))t76)(t1, t70);
    if (t39 == -1)
        goto LAB64;

LAB65:    if (t39 != 0)
        goto LAB66;

LAB61:    t70 = (t1 + 12192);
    xsi_vlog_subprogram_popinvocation(t70);

LAB62:    t77 = (t2 + 64U);
    t78 = *((char **)t77);
    t77 = (t1 + 12192);
    t79 = (t2 + 56U);
    t80 = *((char **)t79);
    xsi_delete_subprogram_invocation(t77, t78, t1, t80, t2);
    xsi_set_current_line(687, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t1 + 17384);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(688, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB67);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 7008);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB69:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t39 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t39 == -1)
        goto LAB70;

LAB71:    if (t39 != 0)
        goto LAB72;

LAB67:    t32 = (t1 + 7008);
    xsi_vlog_subprogram_popinvocation(t32);

LAB68:    t40 = (t2 + 64U);
    t41 = *((char **)t40);
    t40 = (t1 + 7008);
    t42 = (t2 + 56U);
    t43 = *((char **)t42);
    xsi_delete_subprogram_invocation(t40, t41, t1, t43, t2);
    xsi_set_current_line(693, ng30);
    t4 = (t1 + 23504);
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

LAB10:    xsi_set_current_line(642, ng30);

LAB13:    xsi_set_current_line(643, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 9168);
    xsi_vlogfile_write(1, 0, 0, ng82, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB16;
    goto LAB1;

LAB21:    *((unsigned int *)t9) = 1;
    goto LAB24;

LAB25:    xsi_set_current_line(657, ng30);
    t25 = (t2 + 88U);
    t32 = *((char **)t25);
    t33 = (t32 + 0U);
    xsi_wp_set_status(t33, 1);
    *((char **)t3) = &&LAB27;
    goto LAB1;

LAB27:    xsi_set_current_line(657, ng30);

LAB28:    xsi_set_current_line(658, ng30);
    t34 = ((char*)((ng47)));
    t35 = (t1 + 17384);
    xsi_vlogvar_wait_assign_value(t35, t34, 0, 0, 1, 0LL);
    xsi_set_current_line(659, ng30);
    t4 = (t1 + 13784U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng47)));
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
    t71 = (t70 + 320U);
    xsi_vlogvar_assign_value(t71, t47, 0, 0, 1);
    xsi_set_current_line(660, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 160U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    xsi_set_current_line(661, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 15144);
    t11 = (t10 + 56U);
    t24 = *((char **)t11);
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 32, t8, 32, t24, 32);
    t25 = (t9 + 4);
    t12 = *((unsigned int *)t25);
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

LAB36:    t24 = (t1 + 17384);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = ((char*)((ng47)));
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

LAB49:    xsi_set_current_line(661, ng30);

LAB52:    xsi_set_current_line(662, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 9168);
    xsi_vlogfile_write(0, 0, 0, ng83, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t1 + 9168);
    xsi_vlogfile_write(1, 0, 0, ng84, 1, t35);
    xsi_set_current_line(664, ng30);
    xsi_vlog_stop(1);
    goto LAB51;

LAB55:    t11 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB56;

LAB57:    xsi_set_current_line(673, ng30);

LAB60:    xsi_set_current_line(674, ng30);
    t25 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t32 = ((char*)((ng34)));
    t33 = (t1 + 9168);
    xsi_vlogfile_write(0, 0, 0, ng85, 3, t33, (char)118, t31, 64, (char)118, t32, 64);
    t34 = (t2 + 96U);
    t35 = *((char **)t34);
    t36 = (t35 + 0U);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t40 = (t1 + 9168);
    xsi_vlogfile_write(1, 0, 0, ng86, 2, t40, (char)118, t38, 2);
    goto LAB59;

LAB64:    t0 = -1;
    goto LAB1;

LAB66:    t69 = (t2 + 48U);
    *((char **)t69) = &&LAB63;
    goto LAB1;

LAB70:    t0 = -1;
    goto LAB1;

LAB72:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB69;
    goto LAB1;

}

static int sp_READ_BURST(char *t1, char *t2)
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
    int t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 9600);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(721, ng30);

LAB5:    xsi_set_current_line(725, ng30);
    t5 = (t1 + 15784);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(736, ng30);
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
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t36, &&LAB14);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    t39 = (t1 + 8304);
    t40 = xsi_create_subprogram_invocation(t38, 0, t1, t39, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t39, t40);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t40 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 160U);
    xsi_vlogvar_assign_value(t46, t32, 0, 0, 3);

LAB16:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t49 = (t48 + 80U);
    t50 = *((char **)t49);
    t51 = (t50 + 272U);
    t52 = *((char **)t51);
    t53 = (t52 + 0U);
    t54 = *((char **)t53);
    t55 = ((int  (*)(char *, char *))t54)(t1, t48);
    if (t55 == -1)
        goto LAB17;

LAB18:    if (t55 != 0)
        goto LAB19;

LAB14:    t48 = (t1 + 8304);
    xsi_vlog_subprogram_popinvocation(t48);

LAB15:    t56 = (t2 + 64U);
    t57 = *((char **)t56);
    t56 = (t1 + 8304);
    t58 = (t2 + 56U);
    t59 = *((char **)t58);
    xsi_delete_subprogram_invocation(t56, t57, t1, t59, t2);
    xsi_set_current_line(742, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB20);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 8736);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB22:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t55 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t55 == -1)
        goto LAB23;

LAB24:    if (t55 != 0)
        goto LAB25;

LAB20:    t32 = (t1 + 8736);
    xsi_vlog_subprogram_popinvocation(t32);

LAB21:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t40 + 96U);
    t41 = *((char **)t39);
    t42 = (t41 + 0U);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 96U);
    t46 = *((char **)t45);
    t47 = (t46 + 320U);
    xsi_vlogvar_assign_value(t47, t44, 0, 0, 32);
    t48 = (t40 + 96U);
    t49 = *((char **)t48);
    t50 = (t49 + 160U);
    t51 = (t50 + 56U);
    t52 = *((char **)t51);
    t53 = (t2 + 96U);
    t54 = *((char **)t53);
    t56 = (t54 + 480U);
    xsi_vlogvar_assign_value(t56, t52, 0, 0, 2);
    t57 = (t1 + 8736);
    t58 = (t2 + 56U);
    t59 = *((char **)t58);
    xsi_delete_subprogram_invocation(t57, t40, t1, t59, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(725, ng30);

LAB13:    xsi_set_current_line(726, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 9600);
    xsi_vlogfile_write(0, 0, 0, ng87, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 9600);
    xsi_vlogfile_write(0, 0, 0, ng68, 2, t40, (char)118, t39, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 9600);
    xsi_vlogfile_write(1, 0, 0, ng69, 2, t46, (char)118, t45, 3);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t47 = (t2 + 48U);
    *((char **)t47) = &&LAB16;
    goto LAB1;

LAB23:    t0 = -1;
    goto LAB1;

LAB25:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB22;
    goto LAB1;

}

static int sp_WRITE_BURST(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t60[8];
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
    int t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 10032);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(778, ng30);

LAB5:    xsi_set_current_line(782, ng30);
    t5 = (t1 + 15784);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(795, ng30);
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
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t36, &&LAB14);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    t39 = (t1 + 7440);
    t40 = xsi_create_subprogram_invocation(t38, 0, t1, t39, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t39, t40);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t40 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 160U);
    xsi_vlogvar_assign_value(t46, t32, 0, 0, 3);

LAB16:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t49 = (t48 + 80U);
    t50 = *((char **)t49);
    t51 = (t50 + 272U);
    t52 = *((char **)t51);
    t53 = (t52 + 0U);
    t54 = *((char **)t53);
    t55 = ((int  (*)(char *, char *))t54)(t1, t48);
    if (t55 == -1)
        goto LAB17;

LAB18:    if (t55 != 0)
        goto LAB19;

LAB14:    t48 = (t1 + 7440);
    xsi_vlog_subprogram_popinvocation(t48);

LAB15:    t56 = (t2 + 64U);
    t57 = *((char **)t56);
    t56 = (t1 + 7440);
    t58 = (t2 + 56U);
    t59 = *((char **)t58);
    xsi_delete_subprogram_invocation(t56, t57, t1, t59, t2);
    xsi_set_current_line(802, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t1 + 1824);
    t25 = xsi_create_subprogram_invocation(t11, 0, t1, t24, 0, t2);
    t32 = (t25 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 160U);
    xsi_vlogvar_assign_value(t34, t8, 0, 0, 32);

LAB20:    t35 = (t2 + 64U);
    t36 = *((char **)t35);
    t37 = (t36 + 80U);
    t38 = *((char **)t37);
    t39 = (t38 + 272U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    t42 = *((char **)t41);
    t55 = ((int  (*)(char *, char *))t42)(t1, t36);
    if (t55 != 0)
        goto LAB22;

LAB21:    t36 = (t2 + 64U);
    t43 = *((char **)t36);
    t36 = (t43 + 96U);
    t44 = *((char **)t36);
    t45 = (t44 + 0U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memcpy(t9, t47, 8);
    t48 = (t1 + 1824);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t48, t43, t1, t50, t2);
    t51 = (t2 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 800U);
    xsi_vlogvar_assign_value(t53, t9, 0, 0, 4);
    xsi_set_current_line(806, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 480U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 608);
    t11 = *((char **)t10);
    t10 = ((char*)((ng48)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t11, 32, t10, 32);
    memset(t60, 0, 8);
    xsi_vlog_signed_less(t60, 32, t8, 32, t9, 32);
    t24 = (t60 + 4);
    t12 = *((unsigned int *)t24);
    t13 = (~(t12));
    t14 = *((unsigned int *)t60);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB23;

LAB24:
LAB25:    xsi_set_current_line(814, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 320U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t36, &&LAB33);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    t39 = (t1 + 7872);
    t40 = xsi_create_subprogram_invocation(t38, 0, t1, t39, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t39, t40);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 4);
    t44 = (t40 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 160U);
    xsi_vlogvar_assign_value(t46, t32, 0, 0, 32);

LAB35:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t49 = (t48 + 80U);
    t50 = *((char **)t49);
    t51 = (t50 + 272U);
    t52 = *((char **)t51);
    t53 = (t52 + 0U);
    t54 = *((char **)t53);
    t55 = ((int  (*)(char *, char *))t54)(t1, t48);
    if (t55 == -1)
        goto LAB36;

LAB37:    if (t55 != 0)
        goto LAB38;

LAB33:    t48 = (t1 + 7872);
    xsi_vlog_subprogram_popinvocation(t48);

LAB34:    t56 = (t2 + 64U);
    t57 = *((char **)t56);
    t56 = (t1 + 7872);
    t58 = (t2 + 56U);
    t59 = *((char **)t58);
    xsi_delete_subprogram_invocation(t56, t57, t1, t59, t2);
    xsi_set_current_line(821, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB39);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 9168);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB41:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t55 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t55 == -1)
        goto LAB42;

LAB43:    if (t55 != 0)
        goto LAB44;

LAB39:    t32 = (t1 + 9168);
    xsi_vlog_subprogram_popinvocation(t32);

LAB40:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t40 + 96U);
    t41 = *((char **)t39);
    t42 = (t41 + 0U);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 96U);
    t46 = *((char **)t45);
    t47 = (t46 + 640U);
    xsi_vlogvar_assign_value(t47, t44, 0, 0, 2);
    t48 = (t1 + 9168);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t48, t40, t1, t50, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(782, ng30);

LAB13:    xsi_set_current_line(783, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 10032);
    xsi_vlogfile_write(0, 0, 0, ng88, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 10032);
    xsi_vlogfile_write(0, 0, 0, ng68, 2, t40, (char)118, t39, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 10032);
    xsi_vlogfile_write(0, 0, 0, ng69, 2, t46, (char)118, t45, 3);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 480U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 10032);
    xsi_vlogfile_write(1, 0, 0, ng89, 2, t52, (char)119, t51, 32);
    goto LAB12;

LAB17:    t0 = -1;
    goto LAB1;

LAB19:    t47 = (t2 + 48U);
    *((char **)t47) = &&LAB16;
    goto LAB1;

LAB22:    t35 = (t2 + 48U);
    *((char **)t35) = &&LAB20;
    goto LAB1;

LAB23:    xsi_set_current_line(806, ng30);

LAB26:    xsi_set_current_line(808, ng30);
    t25 = ((char*)((ng49)));
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 800U);
    xsi_vlogvar_assign_value(t34, t25, 0, 0, 4);
    xsi_set_current_line(810, ng30);
    xsi_set_current_line(810, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 960U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB27:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    memset(t9, 0, 8);
    xsi_vlog_signed_less(t9, 32, t8, 32, t32, 32);
    t33 = (t9 + 4);
    t12 = *((unsigned int *)t33);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB28;

LAB29:    goto LAB25;

LAB28:    xsi_set_current_line(810, ng30);

LAB30:    xsi_set_current_line(811, ng30);
    t34 = ((char*)((ng70)));
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 800U);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 800U);
    t41 = (t40 + 72U);
    t42 = *((char **)t41);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 960U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    xsi_vlog_generic_convert_bit_index(t60, t42, 2, t47, 32, 1);
    t48 = (t60 + 4);
    t17 = *((unsigned int *)t48);
    t55 = (!(t17));
    if (t55 == 1)
        goto LAB31;

LAB32:    xsi_set_current_line(810, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 960U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB27;

LAB31:    xsi_vlogvar_assign_value(t37, t34, 0, *((unsigned int *)t60), 1);
    goto LAB32;

LAB36:    t0 = -1;
    goto LAB1;

LAB38:    t47 = (t2 + 48U);
    *((char **)t47) = &&LAB35;
    goto LAB1;

LAB42:    t0 = -1;
    goto LAB1;

LAB44:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB41;
    goto LAB1;

}

static int sp_WRITE_BURST_CONCURRENT(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t55[8];
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

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 10464);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(850, ng30);

LAB5:    xsi_set_current_line(855, ng30);
    t5 = (t1 + 15784);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(869, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t1 + 1824);
    t25 = xsi_create_subprogram_invocation(t11, 0, t1, t24, 0, t2);
    t32 = (t25 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 160U);
    xsi_vlogvar_assign_value(t34, t8, 0, 0, 32);

LAB14:    t35 = (t2 + 64U);
    t36 = *((char **)t35);
    t37 = (t36 + 80U);
    t38 = *((char **)t37);
    t39 = (t38 + 272U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    t42 = *((char **)t41);
    t53 = ((int  (*)(char *, char *))t42)(t1, t36);
    if (t53 != 0)
        goto LAB16;

LAB15:    t36 = (t2 + 64U);
    t43 = *((char **)t36);
    t36 = (t43 + 96U);
    t44 = *((char **)t36);
    t45 = (t44 + 0U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memcpy(t9, t47, 8);
    t48 = (t1 + 1824);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t48, t43, t1, t50, t2);
    t51 = (t2 + 96U);
    t52 = *((char **)t51);
    t54 = (t52 + 800U);
    xsi_vlogvar_assign_value(t54, t9, 0, 0, 4);
    xsi_set_current_line(873, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 480U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 608);
    t11 = *((char **)t10);
    t10 = ((char*)((ng48)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t11, 32, t10, 32);
    memset(t55, 0, 8);
    xsi_vlog_signed_less(t55, 32, t8, 32, t9, 32);
    t24 = (t55 + 4);
    t12 = *((unsigned int *)t24);
    t13 = (~(t12));
    t14 = *((unsigned int *)t55);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB17;

LAB18:
LAB19:    xsi_set_current_line(881, ng30);
    t53 = xsi_create_forkvar_inside_subprogram_invocation(t2, 2, 0);
    t4 = (t2 + 80U);
    t5 = *((char **)t4);
    xsi_create_forkjoin_process_inside_subprogram(0, (void *)Forked_882_5, t2, t5);
    t6 = (t2 + 80U);
    t7 = *((char **)t6);
    xsi_create_forkjoin_process_inside_subprogram(0, (void *)Forked_883_6, t2, t7);
    xsi_set_forkwaitinfo_inside_subprogram_status(t2, 0, 1);
    *((char **)t3) = &&LAB27;

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

LAB10:    xsi_set_current_line(855, ng30);

LAB13:    xsi_set_current_line(856, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 10464);
    xsi_vlogfile_write(0, 0, 0, ng90, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 10464);
    xsi_vlogfile_write(0, 0, 0, ng68, 2, t40, (char)118, t39, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 10464);
    xsi_vlogfile_write(0, 0, 0, ng69, 2, t46, (char)118, t45, 3);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 480U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 10464);
    xsi_vlogfile_write(1, 0, 0, ng89, 2, t52, (char)119, t51, 32);
    goto LAB12;

LAB16:    t35 = (t2 + 48U);
    *((char **)t35) = &&LAB14;
    goto LAB1;

LAB17:    xsi_set_current_line(873, ng30);

LAB20:    xsi_set_current_line(875, ng30);
    t25 = ((char*)((ng49)));
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 800U);
    xsi_vlogvar_assign_value(t34, t25, 0, 0, 4);
    xsi_set_current_line(877, ng30);
    xsi_set_current_line(877, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 960U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB21:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    memset(t9, 0, 8);
    xsi_vlog_signed_less(t9, 32, t8, 32, t32, 32);
    t33 = (t9 + 4);
    t12 = *((unsigned int *)t33);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB22;

LAB23:    goto LAB19;

LAB22:    xsi_set_current_line(877, ng30);

LAB24:    xsi_set_current_line(878, ng30);
    t34 = ((char*)((ng70)));
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 800U);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 800U);
    t41 = (t40 + 72U);
    t42 = *((char **)t41);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 960U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    xsi_vlog_generic_convert_bit_index(t55, t42, 2, t47, 32, 1);
    t48 = (t55 + 4);
    t17 = *((unsigned int *)t48);
    t53 = (!(t17));
    if (t53 == 1)
        goto LAB25;

LAB26:    xsi_set_current_line(877, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 960U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB21;

LAB25:    xsi_vlogvar_assign_value(t37, t34, 0, *((unsigned int *)t55), 1);
    goto LAB26;

LAB27:    t8 = xsi_get_forkvar_inside_subprogram_invocation(t2, 0);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    if (*((int *)t11) > 0)
        goto LAB28;

LAB29:    xsi_clean_active_fork_process_list(t2);
    xsi_set_current_line(890, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB30);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 9168);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB32:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t53 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t53 == -1)
        goto LAB33;

LAB34:    if (t53 != 0)
        goto LAB35;

LAB30:    t32 = (t1 + 9168);
    xsi_vlog_subprogram_popinvocation(t32);

LAB31:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t40 + 96U);
    t41 = *((char **)t39);
    t42 = (t41 + 0U);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 96U);
    t46 = *((char **)t45);
    t47 = (t46 + 640U);
    xsi_vlogvar_assign_value(t47, t44, 0, 0, 2);
    t48 = (t1 + 9168);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t48, t40, t1, t50, t2);
    goto LAB4;

LAB28:    xsi_set_forkwaitinfo_inside_subprogram_status(t2, 0, 1);
    goto LAB1;

LAB33:    t0 = -1;
    goto LAB1;

LAB35:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB32;
    goto LAB1;

}

static int sp_WRITE_BURST_DATA_FIRST(char *t1, char *t2)
{
    char t9[8];
    char t31[16];
    char t55[8];
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
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 10896);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(921, ng30);

LAB5:    xsi_set_current_line(926, ng30);
    t5 = (t1 + 15784);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = ((char*)((ng47)));
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
LAB12:    xsi_set_current_line(939, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t24 = (t1 + 1824);
    t25 = xsi_create_subprogram_invocation(t11, 0, t1, t24, 0, t2);
    t32 = (t25 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 160U);
    xsi_vlogvar_assign_value(t34, t8, 0, 0, 32);

LAB14:    t35 = (t2 + 64U);
    t36 = *((char **)t35);
    t37 = (t36 + 80U);
    t38 = *((char **)t37);
    t39 = (t38 + 272U);
    t40 = *((char **)t39);
    t41 = (t40 + 0U);
    t42 = *((char **)t41);
    t53 = ((int  (*)(char *, char *))t42)(t1, t36);
    if (t53 != 0)
        goto LAB16;

LAB15:    t36 = (t2 + 64U);
    t43 = *((char **)t36);
    t36 = (t43 + 96U);
    t44 = *((char **)t36);
    t45 = (t44 + 0U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memcpy(t9, t47, 8);
    t48 = (t1 + 1824);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t48, t43, t1, t50, t2);
    t51 = (t2 + 96U);
    t52 = *((char **)t51);
    t54 = (t52 + 800U);
    xsi_vlogvar_assign_value(t54, t9, 0, 0, 4);
    xsi_set_current_line(943, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 480U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t1 + 608);
    t11 = *((char **)t10);
    t10 = ((char*)((ng48)));
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t11, 32, t10, 32);
    memset(t55, 0, 8);
    xsi_vlog_signed_less(t55, 32, t8, 32, t9, 32);
    t24 = (t55 + 4);
    t12 = *((unsigned int *)t24);
    t13 = (~(t12));
    t14 = *((unsigned int *)t55);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB17;

LAB18:
LAB19:    xsi_set_current_line(951, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 320U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t36, &&LAB27);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    t39 = (t1 + 7872);
    t40 = xsi_create_subprogram_invocation(t38, 0, t1, t39, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t39, t40);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 4);
    t44 = (t40 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 160U);
    xsi_vlogvar_assign_value(t46, t32, 0, 0, 32);

LAB29:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t49 = (t48 + 80U);
    t50 = *((char **)t49);
    t51 = (t50 + 272U);
    t52 = *((char **)t51);
    t54 = (t52 + 0U);
    t56 = *((char **)t54);
    t53 = ((int  (*)(char *, char *))t56)(t1, t48);
    if (t53 == -1)
        goto LAB30;

LAB31:    if (t53 != 0)
        goto LAB32;

LAB27:    t48 = (t1 + 7872);
    xsi_vlog_subprogram_popinvocation(t48);

LAB28:    t57 = (t2 + 64U);
    t58 = *((char **)t57);
    t57 = (t1 + 7872);
    t59 = (t2 + 56U);
    t60 = *((char **)t59);
    xsi_delete_subprogram_invocation(t57, t58, t1, t60, t2);
    xsi_set_current_line(957, ng30);
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
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t36, &&LAB33);
    t37 = (t2 + 56U);
    t38 = *((char **)t37);
    t39 = (t1 + 7440);
    t40 = xsi_create_subprogram_invocation(t38, 0, t1, t39, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t39, t40);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 0U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t40 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 160U);
    xsi_vlogvar_assign_value(t46, t32, 0, 0, 3);

LAB35:    t47 = (t2 + 64U);
    t48 = *((char **)t47);
    t49 = (t48 + 80U);
    t50 = *((char **)t49);
    t51 = (t50 + 272U);
    t52 = *((char **)t51);
    t54 = (t52 + 0U);
    t56 = *((char **)t54);
    t53 = ((int  (*)(char *, char *))t56)(t1, t48);
    if (t53 == -1)
        goto LAB36;

LAB37:    if (t53 != 0)
        goto LAB38;

LAB33:    t48 = (t1 + 7440);
    xsi_vlog_subprogram_popinvocation(t48);

LAB34:    t57 = (t2 + 64U);
    t58 = *((char **)t57);
    t57 = (t1 + 7440);
    t59 = (t2 + 56U);
    t60 = *((char **)t59);
    xsi_delete_subprogram_invocation(t57, t58, t1, t60, t2);
    xsi_set_current_line(963, ng30);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB39);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t11 = (t1 + 9168);
    t24 = xsi_create_subprogram_invocation(t10, 0, t1, t11, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t11, t24);

LAB41:    t25 = (t2 + 64U);
    t32 = *((char **)t25);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t53 = ((int  (*)(char *, char *))t38)(t1, t32);
    if (t53 == -1)
        goto LAB42;

LAB43:    if (t53 != 0)
        goto LAB44;

LAB39:    t32 = (t1 + 9168);
    xsi_vlog_subprogram_popinvocation(t32);

LAB40:    t39 = (t2 + 64U);
    t40 = *((char **)t39);
    t39 = (t40 + 96U);
    t41 = *((char **)t39);
    t42 = (t41 + 0U);
    t43 = (t42 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 96U);
    t46 = *((char **)t45);
    t47 = (t46 + 640U);
    xsi_vlogvar_assign_value(t47, t44, 0, 0, 2);
    t48 = (t1 + 9168);
    t49 = (t2 + 56U);
    t50 = *((char **)t49);
    xsi_delete_subprogram_invocation(t48, t40, t1, t50, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t24 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t24) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(926, ng30);

LAB13:    xsi_set_current_line(927, ng30);
    t32 = xsi_vlog_time(t31, 10000.000000000000, 1000.0000000000000);
    t33 = ((char*)((ng34)));
    t34 = (t1 + 10896);
    xsi_vlogfile_write(0, 0, 0, ng93, 3, t34, (char)118, t31, 64, (char)118, t33, 64);
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = (t1 + 10896);
    xsi_vlogfile_write(0, 0, 0, ng68, 2, t40, (char)118, t39, 32);
    t41 = (t2 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 160U);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t1 + 10896);
    xsi_vlogfile_write(0, 0, 0, ng69, 2, t46, (char)118, t45, 3);
    t47 = (t2 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 480U);
    t50 = (t49 + 56U);
    t51 = *((char **)t50);
    t52 = (t1 + 10896);
    xsi_vlogfile_write(1, 0, 0, ng89, 2, t52, (char)119, t51, 32);
    goto LAB12;

LAB16:    t35 = (t2 + 48U);
    *((char **)t35) = &&LAB14;
    goto LAB1;

LAB17:    xsi_set_current_line(943, ng30);

LAB20:    xsi_set_current_line(945, ng30);
    t25 = ((char*)((ng49)));
    t32 = (t2 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 800U);
    xsi_vlogvar_assign_value(t34, t25, 0, 0, 4);
    xsi_set_current_line(947, ng30);
    xsi_set_current_line(947, ng30);
    t4 = ((char*)((ng49)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 960U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);

LAB21:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t24 = (t11 + 480U);
    t25 = (t24 + 56U);
    t32 = *((char **)t25);
    memset(t9, 0, 8);
    xsi_vlog_signed_less(t9, 32, t8, 32, t32, 32);
    t33 = (t9 + 4);
    t12 = *((unsigned int *)t33);
    t13 = (~(t12));
    t14 = *((unsigned int *)t9);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB22;

LAB23:    goto LAB19;

LAB22:    xsi_set_current_line(947, ng30);

LAB24:    xsi_set_current_line(948, ng30);
    t34 = ((char*)((ng70)));
    t35 = (t2 + 96U);
    t36 = *((char **)t35);
    t37 = (t36 + 800U);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 800U);
    t41 = (t40 + 72U);
    t42 = *((char **)t41);
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 960U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    xsi_vlog_generic_convert_bit_index(t55, t42, 2, t47, 32, 1);
    t48 = (t55 + 4);
    t17 = *((unsigned int *)t48);
    t53 = (!(t17));
    if (t53 == 1)
        goto LAB25;

LAB26:    xsi_set_current_line(947, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t10 = ((char*)((ng47)));
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 32, t8, 32, t10, 32);
    t11 = (t2 + 96U);
    t24 = *((char **)t11);
    t25 = (t24 + 960U);
    xsi_vlogvar_assign_value(t25, t9, 0, 0, 32);
    goto LAB21;

LAB25:    xsi_vlogvar_assign_value(t37, t34, 0, *((unsigned int *)t55), 1);
    goto LAB26;

LAB30:    t0 = -1;
    goto LAB1;

LAB32:    t47 = (t2 + 48U);
    *((char **)t47) = &&LAB29;
    goto LAB1;

LAB36:    t0 = -1;
    goto LAB1;

LAB38:    t47 = (t2 + 48U);
    *((char **)t47) = &&LAB35;
    goto LAB1;

LAB42:    t0 = -1;
    goto LAB1;

LAB44:    t25 = (t2 + 48U);
    *((char **)t25) = &&LAB41;
    goto LAB1;

}

static int sp_set_error_on_slverr(char *t1, char *t2)
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

LAB2:    t4 = (t1 + 11328);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(978, ng30);

LAB5:    xsi_set_current_line(979, ng30);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 11328);
    xsi_vlogfile_write(1, 0, 0, ng94, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(980, ng30);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 16104);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_set_error_on_decerr(char *t1, char *t2)
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

LAB2:    t4 = (t1 + 11760);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(994, ng30);

LAB5:    xsi_set_current_line(995, ng30);
    t6 = xsi_vlog_time(t5, 10000.000000000000, 1000.0000000000000);
    t7 = ((char*)((ng34)));
    t8 = (t2 + 96U);
    t9 = *((char **)t8);
    t10 = (t9 + 0U);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t1 + 11760);
    xsi_vlogfile_write(1, 0, 0, ng95, 4, t13, (char)118, t5, 64, (char)118, t7, 64, (char)118, t12, 1);
    xsi_set_current_line(996, ng30);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 16264);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
}

static int sp_check_response_value(char *t1, char *t2)
{
    char t11[8];
    char t40[16];
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
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 12192);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(1017, ng30);

LAB5:    xsi_set_current_line(1019, ng30);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng96)));
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
LAB11:    xsi_set_current_line(1047, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 0U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng101)));
    memset(t11, 0, 8);
    if (*((unsigned int *)t8) != *((unsigned int *)t9))
        goto LAB38;

LAB36:    t10 = (t8 + 4);
    t12 = (t9 + 4);
    if (*((unsigned int *)t10) != *((unsigned int *)t12))
        goto LAB38;

LAB37:    *((unsigned int *)t11) = 1;

LAB38:    t13 = (t11 + 4);
    t15 = *((unsigned int *)t13);
    t16 = (~(t15));
    t17 = *((unsigned int *)t11);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB39;

LAB40:
LAB41:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    xsi_set_current_line(1019, ng30);

LAB12:    xsi_set_current_line(1020, ng30);
    t20 = (t1 + 16104);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t22);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB13;

LAB14:    xsi_set_current_line(1035, ng30);

LAB30:    xsi_set_current_line(1036, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 4);
    t15 = *((unsigned int *)t9);
    t16 = (~(t15));
    t17 = *((unsigned int *)t8);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB31;

LAB32:    xsi_set_current_line(1039, ng30);

LAB35:    xsi_set_current_line(1040, ng30);
    t4 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng34)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng100, 4, t12, (char)118, t40, 64, (char)118, t5, 64, (char)118, t10, 2);

LAB33:    xsi_set_current_line(1043, ng30);
    t4 = (t1 + 18824);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 18824);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);

LAB15:    goto LAB11;

LAB13:    xsi_set_current_line(1020, ng30);

LAB16:    xsi_set_current_line(1021, ng30);
    t29 = (t2 + 96U);
    t30 = *((char **)t29);
    t31 = (t30 + 160U);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    t34 = (t33 + 4);
    t35 = *((unsigned int *)t34);
    t36 = (~(t35));
    t37 = *((unsigned int *)t33);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB17;

LAB18:    xsi_set_current_line(1024, ng30);

LAB21:    xsi_set_current_line(1025, ng30);
    t4 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng34)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng98, 4, t12, (char)118, t40, 64, (char)118, t5, 64, (char)118, t10, 2);

LAB19:    xsi_set_current_line(1029, ng30);
    t4 = (t1 + 15464);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
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
    t35 = (~(t28));
    t36 = (t25 & t35);
    if (t36 != 0)
        goto LAB25;

LAB22:    if (t28 != 0)
        goto LAB24;

LAB23:    *((unsigned int *)t11) = 1;

LAB25:    t12 = (t11 + 4);
    t37 = *((unsigned int *)t12);
    t38 = (~(t37));
    t39 = *((unsigned int *)t11);
    t49 = (t39 & t38);
    t50 = (t49 != 0);
    if (t50 > 0)
        goto LAB26;

LAB27:
LAB28:    xsi_set_current_line(1033, ng30);
    t4 = (t1 + 18664);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 18664);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB15;

LAB17:    xsi_set_current_line(1021, ng30);

LAB20:    xsi_set_current_line(1022, ng30);
    t41 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t42 = ((char*)((ng34)));
    t43 = (t2 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 0U);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng97, 4, t48, (char)118, t40, 64, (char)118, t42, 64, (char)118, t47, 2);
    goto LAB19;

LAB24:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB25;

LAB26:    xsi_set_current_line(1029, ng30);

LAB29:    xsi_set_current_line(1030, ng30);
    t13 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t13);
    xsi_set_current_line(1031, ng30);
    xsi_vlog_stop(1);
    goto LAB28;

LAB31:    xsi_set_current_line(1036, ng30);

LAB34:    xsi_set_current_line(1037, ng30);
    t10 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t12 = ((char*)((ng34)));
    t13 = (t2 + 96U);
    t14 = *((char **)t13);
    t20 = (t14 + 0U);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng99, 4, t23, (char)118, t40, 64, (char)118, t12, 64, (char)118, t22, 2);
    goto LAB33;

LAB39:    xsi_set_current_line(1047, ng30);

LAB42:    xsi_set_current_line(1048, ng30);
    t14 = (t1 + 16264);
    t20 = (t14 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 4);
    t24 = *((unsigned int *)t22);
    t25 = (~(t24));
    t26 = *((unsigned int *)t21);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB43;

LAB44:    xsi_set_current_line(1063, ng30);

LAB60:    xsi_set_current_line(1064, ng30);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 4);
    t15 = *((unsigned int *)t9);
    t16 = (~(t15));
    t17 = *((unsigned int *)t8);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB61;

LAB62:    xsi_set_current_line(1067, ng30);

LAB65:    xsi_set_current_line(1068, ng30);
    t4 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng34)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng105, 4, t12, (char)118, t40, 64, (char)118, t5, 64, (char)118, t10, 2);

LAB63:    xsi_set_current_line(1071, ng30);
    t4 = (t1 + 18824);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 18824);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);

LAB45:    goto LAB41;

LAB43:    xsi_set_current_line(1048, ng30);

LAB46:    xsi_set_current_line(1049, ng30);
    t23 = (t2 + 96U);
    t29 = *((char **)t23);
    t30 = (t29 + 160U);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t32 + 4);
    t35 = *((unsigned int *)t33);
    t36 = (~(t35));
    t37 = *((unsigned int *)t32);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB47;

LAB48:    xsi_set_current_line(1052, ng30);

LAB51:    xsi_set_current_line(1053, ng30);
    t4 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t5 = ((char*)((ng34)));
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng103, 4, t12, (char)118, t40, 64, (char)118, t5, 64, (char)118, t10, 2);

LAB49:    xsi_set_current_line(1057, ng30);
    t4 = (t1 + 15464);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
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
    t35 = (~(t28));
    t36 = (t25 & t35);
    if (t36 != 0)
        goto LAB55;

LAB52:    if (t28 != 0)
        goto LAB54;

LAB53:    *((unsigned int *)t11) = 1;

LAB55:    t12 = (t11 + 4);
    t37 = *((unsigned int *)t12);
    t38 = (~(t37));
    t39 = *((unsigned int *)t11);
    t49 = (t39 & t38);
    t50 = (t49 != 0);
    if (t50 > 0)
        goto LAB56;

LAB57:
LAB58:    xsi_set_current_line(1061, ng30);
    t4 = (t1 + 18664);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng47)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t6, 32, t7, 32);
    t8 = (t1 + 18664);
    xsi_vlogvar_assign_value(t8, t11, 0, 0, 32);
    goto LAB45;

LAB47:    xsi_set_current_line(1049, ng30);

LAB50:    xsi_set_current_line(1050, ng30);
    t34 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t41 = ((char*)((ng34)));
    t42 = (t2 + 96U);
    t43 = *((char **)t42);
    t44 = (t43 + 0U);
    t45 = (t44 + 56U);
    t46 = *((char **)t45);
    t47 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng102, 4, t47, (char)118, t40, 64, (char)118, t41, 64, (char)118, t46, 2);
    goto LAB49;

LAB54:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB55;

LAB56:    xsi_set_current_line(1057, ng30);

LAB59:    xsi_set_current_line(1058, ng30);
    t13 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t13);
    xsi_set_current_line(1059, ng30);
    xsi_vlog_stop(1);
    goto LAB58;

LAB61:    xsi_set_current_line(1064, ng30);

LAB64:    xsi_set_current_line(1065, ng30);
    t10 = xsi_vlog_time(t40, 10000.000000000000, 1000.0000000000000);
    t12 = ((char*)((ng34)));
    t13 = (t2 + 96U);
    t14 = *((char **)t13);
    t20 = (t14 + 0U);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t1 + 12192);
    xsi_vlogfile_write(1, 0, 0, ng104, 4, t23, (char)118, t40, 64, (char)118, t12, 64, (char)118, t22, 2);
    goto LAB63;

}

static void Cont_113_0(char *t0)
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

LAB0:    t1 = (t0 + 20056U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(113, ng30);
    t2 = (t0 + 12824U);
    t3 = *((char **)t2);
    t2 = (t0 + 21704);
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
    t16 = (t0 + 14824);
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
    t21 = (t0 + 21368);
    *((int *)t21) = 1;

LAB1:    return;
LAB4:    t19 = 0.0000000000000000;
    goto LAB6;

}

static void Initial_118_1(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(118, ng30);

LAB2:    xsi_set_current_line(119, ng30);
    t1 = ((char*)((ng71)));
    t2 = (t0 + 18184);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(120, ng30);
    t1 = ((char*)((ng71)));
    t2 = (t0 + 18344);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(121, ng30);
    t1 = ((char*)((ng71)));
    t2 = (t0 + 18504);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(122, ng30);
    t1 = ((char*)((ng49)));
    t2 = (t0 + 18664);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    xsi_set_current_line(123, ng30);
    t1 = ((char*)((ng49)));
    t2 = (t0 + 18824);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    xsi_set_current_line(124, ng30);
    t1 = ((char*)((ng49)));
    t2 = (t0 + 18984);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);
    xsi_set_current_line(125, ng30);
    t1 = ((char*)((ng71)));
    t2 = (t0 + 19144);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Initial_131_2(char *t0)
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

LAB0:    t1 = (t0 + 20552U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(131, ng30);

LAB4:    xsi_set_current_line(132, ng30);
    *((int *)t3) = xsi_xilinx_lic_check(ng106, 2010.0999999999999);
    t2 = (t3 + 4);
    *((int *)t2) = 0;
    t4 = ((char*)((ng49)));
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

LAB10:    xsi_set_current_line(138, ng30);

LAB13:    xsi_set_current_line(139, ng30);
    t2 = ((char*)((ng108)));
    *((double *)t3) = 2010.0999999999999;
    xsi_vlogfile_write(1, 0, 0, ng109, 3, t0, (char)118, t2, 112, (char)114, t3, 64);
    xsi_set_current_line(141, ng30);
    xsi_vlog_finish(1);

LAB11:    xsi_set_current_line(143, ng30);
    xsi_vlogfile_write(1, 0, 0, ng31, 1, t0);
    xsi_set_current_line(144, ng30);
    xsi_vlogfile_write(1, 0, 0, ng110, 1, t0);
    xsi_set_current_line(145, ng30);
    xsi_vlogfile_write(1, 0, 0, ng31, 1, t0);
    xsi_set_current_line(146, ng30);
    xsi_vlogfile_write(0, 0, 0, ng111, 1, t0);
    xsi_vlogfile_write(1, 0, 0, ng112, 1, t0);
    xsi_set_current_line(147, ng30);
    t2 = (t0 + 20360);
    t4 = (t0 + 1392);
    t6 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t6);

LAB16:    t7 = (t0 + 20456);
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

LAB14:    t20 = (t0 + 1392);
    xsi_vlog_subprogram_popinvocation(t20);

LAB15:    t34 = (t0 + 20456);
    t35 = *((char **)t34);
    t34 = (t0 + 1392);
    t36 = (t0 + 20360);
    t37 = 0;
    xsi_delete_subprogram_invocation(t34, t35, t0, t36, t37);

LAB1:    return;
LAB6:    *((unsigned int *)t5) = 1;
    goto LAB8;

LAB7:    t20 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB8;

LAB9:    xsi_set_current_line(133, ng30);

LAB12:    xsi_set_current_line(134, ng30);
    t27 = ((char*)((ng108)));
    *((double *)t28) = 2010.0999999999999;
    xsi_vlogfile_write(1, 0, 0, ng107, 3, t0, (char)118, t27, 112, (char)114, t28, 64);
    goto LAB11;

LAB17:;
LAB19:    t7 = (t0 + 20552U);
    *((char **)t7) = &&LAB16;
    goto LAB1;

}

static void Always_191_3(char *t0)
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

LAB0:    t1 = (t0 + 20800U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(191, ng30);
    t2 = (t0 + 21416);
    *((int *)t2) = 1;
    t3 = (t0 + 20832);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(191, ng30);

LAB5:    xsi_set_current_line(192, ng30);
    t5 = (t0 + 12984U);
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

LAB11:    xsi_set_current_line(256, ng30);

LAB105:    xsi_set_current_line(257, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 19144);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(192, ng30);

LAB13:    xsi_set_current_line(196, ng30);
    t19 = (t0 + 19144);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = ((char*)((ng49)));
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
LAB20:    xsi_set_current_line(205, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 16424);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(206, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 16584);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    xsi_set_current_line(207, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 16744);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(210, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 16904);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(211, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 17064);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    xsi_set_current_line(212, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 17224);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(215, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 17384);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(218, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 17544);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(219, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 17704);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    xsi_set_current_line(220, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 17864);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(223, ng30);
    t2 = ((char*)((ng49)));
    t3 = (t0 + 18024);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(230, ng30);
    t2 = (t0 + 21432);
    *((int *)t2) = 1;
    t3 = (t0 + 20832);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB22;
    goto LAB1;

LAB16:    t38 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t38) = 1;
    goto LAB17;

LAB18:    xsi_set_current_line(196, ng30);

LAB21:    xsi_set_current_line(197, ng30);
    t46 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t47 = ((char*)((ng34)));
    xsi_vlogfile_write(1, 0, 0, ng113, 3, t0, (char)118, t45, 64, (char)118, t47, 64);
    goto LAB20;

LAB22:    xsi_set_current_line(232, ng30);
    t2 = (t0 + 13784U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng49)));
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
LAB46:    xsi_set_current_line(241, ng30);
    t2 = (t0 + 14424U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng49)));
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
LAB79:    xsi_set_current_line(249, ng30);
    t2 = (t0 + 15304);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng49)));
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
        goto LAB92;

LAB89:    if (t18 != 0)
        goto LAB91;

LAB90:    *((unsigned int *)t4) = 1;

LAB92:    t20 = (t4 + 4);
    t28 = *((unsigned int *)t20);
    t29 = (~(t28));
    t30 = *((unsigned int *)t4);
    t31 = (t30 & t29);
    t32 = (t31 != 0);
    if (t32 > 0)
        goto LAB93;

LAB94:
LAB95:    xsi_set_current_line(254, ng30);
    t2 = ((char*)((ng47)));
    t3 = (t0 + 19144);
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

LAB30:    t20 = (t0 + 15304);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t24 = ((char*)((ng49)));
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

LAB44:    xsi_set_current_line(232, ng30);

LAB47:    xsi_set_current_line(233, ng30);
    t86 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t87 = ((char*)((ng34)));
    xsi_vlogfile_write(1, 0, 0, ng114, 3, t0, (char)118, t45, 64, (char)118, t87, 64);
    xsi_set_current_line(234, ng30);
    t2 = (t0 + 15464);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng47)));
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
LAB54:    xsi_set_current_line(238, ng30);
    t2 = (t0 + 18664);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng47)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 18664);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB46;

LAB50:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(234, ng30);

LAB55:    xsi_set_current_line(235, ng30);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t0);
    xsi_set_current_line(236, ng30);
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

LAB63:    t20 = (t0 + 15304);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t24 = ((char*)((ng49)));
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

LAB77:    xsi_set_current_line(241, ng30);

LAB80:    xsi_set_current_line(242, ng30);
    t86 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t87 = ((char*)((ng34)));
    xsi_vlogfile_write(1, 0, 0, ng115, 3, t0, (char)118, t45, 64, (char)118, t87, 64);
    xsi_set_current_line(243, ng30);
    t2 = (t0 + 15464);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng47)));
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
LAB87:    xsi_set_current_line(247, ng30);
    t2 = (t0 + 18664);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng47)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 18664);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB79;

LAB83:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB84;

LAB85:    xsi_set_current_line(243, ng30);

LAB88:    xsi_set_current_line(244, ng30);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t0);
    xsi_set_current_line(245, ng30);
    xsi_vlog_stop(1);
    goto LAB87;

LAB91:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB92;

LAB93:    xsi_set_current_line(249, ng30);

LAB96:    xsi_set_current_line(250, ng30);
    t21 = (t0 + 19144);
    t22 = (t21 + 56U);
    t24 = *((char **)t22);
    t25 = ((char*)((ng49)));
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
        goto LAB100;

LAB97:    if (t44 != 0)
        goto LAB99;

LAB98:    *((unsigned int *)t23) = 1;

LAB100:    t47 = (t23 + 4);
    t56 = *((unsigned int *)t47);
    t57 = (~(t56));
    t58 = *((unsigned int *)t23);
    t59 = (t58 & t57);
    t60 = (t59 != 0);
    if (t60 > 0)
        goto LAB101;

LAB102:
LAB103:    goto LAB95;

LAB99:    t46 = (t23 + 4);
    *((unsigned int *)t23) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB100;

LAB101:    xsi_set_current_line(250, ng30);

LAB104:    xsi_set_current_line(251, ng30);
    t52 = xsi_vlog_time(t45, 10000.000000000000, 1000.0000000000000);
    t53 = ((char*)((ng34)));
    xsi_vlogfile_write(1, 0, 0, ng116, 3, t0, (char)118, t45, 64, (char)118, t53, 64);
    goto LAB103;

}

static void Always_268_4(char *t0)
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

LAB0:    t1 = (t0 + 21048U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(268, ng30);
    t2 = (t0 + 21448);
    *((int *)t2) = 1;
    t3 = (t0 + 21080);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(268, ng30);

LAB5:    xsi_set_current_line(269, ng30);
    t4 = (t0 + 12824U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng49)));
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
    t23 = ((char*)((ng49)));
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

LAB27:    xsi_set_current_line(269, ng30);

LAB30:    xsi_set_current_line(270, ng30);
    t87 = xsi_vlog_time(t86, 10000.000000000000, 1000.0000000000000);
    t88 = ((char*)((ng34)));
    xsi_vlogfile_write(1, 0, 0, ng117, 3, t0, (char)118, t86, 64, (char)118, t88, 64);
    xsi_set_current_line(271, ng30);
    t2 = (t0 + 15464);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng47)));
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
LAB37:    xsi_set_current_line(275, ng30);
    t2 = (t0 + 18664);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng47)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 18664);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB29;

LAB33:    t10 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB34;

LAB35:    xsi_set_current_line(271, ng30);

LAB38:    xsi_set_current_line(272, ng30);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t0);
    xsi_set_current_line(273, ng30);
    xsi_vlog_stop(1);
    goto LAB37;

}

static void Forked_882_5(char *t0)
{
    char t41[8];
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
    int t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    unsigned int t42;

LAB0:    t1 = (t0 + 72U);
    t2 = *((char **)t1);
    t3 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t4 = (t3 + 192U);
    t5 = *((char **)t4);
    if (t5 == 0)
        goto LAB2;

LAB3:    goto *t5;

LAB2:    t5 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    xsi_vlog_process_setdisablestate(t5, &&LAB4);
    xsi_set_current_line(882, ng30);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 160U);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t17 = (t2 + 7440);
    t18 = xsi_create_subprogram_invocation(t16, 0, t2, t17, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t17, t18);
    t19 = (t18 + 96U);
    t20 = *((char **)t19);
    t21 = (t20 + 0U);
    xsi_vlogvar_assign_value(t21, t10, 0, 0, 32);
    t22 = (t18 + 96U);
    t23 = *((char **)t22);
    t24 = (t23 + 160U);
    xsi_vlogvar_assign_value(t24, t15, 0, 0, 3);

LAB7:    t25 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t26 = (t25 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 80U);
    t29 = *((char **)t28);
    t30 = (t29 + 272U);
    t31 = *((char **)t30);
    t32 = (t31 + 0U);
    t33 = *((char **)t32);
    t34 = ((int  (*)(char *, char *))t33)(t2, t27);

LAB9:    if (t34 != 0)
        goto LAB10;

LAB5:    t35 = (t2 + 7440);
    xsi_vlog_subprogram_popinvocation(t35);

LAB6:    t36 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t37 = (t2 + 7440);
    t39 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t40 = 0;
    xsi_delete_subprogram_invocation(t37, t38, t2, t39, t40);

LAB4:    t1 = xsi_get_forkvar_inside_subprogram_invocation(t0, 0);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    memcpy(t41, t5, 8);
    t42 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t42 - 1);
    xsi_vlogvar_assign_value(t1, t41, 0, 0, 32);

LAB1:    return;
LAB8:;
LAB10:    t26 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t27 = (t26 + 192U);
    *((char **)t27) = &&LAB7;
    goto LAB1;

}

static void Forked_883_6(char *t0)
{
    char t41[8];
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
    int t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    unsigned int t42;

LAB0:    t1 = (t0 + 72U);
    t2 = *((char **)t1);
    t3 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t4 = (t3 + 192U);
    t5 = *((char **)t4);
    if (t5 == 0)
        goto LAB2;

LAB3:    goto *t5;

LAB2:    t5 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    xsi_vlog_process_setdisablestate(t5, &&LAB4);
    xsi_set_current_line(883, ng30);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 800U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t17 = (t2 + 7872);
    t18 = xsi_create_subprogram_invocation(t16, 0, t2, t17, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t17, t18);
    t19 = (t18 + 96U);
    t20 = *((char **)t19);
    t21 = (t20 + 0U);
    xsi_vlogvar_assign_value(t21, t10, 0, 0, 4);
    t22 = (t18 + 96U);
    t23 = *((char **)t22);
    t24 = (t23 + 160U);
    xsi_vlogvar_assign_value(t24, t15, 0, 0, 32);

LAB7:    t25 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t26 = (t25 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 80U);
    t29 = *((char **)t28);
    t30 = (t29 + 272U);
    t31 = *((char **)t30);
    t32 = (t31 + 0U);
    t33 = *((char **)t32);
    t34 = ((int  (*)(char *, char *))t33)(t2, t27);

LAB9:    if (t34 != 0)
        goto LAB10;

LAB5:    t35 = (t2 + 7872);
    xsi_vlog_subprogram_popinvocation(t35);

LAB6:    t36 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t37 = (t36 + 96U);
    t38 = *((char **)t37);
    t37 = (t2 + 7872);
    t39 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t40 = 0;
    xsi_delete_subprogram_invocation(t37, t38, t2, t39, t40);

LAB4:    t1 = xsi_get_forkvar_inside_subprogram_invocation(t0, 0);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    memcpy(t41, t5, 8);
    t42 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t42 - 1);
    xsi_vlogvar_assign_value(t1, t41, 0, 0, 32);

LAB1:    return;
LAB8:;
LAB10:    t26 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t27 = (t26 + 192U);
    *((char **)t27) = &&LAB7;
    goto LAB1;

}


extern void secureip_m_13511109259789057922_1620950414_init()
{
	static char *pe[] = {(void *)Cont_113_0,(void *)Initial_118_1,(void *)Initial_131_2,(void *)Always_191_3,(void *)Always_268_4};
	static char *se[] = {(void *)sp_report_config,(void *)sp_calculate_strobe,(void *)sp_set_channel_level_info,(void *)sp_set_function_level_info,(void *)sp_set_stop_on_error,(void *)sp_set_response_timeout,(void *)sp_set_clear_signals_after_handshake,(void *)sp_set_disable_reset_value_checks,(void *)sp_set_task_call_and_reset_handling,(void *)sp_task_reset_handling,(void *)sp_set_bfm_clk_delay,(void *)sp_report_status,(void *)sp_add_pending_transaction,(void *)sp_remove_pending_transaction,(void *)sp_SEND_WRITE_ADDRESS,(void *)sp_SEND_WRITE_DATA,(void *)sp_SEND_READ_ADDRESS,(void *)sp_RECEIVE_READ_DATA,(void *)sp_RECEIVE_WRITE_RESPONSE,(void *)sp_READ_BURST,(void *)sp_WRITE_BURST,(void *)sp_WRITE_BURST_CONCURRENT,(void *)sp_WRITE_BURST_DATA_FIRST,(void *)sp_set_error_on_slverr,(void *)sp_set_error_on_decerr,(void *)sp_check_response_value};
	xsi_register_didat("secureip_m_13511109259789057922_1620950414", "isim/isim_bfm_system.sim/secureip/m_13511109259789057922_1620950414.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
	xsi_register_subprogram_init(2, (void *)calculate_strobe_varinit);
	xsi_register_subprogram_init(3, (void *)set_channel_level_info_varinit);
	xsi_register_subprogram_init(4, (void *)set_function_level_info_varinit);
	xsi_register_subprogram_init(5, (void *)set_stop_on_error_varinit);
	xsi_register_subprogram_init(6, (void *)set_response_timeout_varinit);
	xsi_register_subprogram_init(7, (void *)set_clear_signals_after_handshake_varinit);
	xsi_register_subprogram_init(8, (void *)set_disable_reset_value_checks_varinit);
	xsi_register_subprogram_init(9, (void *)set_task_call_and_reset_handling_varinit);
	xsi_register_subprogram_init(10, (void *)task_reset_handling_varinit);
	xsi_register_subprogram_init(11, (void *)set_bfm_clk_delay_varinit);
	xsi_register_subprogram_init(12, (void *)report_status_varinit);
	xsi_register_subprogram_init(13, (void *)add_pending_transaction_varinit);
	xsi_register_subprogram_init(14, (void *)remove_pending_transaction_varinit);
	xsi_register_subprogram_init(15, (void *)SEND_WRITE_ADDRESS_varinit);
	xsi_register_subprogram_init(16, (void *)SEND_WRITE_DATA_varinit);
	xsi_register_subprogram_init(17, (void *)SEND_READ_ADDRESS_varinit);
	xsi_register_subprogram_init(18, (void *)RECEIVE_READ_DATA_varinit);
	xsi_register_subprogram_init(19, (void *)RECEIVE_WRITE_RESPONSE_varinit);
	xsi_register_subprogram_init(20, (void *)READ_BURST_varinit);
	xsi_register_subprogram_init(21, (void *)WRITE_BURST_varinit);
	xsi_register_subprogram_init(22, (void *)WRITE_BURST_CONCURRENT_varinit);
	xsi_register_subprogram_init(23, (void *)WRITE_BURST_DATA_FIRST_varinit);
	xsi_register_subprogram_init(24, (void *)set_error_on_slverr_varinit);
	xsi_register_subprogram_init(25, (void *)set_error_on_decerr_varinit);
	xsi_register_subprogram_init(26, (void *)check_response_value_varinit);
}
