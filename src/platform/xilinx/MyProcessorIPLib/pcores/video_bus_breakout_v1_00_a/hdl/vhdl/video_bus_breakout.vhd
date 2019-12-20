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
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

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

entity video_bus_breakout is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
         C_DIRECTION                    : integer              := 0;
         C_COMPONENT_DEPTH              : integer              := 8;
	      C_USE_BLANKING                 : integer              := 0
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
	 I_HSYNC                        : in std_logic;
	 I_VSYNC                        : in std_logic;
	 I_HBLANK                       : in std_logic := 'X';
	 I_VBLANK                       : in std_logic := 'X';
	 I_RED                          : in std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 I_GREEN                        : in std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 I_BLUE                         : in std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 
	 O_HSYNC                        : out std_logic;
	 O_VSYNC                        : out std_logic;
	 O_HBLANK                       : out std_logic := 'X';
	 O_VBLANK                       : out std_logic := 'X';
	 O_RED                          : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 o_GREEN                        : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
	 O_BLUE                         : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0)
    -- ADD USER PORTS ABOVE THIS LINE ------------------
  );

end entity video_bus_breakout;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of video_bus_breakout is

begin

  ------------------------------------------
  -- connect internal signals
  ------------------------------------------
  O_HSYNC <= I_HSYNC;
  O_VSYNC <= I_VSYNC;
  O_HBLANK <= I_HBLANK;
  O_VBLANK <= I_VBLANK;
  O_RED <= I_RED;
  O_GREEN <= I_GREEN;
  O_BLUE <= I_BLUE;

end IMP;
