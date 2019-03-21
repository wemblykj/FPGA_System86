-------------------------------------------------------------------------------
-- bfm_system_axi_lite_ram_inst_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library axi_lite_ram_v1_00_a;
use axi_lite_ram_v1_00_a.all;

entity bfm_system_axi_lite_ram_inst_wrapper is
  port (
    slave_addr_offset : in std_logic_vector(31 downto 0);
    m_axi_lite_aclk : in std_logic;
    m_axi_lite_aresetn : in std_logic;
    md_error : out std_logic;
    m_axi_lite_arready : in std_logic;
    m_axi_lite_arvalid : out std_logic;
    m_axi_lite_araddr : out std_logic_vector(31 downto 0);
    m_axi_lite_arprot : out std_logic_vector(2 downto 0);
    m_axi_lite_rready : out std_logic;
    m_axi_lite_rvalid : in std_logic;
    m_axi_lite_rdata : in std_logic_vector(31 downto 0);
    m_axi_lite_rresp : in std_logic_vector(1 downto 0);
    m_axi_lite_awready : in std_logic;
    m_axi_lite_awvalid : out std_logic;
    m_axi_lite_awaddr : out std_logic_vector(31 downto 0);
    m_axi_lite_awprot : out std_logic_vector(2 downto 0);
    m_axi_lite_wready : in std_logic;
    m_axi_lite_wvalid : out std_logic;
    m_axi_lite_wdata : out std_logic_vector(31 downto 0);
    m_axi_lite_wstrb : out std_logic_vector(3 downto 0);
    m_axi_lite_bready : out std_logic;
    m_axi_lite_bvalid : in std_logic;
    m_axi_lite_bresp : in std_logic_vector(1 downto 0)
  );
end bfm_system_axi_lite_ram_inst_wrapper;

architecture STRUCTURE of bfm_system_axi_lite_ram_inst_wrapper is

  component axi_lite_ram is
    generic (
      C_SLAVE_BASE_ADDR : std_logic_vector;
      C_FAMILY : STRING;
      C_M_AXI_LITE_ADDR_WIDTH : INTEGER;
      C_M_AXI_LITE_DATA_WIDTH : INTEGER
    );
    port (
      slave_addr_offset : in std_logic_vector((C_M_AXI_LITE_ADDR_WIDTH-1) downto 0);
      m_axi_lite_aclk : in std_logic;
      m_axi_lite_aresetn : in std_logic;
      md_error : out std_logic;
      m_axi_lite_arready : in std_logic;
      m_axi_lite_arvalid : out std_logic;
      m_axi_lite_araddr : out std_logic_vector((C_M_AXI_LITE_ADDR_WIDTH-1) downto 0);
      m_axi_lite_arprot : out std_logic_vector(2 downto 0);
      m_axi_lite_rready : out std_logic;
      m_axi_lite_rvalid : in std_logic;
      m_axi_lite_rdata : in std_logic_vector((C_M_AXI_LITE_DATA_WIDTH-1) downto 0);
      m_axi_lite_rresp : in std_logic_vector(1 downto 0);
      m_axi_lite_awready : in std_logic;
      m_axi_lite_awvalid : out std_logic;
      m_axi_lite_awaddr : out std_logic_vector((C_M_AXI_LITE_ADDR_WIDTH-1) downto 0);
      m_axi_lite_awprot : out std_logic_vector(2 downto 0);
      m_axi_lite_wready : in std_logic;
      m_axi_lite_wvalid : out std_logic;
      m_axi_lite_wdata : out std_logic_vector((C_M_AXI_LITE_DATA_WIDTH-1) downto 0);
      m_axi_lite_wstrb : out std_logic_vector(((C_M_AXI_LITE_DATA_WIDTH/8)-1) downto 0);
      m_axi_lite_bready : out std_logic;
      m_axi_lite_bvalid : in std_logic;
      m_axi_lite_bresp : in std_logic_vector(1 downto 0)
    );
  end component;

begin

  axi_lite_ram_inst : axi_lite_ram
    generic map (
      C_SLAVE_BASE_ADDR => X"40000000",
      C_FAMILY => "virtex6",
      C_M_AXI_LITE_ADDR_WIDTH => 32,
      C_M_AXI_LITE_DATA_WIDTH => 32
    )
    port map (
      slave_addr_offset => slave_addr_offset,
      m_axi_lite_aclk => m_axi_lite_aclk,
      m_axi_lite_aresetn => m_axi_lite_aresetn,
      md_error => md_error,
      m_axi_lite_arready => m_axi_lite_arready,
      m_axi_lite_arvalid => m_axi_lite_arvalid,
      m_axi_lite_araddr => m_axi_lite_araddr,
      m_axi_lite_arprot => m_axi_lite_arprot,
      m_axi_lite_rready => m_axi_lite_rready,
      m_axi_lite_rvalid => m_axi_lite_rvalid,
      m_axi_lite_rdata => m_axi_lite_rdata,
      m_axi_lite_rresp => m_axi_lite_rresp,
      m_axi_lite_awready => m_axi_lite_awready,
      m_axi_lite_awvalid => m_axi_lite_awvalid,
      m_axi_lite_awaddr => m_axi_lite_awaddr,
      m_axi_lite_awprot => m_axi_lite_awprot,
      m_axi_lite_wready => m_axi_lite_wready,
      m_axi_lite_wvalid => m_axi_lite_wvalid,
      m_axi_lite_wdata => m_axi_lite_wdata,
      m_axi_lite_wstrb => m_axi_lite_wstrb,
      m_axi_lite_bready => m_axi_lite_bready,
      m_axi_lite_bvalid => m_axi_lite_bvalid,
      m_axi_lite_bresp => m_axi_lite_bresp
    );

end architecture STRUCTURE;

