------------------------------------------------------------------------------
-- video_sync_gen.vhd - entity/architecture pair
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
-- Filename:          video_sync_gen.vhd
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

ENTITY video_sync_gen IS
	GENERIC (
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		C_TOTAL_COLS : INTEGER := 800;
		C_TOTAL_ROWS : INTEGER := 525;
		C_SYNC_PULSE_HORZ : INTEGER := 96;
		C_SYNC_PULSE_HORZ : INTEGER := 2
		-- ADD USER GENERICS ABOVE THIS LINE ---------------
	);
	PORT (
		-- ADD USER PORTS BELOW THIS LINE ------------------
		I_CLK : IN std_logic;
		I_HSYNC : IN std_logic;
		I_VSYNC : IN std_logic;
		O_LOCKED : OUT std_logic;
		O_HSYNC : OUT std_logic;
		O_VSYNC : OUT std_logic
		-- ADD USER PORTS ABOVE THIS LINE ------------------
	);

END ENTITY video_sync_gen;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

ARCHITECTURE IMP OF video_sync_gen IS

	COMPONENT VGA_Sync_Pulses
	GENERIC(
		TOTAL_COLS                    : integer              := 800;
		TOTAL_ROWS                    : integer              := 525;
		SYNC_PULSE_HORZ               : integer              := 96;
		SYNC_PULSE_VERT               : integer              := 2
	);
	PORT(
        	i_Clk : IN std_logic;
		i_Rst : IN std_logic;
		o_Locked : OUT std_logic;
		o_HSync : OUT std_logic;
		o_VSync : OUT std_logic
        	);
        END COMPONENT;

BEGIN

	SYNC_PULSES_I: VGA_Sync_Pulses
	GENERIC MAP(
		TOTAL_COLS => C_TOTAL_COLS,
		TOTAL_ROWS => C_TOTAL_ROWS,
		SYNC_PULSE_HORZ => C_SYNC_PULSE_HORZ,
		SYNC_PULSE_VERT => C_SYNC_PULSE_VERT
	)
	 PORT MAP(
		i_Clk => I_CLK,
		i_Rst => I_RST,
		o_Locked => O_LOCKED,
		o_HSync => O_HSYNC,
		o_VSync => O_VSYNC
	        );

END IMP;
