//-----------------------------------------------------------------------------
// bfm_system_bfm_processor_wrapper.v
//-----------------------------------------------------------------------------

`timescale 1 ps / 100 fs

`uselib lib=unisims_ver lib=cdn_axi4_lite_master_bfm_wrap_v2_01_b

module bfm_system_bfm_processor_wrapper
  (
    M_AXI_LITE_ACLK,
    M_AXI_LITE_ARESETN,
    M_AXI_LITE_AWADDR,
    M_AXI_LITE_AWPROT,
    M_AXI_LITE_AWVALID,
    M_AXI_LITE_AWREADY,
    M_AXI_LITE_WDATA,
    M_AXI_LITE_WSTRB,
    M_AXI_LITE_WVALID,
    M_AXI_LITE_WREADY,
    M_AXI_LITE_BRESP,
    M_AXI_LITE_BVALID,
    M_AXI_LITE_BREADY,
    M_AXI_LITE_ARADDR,
    M_AXI_LITE_ARPROT,
    M_AXI_LITE_ARVALID,
    M_AXI_LITE_ARREADY,
    M_AXI_LITE_RDATA,
    M_AXI_LITE_RRESP,
    M_AXI_LITE_RVALID,
    M_AXI_LITE_RREADY
  );
  input M_AXI_LITE_ACLK;
  input M_AXI_LITE_ARESETN;
  output [31:0] M_AXI_LITE_AWADDR;
  output [2:0] M_AXI_LITE_AWPROT;
  output M_AXI_LITE_AWVALID;
  input M_AXI_LITE_AWREADY;
  output [31:0] M_AXI_LITE_WDATA;
  output [3:0] M_AXI_LITE_WSTRB;
  output M_AXI_LITE_WVALID;
  input M_AXI_LITE_WREADY;
  input [1:0] M_AXI_LITE_BRESP;
  input M_AXI_LITE_BVALID;
  output M_AXI_LITE_BREADY;
  output [31:0] M_AXI_LITE_ARADDR;
  output [2:0] M_AXI_LITE_ARPROT;
  output M_AXI_LITE_ARVALID;
  input M_AXI_LITE_ARREADY;
  input [31:0] M_AXI_LITE_RDATA;
  input [1:0] M_AXI_LITE_RRESP;
  input M_AXI_LITE_RVALID;
  output M_AXI_LITE_RREADY;

  cdn_axi4_lite_master_bfm_wrap
    #(
      .C_INTERCONNECT_M_AXI_LITE_WRITE_ISSUING ( 8 ),
      .C_INTERCONNECT_M_AXI_LITE_READ_ISSUING ( 8 ),
      .C_M_AXI_LITE_NAME ( "MASTER_0" ),
      .C_M_AXI_LITE_DATA_WIDTH ( 32 ),
      .C_M_AXI_LITE_ADDR_WIDTH ( 32 )
    )
    bfm_processor (
      .M_AXI_LITE_ACLK ( M_AXI_LITE_ACLK ),
      .M_AXI_LITE_ARESETN ( M_AXI_LITE_ARESETN ),
      .M_AXI_LITE_AWADDR ( M_AXI_LITE_AWADDR ),
      .M_AXI_LITE_AWPROT ( M_AXI_LITE_AWPROT ),
      .M_AXI_LITE_AWVALID ( M_AXI_LITE_AWVALID ),
      .M_AXI_LITE_AWREADY ( M_AXI_LITE_AWREADY ),
      .M_AXI_LITE_WDATA ( M_AXI_LITE_WDATA ),
      .M_AXI_LITE_WSTRB ( M_AXI_LITE_WSTRB ),
      .M_AXI_LITE_WVALID ( M_AXI_LITE_WVALID ),
      .M_AXI_LITE_WREADY ( M_AXI_LITE_WREADY ),
      .M_AXI_LITE_BRESP ( M_AXI_LITE_BRESP ),
      .M_AXI_LITE_BVALID ( M_AXI_LITE_BVALID ),
      .M_AXI_LITE_BREADY ( M_AXI_LITE_BREADY ),
      .M_AXI_LITE_ARADDR ( M_AXI_LITE_ARADDR ),
      .M_AXI_LITE_ARPROT ( M_AXI_LITE_ARPROT ),
      .M_AXI_LITE_ARVALID ( M_AXI_LITE_ARVALID ),
      .M_AXI_LITE_ARREADY ( M_AXI_LITE_ARREADY ),
      .M_AXI_LITE_RDATA ( M_AXI_LITE_RDATA ),
      .M_AXI_LITE_RRESP ( M_AXI_LITE_RRESP ),
      .M_AXI_LITE_RVALID ( M_AXI_LITE_RVALID ),
      .M_AXI_LITE_RREADY ( M_AXI_LITE_RREADY )
    );

endmodule

