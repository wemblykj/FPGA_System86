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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use std.textio.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.ipif_pkg.SLV64_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.INTEGER_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.calc_num_ce;

-------------------------------------------------------------------------------
-- axi_gpio_v1_01_b library is used for axi4 component declarations
-------------------------------------------------------------------------------
library axi_lite_ipif_v1_01_a; 

-------------------------------------------------------------------------------
-- axi_gpio_v1_01_b library is used for interrupt controller component 
-- declarations
-------------------------------------------------------------------------------

library interrupt_control_ex_v2_01_a;
use interrupt_control_ex_v2_01_a.interrupt_control_ex;

-------------------------------------------------------------------------------
-- axi_ttl_memory_bus_v1_00_a library is used for axi_ttl_memory_bus component declarations
-------------------------------------------------------------------------------

library axi_ttl_memory_bus_v1_00_a;
--use axi_ttl_memory_bus_v1_00_a.axi_ttl_memory_bus_reg;
--use axi_ttl_memory_bus_v1_00_a.axi_ttl_memory_bus_core;


-------------------------------------------------------------------------------
--                     Defination of Generics :                              --
-------------------------------------------------------------------------------
-- C_INTERRUPT_PRESENT    -- TTL memory bus interrupt.

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
--
-- IP2INTC_Irpt          -- AXI GPIO Interrupt
--
-- AXI Global Signals
-- S_AXI_ACLK            -- AXI Clock
-- S_AXI_ARESETN          -- AXI Reset
--
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
	C_CTRL_WIDTH : integer range 1 to 3 := 3;
    C_ADDR_WIDTH : integer range 4 to 16 := 16;
    C_DATA_WIDTH : integer range 4 to 8 := 8;
	
	-- Interfacing
	C_BUS_TYPE : integer range 0 to 1      	    := 0;
    -- Mapping generics
    C_MAPPED_BASEADDR : std_logic_vector := X"FFFFFFFF";
	C_MAPPED_SIZE : std_logic_vector := X"00000000";
    C_USE_DYNAMIC_MAPPING : integer range 0 to 1      	    := 0;

	 -- Interrupts
	 C_INTERRUPT_PRESENT    : integer range 0 to 1      	    := 0;

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
    C_S_AXI_ADDR_WIDTH : integer range 32 to 32 := 32;
    C_S_AXI_DATA_WIDTH : integer range 32 to 32 := 32;
    C_S_AXI_PROTOCOL : string := "AXI4LITE";
    C_BASEADDR                    : std_logic_vector := X"FFFFFFFF";
    C_HIGHADDR                    : std_logic_vector := X"00000000"
  );
  port (
	 -- Interrupt---------------------------------------------------------------
    IP2INTC_Irpt            : out std_logic;
	 
    -- AXI Global

    -- AXI signals
    M_AXI_ACLK : in std_logic; -- AXI clock
    M_AXI_ARESETN : in std_logic; -- AXI active low synchronous reset
	 
    M_AXI_AWADDR : out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
    M_AXI_AWVALID : out std_logic;
    M_AXI_AWREADY : in std_logic;
	 
    M_AXI_WDATA : out std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
    M_AXI_WSTRB : out std_logic_vector((C_M_AXI_DATA_WIDTH/8) - 1 downto 0);
    M_AXI_WVALID : out std_logic;
    M_AXI_WREADY : in std_logic;

    -- AXI Write Response Channel Signals
    M_AXI_BRESP : in std_logic_vector(1 downto 0);
    M_AXI_BVALID : in std_logic;
    M_AXI_BREADY : out std_logic;

    -- AXI Read Address Channel Signals
    M_AXI_ARVALID : out std_logic;
    M_AXI_ARADDR : out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
    M_AXI_ARREADY : in std_logic;

    -- AXI Read Data Channel Sigals
    M_AXI_RDATA : in std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
    M_AXI_RRESP : in std_logic_vector(1 downto 0);
    M_AXI_RVALID : in std_logic;
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
    S_AXI_RREADY : in std_logic;
	 
	 -- ROM ports
    nChipEnable : in std_logic;
    nOutputEnable : in std_logic;
    nWriteEnable : in std_logic;
    Address : in std_logic_vector((C_ADDR_WIDTH - 1) downto 0);
	 DataIn : in std_logic_vector((C_DATA_WIDTH - 1) downto 0);
	 DataOut : out std_logic_vector((C_DATA_WIDTH - 1) downto 0);
    DataT : in std_logic  
	 

	 
    -- Mapping
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
  attribute SIGIS of IP2INTC_Irpt  	: signal is "INTR_LEVEL_HIGH";

end entity axi_ttl_memory_bus;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_ttl_memory_bus is

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

  constant C_CORE_GENERATION_INFO : string := C_INSTANCE & ",axi_ttl_memory_bus,{"
    & "C_FAMILY = "              &  C_FAMILY
    & ",C_INSTANCE = "           &  C_INSTANCE
    & ",C_S_AXI_DATA_WIDTH = "   & integer'image(C_S_AXI_DATA_WIDTH)
	 & ",C_CTRL_WIDTH = "         & integer'image(C_CTRL_WIDTH)
    & ",C_ADDR_WIDTH = "         & integer'image(C_ADDR_WIDTH)
    & ",C_DATA_WIDTH = "         & integer'image(C_DATA_WIDTH)
	 & ",C_MAPPED_BASEADDR = "     & str(C_MAPPED_BASEADDR)
    & ",C_USE_DYNAMIC_MAPPING = "         & integer'image(C_USE_DYNAMIC_MAPPING)
    & ",C_INTERRUPT_PRESENT = "  & integer'image(C_INTERRUPT_PRESENT)
    & "}";

  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of imp : architecture is C_CORE_GENERATION_INFO;

type     bo2na_type is array (boolean) of natural; -- boolean to 
							--natural conversion
constant bo2na      :  bo2na_type := (false => 0, true => 1);

-------------------------------------------------------------------------------
-- Function Declarations
-------------------------------------------------------------------------------

type BOOLEAN_ARRAY_TYPE is array(natural range <>) of boolean;

----------------------------------------------------------------------------
-- This function returns the number of elements that are true in
-- a boolean array.
----------------------------------------------------------------------------
function num_set( ba : BOOLEAN_ARRAY_TYPE ) return natural is
	 variable n : natural := 0;
begin
	 for i in ba'range loop
		  n := n + bo2na(ba(i));
	 end loop;
	 return n;
end;

----------------------------------------------------------------------------
-- This function returns a num_ce integer array that is constructed by
-- taking only those elements of superset num_ce integer array
-- that will be defined by the current case.
-- The superset num_ce array is given by parameter num_ce_by_ard.
-- The current case the ard elements that will be used is given
-- by parameter defined_ards.
----------------------------------------------------------------------------
function qual_ard_num_ce_array( defined_ards  : BOOLEAN_ARRAY_TYPE;
										  num_ce_by_ard : INTEGER_ARRAY_TYPE
										) return INTEGER_ARRAY_TYPE is
	 variable res : INTEGER_ARRAY_TYPE(num_set(defined_ards)-1 downto 0);
	 variable i : natural := 0;
	 variable j : natural := defined_ards'left;
begin
	 while i /= res'length loop
			 -- coverage off
		  while defined_ards(j) = false loop
				j := j+1;
		  end loop;
			 -- coverage on
		  res(i) := num_ce_by_ard(j);
		  i := i+1;
		  j := j+1;
	 end loop;
	 return res;
end;


----------------------------------------------------------------------------
-- This function returns a addr_range array that is constructed by
-- taking only those elements of superset addr_range array
-- that will be defined by the current case.
-- The superset addr_range array is given by parameter addr_range_by_ard.
-- The current case the ard elements that will be used is given
-- by parameter defined_ards.
----------------------------------------------------------------------------
function qual_ard_addr_range_array( defined_ards      : BOOLEAN_ARRAY_TYPE;
												addr_range_by_ard : SLV64_ARRAY_TYPE
											 ) return SLV64_ARRAY_TYPE is
	 variable res : SLV64_ARRAY_TYPE(0 to 2*num_set(defined_ards)-1);
	 variable i : natural := 0;
	 variable j : natural := defined_ards'left;
begin
	 while i /= res'length loop
			 -- coverage off
		  while defined_ards(j) = false loop
				j := j+1;
		  end loop;
			 -- coverage on        
		  res(i)   := addr_range_by_ard(2*j);
		  res(i+1) := addr_range_by_ard((2*j)+1);
		  i := i+2;
		  j := j+1;
	 end loop;
	 return res;
end;

function qual_ard_ce_valid( defined_ards      : BOOLEAN_ARRAY_TYPE
											 ) return std_logic_vector is
	 variable res : std_logic_vector(0 to 31);
begin
		res := (others => '0');
	 if defined_ards(defined_ards'right) then
		res(0 to 3) := "1111";
		res(12) := '1';
		res(13) := '1';
		res(15) := '1';
	 else
		res(0 to 3) := "1111";
	 end if;
	 return res;
end;
  -------------------  Constant Declaration Section BEGIN -----------------------

constant IP_NUM_INTR       : integer   := 3;
constant IP_NUM_REG   : integer   := 4;

constant BASEADDR : std_logic_vector(31 downto 0) := X"00000000";
constant HIGHADDR : std_logic_vector(31 downto 0) := X"000000FF";

constant INTR_BASEADDR  : std_logic_vector(0 to 31):= X"00000100";
constant INTR_HIGHADDR  : std_logic_vector(0 to 31):= X"000001FF";

constant AXI_MIN_SIZE : std_logic_vector(31 downto 0) := X"000000FF";

constant ZERO_ADDR_PAD : std_logic_vector(0 to 31)
	:= (others => '0');

constant INTR_TYPE      : integer   := 5;

constant ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
	qual_ard_addr_range_array(
		(true,C_INTERRUPT_PRESENT=1),
		(ZERO_ADDR_PAD & BASEADDR, 
		 ZERO_ADDR_PAD & HIGHADDR,
		 ZERO_ADDR_PAD & INTR_BASEADDR,
		 ZERO_ADDR_PAD & INTR_HIGHADDR
		)
);

constant ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE :=
	qual_ard_num_ce_array(
		(true,C_INTERRUPT_PRESENT=1),
		(IP_NUM_REG,16)
);  

constant ARD_CE_VALID : std_logic_vector(0 to 31) :=
	qual_ard_ce_valid(
		(true,C_INTERRUPT_PRESENT=1)
);

constant IP_INTR_MODE_ARRAY : INTEGER_ARRAY_TYPE(0 to IP_NUM_INTR)
						:= (others => 5);
								 
constant USE_WSTRB : integer := 1;
constant DPHASE_TIMEOUT : integer := 0;
  
  -------------------------------------------------------------------------------
  -- Signal and Type Declarations
  -------------------------------------------------------------------------------

-- Memory bus control
signal controlReg : std_logic_vector(31 downto 0);
signal statusReg : std_logic_vector(31 downto 0);

-- Bus control lines state
signal busControlReadReg : std_logic_vector(C_CTRL_WIDTH-1 downto 0);
-- Address bus state
signal busAddressReadReg : std_logic_vector(C_ADDR_WIDTH-1 downto 0);
-- Address bus update
signal busAddressWriteReg : std_logic_vector(C_ADDR_WIDTH-1 downto 0);
-- Data bus state
signal busDataReadReg : std_logic_vector(C_DATA_WIDTH-1 downto 0);
-- Data bus update
signal busDataWriteReg : std_logic_vector(C_DATA_WIDTH-1 downto 0);

-- Data interface
signal data : std_logic_vector(C_DATA_WIDTH-1 downto 0);

-- Interrupt
--signal addrReqIntrEvent     : std_logic;
--signal dataReadIntrEvent     : std_logic;
--signal dataWriteIntrEvent     : std_logic;
signal ip2bus_intrevent     : std_logic_vector(0 to IP_NUM_INTR);
signal intr2ip_status       : std_logic_vector(0 to IP_NUM_INTR);
signal intr2ip_enable       : std_logic_vector(0 to IP_NUM_INTR);

-- Mapping
signal mappedAddressReg : std_logic_vector(31 downto 0);

-- IPIC Used Signals

signal ip2bus_data    : std_logic_vector(0 to C_S_AXI_DATA_WIDTH-1);
signal ip2bus_rdack   : std_logic;
signal ip2bus_wrack   : std_logic;
signal ip2bus_error   : std_logic;

signal bus2ip_addr    : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH-1);
signal bus2ip_data    : std_logic_vector(0 to C_S_AXI_DATA_WIDTH-1);
signal bus2ip_rnw     : std_logic;
signal bus2ip_cs      : std_logic_vector(0 to 0 + bo2na
						      (C_INTERRUPT_PRESENT=1));
signal bus2ip_rdce    : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
signal bus2ip_wrce    : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);

signal Intrpt_bus2ip_rdce              : std_logic_vector(0 to 15);
signal Intrpt_bus2ip_wrce              : std_logic_vector(0 to 15);
signal intr_wr_ce_or_reduce            : std_logic; 
signal intr_rd_ce_or_reduce  	       : std_logic;
signal ip2Bus_RdAck_intr_reg_hole      : std_logic;
signal ip2Bus_RdAck_intr_reg_hole_d1   : std_logic;
signal ip2Bus_WrAck_intr_reg_hole      : std_logic;
signal ip2Bus_WrAck_intr_reg_hole_d1   : std_logic;

signal bus2ip_be      : std_logic_vector(0 to (C_S_AXI_DATA_WIDTH / 8) - 1);
signal bus2ip_clk     : std_logic;
signal bus2ip_reset   : std_logic;
signal bus2ip_resetn  : std_logic;
signal intr2bus_data  : std_logic_vector(0 to C_S_AXI_DATA_WIDTH-1);
signal intr2bus_wrack : std_logic;
signal intr2bus_rdack : std_logic;
signal intr2bus_error : std_logic;

signal ip2bus_data_i      : std_logic_vector(0 to C_S_AXI_DATA_WIDTH-1);
signal ip2bus_data_i_D1   : std_logic_vector(0 to C_S_AXI_DATA_WIDTH-1);
signal ip2bus_wrack_i     : std_logic;
signal ip2bus_wrack_i_D1  : std_logic;
signal ip2bus_rdack_i     : std_logic;
signal ip2bus_rdack_i_D1  : std_logic;
signal ip2bus_error_i     : std_logic;
signal IP2INTC_Irpt_i     : std_logic;

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
        IP2Bus_Data    => ip2bus_data_i_D1,
        IP2Bus_WrAck   => ip2bus_wrack_i_D1,
        IP2Bus_RdAck   => ip2bus_rdack_i_D1,
        --IP2Bus_WrAck   => ip2bus_wrack_i,
        --IP2Bus_RdAck   => ip2bus_rdack_i,
        IP2Bus_Error   => ip2bus_error_i,
        Bus2IP_Addr    => bus2ip_addr,
        Bus2IP_Data    => bus2ip_data,
        Bus2IP_RNW     => bus2ip_rnw,
        Bus2IP_BE      => bus2ip_be,
        Bus2IP_CS      => bus2ip_cs,
        Bus2IP_RdCE    => bus2ip_rdce,
        Bus2IP_WrCE    => bus2ip_wrce
       );

	

    ip2bus_data_i   <= intr2bus_data or ip2bus_data;
    
    ip2bus_wrack_i  <= intr2bus_wrack 			    or 
               	       ip2bus_wrack or
               	       ip2Bus_WrAck_intr_reg_hole;-- Holes in Address range
               	       
    ip2bus_rdack_i  <= intr2bus_rdack                  or 
    		       ip2bus_rdack or
    		       ip2Bus_RdAck_intr_reg_hole; -- Holes in Address range
    	
    	       
    I_WRACK_RDACK_DELAYS: process(bus2ip_clk) is
    begin
       if (bus2ip_clk'event and bus2ip_clk = '1') then
         if (bus2ip_reset = '1') then
        	ip2bus_wrack_i_D1     <= '0';
        	ip2bus_rdack_i_D1     <= '0';
        	ip2bus_data_i_D1      <= (others => '0');
         else
        	ip2bus_wrack_i_D1     <= ip2bus_wrack_i;
        	ip2bus_rdack_i_D1     <= ip2bus_rdack_i;
        	ip2bus_data_i_D1      <= ip2bus_data_i;
         end if;
       end if;
    end process I_WRACK_RDACK_DELAYS;   
      
      
    ip2bus_error_i  <= intr2bus_error or ip2bus_error;

  ----------------------
  --REG_RESET_FROM_IPIF: convert active low to active hig reset to rest of
  --                     the core.
  ----------------------
  REG_RESET_FROM_IPIF: process (S_AXI_ACLK) is
  begin
       if(S_AXI_ACLK'event and S_AXI_ACLK = '1') then
           bus2ip_reset <= not(bus2ip_resetn);
       end if;
  end process REG_RESET_FROM_IPIF;
    ---------------------------------------------------------------------------
    -- Interrupts
    ---------------------------------------------------------------------------

    INTR_CTRLR_GEN : if (C_INTERRUPT_PRESENT = 1) generate
         constant NUM_IPIF_IRPT_SRC     : natural := 1;
         constant NUM_CE                : integer := 16;

         signal errack_reserved         : std_logic_vector(0 to 1);
         signal ipif_lvl_interrupts     : std_logic_vector(0 to 
         						NUM_IPIF_IRPT_SRC-1);
    begin

      ipif_lvl_interrupts    <= (others => '0');  
      errack_reserved        <= (others => '0');
      
      
      --- Addr 0X11c, 0X120, 0X128 valid addresses, remaining are holes 
      
      Intrpt_bus2ip_rdce <= "0000000" & bus2ip_rdce(11) & bus2ip_rdce(12) & '0'
				      & bus2ip_rdce(14)	& "00000";
				      
      Intrpt_bus2ip_wrce <= "0000000" & bus2ip_wrce(11) & bus2ip_wrce(12) & '0'
				      & bus2ip_wrce(14)	& "00000";
				      
				      
      intr_rd_ce_or_reduce <= or_reduce(bus2ip_rdce(4 to 10)) or
                                    bus2ip_rdce(13)      or
   				    or_reduce(bus2ip_rdce(15 to 19));
   				    
      intr_wr_ce_or_reduce <= or_reduce(bus2ip_wrce(4 to 10)) or
                                    bus2ip_wrce(13)      or
   				    or_reduce(bus2ip_wrce(15 to 19));   
   				    
      I_READ_ACK_INTR_HOLES: process(bus2ip_clk) is
      begin
         if (bus2ip_clk'event and bus2ip_clk = '1') then
           if (bus2ip_reset = '1') then
     	  	ip2Bus_RdAck_intr_reg_hole     <= '0';
     	  	ip2Bus_RdAck_intr_reg_hole_d1  <= '0';
           else
     	  	ip2Bus_RdAck_intr_reg_hole_d1 <= intr_rd_ce_or_reduce;
     	  	ip2Bus_RdAck_intr_reg_hole    <= intr_rd_ce_or_reduce and
     					   (not ip2Bus_RdAck_intr_reg_hole_d1);
           end if;
         end if;
      end process I_READ_ACK_INTR_HOLES;   
      
      
      
       I_WRITE_ACK_INTR_HOLES: process(bus2ip_clk) is
       begin
          if (bus2ip_clk'event and bus2ip_clk = '1') then
           if (bus2ip_reset = '1') then
                ip2Bus_WrAck_intr_reg_hole     <= '0';
                ip2Bus_WrAck_intr_reg_hole_d1  <= '0';
            else
                ip2Bus_WrAck_intr_reg_hole_d1 <= intr_wr_ce_or_reduce;
                ip2Bus_WrAck_intr_reg_hole    <= intr_wr_ce_or_reduce and
                                            (not ip2Bus_WrAck_intr_reg_hole_d1);
            end if;
          end if;
       end process I_WRITE_ACK_INTR_HOLES;

   				    
      interrupt_control_ex_I : entity interrupt_control_ex
        generic map
        (
          C_NUM_CE                => NUM_CE,
          C_NUM_IPIF_IRPT_SRC     => NUM_IPIF_IRPT_SRC,   
          C_IP_INTR_MODE_ARRAY    => IP_INTR_MODE_ARRAY,
          C_INCLUDE_DEV_PENCODER  => false,
          C_INCLUDE_DEV_ISC       => false,
          C_IPIF_DWIDTH           => C_S_AXI_DATA_WIDTH
        )
        port map
        (
          -- Inputs From the IPIF Bus 
          Bus2IP_Clk           => bus2ip_clk,
          Bus2IP_Reset         => bus2ip_reset, 
          Bus2IP_Data          => bus2ip_data,
          Bus2IP_BE            => bus2ip_be,
          Interrupt_RdCE       => Intrpt_bus2ip_rdce,
          Interrupt_WrCE       => Intrpt_bus2ip_wrce,

          -- Interrupt inputs from the IPIF sources that will 
          -- get registered in this design
          IPIF_Reg_Interrupts  => errack_reserved,     

          -- Level Interrupt inputs from the IPIF sources
          IPIF_Lvl_Interrupts  => ipif_lvl_interrupts,     

          -- Inputs from the IP Interface  
          IP2Bus_IntrEvent     => ip2bus_intrevent(IP_INTR_MODE_ARRAY'range),  

          -- Final Device Interrupt Output
          Intr2Bus_DevIntr     => IP2INTC_Irpt_i,       

          -- Status Reply Outputs to the Bus 
          Intr2Bus_DBus        => intr2bus_data,           
          Intr2Bus_WrAck       => intr2bus_wrack,   
          Intr2Bus_RdAck       => intr2bus_rdack,   
          Intr2Bus_Error       => intr2bus_error,   
          Intr2Bus_Retry       => open,          
          Intr2Bus_ToutSup     => open,

		  Intr2IP_IntrStatus   => intr2ip_status,
		  Intr2IP_IntrEnable   => intr2ip_enable
        );

       -- registering interrupt
       I_INTR_DELAY: process(bus2ip_clk) is
       begin
          if (bus2ip_clk'event and bus2ip_clk = '1') then
            if (bus2ip_reset = '1') then
           	IP2INTC_Irpt          <= '0';
            else
           	IP2INTC_Irpt          <= IP2INTC_Irpt_i;
            end if;
          end if;
       end process I_INTR_DELAY;   
      
    end generate INTR_CTRLR_GEN;
    -----------------------------------------------------------------------
    -- Assigning the intr2bus signal to zero's when interrupt is not 
    -- present
    -----------------------------------------------------------------------
    REMOVE_INTERRUPT : if (C_INTERRUPT_PRESENT = 0) generate

         intr2bus_data     <=  (others => '0');
         IP2INTC_Irpt      <=  '0';
         intr2bus_error    <=  '0'; 
         intr2bus_rdack    <=  '0'; 
         intr2bus_wrack    <=  '0'; 
         ip2Bus_WrAck_intr_reg_hole    <=  '0';
         ip2Bus_RdAck_intr_reg_hole    <=  '0';

    end generate REMOVE_INTERRUPT; 
	
------------------------------------------------------------------------
-- Instantiate axi_ttl_memory_bus_reg
------------------------------------------------------------------------
    Inst_AxiHDMIReg: entity axi_ttl_memory_bus_v1_00_a.axi_ttl_memory_bus_reg
    generic map(
	     C_CTRL_WIDTH            => C_CTRL_WIDTH,
        C_ADDR_WIDTH            => C_ADDR_WIDTH,
        C_DATA_WIDTH            => C_DATA_WIDTH,
        C_SLV_DWIDTH            => C_S_AXI_DATA_WIDTH,
        C_MAPPED_BASEADDR        => C_MAPPED_BASEADDR,
        C_USE_DYNAMIC_MAPPING   => C_USE_DYNAMIC_MAPPING)
    port map(
        Control                 => controlReg,
        Status                  => statusReg,
        MappedAddress           => mappedAddressReg,

        BusControlRead          => busControlReadReg,

        BusAddressRead          => busAddressReadReg,
        BusAddressWrite	        => busAddressWriteReg,
        
        BusDataRead				  => busDataReadReg,
        BusDataWrite				  => busDataWriteReg,
        
        Bus2IP_Clk              => bus2ip_clk,
        Bus2IP_Resetn           => bus2ip_resetn,
		  Bus2IP_Data             => bus2ip_data,
        Bus2IP_BE               => bus2ip_be,
        Bus2IP_RdCE             => bus2ip_rdce(0 to IP_NUM_REG-1),
        Bus2IP_WrCE             => bus2ip_wrce(0 to IP_NUM_REG-1),
        IP2Bus_Data             => ip2bus_data,
        IP2Bus_RdAck            => ip2bus_rdack,
        IP2Bus_WrAck            => ip2bus_wrack,
        IP2Bus_Error            => ip2bus_error); 
		
------------------------------------------------------------------------
-- Instantiate the AXI memory bus master
------------------------------------------------------------------------

	 data    <= DataIn when DataT = '1' else (others => 'Z');
	 DataOut <= data;

    Inst_AxiBusCore: entity axi_ttl_memory_bus_v1_00_a.axi_ttl_memory_bus_core
    generic map(
	     C_CTRL_WIDTH            => C_CTRL_WIDTH,
        C_ADDR_WIDTH        	  => C_ADDR_WIDTH,
        C_DATA_WIDTH        	  => C_DATA_WIDTH,
        C_MAPPED_BASEADDR          => C_MAPPED_BASEADDR,
        C_USE_DYNAMIC_MAPPING	  => C_USE_DYNAMIC_MAPPING,
		  C_INTERRUPT_PRESENT 		=> C_INTERRUPT_PRESENT,
        C_M_AXI_DATA_WIDTH        => C_M_AXI_DATA_WIDTH,
        C_M_AXI_ADDR_WIDTH        => C_M_AXI_ADDR_WIDTH,
        C_FAMILY                  => C_FAMILY,
        C_MST_AWIDTH              => 32,
        C_MST_DWIDTH              => 32)
    port map(
        nChipEnable		  		  => nChipEnable,
        nOutputEnable			  => nOutputEnable,
        nWriteEnable			     => nWriteEnable,
        Address					  => Address,
        Data					     => data,
        MappedAddress           => mappedAddressReg,
        	
        ControlReg				  => controlReg,
        StatusReg				     => statusReg,
        
		  BusControlReadReg		  => busControlReadReg,
		  
        BusAddressReadReg		  => busAddressReadReg,
        BusAddressWriteReg		  => busAddressWriteReg,
								  
        BusDataReadReg			  => busDataReadReg,
        BusDataWriteReg			  => busDataWriteReg,
        
			AddrReqIntr               => ip2bus_intrevent(0),
			AddrReqIntrStatus         => intr2ip_status(0),
			AddrReqIntrEnable         => intr2ip_enable(0),
		
        DataReadReqIntr              => ip2bus_intrevent(1),
			DataReadReqIntrStatus        => intr2ip_status(1),
			DataReadReqIntrEnable        => intr2ip_enable(1),
		
        DataWriteReqIntr             => ip2bus_intrevent(2),
        DataWriteReqIntrStatus       => intr2ip_status(2),  
			DataWriteReqIntrEnable       => intr2ip_enable(2),
        
        M_AXI_ACLK                => M_AXI_ACLK,
        M_AXI_ARESETN             => M_AXI_ARESETN,
							      
        M_AXI_AWADDR              => M_AXI_AWADDR,
        M_AXI_AWVALID             => M_AXI_AWVALID,
        M_AXI_AWREADY             => M_AXI_AWREADY,
		  
        M_AXI_WDATA               => M_AXI_WDATA,
        M_AXI_WSTRB               => M_AXI_WSTRB,
        M_AXI_WVALID              => M_AXI_WVALID,
        M_AXI_WREADY              => M_AXI_WREADY,
								  
        M_AXI_BRESP               => M_AXI_BRESP,
        M_AXI_BVALID              => M_AXI_BVALID,
        M_AXI_BREADY              => M_AXI_BREADY,
								  
        M_AXI_ARADDR              => M_AXI_ARADDR,
        M_AXI_ARVALID             => M_AXI_ARVALID,
        M_AXI_ARREADY             => M_AXI_ARREADY,
								  
        M_AXI_RREADY              => M_AXI_RREADY,
        M_AXI_RDATA               => M_AXI_RDATA,
        M_AXI_RRESP               => M_AXI_RRESP,
        M_AXI_RVALID              => M_AXI_RVALID);
	 
end imp;
