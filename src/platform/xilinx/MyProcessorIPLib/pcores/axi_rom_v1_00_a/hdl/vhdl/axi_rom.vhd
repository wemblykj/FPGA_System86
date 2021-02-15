------------------------------------------------------------------------------
-- axi_rom.vhd - entity/architecture pair
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
-- Filename:          axi_rom.vhd
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

library proc_common_v3_00_a;
use proc_common_v3_00_a.ipif_pkg.SLV64_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.INTEGER_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.calc_num_ce;



-------------------------------------------------------------------------------
-- axi_gpio_v1_01_b library is used for axi4 component declarations
-------------------------------------------------------------------------------
library axi_lite_ipif_v1_01_a; 

-------------------------------------------------------------------------------
-- axi_rom_v1_00_a library is used for axi_rom component declarations
-------------------------------------------------------------------------------

library axi_rom_v1_00_a; 

-------------------------------------------------------------------------------
--                     Defination of Generics :                              --
-------------------------------------------------------------------------------
-- AXI generics
--  C_BASEADDR      -- Base address of the core
--  C_HIGHADDR      -- Permits alias of address space
--                           by making greater than xFFF
--  C_M_AXI_ADDR_WIDTH    -- Width of Master AXI Address interface (in bits)
--  C_M_AXI_DATA_WIDTH    -- Width of the Master AXI Data interface (in bits)
--  C_S_AXI_ADDR_WIDTH    -- Width of Slave AXI Address interface (in bits)
--  C_S_AXI_DATA_WIDTH    -- Width of the Slave AXI Data interface (in bits)

-- C_FAMILY               -- XILINX FPGA family
-- C_INSTANCE             -- Instance name ot the core in the EDK system

--   C_SLAVE_BASE_ADDR            -- Base address to which all external ROM requests will 
--                                   be mapped on the AXI bus
--
--
-- Definition of Ports:
--
-------------------------------------------------------------------------------
--                  Defination of Ports                                      --
-------------------------------------------------------------------------------
-- AXI Global Signals
--   slave_addr_offset            -- An offset from C_BASEADDR for with incoming 
--                                   requests will be mapped
-- AXI Global Signals
-- S_AXI_ACLK            -- AXI Clock
-- S_AXI_ARESETN          -- AXI Reset

-- AXI Slave Lite signals
-- S_AXI_ACLK            -- AXI Clock
-- S_AXI_ARESETN          -- AXI Reset
-- S_AXI_AWADDR          -- AXI Write address
-- S_AXI_AWVALID         -- Write address valid
-- S_AXI_AWREADY         -- Write address ready
-- S_AXI_WDATA           -- Write data
-- S_AXI_WSTRB           -- Write strobes
-- S_AXI_WVALID          -- Write valid
-- S_AXI_WREADY          -- Write ready
-- S_AXI_BRESP           -- Write response
-- S_AXI_BVALID          -- Write response valid
-- S_AXI_BREADY          -- Response ready
-- S_AXI_ARADDR          -- Read address
-- S_AXI_ARVALID         -- Read address valid
-- S_AXI_ARREADY         -- Read address ready
-- S_AXI_RDATA           -- Read data
-- S_AXI_RRESP           -- Read response
-- S_AXI_RVALID          -- Read valid
-- S_AXI_RREADY          -- Read ready

------------------------------------------------------------------------------

entity axi_rom is
  generic
  (
      -- ROM generics
      C_ROM_ADDR_WIDTH              : integer range 4 to 16 := 16;
      C_ROM_DATA_WIDTH              : integer range 4 to 8 := 8;
      
		-- Mapping generics
      C_MAPPED_BASE_ADDR            : std_logic_vector     := X"C0000000";
      C_USE_DYNAMIC_MAPPING         : std_logic := '0';

      --Family Generics
      C_XLNX_REF_BOARD              : string  := "NONE";
      C_FAMILY                      : string  := "virtex6";
      C_INSTANCE                    : string  := "axi_rom_inst";
      
      -- Master AXI Generics
      -- C_M_AXI_THREAD_ID_WIDTH       : integer := 4;
      C_M_AXI_ADDR_WIDTH            : integer := 32;
      C_M_AXI_DATA_WIDTH            : integer := 32;
      
		-- Slave AXI-Lite Generics
		C_S_AXI_ADDR_WIDTH            : integer range 8 to 8 := 8;
      C_S_AXI_DATA_WIDTH            : integer range 32 to 32 := 32
		--C_BASEADDR                    : std_logic_vector := X"FFFFFFFF";
		--C_HIGHADDR                    : std_logic_vector := X"00000000"
  );
  port
  (
      -- ROM ports
      --chip_enable             : in std_logic;
      --output_enable           : in std_logic;
      --addr	 						: in std_logic_vector(C_ROM_ADDR_WIDTH-1 downto 0);
      --data                    : inout std_logic_vector(C_ROM_DATA_WIDTH-1 downto 0);
      --data_T                  : in std_logic;
      --data_I                  : in std_logic_vector((C_ROM_DATA_WIDTH-1) downto 0);
      --data_O                  : out std_logic_vector((C_ROM_DATA_WIDTH-1) downto 0);
      --mapping_addr            : in std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  
      -- AXI Global

      -- AXI Master Write Address Channel
      M_AXI_ACLK              : in  std_logic; -- AXI clock
      M_AXI_ARESETN           : in  std_logic; -- AXI active low synchronous reset
     
      -- AXI Master Read Address Channel
      --M_AXI_ARID              : out std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
      M_AXI_ARADDR            : out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
      M_AXI_ARLEN             : out std_logic_vector(7 downto 0);
      M_AXI_ARSIZE            : out std_logic_vector(2 downto 0);
      M_AXI_ARBURST           : out std_logic_vector(1 downto 0);
      M_AXI_ARPROT            : out std_logic_vector(2 downto 0);
      M_AXI_ARVALID           : out std_logic;
      M_AXI_ARREADY           : in  std_logic;
      M_AXI_ARLOCK            : out std_logic;
      M_AXI_ARCACHE           : out std_logic_vector(3 downto 0);

      -- AXI Master Read Data Channel
      M_AXI_RDATA             : in  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
      M_AXI_RRESP             : in  std_logic_vector(1 downto 0);
      M_AXI_RLAST             : in  std_logic;
      M_AXI_RVALID            : in  std_logic;
      M_AXI_RREADY            : out std_logic;

      -- AXI Slave Lite Interface - CFG Block
		S_AXI_ACLK              : in  std_logic;
    S_AXI_ARESETN           : in  std_logic;
    S_AXI_AWADDR            : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 
    								downto 0);
    S_AXI_AWVALID           : in  std_logic;
    S_AXI_AWREADY           : out std_logic;
    
    S_AXI_WDATA             : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 
    								downto 0);
    S_AXI_WSTRB             : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 
    								downto 0);
    S_AXI_WVALID            : in  std_logic;
    S_AXI_WREADY            : out std_logic;
    
    S_AXI_BRESP             : out std_logic_vector(1 downto 0);
    S_AXI_BVALID            : out std_logic;
    S_AXI_BREADY            : in  std_logic;
    
    S_AXI_ARADDR            : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 
    								downto 0);
    S_AXI_ARVALID           : in  std_logic;
    S_AXI_ARREADY           : out std_logic;
    
    S_AXI_RDATA             : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 
    								downto 0);
    S_AXI_RRESP             : out std_logic_vector(1 downto 0);
    S_AXI_RVALID            : out std_logic;
    S_AXI_RREADY            : in  std_logic
  );

-------------------------------------------------------------------------------
-- fan-out attributes for XST
-------------------------------------------------------------------------------

  attribute MAX_FANOUT                    : string;
  attribute MAX_FANOUT   of M_AXI_ACLK    : signal is "10000";
  attribute MAX_FANOUT   of M_AXI_ARESETN : signal is "10000";
  attribute MAX_FANOUT   of S_AXI_ACLK    : signal is "10000";
  attribute MAX_FANOUT   of S_AXI_ARESETN : signal is "10000";
-------------------------------------------------------------------------------
-- Attributes for MPD file
-------------------------------------------------------------------------------
  attribute IP_GROUP             	: string ;
  attribute IP_GROUP of axi_rom 	: entity is "LOGICORE";
  attribute SIGIS                	: string ;
  attribute SIGIS of M_AXI_ACLK     : signal is "Clk";
  attribute SIGIS of M_AXI_ARESETN  : signal is "Rst";
  attribute SIGIS of S_AXI_ACLK     : signal is "Clk";
  attribute SIGIS of S_AXI_ARESETN  : signal is "Rst";

end entity axi_rom;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_rom is

-------------------  Constant Declaration Section BEGIN -----------------------

constant ZERO_ADDR_PAD         : std_logic_vector(0 to 31)
                                 := (others => '0');

constant BASEADDR  : std_logic_vector(31 downto 0):= X"00000000";
constant HIGHADDR  : std_logic_vector(31 downto 0):= X"000000FF";

constant ARD_ADDR_RANGE_ARRAY  : SLV64_ARRAY_TYPE :=
                                 (ZERO_ADDR_PAD & BASEADDR, 
                                  ZERO_ADDR_PAD & HIGHADDR);
constant ARD_NUM_CE_ARRAY      : INTEGER_ARRAY_TYPE := (0 => 8);

constant AXI_MIN_SIZE       : std_logic_vector(31 downto 0) := X"000000FF";
constant USE_WSTRB          : integer := 1;
constant DPHASE_TIMEOUT     : integer := 0;
  
-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------

signal mapped_base_addr    : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);

signal bus2ip_clk      : std_logic;
signal bus2ip_resetn   : std_logic;
		  
--IPIC request qualifier signals
signal ip2bus_rdack         : std_logic;
signal ip2bus_wrack         : std_logic;
signal ip2bus_addrack       : std_logic;
signal ip2bus_error        : std_logic;
-- IPIC address, data signals
signal ip2bus_data          : std_logic_vector(0 to (C_S_AXI_DATA_WIDTH-1));

signal bus2ip_addr          : std_logic_vector(0 to (C_S_AXI_ADDR_WIDTH-1));

-- Bus2IP_* Signals
signal bus2ip_data          : std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
--
signal bus2ip_rnw           : std_logic;
--
signal bus2ip_cs            : std_logic_vector
										(((ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);

signal bus2ip_rdce          : std_logic_vector
                              (0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal bus2ip_wrce          : std_logic_vector
                              (0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
--
signal bus2ip_be            : std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
signal bus2ip_burst         : std_logic;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------

begin -- architecture IMP

    AXI_LITE_IPIF_I : entity axi_lite_ipif_v1_01_a.axi_lite_ipif
      generic map
       (
        C_S_AXI_ADDR_WIDTH        => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH        => C_S_AXI_DATA_WIDTH,
        C_S_AXI_MIN_SIZE          => AXI_MIN_SIZE,
        C_USE_WSTRB               => USE_WSTRB,
        C_DPHASE_TIMEOUT          => DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY    => ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY        => ARD_NUM_CE_ARRAY,
        C_FAMILY                  => C_FAMILY
       )
     port map
       (
        S_AXI_ACLK          =>  S_AXI_ACLK,
        S_AXI_ARESETN       =>  S_AXI_ARESETN,
        S_AXI_AWADDR        =>  S_AXI_AWADDR,
        S_AXI_AWVALID       =>  S_AXI_AWVALID,
        S_AXI_AWREADY       =>  S_AXI_AWREADY,
        S_AXI_WDATA         =>  S_AXI_WDATA,
        S_AXI_WSTRB         =>  S_AXI_WSTRB,
        S_AXI_WVALID        =>  S_AXI_WVALID,
        S_AXI_WREADY        =>  S_AXI_WREADY,
        S_AXI_BRESP         =>  S_AXI_BRESP,
        S_AXI_BVALID        =>  S_AXI_BVALID,
        S_AXI_BREADY        =>  S_AXI_BREADY,
        S_AXI_ARADDR        =>  S_AXI_ARADDR,
        S_AXI_ARVALID       =>  S_AXI_ARVALID,
        S_AXI_ARREADY       =>  S_AXI_ARREADY,
        S_AXI_RDATA         =>  S_AXI_RDATA,
        S_AXI_RRESP         =>  S_AXI_RRESP,
        S_AXI_RVALID        =>  S_AXI_RVALID,
        S_AXI_RREADY        =>  S_AXI_RREADY,
     
        -- IP Interconnect (IPIC) port signals 
        Bus2IP_Clk     => bus2ip_clk,
        Bus2IP_Resetn  => bus2ip_resetn,
        IP2Bus_Data    => ip2bus_data,
        IP2Bus_WrAck   => ip2bus_wrack,
        IP2Bus_RdAck   => ip2bus_rdack,
        IP2Bus_Error   => ip2bus_error,
        Bus2IP_Addr    => bus2ip_addr,
        Bus2IP_Data    => bus2ip_data,
        Bus2IP_RNW     => bus2ip_rnw,
        Bus2IP_BE      => bus2ip_be,
        Bus2IP_CS      => bus2ip_cs,
        Bus2IP_RdCE    => bus2ip_rdce,
        Bus2IP_WrCE    => bus2ip_wrce
       );

end architecture imp;
