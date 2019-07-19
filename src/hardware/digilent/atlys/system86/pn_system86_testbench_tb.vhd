-------------------------------------------------------------------------------
-- testbench.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

-- START USER CODE (Do not remove this line)

-- User: Put your libraries here. Code in this
--       section will not be overwritten.

-- END USER CODE (Do not remove this line)

entity testbench is
end testbench;

architecture STRUCTURE of testbench is

  constant GCLK_PERIOD : time := 10000.000000 ps;
  constant RESET_LENGTH : time := 160000 ps;

  component system86 is
    port (
      zio : inout std_logic;
      rzq : inout std_logic;
      mcbx_dram_we_n : out std_logic;
      mcbx_dram_udqs_n : inout std_logic;
      mcbx_dram_udqs : inout std_logic;
      mcbx_dram_udm : out std_logic;
      mcbx_dram_ras_n : out std_logic;
      mcbx_dram_odt : out std_logic;
      mcbx_dram_ldm : out std_logic;
      mcbx_dram_dqs_n : inout std_logic;
      mcbx_dram_dqs : inout std_logic;
      mcbx_dram_dq : inout std_logic_vector(15 downto 0);
      mcbx_dram_clk_n : out std_logic;
      mcbx_dram_clk : out std_logic;
      mcbx_dram_cke : out std_logic;
      mcbx_dram_cas_n : out std_logic;
      mcbx_dram_ba : out std_logic_vector(2 downto 0);
      mcbx_dram_addr : out std_logic_vector(12 downto 0);
      RS232_Uart_1_sout : out std_logic;
      RS232_Uart_1_sin : in std_logic;
      RESET : in std_logic;
      QSPI_FLASH_SS : inout std_logic;
      QSPI_FLASH_SCLK : inout std_logic;
      QSPI_FLASH_IO1 : inout std_logic;
      QSPI_FLASH_IO0 : inout std_logic;
      Push_Buttons_5Bits_TRI_I : in std_logic_vector(4 downto 0);
      LEDs_8Bits_TRI_O : out std_logic_vector(7 downto 0);
      GCLK : in std_logic;
      DIP_Switches_8Bits_TRI_I : in std_logic_vector(7 downto 0);
      axi_hdmi_0_TMDS_RX_CLK_P_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_CLK_N_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_2_P_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_2_N_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_1_P_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_1_N_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_0_P_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_0_N_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_SCL_pin : in std_logic;
      axi_hdmi_0_TMDS_RX_SDA_pin : inout std_logic;
      axi_hdmi_0_TMDS_TX_CLK_P_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_CLK_N_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_2_P_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_2_N_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_1_P_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_1_N_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_0_P_pin : out std_logic;
      axi_hdmi_0_TMDS_TX_0_N_pin : out std_logic;
      Digilent_Usb_Epp_IFCLK_pin : in std_logic;
      Digilent_Usb_Epp_STMEN_pin : in std_logic;
      Digilent_Usb_Epp_FLAGA_pin : in std_logic;
      Digilent_Usb_Epp_FLAGB_pin : in std_logic;
      Digilent_Usb_Epp_FLAGC_pin : in std_logic;
      Digilent_Usb_Epp_SLRD_pin : out std_logic;
      Digilent_Usb_Epp_SLWR_pin : out std_logic;
      Digilent_Usb_Epp_SLOE_pin : out std_logic;
      Digilent_Usb_Epp_FIFOADR_pin : out std_logic_vector(1 downto 0);
      Digilent_Usb_Epp_PKTEND_pin : out std_logic;
      Digilent_Usb_Epp_EPPRST_pin : in std_logic;
      Digilent_AC97_Cntlr_BITCLK_pin : in std_logic;
      Digilent_AC97_Cntlr_SDATA_IN_pin : in std_logic;
      Digilent_AC97_Cntlr_SDATA_OUT_pin : out std_logic;
      Digilent_AC97_Cntlr_SYNC_pin : out std_logic;
      Digilent_AC97_Cntlr_RESET_N_pin : out std_logic;
      Digilent_Usb_Epp_DB_pin : inout std_logic_vector(7 downto 0)
    );
  end component;

  component ddr2 is
    generic (
      ADDR_BITS : INTEGER;
      BA_BITS : INTEGER;
      COL_BITS : INTEGER;
      ROW_BITS : INTEGER;
      TRAS_MIN : INTEGER;
      TRCD : INTEGER;
      TRFC_MIN : INTEGER;
      TRP : INTEGER;
      TRTP : INTEGER;
      TWTR : INTEGER
    );
    port (
      addr : in std_logic_vector(12 downto 0);
      ba : in std_logic_vector(2 downto 0);
      cas_n : in std_logic;
      ck : in std_logic;
      ck_n : in std_logic;
      cke : in std_logic;
      dm_rdqs : inout std_logic_vector(0 to 0);
      dq : inout std_logic_vector(7 downto 0);
      dqs : inout std_logic_vector(0 to 0);
      dqs_n : inout std_logic_vector(0 to 0);
      odt : in std_logic;
      ras_n : in std_logic;
      we_n : in std_logic;
      rdqs_n : out std_logic_vector(0 to 0);
      cs_n : in std_logic
    );
  end component;

  -- Internal signals

  signal DIP_Switches_8Bits_TRI_I : std_logic_vector(7 downto 0);
  signal Digilent_AC97_Cntlr_BITCLK_pin : std_logic;
  signal Digilent_AC97_Cntlr_RESET_N_pin : std_logic;
  signal Digilent_AC97_Cntlr_SDATA_IN_pin : std_logic;
  signal Digilent_AC97_Cntlr_SDATA_OUT_pin : std_logic;
  signal Digilent_AC97_Cntlr_SYNC_pin : std_logic;
  signal Digilent_Usb_Epp_DB_pin : std_logic_vector(7 downto 0);
  signal Digilent_Usb_Epp_EPPRST_pin : std_logic;
  signal Digilent_Usb_Epp_FIFOADR_pin : std_logic_vector(1 downto 0);
  signal Digilent_Usb_Epp_FLAGA_pin : std_logic;
  signal Digilent_Usb_Epp_FLAGB_pin : std_logic;
  signal Digilent_Usb_Epp_FLAGC_pin : std_logic;
  signal Digilent_Usb_Epp_IFCLK_pin : std_logic;
  signal Digilent_Usb_Epp_PKTEND_pin : std_logic;
  signal Digilent_Usb_Epp_SLOE_pin : std_logic;
  signal Digilent_Usb_Epp_SLRD_pin : std_logic;
  signal Digilent_Usb_Epp_SLWR_pin : std_logic;
  signal Digilent_Usb_Epp_STMEN_pin : std_logic;
  signal GCLK : std_logic;
  signal LEDs_8Bits_TRI_O : std_logic_vector(7 downto 0);
  signal Push_Buttons_5Bits_TRI_I : std_logic_vector(4 downto 0);
  signal QSPI_FLASH_IO0 : std_logic;
  signal QSPI_FLASH_IO1 : std_logic;
  signal QSPI_FLASH_SCLK : std_logic;
  signal QSPI_FLASH_SS : std_logic;
  signal RESET : std_logic;
  signal RS232_Uart_1_sin : std_logic;
  signal RS232_Uart_1_sout : std_logic;
  signal axi_hdmi_0_TMDS_RX_0_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_0_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_1_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_1_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_2_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_2_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_CLK_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_CLK_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_SCL_pin : std_logic;
  signal axi_hdmi_0_TMDS_RX_SDA_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_0_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_0_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_1_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_1_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_2_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_2_P_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_CLK_N_pin : std_logic;
  signal axi_hdmi_0_TMDS_TX_CLK_P_pin : std_logic;
  signal mcbx_dram_addr : std_logic_vector(12 downto 0);
  signal mcbx_dram_ba : std_logic_vector(2 downto 0);
  signal mcbx_dram_cas_n : std_logic;
  signal mcbx_dram_cke : std_logic;
  signal mcbx_dram_clk : std_logic;
  signal mcbx_dram_clk_n : std_logic;
  signal mcbx_dram_dq : std_logic_vector(15 downto 0);
  signal mcbx_dram_dqs : std_logic_vector(0 to 0);
  signal mcbx_dram_dqs_n : std_logic_vector(0 to 0);
  signal mcbx_dram_ldm : std_logic_vector(0 to 0);
  signal mcbx_dram_odt : std_logic;
  signal mcbx_dram_ras_n : std_logic;
  signal mcbx_dram_udm : std_logic_vector(0 to 0);
  signal mcbx_dram_udqs : std_logic_vector(0 to 0);
  signal mcbx_dram_udqs_n : std_logic_vector(0 to 0);
  signal mcbx_dram_we_n : std_logic;
  signal net_gnd : std_logic;
  signal rzq : std_logic;
  signal zio : std_logic;

  -- START USER CODE (Do not remove this line)

  -- User: Put your signals here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

begin

  -- Internal assignments

  net_gnd <= '0';

  dut : system86
    port map (
      zio => zio,
      rzq => rzq,
      mcbx_dram_we_n => mcbx_dram_we_n,
      mcbx_dram_udqs_n => mcbx_dram_udqs_n(0),
      mcbx_dram_udqs => mcbx_dram_udqs(0),
      mcbx_dram_udm => mcbx_dram_udm(0),
      mcbx_dram_ras_n => mcbx_dram_ras_n,
      mcbx_dram_odt => mcbx_dram_odt,
      mcbx_dram_ldm => mcbx_dram_ldm(0),
      mcbx_dram_dqs_n => mcbx_dram_dqs_n(0),
      mcbx_dram_dqs => mcbx_dram_dqs(0),
      mcbx_dram_dq => mcbx_dram_dq,
      mcbx_dram_clk_n => mcbx_dram_clk_n,
      mcbx_dram_clk => mcbx_dram_clk,
      mcbx_dram_cke => mcbx_dram_cke,
      mcbx_dram_cas_n => mcbx_dram_cas_n,
      mcbx_dram_ba => mcbx_dram_ba,
      mcbx_dram_addr => mcbx_dram_addr,
      RS232_Uart_1_sout => RS232_Uart_1_sout,
      RS232_Uart_1_sin => RS232_Uart_1_sin,
      RESET => RESET,
      QSPI_FLASH_SS => QSPI_FLASH_SS,
      QSPI_FLASH_SCLK => QSPI_FLASH_SCLK,
      QSPI_FLASH_IO1 => QSPI_FLASH_IO1,
      QSPI_FLASH_IO0 => QSPI_FLASH_IO0,
      Push_Buttons_5Bits_TRI_I => Push_Buttons_5Bits_TRI_I,
      LEDs_8Bits_TRI_O => LEDs_8Bits_TRI_O,
      GCLK => GCLK,
      DIP_Switches_8Bits_TRI_I => DIP_Switches_8Bits_TRI_I,
      axi_hdmi_0_TMDS_RX_CLK_P_pin => axi_hdmi_0_TMDS_RX_CLK_P_pin,
      axi_hdmi_0_TMDS_RX_CLK_N_pin => axi_hdmi_0_TMDS_RX_CLK_N_pin,
      axi_hdmi_0_TMDS_RX_2_P_pin => axi_hdmi_0_TMDS_RX_2_P_pin,
      axi_hdmi_0_TMDS_RX_2_N_pin => axi_hdmi_0_TMDS_RX_2_N_pin,
      axi_hdmi_0_TMDS_RX_1_P_pin => axi_hdmi_0_TMDS_RX_1_P_pin,
      axi_hdmi_0_TMDS_RX_1_N_pin => axi_hdmi_0_TMDS_RX_1_N_pin,
      axi_hdmi_0_TMDS_RX_0_P_pin => axi_hdmi_0_TMDS_RX_0_P_pin,
      axi_hdmi_0_TMDS_RX_0_N_pin => axi_hdmi_0_TMDS_RX_0_N_pin,
      axi_hdmi_0_TMDS_RX_SCL_pin => axi_hdmi_0_TMDS_RX_SCL_pin,
      axi_hdmi_0_TMDS_RX_SDA_pin => axi_hdmi_0_TMDS_RX_SDA_pin,
      axi_hdmi_0_TMDS_TX_CLK_P_pin => axi_hdmi_0_TMDS_TX_CLK_P_pin,
      axi_hdmi_0_TMDS_TX_CLK_N_pin => axi_hdmi_0_TMDS_TX_CLK_N_pin,
      axi_hdmi_0_TMDS_TX_2_P_pin => axi_hdmi_0_TMDS_TX_2_P_pin,
      axi_hdmi_0_TMDS_TX_2_N_pin => axi_hdmi_0_TMDS_TX_2_N_pin,
      axi_hdmi_0_TMDS_TX_1_P_pin => axi_hdmi_0_TMDS_TX_1_P_pin,
      axi_hdmi_0_TMDS_TX_1_N_pin => axi_hdmi_0_TMDS_TX_1_N_pin,
      axi_hdmi_0_TMDS_TX_0_P_pin => axi_hdmi_0_TMDS_TX_0_P_pin,
      axi_hdmi_0_TMDS_TX_0_N_pin => axi_hdmi_0_TMDS_TX_0_N_pin,
      Digilent_Usb_Epp_IFCLK_pin => Digilent_Usb_Epp_IFCLK_pin,
      Digilent_Usb_Epp_STMEN_pin => Digilent_Usb_Epp_STMEN_pin,
      Digilent_Usb_Epp_FLAGA_pin => Digilent_Usb_Epp_FLAGA_pin,
      Digilent_Usb_Epp_FLAGB_pin => Digilent_Usb_Epp_FLAGB_pin,
      Digilent_Usb_Epp_FLAGC_pin => Digilent_Usb_Epp_FLAGC_pin,
      Digilent_Usb_Epp_SLRD_pin => Digilent_Usb_Epp_SLRD_pin,
      Digilent_Usb_Epp_SLWR_pin => Digilent_Usb_Epp_SLWR_pin,
      Digilent_Usb_Epp_SLOE_pin => Digilent_Usb_Epp_SLOE_pin,
      Digilent_Usb_Epp_FIFOADR_pin => Digilent_Usb_Epp_FIFOADR_pin,
      Digilent_Usb_Epp_PKTEND_pin => Digilent_Usb_Epp_PKTEND_pin,
      Digilent_Usb_Epp_EPPRST_pin => Digilent_Usb_Epp_EPPRST_pin,
      Digilent_AC97_Cntlr_BITCLK_pin => Digilent_AC97_Cntlr_BITCLK_pin,
      Digilent_AC97_Cntlr_SDATA_IN_pin => Digilent_AC97_Cntlr_SDATA_IN_pin,
      Digilent_AC97_Cntlr_SDATA_OUT_pin => Digilent_AC97_Cntlr_SDATA_OUT_pin,
      Digilent_AC97_Cntlr_SYNC_pin => Digilent_AC97_Cntlr_SYNC_pin,
      Digilent_AC97_Cntlr_RESET_N_pin => Digilent_AC97_Cntlr_RESET_N_pin,
      Digilent_Usb_Epp_DB_pin => Digilent_Usb_Epp_DB_pin
    );

  inst_ddr_00 : ddr2
    generic map (
      ADDR_BITS => 13,
      BA_BITS => 3,
      COL_BITS => 10,
      ROW_BITS => 13,
      TRAS_MIN => 42500,
      TRCD => 15000,
      TRFC_MIN => 127500,
      TRP => 15000,
      TRTP => 7500,
      TWTR => 7500
    )
    port map (
      addr => mcbx_dram_addr,
      ba => mcbx_dram_ba,
      cas_n => mcbx_dram_cas_n,
      ck => mcbx_dram_clk,
      ck_n => mcbx_dram_clk_n,
      cke => mcbx_dram_cke,
      dm_rdqs => mcbx_dram_ldm(0 to 0),
      dq => mcbx_dram_dq(7 downto 0),
      dqs => mcbx_dram_dqs(0 to 0),
      dqs_n => mcbx_dram_dqs_n(0 to 0),
      odt => mcbx_dram_odt,
      ras_n => mcbx_dram_ras_n,
      we_n => mcbx_dram_we_n,
      rdqs_n => open,
      cs_n => net_gnd
    );

  inst_ddr_01 : ddr2
    generic map (
      ADDR_BITS => 13,
      BA_BITS => 3,
      COL_BITS => 10,
      ROW_BITS => 13,
      TRAS_MIN => 42500,
      TRCD => 15000,
      TRFC_MIN => 127500,
      TRP => 15000,
      TRTP => 7500,
      TWTR => 7500
    )
    port map (
      addr => mcbx_dram_addr,
      ba => mcbx_dram_ba,
      cas_n => mcbx_dram_cas_n,
      ck => mcbx_dram_clk,
      ck_n => mcbx_dram_clk_n,
      cke => mcbx_dram_cke,
      dm_rdqs => mcbx_dram_udm(0 to 0),
      dq => mcbx_dram_dq(15 downto 8),
      dqs => mcbx_dram_udqs(0 to 0),
      dqs_n => mcbx_dram_udqs_n(0 to 0),
      odt => mcbx_dram_odt,
      ras_n => mcbx_dram_ras_n,
      we_n => mcbx_dram_we_n,
      rdqs_n => open,
      cs_n => net_gnd
    );

  -- Clock generator for GCLK

  process
  begin
    GCLK <= '0';
    loop
      wait for (GCLK_PERIOD/2);
      GCLK <= not GCLK;
    end loop;
  end process;

  -- Reset Generator for RESET

  process
  begin
    RESET <= '0';
    wait for (RESET_LENGTH);
    RESET <= not RESET;
    wait;
  end process;

  -- START USER CODE (Do not remove this line)

  -- User: Put your stimulus here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

end architecture STRUCTURE;

