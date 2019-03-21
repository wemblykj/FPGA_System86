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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *PROC_COMMON_V3_00_A_P_4147123038;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *PROC_COMMON_V3_00_A_P_2444876401;
char *IEEE_P_1242562249;
char *UNISIM_P_0947159679;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-13);
    secureip_m_13511109259789057922_1620950414_init();
    cdn_axi4_lite_master_bfm_wrap_v2_01_b_m_10665483959287052059_1281788227_init();
    work_m_03986995518248580703_0172061096_init();
    secureip_m_14885042784626448528_3733016353_init();
    cdn_axi4_slave_bfm_wrap_v2_01_b_m_15779819978726013949_0017390179_init();
    work_m_03851143462947552055_3661753353_init();
    axi_interconnect_v1_06_a_m_05242182079744805947_1891171330_init();
    axi_interconnect_v1_06_a_m_05242182079744805947_3419179701_init();
    axi_interconnect_v1_06_a_m_05242182079744805947_0615229489_init();
    axi_interconnect_v1_06_a_m_05242182079744805947_3705990773_init();
    axi_interconnect_v1_06_a_m_02022051384201480636_3149699661_init();
    axi_interconnect_v1_06_a_m_09790589700459938510_3749783856_init();
    axi_interconnect_v1_06_a_m_01742875151299725405_3166636469_init();
    axi_interconnect_v1_06_a_m_01676794631051941824_0856102106_init();
    axi_interconnect_v1_06_a_m_03414206120657254153_3319252396_init();
    axi_interconnect_v1_06_a_m_03396409324246383675_1804217362_init();
    axi_interconnect_v1_06_a_m_03414206120657254153_2932381463_init();
    axi_interconnect_v1_06_a_m_09959061102228604522_2772372856_init();
    axi_interconnect_v1_06_a_m_02299728925556858157_1668569736_init();
    axi_interconnect_v1_06_a_m_01351947538786234465_3003443197_init();
    axi_interconnect_v1_06_a_m_14644133197522250211_0154444130_init();
    axi_interconnect_v1_06_a_m_11821160183776056666_1670784820_init();
    axi_interconnect_v1_06_a_m_01813711481159122068_3471636900_init();
    axi_interconnect_v1_06_a_m_15313874814666931987_1049947203_init();
    axi_interconnect_v1_06_a_m_15313874814666931987_2974975150_init();
    axi_interconnect_v1_06_a_m_14462056132263107898_3217662082_init();
    axi_interconnect_v1_06_a_m_11821160183776056666_2516653168_init();
    axi_interconnect_v1_06_a_m_11821160183776056666_3030343318_init();
    axi_interconnect_v1_06_a_m_14462056132263107898_4195896038_init();
    axi_interconnect_v1_06_a_m_05242182079744805947_2127593516_init();
    axi_interconnect_v1_06_a_m_14462056132263107898_1499097745_init();
    axi_interconnect_v1_06_a_m_05225473835918104342_1715207630_init();
    axi_interconnect_v1_06_a_m_10205262360788560506_3643633672_init();
    axi_interconnect_v1_06_a_m_13065764652148609973_3017384839_init();
    work_m_13301036995482623439_0602607925_init();
    work_m_10936720544916880316_0196419766_init();
    work_m_17621376616792139537_0488649307_init();
    work_m_16541823861846354283_2073120511_init();
    ieee_p_2592010699_init();
    unisim_p_0947159679_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    ieee_p_1242562249_init();
    proc_common_v3_00_a_p_2444876401_init();
    proc_common_v3_00_a_p_4147123038_init();
    axi_master_lite_v1_00_a_a_1442623447_3640575771_init();
    axi_master_lite_v1_00_a_a_1217337167_3640575771_init();
    axi_master_lite_v1_00_a_a_1097934104_3640575771_init();
    axi_lite_ram_v1_00_a_a_0412488095_3306564128_init();
    work_a_1966751928_0632001823_init();


    xsi_register_tops("work_m_17621376616792139537_0488649307");
    xsi_register_tops("work_m_16541823861846354283_2073120511");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    PROC_COMMON_V3_00_A_P_4147123038 = xsi_get_engine_memory("proc_common_v3_00_a_p_4147123038");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    PROC_COMMON_V3_00_A_P_2444876401 = xsi_get_engine_memory("proc_common_v3_00_a_p_2444876401");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");

    return xsi_run_simulation(argc, argv);

}
