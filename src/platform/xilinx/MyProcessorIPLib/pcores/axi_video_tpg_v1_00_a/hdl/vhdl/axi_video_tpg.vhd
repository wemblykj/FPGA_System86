------------------------------------------------------------------------------
-- axi_video_tpg.vhd - entity/architecture pair
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
-- Filename:          axi_video_tpg.vhd
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

LIBRARY proc_common_v3_00_a;
USE proc_common_v3_00_a.proc_common_pkg.ALL;
USE proc_common_v3_00_a.ipif_pkg.ALL;
USE proc_common_v3_00_a.soft_reset;

LIBRARY axi_lite_ipif_v1_01_a;
USE axi_lite_ipif_v1_01_a.axi_lite_ipif;

LIBRARY video_lib_v1_00_a;
USE video_lib_v1_00_a.video_tpg;

LIBRARY axi_video_tpg_v1_00_a;
USE axi_video_tpg_v1_00_a.user_logic;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_S_AXI_DATA_WIDTH           -- AXI4LITE slave: Data width
--   C_S_AXI_ADDR_WIDTH           -- AXI4LITE slave: Address Width
--   C_S_AXI_MIN_SIZE             -- AXI4LITE slave: Min Size
--   C_USE_WSTRB                  -- AXI4LITE slave: Write Strobe
--   C_DPHASE_TIMEOUT             -- AXI4LITE slave: Data Phase Timeout
--   C_BASEADDR                   -- AXI4LITE slave: base address
--   C_HIGHADDR                   -- AXI4LITE slave: high address
--   C_FAMILY                     -- FPGA Family
--   C_NUM_REG                    -- Number of software accessible registers
--   C_NUM_MEM                    -- Number of address-ranges
--   C_SLV_AWIDTH                 -- Slave interface address bus width
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
--   C_COMPONENT_DEPTH            -- 
--   C_TOTAL_COLS                 -- 
--   C_TOTAL_ROWS                 -- 
--   C_ACTIVE_COLS                -- 
--   C_ACTIVE_ROWS                -- 
--   C_USE_BLANKING               -- 
--   C_SYNC_PULSE_HORZ            -- 
--   C_SYNC_PULSE_VERT            -- 
--   C_FRONT_PORCH_HORZ           -- 
--   C_BACK_PORCH_HORZ            -- 
--   C_FRONT_PORCH_VERT           -- 
--   C_BACK_PORCH_VERT            -- 
--
-- Definition of Ports:
--   S_AXI_ACLK                   -- AXI4LITE slave: Clock 
--   S_AXI_ARESETN                -- AXI4LITE slave: Reset
--   S_AXI_AWADDR                 -- AXI4LITE slave: Write address
--   S_AXI_AWVALID                -- AXI4LITE slave: Write address valid
--   S_AXI_WDATA                  -- AXI4LITE slave: Write data
--   S_AXI_WSTRB                  -- AXI4LITE slave: Write strobe
--   S_AXI_WVALID                 -- AXI4LITE slave: Write data valid
--   S_AXI_BREADY                 -- AXI4LITE slave: Response ready
--   S_AXI_ARADDR                 -- AXI4LITE slave: Read address
--   S_AXI_ARVALID                -- AXI4LITE slave: Read address valid
--   S_AXI_RREADY                 -- AXI4LITE slave: Read data ready
--   S_AXI_ARREADY                -- AXI4LITE slave: read addres ready
--   S_AXI_RDATA                  -- AXI4LITE slave: Read data
--   S_AXI_RRESP                  -- AXI4LITE slave: Read data response
--   S_AXI_RVALID                 -- AXI4LITE slave: Read data valid
--   S_AXI_WREADY                 -- AXI4LITE slave: Write data ready
--   S_AXI_BRESP                  -- AXI4LITE slave: Response
--   S_AXI_BVALID                 -- AXI4LITE slave: Resonse valid
--   S_AXI_AWREADY                -- AXI4LITE slave: Wrte address ready
------------------------------------------------------------------------------

ENTITY axi_video_tpg IS
	GENERIC (
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		C_COMPONENT_DEPTH : INTEGER := 8;
		C_TOTAL_COLS : INTEGER := 800;
		C_TOTAL_ROWS : INTEGER := 525;
		C_ACTIVE_COLS : INTEGER := 640;
		C_ACTIVE_ROWS : INTEGER := 480;
		C_SYNC_PULSE_HORZ : INTEGER := 96;
		C_SYNC_PULSE_VERT : INTEGER := 2;
		C_USE_BLANKING : INTEGER := 0;
		C_FRONT_PORCH_HORZ : INTEGER := 16;
		C_BACK_PORCH_HORZ : INTEGER := 48;
		C_FRONT_PORCH_VERT : INTEGER := 10;
		C_BACK_PORCH_VERT : INTEGER := 33;
		-- ADD USER GENERICS ABOVE THIS LINE ---------------

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol parameters, do not add to or delete
		C_S_AXI_DATA_WIDTH : INTEGER := 32;
		C_S_AXI_ADDR_WIDTH : INTEGER := 32;
		C_S_AXI_MIN_SIZE : std_logic_vector := X"000001FF";
		C_USE_WSTRB : INTEGER := 0;
		C_DPHASE_TIMEOUT : INTEGER := 8;
		C_BASEADDR : std_logic_vector := X"FFFFFFFF";
		C_HIGHADDR : std_logic_vector := X"00000000";
		C_FAMILY : STRING := "virtex6";
		C_NUM_REG : INTEGER := 1;
		C_NUM_MEM : INTEGER := 1;
		C_SLV_AWIDTH : INTEGER := 32;
		C_SLV_DWIDTH : INTEGER := 32
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
	PORT (
		-- ADD USER PORTS BELOW THIS LINE ------------------
		I_CLK : IN std_logic;
		I_RST : IN std_logic := '0';

		I_PATTERN : IN std_logic_vector(3 DOWNTO 0);

		I_HSYNC : IN std_logic;
		I_VSYNC : IN std_logic;

		O_LOCKED : OUT std_logic;
		O_HSYNC : OUT std_logic;
		O_VSYNC : OUT std_logic;
		O_HBLANK : OUT std_logic := 'X';
		O_VBLANK : OUT std_logic := 'X';
		O_RED : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_GREEN : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		O_BLUE : OUT std_logic_vector(C_COMPONENT_DEPTH - 1 DOWNTO 0);
		-- ADD USER PORTS ABOVE THIS LINE ------------------

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add to or delete
		S_AXI_ACLK : IN std_logic;
		S_AXI_ARESETN : IN std_logic;
		S_AXI_AWADDR : IN std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		S_AXI_AWVALID : IN std_logic;
		S_AXI_WDATA : IN std_logic_vector(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
		S_AXI_WSTRB : IN std_logic_vector((C_S_AXI_DATA_WIDTH/8) - 1 DOWNTO 0);
		S_AXI_WVALID : IN std_logic;
		S_AXI_BREADY : IN std_logic;
		S_AXI_ARADDR : IN std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		S_AXI_ARVALID : IN std_logic;
		S_AXI_RREADY : IN std_logic;
		S_AXI_ARREADY : OUT std_logic;
		S_AXI_RDATA : OUT std_logic_vector(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
		S_AXI_RRESP : OUT std_logic_vector(1 DOWNTO 0);
		S_AXI_RVALID : OUT std_logic;
		S_AXI_WREADY : OUT std_logic;
		S_AXI_BRESP : OUT std_logic_vector(1 DOWNTO 0);
		S_AXI_BVALID : OUT std_logic;
		S_AXI_AWREADY : OUT std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);

	ATTRIBUTE MAX_FANOUT : STRING;
	ATTRIBUTE SIGIS : STRING;
	ATTRIBUTE MAX_FANOUT OF S_AXI_ACLK : SIGNAL IS "10000";
	ATTRIBUTE MAX_FANOUT OF S_AXI_ARESETN : SIGNAL IS "10000";
	ATTRIBUTE SIGIS OF S_AXI_ACLK : SIGNAL IS "Clk";
	ATTRIBUTE SIGIS OF S_AXI_ARESETN : SIGNAL IS "Rst";
END ENTITY axi_video_tpg;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

ARCHITECTURE IMP OF axi_video_tpg IS

	CONSTANT USER_SLV_DWIDTH : INTEGER := C_S_AXI_DATA_WIDTH;

	CONSTANT IPIF_SLV_DWIDTH : INTEGER := C_S_AXI_DATA_WIDTH;

	CONSTANT ZERO_ADDR_PAD : std_logic_vector(0 TO 31) := (OTHERS => '0');
	CONSTANT RST_BASEADDR : std_logic_vector := C_BASEADDR OR X"00000100";
	CONSTANT RST_HIGHADDR : std_logic_vector := C_BASEADDR OR X"000001FF";
	CONSTANT USER_SLV_BASEADDR : std_logic_vector := C_BASEADDR OR X"00000000";
	CONSTANT USER_SLV_HIGHADDR : std_logic_vector := C_BASEADDR OR X"000000FF";

	CONSTANT IPIF_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
	(
	ZERO_ADDR_PAD & RST_BASEADDR, -- soft reset space base address
	ZERO_ADDR_PAD & RST_HIGHADDR, -- soft reset space high address
	ZERO_ADDR_PAD & USER_SLV_BASEADDR, -- user logic slave space base address
	ZERO_ADDR_PAD & USER_SLV_HIGHADDR -- user logic slave space high address
	);

	CONSTANT RST_NUM_CE : INTEGER := 1;
	CONSTANT USER_SLV_NUM_REG : INTEGER := 5;
	CONSTANT USER_NUM_REG : INTEGER := USER_SLV_NUM_REG;
	CONSTANT TOTAL_IPIF_CE : INTEGER := USER_NUM_REG + RST_NUM_CE;

	CONSTANT IPIF_ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE :=
	(
	0 => (RST_NUM_CE), -- number of ce for soft reset space
	1 => (USER_SLV_NUM_REG) -- number of ce for user logic slave space
	);

	------------------------------------------
	-- Width of triggered reset in bus clocks
	------------------------------------------
	CONSTANT RESET_WIDTH : INTEGER := 8;

	------------------------------------------
	-- Index for CS/CE
	------------------------------------------
	CONSTANT RST_CS_INDEX : INTEGER := 0;
	CONSTANT RST_CE_INDEX : INTEGER := USER_NUM_REG;
	CONSTANT USER_SLV_CS_INDEX : INTEGER := 1;
	CONSTANT USER_SLV_CE_INDEX : INTEGER := calc_start_ce_index(IPIF_ARD_NUM_CE_ARRAY, USER_SLV_CS_INDEX);

	CONSTANT USER_CE_INDEX : INTEGER := USER_SLV_CE_INDEX;

	------------------------------------------
	-- IP Interconnect (IPIC) signal declarations
	------------------------------------------
	SIGNAL ipif_Bus2IP_Clk : std_logic;
	SIGNAL ipif_Bus2IP_Resetn : std_logic;
	SIGNAL ipif_Bus2IP_Addr : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL ipif_Bus2IP_RNW : std_logic;
	SIGNAL ipif_Bus2IP_BE : std_logic_vector(IPIF_SLV_DWIDTH/8 - 1 DOWNTO 0);
	SIGNAL ipif_Bus2IP_CS : std_logic_vector((IPIF_ARD_ADDR_RANGE_ARRAY'LENGTH)/2 - 1 DOWNTO 0);
	SIGNAL ipif_Bus2IP_RdCE : std_logic_vector(calc_num_ce(IPIF_ARD_NUM_CE_ARRAY) - 1 DOWNTO 0);
	SIGNAL ipif_Bus2IP_WrCE : std_logic_vector(calc_num_ce(IPIF_ARD_NUM_CE_ARRAY) - 1 DOWNTO 0);
	SIGNAL ipif_Bus2IP_Data : std_logic_vector(IPIF_SLV_DWIDTH - 1 DOWNTO 0);
	SIGNAL ipif_IP2Bus_WrAck : std_logic;
	SIGNAL ipif_IP2Bus_RdAck : std_logic;
	SIGNAL ipif_IP2Bus_Error : std_logic;
	SIGNAL ipif_IP2Bus_Data : std_logic_vector(IPIF_SLV_DWIDTH - 1 DOWNTO 0);
	SIGNAL ipif_Bus2IP_Reset : std_logic;
	SIGNAL rst_Bus2IP_Reset : std_logic;
	SIGNAL rst_IP2Bus_WrAck : std_logic;
	SIGNAL rst_IP2Bus_Error : std_logic;
	SIGNAL rst_Bus2IP_Reset_tmp : std_logic;
	SIGNAL user_Bus2IP_RdCE : std_logic_vector(USER_NUM_REG - 1 DOWNTO 0);
	SIGNAL user_Bus2IP_WrCE : std_logic_vector(USER_NUM_REG - 1 DOWNTO 0);
	SIGNAL user_IP2Bus_Data : std_logic_vector(USER_SLV_DWIDTH - 1 DOWNTO 0);
	SIGNAL user_IP2Bus_RdAck : std_logic;
	SIGNAL user_IP2Bus_WrAck : std_logic;
	SIGNAL user_IP2Bus_Error : std_logic;

BEGIN

	------------------------------------------
	-- instantiate axi_lite_ipif
	------------------------------------------
	AXI_LITE_IPIF_I : ENTITY axi_lite_ipif_v1_01_a.axi_lite_ipif
		GENERIC MAP
		(
			C_S_AXI_DATA_WIDTH => IPIF_SLV_DWIDTH,
			C_S_AXI_ADDR_WIDTH => C_S_AXI_ADDR_WIDTH,
			C_S_AXI_MIN_SIZE => C_S_AXI_MIN_SIZE,
			C_USE_WSTRB => C_USE_WSTRB,
			C_DPHASE_TIMEOUT => C_DPHASE_TIMEOUT,
			C_ARD_ADDR_RANGE_ARRAY => IPIF_ARD_ADDR_RANGE_ARRAY,
			C_ARD_NUM_CE_ARRAY => IPIF_ARD_NUM_CE_ARRAY,
			C_FAMILY => C_FAMILY
		)
		PORT MAP
		(
			S_AXI_ACLK => S_AXI_ACLK,
			S_AXI_ARESETN => S_AXI_ARESETN,
			S_AXI_AWADDR => S_AXI_AWADDR,
			S_AXI_AWVALID => S_AXI_AWVALID,
			S_AXI_WDATA => S_AXI_WDATA,
			S_AXI_WSTRB => S_AXI_WSTRB,
			S_AXI_WVALID => S_AXI_WVALID,
			S_AXI_BREADY => S_AXI_BREADY,
			S_AXI_ARADDR => S_AXI_ARADDR,
			S_AXI_ARVALID => S_AXI_ARVALID,
			S_AXI_RREADY => S_AXI_RREADY,
			S_AXI_ARREADY => S_AXI_ARREADY,
			S_AXI_RDATA => S_AXI_RDATA,
			S_AXI_RRESP => S_AXI_RRESP,
			S_AXI_RVALID => S_AXI_RVALID,
			S_AXI_WREADY => S_AXI_WREADY,
			S_AXI_BRESP => S_AXI_BRESP,
			S_AXI_BVALID => S_AXI_BVALID,
			S_AXI_AWREADY => S_AXI_AWREADY,
			Bus2IP_Clk => ipif_Bus2IP_Clk,
			Bus2IP_Resetn => ipif_Bus2IP_Resetn,
			Bus2IP_Addr => ipif_Bus2IP_Addr,
			Bus2IP_RNW => ipif_Bus2IP_RNW,
			Bus2IP_BE => ipif_Bus2IP_BE,
			Bus2IP_CS => ipif_Bus2IP_CS,
			Bus2IP_RdCE => ipif_Bus2IP_RdCE,
			Bus2IP_WrCE => ipif_Bus2IP_WrCE,
			Bus2IP_Data => ipif_Bus2IP_Data,
			IP2Bus_WrAck => ipif_IP2Bus_WrAck,
			IP2Bus_RdAck => ipif_IP2Bus_RdAck,
			IP2Bus_Error => ipif_IP2Bus_Error,
			IP2Bus_Data => ipif_IP2Bus_Data
		);

	------------------------------------------
	-- instantiate soft_reset
	------------------------------------------
	SOFT_RESET_I : ENTITY proc_common_v3_00_a.soft_reset
		GENERIC MAP
		(
			C_SIPIF_DWIDTH => IPIF_SLV_DWIDTH,
			C_RESET_WIDTH => RESET_WIDTH
		)
		PORT MAP
		(
			Bus2IP_Reset => ipif_Bus2IP_Reset,
			Bus2IP_Clk => ipif_Bus2IP_Clk,
			Bus2IP_WrCE => ipif_Bus2IP_WrCE(RST_CE_INDEX),
			Bus2IP_Data => ipif_Bus2IP_Data,
			Bus2IP_BE => ipif_Bus2IP_BE,
			Reset2IP_Reset => rst_Bus2IP_Reset,
			Reset2Bus_WrAck => rst_IP2Bus_WrAck,
			Reset2Bus_Error => rst_IP2Bus_Error,
			Reset2Bus_ToutSup => OPEN
		);

	------------------------------------------
	-- instantiate User Logic
	------------------------------------------
	USER_LOGIC_I : ENTITY axi_video_tpg_v1_00_a.user_logic
		GENERIC MAP
		(
			-- MAP USER GENERICS BELOW THIS LINE ---------------
			--USER generics mapped here
			-- MAP USER GENERICS ABOVE THIS LINE ---------------

			C_NUM_REG => USER_NUM_REG,
			C_SLV_DWIDTH => USER_SLV_DWIDTH
		)
		PORT MAP
		(
			-- MAP USER PORTS BELOW THIS LINE ------------------
			--USER ports mapped here
			-- MAP USER PORTS ABOVE THIS LINE ------------------

			Bus2IP_Clk => ipif_Bus2IP_Clk,
			Bus2IP_Resetn => rst_Bus2IP_Reset_tmp,
			Bus2IP_Data => ipif_Bus2IP_Data,
			Bus2IP_BE => ipif_Bus2IP_BE,
			Bus2IP_RdCE => user_Bus2IP_RdCE,
			Bus2IP_WrCE => user_Bus2IP_WrCE,
			IP2Bus_Data => user_IP2Bus_Data,
			IP2Bus_RdAck => user_IP2Bus_RdAck,
			IP2Bus_WrAck => user_IP2Bus_WrAck,
			IP2Bus_Error => user_IP2Bus_Error
		);

	------------------------------------------
	-- instantiate Test Pattern Generator
	------------------------------------------

	--TEST_GEN_I: Test_Pattern_Gen
	TEST_GEN_I : ENTITY video_lib_v1_00_a.video_tpg
		GENERIC MAP
		(
			C_COMPONENT_DEPTH => C_COMPONENT_DEPTH,
			C_TOTAL_COLS => C_TOTAL_COLS,
			C_TOTAL_ROWS => C_TOTAL_ROWS,
			C_ACTIVE_COLS => C_ACTIVE_COLS,
			C_ACTIVE_ROWS => C_ACTIVE_ROWS,
			C_USE_BLANKING => C_USE_BLANKING,
			C_SYNC_PULSE_HORZ => C_SYNC_PULSE_HORZ,
			C_SYNC_PULSE_VERT => C_SYNC_PULSE_VERT,
			C_FRONT_PORCH_HORZ => C_FRONT_PORCH_HORZ,
			C_BACK_PORCH_HORZ => C_BACK_PORCH_HORZ,
			C_FRONT_PORCH_VERT => C_FRONT_PORCH_VERT,
			C_BACK_PORCH_VERT => C_BACK_PORCH_VERT
		)
		PORT MAP
		(
			I_CLK => I_CLK,
			I_RST => I_RST,
			I_PATTERN => I_PATTERN,
			I_HSYNC => I_HSYNC,
			I_VSYNC => I_VSYNC,
			O_LOCKED => O_LOCKED,
			O_HSYNC => O_HSYNC,
			O_VSYNC => O_VSYNC,
			O_HBLANK => O_HBLANK,
			O_VBLANK => O_VBLANK,
			O_RED => O_RED,
			O_GREEN => O_GREEN,
			O_BLUE => O_BLUE
		);

	------------------------------------------
	-- connect internal signals
	------------------------------------------
	IP2BUS_DATA_MUX_PROC : PROCESS (ipif_Bus2IP_CS, user_IP2Bus_Data) IS
	BEGIN

		CASE ipif_Bus2IP_CS (1 DOWNTO 0) IS
			WHEN "01" => ipif_IP2Bus_Data <= user_IP2Bus_Data;
			WHEN "10" => ipif_IP2Bus_Data <= (OTHERS => '0');
			WHEN OTHERS => ipif_IP2Bus_Data <= (OTHERS => '0');
		END CASE;

	END PROCESS IP2BUS_DATA_MUX_PROC;

	ipif_IP2Bus_WrAck <= user_IP2Bus_WrAck OR rst_IP2Bus_WrAck;
	ipif_IP2Bus_RdAck <= user_IP2Bus_RdAck;
	ipif_IP2Bus_Error <= user_IP2Bus_Error OR rst_IP2Bus_Error;

	user_Bus2IP_RdCE <= ipif_Bus2IP_RdCE(USER_NUM_REG - 1 DOWNTO 0);
	user_Bus2IP_WrCE <= ipif_Bus2IP_WrCE(USER_NUM_REG - 1 DOWNTO 0);

	ipif_Bus2IP_Reset <= NOT ipif_Bus2IP_Resetn;
	rst_Bus2IP_Reset_tmp <= NOT rst_Bus2IP_Reset;
END IMP;
