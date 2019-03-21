#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     top_level_ports_wave.tcl (Wed Mar 20 17:46:27 2019)
#
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "bfm_system_tb${ps}dut" }

wave add $tbpath${ps}sys_reset -into $id 
wave add $tbpath${ps}sys_clk -into $id 

