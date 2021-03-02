------------------------------------------------------------------------------
-- axi_ttl_memory_bus.vhd - entity/architecture pair
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
-- Filename:          axi_ttl_memory_bus.vhd
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
use ieee.numeric_std.all;

package axi_slave_pkg is
  type register_array is array(natural range <>) of std_logic_vector;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.axi_slave_pkg.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.ipif_pkg.SLV64_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.INTEGER_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.calc_num_ce;

-------------------------------------------------------------------------------
-- axi_lite_ipif_v1_01_a library is used for axi4 component declarations
-------------------------------------------------------------------------------
library axi_lite_ipif_v1_01_a;

-------------------------------------------------------------------------------
-- axi_master_lite_v2_00_a library is used for axi4 component declarations
-------------------------------------------------------------------------------
library axi_master_lite_v2_00_a;

-------------------------------------------------------------------------------
-- axi_ttl_memory_bus_v1_00_a library is used for axi_ttl_memory_bus component declarations
-------------------------------------------------------------------------------

library axi_ttl_memory_bus_v1_00_a;
use axi_ttl_memory_bus_v1_00_a.all;


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

-- AXI Master Signals
--
--  M_AXI_ACLK               -- AXI Clock
--  M_AXI_ARESETN            -- AXI Reset Signal - active low
--
-- AXI Write address channel signals
--  M_AXI_AWID               -- Write address ID. This signal is the
--                           -- identification tag for the write address 
--                           -- group of signals
--  M_AXI_AWLEN              -- Burst length. The burst length gives the 
--                           -- exact number of transfers in a burst
--  M_AXI_AWSIZE             -- Burst size. This signal indicates the size 
--                           -- of each transfer in the burst
--  M_AXI_AWBURST            -- Burst type. The burst type, coupled with
--                           -- the size information, details how the address 
--                           -- for each transfer within the burst is calculated
--  M_AXI_AWADDR             -- Write address bus - The write address bus gives
--                              the address of the first transfer in a write
--                              burst transaction - fixed to 32
--  M_AXI_AWCACHE            -- Cache type. This signal indicates 
--                           -- the bufferable,cacheable, write-through, 
--                           -- write-back,and allocate attributes of the
--                           -- transaction 
--  M_AXI_AWPROT             -- Protection type - This signal indicates the
--                              normal, privileged, or secure protection level
--                              of the transaction and whether the transaction
--                              is a data access or an instruction access
--  M_AXI_AWVALID            -- Write address valid - This signal indicates
--                              that valid write address & control information
--                              are available
--  M_AXI_AWREADY            -- Write address ready - This signal indicates
--                              that the slave is ready to accept an address
--                              and associated control signals
--  M_AXI_AWLOCK             -- Lock type. This signal provides additional 
-- information about the atomic characteristics
-- of the transfer
--
-- AXI Write data channel signals
--
--  M_AXI_WDATA              -- Write data bus  
--  M_AXI_WSTRB              -- Write strobes - These signals indicates which
--                              byte lanes to update in memory
--  M_AXI_WLAST              -- Write last. This signal indicates the last 
--                           -- transfer in a write burst
--  M_AXI_WVALID             -- Write valid - This signal indicates that valid
--                              write data and strobes are available
--  M_AXI_WREADY             -- Write ready - This signal indicates that the
--                              slave can accept the write data
-- AXI Write response channel signals
--
--  M_AXI_BID                -- Response ID. The identification tag of the 
--                           -- write response
--  M_AXI_BRESP              -- Write response - This signal indicates the
--                              status of the write transaction
--  M_AXI_BVALID             -- Write response valid - This signal indicates
--                              that a valid write response is available
--  M_AXI_BREADY             -- Response ready - This signal indicates that
--                              the master can accept the response information
--
-- AXI Read address channel signals
--
--  M_AXI_ARID               -- Read address ID. This signal is the 
--                           -- identification tag for the read address group 
--                           -- of signals
--  M_AXI_ARADDR             -- Read address - The read address bus gives the
--                              initial address of a read burst transaction
--  M_AXI_ARPROT             -- Protection type - This signal provides
--                              protection unit information for the transaction
--  M_AXI_ARCACHE            -- Cache type. This signal provides additional 
--                              information about the cacheable 
--                           -- characteristics of the transfer
--  M_AXI_ARVALID            -- Read address valid - This signal indicates,
--                              when HIGH, that the read address and control
--                              information is valid and will remain stable
--                              until the address acknowledge signal,ARREADY,
--                              is high.
--  M_AXI_ARLEN              -- Burst length. The burst length gives the 
--                           -- exact number of transfers in a burst
--  M_AXI_ARSIZE             -- Burst size. This signal indicates the size of i
-- each transfer in the burst
--  M_AXI_ARBURST            -- Burst type. The burst type, coupled with the 
--                           -- size information, details how the address for
-- each transfer within the burst is calculated
--  M_AXI_ARLOCK             -- Lock type. This signal provides additional 
-- information about the atomic characteristics
-- of the transfer
--  M_AXI_ARREADY            -- Read address ready - This signal indicates
--                              that the slave is ready to accept an address
--                              and associated control signals:
--
-- AXI Read data channel signals
--
--  M_AXI_RID                -- Read ID tag. This signal is the ID tag of 
-- the read data group of signals
--  M_AXI_RDATA              -- Read data bus - fixed to 32
--  M_AXI_RRESP              -- Read response - This signal indicates the
--                              status of the read transfer
--  M_AXI_RVALID             -- Read valid - This signal indicates that the
--                              required read data is available and the read
--                              transfer can complete
--  M_AXI_RLAST              -- Read last. This signal indicates the 
--                           -- last transfer in a read burst
--  M_AXI_RREADY             -- Read ready - This signal indicates that the
--                              master can accept the read data and response
--                              information
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

entity axi_ttl_memory_bus is
  generic (
    -- ROM generics
    C_ADDR_WIDTH : integer range 4 to 16 := 16;
    C_DATA_WIDTH : integer range 4 to 8 := 8;

    -- Mapping generics
    C_MAPPED_ADDRESS : std_logic_vector := X"C0000000";
    C_USE_DYNAMIC_MAPPING : std_logic := '0';

    --Family Generics
    C_XLNX_REF_BOARD : string := "NONE";
    C_FAMILY : string := "virtex6";
    C_INSTANCE : string := "axi_ttl_memory_bus_inst";

    -- Master AXI Generics
    C_M_AXI_THREAD_ID_WIDTH : integer := 1;
    C_M_AXI_ADDR_WIDTH : integer := 32;
    C_M_AXI_DATA_WIDTH : integer := 32;
    C_M_AXI_PROTOCOL : string := "AXI4";

    -- Slave AXI-Lite Generics
    C_S_AXI_ADDR_WIDTH : integer range 8 to 8 := 8;
    C_S_AXI_DATA_WIDTH : integer range 32 to 32 := 32;
    C_S_AXI_PROTOCOL : string := "AXI4LITE"
    --C_BASEADDR                    : std_logic_vector := X"FFFFFFFF";
    --C_HIGHADDR                    : std_logic_vector := X"00000000"
  );
  port (
    -- ROM ports
    chip_enable : in std_logic := '0';
    output_enable : in std_logic;
    write_enable : in std_logic;
    addr : in std_logic_vector((C_ADDR_WIDTH - 1) downto 0);
    data : inout std_logic_vector((C_DATA_WIDTH - 1) downto 0);
    --mapping_addr            : in std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);

    -- AXI Global

    -- AXI signals
    M_AXI_ACLK : in std_logic; -- AXI clock
    M_AXI_ARESETN : in std_logic; -- AXI active low synchronous reset

    -- AXI Write Address Channel Signals
    --M_AXI_AWID         : out std_logic_vector 
    --                         (C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
    -- M_AXI_AWLEN : out std_logic_vector (7 downto 0);
    -- M_AXI_AWSIZE : out std_logic_vector (2 downto 0);
    -- M_AXI_AWBURST : out std_logic_vector (1 downto 0);
    -- --M_AXI_AWCACHE      : out std_logic_vector (3 downto 0);
    M_AXI_AWADDR : out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
    --M_AXI_AWPROT       : out std_logic_vector(2 downto 0);
    M_AXI_AWVALID : out std_logic;
    M_AXI_AWREADY : in std_logic;
    -- M_AXI_AWLOCK : out std_logic;
    -- AXI Write Data Channel Signals
    -- M_AXI_WID : out std_logic_vector
    -- (C_M_AXI_THREAD_ID_WIDTH - 1 downto 0);
    M_AXI_WDATA : out std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
    M_AXI_WSTRB : out std_logic_vector
    ((C_M_AXI_DATA_WIDTH/8) - 1 downto 0);
    -- M_AXI_WLAST : out std_logic;
    M_AXI_WVALID : out std_logic;
    M_AXI_WREADY : in std_logic;

    -- AXI Write Response Channel Signals
    --M_AXI_BID          : in  std_logic_vector 
    --                         (C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
    M_AXI_BRESP : in std_logic_vector(1 downto 0);
    M_AXI_BVALID : in std_logic;
    M_AXI_BREADY : out std_logic;

    -- AXI Read Address Channel Signals
    --M_AXI_ARID         : out std_logic_vector 
    --                         (C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
    M_AXI_ARLEN : out std_logic_vector(7 downto 0);
    -- M_AXI_ARSIZE : out std_logic_vector(2 downto 0);
    -- M_AXI_ARBURST : out std_logic_vector(1 downto 0);
    --M_AXI_ARPROT       : out std_logic_vector(2 downto 0);
    --M_AXI_ARCACHE      : out std_logic_vector(3 downto 0);
    M_AXI_ARVALID : out std_logic;
    M_AXI_ARADDR : out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
    -- M_AXI_ARLOCK : out std_logic;
    M_AXI_ARREADY : in std_logic;

    -- AXI Read Data Channel Sigals
    --M_AXI_RID          : in  std_logic_vector 
    --                         (C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
    M_AXI_RDATA : in std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
    M_AXI_RRESP : in std_logic_vector(1 downto 0);
    M_AXI_RVALID : in std_logic;
    -- M_AXI_RLAST : in std_logic;
    M_AXI_RREADY : out std_logic;

    -- AXI Slave Lite Interface - CFG Block
    S_AXI_ACLK : in std_logic;
    S_AXI_ARESETN : in std_logic;
    S_AXI_AWADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1
    downto 0);
    S_AXI_AWVALID : in std_logic;
    S_AXI_AWREADY : out std_logic;

    S_AXI_WDATA : in std_logic_vector(C_S_AXI_DATA_WIDTH - 1
    downto 0);
    S_AXI_WSTRB : in std_logic_vector((C_S_AXI_DATA_WIDTH/8) - 1
    downto 0);
    S_AXI_WVALID : in std_logic;
    S_AXI_WREADY : out std_logic;

    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_BVALID : out std_logic;
    S_AXI_BREADY : in std_logic;

    S_AXI_ARADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1
    downto 0);
    S_AXI_ARVALID : in std_logic;
    S_AXI_ARREADY : out std_logic;

    S_AXI_RDATA : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1
    downto 0);
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_RVALID : out std_logic;
    S_AXI_RREADY : in std_logic
  );

  -------------------------------------------------------------------------------
  -- fan-out attributes for XST
  -------------------------------------------------------------------------------

  attribute MAX_FANOUT : string;
  attribute MAX_FANOUT of M_AXI_ACLK : signal is "10000";
  attribute MAX_FANOUT of M_AXI_ARESETN : signal is "10000";
  attribute MAX_FANOUT of S_AXI_ACLK : signal is "10000";
  attribute MAX_FANOUT of S_AXI_ARESETN : signal is "10000";
  -------------------------------------------------------------------------------
  -- Attributes for MPD file
  -------------------------------------------------------------------------------
  attribute IP_GROUP : string;
  attribute IP_GROUP of axi_ttl_memory_bus : entity is "LOGICORE";
  attribute SIGIS : string;
  attribute SIGIS of M_AXI_ACLK : signal is "Clk";
  attribute SIGIS of M_AXI_ARESETN : signal is "Rst";
  attribute SIGIS of S_AXI_ACLK : signal is "Clk";
  attribute SIGIS of S_AXI_ARESETN : signal is "Rst";

end entity axi_ttl_memory_bus;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_ttl_memory_bus is

	component axi_slave
    generic (
      C_REGISTER_COUNT : integer := 1;
      C_S_AXI_ADDR_WIDTH : integer := 32;
      C_S_AXI_DATA_WIDTH : integer := 32
    );
    port (
    packed_registers : in std_logic_vector((C_REGISTER_COUNT * C_S_AXI_DATA_WIDTH) - 1 downto 0);
	  S_AXI_ACLK : in std_logic;
	  S_AXI_ARESETN : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
	  S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
		S_AXI_AWADDR : in std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
		S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
		S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic
    );
  end component;
  
  component axi_read
    generic (
      C_ADDR_WIDTH : integer := 8;
      C_DATA_WIDTH : integer := 0;
      C_M_AXI_ADDR_WIDTH : integer := 0;
      C_M_AXI_DATA_WIDTH : integer := 0
    );
    port (
      chipEnable : in std_logic;
      outputEnable : in std_logic;
      address : in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
      data : out std_logic_vector(C_DATA_WIDTH - 1 downto 0);
      baseAddress : in std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
      M_AXI_ARADDR : out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
      M_AXI_ARVALID : out std_logic;
      M_AXI_ARREADY : in std_logic;
      M_AXI_RDATA : in std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
      M_AXI_RVALID : in std_logic;
      M_AXI_RREADY : out std_logic
    );
  end component;

function flatten_registers(registers : register_array) return std_logic_vector is
  variable flat : std_logic_vector((registers'length * C_M_AXI_DATA_WIDTH) - 1 downto 0);
begin
  for i in registers'range loop
    flat((i * C_M_AXI_DATA_WIDTH) + (C_M_AXI_DATA_WIDTH-1) downto (i * C_M_AXI_DATA_WIDTH)) := registers(i);
  end loop;
  return flat;
end function;

  -------------------  Constant Declaration Section BEGIN -----------------------

  constant ZERO_ADDR_PAD : std_logic_vector(0 to 31)
  := (others => '0');

  constant BASEADDR : std_logic_vector(31 downto 0) := X"00000000";
  constant HIGHADDR : std_logic_vector(31 downto 0) := X"000000FF";

  constant ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
  (ZERO_ADDR_PAD & BASEADDR,
  ZERO_ADDR_PAD & HIGHADDR);
  constant ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE := (0 => 8);

  constant AXI_MIN_SIZE : std_logic_vector(31 downto 0) := X"000000FF";
  constant USE_WSTRB : integer := 1;
  constant DPHASE_TIMEOUT : integer := 0;

  constant REGISTER_COUNT : integer := 2;
  
  -------------------------------------------------------------------------------
  -- Signal and Type Declarations
  -------------------------------------------------------------------------------

  signal mapped_base_addr : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
  signal registers : register_array(0 to REGISTER_COUNT - 1)(C_S_AXI_DATA_WIDTH - 1 downto 0);
  
  -- AXI Lite Master
  -----------------------------------------------------------------------------
  -- IP Master Request/Qualifers
  -----------------------------------------------------------------------------
  signal ip2bus_mstrd_req : std_logic;
  signal ip2bus_mstwr_req : std_logic;
  signal ip2bus_mst_addr : std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
  signal ip2bus_mst_be : std_logic_vector((C_M_AXI_DATA_WIDTH/8) - 1 downto 0);
  signal ip2bus_mst_lock : std_logic;
  signal ip2bus_mst_reset : std_logic;

  -----------------------------------------------------------------------------
  -- IP Request Status Reply                                                            
  -----------------------------------------------------------------------------
  signal bus2ip_mst_cmdack : std_logic;
  signal bus2ip_mst_cmplt : std_logic;
  signal bus2ip_mst_error : std_logic;
  signal bus2ip_mst_rearbitrate : std_logic;
  signal bus2ip_mst_cmd_timeout : std_logic;

  -----------------------------------------------------------------------------
  -- IPIC Read data                                                                     
  -----------------------------------------------------------------------------
  signal bus2ip_mstrd_d : std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
  signal bus2ip_mstrd_src_rdy_n : std_logic;

  -----------------------------------------------------------------------------
  -- IPIC Write data                                                                    
  -----------------------------------------------------------------------------
  signal ip2bus_mstwr_d : std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
  signal bus2ip_mstwr_dst_rdy_n : std_logic;

  -- AXI Lite Slave
  signal bus2ip_clk : std_logic;
  signal bus2ip_resetn : std_logic;

  --IPIC request qualifier signals
  signal ip2bus_rdack : std_logic;
  signal ip2bus_wrack : std_logic;
  signal ip2bus_addrack : std_logic;
  signal ip2bus_error : std_logic;
  -- IPIC address, data signals
  signal ip2bus_data : std_logic_vector(0 to (C_S_AXI_DATA_WIDTH - 1));

  signal bus2ip_addr : std_logic_vector(0 to (C_S_AXI_ADDR_WIDTH - 1));

  -- Bus2IP_* Signals
  signal bus2ip_data : std_logic_vector((C_S_AXI_DATA_WIDTH - 1) downto 0);
  --
  signal bus2ip_rnw : std_logic;
  --
  signal bus2ip_cs : std_logic_vector
  (((ARD_ADDR_RANGE_ARRAY'LENGTH)/2) - 1 downto 0);

  signal bus2ip_rdce : std_logic_vector
  (0 to calc_num_ce(ARD_NUM_CE_ARRAY) - 1);
  signal bus2ip_wrce : std_logic_vector
  (0 to calc_num_ce(ARD_NUM_CE_ARRAY) - 1);
  --
  signal bus2ip_be : std_logic_vector((C_S_AXI_DATA_WIDTH/8) - 1 downto 0);
  signal bus2ip_burst : std_logic;

  -------------------------------------------------------------------------------
  -- Architecture
  -------------------------------------------------------------------------------

begin -- architecture IMP

  AXI_MASTER_LITE_I : entity axi_master_lite_v2_00_a.axi_master_lite
    generic map
    (
      C_M_AXI_LITE_ADDR_WIDTH => C_M_AXI_ADDR_WIDTH,
      C_M_AXI_LITE_DATA_WIDTH => C_M_AXI_DATA_WIDTH,
      --C_M_AXI_LITE_MIN_SIZE => AXI_MIN_SIZE,
      --C_USE_WSTRB => USE_WSTRB,
      --C_DPHASE_TIMEOUT => DPHASE_TIMEOUT,
      --C_ARD_ADDR_RANGE_ARRAY => ARD_ADDR_RANGE_ARRAY,
      --C_ARD_NUM_CE_ARRAY => ARD_NUM_CE_ARRAY,
      C_FAMILY => C_FAMILY
    )
    port map
    (
      m_axi_lite_aclk => M_AXI_ACLK,
      m_axi_lite_aresetn => M_AXI_ARESETN,
      m_axi_lite_awaddr => M_AXI_AWADDR,
      m_axi_lite_awvalid => M_AXI_AWVALID,
      m_axi_lite_awready => M_AXI_AWREADY,
      m_axi_lite_wdata => M_AXI_WDATA,
      m_axi_lite_wstrb => M_AXI_WSTRB,
      m_axi_lite_wvalid => M_AXI_WVALID,
      m_axi_lite_wready => M_AXI_WREADY,
      m_axi_lite_bresp => M_AXI_BRESP,
      m_axi_lite_bvalid => M_AXI_BVALID,
      m_axi_lite_bready => M_AXI_BREADY,
      m_axi_lite_araddr => M_AXI_ARADDR,
      m_axi_lite_arvalid => M_AXI_ARVALID,
      m_axi_lite_arready => M_AXI_ARREADY,
      m_axi_lite_rdata => M_AXI_RDATA,
      m_axi_lite_rresp => M_AXI_RRESP,
      m_axi_lite_rvalid => M_AXI_RVALID,
      m_axi_lite_rready => M_AXI_RREADY,

      -- ip interconnect (IPIC) port signals 
      -----------------------------------------------------------------------------
      -- IP Master Request/Qualifers
      -----------------------------------------------------------------------------
      ip2bus_mstrd_req => ip2bus_mstrd_req,
      ip2bus_mstwr_req => ip2bus_mstwr_req,
      ip2bus_mst_addr => ip2bus_mst_addr,
      ip2bus_mst_be => ip2bus_mst_be,
      ip2bus_mst_lock => ip2bus_mst_lock,
      ip2bus_mst_reset => ip2bus_mst_reset,

      -----------------------------------------------------------------------------
      -- IP Request Status Reply                                                            
      -----------------------------------------------------------------------------
      bus2ip_mst_cmdack => bus2ip_mst_cmdack,
      bus2ip_mst_cmplt => bus2ip_mst_cmplt,
      bus2ip_mst_error => bus2ip_mst_error,
      bus2ip_mst_rearbitrate => bus2ip_mst_rearbitrate,
      bus2ip_mst_cmd_timeout => bus2ip_mst_cmd_timeout,

      -----------------------------------------------------------------------------
      -- IPIC Read data                                                                     
      -----------------------------------------------------------------------------
      bus2ip_mstrd_d => bus2ip_mstrd_d,
      bus2ip_mstrd_src_rdy_n => bus2ip_mstrd_src_rdy_n,

      -----------------------------------------------------------------------------
      -- IPIC Write data                                                                    
      -----------------------------------------------------------------------------
      ip2bus_mstwr_d => ip2bus_mstwr_d,
      bus2ip_mstwr_dst_rdy_n => bus2ip_mstwr_dst_rdy_n
    );

--  AXI_LITE_IPIF_I : entity axi_lite_ipif_v1_01_a.axi_lite_ipif
--    generic map
--    (
--      C_S_AXI_ADDR_WIDTH => C_S_AXI_ADDR_WIDTH,
--      C_S_AXI_DATA_WIDTH => C_S_AXI_DATA_WIDTH,
--      C_S_AXI_MIN_SIZE => AXI_MIN_SIZE,
--      C_USE_WSTRB => USE_WSTRB,
--      C_DPHASE_TIMEOUT => DPHASE_TIMEOUT,
--      C_ARD_ADDR_RANGE_ARRAY => ARD_ADDR_RANGE_ARRAY,
--      C_ARD_NUM_CE_ARRAY => ARD_NUM_CE_ARRAY,
--      C_FAMILY => C_FAMILY
--    )
--    port map
--    (
--      S_AXI_ACLK => S_AXI_ACLK,
--      S_AXI_ARESETN => S_AXI_ARESETN,
--      S_AXI_AWADDR => S_AXI_AWADDR,
--      S_AXI_AWVALID => S_AXI_AWVALID,
--      S_AXI_AWREADY => S_AXI_AWREADY,
--      S_AXI_WDATA => S_AXI_WDATA,
--      S_AXI_WSTRB => S_AXI_WSTRB,
--      S_AXI_WVALID => S_AXI_WVALID,
--      S_AXI_WREADY => S_AXI_WREADY,
--      S_AXI_BRESP => S_AXI_BRESP,
--      S_AXI_BVALID => S_AXI_BVALID,
--      S_AXI_BREADY => S_AXI_BREADY,
--      S_AXI_ARADDR => S_AXI_ARADDR,
--      S_AXI_ARVALID => S_AXI_ARVALID,
--      S_AXI_ARREADY => S_AXI_ARREADY,
--      S_AXI_RDATA => S_AXI_RDATA,
--      S_AXI_RRESP => S_AXI_RRESP,
--      S_AXI_RVALID => S_AXI_RVALID,
--      S_AXI_RREADY => S_AXI_RREADY,
--
--      -- IP Interconnect (IPIC) port signals 
--      Bus2IP_Clk => bus2ip_clk,
--      Bus2IP_Resetn => bus2ip_resetn,
--      IP2Bus_Data => ip2bus_data,
--      IP2Bus_WrAck => ip2bus_wrack,
--      IP2Bus_RdAck => ip2bus_rdack,
--      IP2Bus_Error => ip2bus_error,
--      Bus2IP_Addr => bus2ip_addr,
--      Bus2IP_Data => bus2ip_data,
--      Bus2IP_RNW => bus2ip_rnw,
--      Bus2IP_BE => bus2ip_be,
--      Bus2IP_CS => bus2ip_cs,
--      Bus2IP_RdCE => bus2ip_rdce,
--      Bus2IP_WrCE => bus2ip_wrce
--    );

	AXI_SLAVE_I : entity axi_ttl_memory_bus_v1_00_a.axi_slave
    generic map
    (
      C_REGISTER_COUNT => C_REGISTER_COUNT,
      C_S_AXI_ADDR_WIDTH => C_S_AXI_ADDR_WIDTH,
      C_S_AXI_DATA_WIDTH => C_S_AXI_DATA_WIDTH
    )
    port map
    (
      packed_registers => flatten_registers(registers),
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_ARADDR => S_AXI_ARADDR,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_RDATA => S_AXI_RDATA,
      S_AXI_RRESP => S_AXI_RRESP,
      S_AXI_RVALID => S_AXI_RVALID,
      S_AXI_RREADY => S_AXI_RREADY,
      S_AXI_AWADDR => S_AXI_AWADDR,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_AWREADY => S_AXI_AWREADY,
      S_AXI_WDATA => S_AXI_WDATA,
      S_AXI_WVALID => S_AXI_WVALID,
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_BRESP => S_AXI_BRESP,
      S_AXI_BVALID => S_AXI_BVALID,
      S_AXI_BREADY => S_AXI_BREADY
    );
	 
end imp;
