------------------------------------------------------------------------------
-- mc6809e_cpu.vhd - entity/architecture pair
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
-- Filename:          mc6809e_cpu.vhd
-- Version:           1.00.a
-- Description:       Top level design, instantiates library components and user logic.
-- Date:              Wed Mar 20 13:15:10 2019 (by Create and Import Peripheral Wizard)
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


-------------------------------------------------------------------------------
-- mc6809e_cpu_v1_00_a library is used for mc6809e_cpu component declarations
-------------------------------------------------------------------------------

library mc6809e_cpu_v1_00_a;
use mc6809e_cpu_v1_00_a.all;

-------------------------------------------------------------------------------
--                     Defination of Generics :                              --
-------------------------------------------------------------------------------
-- C_VARIANT    	  -- The MC6809 variant.

-- AXI generics
-- C_FAMILY               -- XILINX FPGA family
-- C_INSTANCE             -- Instance name ot the core in the EDK system
--
--
-- Definition of Ports:
--
-------------------------------------------------------------------------------
--                  Defination of Ports                                      --
-------------------------------------------------------------------------------

------------------------------------------------------------------------------

entity mc6809e_cpu is
  generic (
    -- ROM generics
    -- C_VARIANT : std_logic := '0';
    C_ADDR_WIDTH : integer := 16;
    C_DATA_WIDTH : integer := 8;

    --Family Generics
    C_XLNX_REF_BOARD : string := "NONE";
    C_FAMILY : string := "spartan6";
    C_INSTANCE : string := "mc6809e_cpu_inst"
  );
  port (
    -- MC6809 common
    nReset 			: in std_logic;
    nHalt 			: in std_logic;
    nIrq 			: in std_logic;
    nFirq 			: in std_logic;
    nNmi 			: in std_logic;
    nWriteEnable 	: out std_logic;
    Address 		: out std_logic_vector((C_ADDR_WIDTH - 1) downto 0);
    Data 			: inout std_logic_vector((C_DATA_WIDTH - 1) downto 0);
    BS 				: out std_logic;
    BA		 		: out std_logic;
    -- MC6809E
    E 				: in std_logic;
    Q 				: in std_logic;
    Avma 			: out std_logic;
    Busy 			: out std_logic;
    Lic 				: out std_logic
  );

  -------------------------------------------------------------------------------
  -- fan-out attributes for XST
  -------------------------------------------------------------------------------

  attribute MAX_FANOUT : string;
  attribute MAX_FANOUT of E : signal is "10000";
  attribute MAX_FANOUT of Q : signal is "10000";
  attribute MAX_FANOUT of nReset : signal is "10000";
  
  -------------------------------------------------------------------------------
  -- Attributes for MPD file
  -------------------------------------------------------------------------------
  attribute IP_GROUP : string;
  attribute IP_GROUP of mc6809e_cpu : entity is "LOGICORE";
  attribute SIGIS : string;
  attribute SIGIS of E : signal is "Clk";
  attribute SIGIS of Q : signal is "Clk";
  attribute SIGIS of nReset : signal is "Rst";

end entity mc6809e_cpu;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of mc6809e_cpu is

component mc68a09e
    port (
      E		 		: in std_logic;
      Q		 		: in std_logic;
      nIRQ	 		: in std_logic;
      nFIRQ	 		: in std_logic;
      nNMI	 		: in std_logic;
      nRESET	 	: in std_logic;
      nHALT	 		: in std_logic;
      A 				: out std_logic_vector(15 downto 0);
      D 				: inout std_logic_vector(7 downto 0);
      RnW	 		: out std_logic;
      BS	 			: out std_logic;
      BA	 			: out std_logic;
      AVMA	 		: out std_logic;
      BUSY	 		: out std_logic;
      LIC	 		: out std_logic
    );
end component;

-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Function Declarations
-------------------------------------------------------------------------------

  -------------------  Constant Declaration Section BEGIN -----------------------

  
  -------------------------------------------------------------------------------
  -- Signal and Type Declarations
  -------------------------------------------------------------------------------

	

  -------------------------------------------------------------------------------
  -- Architecture
  -------------------------------------------------------------------------------

begin -- architecture IMP

------------------------------------------------------------------------
-- Instantiate the iMC6809E
------------------------------------------------------------------------

    Inst_MC6809E : mc68a09e
		port map(
			E				=> E,
			Q				=> Q,
			nIRQ			=> nIrq,
			nFIRQ			=> nFirq,
			nNMI			=> nNmi,
			nRESET			=> nReset,
			nHALT			=> nHalt,
			A				=> Address,
			D				=> Data,
			RnW				=> nWriteEnable,
			BS				=> BS,
			BA				=> BA,
			AVMA			=> Avma,
			BUSY			=> Busy,
			LIC				=> Lic);
	 
------------------------------------------------------------------------
    
end IMP;
