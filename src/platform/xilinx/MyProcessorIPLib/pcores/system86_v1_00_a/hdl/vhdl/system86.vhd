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

library system86;
use system86.cus27.all;

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
		C_USE_HARDWARE_CLOCKS 		: integer	:= 1;
		C_VIDEO_COMPONENT_DEPTH		: integer	:= 8;
		
		C_EPROM_7116_ADDR_WIDTH 	: integer	:= 9;
		C_EPROM_7116_DATA_WIDTH 	: integer	:= 4;
		C_EPROM_7124_ADDR_WIDTH 	: integer	:= 9;
		C_EPROM_7124_DATA_WIDTH 	: integer	:= 8;
		
		C_SRAM_CY6462_ADDR_WIDTH 	: integer	:= 13;
		C_SRAM_CY6462_DATA_WIDTH 	: integer	:= 8
	);
	port 
	(
		-- Global Ports

		reset	: in	std_logic;

		clk_48m	: in	std_logic;
		--gen1: if C_USE_HARDWARE_CLOCKS = 0 generate
			clk_24m	: in	std_logic;
			clk_12m	: in	std_logic;
			clk_6m	: in	std_logic;
		--end generate;
    
		-- Component Video
		vid_clk		: out    std_logic;
		vid_data		: out    std_logic_vector((3*C_VIDEO_COMPONENT_DEPTH)-1 downto 0);
		vid_red		: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_green	: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_blue		: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_hblank	: out    std_logic;
		vid_vblank	: out    std_logic;
		vid_csync	: out    std_logic;
		vid_hsync	: out    std_logic;
		vid_vsync	: out    std_logic;

		-- J4 connector to sub PCB (34 pin)
		conn_j4_reset    : out    std_logic;				-- pin 18 - system reset
		conn_j4_ce		: out    std_logic;				-- pin 4  - sub PCB bus 'chip enable'
		conn_j4_oe       : out    std_logic;				-- pin 14 - output enable (pixel clock x2)
		conn_j4_we       : out    std_logic;				-- pin 33 - r/w
		conn_j4_addr	 : out    std_logic_vector(14 downto 0);	-- address bus
		conn_j4_data	 : out    std_logic_vector(7 downto 0);		-- data bus
		conn_j4_voice    : in     std_logic;				-- pin 1  - audio

		-- J5 connector (20 pin, tile layer expansion?)
		conn_j5_clk_6m        : out    std_logic;
		conn_j5_vreset        : out    std_logic;
		conn_j5_hreset        : out    std_logic;
		conn_j5_clk_48m       : out    std_logic;
		conn_j5_pr            : inout  std_logic_vector(2 downto 0);
		conn_j5_cl            : inout  std_logic_vector(7 downto 0);
		conn_j5_dt            : inout  std_logic_vector(2 downto 0);
		conn_j5_backcolor     : out    std_logic;
		conn_j5_backcolor_t   : in     std_logic;			-- disable backcolor buffer
		conn_j5_clk_6m        : out    std_logic;
		
		-- SRAM 4r
		sram_4r_ce     : in	std_logic;
		sram_4r_we     : in	std_logic;
		sram_4r_oe     : in	std_logic;
		sram_4r_addr   : in	std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0);
		sram_4r_data   : inout	std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0);
		
		-- EPROM 3R
		eprom_3r_ce     : in	std_logic;
		eprom_3r_oe     : in	std_logic;
		eprom_3r_addr   : in	std_logic_vector(C_EPROM_7124_ADDR_WIDTH-1 downto 0);
		eprom_3r_data   : out	std_logic_vector(C_EPROM_7124_DATA_WIDTH-1 downto 0);
		
		-- EPROM 3S
		eprom_3s_ce     : in	std_logic;
		eprom_3s_oe     : in	std_logic;
		eprom_3s_addr   : in	std_logic_vector(C_EPROM_7116_ADDR_WIDTH-1 downto 0);
		eprom_3s_data   : out	std_logic_vector(C_EPROM_7116_DATA_WIDTH-1 downto 0)
		
	);

attribute SIGIS : string; 
attribute SIGIS of clk_48m : signal is "Clk"; 
--gen2: if C_USE_HARDWARE_CLOCKS = 0 generate
	attribute SIGIS of clk_24m : signal is "Clk"; 
	attribute SIGIS of clk_12m : signal is "Clk"; 
	attribute SIGIS of clk_6m : signal is "Clk"; 
--end generate;
attribute SIGIS of reset : signal is "Rst"; 
attribute SIGIS of vid_clk : signal is "Clk"; 

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
	Inst_Cus27: cus27_t
   generic map
	(
		C_USE_HARDWARE_CLOCKS	=> C_USE_HARDWARE_CLOCKS
	)
	port map
	(
		rst			=> rst,
		clk_48m		=> clk_48m,
		clk_6m		=> clk_6m,
--USE_HARDWARE_CLOCKS: if C_USE_HARDWARE_CLOCKS = 0 generate
		clk_24m_o	=> clk_24m_o,
		clk_12m_o	=> clk_12m_o,
		clk_6m_o		=> clk_6m_o,
--end generate
		clk_S2h_o	=> clk_S2h_o
	);
	
end architecture EXAMPLE;
