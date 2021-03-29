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

-------------------------------------------------------------------------------
-- system86_v1_00_a library is used for system86 component declarations
-------------------------------------------------------------------------------

library system86_v1_00_a;  

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
		--Family Generics
		C_XLNX_REF_BOARD              : string  := "NONE";
		C_FAMILY               : string                         := "virtex6";
		C_INSTANCE             : string                         := "system86_inst";

		--  -- System Parameter		
		C_USE_HARDWARE_CLOCKS		: integer 	:= 0;
		C_VIDEO_COMPONENT_DEPTH		: integer	:= 8;
		
--		C_EPROM_M27512_ADDR_WIDTH 	: integer	:= 16;
--		C_EPROM_M27512_DATA_WIDTH 	: integer	:= 8;
--		C_EPROM_M27256_ADDR_WIDTH 	: integer	:= 15;
--		C_EPROM_M27256_DATA_WIDTH 	: integer	:= 8;
--		C_EPROM_MB7138_ADDR_WIDTH 	: integer	:= 11;
--		C_EPROM_MB7138_DATA_WIDTH 	: integer	:= 8;
		C_EPROM_MB7124_ADDR_WIDTH 	: integer	:= 9;
		C_EPROM_MB7124_DATA_WIDTH 	: integer	:= 8;
--		C_EPROM_MB7116_ADDR_WIDTH 	: integer	:= 9;
--		C_EPROM_MB7116_DATA_WIDTH 	: integer	:= 4;
--		C_EPROM_MB7112_ADDR_WIDTH 	: integer	:= 4;
--		C_EPROM_MB7112_DATA_WIDTH 	: integer	:= 8;
--		
		C_SRAM_CY6462_ADDR_WIDTH 	: integer	:= 13;
		C_SRAM_CY6462_DATA_WIDTH 	: integer	:= 8
	);
	port 
	(
		--
		-- simulation
		--
		
		-- simulation control
		rst_n 					: in std_logic;					-- hard reset the simulation
		--enable 				: in std_logic := 1;				-- enable the simulation

		-- simulation video
		vid_clk				: out    std_logic;
		vid_data				: out    std_logic_vector((3*C_VIDEO_COMPONENT_DEPTH)-1 downto 0);
		vid_red				: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_green			: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_blue				: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
		vid_csync			: out    std_logic;
		vid_hsync			: out    std_logic;
		vid_vsync			: out    std_logic;
		vid_hblank			: out    std_logic;
		vid_vblank			: out    std_logic;
		
		-- simulation generated  system clock
		CLK_48M				: in	std_logic;					-- 49.152 MHz system clock
		
		--CLK_24M_ext			: in	std_logic;					-- 49.152 MHz system clock
		--CLK_12M_ext			: in	std_logic;					-- 49.152 MHz system clock
		--CLK_6M_ext				: in	std_logic;					-- 49.152 MHz system clock
		
		--
		-- System 86 external connectors
		--
		
		-- System 86 native video (albeit 4-bit digital equivalent before resister ladder conversion)
		conn_j2_sync		: out    std_logic;
		conn_j2_red			: out    std_logic_vector(3 downto 0);
		conn_j2_green		: out    std_logic_vector(3 downto 0);
		conn_j2_blue		: out    std_logic_vector(3 downto 0);
--		
--		-- J4 connector to sub PCB (34 pin)
--		conn_j4_reset		: out    std_logic;				-- pin 18 - system reset
--		conn_j4_ce			: out    std_logic;				-- pin 4  - sub PCB bus 'chip enable'
--		conn_j4_oe			: out    std_logic;				-- pin 14 - output enable (pixel clock x2)
--		conn_j4_we			: out    std_logic;				-- pin 33 - r/w
--		conn_j4_addr	 	: out    std_logic_vector(14 downto 0);	-- address bus
--		conn_j4_data_T		: out    std_logic;				-- data bus
--		conn_j4_data_O		: out    std_logic_vector(7 downto 0);		-- data bus
--		conn_j4_data_I		: in     std_logic_vector(7 downto 0);		-- data bus
--		conn_j4_voice		: in     std_logic;				-- pin 1  - audio

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
		
		prom_3r_ce	: out std_logic;
		prom_3r_oe	: out std_logic;
		prom_3r_addr	: out std_logic_vector(C_EPROM_MB7124_ADDR_WIDTH-1 downto 0) := "000000000";
		--prom_3r_data_T	: out std_logic;
		prom_3r_data	: in  std_logic_vector(C_EPROM_MB7124_DATA_WIDTH-1 downto 0) := "00000000";
		--prom_3r_data_O	: out  std_logic_vector(C_EPROM_MB7124_DATA_WIDTH-1 downto 0) := "00000000";
		
--		prom_3s_ce		: out std_logic;
--		prom_3s_oe		: out std_logic;
--		prom_3s_addr	: out std_logic_vector(C_EPROM_MB7116_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_3s_data  	: in  std_logic_vector(C_EPROM_MB7116_DATA_WIDTH-1 downto 0) := "0000";
--		
--		prom_4v_ce		: out std_logic;
--		prom_4v_oe		: out std_logic;
--		prom_4v_addr	: out std_logic_vector(C_EPROM_MB7138_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_4v_data  	: in  std_logic_vector(C_EPROM_MB7138_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_5v_ce		: out std_logic;
--		prom_5v_oe		: out std_logic;
--		prom_5v_addr	: out std_logic_vector(C_EPROM_MB7138_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_5v_data  	: in  std_logic_vector(C_EPROM_MB7138_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_6u_ce		: out std_logic;
--		prom_6u_oe		: out std_logic;
--		prom_6u_addr	: out std_logic_vector(C_EPROM_MB7112_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_6u_data  	: in  std_logic_vector(C_EPROM_MB7112_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_7s_ce		: out std_logic;
--		prom_7s_oe		: out std_logic;
--		prom_7s_addr	: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_7s_data  	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_9c_ce		: out std_logic;
--		prom_9c_oe		: out std_logic;
--		prom_9c_addr	: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_9c_data  	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_9d_ce		: out std_logic;
--		prom_9d_oe		: out std_logic;
--		prom_9d_addr	: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_9d_data  	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_12c_ce		: out std_logic;
--		prom_12c_oe		: out std_logic;
--		prom_12c_addr	: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_12c_data  : in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_12d_ce		: out std_logic;
--		prom_12d_oe		: out std_logic;
--		prom_12d_addr	: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_12d_data  : in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
		sram_3f_ce		: out std_logic;
		sram_3f_oe		: out std_logic;
		sram_3f_we		: out std_logic;
		sram_3f_addr	: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "0000000000000";
		sram_3f_data   : inout std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000"
--		
--		sram_4n_ce		: out std_logic;
--		sram_4n_oe		: out std_logic;
--		sram_4n_we		: out std_logic;
--		sram_4n_addr	: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "000000000";
--		sram_4n_data  	: in  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000";
--
--		sram_4r_ce		: out std_logic;
--		sram_4r_oe		: out std_logic;
--		sram_4r_we		: out std_logic;
--		sram_4r_addr	: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "000000000";
--		sram_4r_data  	: in  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000";
--
--		sram_7n_ce		: out std_logic;
--		sram_7n_oe		: out std_logic;
--		sram_7n_we		: out std_logic;
--		sram_7n_addr	: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "000000000";
--		sram_7n_data  	: in  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000";
--
--		sram_10m_ce		: out std_logic;
--		sram_10m_oe		: out std_logic;
--		sram_10m_we		: out std_logic;
--		sram_10m_addr	: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "000000000";
--		sram_10m_data  : in  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000"

		--sram_11k_ce		: out std_logic;
		--sram_11k_oe		: out std_logic;
		--sram_11k_we		: out std_logic;
		--sram_11k_addr	: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "000000000";
		--sram_11k_data  : in  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "0000";		
	);

-------------------------------------------------------------------------------
-- fan-out attributes for XST
-------------------------------------------------------------------------------

  attribute MAX_FANOUT                    : string;
  attribute MAX_FANOUT   of CLK_48M       : signal is "10000";
  
-------------------------------------------------------------------------------
-- Attributes for MPD file
-------------------------------------------------------------------------------
  attribute IP_GROUP             	: string ;
  attribute IP_GROUP of system86 	: entity is "LOGICORE";
  attribute SIGIS : string; 
--attribute SIGIS of rst : signal is "Rst"; 

  attribute SIGIS of CLK_48M : signal is "Clk"; 

--attribute SIGIS of CLK_6M : signal is "Clk"; 

end entity system86;

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

architecture IMP of system86 is

--
-- global signals
--

-- timing subsystem outputs
--signal CLK_48M_tmp		: std_logic;
--signal CLK_24M		: std_logic;
--signal CLK_12M		: std_logic;
--signal CLK_6M		: std_logic;
--signal CLK_6MD		: std_logic;
--
--signal nHSYNC		: std_logic;
--signal nVSYNC		: std_logic;
--signal nVBLANK		: std_logic;
--signal nHBLANK		: std_logic;	-- used for simulation only
--signal BLANKING	: std_logic;
--signal nHRESET		: std_logic;
--signal nVRESET		: std_logic;
--signal SYNC			: std_logic;
--signal RED			: std_logic_vector(3 downto 0);
--signal GREEN		: std_logic_vector(3 downto 0);
--signal BLUE			: std_logic_vector(3 downto 0);
--
--signal CLK_8V		: std_logic;
--signal CLK_4V		: std_logic;
--signal CLK_1V		: std_logic;
--signal CLK_4H		: std_logic;
--signal CLK_2H		: std_logic;
--signal CLK_1H		: std_logic;
--signal CLK_S2H		: std_logic;
--signal CLK_S1H		: std_logic;
--
--signal dot_lsb_acc	: std_logic_vector(15 downto 0) := "0000000000000000";
--signal dot_msb_acc	: std_logic_vector(15 downto 0) := "0000000000000000";
--signal DOT			: std_logic_vector(7 downto 0) := "00000000";
--signal BANK			: std_logic := '0';
--
----
---- internal signals
----
--
--signal vid_active			: std_logic;
--signal vid_active_col	: std_logic_vector(9 downto 0);
--signal vid_active_row	: std_logic_vector(9 downto 0);
--signal vidgen_pattern	: std_logic_vector(3 downto 0) := "0001";
--
--signal tpg_pattern		: std_logic_vector(3 downto 0) := "0000"; --"0101";	-- 0110 black recangle with white border
----signal tpg_pattern		: std_logic_vector(3 downto 0) := "0101";	-- 0110 black recangle with white border
--signal tpg_red				: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
--signal tpg_green			: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
--signal tpg_blue			: std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
--signal tpg_hsync			: std_logic;
--signal tpg_vsync			: std_logic;
--signal tpg_hblank			: std_logic;
--signal tpg_vblank			: std_logic;
--

component system86
port(
	-- simulation control
	rst_n 				: in std_logic := '0';		// master reset
	
	-- simulation outputs
	
	vid_clk				: out    std_logic;
	vid_data				: out    std_logic_vector(11 downto 0);		-- 12-bit RGB data
	vid_hsync_n			: out    std_logic;
	vid_vsync_n			: out    std_logic;
	vid_hblank_n		: out    std_logic;
	vid_vblank_n		: out    std_logic;
		
	--
	-- System 86 board inputs
	-- 
	
	CLK_48M 				: in std_logic;		

	--
	-- System 86 board outputs
	--
	
	conn_j2_sync		: out    std_logic;									-- composite sync
	conn_j2_red			: out    std_logic_vector(3 downto 0);			-- 4-bit red component
	conn_j2_green		: out    std_logic_vector(3 downto 0);			-- 4-bit green component
	conn_j2_blue		: out    std_logic_vector(3 downto 0);			-- 4-bit blue component
	
	--
	-- System 86 CPU busses
	--
	
	-- TODO: support for externally defined 6809 CPU IP or physical chip
	
	--
	-- System 86 PROM busses
	--
	
	prom_3r_ce		: out std_logic;
	prom_3r_oe		: out std_logic;
	prom_3r_addr	: out std_logic_vector(8 downto 0) := "000000000";
	prom_3r_data	: in  std_logic_vector(7 downto 0) := "00000000";
--	
--	prom_3s_ce		: out std_logic;
--	prom_3s_oe		: out std_logic;
--	prom_3s_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	prom_3s_data  	: in  std_logic_vector(3 downto 0) := "0000";
--	
--	prom_4v_ce		: out std_logic;
--	prom_4v_oe		: out std_logic;
--	prom_4v_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	prom_4v_data  	: in  std_logic_vector(3 downto 0) := "0000";
--	
--	prom_5v_ce		: out std_logic;
--	prom_5v_oe		: out std_logic;
--	prom_5v_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	prom_5v_data  	: in  std_logic_vector(3 downto 0) := "0000";
--	
--	prom_6u_ce		: out std_logic;
--	prom_6u_oe		: out std_logic;
--	prom_6u_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	prom_6u_data  	: in  std_logic_vector(3 downto 0) := "0000";
--	
--	prom_7s_ce		: out std_logic;
--	prom_7s_oe		: out std_logic;
--	prom_7s_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	prom_7s_data  	: in  std_logic_vector(3 downto 0) := "0000";

	--
	-- System 86 static RAM busses
	--
--	sram_3f_ce		: out std_logic;
--	sram_3f_oe		: out std_logic;
--	sram_3f_we		: out std_logic;
--	sram_3f_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	sram_3f_data  	: in  std_logic_vector(3 downto 0) := "0000";
	
--	
--	sram_4n_ce		: out std_logic;
--	sram_4n_oe		: out std_logic;
--	sram_4n_we		: out std_logic;
--	sram_4n_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	sram_4n_data  	: in  std_logic_vector(3 downto 0) := "0000";
--
--	sram_4r_ce		: out std_logic;
--	sram_4r_oe		: out std_logic;
--	sram_4r_we		: out std_logic;
--	sram_4r_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	sram_4r_data  	: in  std_logic_vector(3 downto 0) := "0000";
--
--	sram_7n_ce		: out std_logic;
--	sram_7n_oe		: out std_logic;
--	sram_7n_we		: out std_logic;
--	sram_7n_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	sram_7n_data  	: in  std_logic_vector(3 downto 0) := "0000";
--
--	sram_10m_ce		: out std_logic;
--	sram_10m_oe		: out std_logic;
--	sram_10m_we		: out std_logic;
--	sram_10m_addr	: out std_logic_vector(8 downto 0) := "000000000";
--	sram_10m_data  : in  std_logic_vector(3 downto 0) := "0000";
--
--	SYNC				: out std_logic;
--	RED				: out std_logic_vector(3 downto 0);
--	GREEN				: out std_logic_vector(3 downto 0);
--	BLUE				: out std_logic_vector(3 downto 0)
);
end component;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

begin -- architecture IMP

	Inst_System86: system86
	port map
	(
		rst_n 			=> rst_n,
		CLK_48M			=> CLK_48M,
		CLK_48M			=> SYNC,
		conn_j2_red		=> RED,
		conn_j2_green	=> GREEN,
		conn_j2_blue	=> BLUE
	);

----
----	timing_subsys: timing_subsystem
----   port map
----	(
----		-- simulation control
----		rst			=> rst,
----		enable		=> enable,
----		
----		-- input clocks
----		CLK_48M		=> CLK_48M,
----		
----		-- soft generated clocks
----		CLK_24M		=> CLK_24M,
----		CLK_12M		=> CLK_12M,
----		CLK_6M		=> CLK_6M,
----		CLK_6MD		=> CLK_6MD,
----		
----		-- video synchronisation
----		nHSYNC 		=> nHSYNC,
----		nVSYNC 		=> nVSYNC,
----		nHBLANK		=> nHBLANK,	-- artistic licence - brought out for simulation
----		nVBLANK		=> nVBLANK,
----		BLANKING		=> BLANKING,
----		nHRESET 		=> nHRESET,
----		nVRESET 		=> nVRESET,
----		
----		-- video timings
----		CLK_8V	=> CLK_8V,
----		CLK_4V	=> CLK_4V,
----		CLK_1V	=> CLK_1V,
----		CLK_4H	=> CLK_4H,
----		CLK_2H	=> CLK_2H,
----		CLK_1H	=> CLK_1H,
----		CLK_S2H	=> CLK_S2H,
----		CLK_S1H	=> CLK_S1H
----	);
----	
----	videogen_subsys: videogen_subsystem
----   port map
----	(
----		-- simulation reset
----		reset			=> reset,
----		enable		=> enable,
----		
----		-- input clocks
----		CLK_6MD		=> CLK_6MD,
----		nCLR			=> '1',
----		D				=> DOT,
----		BANK			=> BANK,
----		RED			=> RED,
----		GREEN			=> GREEN,
----		BLUE			=> BLUE,
----		
----		prom_3r_ce		=> prom_3r_ce,
----		prom_3r_addr 	=> prom_3r_addr,
----		prom_3r_data 	=> prom_3r_data,
----		
----		prom_3s_ce		=> prom_3s_ce,
----		prom_3s_addr 	=> prom_3s_addr,
----		prom_3s_data 	=> prom_3s_data
----	);
----	
----	--
----	-- Testing
----	--
----	
----	InstBlankingToCount: Blanking_To_Count
----	generic map
----	(
----		ACTIVE_COLS  		=> 288,
----		ACTIVE_ROWS  		=> 224
----	)
----	port map
----	(
----		i_Clk 			=> CLK_6M,
----		i_Rst				=> reset,
----		i_HSync 			=> nHSYNC,
----		i_VSync 			=> nVSYNC,
----		i_HBlank 		=> nHBLANK,
----		i_VBlank 		=> nVBLANK,
----		o_Active			=> vid_active,
----		o_Col_Count		=> vid_active_col,
----		o_Row_Count		=> vid_active_row
----	);
----	
----	Inst_Test_Pattern_Gen: Test_Pattern_Gen
----	generic map
----	(
----		COMPONENT_DEPTH 	=> 4,
----		USE_BLANKING		=> 1,
----		TOTAL_COLS  		=> 384,
----		TOTAL_ROWS   		=> 288,
----		ACTIVE_COLS  		=> 288,
----		ACTIVE_ROWS  		=> 224
----	)
----	port map
----	(
----		i_Clk 			=> CLK_6M,
----		i_Rst				=> reset,
----		i_Pattern 		=> tpg_pattern,
----		i_HSync 			=> nHSYNC,
----		i_VSync 			=> nVSYNC,
----		o_HSync 			=> tpg_hsync,
----		o_VSync 			=> tpg_vsync,
----		o_HBlank			=> tpg_hblank,
----		o_VBlank			=> tpg_vblank,
----		o_Red_Video  	=> tpg_red(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4),
----		o_Grn_Video  	=> tpg_green(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4),
----		o_Blu_Video		=> tpg_blue(C_VIDEO_COMPONENT_DEPTH-1 downto C_VIDEO_COMPONENT_DEPTH-4)
----	);
----	
--process(CLK_48M)
--begin
--	if falling_edge(CLK_48M) then
--		CLK_48M_tmp <= CLK_48M; 
--		prom_3r_ce <= CLK_48M_tmp;
--	end if;
--end process;
----	process(CLK_6M)
----	begin
----		if falling_edge(CLK_6M) then
----			if vidgen_pattern /= "0000" then
----				if vid_active_row(8 downto 0) = "001110000" then
----					BANK <= '1';
----				elsif vid_active_row(8 downto 0) = "000000000" then
----					BANK <= '0';
----				end if;			
----				
----				if vid_active /= '0' then
----					DOT <= dot_msb_acc(15 downto 13) & dot_lsb_acc(15 downto 11);
----					
----					if (vid_active_col = 287) then
----						dot_lsb_acc <= "0000000000000000";
----						dot_msb_acc <= dot_msb_acc + 590;
----					else
----						dot_lsb_acc <= dot_lsb_acc + 228;
----					end if;
----					
----					if (vid_active_row = 111 or vid_active_row = 223) then
----						dot_lsb_acc <= "0000000000000000";
----						dot_msb_acc <= "0000000000000000";
----					end if;
----				else
----					DOT <= "00000000";
----				end if;
----			end if;
----		elsif rising_edge(CLK_6M) then
----			if tpg_pattern /= "0000" then
----				vid_hsync 	<= tpg_hsync;
----				vid_vsync 	<= tpg_vsync;
----				vid_hblank 	<= tpg_hblank;
----				vid_vblank 	<= tpg_vblank;
----				vid_red 		<= tpg_red;
----				vid_green 	<= tpg_green;
----				vid_blue 	<= tpg_blue;
----			else
----				vid_hsync 	<= nHSYNC;
----				vid_vsync 	<= nVSYNC;
----				vid_hblank 	<= nHBLANK;
----				vid_vblank 	<= nVBLANK;
----				vid_red 		<= RED;
----				vid_green 	<= GREEN;
----				vid_blue 	<= BLUE;				
----			end if;
----		end if;
----		
----		vid_clk <= CLK_6M;
----	end process;
----	
----	--
----	-- assign connection outputs
----	--
----	

	
end imp;
