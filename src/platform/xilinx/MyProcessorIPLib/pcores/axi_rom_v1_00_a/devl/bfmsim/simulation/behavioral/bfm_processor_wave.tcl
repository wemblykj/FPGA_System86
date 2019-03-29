#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_processor_wave.tcl (Wed Mar 20 17:46:27 2019)
#
#  Module   bfm_system_bfm_processor_wrapper
#  Instance bfm_processor
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "bfm_system_tb${ps}dut" }

# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ACLK -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARESETN -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWADDR -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWPROT -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWVALID -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_AWREADY -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WDATA -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WSTRB -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WVALID -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_WREADY -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_BRESP -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_BVALID -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_BREADY -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARADDR -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARPROT -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARVALID -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_ARREADY -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RDATA -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RRESP -into $id
# wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RVALID -into $id
  wave add $tbpath${ps}bfm_processor${ps}M_AXI_LITE_RREADY -into $id

