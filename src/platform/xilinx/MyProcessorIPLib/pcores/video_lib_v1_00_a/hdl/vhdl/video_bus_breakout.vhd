----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:30:48 12/19/2019 
-- Design Name: 
-- Module Name:    Test_Pattern_Gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity video_tpg is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    C_COMPONENT_DEPTH              : integer              := 8;
	 C_TOTAL_COLS                   : integer              := 800;
	 C_TOTAL_ROWS                   : integer              := 525;
	 C_ACTIVE_COLS                  : integer              := 640;
	 C_ACTIVE_ROWS                  : integer              := 480;
	 C_SYNC_PULSE_HORZ              : integer              := 96;
	 C_SYNC_PULSE_VERT              : integer              := 2;
	 C_USE_BLANKING                 : integer              := 0;
	 C_FRONT_PORCH_HORZ             : integer              := 16;
	 C_BACK_PORCH_HORZ              : integer              := 48;
	 C_FRONT_PORCH_VERT             : integer              := 10;
	 C_BACK_PORCH_VERT              : integer              := 33
    -- ADD USER GENERICS ABOVE THIS LINE ---------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    I_CLK                          : in  std_logic;
	 I_RST                          : in  std_logic := '0';
	 
	 I_PATTERN                      : in  std_logic_vector(3 downto 0);
	 
	 I_HSYNC                        : in  std_logic;
	 I_VSYNC                        : in  std_logic;
	 
	 O_LOCKED                       : out std_logic;
	 O_HSYNC                        : out std_logic;
	 O_VSYNC                        : out std_logic;
	 O_HBLANK                       : out std_logic := 'X';
	 O_VBLANK                       : out std_logic := 'X';
	 O_RED                          : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 o_GREEN                        : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 O_BLUE                         : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0)
    -- ADD USER PORTS ABOVE THIS LINE ------------------
  );
end entity video_tpg;

architecture Behavioral of video_tpg is

component Test_Pattern_Gen
    generic(
      COMPONENT_DEPTH                     : integer := 8;
      TOTAL_COLS                          : integer := 800;
      TOTAL_ROWS                          : integer := 525;
      ACTIVE_COLS                         : integer := 640;
      ACTIVE_ROWS                         : integer := 480;
      USE_BLANKING                        : integer := 0;
      SYNC_PULSE_HORZ                     : integer := 96;
      SYNC_PULSE_VERT                     : integer := 2;
      FRONT_PORCH_HORZ                    : integer := 16;
      BACK_PORCH_HORZ                     : integer := 48;
      FRONT_PORCH_VERT                    : integer := 10;
      BACK_PORCH_VERT                     : integer := 33	  
    );
    port (
      i_Clk : in std_logic;
	   i_Rst : in std_logic;
      i_Pattern : in std_logic_vector(3 downto 0);
      i_HSync : in std_logic;
      i_VSync : in std_logic;
	   o_Locked : out std_logic;
	   o_HSync : out std_logic;
      o_VSync : out std_logic;
	   o_HBlank : out std_logic := 'X';
      o_VBlank : out std_logic := 'X';
      o_Red_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0);
      o_Grn_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0);
      o_Blu_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0)
    );
  end component;
  
begin

------------------------------------------
  -- instantiate Test Pattern Generator
  ------------------------------------------

  TEST_GEN_I: Test_Pattern_Gen
	 generic map
    (
      COMPONENT_DEPTH                => C_COMPONENT_DEPTH,
      TOTAL_COLS                     => C_TOTAL_COLS,
      TOTAL_ROWS                     => C_TOTAL_ROWS,
      ACTIVE_COLS                    => C_ACTIVE_COLS,
      ACTIVE_ROWS                    => C_ACTIVE_ROWS,
		USE_BLANKING                   => C_USE_BLANKING,
		SYNC_PULSE_HORZ                => C_SYNC_PULSE_HORZ,
	   SYNC_PULSE_VERT                => C_SYNC_PULSE_VERT,
	   FRONT_PORCH_HORZ               => C_FRONT_PORCH_HORZ,
	   BACK_PORCH_HORZ                => C_BACK_PORCH_HORZ,
	   FRONT_PORCH_VERT               => C_FRONT_PORCH_VERT,
	   BACK_PORCH_VERT                => C_BACK_PORCH_VERT
	 )
	 port map
	 (
      i_Clk                          => I_CLK,
		i_RST                          => I_RST,
      i_Pattern                      => I_PATTERN,
      i_HSync                        => I_HSYNC,
      i_VSync                        => I_VSYNC,
		o_Locked                       => O_LOCKED,
		o_HSync                        => O_HSYNC,
      o_VSync                        => O_VSYNC,
		o_HBlank                       => O_HBLANK,
      o_VBlank                       => O_VBLANK,
      o_Red_Video                    => O_RED,
      o_Grn_Video                    => O_GREEN,
      o_Blu_Video                    => O_BLUE
    );

end Behavioral;

