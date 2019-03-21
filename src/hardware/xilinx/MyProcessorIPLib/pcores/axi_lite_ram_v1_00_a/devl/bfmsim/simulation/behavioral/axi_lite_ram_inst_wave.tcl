#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     axi_lite_ram_inst_wave.tcl (Wed Mar 20 17:46:27 2019)
#
#  Module   bfm_system_axi_lite_ram_inst_wrapper
#  Instance axi_lite_ram_inst
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "bfm_system_tb${ps}dut" }

  wave add $tbpath${ps}axi_lite_ram_inst${ps}slave_addr_offset -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_aclk -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_aresetn -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}md_error -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_arready -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_arvalid -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_araddr -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_arprot -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_rready -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_rvalid -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_rdata -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_rresp -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_awready -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_awvalid -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_awaddr -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_awprot -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_wready -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_wvalid -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_wdata -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_wstrb -into $id
  wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_bready -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_bvalid -into $id
# wave add $tbpath${ps}axi_lite_ram_inst${ps}m_axi_lite_bresp -into $id

