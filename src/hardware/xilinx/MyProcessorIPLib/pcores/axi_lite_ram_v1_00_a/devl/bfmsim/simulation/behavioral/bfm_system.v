//-----------------------------------------------------------------------------
// bfm_system.v
//-----------------------------------------------------------------------------

`timescale 1 ps / 100 fs

`uselib lib=unisims_ver

module bfm_system
  (
    sys_reset,
    sys_clk
  );
  input sys_reset;
  input sys_clk;

  // Internal signals

  wire [31:0] axi4lite_bus_M_ARADDR;
  wire [1:0] axi4lite_bus_M_ARBURST;
  wire [3:0] axi4lite_bus_M_ARCACHE;
  wire [0:0] axi4lite_bus_M_ARESETN;
  wire [0:0] axi4lite_bus_M_ARID;
  wire [7:0] axi4lite_bus_M_ARLEN;
  wire [1:0] axi4lite_bus_M_ARLOCK;
  wire [2:0] axi4lite_bus_M_ARPROT;
  wire [3:0] axi4lite_bus_M_ARQOS;
  wire [0:0] axi4lite_bus_M_ARREADY;
  wire [3:0] axi4lite_bus_M_ARREGION;
  wire [2:0] axi4lite_bus_M_ARSIZE;
  wire [0:0] axi4lite_bus_M_ARVALID;
  wire [31:0] axi4lite_bus_M_AWADDR;
  wire [1:0] axi4lite_bus_M_AWBURST;
  wire [3:0] axi4lite_bus_M_AWCACHE;
  wire [0:0] axi4lite_bus_M_AWID;
  wire [7:0] axi4lite_bus_M_AWLEN;
  wire [1:0] axi4lite_bus_M_AWLOCK;
  wire [2:0] axi4lite_bus_M_AWPROT;
  wire [3:0] axi4lite_bus_M_AWQOS;
  wire [0:0] axi4lite_bus_M_AWREADY;
  wire [3:0] axi4lite_bus_M_AWREGION;
  wire [2:0] axi4lite_bus_M_AWSIZE;
  wire [0:0] axi4lite_bus_M_AWVALID;
  wire [0:0] axi4lite_bus_M_BID;
  wire [0:0] axi4lite_bus_M_BREADY;
  wire [1:0] axi4lite_bus_M_BRESP;
  wire [0:0] axi4lite_bus_M_BVALID;
  wire [31:0] axi4lite_bus_M_RDATA;
  wire [0:0] axi4lite_bus_M_RID;
  wire [0:0] axi4lite_bus_M_RLAST;
  wire [0:0] axi4lite_bus_M_RREADY;
  wire [1:0] axi4lite_bus_M_RRESP;
  wire [0:0] axi4lite_bus_M_RVALID;
  wire [31:0] axi4lite_bus_M_WDATA;
  wire [0:0] axi4lite_bus_M_WLAST;
  wire [0:0] axi4lite_bus_M_WREADY;
  wire [3:0] axi4lite_bus_M_WSTRB;
  wire [0:0] axi4lite_bus_M_WVALID;
  wire [63:0] axi4lite_bus_S_ARADDR;
  wire [1:0] axi4lite_bus_S_ARESETN;
  wire [5:0] axi4lite_bus_S_ARPROT;
  wire [1:0] axi4lite_bus_S_ARREADY;
  wire [1:0] axi4lite_bus_S_ARVALID;
  wire [63:0] axi4lite_bus_S_AWADDR;
  wire [5:0] axi4lite_bus_S_AWPROT;
  wire [1:0] axi4lite_bus_S_AWREADY;
  wire [1:0] axi4lite_bus_S_AWVALID;
  wire [1:0] axi4lite_bus_S_BREADY;
  wire [3:0] axi4lite_bus_S_BRESP;
  wire [1:0] axi4lite_bus_S_BVALID;
  wire [63:0] axi4lite_bus_S_RDATA;
  wire [1:0] axi4lite_bus_S_RREADY;
  wire [3:0] axi4lite_bus_S_RRESP;
  wire [1:0] axi4lite_bus_S_RVALID;
  wire [63:0] axi4lite_bus_S_WDATA;
  wire [1:0] axi4lite_bus_S_WREADY;
  wire [7:0] axi4lite_bus_S_WSTRB;
  wire [1:0] axi4lite_bus_S_WVALID;
  wire net_gnd0;
  wire [0:0] net_gnd1;
  wire [1:0] net_gnd2;
  wire [3:0] net_gnd4;
  wire [5:0] net_gnd6;
  wire [7:0] net_gnd8;
  wire [15:0] net_gnd16;
  wire [31:0] net_gnd32;
  wire [0:0] pgassign1;
  wire [1:0] pgassign2;

  // Internal assignments

  assign pgassign1[0] = sys_clk;
  assign pgassign2[1] = sys_clk;
  assign pgassign2[0] = sys_clk;
  assign net_gnd0 = 1'b0;
  assign net_gnd1[0:0] = 1'b0;
  assign net_gnd16[15:0] = 16'b0000000000000000;
  assign net_gnd2[1:0] = 2'b00;
  assign net_gnd32[31:0] = 32'b00000000000000000000000000000000;
  assign net_gnd4[3:0] = 4'b0000;
  assign net_gnd6[5:0] = 6'b000000;
  assign net_gnd8[7:0] = 8'b00000000;

  bfm_system_bfm_processor_wrapper
    bfm_processor (
      .M_AXI_LITE_ACLK ( sys_clk ),
      .M_AXI_LITE_ARESETN ( axi4lite_bus_S_ARESETN[0] ),
      .M_AXI_LITE_AWADDR ( axi4lite_bus_S_AWADDR[31:0] ),
      .M_AXI_LITE_AWPROT ( axi4lite_bus_S_AWPROT[2:0] ),
      .M_AXI_LITE_AWVALID ( axi4lite_bus_S_AWVALID[0] ),
      .M_AXI_LITE_AWREADY ( axi4lite_bus_S_AWREADY[0] ),
      .M_AXI_LITE_WDATA ( axi4lite_bus_S_WDATA[31:0] ),
      .M_AXI_LITE_WSTRB ( axi4lite_bus_S_WSTRB[3:0] ),
      .M_AXI_LITE_WVALID ( axi4lite_bus_S_WVALID[0] ),
      .M_AXI_LITE_WREADY ( axi4lite_bus_S_WREADY[0] ),
      .M_AXI_LITE_BRESP ( axi4lite_bus_S_BRESP[1:0] ),
      .M_AXI_LITE_BVALID ( axi4lite_bus_S_BVALID[0] ),
      .M_AXI_LITE_BREADY ( axi4lite_bus_S_BREADY[0] ),
      .M_AXI_LITE_ARADDR ( axi4lite_bus_S_ARADDR[31:0] ),
      .M_AXI_LITE_ARPROT ( axi4lite_bus_S_ARPROT[2:0] ),
      .M_AXI_LITE_ARVALID ( axi4lite_bus_S_ARVALID[0] ),
      .M_AXI_LITE_ARREADY ( axi4lite_bus_S_ARREADY[0] ),
      .M_AXI_LITE_RDATA ( axi4lite_bus_S_RDATA[31:0] ),
      .M_AXI_LITE_RRESP ( axi4lite_bus_S_RRESP[1:0] ),
      .M_AXI_LITE_RVALID ( axi4lite_bus_S_RVALID[0] ),
      .M_AXI_LITE_RREADY ( axi4lite_bus_S_RREADY[0] )
    );

  bfm_system_bfm_memory_wrapper
    bfm_memory (
      .S_AXI_ACLK ( sys_clk ),
      .S_AXI_ARESETN ( axi4lite_bus_M_ARESETN[0] ),
      .S_AXI_AWID ( axi4lite_bus_M_AWID[0:0] ),
      .S_AXI_AWADDR ( axi4lite_bus_M_AWADDR ),
      .S_AXI_AWLEN ( axi4lite_bus_M_AWLEN ),
      .S_AXI_AWSIZE ( axi4lite_bus_M_AWSIZE ),
      .S_AXI_AWBURST ( axi4lite_bus_M_AWBURST ),
      .S_AXI_AWLOCK ( axi4lite_bus_M_AWLOCK[0] ),
      .S_AXI_AWCACHE ( axi4lite_bus_M_AWCACHE ),
      .S_AXI_AWPROT ( axi4lite_bus_M_AWPROT ),
      .S_AXI_AWQOS ( axi4lite_bus_M_AWQOS ),
      .S_AXI_AWREGION ( axi4lite_bus_M_AWREGION ),
      .S_AXI_AWUSER ( net_gnd1[0:0] ),
      .S_AXI_AWVALID ( axi4lite_bus_M_AWVALID[0] ),
      .S_AXI_AWREADY ( axi4lite_bus_M_AWREADY[0] ),
      .S_AXI_WDATA ( axi4lite_bus_M_WDATA ),
      .S_AXI_WSTRB ( axi4lite_bus_M_WSTRB ),
      .S_AXI_WLAST ( axi4lite_bus_M_WLAST[0] ),
      .S_AXI_WUSER ( net_gnd1[0:0] ),
      .S_AXI_WVALID ( axi4lite_bus_M_WVALID[0] ),
      .S_AXI_WREADY ( axi4lite_bus_M_WREADY[0] ),
      .S_AXI_BID ( axi4lite_bus_M_BID[0:0] ),
      .S_AXI_BRESP ( axi4lite_bus_M_BRESP ),
      .S_AXI_BUSER (  ),
      .S_AXI_BVALID ( axi4lite_bus_M_BVALID[0] ),
      .S_AXI_BREADY ( axi4lite_bus_M_BREADY[0] ),
      .S_AXI_ARID ( axi4lite_bus_M_ARID[0:0] ),
      .S_AXI_ARADDR ( axi4lite_bus_M_ARADDR ),
      .S_AXI_ARLEN ( axi4lite_bus_M_ARLEN ),
      .S_AXI_ARSIZE ( axi4lite_bus_M_ARSIZE ),
      .S_AXI_ARBURST ( axi4lite_bus_M_ARBURST ),
      .S_AXI_ARLOCK ( axi4lite_bus_M_ARLOCK[0] ),
      .S_AXI_ARCACHE ( axi4lite_bus_M_ARCACHE ),
      .S_AXI_ARPROT ( axi4lite_bus_M_ARPROT ),
      .S_AXI_ARQOS ( axi4lite_bus_M_ARQOS ),
      .S_AXI_ARREGION ( axi4lite_bus_M_ARREGION ),
      .S_AXI_ARUSER ( net_gnd1[0:0] ),
      .S_AXI_ARVALID ( axi4lite_bus_M_ARVALID[0] ),
      .S_AXI_ARREADY ( axi4lite_bus_M_ARREADY[0] ),
      .S_AXI_RID ( axi4lite_bus_M_RID[0:0] ),
      .S_AXI_RDATA ( axi4lite_bus_M_RDATA ),
      .S_AXI_RRESP ( axi4lite_bus_M_RRESP ),
      .S_AXI_RLAST ( axi4lite_bus_M_RLAST[0] ),
      .S_AXI_RUSER (  ),
      .S_AXI_RVALID ( axi4lite_bus_M_RVALID[0] ),
      .S_AXI_RREADY ( axi4lite_bus_M_RREADY[0] )
    );

  bfm_system_axi4lite_bus_wrapper
    axi4lite_bus (
      .INTERCONNECT_ACLK ( sys_clk ),
      .INTERCONNECT_ARESETN ( sys_reset ),
      .S_AXI_ARESET_OUT_N ( axi4lite_bus_S_ARESETN ),
      .M_AXI_ARESET_OUT_N ( axi4lite_bus_M_ARESETN[0:0] ),
      .IRQ (  ),
      .S_AXI_ACLK ( pgassign2 ),
      .S_AXI_AWID ( net_gnd2 ),
      .S_AXI_AWADDR ( axi4lite_bus_S_AWADDR ),
      .S_AXI_AWLEN ( net_gnd16 ),
      .S_AXI_AWSIZE ( net_gnd6 ),
      .S_AXI_AWBURST ( net_gnd4 ),
      .S_AXI_AWLOCK ( net_gnd4 ),
      .S_AXI_AWCACHE ( net_gnd8 ),
      .S_AXI_AWPROT ( axi4lite_bus_S_AWPROT ),
      .S_AXI_AWQOS ( net_gnd8 ),
      .S_AXI_AWUSER ( net_gnd2 ),
      .S_AXI_AWVALID ( axi4lite_bus_S_AWVALID ),
      .S_AXI_AWREADY ( axi4lite_bus_S_AWREADY ),
      .S_AXI_WID ( net_gnd2 ),
      .S_AXI_WDATA ( axi4lite_bus_S_WDATA ),
      .S_AXI_WSTRB ( axi4lite_bus_S_WSTRB ),
      .S_AXI_WLAST ( net_gnd2 ),
      .S_AXI_WUSER ( net_gnd2 ),
      .S_AXI_WVALID ( axi4lite_bus_S_WVALID ),
      .S_AXI_WREADY ( axi4lite_bus_S_WREADY ),
      .S_AXI_BID (  ),
      .S_AXI_BRESP ( axi4lite_bus_S_BRESP ),
      .S_AXI_BUSER (  ),
      .S_AXI_BVALID ( axi4lite_bus_S_BVALID ),
      .S_AXI_BREADY ( axi4lite_bus_S_BREADY ),
      .S_AXI_ARID ( net_gnd2 ),
      .S_AXI_ARADDR ( axi4lite_bus_S_ARADDR ),
      .S_AXI_ARLEN ( net_gnd16 ),
      .S_AXI_ARSIZE ( net_gnd6 ),
      .S_AXI_ARBURST ( net_gnd4 ),
      .S_AXI_ARLOCK ( net_gnd4 ),
      .S_AXI_ARCACHE ( net_gnd8 ),
      .S_AXI_ARPROT ( axi4lite_bus_S_ARPROT ),
      .S_AXI_ARQOS ( net_gnd8 ),
      .S_AXI_ARUSER ( net_gnd2 ),
      .S_AXI_ARVALID ( axi4lite_bus_S_ARVALID ),
      .S_AXI_ARREADY ( axi4lite_bus_S_ARREADY ),
      .S_AXI_RID (  ),
      .S_AXI_RDATA ( axi4lite_bus_S_RDATA ),
      .S_AXI_RRESP ( axi4lite_bus_S_RRESP ),
      .S_AXI_RLAST (  ),
      .S_AXI_RUSER (  ),
      .S_AXI_RVALID ( axi4lite_bus_S_RVALID ),
      .S_AXI_RREADY ( axi4lite_bus_S_RREADY ),
      .M_AXI_ACLK ( pgassign1[0:0] ),
      .M_AXI_AWID ( axi4lite_bus_M_AWID[0:0] ),
      .M_AXI_AWADDR ( axi4lite_bus_M_AWADDR ),
      .M_AXI_AWLEN ( axi4lite_bus_M_AWLEN ),
      .M_AXI_AWSIZE ( axi4lite_bus_M_AWSIZE ),
      .M_AXI_AWBURST ( axi4lite_bus_M_AWBURST ),
      .M_AXI_AWLOCK ( axi4lite_bus_M_AWLOCK ),
      .M_AXI_AWCACHE ( axi4lite_bus_M_AWCACHE ),
      .M_AXI_AWPROT ( axi4lite_bus_M_AWPROT ),
      .M_AXI_AWREGION ( axi4lite_bus_M_AWREGION ),
      .M_AXI_AWQOS ( axi4lite_bus_M_AWQOS ),
      .M_AXI_AWUSER (  ),
      .M_AXI_AWVALID ( axi4lite_bus_M_AWVALID[0:0] ),
      .M_AXI_AWREADY ( axi4lite_bus_M_AWREADY[0:0] ),
      .M_AXI_WID (  ),
      .M_AXI_WDATA ( axi4lite_bus_M_WDATA ),
      .M_AXI_WSTRB ( axi4lite_bus_M_WSTRB ),
      .M_AXI_WLAST ( axi4lite_bus_M_WLAST[0:0] ),
      .M_AXI_WUSER (  ),
      .M_AXI_WVALID ( axi4lite_bus_M_WVALID[0:0] ),
      .M_AXI_WREADY ( axi4lite_bus_M_WREADY[0:0] ),
      .M_AXI_BID ( axi4lite_bus_M_BID[0:0] ),
      .M_AXI_BRESP ( axi4lite_bus_M_BRESP ),
      .M_AXI_BUSER ( net_gnd1[0:0] ),
      .M_AXI_BVALID ( axi4lite_bus_M_BVALID[0:0] ),
      .M_AXI_BREADY ( axi4lite_bus_M_BREADY[0:0] ),
      .M_AXI_ARID ( axi4lite_bus_M_ARID[0:0] ),
      .M_AXI_ARADDR ( axi4lite_bus_M_ARADDR ),
      .M_AXI_ARLEN ( axi4lite_bus_M_ARLEN ),
      .M_AXI_ARSIZE ( axi4lite_bus_M_ARSIZE ),
      .M_AXI_ARBURST ( axi4lite_bus_M_ARBURST ),
      .M_AXI_ARLOCK ( axi4lite_bus_M_ARLOCK ),
      .M_AXI_ARCACHE ( axi4lite_bus_M_ARCACHE ),
      .M_AXI_ARPROT ( axi4lite_bus_M_ARPROT ),
      .M_AXI_ARREGION ( axi4lite_bus_M_ARREGION ),
      .M_AXI_ARQOS ( axi4lite_bus_M_ARQOS ),
      .M_AXI_ARUSER (  ),
      .M_AXI_ARVALID ( axi4lite_bus_M_ARVALID[0:0] ),
      .M_AXI_ARREADY ( axi4lite_bus_M_ARREADY[0:0] ),
      .M_AXI_RID ( axi4lite_bus_M_RID[0:0] ),
      .M_AXI_RDATA ( axi4lite_bus_M_RDATA ),
      .M_AXI_RRESP ( axi4lite_bus_M_RRESP ),
      .M_AXI_RLAST ( axi4lite_bus_M_RLAST[0:0] ),
      .M_AXI_RUSER ( net_gnd1[0:0] ),
      .M_AXI_RVALID ( axi4lite_bus_M_RVALID[0:0] ),
      .M_AXI_RREADY ( axi4lite_bus_M_RREADY[0:0] ),
      .S_AXI_CTRL_AWADDR ( net_gnd32 ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32 ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32 ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 ),
      .INTERCONNECT_ARESET_OUT_N (  ),
      .DEBUG_AW_TRANS_SEQ (  ),
      .DEBUG_AW_ARB_GRANT (  ),
      .DEBUG_AR_TRANS_SEQ (  ),
      .DEBUG_AR_ARB_GRANT (  ),
      .DEBUG_AW_TRANS_QUAL (  ),
      .DEBUG_AW_ACCEPT_CNT (  ),
      .DEBUG_AW_ACTIVE_THREAD (  ),
      .DEBUG_AW_ACTIVE_TARGET (  ),
      .DEBUG_AW_ACTIVE_REGION (  ),
      .DEBUG_AW_ERROR (  ),
      .DEBUG_AW_TARGET (  ),
      .DEBUG_AR_TRANS_QUAL (  ),
      .DEBUG_AR_ACCEPT_CNT (  ),
      .DEBUG_AR_ACTIVE_THREAD (  ),
      .DEBUG_AR_ACTIVE_TARGET (  ),
      .DEBUG_AR_ACTIVE_REGION (  ),
      .DEBUG_AR_ERROR (  ),
      .DEBUG_AR_TARGET (  ),
      .DEBUG_B_TRANS_SEQ (  ),
      .DEBUG_R_BEAT_CNT (  ),
      .DEBUG_R_TRANS_SEQ (  ),
      .DEBUG_AW_ISSUING_CNT (  ),
      .DEBUG_AR_ISSUING_CNT (  ),
      .DEBUG_W_BEAT_CNT (  ),
      .DEBUG_W_TRANS_SEQ (  ),
      .DEBUG_BID_TARGET (  ),
      .DEBUG_BID_ERROR (  ),
      .DEBUG_RID_TARGET (  ),
      .DEBUG_RID_ERROR (  ),
      .DEBUG_SR_SC_ARADDR (  ),
      .DEBUG_SR_SC_ARADDRCONTROL (  ),
      .DEBUG_SR_SC_AWADDR (  ),
      .DEBUG_SR_SC_AWADDRCONTROL (  ),
      .DEBUG_SR_SC_BRESP (  ),
      .DEBUG_SR_SC_RDATA (  ),
      .DEBUG_SR_SC_RDATACONTROL (  ),
      .DEBUG_SR_SC_WDATA (  ),
      .DEBUG_SR_SC_WDATACONTROL (  ),
      .DEBUG_SC_SF_ARADDR (  ),
      .DEBUG_SC_SF_ARADDRCONTROL (  ),
      .DEBUG_SC_SF_AWADDR (  ),
      .DEBUG_SC_SF_AWADDRCONTROL (  ),
      .DEBUG_SC_SF_BRESP (  ),
      .DEBUG_SC_SF_RDATA (  ),
      .DEBUG_SC_SF_RDATACONTROL (  ),
      .DEBUG_SC_SF_WDATA (  ),
      .DEBUG_SC_SF_WDATACONTROL (  ),
      .DEBUG_SF_CB_ARADDR (  ),
      .DEBUG_SF_CB_ARADDRCONTROL (  ),
      .DEBUG_SF_CB_AWADDR (  ),
      .DEBUG_SF_CB_AWADDRCONTROL (  ),
      .DEBUG_SF_CB_BRESP (  ),
      .DEBUG_SF_CB_RDATA (  ),
      .DEBUG_SF_CB_RDATACONTROL (  ),
      .DEBUG_SF_CB_WDATA (  ),
      .DEBUG_SF_CB_WDATACONTROL (  ),
      .DEBUG_CB_MF_ARADDR (  ),
      .DEBUG_CB_MF_ARADDRCONTROL (  ),
      .DEBUG_CB_MF_AWADDR (  ),
      .DEBUG_CB_MF_AWADDRCONTROL (  ),
      .DEBUG_CB_MF_BRESP (  ),
      .DEBUG_CB_MF_RDATA (  ),
      .DEBUG_CB_MF_RDATACONTROL (  ),
      .DEBUG_CB_MF_WDATA (  ),
      .DEBUG_CB_MF_WDATACONTROL (  ),
      .DEBUG_MF_MC_ARADDR (  ),
      .DEBUG_MF_MC_ARADDRCONTROL (  ),
      .DEBUG_MF_MC_AWADDR (  ),
      .DEBUG_MF_MC_AWADDRCONTROL (  ),
      .DEBUG_MF_MC_BRESP (  ),
      .DEBUG_MF_MC_RDATA (  ),
      .DEBUG_MF_MC_RDATACONTROL (  ),
      .DEBUG_MF_MC_WDATA (  ),
      .DEBUG_MF_MC_WDATACONTROL (  ),
      .DEBUG_MC_MP_ARADDR (  ),
      .DEBUG_MC_MP_ARADDRCONTROL (  ),
      .DEBUG_MC_MP_AWADDR (  ),
      .DEBUG_MC_MP_AWADDRCONTROL (  ),
      .DEBUG_MC_MP_BRESP (  ),
      .DEBUG_MC_MP_RDATA (  ),
      .DEBUG_MC_MP_RDATACONTROL (  ),
      .DEBUG_MC_MP_WDATA (  ),
      .DEBUG_MC_MP_WDATACONTROL (  ),
      .DEBUG_MP_MR_ARADDR (  ),
      .DEBUG_MP_MR_ARADDRCONTROL (  ),
      .DEBUG_MP_MR_AWADDR (  ),
      .DEBUG_MP_MR_AWADDRCONTROL (  ),
      .DEBUG_MP_MR_BRESP (  ),
      .DEBUG_MP_MR_RDATA (  ),
      .DEBUG_MP_MR_RDATACONTROL (  ),
      .DEBUG_MP_MR_WDATA (  ),
      .DEBUG_MP_MR_WDATACONTROL (  )
    );

  bfm_system_axi_lite_ram_inst_wrapper
    axi_lite_ram_inst (
      .slave_addr_offset ( net_gnd32 ),
      .m_axi_lite_aclk ( sys_clk ),
      .m_axi_lite_aresetn ( axi4lite_bus_S_ARESETN[1] ),
      .md_error (  ),
      .m_axi_lite_arready ( axi4lite_bus_S_ARREADY[1] ),
      .m_axi_lite_arvalid ( axi4lite_bus_S_ARVALID[1] ),
      .m_axi_lite_araddr ( axi4lite_bus_S_ARADDR[63:32] ),
      .m_axi_lite_arprot ( axi4lite_bus_S_ARPROT[5:3] ),
      .m_axi_lite_rready ( axi4lite_bus_S_RREADY[1] ),
      .m_axi_lite_rvalid ( axi4lite_bus_S_RVALID[1] ),
      .m_axi_lite_rdata ( axi4lite_bus_S_RDATA[63:32] ),
      .m_axi_lite_rresp ( axi4lite_bus_S_RRESP[3:2] ),
      .m_axi_lite_awready ( axi4lite_bus_S_AWREADY[1] ),
      .m_axi_lite_awvalid ( axi4lite_bus_S_AWVALID[1] ),
      .m_axi_lite_awaddr ( axi4lite_bus_S_AWADDR[63:32] ),
      .m_axi_lite_awprot ( axi4lite_bus_S_AWPROT[5:3] ),
      .m_axi_lite_wready ( axi4lite_bus_S_WREADY[1] ),
      .m_axi_lite_wvalid ( axi4lite_bus_S_WVALID[1] ),
      .m_axi_lite_wdata ( axi4lite_bus_S_WDATA[63:32] ),
      .m_axi_lite_wstrb ( axi4lite_bus_S_WSTRB[7:4] ),
      .m_axi_lite_bready ( axi4lite_bus_S_BREADY[1] ),
      .m_axi_lite_bvalid ( axi4lite_bus_S_BVALID[1] ),
      .m_axi_lite_bresp ( axi4lite_bus_S_BRESP[3:2] )
    );

endmodule

