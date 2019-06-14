-------------------------------------------------------------------------------
-- vid_processing_axi_hdmi_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library axi_hdmi_v1_00_a;
use axi_hdmi_v1_00_a.all;

entity vid_processing_axi_hdmi_0_wrapper is
  port (
    ACLK : in std_logic;
    MM2S_FSYNC_IN : in std_logic;
    MM2S_BUFFER_ALMOST_EMPTY : in std_logic;
    S2MM_FSYNC_IN : in std_logic;
    S_AXIS_MM2S_ACLK : out std_logic;
    S_AXIS_MM2S_ARESETN : in std_logic;
    S_AXIS_MM2S_TREADY : out std_logic;
    S_AXIS_MM2S_TDATA : in std_logic_vector(23 downto 0);
    S_AXIS_MM2S_TKEEP : in std_logic_vector(2 downto 0);
    S_AXIS_MM2S_TLAST : in std_logic;
    S_AXIS_MM2S_TVALID : in std_logic;
    M_AXIS_S2MM_ACLK : out std_logic;
    M_AXIS_S2MM_ARESETN : in std_logic;
    M_AXIS_S2MM_TVALID : out std_logic;
    M_AXIS_S2MM_TDATA : out std_logic_vector(23 downto 0);
    M_AXIS_S2MM_TKEEP : out std_logic_vector(2 downto 0);
    M_AXIS_S2MM_TLAST : out std_logic;
    M_AXIS_S2MM_TREADY : in std_logic;
    TMDS_RX_CLK_P : in std_logic;
    TMDS_RX_CLK_N : in std_logic;
    TMDS_RX_2_P : in std_logic;
    TMDS_RX_2_N : in std_logic;
    TMDS_RX_1_P : in std_logic;
    TMDS_RX_1_N : in std_logic;
    TMDS_RX_0_P : in std_logic;
    TMDS_RX_0_N : in std_logic;
    TMDS_RX_SCL : in std_logic;
    TMDS_TX_CLK_P : out std_logic;
    TMDS_TX_CLK_N : out std_logic;
    TMDS_TX_2_P : out std_logic;
    TMDS_TX_2_N : out std_logic;
    TMDS_TX_1_P : out std_logic;
    TMDS_TX_1_N : out std_logic;
    TMDS_TX_0_P : out std_logic;
    TMDS_TX_0_N : out std_logic;
    S_AXI_ACLK : in std_logic;
    S_AXI_ARESETN : in std_logic;
    S_AXI_AWADDR : in std_logic_vector(31 downto 0);
    S_AXI_AWVALID : in std_logic;
    S_AXI_WDATA : in std_logic_vector(31 downto 0);
    S_AXI_WSTRB : in std_logic_vector(3 downto 0);
    S_AXI_WVALID : in std_logic;
    S_AXI_BREADY : in std_logic;
    S_AXI_ARADDR : in std_logic_vector(31 downto 0);
    S_AXI_ARVALID : in std_logic;
    S_AXI_RREADY : in std_logic;
    S_AXI_ARREADY : out std_logic;
    S_AXI_RDATA : out std_logic_vector(31 downto 0);
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_RVALID : out std_logic;
    S_AXI_WREADY : out std_logic;
    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_BVALID : out std_logic;
    S_AXI_AWREADY : out std_logic;
    TMDS_RX_SDA_I : in std_logic;
    TMDS_RX_SDA_O : out std_logic;
    TMDS_RX_SDA_T : out std_logic
  );
end vid_processing_axi_hdmi_0_wrapper;

architecture STRUCTURE of vid_processing_axi_hdmi_0_wrapper is

  component axi_hdmi is
    generic (
      C_USE_HDMI_RECEIVER : INTEGER;
      C_USE_HDMI_TRANSMITTER : INTEGER;
      C_USE_HDMI_REGS : INTEGER;
      C_USE_HDMI_DDC : INTEGER;
      C_BASEADDR : std_logic_vector;
      C_HIGHADDR : std_logic_vector;
      C_AXI_STREAM_DATA_WIDTH : INTEGER
    );
    port (
      ACLK : in std_logic;
      MM2S_FSYNC_IN : in std_logic;
      MM2S_BUFFER_ALMOST_EMPTY : in std_logic;
      S2MM_FSYNC_IN : in std_logic;
      S_AXIS_MM2S_ACLK : out std_logic;
      S_AXIS_MM2S_ARESETN : in std_logic;
      S_AXIS_MM2S_TREADY : out std_logic;
      S_AXIS_MM2S_TDATA : in std_logic_vector(C_AXI_STREAM_DATA_WIDTH-1 downto 0);
      S_AXIS_MM2S_TKEEP : in std_logic_vector((C_AXI_STREAM_DATA_WIDTH/8)-1 downto 0);
      S_AXIS_MM2S_TLAST : in std_logic;
      S_AXIS_MM2S_TVALID : in std_logic;
      M_AXIS_S2MM_ACLK : out std_logic;
      M_AXIS_S2MM_ARESETN : in std_logic;
      M_AXIS_S2MM_TVALID : out std_logic;
      M_AXIS_S2MM_TDATA : out std_logic_vector(C_AXI_STREAM_DATA_WIDTH-1 downto 0);
      M_AXIS_S2MM_TKEEP : out std_logic_vector((C_AXI_STREAM_DATA_WIDTH/8)-1 downto 0);
      M_AXIS_S2MM_TLAST : out std_logic;
      M_AXIS_S2MM_TREADY : in std_logic;
      TMDS_RX_CLK_P : in std_logic;
      TMDS_RX_CLK_N : in std_logic;
      TMDS_RX_2_P : in std_logic;
      TMDS_RX_2_N : in std_logic;
      TMDS_RX_1_P : in std_logic;
      TMDS_RX_1_N : in std_logic;
      TMDS_RX_0_P : in std_logic;
      TMDS_RX_0_N : in std_logic;
      TMDS_RX_SCL : in std_logic;
      TMDS_TX_CLK_P : out std_logic;
      TMDS_TX_CLK_N : out std_logic;
      TMDS_TX_2_P : out std_logic;
      TMDS_TX_2_N : out std_logic;
      TMDS_TX_1_P : out std_logic;
      TMDS_TX_1_N : out std_logic;
      TMDS_TX_0_P : out std_logic;
      TMDS_TX_0_N : out std_logic;
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_RREADY : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_AWREADY : out std_logic;
      TMDS_RX_SDA_I : in std_logic;
      TMDS_RX_SDA_O : out std_logic;
      TMDS_RX_SDA_T : out std_logic
    );
  end component;

begin

  axi_hdmi_0 : axi_hdmi
    generic map (
      C_USE_HDMI_RECEIVER => 0,
      C_USE_HDMI_TRANSMITTER => 1,
      C_USE_HDMI_REGS => 1,
      C_USE_HDMI_DDC => 1,
      C_BASEADDR => X"7e200000",
      C_HIGHADDR => X"7e20ffff",
      C_AXI_STREAM_DATA_WIDTH => 24
    )
    port map (
      ACLK => ACLK,
      MM2S_FSYNC_IN => MM2S_FSYNC_IN,
      MM2S_BUFFER_ALMOST_EMPTY => MM2S_BUFFER_ALMOST_EMPTY,
      S2MM_FSYNC_IN => S2MM_FSYNC_IN,
      S_AXIS_MM2S_ACLK => S_AXIS_MM2S_ACLK,
      S_AXIS_MM2S_ARESETN => S_AXIS_MM2S_ARESETN,
      S_AXIS_MM2S_TREADY => S_AXIS_MM2S_TREADY,
      S_AXIS_MM2S_TDATA => S_AXIS_MM2S_TDATA,
      S_AXIS_MM2S_TKEEP => S_AXIS_MM2S_TKEEP,
      S_AXIS_MM2S_TLAST => S_AXIS_MM2S_TLAST,
      S_AXIS_MM2S_TVALID => S_AXIS_MM2S_TVALID,
      M_AXIS_S2MM_ACLK => M_AXIS_S2MM_ACLK,
      M_AXIS_S2MM_ARESETN => M_AXIS_S2MM_ARESETN,
      M_AXIS_S2MM_TVALID => M_AXIS_S2MM_TVALID,
      M_AXIS_S2MM_TDATA => M_AXIS_S2MM_TDATA,
      M_AXIS_S2MM_TKEEP => M_AXIS_S2MM_TKEEP,
      M_AXIS_S2MM_TLAST => M_AXIS_S2MM_TLAST,
      M_AXIS_S2MM_TREADY => M_AXIS_S2MM_TREADY,
      TMDS_RX_CLK_P => TMDS_RX_CLK_P,
      TMDS_RX_CLK_N => TMDS_RX_CLK_N,
      TMDS_RX_2_P => TMDS_RX_2_P,
      TMDS_RX_2_N => TMDS_RX_2_N,
      TMDS_RX_1_P => TMDS_RX_1_P,
      TMDS_RX_1_N => TMDS_RX_1_N,
      TMDS_RX_0_P => TMDS_RX_0_P,
      TMDS_RX_0_N => TMDS_RX_0_N,
      TMDS_RX_SCL => TMDS_RX_SCL,
      TMDS_TX_CLK_P => TMDS_TX_CLK_P,
      TMDS_TX_CLK_N => TMDS_TX_CLK_N,
      TMDS_TX_2_P => TMDS_TX_2_P,
      TMDS_TX_2_N => TMDS_TX_2_N,
      TMDS_TX_1_P => TMDS_TX_1_P,
      TMDS_TX_1_N => TMDS_TX_1_N,
      TMDS_TX_0_P => TMDS_TX_0_P,
      TMDS_TX_0_N => TMDS_TX_0_N,
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_AWADDR => S_AXI_AWADDR,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_WDATA => S_AXI_WDATA,
      S_AXI_WSTRB => S_AXI_WSTRB,
      S_AXI_WVALID => S_AXI_WVALID,
      S_AXI_BREADY => S_AXI_BREADY,
      S_AXI_ARADDR => S_AXI_ARADDR,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_RREADY => S_AXI_RREADY,
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_RDATA => S_AXI_RDATA,
      S_AXI_RRESP => S_AXI_RRESP,
      S_AXI_RVALID => S_AXI_RVALID,
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_BRESP => S_AXI_BRESP,
      S_AXI_BVALID => S_AXI_BVALID,
      S_AXI_AWREADY => S_AXI_AWREADY,
      TMDS_RX_SDA_I => TMDS_RX_SDA_I,
      TMDS_RX_SDA_O => TMDS_RX_SDA_O,
      TMDS_RX_SDA_T => TMDS_RX_SDA_T
    );

end architecture STRUCTURE;

