#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_system_wave.tcl (Wed Mar 20 17:46:27 2019)
#
#  ISE Simulator Trace Script File
#
#  Trace script files specify signals to save for later
#  display when viewing results of the simulation a graphic
#  format. Comment or uncomment commands to change the set of
#  signals viewed.
#
puts  "Setting up signal tracing ..."

if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "bfm_system_tb${ps}dut" }

#
#  Trace top-level ports
#
set id [group add "Top level ports"]
source top_level_ports_wave.tcl


#
#  Trace Bus signal ports
#
set id [group add "Bus signal ports" ]
source axi4lite_bus_wave.tcl

#
#  Trace Processor ports
#
set id [group add "Processor ports" ]
#
#  Trace processor registers
#

set id [group add "Processor registers"]
#
#  Trace IP and peripheral ports
#
set id [group add "IP and peripheral ports" ]
source bfm_processor_wave.tcl

source bfm_memory_wave.tcl

source axi_lite_ram_inst_wave.tcl

#
#  Trace setup complete. Start tracing the signals.
#

puts  "Signal tracing setup completed."

puts  "Simulate the design with the 'run' command."
