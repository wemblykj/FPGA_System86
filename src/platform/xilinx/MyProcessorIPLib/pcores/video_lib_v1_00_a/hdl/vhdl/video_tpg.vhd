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

ENTITY video_tpg IS
	GENERIC (
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		C_COMPONENT_DEPTH : INTEGER := 8;
		C_TOTAL_COLS : INTEGER := 800;
		C_TOTAL_ROWS : INTEGER := 525;
		C_ACTIVE_COLS : INTEGER := 640;
		C_ACTIVE_ROWS : INTEGER := 480;
		C_SYNC_PULSE_HORZ : INTEGER := 96;
		C_SYNC_PULSE_VERT : INTEGER := 2;
		C_USE_BLANKING : INTEGER := 0;
		C_FRONT_PORCH_HORZ : INTEGER := 16;
		C_BACK_PORCH_HORZ : INTEGER := 48;
		C_FRONT_PORCH_VERT : INTEGER := 10;
		C_BACK_PORCH_VERT : INTEGER := 33
		-- ADD USER GENERICS ABOVE THIS LINE ---------------
	);
	PORT (
		-- ADD USER PORTS BELOW THIS LINE ------------------
		I_CLK : IN std_logic;
		I_RST : IN std_logic := '0';

		I_PATTERN : IN std_logic_vector(3 DOWNTO 0);

		I_HSYNC : IN std_logic;
		I_VSYNC : IN std_logic;

		O_LOCKED : OUT std_logic;
		O_HSYNC : OUT std_logic;
		O_VSYNC : OUT std_logic;
		O_HBLANK : OUT std_logic := 'X';
		O_VBLANK : OUT std_logic := 'X';
		O_RED : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		o_GREEN : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_BLUE : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0)
		-- ADD USER PORTS ABOVE THIS LINE ------------------
	);
END ENTITY video_tpg;

ARCHITECTURE Behavioral OF video_tpg IS

	COMPONENT Test_Pattern_Gen
		GENERIC (
			COMPONENT_DEPTH : INTEGER := 8;
			TOTAL_COLS : INTEGER := 800;
			TOTAL_ROWS : INTEGER := 525;
			ACTIVE_COLS : INTEGER := 640;
			ACTIVE_ROWS : INTEGER := 480;
			USE_BLANKING : INTEGER := 0;
			SYNC_PULSE_HORZ : INTEGER := 96;
			SYNC_PULSE_VERT : INTEGER := 2;
			FRONT_PORCH_HORZ : INTEGER := 16;
			BACK_PORCH_HORZ : INTEGER := 48;
			FRONT_PORCH_VERT : INTEGER := 10;
			BACK_PORCH_VERT : INTEGER := 33
		);
		PORT (
			i_Clk : IN std_logic;
			i_Rst : IN std_logic;
			i_Pattern : IN std_logic_vector(3 DOWNTO 0);
			i_HSync : IN std_logic;
			i_VSync : IN std_logic;
			o_Locked : OUT std_logic;
			o_HSync : OUT std_logic;
			o_VSync : OUT std_logic;
			o_HBlank : OUT std_logic := 'X';
			o_VBlank : OUT std_logic := 'X';
			o_Red_Video : OUT std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			o_Grn_Video : OUT std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0);
			o_Blu_Video : OUT std_logic_vector(COMPONENT_DEPTH - 1 DOWNTO 0)
		);
	END COMPONENT;

BEGIN

	------------------------------------------
	-- instantiate Test Pattern Generator
	------------------------------------------

	TEST_GEN_I : Test_Pattern_Gen
	GENERIC MAP
	(
		COMPONENT_DEPTH => C_COMPONENT_DEPTH,
		TOTAL_COLS => C_TOTAL_COLS,
		TOTAL_ROWS => C_TOTAL_ROWS,
		ACTIVE_COLS => C_ACTIVE_COLS,
		ACTIVE_ROWS => C_ACTIVE_ROWS,
		USE_BLANKING => C_USE_BLANKING,
		SYNC_PULSE_HORZ => C_SYNC_PULSE_HORZ,
		SYNC_PULSE_VERT => C_SYNC_PULSE_VERT,
		FRONT_PORCH_HORZ => C_FRONT_PORCH_HORZ,
		BACK_PORCH_HORZ => C_BACK_PORCH_HORZ,
		FRONT_PORCH_VERT => C_FRONT_PORCH_VERT,
		BACK_PORCH_VERT => C_BACK_PORCH_VERT
	)
	PORT MAP
	(
		i_Clk => I_CLK,
		i_RST => I_RST,
		i_Pattern => I_PATTERN,
		i_HSync => I_HSYNC,
		i_VSync => I_VSYNC,
		o_Locked => O_LOCKED,
		o_HSync => O_HSYNC,
		o_VSync => O_VSYNC,
		o_HBlank => O_HBLANK,
		o_VBlank => O_VBLANK,
		o_Red_Video => O_RED,
		o_Grn_Video => O_GREEN,
		o_Blu_Video => O_BLUE
	);

END Behavioral;