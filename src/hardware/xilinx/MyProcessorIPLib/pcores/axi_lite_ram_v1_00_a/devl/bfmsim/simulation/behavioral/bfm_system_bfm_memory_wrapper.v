//-----------------------------------------------------------------------------
// bfm_system_bfm_memory_wrapper.v
//-----------------------------------------------------------------------------

`timescale 1 ps / 100 fs

`uselib lib=unisims_ver lib=cdn_axi4_slave_bfm_wrap_v2_01_b

module bfm_system_bfm_memory_wrapper
  (
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWID,
    S_AXI_AWADDR,
    S_AXI_AWLEN,
    S_AXI_AWSIZE,
    S_AXI_AWBURST,
    S_AXI_AWLOCK,
    S_AXI_AWCACHE,
    S_AXI_AWPROT,
    S_AXI_AWQOS,
    S_AXI_AWREGION,
    S_AXI_AWUSER,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WLAST,
    S_AXI_WUSER,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BID,
    S_AXI_BRESP,
    S_AXI_BUSER,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARID,
    S_AXI_ARADDR,
    S_AXI_ARLEN,
    S_AXI_ARSIZE,
    S_AXI_ARBURST,
    S_AXI_ARLOCK,
    S_AXI_ARCACHE,
    S_AXI_ARPROT,
    S_AXI_ARQOS,
    S_AXI_ARREGION,
    S_AXI_ARUSER,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RID,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RLAST,
    S_AXI_RUSER,
    S_AXI_RVALID,
    S_AXI_RREADY
  );
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [0:0] S_AXI_AWID;
  input [31:0] S_AXI_AWADDR;
  input [7:0] S_AXI_AWLEN;
  input [2:0] S_AXI_AWSIZE;
  input [1:0] S_AXI_AWBURST;
  input S_AXI_AWLOCK;
  input [3:0] S_AXI_AWCACHE;
  input [2:0] S_AXI_AWPROT;
  input [3:0] S_AXI_AWQOS;
  input [3:0] S_AXI_AWREGION;
  input [0:0] S_AXI_AWUSER;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WLAST;
  input [0:0] S_AXI_WUSER;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [0:0] S_AXI_BID;
  output [1:0] S_AXI_BRESP;
  output [0:0] S_AXI_BUSER;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [0:0] S_AXI_ARID;
  input [31:0] S_AXI_ARADDR;
  input [7:0] S_AXI_ARLEN;
  input [2:0] S_AXI_ARSIZE;
  input [1:0] S_AXI_ARBURST;
  input S_AXI_ARLOCK;
  input [3:0] S_AXI_ARCACHE;
  input [2:0] S_AXI_ARPROT;
  input [3:0] S_AXI_ARQOS;
  input [3:0] S_AXI_ARREGION;
  input [0:0] S_AXI_ARUSER;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [0:0] S_AXI_RID;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RLAST;
  output [0:0] S_AXI_RUSER;
  output S_AXI_RVALID;
  input S_AXI_RREADY;

  cdn_axi4_slave_bfm_wrap
    #(
      .C_INTERCONNECT_S_AXI_WRITE_ACCEPTANCE ( 8 ),
      .C_INTERCONNECT_S_AXI_READ_ACCEPTANCE ( 8 ),
      .C_BASEADDR ( 32'h40000000 ),
      .C_HIGHADDR ( 32'h4000ffff ),
      .C_S_AXI_NAME ( "SLAVE_0" ),
      .C_S_AXI_EXCLUSIVE_ACCESS_SUPPORTED ( 0 ),
      .C_S_AXI_MEMORY_MODEL_MODE ( 1 ),
      .C_S_AXI_ID_WIDTH ( 1 ),
      .C_S_AXI_ADDR_WIDTH ( 32 ),
      .C_S_AXI_DATA_WIDTH ( 32 ),
      .C_S_AXI_AWUSER_WIDTH ( 1 ),
      .C_S_AXI_WUSER_WIDTH ( 1 ),
      .C_S_AXI_BUSER_WIDTH ( 1 ),
      .C_S_AXI_ARUSER_WIDTH ( 1 ),
      .C_S_AXI_RUSER_WIDTH ( 1 )
    )
    bfm_memory (
      .S_AXI_ACLK ( S_AXI_ACLK ),
      .S_AXI_ARESETN ( S_AXI_ARESETN ),
      .S_AXI_AWID ( S_AXI_AWID ),
      .S_AXI_AWADDR ( S_AXI_AWADDR ),
      .S_AXI_AWLEN ( S_AXI_AWLEN ),
      .S_AXI_AWSIZE ( S_AXI_AWSIZE ),
      .S_AXI_AWBURST ( S_AXI_AWBURST ),
      .S_AXI_AWLOCK ( S_AXI_AWLOCK ),
      .S_AXI_AWCACHE ( S_AXI_AWCACHE ),
      .S_AXI_AWPROT ( S_AXI_AWPROT ),
      .S_AXI_AWQOS ( S_AXI_AWQOS ),
      .S_AXI_AWREGION ( S_AXI_AWREGION ),
      .S_AXI_AWUSER ( S_AXI_AWUSER ),
      .S_AXI_AWVALID ( S_AXI_AWVALID ),
      .S_AXI_AWREADY ( S_AXI_AWREADY ),
      .S_AXI_WDATA ( S_AXI_WDATA ),
      .S_AXI_WSTRB ( S_AXI_WSTRB ),
      .S_AXI_WLAST ( S_AXI_WLAST ),
      .S_AXI_WUSER ( S_AXI_WUSER ),
      .S_AXI_WVALID ( S_AXI_WVALID ),
      .S_AXI_WREADY ( S_AXI_WREADY ),
      .S_AXI_BID ( S_AXI_BID ),
      .S_AXI_BRESP ( S_AXI_BRESP ),
      .S_AXI_BUSER ( S_AXI_BUSER ),
      .S_AXI_BVALID ( S_AXI_BVALID ),
      .S_AXI_BREADY ( S_AXI_BREADY ),
      .S_AXI_ARID ( S_AXI_ARID ),
      .S_AXI_ARADDR ( S_AXI_ARADDR ),
      .S_AXI_ARLEN ( S_AXI_ARLEN ),
      .S_AXI_ARSIZE ( S_AXI_ARSIZE ),
      .S_AXI_ARBURST ( S_AXI_ARBURST ),
      .S_AXI_ARLOCK ( S_AXI_ARLOCK ),
      .S_AXI_ARCACHE ( S_AXI_ARCACHE ),
      .S_AXI_ARPROT ( S_AXI_ARPROT ),
      .S_AXI_ARQOS ( S_AXI_ARQOS ),
      .S_AXI_ARREGION ( S_AXI_ARREGION ),
      .S_AXI_ARUSER ( S_AXI_ARUSER ),
      .S_AXI_ARVALID ( S_AXI_ARVALID ),
      .S_AXI_ARREADY ( S_AXI_ARREADY ),
      .S_AXI_RID ( S_AXI_RID ),
      .S_AXI_RDATA ( S_AXI_RDATA ),
      .S_AXI_RRESP ( S_AXI_RRESP ),
      .S_AXI_RLAST ( S_AXI_RLAST ),
      .S_AXI_RUSER ( S_AXI_RUSER ),
      .S_AXI_RVALID ( S_AXI_RVALID ),
      .S_AXI_RREADY ( S_AXI_RREADY )
    );

endmodule

