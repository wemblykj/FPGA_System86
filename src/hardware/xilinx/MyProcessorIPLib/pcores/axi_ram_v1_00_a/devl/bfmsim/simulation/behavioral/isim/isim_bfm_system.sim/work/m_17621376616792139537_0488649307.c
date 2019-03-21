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
static const char *ng1 = "data";
static const char *ng2 = "prot";
static const char *ng3 = "strobe";
static const char *ng4 = "response";
static const char *ng5 = "expected";
static const char *ng6 = "actual";
static const char *ng7 = "nRW";
static const char *ng8 = "done";
static const char *ng9 = "rd_data";
static const char *ng10 = "count";
static const char *ng11 = "/home/administrator/Development/test_rig/pcores/axi_lite_ram_v1_00_a/devl/bfmsim/simulation/behavioral/bfm_system_tb.v";
static unsigned int ng15[] = {0U, 0U};
static const char *ng16 = "TESTBENCH FAILED! Response is not OKAY";
static const char *ng17 = "\n expected = 0x%h";
static const char *ng18 = "\n actual = 0x%h";
static unsigned int ng19[] = {4294967295U, 4294967295U, 4294967295U, 4294967295U};
static const char *ng20 = "TESTBENCH FAILED! COMPARE_DATA cannot be performed with an expected or actual vector that is all 'x'!";
static const char *ng21 = "TESTBENCH FAILED! Data expected is not equal to actual.";
static const char *ng22 = "\n actual   = 0x%h";
static int ng23[] = {1, 0};
static unsigned int ng24[] = {805306368U, 0U};
static unsigned int ng25[] = {256U, 0U};
static unsigned int ng26[] = {2U, 0U};
static unsigned int ng27[] = {1U, 0U};
static unsigned int ng28[] = {260U, 0U};
static unsigned int ng29[] = {15U, 0U};
static unsigned int ng30[] = {264U, 0U};
static unsigned int ng31[] = {65535U, 0U};
static unsigned int ng32[] = {3U, 0U};
static unsigned int ng33[] = {268U, 0U};
static unsigned int ng34[] = {4U, 0U};
static unsigned int ng35[] = {271U, 0U};
static unsigned int ng36[] = {167772160U, 0U};
static unsigned int ng37[] = {8U, 0U};
static int ng38[] = {0, 0};
static int ng39[] = {100, 0};
static unsigned int ng40[] = {65280U, 0U, 0U, 0U};
static unsigned int ng41[] = {0U, 0U, 0U, 0U};
static const char *ng42 = "----------------------------------------------------";
static const char *ng43 = "Full Registers write followed by a full Registers read";
static int ng44[] = {8, 0};
static int ng45[] = {6, 0};
static const char *ng46 = "Writing to Slave Register addr=0x%h";
static const char *ng47 = " data=0x%h";
static const char *ng48 = "Reading from Slave Register addr=0x%h";
static const char *ng49 = "Soft Reseting of peripheral and Full Register read";
static unsigned int ng50[] = {10U, 0U};
static unsigned int ng51[] = {512U, 0U};
static const char *ng52 = "---------------------------------------------------";
static const char *ng53 = "Master Verification";
static const char *ng54 = "Initializing first 16 locations of AXI Slave BFM memory with value";
static int ng55[] = {16, 0};
static unsigned int ng56[] = {1073741824U, 0U};
static const char *ng57 = "Initializing second 16 locations of AXI Slave BFM memory with zero value";
static const char *ng58 = "Requesting master to read the data and write to different location";
static const char *ng59 = " data=%0xh";
static const char *ng60 = "Peripheral Verification Completed Successfully";

static void Forked_262_4(char *);
static void Forked_263_5(char *);
static void Forked_264_6(char *);
void Forked_262_4();
void Forked_263_5();
void Forked_264_6();


static void SINGLE_WRITE_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng0, 2, 31, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng1, 2, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng2, 2, 2, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng3, 2, 3, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng4, 2, 1, 0, 0, t25, 0, 1, 0);

LAB1:    return;
}

static void SINGLE_READ_varinit(char *t0)
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
    xsi_vlogvar_initialize(t8, ng1, 2, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng2, 2, 2, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng4, 2, 1, 0, 0, t20, 0, 1, 0);

LAB1:    return;
}

static void CHECK_RESPONSE_OKAY_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng4, 2, 1, 0, 0, t5, 0, 1, 0);

LAB1:    return;
}

static void COMPARE_DATA_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng5, 2, 63, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng6, 2, 63, 0, 0, t10, 0, 1, 0);

LAB1:    return;
}

static void GEN_MASTER_REQ_varinit(char *t0)
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
    xsi_vlogvar_initialize(t3, ng7, 2, 0, 0, 0, t5, 0, 1, 0);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t0 + 80U);
    t10 = *((char **)t9);
    xsi_vlogvar_initialize(t8, ng0, 2, 31, 0, 0, t10, 0, 1, 0);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t0 + 80U);
    t15 = *((char **)t14);
    xsi_vlogvar_initialize(t13, ng2, 2, 2, 0, 0, t15, 0, 1, 0);
    t16 = (t0 + 96U);
    t17 = *((char **)t16);
    t18 = (t17 + 480U);
    t19 = (t0 + 80U);
    t20 = *((char **)t19);
    xsi_vlogvar_initialize(t18, ng4, 2, 1, 0, 0, t20, 0, 1, 0);
    t21 = (t0 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 640U);
    t24 = (t0 + 80U);
    t25 = *((char **)t24);
    xsi_vlogvar_initialize(t23, ng8, 2, 0, 0, 0, t25, 0, 1, 0);
    t26 = (t0 + 96U);
    t27 = *((char **)t26);
    t28 = (t27 + 800U);
    t29 = (t0 + 80U);
    t30 = *((char **)t29);
    xsi_vlogvar_initialize(t28, ng9, 2, 31, 0, 0, t30, 0, 1, 0);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 960U);
    t34 = (t0 + 80U);
    t35 = *((char **)t34);
    xsi_vlogvar_initialize(t33, ng10, 0, 31, 0, 0, t35, 0, 1, 0);

LAB1:    return;
}

static int sp_SINGLE_WRITE(char *t1, char *t2)
{
    int t0;
    char *t3;
    char *t4;
    int t5;
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

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1392);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(260, ng11);

LAB5:    xsi_set_current_line(261, ng11);
    t5 = xsi_create_forkvar_inside_subprogram_invocation(t2, 3, 0);
    t6 = (t2 + 80U);
    t7 = *((char **)t6);
    xsi_create_forkjoin_process_inside_subprogram(0, (void *)Forked_262_4, t2, t7);
    t8 = (t2 + 80U);
    t9 = *((char **)t8);
    xsi_create_forkjoin_process_inside_subprogram(0, (void *)Forked_263_5, t2, t9);
    t10 = (t2 + 80U);
    t11 = *((char **)t10);
    xsi_create_forkjoin_process_inside_subprogram(0, (void *)Forked_264_6, t2, t11);
    xsi_set_forkwaitinfo_inside_subprogram_status(t2, 0, 1);
    *((char **)t3) = &&LAB6;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    t12 = xsi_get_forkvar_inside_subprogram_invocation(t2, 0);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    if (*((int *)t14) > 0)
        goto LAB7;

LAB8:    xsi_clean_active_fork_process_list(t2);
    xsi_set_current_line(266, ng11);
    t4 = (t2 + 96U);
    t6 = *((char **)t4);
    t7 = (t6 + 640U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t2 + 56U);
    t13 = *((char **)t12);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t13, &&LAB9);
    t14 = (t2 + 56U);
    t15 = *((char **)t14);
    t16 = (t1 + 2256);
    t17 = xsi_create_subprogram_invocation(t15, 0, t1, t16, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t16, t17);
    t18 = (t17 + 96U);
    t19 = *((char **)t18);
    t20 = (t19 + 0U);
    xsi_vlogvar_assign_value(t20, t9, 0, 0, 2);

LAB11:    t21 = (t2 + 64U);
    t22 = *((char **)t21);
    t23 = (t22 + 80U);
    t24 = *((char **)t23);
    t25 = (t24 + 272U);
    t26 = *((char **)t25);
    t27 = (t26 + 0U);
    t28 = *((char **)t27);
    t5 = ((int  (*)(char *, char *))t28)(t1, t22);
    if (t5 == -1)
        goto LAB12;

LAB13:    if (t5 != 0)
        goto LAB14;

LAB9:    t22 = (t1 + 2256);
    xsi_vlog_subprogram_popinvocation(t22);

LAB10:    t29 = (t2 + 64U);
    t30 = *((char **)t29);
    t29 = (t1 + 2256);
    t31 = (t2 + 56U);
    t32 = *((char **)t31);
    xsi_delete_subprogram_invocation(t29, t30, t1, t32, t2);
    goto LAB4;

LAB7:    xsi_set_forkwaitinfo_inside_subprogram_status(t2, 0, 1);
    goto LAB1;

LAB12:    t0 = -1;
    goto LAB1;

LAB14:    t21 = (t2 + 48U);
    *((char **)t21) = &&LAB11;
    goto LAB1;

}

static int sp_SINGLE_READ(char *t1, char *t2)
{
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
    int t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1824);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(279, ng11);

LAB5:    xsi_set_current_line(280, ng11);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t2 + 96U);
    t11 = *((char **)t10);
    t12 = (t11 + 320U);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t2 + 56U);
    t16 = *((char **)t15);
    t17 = (t2 + 56U);
    t18 = *((char **)t17);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t18, &&LAB6);
    t19 = (t2 + 56U);
    t20 = *((char **)t19);
    t21 = (t1 + 10272);
    t22 = *((char **)t21);
    t23 = (t1 + 10280);
    t24 = xsi_create_subprogram_invocation(t20, 0, *((char **)t23), ((char*)(t22)), 0, t2);
    xsi_vlog_subprogram_pushinvocation(((char*)(t22)), t24);
    t25 = (t24 + 96U);
    t26 = *((char **)t25);
    t27 = (t26 + 0U);
    xsi_vlogvar_assign_value(t27, t9, 0, 0, 32);
    t28 = (t24 + 96U);
    t29 = *((char **)t28);
    t30 = (t29 + 160U);
    xsi_vlogvar_assign_value(t30, t14, 0, 0, 3);

LAB8:    t31 = (t2 + 64U);
    t32 = *((char **)t31);
    t33 = (t32 + 80U);
    t34 = *((char **)t33);
    t35 = (t34 + 272U);
    t36 = *((char **)t35);
    t37 = (t36 + 0U);
    t38 = *((char **)t37);
    t39 = (t1 + 10280);
    t40 = ((int  (*)(char *, char *))t38)(*((char **)t39), t32);
    if (t40 == -1)
        goto LAB9;

LAB10:    if (t40 != 0)
        goto LAB11;

LAB6:    t32 = (t1 + 10368);
    t41 = *((char **)t32);
    xsi_vlog_subprogram_popinvocation(((char*)(t41)));

LAB7:    t42 = (t2 + 64U);
    t43 = *((char **)t42);
    t42 = (t1 + 10368);
    t44 = *((char **)t42);
    t45 = (t2 + 56U);
    t46 = *((char **)t45);
    xsi_delete_subprogram_invocation(((char*)(t44)), t43, t1, t46, t2);
    xsi_set_current_line(281, ng11);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t7, &&LAB12);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t10 = (t1 + 10464);
    t11 = *((char **)t10);
    t12 = (t1 + 10472);
    t13 = xsi_create_subprogram_invocation(t9, 0, *((char **)t12), ((char*)(t11)), 0, t2);
    xsi_vlog_subprogram_pushinvocation(((char*)(t11)), t13);

LAB14:    t14 = (t2 + 64U);
    t15 = *((char **)t14);
    t16 = (t15 + 80U);
    t17 = *((char **)t16);
    t18 = (t17 + 272U);
    t19 = *((char **)t18);
    t20 = (t19 + 0U);
    t21 = *((char **)t20);
    t22 = (t1 + 10472);
    t40 = ((int  (*)(char *, char *))t21)(*((char **)t22), t15);
    if (t40 == -1)
        goto LAB15;

LAB16:    if (t40 != 0)
        goto LAB17;

LAB12:    t15 = (t1 + 10560);
    t23 = *((char **)t15);
    xsi_vlog_subprogram_popinvocation(((char*)(t23)));

LAB13:    t24 = (t2 + 64U);
    t25 = *((char **)t24);
    t24 = (t25 + 96U);
    t26 = *((char **)t24);
    t27 = (t26 + 0U);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t2 + 96U);
    t31 = *((char **)t30);
    t32 = (t31 + 160U);
    xsi_vlogvar_assign_value(t32, t29, 0, 0, 32);
    t33 = (t25 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 160U);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 96U);
    t39 = *((char **)t38);
    t41 = (t39 + 480U);
    xsi_vlogvar_assign_value(t41, t37, 0, 0, 2);
    t42 = (t1 + 10560);
    t43 = *((char **)t42);
    t44 = (t2 + 56U);
    t45 = *((char **)t44);
    xsi_delete_subprogram_invocation(((char*)(t43)), t25, t1, t45, t2);
    xsi_set_current_line(282, ng11);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 480U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t2 + 56U);
    t12 = *((char **)t11);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t12, &&LAB18);
    t13 = (t2 + 56U);
    t14 = *((char **)t13);
    t15 = (t1 + 2256);
    t16 = xsi_create_subprogram_invocation(t14, 0, t1, t15, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t15, t16);
    t17 = (t16 + 96U);
    t18 = *((char **)t17);
    t19 = (t18 + 0U);
    xsi_vlogvar_assign_value(t19, t8, 0, 0, 2);

LAB20:    t20 = (t2 + 64U);
    t21 = *((char **)t20);
    t22 = (t21 + 80U);
    t23 = *((char **)t22);
    t24 = (t23 + 272U);
    t25 = *((char **)t24);
    t26 = (t25 + 0U);
    t27 = *((char **)t26);
    t40 = ((int  (*)(char *, char *))t27)(t1, t21);
    if (t40 == -1)
        goto LAB21;

LAB22:    if (t40 != 0)
        goto LAB23;

LAB18:    t21 = (t1 + 2256);
    xsi_vlog_subprogram_popinvocation(t21);

LAB19:    t28 = (t2 + 64U);
    t29 = *((char **)t28);
    t28 = (t1 + 2256);
    t30 = (t2 + 56U);
    t31 = *((char **)t30);
    xsi_delete_subprogram_invocation(t28, t29, t1, t31, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB9:    t0 = -1;
    goto LAB1;

LAB11:    t31 = (t2 + 48U);
    *((char **)t31) = &&LAB8;
    goto LAB1;

LAB15:    t0 = -1;
    goto LAB1;

LAB17:    t14 = (t2 + 48U);
    *((char **)t14) = &&LAB14;
    goto LAB1;

LAB21:    t0 = -1;
    goto LAB1;

LAB23:    t20 = (t2 + 48U);
    *((char **)t20) = &&LAB20;
    goto LAB1;

}

static int sp_CHECK_RESPONSE_OKAY(char *t1, char *t2)
{
    char t11[8];
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
    char *t26;
    char *t27;
    char *t28;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 2256);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(294, ng11);

LAB5:    xsi_set_current_line(295, ng11);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng15)));
    memset(t11, 0, 8);
    if (*((unsigned int *)t9) != *((unsigned int *)t10))
        goto LAB7;

LAB6:    t12 = (t9 + 4);
    t13 = (t10 + 4);
    if (*((unsigned int *)t12) != *((unsigned int *)t13))
        goto LAB7;

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
LAB7:    *((unsigned int *)t11) = 1;
    goto LAB8;

LAB9:    xsi_set_current_line(295, ng11);

LAB12:    xsi_set_current_line(296, ng11);
    t20 = (t1 + 2256);
    xsi_vlogfile_write(0, 0, 0, ng16, 1, t20);
    t21 = ((char*)((ng15)));
    t22 = (t1 + 2256);
    xsi_vlogfile_write(0, 0, 0, ng17, 2, t22, (char)118, t21, 2);
    t23 = (t2 + 96U);
    t24 = *((char **)t23);
    t25 = (t24 + 0U);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t1 + 2256);
    xsi_vlogfile_write(1, 0, 0, ng18, 2, t28, (char)118, t27, 2);
    xsi_set_current_line(299, ng11);
    xsi_vlog_stop(1);
    goto LAB11;

}

static int sp_COMPARE_DATA(char *t1, char *t2)
{
    char t11[16];
    char t12[8];
    char t31[16];
    char t32[8];
    char t40[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    char *t44;
    char *t45;
    char *t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    char *t54;
    char *t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    char *t74;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 2688);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(312, ng11);

LAB5:    xsi_set_current_line(313, ng11);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng19)));
    xsi_vlog_unsigned_case_eq(t11, 64, t9, 64, t10, 64);
    memset(t12, 0, 8);
    t13 = (t11 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t11);
    t17 = (t16 & t15);
    t18 = (t17 & 1U);
    if (t18 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t13) != 0)
        goto LAB8;

LAB9:    t20 = (t12 + 4);
    t21 = *((unsigned int *)t12);
    t22 = (!(t21));
    t23 = *((unsigned int *)t20);
    t24 = (t22 || t23);
    if (t24 > 0)
        goto LAB10;

LAB11:    memcpy(t40, t12, 8);

LAB12:    t68 = (t40 + 4);
    t69 = *((unsigned int *)t68);
    t70 = (~(t69));
    t71 = *((unsigned int *)t40);
    t72 = (t71 & t70);
    t73 = (t72 != 0);
    if (t73 > 0)
        goto LAB20;

LAB21:
LAB22:    xsi_set_current_line(317, ng11);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 160U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t2 + 96U);
    t10 = *((char **)t9);
    t13 = (t10 + 0U);
    t19 = (t13 + 56U);
    t20 = *((char **)t19);
    xsi_vlog_unsigned_case_noteq(t11, 64, t8, 64, t20, 64);
    t25 = (t11 + 4);
    t14 = *((unsigned int *)t25);
    t15 = (~(t14));
    t16 = *((unsigned int *)t11);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB24;

LAB25:
LAB26:
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB6:    *((unsigned int *)t12) = 1;
    goto LAB9;

LAB8:    t19 = (t12 + 4);
    *((unsigned int *)t12) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB9;

LAB10:    t25 = (t2 + 96U);
    t26 = *((char **)t25);
    t27 = (t26 + 160U);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = ((char*)((ng19)));
    xsi_vlog_unsigned_case_eq(t31, 64, t29, 64, t30, 64);
    memset(t32, 0, 8);
    t33 = (t31 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t31);
    t37 = (t36 & t35);
    t38 = (t37 & 1U);
    if (t38 != 0)
        goto LAB13;

LAB14:    if (*((unsigned int *)t33) != 0)
        goto LAB15;

LAB16:    t41 = *((unsigned int *)t12);
    t42 = *((unsigned int *)t32);
    t43 = (t41 | t42);
    *((unsigned int *)t40) = t43;
    t44 = (t12 + 4);
    t45 = (t32 + 4);
    t46 = (t40 + 4);
    t47 = *((unsigned int *)t44);
    t48 = *((unsigned int *)t45);
    t49 = (t47 | t48);
    *((unsigned int *)t46) = t49;
    t50 = *((unsigned int *)t46);
    t51 = (t50 != 0);
    if (t51 == 1)
        goto LAB17;

LAB18:
LAB19:    goto LAB12;

LAB13:    *((unsigned int *)t32) = 1;
    goto LAB16;

LAB15:    t39 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB16;

LAB17:    t52 = *((unsigned int *)t40);
    t53 = *((unsigned int *)t46);
    *((unsigned int *)t40) = (t52 | t53);
    t54 = (t12 + 4);
    t55 = (t32 + 4);
    t56 = *((unsigned int *)t54);
    t57 = (~(t56));
    t58 = *((unsigned int *)t12);
    t59 = (t58 & t57);
    t60 = *((unsigned int *)t55);
    t61 = (~(t60));
    t62 = *((unsigned int *)t32);
    t63 = (t62 & t61);
    t64 = (~(t59));
    t65 = (~(t63));
    t66 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t66 & t64);
    t67 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t67 & t65);
    goto LAB19;

LAB20:    xsi_set_current_line(313, ng11);

LAB23:    xsi_set_current_line(314, ng11);
    t74 = (t1 + 2688);
    xsi_vlogfile_write(1, 0, 0, ng20, 1, t74);
    xsi_set_current_line(315, ng11);
    xsi_vlog_stop(1);
    goto LAB22;

LAB24:    xsi_set_current_line(317, ng11);

LAB27:    xsi_set_current_line(318, ng11);
    t26 = (t1 + 2688);
    xsi_vlogfile_write(0, 0, 0, ng21, 1, t26);
    t27 = (t2 + 96U);
    t28 = *((char **)t27);
    t29 = (t28 + 0U);
    t30 = (t29 + 56U);
    t33 = *((char **)t30);
    t39 = (t1 + 2688);
    xsi_vlogfile_write(0, 0, 0, ng17, 2, t39, (char)118, t33, 64);
    t44 = (t2 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 160U);
    t54 = (t46 + 56U);
    t55 = *((char **)t54);
    t68 = (t1 + 2688);
    xsi_vlogfile_write(1, 0, 0, ng22, 2, t68, (char)118, t55, 64);
    xsi_set_current_line(320, ng11);
    xsi_vlog_stop(1);
    goto LAB26;

}

static int sp_GEN_MASTER_REQ(char *t1, char *t2)
{
    char t11[8];
    char t35[8];
    char t84[8];
    char t85[8];
    char t87[8];
    char t118[8];
    char t133[16];
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
    unsigned int t24;
    unsigned int t25;
    char *t26;
    char *t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    char *t33;
    char *t34;
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
    int t71;
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
    unsigned int t86;
    unsigned int t88;
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
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    int t119;
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

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 3120);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(339, ng11);

LAB5:    xsi_set_current_line(340, ng11);
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = ((char*)((ng23)));
    memset(t11, 0, 8);
    t12 = (t9 + 4);
    t13 = (t10 + 4);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = *((unsigned int *)t12);
    t18 = *((unsigned int *)t13);
    t19 = (t17 ^ t18);
    t20 = (t16 | t19);
    t21 = *((unsigned int *)t12);
    t22 = *((unsigned int *)t13);
    t23 = (t21 | t22);
    t24 = (~(t23));
    t25 = (t20 & t24);
    if (t25 != 0)
        goto LAB9;

LAB6:    if (t23 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t11) = 1;

LAB9:    t27 = (t11 + 4);
    t28 = *((unsigned int *)t27);
    t29 = (~(t28));
    t30 = *((unsigned int *)t11);
    t31 = (t30 & t29);
    t32 = (t31 != 0);
    if (t32 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(345, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng25)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = ((char*)((ng27)));
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t9 = (t8 + 320U);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = ((char*)((ng27)));
    t26 = (t2 + 56U);
    t27 = *((char **)t26);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t34, &&LAB19);
    t36 = (t2 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1392);
    t39 = xsi_create_subprogram_invocation(t37, 0, t1, t38, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t38, t39);
    t40 = (t39 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 0U);
    xsi_vlogvar_assign_value(t42, t11, 0, 0, 32);
    t43 = (t39 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 160U);
    xsi_vlogvar_assign_value(t45, t6, 0, 0, 32);
    t46 = (t39 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 320U);
    xsi_vlogvar_assign_value(t48, t12, 0, 0, 3);
    t49 = (t39 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 480U);
    xsi_vlogvar_assign_value(t51, t13, 0, 0, 4);

LAB21:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t54 = (t53 + 80U);
    t55 = *((char **)t54);
    t56 = (t55 + 272U);
    t57 = *((char **)t56);
    t58 = (t57 + 0U);
    t59 = *((char **)t58);
    t71 = ((int  (*)(char *, char *))t59)(t1, t53);
    if (t71 == -1)
        goto LAB22;

LAB23:    if (t71 != 0)
        goto LAB24;

LAB19:    t53 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB20:    t60 = (t2 + 64U);
    t61 = *((char **)t60);
    t60 = (t61 + 96U);
    t62 = *((char **)t60);
    t63 = (t62 + 640U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 480U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 2);
    t69 = (t1 + 1392);
    t70 = (t2 + 56U);
    t72 = *((char **)t70);
    xsi_delete_subprogram_invocation(t69, t61, t1, t72, t2);

LAB12:    xsi_set_current_line(348, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng28)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 160U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t2 + 96U);
    t13 = *((char **)t12);
    t26 = (t13 + 320U);
    t27 = (t26 + 56U);
    t33 = *((char **)t27);
    t34 = ((char*)((ng29)));
    t36 = (t2 + 56U);
    t37 = *((char **)t36);
    t38 = (t2 + 56U);
    t39 = *((char **)t38);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t39, &&LAB25);
    t40 = (t2 + 56U);
    t41 = *((char **)t40);
    t42 = (t1 + 1392);
    t43 = xsi_create_subprogram_invocation(t41, 0, t1, t42, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t42, t43);
    t44 = (t43 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 0U);
    xsi_vlogvar_assign_value(t46, t11, 0, 0, 32);
    t47 = (t43 + 96U);
    t48 = *((char **)t47);
    t49 = (t48 + 160U);
    xsi_vlogvar_assign_value(t49, t10, 0, 0, 32);
    t50 = (t43 + 96U);
    t51 = *((char **)t50);
    t52 = (t51 + 320U);
    xsi_vlogvar_assign_value(t52, t33, 0, 0, 3);
    t53 = (t43 + 96U);
    t54 = *((char **)t53);
    t55 = (t54 + 480U);
    xsi_vlogvar_assign_value(t55, t34, 0, 0, 4);

LAB27:    t56 = (t2 + 64U);
    t57 = *((char **)t56);
    t58 = (t57 + 80U);
    t59 = *((char **)t58);
    t60 = (t59 + 272U);
    t61 = *((char **)t60);
    t62 = (t61 + 0U);
    t63 = *((char **)t62);
    t71 = ((int  (*)(char *, char *))t63)(t1, t57);
    if (t71 == -1)
        goto LAB28;

LAB29:    if (t71 != 0)
        goto LAB30;

LAB25:    t57 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t57);

LAB26:    t64 = (t2 + 64U);
    t65 = *((char **)t64);
    t64 = (t65 + 96U);
    t66 = *((char **)t64);
    t67 = (t66 + 640U);
    t68 = (t67 + 56U);
    t69 = *((char **)t68);
    t70 = (t2 + 96U);
    t72 = *((char **)t70);
    t73 = (t72 + 480U);
    xsi_vlogvar_assign_value(t73, t69, 0, 0, 2);
    t74 = (t1 + 1392);
    t75 = (t2 + 56U);
    t76 = *((char **)t75);
    xsi_delete_subprogram_invocation(t74, t65, t1, t76, t2);
    xsi_set_current_line(351, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng30)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = ((char*)((ng31)));
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t9 = (t8 + 320U);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = ((char*)((ng32)));
    t26 = (t2 + 56U);
    t27 = *((char **)t26);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t34, &&LAB31);
    t36 = (t2 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1392);
    t39 = xsi_create_subprogram_invocation(t37, 0, t1, t38, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t38, t39);
    t40 = (t39 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 0U);
    xsi_vlogvar_assign_value(t42, t11, 0, 0, 32);
    t43 = (t39 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 160U);
    xsi_vlogvar_assign_value(t45, t6, 0, 0, 32);
    t46 = (t39 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 320U);
    xsi_vlogvar_assign_value(t48, t12, 0, 0, 3);
    t49 = (t39 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 480U);
    xsi_vlogvar_assign_value(t51, t13, 0, 0, 4);

LAB33:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t54 = (t53 + 80U);
    t55 = *((char **)t54);
    t56 = (t55 + 272U);
    t57 = *((char **)t56);
    t58 = (t57 + 0U);
    t59 = *((char **)t58);
    t71 = ((int  (*)(char *, char *))t59)(t1, t53);
    if (t71 == -1)
        goto LAB34;

LAB35:    if (t71 != 0)
        goto LAB36;

LAB31:    t53 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB32:    t60 = (t2 + 64U);
    t61 = *((char **)t60);
    t60 = (t61 + 96U);
    t62 = *((char **)t60);
    t63 = (t62 + 640U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 480U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 2);
    t69 = (t1 + 1392);
    t70 = (t2 + 56U);
    t72 = *((char **)t70);
    xsi_delete_subprogram_invocation(t69, t61, t1, t72, t2);
    xsi_set_current_line(354, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng33)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = ((char*)((ng34)));
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t9 = (t8 + 320U);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = ((char*)((ng32)));
    t26 = (t2 + 56U);
    t27 = *((char **)t26);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t34, &&LAB37);
    t36 = (t2 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1392);
    t39 = xsi_create_subprogram_invocation(t37, 0, t1, t38, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t38, t39);
    t40 = (t39 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 0U);
    xsi_vlogvar_assign_value(t42, t11, 0, 0, 32);
    t43 = (t39 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 160U);
    xsi_vlogvar_assign_value(t45, t6, 0, 0, 32);
    t46 = (t39 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 320U);
    xsi_vlogvar_assign_value(t48, t12, 0, 0, 3);
    t49 = (t39 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 480U);
    xsi_vlogvar_assign_value(t51, t13, 0, 0, 4);

LAB39:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t54 = (t53 + 80U);
    t55 = *((char **)t54);
    t56 = (t55 + 272U);
    t57 = *((char **)t56);
    t58 = (t57 + 0U);
    t59 = *((char **)t58);
    t71 = ((int  (*)(char *, char *))t59)(t1, t53);
    if (t71 == -1)
        goto LAB40;

LAB41:    if (t71 != 0)
        goto LAB42;

LAB37:    t53 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB38:    t60 = (t2 + 64U);
    t61 = *((char **)t60);
    t60 = (t61 + 96U);
    t62 = *((char **)t60);
    t63 = (t62 + 640U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 480U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 2);
    t69 = (t1 + 1392);
    t70 = (t2 + 56U);
    t72 = *((char **)t70);
    xsi_delete_subprogram_invocation(t69, t61, t1, t72, t2);
    xsi_set_current_line(357, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng35)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = ((char*)((ng36)));
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t9 = (t8 + 320U);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = ((char*)((ng37)));
    t26 = (t2 + 56U);
    t27 = *((char **)t26);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t34, &&LAB43);
    t36 = (t2 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1392);
    t39 = xsi_create_subprogram_invocation(t37, 0, t1, t38, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t38, t39);
    t40 = (t39 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 0U);
    xsi_vlogvar_assign_value(t42, t11, 0, 0, 32);
    t43 = (t39 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 160U);
    xsi_vlogvar_assign_value(t45, t6, 0, 0, 32);
    t46 = (t39 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 320U);
    xsi_vlogvar_assign_value(t48, t12, 0, 0, 3);
    t49 = (t39 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 480U);
    xsi_vlogvar_assign_value(t51, t13, 0, 0, 4);

LAB45:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t54 = (t53 + 80U);
    t55 = *((char **)t54);
    t56 = (t55 + 272U);
    t57 = *((char **)t56);
    t58 = (t57 + 0U);
    t59 = *((char **)t58);
    t71 = ((int  (*)(char *, char *))t59)(t1, t53);
    if (t71 == -1)
        goto LAB46;

LAB47:    if (t71 != 0)
        goto LAB48;

LAB43:    t53 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB44:    t60 = (t2 + 64U);
    t61 = *((char **)t60);
    t60 = (t61 + 96U);
    t62 = *((char **)t60);
    t63 = (t62 + 640U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 480U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 2);
    t69 = (t1 + 1392);
    t70 = (t2 + 56U);
    t72 = *((char **)t70);
    xsi_delete_subprogram_invocation(t69, t61, t1, t72, t2);
    xsi_set_current_line(360, ng11);
    t4 = ((char*)((ng38)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 640U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 1);
    xsi_set_current_line(361, ng11);
    t4 = ((char*)((ng38)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 960U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(362, ng11);

LAB49:    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 640U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memset(t11, 0, 8);
    t9 = (t8 + 4);
    t14 = *((unsigned int *)t9);
    t15 = (~(t14));
    t16 = *((unsigned int *)t8);
    t17 = (t16 & t15);
    t18 = (t17 & 1U);
    if (t18 != 0)
        goto LAB53;

LAB51:    if (*((unsigned int *)t9) == 0)
        goto LAB50;

LAB52:    t10 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t10) = 1;

LAB53:    memset(t35, 0, 8);
    t12 = (t11 + 4);
    t19 = *((unsigned int *)t12);
    t20 = (~(t19));
    t21 = *((unsigned int *)t11);
    t22 = (t21 & t20);
    t23 = (t22 & 1U);
    if (t23 != 0)
        goto LAB54;

LAB55:    if (*((unsigned int *)t12) != 0)
        goto LAB56;

LAB57:    t26 = (t35 + 4);
    t24 = *((unsigned int *)t35);
    t25 = *((unsigned int *)t26);
    t28 = (t24 || t25);
    if (t28 > 0)
        goto LAB58;

LAB59:    memcpy(t87, t35, 8);

LAB60:    t46 = (t87 + 4);
    t113 = *((unsigned int *)t46);
    t114 = (~(t113));
    t115 = *((unsigned int *)t87);
    t116 = (t115 & t114);
    t117 = (t116 != 0);
    if (t117 > 0)
        goto LAB68;

LAB69:    xsi_set_current_line(369, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng25)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = ((char*)((ng15)));
    t7 = (t2 + 96U);
    t8 = *((char **)t7);
    t9 = (t8 + 320U);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = ((char*)((ng29)));
    t26 = (t2 + 56U);
    t27 = *((char **)t26);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t34, &&LAB77);
    t36 = (t2 + 56U);
    t37 = *((char **)t36);
    t38 = (t1 + 1392);
    t39 = xsi_create_subprogram_invocation(t37, 0, t1, t38, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t38, t39);
    t40 = (t39 + 96U);
    t41 = *((char **)t40);
    t42 = (t41 + 0U);
    xsi_vlogvar_assign_value(t42, t11, 0, 0, 32);
    t43 = (t39 + 96U);
    t44 = *((char **)t43);
    t45 = (t44 + 160U);
    xsi_vlogvar_assign_value(t45, t6, 0, 0, 32);
    t46 = (t39 + 96U);
    t47 = *((char **)t46);
    t48 = (t47 + 320U);
    xsi_vlogvar_assign_value(t48, t12, 0, 0, 3);
    t49 = (t39 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 480U);
    xsi_vlogvar_assign_value(t51, t13, 0, 0, 4);

LAB79:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t54 = (t53 + 80U);
    t55 = *((char **)t54);
    t56 = (t55 + 272U);
    t57 = *((char **)t56);
    t58 = (t57 + 0U);
    t59 = *((char **)t58);
    t71 = ((int  (*)(char *, char *))t59)(t1, t53);
    if (t71 == -1)
        goto LAB80;

LAB81:    if (t71 != 0)
        goto LAB82;

LAB77:    t53 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB78:    t60 = (t2 + 64U);
    t61 = *((char **)t60);
    t60 = (t61 + 96U);
    t62 = *((char **)t60);
    t63 = (t62 + 640U);
    t64 = (t63 + 56U);
    t65 = *((char **)t64);
    t66 = (t2 + 96U);
    t67 = *((char **)t66);
    t68 = (t67 + 480U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 2);
    t69 = (t1 + 1392);
    t70 = (t2 + 56U);
    t72 = *((char **)t70);
    xsi_delete_subprogram_invocation(t69, t61, t1, t72, t2);
    xsi_set_current_line(372, ng11);
    t4 = ((char*)((ng38)));
    t5 = (t2 + 96U);
    t6 = *((char **)t5);
    t7 = (t6 + 800U);
    xsi_vlogvar_assign_value(t7, t4, 0, 0, 32);
    xsi_set_current_line(373, ng11);
    t4 = ((char*)((ng24)));
    t5 = ((char*)((ng25)));
    memset(t11, 0, 8);
    xsi_vlog_unsigned_add(t11, 32, t4, 32, t5, 32);
    t6 = (t2 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 320U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t2 + 56U);
    t13 = *((char **)t12);
    t26 = (t2 + 56U);
    t27 = *((char **)t26);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t27, &&LAB83);
    t33 = (t2 + 56U);
    t34 = *((char **)t33);
    t36 = (t1 + 1824);
    t37 = xsi_create_subprogram_invocation(t34, 0, t1, t36, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t36, t37);
    t38 = (t37 + 96U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    xsi_vlogvar_assign_value(t40, t11, 0, 0, 32);
    t41 = (t37 + 96U);
    t42 = *((char **)t41);
    t43 = (t42 + 320U);
    xsi_vlogvar_assign_value(t43, t10, 0, 0, 3);

LAB85:    t44 = (t2 + 64U);
    t45 = *((char **)t44);
    t46 = (t45 + 80U);
    t47 = *((char **)t46);
    t48 = (t47 + 272U);
    t49 = *((char **)t48);
    t50 = (t49 + 0U);
    t51 = *((char **)t50);
    t71 = ((int  (*)(char *, char *))t51)(t1, t45);
    if (t71 == -1)
        goto LAB86;

LAB87:    if (t71 != 0)
        goto LAB88;

LAB83:    t45 = (t1 + 1824);
    xsi_vlog_subprogram_popinvocation(t45);

LAB84:    t52 = (t2 + 64U);
    t53 = *((char **)t52);
    t52 = (t53 + 96U);
    t54 = *((char **)t52);
    t55 = (t54 + 160U);
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
    t68 = (t67 + 480U);
    xsi_vlogvar_assign_value(t68, t65, 0, 0, 2);
    t69 = (t1 + 1824);
    t70 = (t2 + 56U);
    t72 = *((char **)t70);
    xsi_delete_subprogram_invocation(t69, t53, t1, t72, t2);
    xsi_set_current_line(374, ng11);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng40)));
    t14 = 0;

LAB92:    t15 = (t14 < 1);
    if (t15 == 1)
        goto LAB93;

LAB94:    t14 = 1;

LAB95:    t104 = (t14 < 2);
    if (t104 == 1)
        goto LAB96;

LAB101:    t43 = ((char*)((ng41)));
    t44 = (t2 + 56U);
    t45 = *((char **)t44);
    t46 = (t2 + 56U);
    t47 = *((char **)t46);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t47, &&LAB102);
    t48 = (t2 + 56U);
    t49 = *((char **)t48);
    t50 = (t1 + 2688);
    t51 = xsi_create_subprogram_invocation(t49, 0, t1, t50, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t50, t51);
    t52 = (t51 + 96U);
    t53 = *((char **)t52);
    t54 = (t53 + 0U);
    xsi_vlogvar_assign_value(t54, t133, 0, 0, 64);
    t55 = (t51 + 96U);
    t56 = *((char **)t55);
    t57 = (t56 + 160U);
    xsi_vlogvar_assign_value(t57, t43, 0, 0, 64);

LAB104:    t58 = (t2 + 64U);
    t59 = *((char **)t58);
    t60 = (t59 + 80U);
    t61 = *((char **)t60);
    t62 = (t61 + 272U);
    t63 = *((char **)t62);
    t64 = (t63 + 0U);
    t65 = *((char **)t64);
    t119 = ((int  (*)(char *, char *))t65)(t1, t59);
    if (t119 == -1)
        goto LAB105;

LAB106:    if (t119 != 0)
        goto LAB107;

LAB102:    t59 = (t1 + 2688);
    xsi_vlog_subprogram_popinvocation(t59);

LAB103:    t66 = (t2 + 64U);
    t67 = *((char **)t66);
    t66 = (t1 + 2688);
    t68 = (t2 + 56U);
    t69 = *((char **)t68);
    xsi_delete_subprogram_invocation(t66, t67, t1, t69, t2);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB8:    t26 = (t11 + 4);
    *((unsigned int *)t11) = 1;
    *((unsigned int *)t26) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(342, ng11);
    t33 = ((char*)((ng24)));
    t34 = ((char*)((ng25)));
    memset(t35, 0, 8);
    xsi_vlog_unsigned_add(t35, 32, t33, 32, t34, 32);
    t36 = ((char*)((ng26)));
    t37 = (t2 + 96U);
    t38 = *((char **)t37);
    t39 = (t38 + 320U);
    t40 = (t39 + 56U);
    t41 = *((char **)t40);
    t42 = ((char*)((ng27)));
    t43 = (t2 + 56U);
    t44 = *((char **)t43);
    t45 = (t2 + 56U);
    t46 = *((char **)t45);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t46, &&LAB13);
    t47 = (t2 + 56U);
    t48 = *((char **)t47);
    t49 = (t1 + 1392);
    t50 = xsi_create_subprogram_invocation(t48, 0, t1, t49, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t49, t50);
    t51 = (t50 + 96U);
    t52 = *((char **)t51);
    t53 = (t52 + 0U);
    xsi_vlogvar_assign_value(t53, t35, 0, 0, 32);
    t54 = (t50 + 96U);
    t55 = *((char **)t54);
    t56 = (t55 + 160U);
    xsi_vlogvar_assign_value(t56, t36, 0, 0, 32);
    t57 = (t50 + 96U);
    t58 = *((char **)t57);
    t59 = (t58 + 320U);
    xsi_vlogvar_assign_value(t59, t41, 0, 0, 3);
    t60 = (t50 + 96U);
    t61 = *((char **)t60);
    t62 = (t61 + 480U);
    xsi_vlogvar_assign_value(t62, t42, 0, 0, 4);

LAB15:    t63 = (t2 + 64U);
    t64 = *((char **)t63);
    t65 = (t64 + 80U);
    t66 = *((char **)t65);
    t67 = (t66 + 272U);
    t68 = *((char **)t67);
    t69 = (t68 + 0U);
    t70 = *((char **)t69);
    t71 = ((int  (*)(char *, char *))t70)(t1, t64);
    if (t71 == -1)
        goto LAB16;

LAB17:    if (t71 != 0)
        goto LAB18;

LAB13:    t64 = (t1 + 1392);
    xsi_vlog_subprogram_popinvocation(t64);

LAB14:    t72 = (t2 + 64U);
    t73 = *((char **)t72);
    t72 = (t73 + 96U);
    t74 = *((char **)t72);
    t75 = (t74 + 640U);
    t76 = (t75 + 56U);
    t77 = *((char **)t76);
    t78 = (t2 + 96U);
    t79 = *((char **)t78);
    t80 = (t79 + 480U);
    xsi_vlogvar_assign_value(t80, t77, 0, 0, 2);
    t81 = (t1 + 1392);
    t82 = (t2 + 56U);
    t83 = *((char **)t82);
    xsi_delete_subprogram_invocation(t81, t73, t1, t83, t2);
    goto LAB12;

LAB16:    t0 = -1;
    goto LAB1;

LAB18:    t63 = (t2 + 48U);
    *((char **)t63) = &&LAB15;
    goto LAB1;

LAB22:    t0 = -1;
    goto LAB1;

LAB24:    t52 = (t2 + 48U);
    *((char **)t52) = &&LAB21;
    goto LAB1;

LAB28:    t0 = -1;
    goto LAB1;

LAB30:    t56 = (t2 + 48U);
    *((char **)t56) = &&LAB27;
    goto LAB1;

LAB34:    t0 = -1;
    goto LAB1;

LAB36:    t52 = (t2 + 48U);
    *((char **)t52) = &&LAB33;
    goto LAB1;

LAB40:    t0 = -1;
    goto LAB1;

LAB42:    t52 = (t2 + 48U);
    *((char **)t52) = &&LAB39;
    goto LAB1;

LAB46:    t0 = -1;
    goto LAB1;

LAB48:    t52 = (t2 + 48U);
    *((char **)t52) = &&LAB45;
    goto LAB1;

LAB50:    *((unsigned int *)t11) = 1;
    goto LAB53;

LAB54:    *((unsigned int *)t35) = 1;
    goto LAB57;

LAB56:    t13 = (t35 + 4);
    *((unsigned int *)t35) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB57;

LAB58:    t27 = (t2 + 96U);
    t33 = *((char **)t27);
    t34 = (t33 + 960U);
    t36 = (t34 + 56U);
    t37 = *((char **)t36);
    t38 = ((char*)((ng39)));
    memset(t84, 0, 8);
    xsi_vlog_signed_less(t84, 32, t37, 32, t38, 32);
    memset(t85, 0, 8);
    t39 = (t84 + 4);
    t29 = *((unsigned int *)t39);
    t30 = (~(t29));
    t31 = *((unsigned int *)t84);
    t32 = (t31 & t30);
    t86 = (t32 & 1U);
    if (t86 != 0)
        goto LAB61;

LAB62:    if (*((unsigned int *)t39) != 0)
        goto LAB63;

LAB64:    t88 = *((unsigned int *)t35);
    t89 = *((unsigned int *)t85);
    t90 = (t88 & t89);
    *((unsigned int *)t87) = t90;
    t41 = (t35 + 4);
    t42 = (t85 + 4);
    t43 = (t87 + 4);
    t91 = *((unsigned int *)t41);
    t92 = *((unsigned int *)t42);
    t93 = (t91 | t92);
    *((unsigned int *)t43) = t93;
    t94 = *((unsigned int *)t43);
    t95 = (t94 != 0);
    if (t95 == 1)
        goto LAB65;

LAB66:
LAB67:    goto LAB60;

LAB61:    *((unsigned int *)t85) = 1;
    goto LAB64;

LAB63:    t40 = (t85 + 4);
    *((unsigned int *)t85) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB64;

LAB65:    t96 = *((unsigned int *)t87);
    t97 = *((unsigned int *)t43);
    *((unsigned int *)t87) = (t96 | t97);
    t44 = (t35 + 4);
    t45 = (t85 + 4);
    t98 = *((unsigned int *)t35);
    t99 = (~(t98));
    t100 = *((unsigned int *)t44);
    t101 = (~(t100));
    t102 = *((unsigned int *)t85);
    t103 = (~(t102));
    t104 = *((unsigned int *)t45);
    t105 = (~(t104));
    t71 = (t99 & t101);
    t106 = (t103 & t105);
    t107 = (~(t71));
    t108 = (~(t106));
    t109 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t109 & t107);
    t110 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t110 & t108);
    t111 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t111 & t107);
    t112 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t112 & t108);
    goto LAB67;

LAB68:    xsi_set_current_line(362, ng11);

LAB70:    xsi_set_current_line(363, ng11);
    t47 = ((char*)((ng24)));
    t48 = ((char*)((ng25)));
    memset(t118, 0, 8);
    xsi_vlog_unsigned_add(t118, 32, t47, 32, t48, 32);
    t49 = (t2 + 96U);
    t50 = *((char **)t49);
    t51 = (t50 + 320U);
    t52 = (t51 + 56U);
    t53 = *((char **)t52);
    t54 = (t2 + 56U);
    t55 = *((char **)t54);
    t56 = (t2 + 56U);
    t57 = *((char **)t56);
    xsi_vlog_subprograminvocation_setJumpstate(t2, t57, &&LAB71);
    t58 = (t2 + 56U);
    t59 = *((char **)t58);
    t60 = (t1 + 1824);
    t61 = xsi_create_subprogram_invocation(t59, 0, t1, t60, 0, t2);
    xsi_vlog_subprogram_pushinvocation(t60, t61);
    t62 = (t61 + 96U);
    t63 = *((char **)t62);
    t64 = (t63 + 0U);
    xsi_vlogvar_assign_value(t64, t118, 0, 0, 32);
    t65 = (t61 + 96U);
    t66 = *((char **)t65);
    t67 = (t66 + 320U);
    xsi_vlogvar_assign_value(t67, t53, 0, 0, 3);

LAB73:    t68 = (t2 + 64U);
    t69 = *((char **)t68);
    t70 = (t69 + 80U);
    t72 = *((char **)t70);
    t73 = (t72 + 272U);
    t74 = *((char **)t73);
    t75 = (t74 + 0U);
    t76 = *((char **)t75);
    t119 = ((int  (*)(char *, char *))t76)(t1, t69);
    if (t119 == -1)
        goto LAB74;

LAB75:    if (t119 != 0)
        goto LAB76;

LAB71:    t69 = (t1 + 1824);
    xsi_vlog_subprogram_popinvocation(t69);

LAB72:    t77 = (t2 + 64U);
    t78 = *((char **)t77);
    t77 = (t78 + 96U);
    t79 = *((char **)t77);
    t80 = (t79 + 160U);
    t81 = (t80 + 56U);
    t82 = *((char **)t81);
    t83 = (t2 + 96U);
    t120 = *((char **)t83);
    t121 = (t120 + 800U);
    xsi_vlogvar_assign_value(t121, t82, 0, 0, 32);
    t122 = (t78 + 96U);
    t123 = *((char **)t122);
    t124 = (t123 + 480U);
    t125 = (t124 + 56U);
    t126 = *((char **)t125);
    t127 = (t2 + 96U);
    t128 = *((char **)t127);
    t129 = (t128 + 480U);
    xsi_vlogvar_assign_value(t129, t126, 0, 0, 2);
    t130 = (t1 + 1824);
    t131 = (t2 + 56U);
    t132 = *((char **)t131);
    xsi_delete_subprogram_invocation(t130, t78, t1, t132, t2);
    xsi_set_current_line(364, ng11);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 800U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memset(t11, 0, 8);
    t9 = (t11 + 4);
    t10 = (t8 + 4);
    t14 = *((unsigned int *)t8);
    t15 = (t14 >> 8);
    t16 = (t15 & 1);
    *((unsigned int *)t11) = t16;
    t17 = *((unsigned int *)t10);
    t18 = (t17 >> 8);
    t19 = (t18 & 1);
    *((unsigned int *)t9) = t19;
    t12 = (t2 + 96U);
    t13 = *((char **)t12);
    t26 = (t13 + 640U);
    xsi_vlogvar_assign_value(t26, t11, 0, 0, 1);
    xsi_set_current_line(365, ng11);
    t4 = (t2 + 96U);
    t5 = *((char **)t4);
    t6 = (t5 + 960U);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng23)));
    memset(t11, 0, 8);
    xsi_vlog_signed_add(t11, 32, t8, 32, t9, 32);
    t10 = (t2 + 96U);
    t12 = *((char **)t10);
    t13 = (t12 + 960U);
    xsi_vlogvar_assign_value(t13, t11, 0, 0, 32);
    goto LAB49;

LAB74:    t0 = -1;
    goto LAB1;

LAB76:    t68 = (t2 + 48U);
    *((char **)t68) = &&LAB73;
    goto LAB1;

LAB80:    t0 = -1;
    goto LAB1;

LAB82:    t52 = (t2 + 48U);
    *((char **)t52) = &&LAB79;
    goto LAB1;

LAB86:    t0 = -1;
    goto LAB1;

LAB88:    t44 = (t2 + 48U);
    *((char **)t44) = &&LAB85;
    goto LAB1;

LAB89:    t31 = (t14 * 8);
    t32 = *((unsigned int *)t13);
    t86 = *((unsigned int *)t33);
    *((unsigned int *)t13) = (t32 | t86);
    t34 = (t8 + t31);
    t88 = (t31 + 4);
    t36 = (t8 + t88);
    t37 = (t9 + t31);
    t89 = (t31 + 4);
    t38 = (t9 + t89);
    t90 = *((unsigned int *)t34);
    t91 = (~(t90));
    t92 = *((unsigned int *)t36);
    t93 = (~(t92));
    t94 = *((unsigned int *)t37);
    t95 = (~(t94));
    t96 = *((unsigned int *)t38);
    t97 = (~(t96));
    t71 = (t91 & t93);
    t106 = (t95 & t97);
    t98 = (~(t71));
    t99 = (~(t106));
    t100 = *((unsigned int *)t33);
    *((unsigned int *)t33) = (t100 & t98);
    t101 = *((unsigned int *)t33);
    *((unsigned int *)t33) = (t101 & t99);
    t102 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t102 & t98);
    t103 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t103 & t99);

LAB91:    t14 = (t14 + 1);
    goto LAB92;

LAB90:    goto LAB91;

LAB93:    t16 = (t14 * 8);
    t10 = (t8 + t16);
    t12 = (t9 + t16);
    t13 = (t133 + t16);
    t17 = *((unsigned int *)t10);
    t18 = *((unsigned int *)t12);
    t19 = (t17 & t18);
    *((unsigned int *)t13) = t19;
    t20 = (t14 * 8);
    t21 = (t20 + 4);
    t26 = (t8 + t21);
    t22 = (t20 + 4);
    t27 = (t9 + t22);
    t23 = (t20 + 4);
    t33 = (t133 + t23);
    t24 = *((unsigned int *)t26);
    t25 = *((unsigned int *)t27);
    t28 = (t24 | t25);
    *((unsigned int *)t33) = t28;
    t29 = *((unsigned int *)t33);
    t30 = (t29 != 0);
    if (t30 == 1)
        goto LAB89;
    else
        goto LAB90;

LAB96:    t105 = (t14 * 8);
    t39 = (t133 + t105);
    *((unsigned int *)t39) = 0;
    t107 = (t105 + 4);
    t40 = (t133 + t107);
    *((unsigned int *)t40) = 0;
    t108 = (t14 < 1);
    if (t108 == 1)
        goto LAB97;

LAB99:    t110 = (t14 < 2);
    if (t110 == 1)
        goto LAB98;

LAB100:    t14 = (t14 + 1);
    goto LAB95;

LAB97:    t109 = (t105 + 4);
    t41 = (t8 + t109);
    *((unsigned int *)t39) = *((unsigned int *)t41);
    *((unsigned int *)t40) = *((unsigned int *)t41);
    goto LAB100;

LAB98:    t111 = (t105 + 4);
    t42 = (t9 + t111);
    *((unsigned int *)t39) = *((unsigned int *)t42);
    *((unsigned int *)t40) = *((unsigned int *)t42);
    goto LAB100;

LAB105:    t0 = -1;
    goto LAB1;

LAB107:    t58 = (t2 + 48U);
    *((char **)t58) = &&LAB104;
    goto LAB1;

}

static void Initial_140_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;

LAB0:    t1 = (t0 + 6504U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(140, ng11);

LAB4:    xsi_set_current_line(141, ng11);
    t2 = ((char*)((ng15)));
    t3 = (t0 + 3992);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(142, ng11);
    t2 = (t0 + 6312);
    xsi_process_wait(t2, 2000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(142, ng11);
    t3 = ((char*)((ng27)));
    t4 = (t0 + 3992);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    goto LAB1;

}

static void Initial_149_1(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(149, ng11);
    t1 = ((char*)((ng15)));
    t2 = (t0 + 4152);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Always_150_2(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 7000U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(150, ng11);
    t2 = (t0 + 6808);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(150, ng11);
    t4 = (t0 + 4152);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t0 + 4152);
    xsi_vlogvar_assign_value(t14, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

}

static void Initial_156_3(char *t0)
{
    char t6[8];
    char t36[8];
    char t37[8];
    char t39[8];
    char t40[8];
    char t41[8];
    char t49[8];
    char t77[16];
    char t78[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
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
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t38;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t50;
    char *t51;
    int t52;
    char *t53;
    int t54;
    int t55;
    char *t56;
    int t57;
    int t58;
    int t59;
    int t60;
    int t61;
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

LAB0:    t1 = (t0 + 7248U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(156, ng11);

LAB4:    xsi_set_current_line(158, ng11);

LAB5:    t2 = (t0 + 3992);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng38)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t5);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB11;

LAB10:    t28 = (t0 + 7568);
    *((int *)t28) = 1;
    t29 = (t0 + 7248U);
    *((char **)t29) = &&LAB5;

LAB1:    return;
LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB11:    t30 = (t0 + 7568);
    *((int *)t30) = 0;
    xsi_set_current_line(158, ng11);
    t31 = (t0 + 7584);
    *((int *)t31) = 1;
    t32 = (t0 + 7280);
    *((char **)t32) = t31;
    *((char **)t1) = &&LAB12;
    goto LAB1;

LAB12:    xsi_set_current_line(159, ng11);

LAB13:    t2 = (t0 + 3992);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t5);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB17;

LAB14:    if (t18 != 0)
        goto LAB16;

LAB15:    *((unsigned int *)t6) = 1;

LAB17:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB19;

LAB18:    t28 = (t0 + 7600);
    *((int *)t28) = 1;
    t29 = (t0 + 7248U);
    *((char **)t29) = &&LAB13;
    goto LAB1;

LAB16:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB17;

LAB19:    t30 = (t0 + 7600);
    *((int *)t30) = 0;
    xsi_set_current_line(159, ng11);
    t31 = (t0 + 7616);
    *((int *)t31) = 1;
    t32 = (t0 + 7280);
    *((char **)t32) = t31;
    *((char **)t1) = &&LAB20;
    goto LAB1;

LAB20:    xsi_set_current_line(160, ng11);
    t2 = (t0 + 7056);
    xsi_process_wait(t2, 4000000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(160, ng11);
    t3 = ((char*)((ng38)));
    t4 = (t0 + 5272);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 3);
    xsi_set_current_line(161, ng11);
    xsi_vlogfile_write(1, 0, 0, ng42, 1, t0);
    xsi_set_current_line(162, ng11);
    xsi_vlogfile_write(1, 0, 0, ng43, 1, t0);
    xsi_set_current_line(163, ng11);
    xsi_vlogfile_write(1, 0, 0, ng42, 1, t0);
    xsi_set_current_line(164, ng11);
    t2 = (t0 + 880);
    t3 = *((char **)t2);
    t2 = ((char*)((ng44)));
    memset(t6, 0, 8);
    xsi_vlog_signed_divide(t6, 32, t3, 32, t2, 32);
    t4 = (t0 + 4312);
    xsi_vlogvar_assign_value(t4, t6, 0, 0, 32);
    xsi_set_current_line(165, ng11);
    xsi_set_current_line(165, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB22:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng45)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB23;

LAB24:    xsi_set_current_line(172, ng11);
    xsi_set_current_line(172, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB37:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng45)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(180, ng11);
    xsi_vlogfile_write(1, 0, 0, ng42, 1, t0);
    xsi_set_current_line(181, ng11);
    xsi_vlogfile_write(1, 0, 0, ng49, 1, t0);
    xsi_set_current_line(182, ng11);
    xsi_vlogfile_write(1, 0, 0, ng42, 1, t0);
    xsi_set_current_line(183, ng11);
    t2 = ((char*)((ng50)));
    t3 = (t0 + 4952);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(184, ng11);
    t2 = ((char*)((ng24)));
    t3 = ((char*)((ng51)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t2, 32, t3, 32);
    t4 = (t0 + 5112);
    xsi_vlogvar_assign_value(t4, t6, 0, 0, 32);
    xsi_set_current_line(185, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 5272);
    t22 = (t21 + 56U);
    t28 = *((char **)t22);
    t29 = ((char*)((ng29)));
    t30 = (t0 + 7056);
    t31 = (t0 + 1392);
    t32 = xsi_create_subprogram_invocation(t30, 0, t0, t31, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t31, t32);
    t33 = (t32 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 0U);
    xsi_vlogvar_assign_value(t35, t4, 0, 0, 32);
    t38 = (t32 + 96U);
    t42 = *((char **)t38);
    t43 = (t42 + 160U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t32 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 320U);
    xsi_vlogvar_assign_value(t46, t28, 0, 0, 3);
    t47 = (t32 + 96U);
    t48 = *((char **)t47);
    t50 = (t48 + 480U);
    xsi_vlogvar_assign_value(t50, t29, 0, 0, 4);

LAB60:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t56 = (t53 + 80U);
    t62 = *((char **)t56);
    t63 = (t62 + 272U);
    t64 = *((char **)t63);
    t65 = (t64 + 0U);
    t66 = *((char **)t65);
    t52 = ((int  (*)(char *, char *))t66)(t0, t53);

LAB62:    if (t52 != 0)
        goto LAB63;

LAB58:    t53 = (t0 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB59:    t67 = (t0 + 7152);
    t68 = *((char **)t67);
    t67 = (t68 + 96U);
    t69 = *((char **)t67);
    t70 = (t69 + 640U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 5592);
    xsi_vlogvar_assign_value(t73, t72, 0, 0, 2);
    t74 = (t0 + 1392);
    t75 = (t0 + 7056);
    t76 = 0;
    xsi_delete_subprogram_invocation(t74, t68, t0, t75, t76);
    xsi_set_current_line(186, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4952);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(187, ng11);
    xsi_set_current_line(187, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB64:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng45)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB65;

LAB66:    xsi_set_current_line(194, ng11);
    xsi_vlogfile_write(1, 0, 0, ng52, 1, t0);
    xsi_set_current_line(195, ng11);
    xsi_vlogfile_write(1, 0, 0, ng53, 1, t0);
    xsi_set_current_line(196, ng11);
    xsi_vlogfile_write(1, 0, 0, ng52, 1, t0);
    xsi_set_current_line(197, ng11);
    xsi_vlogfile_write(1, 0, 0, ng54, 1, t0);
    xsi_set_current_line(198, ng11);
    xsi_set_current_line(198, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB83:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng55)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB84;

LAB85:    xsi_set_current_line(208, ng11);
    xsi_vlogfile_write(1, 0, 0, ng57, 1, t0);
    xsi_set_current_line(209, ng11);
    xsi_set_current_line(209, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB99:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng55)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB100;

LAB101:    xsi_set_current_line(216, ng11);
    xsi_vlogfile_write(1, 0, 0, ng58, 1, t0);
    xsi_set_current_line(218, ng11);
    xsi_set_current_line(218, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB109:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng55)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB110;

LAB111:    xsi_set_current_line(235, ng11);
    xsi_set_current_line(235, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 4472);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB125:    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng55)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB126;

LAB127:    xsi_set_current_line(245, ng11);
    xsi_vlogfile_write(1, 0, 0, ng42, 1, t0);
    xsi_set_current_line(246, ng11);
    xsi_vlogfile_write(1, 0, 0, ng60, 1, t0);
    xsi_set_current_line(247, ng11);
    xsi_vlogfile_write(1, 0, 0, ng42, 1, t0);
    goto LAB1;

LAB23:    xsi_set_current_line(165, ng11);

LAB25:    xsi_set_current_line(166, ng11);
    xsi_set_current_line(166, ng11);
    t8 = ((char*)((ng38)));
    t21 = (t0 + 4632);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 32);

LAB26:    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4312);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t8, 32);
    t21 = (t6 + 4);
    t9 = *((unsigned int *)t21);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB27;

LAB28:    xsi_set_current_line(168, ng11);
    t2 = ((char*)((ng24)));
    t3 = ((char*)((ng15)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t2, 32, t3, 32);
    t4 = (t0 + 4472);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 4312);
    t21 = (t8 + 56U);
    t22 = *((char **)t21);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_multiply(t36, 32, t7, 32, t22, 32);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_add(t37, 32, t6, 32, t36, 32);
    t28 = (t0 + 5112);
    xsi_vlogvar_assign_value(t28, t37, 0, 0, 32);
    xsi_set_current_line(169, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlogfile_write(0, 0, 0, ng46, 2, t0, (char)118, t4, 32);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(1, 0, 0, ng47, 2, t0, (char)118, t8, 32);
    xsi_set_current_line(170, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 5272);
    t22 = (t21 + 56U);
    t28 = *((char **)t22);
    t29 = ((char*)((ng29)));
    t30 = (t0 + 7056);
    t31 = (t0 + 1392);
    t32 = xsi_create_subprogram_invocation(t30, 0, t0, t31, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t31, t32);
    t33 = (t32 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 0U);
    xsi_vlogvar_assign_value(t35, t4, 0, 0, 32);
    t38 = (t32 + 96U);
    t42 = *((char **)t38);
    t43 = (t42 + 160U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t32 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 320U);
    xsi_vlogvar_assign_value(t46, t28, 0, 0, 3);
    t47 = (t32 + 96U);
    t48 = *((char **)t47);
    t50 = (t48 + 480U);
    xsi_vlogvar_assign_value(t50, t29, 0, 0, 4);

LAB33:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t56 = (t53 + 80U);
    t62 = *((char **)t56);
    t63 = (t62 + 272U);
    t64 = *((char **)t63);
    t65 = (t64 + 0U);
    t66 = *((char **)t65);
    t52 = ((int  (*)(char *, char *))t66)(t0, t53);

LAB35:    if (t52 != 0)
        goto LAB36;

LAB31:    t53 = (t0 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB32:    t67 = (t0 + 7152);
    t68 = *((char **)t67);
    t67 = (t68 + 96U);
    t69 = *((char **)t67);
    t70 = (t69 + 640U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 5592);
    xsi_vlogvar_assign_value(t73, t72, 0, 0, 2);
    t74 = (t0 + 1392);
    t75 = (t0 + 7056);
    t76 = 0;
    xsi_delete_subprogram_invocation(t74, t68, t0, t75, t76);
    xsi_set_current_line(165, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB22;

LAB27:    xsi_set_current_line(167, ng11);
    t22 = (t0 + 4632);
    t28 = (t22 + 56U);
    t29 = *((char **)t28);
    t30 = (t0 + 4472);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t0 + 4312);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memset(t36, 0, 8);
    xsi_vlog_signed_multiply(t36, 32, t32, 32, t35, 32);
    memset(t37, 0, 8);
    xsi_vlog_signed_add(t37, 32, t29, 32, t36, 32);
    t38 = (t0 + 4952);
    t42 = (t0 + 4952);
    t43 = (t42 + 72U);
    t44 = *((char **)t43);
    t45 = (t0 + 4632);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = ((char*)((ng44)));
    memset(t49, 0, 8);
    xsi_vlog_signed_multiply(t49, 32, t47, 32, t48, 32);
    t50 = ((char*)((ng44)));
    xsi_vlog_convert_indexed_partindices(t39, t40, t41, ((int*)(t44)), 2, t49, 32, 1, t50, 32, 1, 1);
    t51 = (t39 + 4);
    t14 = *((unsigned int *)t51);
    t52 = (!(t14));
    t53 = (t40 + 4);
    t15 = *((unsigned int *)t53);
    t54 = (!(t15));
    t55 = (t52 && t54);
    t56 = (t41 + 4);
    t16 = *((unsigned int *)t56);
    t57 = (!(t16));
    t58 = (t55 && t57);
    if (t58 == 1)
        goto LAB29;

LAB30:    xsi_set_current_line(166, ng11);
    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4632);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB26;

LAB29:    t17 = *((unsigned int *)t41);
    t59 = (t17 + 0);
    t18 = *((unsigned int *)t39);
    t19 = *((unsigned int *)t40);
    t60 = (t18 - t19);
    t61 = (t60 + 1);
    xsi_vlogvar_assign_value(t38, t37, t59, *((unsigned int *)t40), t61);
    goto LAB30;

LAB34:;
LAB36:    t51 = (t0 + 7248U);
    *((char **)t51) = &&LAB33;
    goto LAB1;

LAB38:    xsi_set_current_line(172, ng11);

LAB40:    xsi_set_current_line(173, ng11);
    xsi_set_current_line(173, ng11);
    t8 = ((char*)((ng38)));
    t21 = (t0 + 4632);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 32);

LAB41:    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4312);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t8, 32);
    t21 = (t6 + 4);
    t9 = *((unsigned int *)t21);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB42;

LAB43:    xsi_set_current_line(175, ng11);
    t2 = ((char*)((ng24)));
    t3 = ((char*)((ng15)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t2, 32, t3, 32);
    t4 = (t0 + 4472);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 4312);
    t21 = (t8 + 56U);
    t22 = *((char **)t21);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_multiply(t36, 32, t7, 32, t22, 32);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_add(t37, 32, t6, 32, t36, 32);
    t28 = (t0 + 5112);
    xsi_vlogvar_assign_value(t28, t37, 0, 0, 32);
    xsi_set_current_line(176, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 5272);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 7056);
    t22 = (t0 + 1824);
    t28 = xsi_create_subprogram_invocation(t21, 0, t0, t22, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t22, t28);
    t29 = (t28 + 96U);
    t30 = *((char **)t29);
    t31 = (t30 + 0U);
    xsi_vlogvar_assign_value(t31, t4, 0, 0, 32);
    t32 = (t28 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 320U);
    xsi_vlogvar_assign_value(t34, t8, 0, 0, 3);

LAB48:    t35 = (t0 + 7152);
    t38 = *((char **)t35);
    t42 = (t38 + 80U);
    t43 = *((char **)t42);
    t44 = (t43 + 272U);
    t45 = *((char **)t44);
    t46 = (t45 + 0U);
    t47 = *((char **)t46);
    t52 = ((int  (*)(char *, char *))t47)(t0, t38);

LAB50:    if (t52 != 0)
        goto LAB51;

LAB46:    t38 = (t0 + 1824);
    xsi_vlog_subprogram_popinvocation(t38);

LAB47:    t48 = (t0 + 7152);
    t50 = *((char **)t48);
    t48 = (t50 + 96U);
    t51 = *((char **)t48);
    t53 = (t51 + 160U);
    t56 = (t53 + 56U);
    t62 = *((char **)t56);
    t63 = (t0 + 5432);
    xsi_vlogvar_assign_value(t63, t62, 0, 0, 32);
    t64 = (t50 + 96U);
    t65 = *((char **)t64);
    t66 = (t65 + 480U);
    t67 = (t66 + 56U);
    t68 = *((char **)t67);
    t69 = (t0 + 5592);
    xsi_vlogvar_assign_value(t69, t68, 0, 0, 2);
    t70 = (t0 + 1824);
    t71 = (t0 + 7056);
    t72 = 0;
    xsi_delete_subprogram_invocation(t70, t50, t0, t71, t72);
    xsi_set_current_line(177, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlogfile_write(0, 0, 0, ng48, 2, t0, (char)118, t4, 32);
    t5 = (t0 + 5432);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(1, 0, 0, ng47, 2, t0, (char)118, t8, 32);
    xsi_set_current_line(178, ng11);
    t2 = (t0 + 4952);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memcpy(t77, t4, 8);
    t5 = (t77 + 8);
    memset(t5, 0, 8);
    t7 = (t0 + 5432);
    t8 = (t7 + 56U);
    t21 = *((char **)t8);
    memcpy(t78, t21, 8);
    t22 = (t78 + 8);
    memset(t22, 0, 8);
    t28 = (t0 + 7056);
    t29 = (t0 + 2688);
    t30 = xsi_create_subprogram_invocation(t28, 0, t0, t29, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t29, t30);
    t31 = (t30 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 0U);
    xsi_vlogvar_assign_value(t33, t77, 0, 0, 64);
    t34 = (t30 + 96U);
    t35 = *((char **)t34);
    t38 = (t35 + 160U);
    xsi_vlogvar_assign_value(t38, t78, 0, 0, 64);

LAB54:    t42 = (t0 + 7152);
    t43 = *((char **)t42);
    t44 = (t43 + 80U);
    t45 = *((char **)t44);
    t46 = (t45 + 272U);
    t47 = *((char **)t46);
    t48 = (t47 + 0U);
    t50 = *((char **)t48);
    t52 = ((int  (*)(char *, char *))t50)(t0, t43);

LAB56:    if (t52 != 0)
        goto LAB57;

LAB52:    t43 = (t0 + 2688);
    xsi_vlog_subprogram_popinvocation(t43);

LAB53:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t51 = (t0 + 2688);
    t56 = (t0 + 7056);
    t62 = 0;
    xsi_delete_subprogram_invocation(t51, t53, t0, t56, t62);
    xsi_set_current_line(172, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB37;

LAB42:    xsi_set_current_line(174, ng11);
    t22 = (t0 + 4632);
    t28 = (t22 + 56U);
    t29 = *((char **)t28);
    t30 = (t0 + 4472);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t0 + 4312);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memset(t36, 0, 8);
    xsi_vlog_signed_multiply(t36, 32, t32, 32, t35, 32);
    memset(t37, 0, 8);
    xsi_vlog_signed_add(t37, 32, t29, 32, t36, 32);
    t38 = (t0 + 4952);
    t42 = (t0 + 4952);
    t43 = (t42 + 72U);
    t44 = *((char **)t43);
    t45 = (t0 + 4632);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = ((char*)((ng44)));
    memset(t49, 0, 8);
    xsi_vlog_signed_multiply(t49, 32, t47, 32, t48, 32);
    t50 = ((char*)((ng44)));
    xsi_vlog_convert_indexed_partindices(t39, t40, t41, ((int*)(t44)), 2, t49, 32, 1, t50, 32, 1, 1);
    t51 = (t39 + 4);
    t14 = *((unsigned int *)t51);
    t52 = (!(t14));
    t53 = (t40 + 4);
    t15 = *((unsigned int *)t53);
    t54 = (!(t15));
    t55 = (t52 && t54);
    t56 = (t41 + 4);
    t16 = *((unsigned int *)t56);
    t57 = (!(t16));
    t58 = (t55 && t57);
    if (t58 == 1)
        goto LAB44;

LAB45:    xsi_set_current_line(173, ng11);
    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4632);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB41;

LAB44:    t17 = *((unsigned int *)t41);
    t59 = (t17 + 0);
    t18 = *((unsigned int *)t39);
    t19 = *((unsigned int *)t40);
    t60 = (t18 - t19);
    t61 = (t60 + 1);
    xsi_vlogvar_assign_value(t38, t37, t59, *((unsigned int *)t40), t61);
    goto LAB45;

LAB49:;
LAB51:    t35 = (t0 + 7248U);
    *((char **)t35) = &&LAB48;
    goto LAB1;

LAB55:;
LAB57:    t42 = (t0 + 7248U);
    *((char **)t42) = &&LAB54;
    goto LAB1;

LAB61:;
LAB63:    t51 = (t0 + 7248U);
    *((char **)t51) = &&LAB60;
    goto LAB1;

LAB65:    xsi_set_current_line(187, ng11);

LAB67:    xsi_set_current_line(188, ng11);
    xsi_set_current_line(188, ng11);
    t8 = ((char*)((ng38)));
    t21 = (t0 + 4632);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 32);

LAB68:    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4312);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t8, 32);
    t21 = (t6 + 4);
    t9 = *((unsigned int *)t21);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB69;

LAB70:    xsi_set_current_line(190, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 5272);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 7056);
    t22 = (t0 + 1824);
    t28 = xsi_create_subprogram_invocation(t21, 0, t0, t22, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t22, t28);
    t29 = (t28 + 96U);
    t30 = *((char **)t29);
    t31 = (t30 + 0U);
    xsi_vlogvar_assign_value(t31, t4, 0, 0, 32);
    t32 = (t28 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 320U);
    xsi_vlogvar_assign_value(t34, t8, 0, 0, 3);

LAB73:    t35 = (t0 + 7152);
    t38 = *((char **)t35);
    t42 = (t38 + 80U);
    t43 = *((char **)t42);
    t44 = (t43 + 272U);
    t45 = *((char **)t44);
    t46 = (t45 + 0U);
    t47 = *((char **)t46);
    t52 = ((int  (*)(char *, char *))t47)(t0, t38);

LAB75:    if (t52 != 0)
        goto LAB76;

LAB71:    t38 = (t0 + 1824);
    xsi_vlog_subprogram_popinvocation(t38);

LAB72:    t48 = (t0 + 7152);
    t50 = *((char **)t48);
    t48 = (t50 + 96U);
    t51 = *((char **)t48);
    t53 = (t51 + 160U);
    t56 = (t53 + 56U);
    t62 = *((char **)t56);
    t63 = (t0 + 5432);
    xsi_vlogvar_assign_value(t63, t62, 0, 0, 32);
    t64 = (t50 + 96U);
    t65 = *((char **)t64);
    t66 = (t65 + 480U);
    t67 = (t66 + 56U);
    t68 = *((char **)t67);
    t69 = (t0 + 5592);
    xsi_vlogvar_assign_value(t69, t68, 0, 0, 2);
    t70 = (t0 + 1824);
    t71 = (t0 + 7056);
    t72 = 0;
    xsi_delete_subprogram_invocation(t70, t50, t0, t71, t72);
    xsi_set_current_line(191, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlogfile_write(0, 0, 0, ng48, 2, t0, (char)118, t4, 32);
    t5 = (t0 + 5432);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(1, 0, 0, ng47, 2, t0, (char)118, t8, 32);
    xsi_set_current_line(192, ng11);
    t2 = (t0 + 4952);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memcpy(t77, t4, 8);
    t5 = (t77 + 8);
    memset(t5, 0, 8);
    t7 = (t0 + 5432);
    t8 = (t7 + 56U);
    t21 = *((char **)t8);
    memcpy(t78, t21, 8);
    t22 = (t78 + 8);
    memset(t22, 0, 8);
    t28 = (t0 + 7056);
    t29 = (t0 + 2688);
    t30 = xsi_create_subprogram_invocation(t28, 0, t0, t29, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t29, t30);
    t31 = (t30 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 0U);
    xsi_vlogvar_assign_value(t33, t77, 0, 0, 64);
    t34 = (t30 + 96U);
    t35 = *((char **)t34);
    t38 = (t35 + 160U);
    xsi_vlogvar_assign_value(t38, t78, 0, 0, 64);

LAB79:    t42 = (t0 + 7152);
    t43 = *((char **)t42);
    t44 = (t43 + 80U);
    t45 = *((char **)t44);
    t46 = (t45 + 272U);
    t47 = *((char **)t46);
    t48 = (t47 + 0U);
    t50 = *((char **)t48);
    t52 = ((int  (*)(char *, char *))t50)(t0, t43);

LAB81:    if (t52 != 0)
        goto LAB82;

LAB77:    t43 = (t0 + 2688);
    xsi_vlog_subprogram_popinvocation(t43);

LAB78:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t51 = (t0 + 2688);
    t56 = (t0 + 7056);
    t62 = 0;
    xsi_delete_subprogram_invocation(t51, t53, t0, t56, t62);
    xsi_set_current_line(187, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB64;

LAB69:    xsi_set_current_line(189, ng11);
    t22 = ((char*)((ng24)));
    t28 = ((char*)((ng15)));
    memset(t36, 0, 8);
    xsi_vlog_unsigned_add(t36, 32, t22, 32, t28, 32);
    t29 = (t0 + 4472);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t0 + 4312);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_multiply(t37, 32, t31, 32, t34, 32);
    memset(t39, 0, 8);
    xsi_vlog_unsigned_add(t39, 32, t36, 32, t37, 32);
    t35 = (t0 + 5112);
    xsi_vlogvar_assign_value(t35, t39, 0, 0, 32);
    xsi_set_current_line(188, ng11);
    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4632);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB68;

LAB74:;
LAB76:    t35 = (t0 + 7248U);
    *((char **)t35) = &&LAB73;
    goto LAB1;

LAB80:;
LAB82:    t42 = (t0 + 7248U);
    *((char **)t42) = &&LAB79;
    goto LAB1;

LAB84:    xsi_set_current_line(198, ng11);

LAB86:    xsi_set_current_line(199, ng11);
    xsi_set_current_line(199, ng11);
    t8 = ((char*)((ng38)));
    t21 = (t0 + 4632);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 32);

LAB87:    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4312);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t8, 32);
    t21 = (t6 + 4);
    t9 = *((unsigned int *)t21);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB88;

LAB89:    xsi_set_current_line(203, ng11);
    t2 = ((char*)((ng56)));
    t3 = (t0 + 4472);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 4312);
    t8 = (t7 + 56U);
    t21 = *((char **)t8);
    memset(t6, 0, 8);
    xsi_vlog_unsigned_multiply(t6, 32, t5, 32, t21, 32);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_add(t36, 32, t2, 32, t6, 32);
    t22 = (t0 + 5112);
    xsi_vlogvar_assign_value(t22, t36, 0, 0, 32);
    xsi_set_current_line(204, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlogfile_write(0, 0, 0, ng46, 2, t0, (char)118, t4, 32);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(1, 0, 0, ng47, 2, t0, (char)118, t8, 32);
    xsi_set_current_line(205, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 5272);
    t22 = (t21 + 56U);
    t28 = *((char **)t22);
    t29 = ((char*)((ng29)));
    t30 = (t0 + 7056);
    t31 = (t0 + 1392);
    t32 = xsi_create_subprogram_invocation(t30, 0, t0, t31, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t31, t32);
    t33 = (t32 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 0U);
    xsi_vlogvar_assign_value(t35, t4, 0, 0, 32);
    t38 = (t32 + 96U);
    t42 = *((char **)t38);
    t43 = (t42 + 160U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t32 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 320U);
    xsi_vlogvar_assign_value(t46, t28, 0, 0, 3);
    t47 = (t32 + 96U);
    t48 = *((char **)t47);
    t50 = (t48 + 480U);
    xsi_vlogvar_assign_value(t50, t29, 0, 0, 4);

LAB95:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t56 = (t53 + 80U);
    t62 = *((char **)t56);
    t63 = (t62 + 272U);
    t64 = *((char **)t63);
    t65 = (t64 + 0U);
    t66 = *((char **)t65);
    t52 = ((int  (*)(char *, char *))t66)(t0, t53);

LAB97:    if (t52 != 0)
        goto LAB98;

LAB93:    t53 = (t0 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB94:    t67 = (t0 + 7152);
    t68 = *((char **)t67);
    t67 = (t68 + 96U);
    t69 = *((char **)t67);
    t70 = (t69 + 640U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 5592);
    xsi_vlogvar_assign_value(t73, t72, 0, 0, 2);
    t74 = (t0 + 1392);
    t75 = (t0 + 7056);
    t76 = 0;
    xsi_delete_subprogram_invocation(t74, t68, t0, t75, t76);
    xsi_set_current_line(198, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB83;

LAB88:    xsi_set_current_line(199, ng11);

LAB90:    xsi_set_current_line(200, ng11);
    t22 = (t0 + 4632);
    t28 = (t22 + 56U);
    t29 = *((char **)t28);
    t30 = (t0 + 4472);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t0 + 4312);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memset(t36, 0, 8);
    xsi_vlog_signed_multiply(t36, 32, t32, 32, t35, 32);
    memset(t37, 0, 8);
    xsi_vlog_signed_add(t37, 32, t29, 32, t36, 32);
    t38 = (t0 + 4952);
    t42 = (t0 + 4952);
    t43 = (t42 + 72U);
    t44 = *((char **)t43);
    t45 = (t0 + 4632);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = ((char*)((ng44)));
    memset(t49, 0, 8);
    xsi_vlog_signed_multiply(t49, 32, t47, 32, t48, 32);
    t50 = ((char*)((ng44)));
    xsi_vlog_convert_indexed_partindices(t39, t40, t41, ((int*)(t44)), 2, t49, 32, 1, t50, 32, 1, 1);
    t51 = (t39 + 4);
    t14 = *((unsigned int *)t51);
    t52 = (!(t14));
    t53 = (t40 + 4);
    t15 = *((unsigned int *)t53);
    t54 = (!(t15));
    t55 = (t52 && t54);
    t56 = (t41 + 4);
    t16 = *((unsigned int *)t56);
    t57 = (!(t16));
    t58 = (t55 && t57);
    if (t58 == 1)
        goto LAB91;

LAB92:    xsi_set_current_line(199, ng11);
    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4632);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB87;

LAB91:    t17 = *((unsigned int *)t41);
    t59 = (t17 + 0);
    t18 = *((unsigned int *)t39);
    t19 = *((unsigned int *)t40);
    t60 = (t18 - t19);
    t61 = (t60 + 1);
    xsi_vlogvar_assign_value(t38, t37, t59, *((unsigned int *)t40), t61);
    goto LAB92;

LAB96:;
LAB98:    t51 = (t0 + 7248U);
    *((char **)t51) = &&LAB95;
    goto LAB1;

LAB100:    xsi_set_current_line(209, ng11);

LAB102:    xsi_set_current_line(210, ng11);
    t8 = ((char*)((ng38)));
    t21 = (t0 + 4952);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 32);
    xsi_set_current_line(211, ng11);
    t2 = ((char*)((ng56)));
    t3 = ((char*)((ng55)));
    t4 = (t0 + 4472);
    t5 = (t4 + 56U);
    t7 = *((char **)t5);
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t3, 32, t7, 32);
    t8 = (t0 + 4312);
    t21 = (t8 + 56U);
    t22 = *((char **)t21);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_multiply(t36, 32, t6, 32, t22, 32);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_add(t37, 32, t2, 32, t36, 32);
    t28 = (t0 + 5112);
    xsi_vlogvar_assign_value(t28, t37, 0, 0, 32);
    xsi_set_current_line(212, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlogfile_write(0, 0, 0, ng46, 2, t0, (char)118, t4, 32);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(1, 0, 0, ng47, 2, t0, (char)118, t8, 32);
    xsi_set_current_line(213, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4952);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 5272);
    t22 = (t21 + 56U);
    t28 = *((char **)t22);
    t29 = ((char*)((ng29)));
    t30 = (t0 + 7056);
    t31 = (t0 + 1392);
    t32 = xsi_create_subprogram_invocation(t30, 0, t0, t31, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t31, t32);
    t33 = (t32 + 96U);
    t34 = *((char **)t33);
    t35 = (t34 + 0U);
    xsi_vlogvar_assign_value(t35, t4, 0, 0, 32);
    t38 = (t32 + 96U);
    t42 = *((char **)t38);
    t43 = (t42 + 160U);
    xsi_vlogvar_assign_value(t43, t8, 0, 0, 32);
    t44 = (t32 + 96U);
    t45 = *((char **)t44);
    t46 = (t45 + 320U);
    xsi_vlogvar_assign_value(t46, t28, 0, 0, 3);
    t47 = (t32 + 96U);
    t48 = *((char **)t47);
    t50 = (t48 + 480U);
    xsi_vlogvar_assign_value(t50, t29, 0, 0, 4);

LAB105:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t56 = (t53 + 80U);
    t62 = *((char **)t56);
    t63 = (t62 + 272U);
    t64 = *((char **)t63);
    t65 = (t64 + 0U);
    t66 = *((char **)t65);
    t52 = ((int  (*)(char *, char *))t66)(t0, t53);

LAB107:    if (t52 != 0)
        goto LAB108;

LAB103:    t53 = (t0 + 1392);
    xsi_vlog_subprogram_popinvocation(t53);

LAB104:    t67 = (t0 + 7152);
    t68 = *((char **)t67);
    t67 = (t68 + 96U);
    t69 = *((char **)t67);
    t70 = (t69 + 640U);
    t71 = (t70 + 56U);
    t72 = *((char **)t71);
    t73 = (t0 + 5592);
    xsi_vlogvar_assign_value(t73, t72, 0, 0, 2);
    t74 = (t0 + 1392);
    t75 = (t0 + 7056);
    t76 = 0;
    xsi_delete_subprogram_invocation(t74, t68, t0, t75, t76);
    xsi_set_current_line(209, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB99;

LAB106:;
LAB108:    t51 = (t0 + 7248U);
    *((char **)t51) = &&LAB105;
    goto LAB1;

LAB110:    xsi_set_current_line(218, ng11);

LAB112:    xsi_set_current_line(221, ng11);
    t8 = ((char*)((ng56)));
    t21 = (t0 + 4472);
    t22 = (t21 + 56U);
    t28 = *((char **)t22);
    t29 = (t0 + 4312);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_multiply(t36, 32, t28, 32, t31, 32);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_add(t37, 32, t8, 32, t36, 32);
    t32 = (t0 + 5112);
    xsi_vlogvar_assign_value(t32, t37, 0, 0, 32);
    xsi_set_current_line(222, ng11);
    t2 = ((char*)((ng38)));
    t3 = (t0 + 5112);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 7056);
    t8 = (t0 + 3120);
    t21 = xsi_create_subprogram_invocation(t7, 0, t0, t8, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t8, t21);
    t22 = (t21 + 96U);
    t28 = *((char **)t22);
    t29 = (t28 + 0U);
    xsi_vlogvar_assign_value(t29, t2, 0, 0, 1);
    t30 = (t21 + 96U);
    t31 = *((char **)t30);
    t32 = (t31 + 160U);
    xsi_vlogvar_assign_value(t32, t5, 0, 0, 32);

LAB115:    t33 = (t0 + 7152);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t38 = *((char **)t35);
    t42 = (t38 + 272U);
    t43 = *((char **)t42);
    t44 = (t43 + 0U);
    t45 = *((char **)t44);
    t52 = ((int  (*)(char *, char *))t45)(t0, t34);

LAB117:    if (t52 != 0)
        goto LAB118;

LAB113:    t34 = (t0 + 3120);
    xsi_vlog_subprogram_popinvocation(t34);

LAB114:    t46 = (t0 + 7152);
    t47 = *((char **)t46);
    t46 = (t0 + 3120);
    t48 = (t0 + 7056);
    t50 = 0;
    xsi_delete_subprogram_invocation(t46, t47, t0, t48, t50);
    xsi_set_current_line(227, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng55)));
    t7 = (t0 + 4312);
    t8 = (t7 + 56U);
    t21 = *((char **)t8);
    memset(t6, 0, 8);
    xsi_vlog_unsigned_multiply(t6, 32, t5, 32, t21, 32);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_add(t36, 32, t4, 32, t6, 32);
    t22 = (t0 + 5112);
    xsi_vlogvar_assign_value(t22, t36, 0, 0, 32);
    xsi_set_current_line(228, ng11);
    t2 = ((char*)((ng23)));
    t3 = (t0 + 5112);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = (t0 + 7056);
    t8 = (t0 + 3120);
    t21 = xsi_create_subprogram_invocation(t7, 0, t0, t8, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t8, t21);
    t22 = (t21 + 96U);
    t28 = *((char **)t22);
    t29 = (t28 + 0U);
    xsi_vlogvar_assign_value(t29, t2, 0, 0, 1);
    t30 = (t21 + 96U);
    t31 = *((char **)t30);
    t32 = (t31 + 160U);
    xsi_vlogvar_assign_value(t32, t5, 0, 0, 32);

LAB121:    t33 = (t0 + 7152);
    t34 = *((char **)t33);
    t35 = (t34 + 80U);
    t38 = *((char **)t35);
    t42 = (t38 + 272U);
    t43 = *((char **)t42);
    t44 = (t43 + 0U);
    t45 = *((char **)t44);
    t52 = ((int  (*)(char *, char *))t45)(t0, t34);

LAB123:    if (t52 != 0)
        goto LAB124;

LAB119:    t34 = (t0 + 3120);
    xsi_vlog_subprogram_popinvocation(t34);

LAB120:    t46 = (t0 + 7152);
    t47 = *((char **)t46);
    t46 = (t0 + 3120);
    t48 = (t0 + 7056);
    t50 = 0;
    xsi_delete_subprogram_invocation(t46, t47, t0, t48, t50);
    xsi_set_current_line(218, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB109;

LAB116:;
LAB118:    t33 = (t0 + 7248U);
    *((char **)t33) = &&LAB115;
    goto LAB1;

LAB122:;
LAB124:    t33 = (t0 + 7248U);
    *((char **)t33) = &&LAB121;
    goto LAB1;

LAB126:    xsi_set_current_line(235, ng11);

LAB128:    xsi_set_current_line(236, ng11);
    xsi_set_current_line(236, ng11);
    t8 = ((char*)((ng38)));
    t21 = (t0 + 4632);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 32);

LAB129:    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4312);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t8, 32);
    t21 = (t6 + 4);
    t9 = *((unsigned int *)t21);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB130;

LAB131:    xsi_set_current_line(239, ng11);
    t2 = ((char*)((ng56)));
    t3 = (t0 + 4472);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t7 = ((char*)((ng55)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t5, 32, t7, 32);
    t8 = (t0 + 4312);
    t21 = (t8 + 56U);
    t22 = *((char **)t21);
    memset(t36, 0, 8);
    xsi_vlog_unsigned_multiply(t36, 32, t6, 32, t22, 32);
    memset(t37, 0, 8);
    xsi_vlog_unsigned_add(t37, 32, t2, 32, t36, 32);
    t28 = (t0 + 5112);
    xsi_vlogvar_assign_value(t28, t37, 0, 0, 32);
    xsi_set_current_line(240, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 5272);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t21 = (t0 + 7056);
    t22 = (t0 + 1824);
    t28 = xsi_create_subprogram_invocation(t21, 0, t0, t22, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t22, t28);
    t29 = (t28 + 96U);
    t30 = *((char **)t29);
    t31 = (t30 + 0U);
    xsi_vlogvar_assign_value(t31, t4, 0, 0, 32);
    t32 = (t28 + 96U);
    t33 = *((char **)t32);
    t34 = (t33 + 320U);
    xsi_vlogvar_assign_value(t34, t8, 0, 0, 3);

LAB136:    t35 = (t0 + 7152);
    t38 = *((char **)t35);
    t42 = (t38 + 80U);
    t43 = *((char **)t42);
    t44 = (t43 + 272U);
    t45 = *((char **)t44);
    t46 = (t45 + 0U);
    t47 = *((char **)t46);
    t52 = ((int  (*)(char *, char *))t47)(t0, t38);

LAB138:    if (t52 != 0)
        goto LAB139;

LAB134:    t38 = (t0 + 1824);
    xsi_vlog_subprogram_popinvocation(t38);

LAB135:    t48 = (t0 + 7152);
    t50 = *((char **)t48);
    t48 = (t50 + 96U);
    t51 = *((char **)t48);
    t53 = (t51 + 160U);
    t56 = (t53 + 56U);
    t62 = *((char **)t56);
    t63 = (t0 + 5432);
    xsi_vlogvar_assign_value(t63, t62, 0, 0, 32);
    t64 = (t50 + 96U);
    t65 = *((char **)t64);
    t66 = (t65 + 480U);
    t67 = (t66 + 56U);
    t68 = *((char **)t67);
    t69 = (t0 + 5592);
    xsi_vlogvar_assign_value(t69, t68, 0, 0, 2);
    t70 = (t0 + 1824);
    t71 = (t0 + 7056);
    t72 = 0;
    xsi_delete_subprogram_invocation(t70, t50, t0, t71, t72);
    xsi_set_current_line(241, ng11);
    t2 = (t0 + 5112);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlogfile_write(0, 0, 0, ng48, 2, t0, (char)118, t4, 32);
    t5 = (t0 + 5432);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(1, 0, 0, ng59, 2, t0, (char)118, t8, 32);
    xsi_set_current_line(242, ng11);
    t2 = (t0 + 4952);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memcpy(t77, t4, 8);
    t5 = (t77 + 8);
    memset(t5, 0, 8);
    t7 = (t0 + 5432);
    t8 = (t7 + 56U);
    t21 = *((char **)t8);
    memcpy(t78, t21, 8);
    t22 = (t78 + 8);
    memset(t22, 0, 8);
    t28 = (t0 + 7056);
    t29 = (t0 + 2688);
    t30 = xsi_create_subprogram_invocation(t28, 0, t0, t29, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t29, t30);
    t31 = (t30 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 0U);
    xsi_vlogvar_assign_value(t33, t77, 0, 0, 64);
    t34 = (t30 + 96U);
    t35 = *((char **)t34);
    t38 = (t35 + 160U);
    xsi_vlogvar_assign_value(t38, t78, 0, 0, 64);

LAB142:    t42 = (t0 + 7152);
    t43 = *((char **)t42);
    t44 = (t43 + 80U);
    t45 = *((char **)t44);
    t46 = (t45 + 272U);
    t47 = *((char **)t46);
    t48 = (t47 + 0U);
    t50 = *((char **)t48);
    t52 = ((int  (*)(char *, char *))t50)(t0, t43);

LAB144:    if (t52 != 0)
        goto LAB145;

LAB140:    t43 = (t0 + 2688);
    xsi_vlog_subprogram_popinvocation(t43);

LAB141:    t51 = (t0 + 7152);
    t53 = *((char **)t51);
    t51 = (t0 + 2688);
    t56 = (t0 + 7056);
    t62 = 0;
    xsi_delete_subprogram_invocation(t51, t53, t0, t56, t62);
    xsi_set_current_line(235, ng11);
    t2 = (t0 + 4472);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4472);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB125;

LAB130:    xsi_set_current_line(237, ng11);
    t22 = (t0 + 4632);
    t28 = (t22 + 56U);
    t29 = *((char **)t28);
    t30 = (t0 + 4472);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    t33 = (t0 + 4312);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    memset(t36, 0, 8);
    xsi_vlog_signed_multiply(t36, 32, t32, 32, t35, 32);
    memset(t37, 0, 8);
    xsi_vlog_signed_add(t37, 32, t29, 32, t36, 32);
    t38 = (t0 + 4952);
    t42 = (t0 + 4952);
    t43 = (t42 + 72U);
    t44 = *((char **)t43);
    t45 = (t0 + 4632);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = ((char*)((ng44)));
    memset(t49, 0, 8);
    xsi_vlog_signed_multiply(t49, 32, t47, 32, t48, 32);
    t50 = ((char*)((ng44)));
    xsi_vlog_convert_indexed_partindices(t39, t40, t41, ((int*)(t44)), 2, t49, 32, 1, t50, 32, 1, 1);
    t51 = (t39 + 4);
    t14 = *((unsigned int *)t51);
    t52 = (!(t14));
    t53 = (t40 + 4);
    t15 = *((unsigned int *)t53);
    t54 = (!(t15));
    t55 = (t52 && t54);
    t56 = (t41 + 4);
    t16 = *((unsigned int *)t56);
    t57 = (!(t16));
    t58 = (t55 && t57);
    if (t58 == 1)
        goto LAB132;

LAB133:    xsi_set_current_line(236, ng11);
    t2 = (t0 + 4632);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng23)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 4632);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB129;

LAB132:    t17 = *((unsigned int *)t41);
    t59 = (t17 + 0);
    t18 = *((unsigned int *)t39);
    t19 = *((unsigned int *)t40);
    t60 = (t18 - t19);
    t61 = (t60 + 1);
    xsi_vlogvar_assign_value(t38, t37, t59, *((unsigned int *)t40), t61);
    goto LAB133;

LAB137:;
LAB139:    t35 = (t0 + 7248U);
    *((char **)t35) = &&LAB136;
    goto LAB1;

LAB143:;
LAB145:    t42 = (t0 + 7248U);
    *((char **)t42) = &&LAB142;
    goto LAB1;

}

static void Forked_262_4(char *t0)
{
    char t46[8];
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
    int t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    unsigned int t47;

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
    xsi_set_current_line(262, ng11);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 0U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 320U);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t17 = (t2 + 10664);
    t18 = *((char **)t17);
    t19 = (t2 + 10672);
    t20 = xsi_create_subprogram_invocation(t16, 0, *((char **)t19), ((char*)(t18)), 0, 0);
    xsi_vlog_subprogram_pushinvocation(((char*)(t18)), t20);
    t21 = (t20 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 0U);
    xsi_vlogvar_assign_value(t23, t10, 0, 0, 32);
    t24 = (t20 + 96U);
    t25 = *((char **)t24);
    t26 = (t25 + 160U);
    xsi_vlogvar_assign_value(t26, t15, 0, 0, 3);

LAB7:    t27 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t28 = (t27 + 96U);
    t29 = *((char **)t28);
    t30 = (t29 + 80U);
    t31 = *((char **)t30);
    t32 = (t31 + 272U);
    t33 = *((char **)t32);
    t34 = (t33 + 0U);
    t35 = *((char **)t34);
    t36 = (t2 + 10672);
    t37 = ((int  (*)(char *, char *))t35)(*((char **)t36), t29);

LAB9:    if (t37 != 0)
        goto LAB10;

LAB5:    t38 = (t2 + 10768);
    t39 = *((char **)t38);
    xsi_vlog_subprogram_popinvocation(((char*)(t39)));

LAB6:    t40 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t41 = (t2 + 10768);
    t43 = *((char **)t41);
    t44 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t45 = 0;
    xsi_delete_subprogram_invocation(((char*)(t43)), t42, t2, t44, t45);

LAB4:    t1 = xsi_get_forkvar_inside_subprogram_invocation(t0, 0);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    memcpy(t46, t5, 8);
    t47 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t47 - 1);
    xsi_vlogvar_assign_value(t1, t46, 0, 0, 32);

LAB1:    return;
LAB8:;
LAB10:    t28 = xsi_get_forkjoin_process_inside_subprogram(t0, 0);
    t29 = (t28 + 192U);
    *((char **)t29) = &&LAB7;
    goto LAB1;

}

static void Forked_263_5(char *t0)
{
    char t46[8];
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
    int t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    unsigned int t47;

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
    xsi_set_current_line(263, ng11);
    t6 = (t0 + 96U);
    t7 = *((char **)t6);
    t8 = (t7 + 480U);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t0 + 96U);
    t12 = *((char **)t11);
    t13 = (t12 + 160U);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t17 = (t2 + 10864);
    t18 = *((char **)t17);
    t19 = (t2 + 10872);
    t20 = xsi_create_subprogram_invocation(t16, 0, *((char **)t19), ((char*)(t18)), 0, 0);
    xsi_vlog_subprogram_pushinvocation(((char*)(t18)), t20);
    t21 = (t20 + 96U);
    t22 = *((char **)t21);
    t23 = (t22 + 0U);
    xsi_vlogvar_assign_value(t23, t10, 0, 0, 4);
    t24 = (t20 + 96U);
    t25 = *((char **)t24);
    t26 = (t25 + 160U);
    xsi_vlogvar_assign_value(t26, t15, 0, 0, 32);

LAB7:    t27 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t28 = (t27 + 96U);
    t29 = *((char **)t28);
    t30 = (t29 + 80U);
    t31 = *((char **)t30);
    t32 = (t31 + 272U);
    t33 = *((char **)t32);
    t34 = (t33 + 0U);
    t35 = *((char **)t34);
    t36 = (t2 + 10872);
    t37 = ((int  (*)(char *, char *))t35)(*((char **)t36), t29);

LAB9:    if (t37 != 0)
        goto LAB10;

LAB5:    t38 = (t2 + 10960);
    t39 = *((char **)t38);
    xsi_vlog_subprogram_popinvocation(((char*)(t39)));

LAB6:    t40 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t41 = (t40 + 96U);
    t42 = *((char **)t41);
    t41 = (t2 + 10960);
    t43 = *((char **)t41);
    t44 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t45 = 0;
    xsi_delete_subprogram_invocation(((char*)(t43)), t42, t2, t44, t45);

LAB4:    t1 = xsi_get_forkvar_inside_subprogram_invocation(t0, 0);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    memcpy(t46, t5, 8);
    t47 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t47 - 1);
    xsi_vlogvar_assign_value(t1, t46, 0, 0, 32);

LAB1:    return;
LAB8:;
LAB10:    t28 = xsi_get_forkjoin_process_inside_subprogram(t0, 1);
    t29 = (t28 + 192U);
    *((char **)t29) = &&LAB7;
    goto LAB1;

}

static void Forked_264_6(char *t0)
{
    char t38[8];
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
    int t21;
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
    unsigned int t39;

LAB0:    t1 = (t0 + 72U);
    t2 = *((char **)t1);
    t3 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    t4 = (t3 + 192U);
    t5 = *((char **)t4);
    if (t5 == 0)
        goto LAB2;

LAB3:    goto *t5;

LAB2:    t5 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    xsi_vlog_process_setdisablestate(t5, &&LAB4);
    xsi_set_current_line(264, ng11);
    t6 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    t7 = (t2 + 11064);
    t8 = *((char **)t7);
    t9 = (t2 + 11072);
    t10 = xsi_create_subprogram_invocation(t6, 0, *((char **)t9), ((char*)(t8)), 0, 0);
    xsi_vlog_subprogram_pushinvocation(((char*)(t8)), t10);

LAB7:    t11 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    t12 = (t11 + 96U);
    t13 = *((char **)t12);
    t14 = (t13 + 80U);
    t15 = *((char **)t14);
    t16 = (t15 + 272U);
    t17 = *((char **)t16);
    t18 = (t17 + 0U);
    t19 = *((char **)t18);
    t20 = (t2 + 11072);
    t21 = ((int  (*)(char *, char *))t19)(*((char **)t20), t13);

LAB9:    if (t21 != 0)
        goto LAB10;

LAB5:    t22 = (t2 + 11168);
    t23 = *((char **)t22);
    xsi_vlog_subprogram_popinvocation(((char*)(t23)));

LAB6:    t24 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    t25 = (t24 + 96U);
    t26 = *((char **)t25);
    t25 = (t26 + 96U);
    t27 = *((char **)t25);
    t28 = (t27 + 0U);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = (t0 + 96U);
    t32 = *((char **)t31);
    t33 = (t32 + 640U);
    xsi_vlogvar_assign_value(t33, t30, 0, 0, 2);
    t34 = (t2 + 11168);
    t35 = *((char **)t34);
    t36 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    t37 = 0;
    xsi_delete_subprogram_invocation(((char*)(t35)), t26, t2, t36, t37);

LAB4:    t1 = xsi_get_forkvar_inside_subprogram_invocation(t0, 0);
    t3 = (t1 + 56U);
    t5 = *((char **)t3);
    memcpy(t38, t5, 8);
    t39 = *((unsigned int *)t38);
    *((unsigned int *)t38) = (t39 - 1);
    xsi_vlogvar_assign_value(t1, t38, 0, 0, 32);

LAB1:    return;
LAB8:;
LAB10:    t12 = xsi_get_forkjoin_process_inside_subprogram(t0, 2);
    t13 = (t12 + 192U);
    *((char **)t13) = &&LAB7;
    goto LAB1;

}


extern void work_m_17621376616792139537_0488649307_init()
{
	static char *pe[] = {(void *)Initial_140_0,(void *)Initial_149_1,(void *)Always_150_2,(void *)Initial_156_3};
	static char *se[] = {(void *)sp_SINGLE_WRITE,(void *)sp_SINGLE_READ,(void *)sp_CHECK_RESPONSE_OKAY,(void *)sp_COMPARE_DATA,(void *)sp_GEN_MASTER_REQ};
	xsi_register_didat("work_m_17621376616792139537_0488649307", "isim/isim_bfm_system.sim/work/m_17621376616792139537_0488649307.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
	xsi_register_subprogram_init(1, (void *)SINGLE_WRITE_varinit);
	xsi_register_subprogram_init(2, (void *)SINGLE_READ_varinit);
	xsi_register_subprogram_init(3, (void *)CHECK_RESPONSE_OKAY_varinit);
	xsi_register_subprogram_init(4, (void *)COMPARE_DATA_varinit);
	xsi_register_subprogram_init(5, (void *)GEN_MASTER_REQ_varinit);
}
