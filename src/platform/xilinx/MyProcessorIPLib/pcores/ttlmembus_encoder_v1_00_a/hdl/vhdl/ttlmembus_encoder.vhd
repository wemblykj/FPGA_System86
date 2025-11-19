------------------------------------------------------------------------------
-- ttlmembus_encoder.vhd - entity/architecture pair
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
-- Filename:          ttlmembus_encoder.vhd
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use std.textio.all;

-------------------------------------------------------------------------------
-- ttlmembus_encoder_v1_00_a library is used for ttlmembus_encoder component declarations
-------------------------------------------------------------------------------

library ttlmembus_encoder_v1_00_a;


-------------------------------------------------------------------------------
--                     Defination of Generics :                              --
-------------------------------------------------------------------------------

-- C_FAMILY               -- XILINX FPGA family
-- C_INSTANCE             -- Instance name ot the core in the EDK system

--
-- Definition of Ports:
--
-------------------------------------------------------------------------------
--                  Defination of Ports                                      --
-------------------------------------------------------------------------------

------------------------------------------------------------------------------

entity ttlmembus_encoder is
  generic (
	-- ROM generics
	C_CTRL_WIDTH : integer range 1 to 3 := 3;
	C_ADDR_WIDTH : integer range 4 to 16 := 16;
	C_DATA_WIDTH : integer range 4 to 8 := 8;
	
	--Family Generics
	C_XLNX_REF_BOARD : string := "NONE";
	C_FAMILY : string := "virtex6";
	C_INSTANCE : string := "ttlmembus_encoder_inst"
  );
  port (
	-- ROM ports
	nChipEnable	: out std_logic;
	nOutputEnable	: out std_logic;
	nWriteEnable	: out std_logic;
	Address		: out std_logic_vector((C_ADDR_WIDTH - 1) downto 0);
	Data		: inout std_logic_vector((C_DATA_WIDTH - 1) downto 0);

    	-- TTL Line Interface
	nCE	: in std_logic;
	nOE	: in std_logic;
	nWE	: in std_logic;
	A	: in std_logic_vector((C_ADDR_WIDTH - 1) downto 0);
	D_I	: in std_logic_vector((C_DATA_WIDTH - 1) downto 0);
	D_O	: out std_logic_vector((C_DATA_WIDTH - 1) downto 0);
	D	: inout std_logic  
  );

  -------------------------------------------------------------------------------
  -- fan-out attributes for XST
  -------------------------------------------------------------------------------

  attribute MAX_FANOUT : string;
  
  -------------------------------------------------------------------------------
  -- Attributes for MPD file
  -------------------------------------------------------------------------------
  attribute IP_GROUP : string;
  attribute IP_GROUP of ttlmembus_encoder : entity is "LOGICORE";
  attribute SIGIS : string;

end entity ttlmembus_encoder;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of ttlmembus_encoder is

-------------------------------------------------------------------------------
-- constant added for webtalk information
-------------------------------------------------------------------------------
function chr(sl: std_logic) return character is
    variable c: character;
    begin
      case sl is
         when '0' => c:= '0';
         when '1' => c:= '1';
         when 'Z' => c:= 'Z';
         when 'U' => c:= 'U';
         when 'X' => c:= 'X';
         when 'W' => c:= 'W';
         when 'L' => c:= 'L';
         when 'H' => c:= 'H';
         when '-' => c:= '-';
      end case;
    return c;
   end chr;

function str(slv: std_logic_vector) return string is
     variable result : string (1 to slv'length);
     variable r : integer;
   begin
     r := 1;
     for i in slv'range loop
        result(r) := chr(slv(i));
        r := r + 1;
     end loop;
     return result;
   end str;

  constant C_CORE_GENERATION_INFO : string := C_INSTANCE & ",ttlmembus_encoder,{"
    & "C_FAMILY = "              &  C_FAMILY
    & ",C_INSTANCE = "           &  C_INSTANCE
	 & ",C_CTRL_WIDTH = "         & integer'image(C_CTRL_WIDTH)
    & ",C_ADDR_WIDTH = "         & integer'image(C_ADDR_WIDTH)
    & ",C_DATA_WIDTH = "         & integer'image(C_DATA_WIDTH)
    & "}";

  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of imp : architecture is C_CORE_GENERATION_INFO;

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

	nChipEnable	<=	nCE;
	nOutputEnable	<=	nOE;
  	nWriteEnable	<=	nWE;			 
	Address		<=	A;
	Data		<= 	D_I when nCE = '0' and nWE = '0' else (others => 'Z');
	D_O		<=	Data when nCE = '0' and nOE = '0' else (others => 'Z');
	 
end imp;
