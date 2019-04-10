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



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_17056120930463595330_3539760012_init();
    work_m_11538582287416243585_4032716190_init();
    work_m_09595627467295175854_3180809772_init();
    work_m_14198717948972833701_0130011055_init();
    work_m_04817959177190708770_0624438269_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_04817959177190708770_0624438269");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
