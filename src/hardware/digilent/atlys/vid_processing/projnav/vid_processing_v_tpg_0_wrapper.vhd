-------------------------------------------------------------------------------
-- vid_processing_v_tpg_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library v_tpg_v4_00_a;
use v_tpg_v4_00_a.all;

entity vid_processing_v_tpg_0_wrapper is
  port (
    intc_if : out std_logic_vector(8 downto 0);
    aclk : in std_logic;
    aclken : in std_logic;
    aresetn : in std_logic;
    irq : out std_logic;
    s_axis_video_tdata : in std_logic_vector(23 downto 0);
    s_axis_video_tready : out std_logic;
    s_axis_video_tvalid : in std_logic;
    s_axis_video_tlast : in std_logic;
    s_axis_video_tuser : in std_logic;
    m_axis_video_tdata : out std_logic_vector(23 downto 0);
    m_axis_video_tready : in std_logic;
    m_axis_video_tvalid : out std_logic;
    m_axis_video_tlast : out std_logic;
    m_axis_video_tuser : out std_logic;
    s_axi_aclk : in std_logic;
    s_axi_aclken : in std_logic;
    s_axi_aresetn : in std_logic;
    s_axi_awaddr : in std_logic_vector(8 downto 0);
    s_axi_awvalid : in std_logic;
    s_axi_awready : out std_logic;
    s_axi_wdata : in std_logic_vector(31 downto 0);
    s_axi_wstrb : in std_logic_vector(3 downto 0);
    s_axi_wvalid : in std_logic;
    s_axi_wready : out std_logic;
    s_axi_bresp : out std_logic_vector(1 downto 0);
    s_axi_bvalid : out std_logic;
    s_axi_bready : in std_logic;
    s_axi_araddr : in std_logic_vector(8 downto 0);
    s_axi_arvalid : in std_logic;
    s_axi_arready : out std_logic;
    s_axi_rdata : out std_logic_vector(31 downto 0);
    s_axi_rresp : out std_logic_vector(1 downto 0);
    s_axi_rvalid : out std_logic;
    s_axi_rready : in std_logic
  );
end vid_processing_v_tpg_0_wrapper;

architecture STRUCTURE of vid_processing_v_tpg_0_wrapper is

  component v_tpg is
    generic (
      C_S_AXIS_VIDEO_TUSER_WIDTH : INTEGER;
      C_S_AXIS_VIDEO_DATA_WIDTH : INTEGER;
      C_S_AXIS_VIDEO_FORMAT : INTEGER;
      C_S_AXIS_VIDEO_TDATA_WIDTH : INTEGER;
      C_M_AXIS_VIDEO_DATA_WIDTH : INTEGER;
      C_M_AXIS_VIDEO_TDATA_WIDTH : INTEGER;
      C_M_AXIS_VIDEO_FORMAT : INTEGER;
      C_HAS_INTC_IF : INTEGER;
      C_HAS_AXI4_LITE : INTEGER;
      C_ACTIVE_ROWS : INTEGER;
      C_ACTIVE_COLS : INTEGER;
      C_MAX_COLS : INTEGER;
      C_PATTERN_CONTROL : INTEGER;
      C_MOTION_SPEED : INTEGER;
      C_CROSS_HAIRS : INTEGER;
      C_ZPLATE_HOR_CONTROL : INTEGER;
      C_ZPLATE_VER_CONTROL : INTEGER;
      C_BOX_SIZE : INTEGER;
      C_BOX_COLOR : INTEGER;
      C_STUCK_PIXEL_THRESH : INTEGER;
      C_NOISE_GAIN : INTEGER;
      C_S_AXI_ADDR_WIDTH : INTEGER;
      C_S_AXI_DATA_WIDTH : INTEGER;
      C_S_AXI_CLK_FREQ_HZ : INTEGER;
      C_FAMILY : STRING
    );
    port (
      intc_if : out std_logic_vector(8 downto 0);
      aclk : in std_logic;
      aclken : in std_logic;
      aresetn : in std_logic;
      irq : out std_logic;
      s_axis_video_tdata : in std_logic_vector((C_S_AXIS_VIDEO_TDATA_WIDTH-1) downto 0);
      s_axis_video_tready : out std_logic;
      s_axis_video_tvalid : in std_logic;
      s_axis_video_tlast : in std_logic;
      s_axis_video_tuser : in std_logic;
      m_axis_video_tdata : out std_logic_vector((C_M_AXIS_VIDEO_TDATA_WIDTH-1) downto 0);
      m_axis_video_tready : in std_logic;
      m_axis_video_tvalid : out std_logic;
      m_axis_video_tlast : out std_logic;
      m_axis_video_tuser : out std_logic;
      s_axi_aclk : in std_logic;
      s_axi_aclken : in std_logic;
      s_axi_aresetn : in std_logic;
      s_axi_awaddr : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      s_axi_awvalid : in std_logic;
      s_axi_awready : out std_logic;
      s_axi_wdata : in std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      s_axi_wstrb : in std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
      s_axi_wvalid : in std_logic;
      s_axi_wready : out std_logic;
      s_axi_bresp : out std_logic_vector(1 downto 0);
      s_axi_bvalid : out std_logic;
      s_axi_bready : in std_logic;
      s_axi_araddr : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      s_axi_arvalid : in std_logic;
      s_axi_arready : out std_logic;
      s_axi_rdata : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      s_axi_rresp : out std_logic_vector(1 downto 0);
      s_axi_rvalid : out std_logic;
      s_axi_rready : in std_logic
    );
  end component;

begin

  v_tpg_0 : v_tpg
    generic map (
      C_S_AXIS_VIDEO_TUSER_WIDTH => 0,
      C_S_AXIS_VIDEO_DATA_WIDTH => 8,
      C_S_AXIS_VIDEO_FORMAT => 2,
      C_S_AXIS_VIDEO_TDATA_WIDTH => 24,
      C_M_AXIS_VIDEO_DATA_WIDTH => 8,
      C_M_AXIS_VIDEO_TDATA_WIDTH => 24,
      C_M_AXIS_VIDEO_FORMAT => 0,
      C_HAS_INTC_IF => 0,
      C_HAS_AXI4_LITE => 1,
      C_ACTIVE_ROWS => 224,
      C_ACTIVE_COLS => 288,
      C_MAX_COLS => 384,
      C_PATTERN_CONTROL => 1,
      C_MOTION_SPEED => 4,
      C_CROSS_HAIRS => 6553700,
      C_ZPLATE_HOR_CONTROL => 30,
      C_ZPLATE_VER_CONTROL => 1,
      C_BOX_SIZE => 50,
      C_BOX_COLOR => 0,
      C_STUCK_PIXEL_THRESH => 0,
      C_NOISE_GAIN => 0,
      C_S_AXI_ADDR_WIDTH => 9,
      C_S_AXI_DATA_WIDTH => 32,
      C_S_AXI_CLK_FREQ_HZ => 100000000,
      C_FAMILY => "spartan6"
    )
    port map (
      intc_if => intc_if,
      aclk => aclk,
      aclken => aclken,
      aresetn => aresetn,
      irq => irq,
      s_axis_video_tdata => s_axis_video_tdata,
      s_axis_video_tready => s_axis_video_tready,
      s_axis_video_tvalid => s_axis_video_tvalid,
      s_axis_video_tlast => s_axis_video_tlast,
      s_axis_video_tuser => s_axis_video_tuser,
      m_axis_video_tdata => m_axis_video_tdata,
      m_axis_video_tready => m_axis_video_tready,
      m_axis_video_tvalid => m_axis_video_tvalid,
      m_axis_video_tlast => m_axis_video_tlast,
      m_axis_video_tuser => m_axis_video_tuser,
      s_axi_aclk => s_axi_aclk,
      s_axi_aclken => s_axi_aclken,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awaddr => s_axi_awaddr,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_awready => s_axi_awready,
      s_axi_wdata => s_axi_wdata,
      s_axi_wstrb => s_axi_wstrb,
      s_axi_wvalid => s_axi_wvalid,
      s_axi_wready => s_axi_wready,
      s_axi_bresp => s_axi_bresp,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_bready => s_axi_bready,
      s_axi_araddr => s_axi_araddr,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_arready => s_axi_arready,
      s_axi_rdata => s_axi_rdata,
      s_axi_rresp => s_axi_rresp,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_rready => s_axi_rready
    );

end architecture STRUCTURE;

