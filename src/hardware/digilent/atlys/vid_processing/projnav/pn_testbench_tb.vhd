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

  component vid_processing is
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
      RESET : in std_logic;
      Push_Buttons_5Bits_TRI_I : in std_logic_vector(0 to 4);
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
      axi_hdmi_0_TMDS_TX_0_N_pin : out std_logic
    );
  end component;
 -- cas_n,ck,ck_n,cke,cs_n,ldm,odt,ras_n,udm,we_n,a,ba,ldqs,ldqs_n,udqs,udqs_n,dq
  component ede1116 is
    --generic(
	 --);
	 port(
		cas_n		: in std_logic;
		ck			: in std_logic;
		ck_n		: in std_logic;
		cke		: in std_logic;
		cs_n		: in std_logic;
		ldm		: in std_logic;
		odt		: in std_logic;
		ras_n		: in std_logic;
		udm		: in std_logic;
		we_n		: in std_logic;
		a			: in std_logic_vector(12 downto 0);
		ba			: in std_logic_vector(2 downto 0);
		ldqs		: inout std_logic;
		ldqs_n	: inout std_logic;
		udqs		: inout std_logic;
		udqs_n	: inout std_logic;
		dq			: inout std_logic_vector(15 downto 0)
	 );
  end component;
  -- Internal signals

  signal DIP_Switches_8Bits_TRI_I : std_logic_vector(7 downto 0);
  signal GCLK : std_logic;
  signal LEDs_8Bits_TRI_O : std_logic_vector(7 downto 0);
  signal Push_Buttons_5Bits_TRI_I : std_logic_vector(0 to 4);
  signal RESET : std_logic;
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
  signal mcbx_dram_dqs : std_logic;
  signal mcbx_dram_dqs_n : std_logic;
  signal mcbx_dram_ldm : std_logic;
  signal mcbx_dram_odt : std_logic;
  signal mcbx_dram_ras_n : std_logic;
  signal mcbx_dram_udm : std_logic;
  signal mcbx_dram_udqs : std_logic;
  signal mcbx_dram_udqs_n : std_logic;
  signal mcbx_dram_we_n : std_logic;
  signal rzq : std_logic;
  signal zio : std_logic;

  -- START USER CODE (Do not remove this line)

  -- User: Put your signals here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

begin

  dut : vid_processing
    port map (
      zio => zio,
      rzq => rzq,
      mcbx_dram_we_n => mcbx_dram_we_n,
      mcbx_dram_udqs_n => mcbx_dram_udqs_n,
      mcbx_dram_udqs => mcbx_dram_udqs,
      mcbx_dram_udm => mcbx_dram_udm,
      mcbx_dram_ras_n => mcbx_dram_ras_n,
      mcbx_dram_odt => mcbx_dram_odt,
      mcbx_dram_ldm => mcbx_dram_ldm,
      mcbx_dram_dqs_n => mcbx_dram_dqs_n,
      mcbx_dram_dqs => mcbx_dram_dqs,
      mcbx_dram_dq => mcbx_dram_dq,
      mcbx_dram_clk_n => mcbx_dram_clk_n,
      mcbx_dram_clk => mcbx_dram_clk,
      mcbx_dram_cke => mcbx_dram_cke,
      mcbx_dram_cas_n => mcbx_dram_cas_n,
      mcbx_dram_ba => mcbx_dram_ba,
      mcbx_dram_addr => mcbx_dram_addr,
      RESET => RESET,
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
      axi_hdmi_0_TMDS_TX_0_N_pin => axi_hdmi_0_TMDS_TX_0_N_pin
    );

	 sdram : ede1116
    port map (
		cs_n => '0',
		we_n => mcbx_dram_we_n,
      udqs_n => mcbx_dram_udqs_n,
      udqs => mcbx_dram_udqs,
      udm => mcbx_dram_udm,
      ras_n => mcbx_dram_ras_n,
      odt => mcbx_dram_odt,
      ldm => mcbx_dram_ldm,
      ldqs_n => mcbx_dram_dqs_n,
      ldqs => mcbx_dram_dqs,
      dq => mcbx_dram_dq,
      ck_n => mcbx_dram_clk_n,
      ck => mcbx_dram_clk,
      cke => mcbx_dram_cke,
      cas_n => mcbx_dram_cas_n,
      ba => mcbx_dram_ba,
      a => mcbx_dram_addr
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

