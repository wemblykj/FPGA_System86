#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     axi4lite_bus_wave.tcl (Wed Mar 20 17:46:27 2019)
#
#  Module   bfm_system_axi4lite_bus_wrapper
#  Instance axi4lite_bus
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "bfm_system_tb${ps}dut" }

# wave add $tbpath${ps}axi4lite_bus${ps}INTERCONNECT_ACLK -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}INTERCONNECT_ARESETN -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARESET_OUT_N -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARESET_OUT_N -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}IRQ -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ACLK -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWLEN -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWSIZE -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWBURST -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWLOCK -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWCACHE -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWPROT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWQOS -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWUSER -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWVALID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_AWREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WSTRB -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WLAST -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WUSER -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WVALID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_WREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_BID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_BUSER -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_BVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_BREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARLEN -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARSIZE -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARBURST -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARLOCK -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARCACHE -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARPROT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARQOS -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARUSER -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARVALID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_ARREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RDATA -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RLAST -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RUSER -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_RREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ACLK -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWADDR -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWLEN -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWSIZE -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWBURST -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWLOCK -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWCACHE -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWPROT -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWREGION -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWQOS -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWUSER -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_AWREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WDATA -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WSTRB -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WLAST -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WUSER -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_WREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_BID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_BUSER -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_BVALID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_BREADY -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARADDR -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARLEN -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARSIZE -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARBURST -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARLOCK -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARCACHE -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARPROT -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARREGION -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARQOS -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARUSER -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_ARREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RLAST -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RUSER -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RVALID -into $id
  wave add $tbpath${ps}axi4lite_bus${ps}M_AXI_RREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_AWVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_AWREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_WVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_WREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_BVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_BREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_ARVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_ARREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RVALID -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}S_AXI_CTRL_RREADY -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}INTERCONNECT_ARESET_OUT_N -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_TRANS_SEQ -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ARB_GRANT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_TRANS_SEQ -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ARB_GRANT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_TRANS_QUAL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACCEPT_CNT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACTIVE_THREAD -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACTIVE_TARGET -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ACTIVE_REGION -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ERROR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_TARGET -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_TRANS_QUAL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACCEPT_CNT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACTIVE_THREAD -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACTIVE_TARGET -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ACTIVE_REGION -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ERROR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_TARGET -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_B_TRANS_SEQ -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_R_BEAT_CNT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_R_TRANS_SEQ -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AW_ISSUING_CNT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_AR_ISSUING_CNT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_W_BEAT_CNT -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_W_TRANS_SEQ -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_BID_TARGET -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_BID_ERROR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_RID_TARGET -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_RID_ERROR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SR_SC_WDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SC_SF_WDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_SF_CB_WDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_CB_MF_WDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MF_MC_WDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MC_MP_WDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_ARADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_ARADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_AWADDR -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_AWADDRCONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_BRESP -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_RDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_RDATACONTROL -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_WDATA -into $id
# wave add $tbpath${ps}axi4lite_bus${ps}DEBUG_MP_MR_WDATACONTROL -into $id

