------------------------------------------------------------------------------
-- video_bus_breakout.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          video_bus_breakout.vhd
-- Version:           1.00.a
-- Description:       Top level design, instantiates library components and user logic.
-- Date:              Thu Nov 28 13:05:40 2019 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "I_<#|FUNC>"
------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_DIRECTION                  -- 
--   C_COMPONENT_DEPTH            -- 
--   C_USE_BLANKING               -- 
--
-- Definition of Ports:
------------------------------------------------------------------------------

ENTITY video_bus_breakout IS
	GENERIC (
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		C_COMPONENT_DEPTH : INTEGER := 8;
		C_USE_CLOCK : INTEGER := 0;
		C_USE_TIMINGS : INTEGER := 1;
		C_USE_BLANKING : INTEGER := 0;
		C_USE_DATA : INTEGER := 1

		-- ADD USER GENERICS ABOVE THIS LINE ---------------

	);
	PORT (
		-- ADD USER PORTS BELOW THIS LINE ------------------
		I_CLK : IN std_logic;
		I_HSYNC : IN std_logic;
		I_VSYNC : IN std_logic;
		I_HBLANK : IN std_logic := 'X';
		I_VBLANK : IN std_logic := 'X';
		I_LOCKED : IN std_logic;
		I_RED : IN std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		I_GREEN : IN std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		I_BLUE : IN std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);

		O_CLK : OUT std_logic;
		O_HSYNC : OUT std_logic;
		O_VSYNC : OUT std_logic;
		O_HBLANK : OUT std_logic := 'X';
		O_VBLANK : OUT std_logic := 'X';
		O_LOCKED : OUT std_logic;
		O_RED : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_GREEN : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_BLUE : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0)
		-- ADD USER PORTS ABOVE THIS LINE ------------------
	);

END ENTITY video_bus_breakout;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

ARCHITECTURE IMP OF video_bus_breakout IS

BEGIN

	------------------------------------------
	-- connect internal signals
	------------------------------------------
	HAVE_CLOCK : IF C_USE_CLOCK GENERATE
		O_CLK <= I_CLK;
	END GENERATE HAVE_CLOCK;

	HAVE_TIMINGS : IF C_USE_TIMINGS GENERATE
		O_HSYNC <= I_HSYNC;
		O_VSYNC <= I_VSYNC;
		HAVE_BLANKING : IF C_USE_BLANKING > 0 GENERATE
			O_HBLANK <= I_HBLANK;
			O_VBLANK <= I_VBLANK;
		END GENERATE HAVE_BLANKING;
		O_LOCKED <= I_LOCKED;
	END GENERATE HAVE_TIMINGS;

	HAVE_DATA : IF C_USE_DATA & 4 GENERATE
		O_RED <= I_RED;
		O_GREEN <= I_GREEN;
		O_BLUE <= I_BLUE;
	END GENERATE HAVE_DATA;

END IMP;