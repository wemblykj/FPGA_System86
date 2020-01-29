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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY video_upscaler IS
	GENERIC (
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		C_CLOCK_PASSTHRU : INTEGER := 1;
		C_COMPONENT_DEPTH : INTEGER := 8;
		C_USE_BLANKING_A : INTEGER := 0;
		C_USE_BLANKING_B : INTEGER := 0;
		C_LINE_BUFFER_SIZE : INTEGER := 1024;
		C_LINE_BUFFER_COUNT : INTEGER := 12;
		C_VERTICAL_SYNC_DELAY : INTEGER := 2;
		C_SCALE_PRECISION_WIDTH : INTEGER := 6;
		C_SCALE_PRECISION_HEIGHT : INTEGER := 6;
		C_HORIZONTAL_COUNTER_DEPTH_A : INTEGER := 12;
		C_VERTICAL_COUNTER_DEPTH_A : INTEGER := 12;
		C_HORIZONTAL_COUNTER_DEPTH_B : INTEGER := 12;
		C_VERTICAL_COUNTER_DEPTH_B : INTEGER := 12
		-- ADD USER GENERICS ABOVE THIS LINE ---------------
	);
	PORT (
		-- ADD USER PORTS BELOW THIS LINE ------------------
		I_RST : IN std_logic := '0';

		I_A_CLK : IN std_logic;
		I_A_HSYNC : IN std_logic;
		I_A_VSYNC : IN std_logic;
		I_A_HBLANK : IN std_logic;
		I_A_VBLANK : IN std_logic;
		I_A_RED : IN std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		I_A_GREEN : IN std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		I_A_BLUE : IN std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);

		I_B_CLK : IN std_logic;
		I_B_HSYNC : IN std_logic;
		I_B_VSYNC : IN std_logic;
		I_B_HBLANK : IN std_logic;
		I_B_VBLANK : IN std_logic;

		O_A_LOCKED : OUT std_logic;
		O_A_WIDTH : OUT std_logic_vector(C_HORIZONTAL_COUNTER_DEPTH_A-1 DOWNTO 0);
		O_A_HEIGHT : OUT std_logic_vector(C_VERTICAL_COUNTER_DEPTH_A-1 DOWNTO 0);

		O_B_CLK : OUT std_logic;
		O_B_LOCKED : OUT std_logic;
		O_B_WIDTH : OUT std_logic_vector(C_HORIZONTAL_COUNTER_DEPTH_B-1 DOWNTO 0);
		O_B_HEIGHT : OUT std_logic_vector(C_VERTICAL_COUNTER_DEPTH_B-1 DOWNTO 0);
		O_B_HSYNC : OUT std_logic;
		O_B_VSYNC : OUT std_logic;
		O_B_HBLANK : OUT std_logic := 'X';
		O_B_VBLANK : OUT std_logic := 'X';
		O_B_RED : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_B_GREEN : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_B_BLUE : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0)
		-- ADD USER PORTS ABOVE THIS LINE ------------------
	);
END ENTITY video_upscaler;

ARCHITECTURE Behavioral OF video_upscaler IS

	COMPONENT Upscaler
		GENERIC (
			COMPONENT_DEPTH : INTEGER := 8;
			USE_BLANKING_A : INTEGER := 0;
			USE_BLANKING_B : INTEGER := 0;
			LINE_BUFFER_SIZE : INTEGER := 1024;
			LINE_BUFFER_COUNT : INTEGER := 12;
			VERTICAL_SYNC_DELAY : INTEGER := 2;
			SCALE_PRECISION_WIDTH : INTEGER := 6;
			SCALE_PRECISION_HEIGHT : INTEGER := 6;
			HORIZONTAL_COUNTER_DEPTH_A : INTEGER := 12;
			VERTICAL_COUNTER_DEPTH_A : INTEGER := 12;
			HORIZONTAL_COUNTER_DEPTH_B : INTEGER := 12;
			VERTICAL_COUNTER_DEPTH_B : INTEGER := 12
		);
		PORT (
			i_Rst : IN std_logic;

			i_ClkA : IN std_logic;
			i_ClkB : IN std_logic;
			i_HSyncA : IN std_logic;
			i_VSyncA : IN std_logic;
			i_HBlankA : IN std_logic;
			i_VBlankA : IN std_logic;
			i_RedA : IN std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			i_GreenA : IN std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			i_BlueA : IN std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			i_HSyncB : IN std_logic;
			i_VSyncB : IN std_logic;
			i_HBlankB : IN std_logic;
			i_VBlankB : IN std_logic;
			o_LockedA : OUT std_logic;
			o_WidthA : OUT std_logic_vector(HORIZONTAL_COUNTER_DEPTH_A-1 DOWNTO 0);
			o_HeightA : OUT std_logic_vector(VERTICAL_COUNTER_DEPTH_A-1 DOWNTO 0);
			o_LockedB : OUT std_logic;		
			o_WidthB : OUT std_logic_vector(HORIZONTAL_COUNTER_DEPTH_B-1 DOWNTO 0);
			o_HeightB : OUT std_logic_vector(VERTICAL_COUNTER_DEPTH_B-1 DOWNTO 0);
			o_HSyncB : OUT std_logic;
			o_VSyncB : OUT std_logic;
			o_HBlankB : OUT std_logic := 'X';
			o_VBlankB : OUT std_logic := 'X';
			o_RedB : OUT std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			o_GreenB : OUT std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			o_BlueB : OUT std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0)
		);
	END COMPONENT;

BEGIN

	HAVE_CLOCK : IF C_CLOCK_PASSTHRU > 0 GENERATE
		O_B_CLK <= I_B_CLK;
	END GENERATE HAVE_CLOCK;

	------------------------------------------
	-- instantiate Upscaler
	------------------------------------------

	TEST_GEN_I : Upscaler
	GENERIC MAP
	(
		COMPONENT_DEPTH => C_COMPONENT_DEPTH,
		USE_BLANKING_A => C_USE_BLANKING_A,
		USE_BLANKING_B => C_USE_BLANKING_B,
		LINE_BUFFER_SIZE => C_LINE_BUFFER_SIZE,
		LINE_BUFFER_COUNT => C_LINE_BUFFER_COUNT,
		VERTICAL_SYNC_DELAY => C_VERTICAL_SYNC_DELAY,
		SCALE_PRECISION_WIDTH => C_SCALE_PRECISION_WIDTH,
		SCALE_PRECISION_HEIGHT => C_SCALE_PRECISION_HEIGHT,
		HORIZONTAL_COUNTER_DEPTH_A => C_HORIZONTAL_COUNTER_DEPTH_A,
		VERTICAL_COUNTER_DEPTH_A => C_VERTICAL_COUNTER_DEPTH_A,
		HORIZONTAL_COUNTER_DEPTH_B => C_HORIZONTAL_COUNTER_DEPTH_B,
		VERTICAL_COUNTER_DEPTH_B => C_VERTICAL_COUNTER_DEPTH_B
	)
	PORT MAP
	(
		i_RST => I_RST,
		i_ClkA => I_A_CLK,
		i_ClkB => I_B_CLK,
		i_HSyncA => I_A_HSYNC,
		i_VSyncA => I_A_VSYNC,
		i_HBlankA => I_A_HBLANK,
		i_VBlankA => I_A_VBLANK,
		i_RedA => I_A_RED,
		i_GreenA => I_A_GREEN,
		i_BlueA => I_A_BLUE,
		i_HSyncB => I_B_HSYNC,
		i_VSyncB => I_B_VSYNC,
		i_HBlankB => I_B_HBLANK,
		i_VBlankB => I_B_VBLANK,

		o_LockedA => O_A_LOCKED,
		o_WidthA => O_A_WIDTH,
		o_HeightA => O_A_HEIGHT,
		o_LockedB => O_B_LOCKED,
		o_WidthB => O_B_WIDTH,
		o_HeightB => O_B_HEIGHT,
		o_HSyncB => O_B_HSYNC,
		o_VSyncB => O_B_VSYNC,
		o_HBlankB => O_B_HBLANK,
		o_VBlankB => O_B_VBLANK,
		o_RedB => O_B_RED,
		o_GreenB => O_B_GREEN,
		o_BlueB => O_B_BLUE
	);

END Behavioral;
