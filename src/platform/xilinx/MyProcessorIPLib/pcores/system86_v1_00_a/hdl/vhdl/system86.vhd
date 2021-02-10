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
use ieee.std_logic_unsigned.all;

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
		conn_j2_sync		: out    std_logic;
		conn_j2_red			: out    std_logic_vector(3 downto 0);
		conn_j2_green		: out    std_logic_vector(3 downto 0);
		conn_j2_blue		: out    std_logic_vector(3 downto 0);
		
		-- J4 connector to sub PCB (34 pin)
		conn_j4_reset		: out    std_logic;				-- pin 18 - system reset
		conn_j4_ce			: out    std_logic;				-- pin 4  - sub PCB bus 'chip enable'
		conn_j4_oe			: out    std_logic;				-- pin 14 - output enable (pixel clock x2)
		conn_j4_we			: out    std_logic;				-- pin 33 - r/w
		conn_j4_addr	 	: out    std_logic_vector(14 downto 0);	-- address bus
		conn_j4_data		: out    std_logic_vector(7 downto 0);		-- data bus
		conn_j4_voice		: in     std_logic;				-- pin 1  - audio

		-- J5 connector (20 pin, tile layer expansion?)
		--conn_j5_CLK_6M        : out    std_logic;
		--conn_j5_VRESET        : out    std_logic;
		--conn_j5_HRESET        : out    std_logic;
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
		prom_3r_ce     	: out	std_logic;
		prom_3r_addr   	: out	std_logic_vector(C_EPROM_7124_ADDR_WIDTH-1 downto 0);
		prom_3r_data   	: in	std_logic_vector(C_EPROM_7124_DATA_WIDTH-1 downto 0);
		
		-- EPROM 3S
		prom_3s_ce     	: out	std_logic;
		prom_3s_addr   	: out	std_logic_vector(C_EPROM_7116_ADDR_WIDTH-1 downto 0);
		prom_3s_data   	: in	std_logic_vector(C_EPROM_7116_DATA_WIDTH-1 downto 0)
		
	);

attribute SIGIS : string; 
attribute SIGIS of reset : signal is "Rst"; 

attribute SIGIS of CLK_48M : signal is "Clk"; 

--attribute SIGIS of CLK_6M : signal is "Clk"; 

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

--
-- global signals
--

-- timing subsystem outputs
signal CLK_24M		: std_logic;
signal CLK_12M		: std_logic;
signal CLK_6M		: std_logic;
signal CLK_6MD		: std_logic;

signal nHSYNC		: std_logic;
signal nVSYNC		: std_logic;
signal nVBLANK		: std_logic;
signal nHBLANK		: std_logic;	-- used for simulation only
signal BLANKING	: std_logic;
signal nHRESET		: std_logic;
signal nVRESET		: std_logic;
signal SYNC			: std_logic;
signal RED			: std_logic_vector(3 downto 0);
signal GREEN		: std_logic_vector(3 downto 0);
signal BLUE			: std_logic_vector(3 downto 0);

signal CLK_8V		: std_logic;
signal CLK_4V		: std_logic;
signal CLK_1V		: std_logic;
signal CLK_4H		: std_logic;
signal CLK_2H		: std_logic;
signal CLK_1H		: std_logic;
signal CLK_S2H		: std_logic;
signal CLK_S1H		: std_logic;

signal dot_lsb_acc	: std_logic_vector(15 downto 0) := "0000000000000000";
signal dot_msb_acc	: std_logic_vector(15 downto 0) := "0000000000000000";
signal DOT			: std_logic_vector(7 downto 0) := "00000000";
signal BANK			: std_logic := '0';

--
-- internal signals
--

signal vid_active			: std_logic;
signal vid_active_col	: std_logic_vector(9 downto 0);
signal vid_active_row	: std_logic_vector(9 downto 0);
signal vidgen_pattern	: std_logic_vector(3 downto 0) := "0001";

signal tpg_pattern		: std_logic_vector(3 downto 0) := "0000"; --"0101";	-- 0110 black recangle with white border
--signal tpg_pattern		: std_logic_vector(3 downto 0) := "0101";	-- 0110 black recangle with white border
signal tpg_red				: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
signal tpg_green			: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
signal tpg_blue			: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
signal tpg_hsync			: std_logic;
signal tpg_vsync			: std_logic;
signal tpg_hblank			: std_logic;
signal tpg_vblank			: std_logic;

component timing_subsystem
port(
	-- simulation control
	reset 		: in std_logic := '0';
	enable 		: in std_logic := '1';
	
	-- input clocks
	CLK_48M 		: in std_logic;
	
	-- soft generated clocks
	CLK_24M		: out std_logic;
	CLK_12M		: out std_logic;
	CLK_6M 		: out std_logic;
	CLK_6MD 		: out std_logic;
	
	-- video synchronisation
	nVSYNC			: out std_logic;
	nHSYNC			: out std_logic;
	nHBLANK		: out std_logic;	-- used for simulation only
	nVBLANK		: out std_logic;
	nVRESET		: out std_logic;
	nHRESET		: out std_logic;
	BLANKING		: out std_logic;
	nCOMPSYNC		: out std_logic;
	
	-- video clocks
	CLK_8V	: out std_logic;
	CLK_4V	: out std_logic;
	CLK_1V	: out std_logic;
	CLK_4H	: out std_logic;
	CLK_2H	: out std_logic;
	CLK_1H	: out std_logic;
	CLK_S2H	: out std_logic;
	CLK_S1H	: out std_logic
);
end component;

component videogen_subsystem
port(
	-- simulation control
	reset 			: in std_logic := '0';
	enable 			: in std_logic := '1';
	
	-- input clocks
	CLK_6MD 			: in std_logic;
	nCLR				: in std_logic := '1';
	D					: in std_logic_vector(7 downto 0) := "00000000";
	BANK				: in std_logic;
	
	prom_3r_ce		: out std_logic;
	prom_3r_oe		: out std_logic;
	prom_3r_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_3r_data	: in  std_logic_vector(7 downto 0) := "00000000";
	
	prom_3s_ce		: out std_logic;
	prom_3s_oe		: out std_logic;
	prom_3s_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_3s_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	prom_4v_ce		: out std_logic;
	prom_4v_oe		: out std_logic;
	prom_4v_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_4v_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	prom_5v_ce		: out std_logic;
	prom_5v_oe		: out std_logic;
	prom_5v_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_5v_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	prom_6u_ce		: out std_logic;
	prom_6u_oe		: out std_logic;
	prom_6u_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_6u_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	prom_7s_ce		: out std_logic;
	prom_7s_oe		: out std_logic;
	prom_7s_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_7s_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	prom_9c_ce		: out std_logic;
	prom_9c_oe		: out std_logic;
	prom_9c_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_9c_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	prom_12c_ce		: out std_logic;
	prom_12c_oe		: out std_logic;
	prom_12c_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_12c_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	sram_3f_ce		: out std_logic;
	sram_3f_oe		: out std_logic;
	sram_3f_we		: out std_logic;
	sram_3f_addr	: out std_logic_vector(8 downto 0) := "000000000";
	sram_3f_data  : in  std_logic_vector(3 downto 0) := "0000";
	
	sram_4n_ce		: out std_logic;
	sram_4n_oe		: out std_logic;
	sram_4n_we		: out std_logic;
	sram_4n_addr	: out std_logic_vector(8 downto 0) := "000000000";
	sram_4n_data  : in  std_logic_vector(3 downto 0) := "0000";

	sram_4r_ce		: out std_logic;
	sram_4r_oe		: out std_logic;
	sram_4r_we		: out std_logic;
	sram_4r_addr	: out std_logic_vector(8 downto 0) := "000000000";
	sram_4r_data  : in  std_logic_vector(3 downto 0) := "0000";

	sram_7n_ce		: out std_logic;
	sram_7n_oe		: out std_logic;
	sram_7n_we		: out std_logic;
	sram_7n_addr	: out std_logic_vector(8 downto 0) := "000000000";
	sram_7n_data  : in  std_logic_vector(3 downto 0) := "0000";

	sram_10m_ce		: out std_logic;
	sram_10m_oe		: out std_logic;
	sram_10m_we		: out std_logic;
	sram_10m_addr	: out std_logic_vector(8 downto 0) := "000000000";
	sram_10m_data  : in  std_logic_vector(3 downto 0) := "0000";

	sram_11k_ce		: out std_logic;
	sram_11k_oe		: out std_logic;
	sram_11k_we		: out std_logic;
	sram_11k_addr	: out std_logic_vector(8 downto 0) := "000000000";
	sram_11k_data  : in  std_logic_vector(3 downto 0) := "0000";

	SYNC				: out std_logic;
	RED				: out std_logic_vector(3 downto 0);
	GREEN				: out std_logic_vector(3 downto 0);
	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

component Blanking_To_Count
generic(
	ACTIVE_COLS  		: integer := 640;
   ACTIVE_ROWS  		: integer := 480
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_HSync : in std_logic;
   i_VSync : in std_logic;
	i_HBlank : in std_logic;
   i_VBlank : in std_logic;
	o_Locked : out std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
	o_Active : out std_logic;
   o_Col_Count  : out std_logic_vector(9 downto 0);
   o_Row_Count  : out std_logic_vector(9 downto 0)
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
	SYNC				: out std_logic;
	RED				: out std_logic_vector(3 downto 0);
	GREEN				: out std_logic_vector(3 downto 0);
	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

component Blanking_To_Count
generic(
	ACTIVE_COLS  		: integer := 640;
   ACTIVE_ROWS  		: integer := 480
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_HSync : in std_logic;
   i_VSync : in std_logic;
	i_HBlank : in std_logic;
   i_VBlank : in std_logic;
	o_Locked : out std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
	o_Active : out std_logic;
   o_Col_Count  : out std_logic_vector(9 downto 0);
   o_Row_Count  : out std_logic_vector(9 downto 0)
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
	SYNC				: out std_logic;
	RED				: out std_logic_vector(3 downto 0);
	GREEN				: out std_logic_vector(3 downto 0);
	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

component Blanking_To_Count
generic(
	ACTIVE_COLS  		: integer := 640;
   ACTIVE_ROWS  		: integer := 480
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_HSync : in std_logic;
   i_VSync : in std_logic;
	i_HBlank : in std_logic;
   i_VBlank : in std_logic;
	o_Locked : out std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
	o_Active : out std_logic;
   o_Col_Count  : out std_logic_vector(9 downto 0);
   o_Row_Count  : out std_logic_vector(9 downto 0)
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
	SYNC				: out std_logic;
	RED				: out std_logic_vector(3 downto 0);
	GREEN				: out std_logic_vector(3 downto 0);
	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

component Blanking_To_Count
generic(
	ACTIVE_COLS  		: integer := 640;
   ACTIVE_ROWS  		: integer := 480
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_HSync : in std_logic;
   i_VSync : in std_logic;
	i_HBlank : in std_logic;
   i_VBlank : in std_logic;
	o_Locked : out std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
	o_Active : out std_logic;
   o_Col_Count  : out std_logic_vector(9 downto 0);
   o_Row_Count  : out std_logic_vector(9 downto 0)
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
	SYNC				: out std_logic;
	RED				: out std_logic_vector(3 downto 0);
	GREEN				: out std_logic_vector(3 downto 0);
	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

component Blanking_To_Count
generic(
	ACTIVE_COLS  		: integer := 640;
   ACTIVE_ROWS  		: integer := 480
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_HSync : in std_logic;
   i_VSync : in std_logic;
	i_HBlank : in std_logic;
   i_VBlank : in std_logic;
	o_Locked : out std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
	o_Active : out std_logic;
   o_Col_Count  : out std_logic_vector(9 downto 0);
   o_Row_Count  : out std_logic_vector(9 downto 0)
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
	SYNC				: out std_logic;
	RED				: out std_logic_vector(3 downto 0);
	GREEN				: out std_logic_vector(3 downto 0);
	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

component Blanking_To_Count
generic(
	ACTIVE_COLS  		: integer := 640;
   ACTIVE_ROWS  		: integer := 480
);
port (
	i_Clk : in std_logic;
	i_Rst : in std_logic;
   i_HSync : in std_logic;
   i_VSync : in std_logic;
	i_HBlank : in std_logic;
   i_VBlank : in std_logic;
	o_Locked : out std_logic;
   o_HSync : out std_logic;
   o_VSync : out std_logic;
	o_HBlank : out std_logic;
   o_VBlank : out std_logic;
	o_Active : out std_logic;
   o_Col_Count  : out std_logic_vector(9 downto 0);
   o_Row_Count  : out std_logic_vector(9 downto 0)
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
   o_Red_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0);
   o_Grn_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0);
   o_Blu_Video  : out std_logic_vector(COMPONENT_DEPTH-1 downto 0)
);
end component;

begin

	timing_subsys: timing_subsystem
   port map
	(
		-- simulation control
		reset			=> reset,
		enable		=> enable,
		
		-- input clocks
		CLK_48M		=> CLK_48M,
		
		-- soft generated clocks
		CLK_24M		=> CLK_24M,
		CLK_12M		=> CLK_12M,
		CLK_6M		=> CLK_6M,
		CLK_6MD		=> CLK_6MD,
		
		-- video synchronisation
		nHSYNC 		=> nHSYNC,
		nVSYNC 		=> nVSYNC,
		nHBLANK		=> nHBLANK,	-- artistic licence - brought out for simulation
		nVBLANK		=> nVBLANK,
		BLANKING		=> BLANKING,
		nHRESET 		=> nHRESET,
		nVRESET 		=> nVRESET,
		
		-- video timings
		CLK_8V	=> CLK_8V,
		CLK_4V	=> CLK_4V,
		CLK_1V	=> CLK_1V,
		CLK_4H	=> CLK_4H,
		CLK_2H	=> CLK_2H,
		CLK_1H	=> CLK_1H,
		CLK_S2H	=> CLK_S2H,
		CLK_S1H	=> CLK_S1H
	);
	
	videogen_subsys: videogen_subsystem
   port map
	(
		-- simulation reset
		reset			=> reset,
		enable		=> enable,
		
		-- input clocks
		CLK_6MD		=> CLK_6MD,
		nCLR			=> '1',
		D				=> DOT,
		BANK			=> BANK,
		RED			=> RED,
		GREEN			=> GREEN,
		BLUE			=> BLUE,
		
		prom_3r_ce		=> prom_3r_ce,
		prom_3r_addr 	=> prom_3r_addr,
		prom_3r_data 	=> prom_3r_data,
		
		prom_3s_ce		=> prom_3s_ce,
		prom_3s_addr 	=> prom_3s_addr,
		prom_3s_data 	=> prom_3s_data
	);
	
	--
	-- Testing
	--
	
	InstBlankingToCount: Blanking_To_Count
	generic map
	(
		ACTIVE_COLS  		=> 288,
		ACTIVE_ROWS  		=> 224
	)
	port map
	(
		i_Clk 			=> CLK_6M,
		i_Rst				=> reset,
		i_HSync 			=> nHSYNC,
		i_VSync 			=> nVSYNC,
		i_HBlank 		=> nHBLANK,
		i_VBlank 		=> nVBLANK,
		o_Active			=> vid_active,
		o_Col_Count		=> vid_active_col,
		o_Row_Count		=> vid_active_row
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
		i_Clk 			=> CLK_6M,
		i_Rst				=> reset,
		i_Pattern 		=> tpg_pattern,
		i_HSync 			=> nHSYNC,
		i_VSync 			=> nVSYNC,
		o_HSync 			=> tpg_hsync,
		o_VSync 			=> tpg_vsync,
		o_HBlank			=> tpg_hblank,
		o_VBlank			=> tpg_vblank,
		o_Red_Video  	=> tpg_red(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4),
		o_Grn_Video  	=> tpg_green(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4),
		o_Blu_Video		=> tpg_blue(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4)
	);
	
	process(CLK_6M)
	begin
		if falling_edge(CLK_6M) then
			if vidgen_pattern /= "0000" then
				if vid_active_row(8 downto 0) = "001110000" then
					BANK <= '1';
				elsif vid_active_row(8 downto 0) = "000000000" then
					BANK <= '0';
				end if;			
				
				if vid_active /= '0' then
					DOT <= dot_msb_acc(15 downto 13) & dot_lsb_acc(15 downto 11);
					
					if (vid_active_col = 287) then
						dot_lsb_acc <= "0000000000000000";
						dot_msb_acc <= dot_msb_acc + 590;
					else
						dot_lsb_acc <= dot_lsb_acc + 228;
					end if;
					
					if (vid_active_row = 111 or vid_active_row = 223) then
						dot_lsb_acc <= "0000000000000000";
						dot_msb_acc <= "0000000000000000";
					end if;
				else
					DOT <= "00000000";
				end if;
			end if;
		elsif rising_edge(CLK_6M) then
			if tpg_pattern /= "0000" then
				vid_hsync 	<= tpg_hsync;
				vid_vsync 	<= tpg_vsync;
				vid_hblank 	<= tpg_hblank;
				vid_vblank 	<= tpg_vblank;
				vid_red 		<= tpg_red;
				vid_green 	<= tpg_green;
				vid_blue 	<= tpg_blue;
			else
				vid_hsync 	<= nHSYNC;
				vid_vsync 	<= nVSYNC;
				vid_hblank 	<= nHBLANK;
				vid_vblank 	<= nVBLANK;
				vid_red 		<= RED;
				vid_green 	<= GREEN;
				vid_blue 	<= BLUE;				
			end if;
		end if;
		
		vid_clk <= CLK_6M;
	end process;
	
	--
	-- assign connection outputs
	--
	
	-- video
	conn_j2_sync <= SYNC;
	conn_j2_red <= RED;
	conn_j2_green <= GREEN;
	conn_j2_blue <= BLUE;
	
end architecture rtl;
