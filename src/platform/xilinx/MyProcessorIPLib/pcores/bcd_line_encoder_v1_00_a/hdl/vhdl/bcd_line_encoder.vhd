------------------------------------------------------------------------------
-- bcd_line_encoder.vhd - entity/architecture pair
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
-- Filename:          bcd_line_encoder.vhd
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
-- bcd_line_encoder_v1_00_a library is used for bcd_line_encoder component declarations
-------------------------------------------------------------------------------

library bcd_line_encoder_v1_00_a;


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

entity bcd_line_encoder is
  generic (
	-- generics
	C_BCD_WIDTH : integer range 1 to 3 := 2;
	
	--Family Generics
	C_XLNX_REF_BOARD : string := "NONE";
	C_FAMILY : string := "virtex6";
	C_INSTANCE : string := "bcd_line_encoder_inst"
  );
  port (
	Y0		: in std_logic;
	Y1		: in std_logic;
	Y2		: in std_logic;
	Y3		: in std_logic;
	Y4		: in std_logic;
	Y5		: in std_logic;
	Y6		: in std_logic;
	Y7		: in std_logic;
	A		: out std_logic_vector(C_BCD_WIDTH - 1 downto 0)
  );

  -------------------------------------------------------------------------------
  -- fan-out attributes for XST
  -------------------------------------------------------------------------------

  attribute MAX_FANOUT : string;
  
  -------------------------------------------------------------------------------
  -- Attributes for MPD file
  -------------------------------------------------------------------------------
  attribute IP_GROUP : string;
  attribute IP_GROUP of bcd_line_encoder : entity is "LOGICORE";
  attribute SIGIS : string;

end entity bcd_line_encoder;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of bcd_line_encoder is

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

  constant C_CORE_GENERATION_INFO : string := C_INSTANCE & ",bcd_line_encoder,{"
    & "C_FAMILY = "              &  C_FAMILY
    & ",C_INSTANCE = "           &  C_INSTANCE
    & ",C_BCD_WIDTH = "          & integer'image(C_BCD_WIDTH)
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

	signal in_1 : std_logic;
	signal in_12 : std_logic_vector(1 downto 0);
	signal in_123 : std_logic_vector(2 downto 0);
	signal in_1234 : std_logic_vector(3 downto 0);
	
  -------------------------------------------------------------------------------
  -- Architecture
  -------------------------------------------------------------------------------

begin -- architecture IMP

	in_1 <= Y0;
	
	G_IN_2 : if C_BCD_WIDTH >= 2 generate
	begin
		process(Y1)
		begin
			if Y1 = '1' then
				in_12 <= "10";
			else
				in_12 <= '0' & in_1;
			end if;
		end process;
	end generate G_IN_2;

	G_IN_34 : if C_BCD_WIDTH >= 3 generate
	begin
		process(Y3, Y2)
		begin
			if Y3 = '1' then
				in_123 <= "100";
			elsif Y2 = '1' then
				in_123 <= "011";
			else
				in_123 <= '0' & in_12;
			end if;
		end process;
	end generate G_IN_34;

	G_IN_5678 : if C_BCD_WIDTH >= 4 generate 
	begin
		process(Y7, Y6, Y5, Y4)
		begin
			if Y7 = '1' then
				in_1234 <= "1000";
			elsif Y6 = '1' then
				in_1234 <= "0111";
			elsif Y5 = '1' then
				in_1234 <= "0110";
			elsif Y4 = '1' then
				in_1234 <= "0101";
			else
				in_1234 <= '0' & in_123;
			end if;
		end process;
	end generate G_IN_5678;
	 
	G_OUT_1 : if C_BCD_WIDTH = 1 generate
		A(0) <= in_1;
	end generate G_OUT_1;
	
	G_OUT_12 : if C_BCD_WIDTH = 2 generate
		A(1 downto 0) <= in_12;
	end generate G_OUT_12;
	
	G_OUT_123 : if C_BCD_WIDTH = 3 generate
		A(2 downto 0) <= in_123;
	end generate G_OUT_123;
	
	G_OUT_1234 : if C_BCD_WIDTH = 4 generate
		A(3 downto 0) <= in_1234;
	end generate G_OUT_1234;
	
end imp;
