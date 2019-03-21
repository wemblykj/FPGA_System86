------------------------------------------------------------------------------
-- system86 - entity/architecture pair
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
-- Filename:          system86
-- Version:           1.00.a
-- Description:       Generic Namco System86 IP.
-- Date:              Sun Mar 17 10:55:45 2019 (by Create and Import Peripheral Wizard)
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
use ieee.numeric_std.all;

-------------------------------------------------------------------------------------
--
--
-- Definition of Ports
-- ACLK             : Synchronous clock
-- ARESETN          : System reset, active low
--
-- M_AXIS_TVALID    : Data out is valid
-- M_AXIS_TDATA     : Data Out
-- M_AXIS_TLAST     : Optional data out qualifier
-- M_AXIS_TREADY    : Connected slave device is ready to accept data out
--
-- S_AXIS_TREADY    : Ready to accept data in
-- S_AXIS_TDATA     :  Data in 
-- S_AXIS_TLAST     : Optional data in qualifier
-- S_AXIS_TVALID    : Data in is valid
--
--
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Entity Section
------------------------------------------------------------------------------

entity system86 is
    generic
    (
	C_EPROM_7116_ADDR_WIDTH = 9;
	C_EPROM_7116_DATA_WIDTH = 4;
	C_EPROM_7124_ADDR_WIDTH = 9;
	C_EPROM_7124_DATA_WIDTH = 8
    )

	port 
	(
		-- Global Ports
		clk_48m	: in	std_logic;
		rst	: in	std_logic;
        
		-- EPROM 3R
		eprom_3r_ce     : in	std_logic;
		eprom_3r_we     : in	std_logic;
		eprom_3r_oe     : in	std_logic;
		eprom_3r_addr   : in	std_logic_vector(C_EPROM_7124_ADDR_WIDTH-1 downto 0);
		eprom_3r_data   : inout	std_logic_vector(C_EPROM_7124_DATA_WIDTH-1 downto 0);
		eprom_3r_data_i : in	std_logic_vector(C_EPROM_7124_DATA_WIDTH-1 downto 0);
		eprom_3r_data_o : out	std_logic_vector(C_EPROM_7124_DATA_WIDTH-1 downto 0);

		-- EPROM 3R
		eprom_3s_ce     : in	std_logic;
		eprom_3s_we     : in	std_logic;
		eprom_3s_oe     : in	std_logic;
		eprom_3s_addr   : in	std_logic_vector(C_EPROM_7116_ADDR_WIDTH-1 downto 0);
		eprom_3s_data   : inout	std_logic_vector(C_EPROM_7116_DATA_WIDTH-1 downto 0);
		eprom_3s_data_i : in	std_logic_vector(C_EPROM_7116_DATA_WIDTH-1 downto 0);
		eprom_3s_data_o : out	std_logic_vector(C_EPROM_7116_DATA_WIDTH-1 downto 0);

	);

attribute SIGIS : string; 
attribute SIGIS of CLK_48M : signal is "Clk"; 

end system86;

------------------------------------------------------------------------------
-- Architecture Section
------------------------------------------------------------------------------

-- In this section, we povide an example implementation of ENTITY system86
-- that does the following:
--
-- 1. Read all inputs
-- 2. Add each input to the contents of register 'sum' which
--    acts as an accumulator
-- 3. After all the inputs have been read, write out the
--    content of 'sum' into the output stream NUMBER_OF_OUTPUT_WORDS times
--
-- You will need to modify this example or implement a new architecture for
-- ENTITY system86 to implement your coprocessor

architecture EXAMPLE of system86 is

begin
   
end architecture EXAMPLE;
