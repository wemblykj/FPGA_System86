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
		--
		-- simulation
		--
		
		-- simulation control
		reset 				: in std_logic;					-- hard reset the simulation
		enable 				: in std_logic;					-- enable the simulation

		-- simulation video
		vid_clk				: out    std_logic;
		vid_data				: out    std_logic_vector((3*C_VIDEO_COMPONENT_DEPTH)-1 downto 0);
		vid_red				: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_green			: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_blue				: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_hsync			: out    std_logic;
		vid_vsync			: out    std_logic;
		vid_hblank			: out    std_logic;
		vid_vblank			: out    std_logic;
		
		-- simulation generated  system clock
		CLK_48M				: in	std_logic;					-- 49.152 MHz system clock
		
		--
		-- System 86 external connectors
		--
		
		-- System 86 native video (albeit 4-bit digital equivalent before resister ladder conversion)
		SYNC					: out    std_logic;
		RED					: out    std_logic_vector(3 downto 0);
		GREEN					: out    std_logic_vector(3 downto 0);
		BLUE					: out    std_logic_vector(3 downto 0);

		-- J4 connector to sub PCB (34 pin)
		conn_j4_reset		: out    std_logic;				-- pin 18 - system reset
		conn_j4_ce			: out    std_logic;				-- pin 4  - sub PCB bus 'chip enable'
		conn_j4_oe			: out    std_logic;				-- pin 14 - output enable (pixel clock x2)
		conn_j4_we			: out    std_logic;				-- pin 33 - r/w
		conn_j4_addr	 	: out    std_logic_vector(14 downto 0);	-- address bus
		conn_j4_data		: out    std_logic_vector(7 downto 0);		-- data bus
		conn_j4_voice		: in     std_logic;				-- pin 1  - audio

		-- J5 connector (20 pin, tile layer expansion?)
		--conn_j5_clk_6m        : out    std_logic;
		--conn_j5_vreset        : out    std_logic;
		--conn_j5_hreset        : out    std_logic;
		--conn_j5_CLK_48M       : out    std_logic;
		--conn_j5_pr            : inout  std_logic_vector(2 downto 0);
		--conn_j5_cl            : inout  std_logic_vector(7 downto 0);
		--conn_j5_dt            : inout  std_logic_vector(2 downto 0);
		--conn_j5_backcolor     : out    std_logic;
		--conn_j5_backcolor_t   : in     std_logic;			-- disable backcolor buffer
		
		--
		-- pluggable chips 
		-- (imagine the board has been socketed and the chips are simply external modules with independent busses!)
		--
		
		-- SRAM 4r
		sram_4r_ce     	: in	std_logic;
		sram_4r_we     	: in	std_logic;
		sram_4r_oe     	: in	std_logic;
		sram_4r_addr   	: in	std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0);
		sram_4r_data   	: inout	std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0);
		
		-- EPROM 3R
		eprom_3r_ce     	: in	std_logic;
		eprom_3r_oe     	: in	std_logic;
		eprom_3r_addr   	: in	std_logic_vector(C_EPROM_7124_ADDR_WIDTH-1 downto 0);
		eprom_3r_data   	: out	std_logic_vector(C_EPROM_7124_DATA_WIDTH-1 downto 0);
		
		-- EPROM 3S
		eprom_3s_ce     	: in	std_logic;
		eprom_3s_oe     	: in	std_logic;
		eprom_3s_addr   	: in	std_logic_vector(C_EPROM_7116_ADDR_WIDTH-1 downto 0);
		eprom_3s_data   	: out	std_logic_vector(C_EPROM_7116_DATA_WIDTH-1 downto 0)
		
	);

attribute SIGIS : string; 
attribute SIGIS of reset : signal is "Rst"; 

attribute SIGIS of CLK_48M : signal is "Clk"; 

--attribute SIGIS of clk_6m : signal is "Clk"; 

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

architecture rtl of system86 is

-- timing subsystem outputs
signal clk_24m		: std_logic;
signal clk_12m		: std_logic;
signal clk_6m		: std_logic;

signal hsync		: std_logic;
signal vsync		: std_logic;
signal vblank		: std_logic;
signal blanking	: std_logic;
signal hreset		: std_logic;
signal vreset		: std_logic;

signal clk_8v		: std_logic;
signal clk_4v		: std_logic;
signal clk_1v		: std_logic;
signal clk_4h		: std_logic;
signal clk_2h		: std_logic;
signal clk_1h		: std_logic;
signal clk_s2h		: std_logic;
signal clk_s1h		: std_logic;

signal tpg_pattern		: std_logic_vector(3 downto 0) := "0101";	-- 0110 black recangle with white border
signal tpg_RED				: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
signal tpg_green			: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
signal tpg_blue			: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
signal tpg_hsync			: std_logic;
signal tpg_vsync			: std_logic;
signal tpg_hblank			: std_logic;
signal tpg_vblank			: std_logic;

component timing_subsystem
port(
	-- simulation control
	reset 			: in std_logic;
	enable 			: in std_logic;
	
	-- input clocks
	CLK_48M 		: in std_logic;
	
	-- soft generated clocks
	CLK_24M		: out std_logic;
	CLK_12M		: out std_logic;
	CLK_6M 		: out std_logic;
	
	-- video synchronisation
	VSYNC			: out std_logic;
	HSYNC			: out std_logic;
	VBLANK		: out std_logic;
	VRESET		: out std_logic;
	HRESET		: out std_logic;
	BLANKING		: out std_logic;
	COMPSYNC		: out std_logic;
	
	-- video clocks
	CLK_8V	: out std_logic;
	CLK_4V	: out std_logic;
	CLK_1V	: out std_logic;
	CLK_4H	: out std_logic;
	CLK_2H	: out std_logic;
	CLK_1H	: out std_logic;
	CLK_s2H	: out std_logic;
	CLK_s1H	: out std_logic
);
end component;
	
component Test_Pattern_Gen
generic(
	COMPONENT_DEPTH 		: integer := 3;
   TOTAL_COLS  		: integer := 384;
   TOTAL_ROWS   		: integer := 264;
   ACTIVE_COLS  		: integer := 288;
   ACTIVE_ROWS  		: integer := 224;
	USE_BLANKING  		: integer := 1;
	SYNC_PULSE_HORZ  	: integer := 32;
	SYNC_PULSE_VERT  	: integer := 8;
	FRONT_PORCH_HORZ  : integer := 32;
	BACK_PORCH_HORZ   : integer := 32;
	FRONT_PORCH_VERT  : integer := 8;
	BACK_PORCH_VERT   : integer := 24
	
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_Pattern : in std_logic_vector(3 downto 0);
   i_HSync : in std_logic;
   i_VSync : in std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
   o_RED_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0);
   o_Grn_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0);
   o_Blu_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0)
);

end component;
begin

	timing_subsys: timing_subsystem
   port map
	(
		-- simulation reset
		reset			=> reset,
		enable		=> enable,
		
		-- input clocks
		CLK_48M		=> CLK_48M,
		
		-- soft generated clocks
		CLK_24M		=> clk_24m,
		CLK_12M		=> clk_12m,
		CLK_6M		=> clk_6m,
		
		-- video synchronisation
		HSYNC 		=> hsync,
		VSYNC 		=> vsync,
		VBLANK		=> vblank,
		BLANKING		=> blanking,
		
		-- pixel clocks
		CLK_8V	=> clk_8v,
		CLK_4V	=> clk_4v,
		CLK_1V	=> clk_1v,
		CLK_4H	=> clk_4h,
		CLK_2H	=> clk_2h,
		CLK_1H	=> clk_1h,
		CLK_S2H	=> clk_s2h,
		CLK_S1H	=> clk_s1h
	);
	
	Inst_Test_Pattern_Gen: Test_Pattern_Gen
	generic map
	(
		COMPONENT_DEPTH 	=> 4,
		USE_BLANKING		=> 1,
		TOTAL_COLS  		=> 384,
		TOTAL_ROWS   		=> 288,
		ACTIVE_COLS  		=> 288,
		ACTIVE_ROWS  		=> 224
	)
	port map
	(
		i_Clk 			=> clk_6m,
		i_Rst				=> reset,
		i_Pattern 		=> tpg_pattern,
		i_HSync 			=> hsync,
		i_VSync 			=> vsync,
		o_HSync 			=> tpg_hsync,
		o_VSync 			=> tpg_vsync,
		o_HBlank			=> tpg_hblank,
		o_VBlank			=> tpg_vblank,
		o_RED_Video  	=> tpg_RED(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4),
		o_Grn_Video  	=> tpg_green(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4),
		o_Blu_Video		=> tpg_blue(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4)
	);
	
	vid_clk <= clk_6m;
	vid_hsync <= tpg_hsync;
	vid_vsync <= tpg_vsync;
	vid_hblank <= tpg_hblank;
	vid_vblank <= tpg_vblank;
	vid_red <= tpg_RED;
	vid_green <= tpg_green;
	vid_blue <= tpg_blue;
	
end architecture rtl;
