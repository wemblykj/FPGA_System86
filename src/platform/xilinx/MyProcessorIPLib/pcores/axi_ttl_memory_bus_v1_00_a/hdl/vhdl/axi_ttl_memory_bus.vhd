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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.ipif_pkg.SLV64_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.INTEGER_ARRAY_TYPE;
use proc_common_v3_00_a.ipif_pkg.calc_num_ce;


-------------------------------------------------------------------------------
-- axi_ttl_memory_bus_v1_00_a library is used for axi_ttl_memory_bus component declarations
-------------------------------------------------------------------------------

library axi_ttl_memory_bus_v1_00_a;


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
    C_ADDR_WIDTH : integer range 4 to 16 := 16;
    C_DATA_WIDTH : integer range 4 to 8 := 8;

    -- Mapping generics
    C_MAPPED_ADDRESS : std_logic_vector := X"FFFFFFFF";
    C_USE_DYNAMIC_MAPPING : std_logic := '0';

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
    -- ROM ports
    nChipEnable : in std_logic;
    nOutputEnable : in std_logic;
    nWriteEnable : in std_logic;
    Address : in std_logic_vector((C_ADDR_WIDTH - 1) downto 0);
    Data : inout std_logic_vector((C_DATA_WIDTH - 1) downto 0);
	 
    -- Mapping
    MappedAddress            : in std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);

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
  attribute SIGIS of IP2INTC_Irpt  	: signal is "INTR_LEVEL_HIGH";

end entity axi_ttl_memory_bus;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_ttl_memory_bus is

component axi_ttl_memory_bus_master_top
    generic (
    C_ADDR_WIDTH 		: integer 		:= 16;
    C_DATA_WIDTH 		: integer 		:= 8;
  	C_MAPPED_ADDRESS        : std_logic_vector   	:= X"FFFFFFFF";
    C_USE_DYNAMIC_MAPPING : std_logic := '0';
    C_M_AXI_ADDR_WIDTH 	: integer 		:= 32;
    C_M_AXI_DATA_WIDTH 	: integer 		:= 32;
    C_FAMILY : string := "virtex6";
    C_MST_AWIDTH 	: integer 		:= 32;
    C_MST_DWIDTH 	: integer 		:= 32
    );
    port (
      nChipEnable 		: in std_logic;
      nOutputEnable 		: in std_logic;
      nWriteEnable 		: in std_logic;
      Address 				: in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
      Data 					  : inout std_logic_vector(C_DATA_WIDTH - 1 downto 0);
      MappedAddress 	: in std_logic_vector(C_MST_AWIDTH - 1 downto 0);
      Interrupt       : out std_logic;

      ControlReg			: in std_logic_vector(C_MST_DWIDTH - 1 downto 0);
      StatusReg 			: out std_logic_vector(C_MST_DWIDTH - 1 downto 0);			
		
      BusAddressReadReg 		  : out std_logic_vector(C_MST_DWIDTH - 1 downto 0);			
      BusAddressWriteReg 		: in std_logic_vector(C_MST_DWIDTH - 1 downto 0);			
      
      BusDataReadReg 		  : out std_logic_vector(C_MST_DWIDTH - 1 downto 0);			
      BusDataWriteReg 		: in std_logic_vector(C_MST_DWIDTH - 1 downto 0);			
    
      IntrEnableReg 	: in std_logic_vector(C_MST_DWIDTH - 1 downto 0);			
      IntrStatusReg		: out std_logic_vector(C_MST_DWIDTH - 1 downto 0);
      IntrAckReg		  : in std_logic_vector(C_MST_DWIDTH - 1 downto 0);
		
      M_AXI_ACLK              	: in  std_logic;
      M_AXI_ARESETN           	: in  std_logic;
		
      M_AXI_AWADDR 		: out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
      M_AXI_AWVALID 		: out std_logic;
      M_AXI_AWREADY 		: in std_logic;
		
      M_AXI_WDATA 		: out std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
      M_AXI_WSTRB : out std_logic_vector ((C_M_AXI_DATA_WIDTH/8) - 1 downto 0);
      M_AXI_WVALID 		: out std_logic;
      M_AXI_WREADY 		: in std_logic;
		
      M_AXI_BRESP             	: in std_logic_vector(1 downto 0);
      M_AXI_BVALID            	: in std_logic;
      M_AXI_BREADY            	: out std_logic;
		
      M_AXI_ARADDR 		: out std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
      M_AXI_ARVALID 		: out std_logic;
      M_AXI_ARREADY 		: in std_logic;
		
      M_AXI_RDATA 		: in std_logic_vector(C_M_AXI_DATA_WIDTH - 1 downto 0);
      M_AXI_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_RVALID 		: in std_logic;
      M_AXI_RREADY 		: out std_logic
    );
end component;

component axi_ttl_memory_bus_reg_top
    generic(
        C_MAPPED_ADDRESS        : std_logic_vector   	:= X"FFFFFFFF";
        C_USE_DYNAMIC_MAPPING	: std_logic  			:= '0';
		  
        C_S_AXI_DATA_WIDTH      : integer           := 32;
        C_S_AXI_ADDR_WIDTH      : integer           := 32;
        C_S_AXI_MIN_SIZE        : std_logic_vector  := X"000001FF";
        C_USE_WSTRB             : integer           := 0;
        C_DPHASE_TIMEOUT        : integer           := 8;
        C_BASEADDR              : std_logic_vector  := X"FFFFFFFF";
        C_HIGHADDR              : std_logic_vector  := X"00000000";
        C_FAMILY                : string            := "virtex6";
        C_SLV_AWIDTH            : integer           := 32;
        C_SLV_DWIDTH            : integer           := 32);
    port(
        Control    				  : out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
        Status       			  : in std_logic_vector(C_SLV_DWIDTH-1 downto 0);
        MappedAddress  			: out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
		  
        -- The current state of the addressbus when an interrupt occurs
        BusAddressRead 			      : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        -- Any changes made to this register will be written back 
        -- to the bus when after interrupt has been acknowledged
        BusAddressWrite 			      : in std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        
        -- The current state of the data bus when an interrupt occurs
        BusDataRead 			      : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        -- Any changes made to this register will be written back 
        -- to the bus when after interrupt has been acknowledged
        BusDataWrite 			      : in std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        
        -- Bus interrupt enable mask
        IntrEnable	        : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        -- Bus interrupt status mask
        IntrStatus	        : in std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        -- Bus interrupt acknowledge mask
        IntrAck 	          : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
      
        S_AXI_ACLK              : in  std_logic;
        S_AXI_ARESETN           : in  std_logic;
        S_AXI_AWADDR            : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWVALID           : in  std_logic;
        S_AXI_AWREADY           : out std_logic;
        S_AXI_WDATA             : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB             : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        S_AXI_WVALID            : in  std_logic;
        S_AXI_WREADY            : out std_logic;
        S_AXI_BRESP             : out std_logic_vector(1 downto 0);
        S_AXI_BVALID            : out std_logic;
        S_AXI_BREADY            : in  std_logic;
        S_AXI_ARADDR            : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARVALID           : in  std_logic;
        S_AXI_ARREADY           : out std_logic;
        S_AXI_RDATA             : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP             : out std_logic_vector(1 downto 0);
        S_AXI_RVALID            : out std_logic;
        S_AXI_RREADY            : in  std_logic);
end component;
  
-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------

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

  constant ZERO_ADDR_PAD : std_logic_vector(0 to 31)
  := (others => '0');

	constant INTR_TYPE      : integer   := 5;

	constant INTR_BASEADDR  : std_logic_vector(0 to 31):= X"00000100";
	constant INTR_HIGHADDR  : std_logic_vector(0 to 31):= X"000001FF";

  constant BASEADDR : std_logic_vector(31 downto 0) := X"00000000";
  constant HIGHADDR : std_logic_vector(31 downto 0) := X"000000FF";

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
                (4,16)
    );  

	constant ARD_CE_VALID : std_logic_vector(0 to 31) :=
    qual_ard_ce_valid(
      (true,C_INTERRUPT_PRESENT=1)
    );

  constant IP_INTR_MODE_ARRAY : INTEGER_ARRAY_TYPE(0 to 0)
                            := (others => 5);
									 
  constant AXI_MIN_SIZE : std_logic_vector(31 downto 0) := X"000000FF";
  constant USE_WSTRB : integer := 1;
  constant DPHASE_TIMEOUT : integer := 0;

  constant REGISTER_COUNT : integer := 2;
  
  -------------------------------------------------------------------------------
  -- Signal and Type Declarations
  -------------------------------------------------------------------------------

  -- Memory bus control
  signal controlReg : std_logic_vector(31 downto 0);
  signal statusReg : std_logic_vector(31 downto 0);
  
  -- Address bus state
  signal busAddressReadReg : std_logic_vector(31 downto 0);
  -- Address bus update
  signal busAddressWriteReg : std_logic_vector(31 downto 0);
  
  -- Data bus state
  signal busDataReadReg : std_logic_vector(31 downto 0);
  -- Data bus update
  signal busDataWriteReg : std_logic_vector(31 downto 0);
  
  -- Interrupt
  signal intrEnableReg : std_logic_vector(31 downto 0);
  signal intrStatusReg : std_logic_vector(31 downto 0);
  signal intrAckReg : std_logic_vector(31 downto 0);
  
  -- Mapping
  signal mappedAddressReg : std_logic_vector(31 downto 0);

	

  -------------------------------------------------------------------------------
  -- Architecture
  -------------------------------------------------------------------------------

begin -- architecture IMP

------------------------------------------------------------------------
-- Instantiate the AXI memory bus master
------------------------------------------------------------------------

    Inst_AxiBusMaster: axi_ttl_memory_bus_master_top
    generic map(
        C_ADDR_WIDTH        	  => C_ADDR_WIDTH,
        C_DATA_WIDTH        	  => C_DATA_WIDTH,
        C_MAPPED_ADDRESS        => C_MAPPED_ADDRESS,
        C_USE_DYNAMIC_MAPPING	  => C_USE_DYNAMIC_MAPPING,
        C_M_AXI_DATA_WIDTH      => C_M_AXI_DATA_WIDTH,
        C_M_AXI_ADDR_WIDTH      => C_M_AXI_ADDR_WIDTH,
        C_FAMILY                => C_FAMILY,
        C_MST_AWIDTH            => 32,
        C_MST_DWIDTH            => 32)
    port map(
        nChipEnable		  		=> nChipEnable,
        nOutputEnable			=> nOutputEnable,
        nWriteEnable				=> nWriteEnable,
        Address					=> Address,
        Data						=> Data,
        MappedAddress           => MappedAddress,
        Interrupt           	=> IP2INTC_Irpt,
			
        ControlReg				    => controlReg,
        StatusReg				      => statusReg,
        
        BusAddressReadReg				    => busAddressReadReg,
        BusAddressWriteReg				    => busAddressWriteReg,
        
        BusDataReadReg				    => busDataReadReg,
        BusDataWriteReg				    => busDataWriteReg,
        
        IntrEnableReg				  => intrEnableReg,
        IntrStatusReg				  => intrStatusReg,
        IntrAckReg				    => intrAckReg,
		  
        M_AXI_ACLK              => M_AXI_ACLK,
        M_AXI_ARESETN           => M_AXI_ARESETN,
		  
        M_AXI_AWADDR            => M_AXI_AWADDR,
        M_AXI_AWVALID           => M_AXI_AWVALID,
        M_AXI_AWREADY           => M_AXI_AWREADY,
		  
        M_AXI_WDATA             => M_AXI_WDATA,
        M_AXI_WSTRB             => M_AXI_WSTRB,
        M_AXI_WVALID            => M_AXI_WVALID,
        M_AXI_WREADY            => M_AXI_WREADY,
		  
        M_AXI_BRESP             => M_AXI_BRESP,
        M_AXI_BVALID            => M_AXI_BVALID,
        M_AXI_BREADY            => M_AXI_BREADY,
		  
        M_AXI_ARADDR            => M_AXI_ARADDR,
        M_AXI_ARVALID           => M_AXI_ARVALID,
        M_AXI_ARREADY           => M_AXI_ARREADY,
		  
        M_AXI_RREADY            => M_AXI_RREADY,
        M_AXI_RDATA             => M_AXI_RDATA,
        M_AXI_RRESP             => M_AXI_RRESP,
        M_AXI_RVALID            => M_AXI_RVALID);
	 
------------------------------------------------------------------------
-- Instantiate the AXI DVI Register module
------------------------------------------------------------------------
    
    Inst_AxiSoftReg: axi_ttl_memory_bus_reg_top
    generic map(
        C_MAPPED_ADDRESS        => C_MAPPED_ADDRESS,
        C_USE_DYNAMIC_MAPPING	=> C_USE_DYNAMIC_MAPPING,
        C_S_AXI_DATA_WIDTH      => C_S_AXI_DATA_WIDTH,
        C_S_AXI_ADDR_WIDTH      => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_MIN_SIZE        => x"000001FF",
        C_USE_WSTRB             => 0,
        C_DPHASE_TIMEOUT        => 8,
        C_BASEADDR              => C_BASEADDR,
        C_HIGHADDR              => C_HIGHADDR,
        C_FAMILY                => C_FAMILY,
        C_SLV_AWIDTH            => 32,
        C_SLV_DWIDTH            => 32)
    port map(
        Control		  	        => controlReg,
        Status			           => statusReg,
        MappedAddress           => mappedAddressReg,

        BusAddressRead			    => busAddressReadReg,
        BusAddressWrite			    => busAddressWriteReg,
        
        BusDataRead			        => busDataReadReg,
        BusDataWrite			      => busDataWriteReg,
        
        IntrEnable				      => intrEnableReg,
        IntrStatus				      => intrStatusReg,
        IntrAck   				      => intrAckReg,
			
        S_AXI_ACLK              => S_AXI_ACLK,
        S_AXI_ARESETN           => S_AXI_ARESETN,
        S_AXI_AWADDR            => S_AXI_AWADDR,
        S_AXI_AWVALID           => S_AXI_AWVALID,
        S_AXI_WDATA             => S_AXI_WDATA,
        S_AXI_WSTRB             => S_AXI_WSTRB,
        S_AXI_WVALID            => S_AXI_WVALID,
        S_AXI_BREADY            => S_AXI_BREADY,
        S_AXI_ARADDR            => S_AXI_ARADDR,
        S_AXI_ARVALID           => S_AXI_ARVALID,
        S_AXI_RREADY            => S_AXI_RREADY,
        S_AXI_ARREADY           => S_AXI_ARREADY,
        S_AXI_RDATA             => S_AXI_RDATA,
        S_AXI_RRESP             => S_AXI_RRESP,
        S_AXI_RVALID            => S_AXI_RVALID,
        S_AXI_WREADY            => S_AXI_WREADY,
        S_AXI_BRESP             => S_AXI_BRESP,
        S_AXI_BVALID            => S_AXI_BVALID,
        S_AXI_AWREADY           => S_AXI_AWREADY);
	 
end imp;
