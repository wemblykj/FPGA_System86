library ieee;
use ieee.std_logic_1164.all;

entity cus27_rtl is
	generic
	(
		C_USE_HARDWARE_CLOCKS		: integer	:= 0
	);
	port
	(
		rst              : in    std_logic;
		--USE_HARDWARE_CLOCKS: if C_USE_HARDWARE_CLOCKS = 0 generate
			clk_48m          : in    std_logic;
			clk_6m           : in    std_logic;
			clk_24m_o        : in    std_logic;
			clk_12m_o        : in    std_logic;
			clk_6m_o         : in    std_logic;
		--end generate;
		vsync            : out   std_logic;
		hsync            : out   std_logic;
		hblank           : out   std_logic;
		vblank           : out   std_logic;
		vreset           : out   std_logic;
		hreset           : out   std_logic;
		clk_8v_o         : out   std_logic;
		clk_4v_o         : out   std_logic;
		clk_1v_o         : out   std_logic;
		clk_4h_o         : out   std_logic;
		clk_2h_o         : out   std_logic;
		clk_1h_o         : out   std_logic;
		clk_s1h_o        : out   std_logic;
		clk_s2h_o        : out   std_logic
	);

end cus27_rtl;

architecture rtl of cus27_rtl is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------

-- Data alignment engine
--USE_HARDWARE_CLOCKS: if C_USE_HARDWARE_CLOCKS = 0 generate
component cus27
	generic
	(
		C_USE_HARDWARE_CLOCKS		: integer	:= 0
	);
   port(   
		rst              : in    std_logic;
--USE_HARDWARE_CLOCKS: if C_USE_HARDWARE_CLOCKS = 0 generate
		clk_48m          : in    std_logic;
		clk_6m_o         : in    std_logic;
		clk_24m_o        : in    std_logic;
		clk_12m_o        : in    std_logic;
--end generate;
		clk_6m           : in    std_logic;
		vsync            : out   std_logic;
		hsync            : out   std_logic;
		hblank           : out   std_logic;
		vblank           : out   std_logic;
		vreset           : out   std_logic;
		hreset           : out   std_logic;
		clk_8v_o         : out   std_logic;
		clk_4v_o         : out   std_logic;
		clk_1v_o         : out   std_logic;
		clk_4h_o         : out   std_logic;
		clk_2h_o         : out   std_logic;
		clk_1h_o         : out   std_logic;
		clk_s1h_o        : out   std_logic;
		clk_s2h_o        : out   std_logic
	);
						
end component;
--end generate;

begin
	Inst_Cus27: cus27
	generic map
	(
		C_USE_HARDWARE_CLOCKS	=> C_USE_HARDWARE_CLOCKS
	)
	port map(
		rst			=> rst,
		clk_48m		=> clk_48m,
		clk_6m		=> clk_6m,
--USE_HARDWARE_CLOCKS: if C_USE_HARDWARE_CLOCKS = 0 generate
		clk_24m_o	=> clk_24m_o,
		clk_12m_o	=> clk_12m_o,
		clk_6m_o		=> clk_6m_o,
--end generate
		clk_S2h_o	=> clk_S2h_o
	);
		
end rtl;
