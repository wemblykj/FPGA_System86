------------------------------------------------------------------------------
-- axi_ram.vhd - entity/architecture pair
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
-- Filename:          axi_ram.vhd
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

--library proc_common_v3_00_a;
--use proc_common_v3_00_a.proc_common_pkg.all;
--use proc_common_v3_00_a.ipif_pkg.all;
-- use proc_common_v3_00_a.soft_reset;

-- library axi_lite_ipif_v1_01_a;
--use axi_lite_ipif_v1_01_a.axi_lite_ipif;

library axi_master_lite_v1_00_a;
use axi_master_lite_v1_00_a.axi_master_lite;

-- library ttl_lib;
-- use ttl_lib.;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLAVE_BASE_ADDR            -- Base address to which all external RAM requests will 
--                                   be mapped on the AXI bus
--
--   C_FAMILY                     -- FPGA Family
--   C_M_AXI_LITE_ADDR_WIDTH      -- Master-Intf address bus width
--   C_M_AXI_LITE_DATA_WIDTH      -- Master-Intf data bus width
--
-- Definition of Ports:
--   slave_addr_offset            -- An offset from C_BASEADDR for with incoming 
--                                   requests will be mapped
--
--   m_axi_lite_aclk              -- AXI4LITE master: Clock
--   m_axi_lite_aresetn           -- AXI4LITE master: Reset
--   md_error                     -- AXI4LITE master: Error
--   m_axi_lite_arready           -- AXI4LITE master: Read address ready
--   m_axi_lite_arvalid           -- AXI4LITE master: read address valid
--   m_axi_lite_araddr            -- AXI4LITE master: read address protection
--   m_axi_lite_arprot            -- AXI4LITE master: Read address protection
--   m_axi_lite_rready            -- AXI4LITE master: Read data ready
--   m_axi_lite_rvalid            -- AXI4LITE master: Read data valid
--   m_axi_lite_rdata             -- AXI4LITE master: Read data
--   m_axi_lite_rresp             -- AXI4LITE master: read data response
--   m_axi_lite_awready           -- AXI4LITE master: write address ready
--   m_axi_lite_awvalid           -- AXI4LITE master: write address valid
--   m_axi_lite_awaddr            -- AXI4LITE master: write address valid
--   m_axi_lite_awprot            -- AXI4LITE master: write address protection
--   m_axi_lite_wready            -- AXI4LITE master: write data ready
--   m_axi_lite_wvalid            -- AXI4LITE master: write data valid
--   m_axi_lite_wdata             -- AXI4LITE master: write data
--   m_axi_lite_wstrb             -- AXI4LITE master: write data strobe
--   m_axi_lite_bready            -- AXI4LITE master: read response ready
--   m_axi_lite_bvalid            -- AXI4LITE master: read response valid
--   m_axi_lite_bresp             -- AXI4LITE master: read response
------------------------------------------------------------------------------

entity axi_ram is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------

    -- RAM attributes
    C_RAM_ADDR_WIDTH               : std_logic_vector     := 16;
    C_RAM_DATA_WIDTH               : std_logic_vector     := 8;

    -- Slave address
    C_SLAVE_BASE_ADDR              : std_logic_vector     := X"C0000000";
    C_USE_DYNAMIC_ADDR_OFFSET      : std_logic            := 0;
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_FAMILY                       : string               := "virtex6";
    C_M_AXI_LITE_ADDR_WIDTH        : integer              := 32;
    C_M_AXI_LITE_DATA_WIDTH        : integer              := 32
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
	 
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------

    -- RAM ports
    chip_enable                    : in std_logic;
    write_enable                   : in std_logic;
    output_enable                  : in std_logic;
    address                        : in std_logic_vector(C_RAM_ADDR_WIDTH-1 downto 0);
    data                           : inout std_logic_vector(C_RAM_DATA_WIDTH-1 downto 0);

    -- Slave address
    slave_addr_offset              : in  std_logic_vector(C_M_AXI_LITE_ADDR_WIDTH-1 downto 0);

    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    m_axi_lite_aclk                : in  std_logic;
    m_axi_lite_aresetn             : in  std_logic;
    md_error                       : out std_logic;
    m_axi_lite_arready             : in  std_logic;
    m_axi_lite_arvalid             : out std_logic;
    m_axi_lite_araddr              : out std_logic_vector(C_M_AXI_LITE_ADDR_WIDTH-1 downto 0);
    m_axi_lite_arprot              : out std_logic_vector(2 downto 0);
    m_axi_lite_rready              : out std_logic;
    m_axi_lite_rvalid              : in  std_logic;
    m_axi_lite_rdata               : in  std_logic_vector(C_M_AXI_LITE_DATA_WIDTH-1 downto 0);
    m_axi_lite_rresp               : in  std_logic_vector(1 downto 0);
    m_axi_lite_awready             : in  std_logic;
    m_axi_lite_awvalid             : out std_logic;
    m_axi_lite_awaddr              : out std_logic_vector(C_M_AXI_LITE_ADDR_WIDTH-1 downto 0);
    m_axi_lite_awprot              : out std_logic_vector(2 downto 0);
    m_axi_lite_wready              : in  std_logic;
    m_axi_lite_wvalid              : out std_logic;
    m_axi_lite_wdata               : out std_logic_vector(C_M_AXI_LITE_DATA_WIDTH-1 downto 0);
    m_axi_lite_wstrb               : out std_logic_vector((C_M_AXI_LITE_DATA_WIDTH/8)-1 downto 0);
    m_axi_lite_bready              : out std_logic;
    m_axi_lite_bvalid              : in  std_logic;
    m_axi_lite_bresp               : in  std_logic_vector(1 downto 0)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;

  attribute MAX_FANOUT of m_axi_lite_aclk       : signal is "10000";
  attribute MAX_FANOUT of m_axi_lite_aresetn       : signal is "10000";
  attribute SIGIS of m_axi_lite_aclk       : signal is "Clk";
  attribute SIGIS of m_axi_lite_aresetn       : signal is "Rst";
end entity axi_ram;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_ram is
 
  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations
  ------------------------------------------

  signal ipif_ip2bus_mstrd_req          : std_logic;
  signal ipif_ip2bus_mstwr_req          : std_logic;
  signal ipif_ip2bus_mst_addr           : std_logic_vector(0 to C_M_AXI_LITE_ADDR_WIDTH-1);
  signal ipif_ip2bus_mst_be             : std_logic_vector(0 to (C_M_AXI_LITE_DATA_WIDTH/8)-1);
  signal ipif_ip2bus_mst_lock           : std_logic;
  signal ipif_ip2bus_mst_reset          : std_logic;
  signal ipif_bus2ip_mst_cmdack         : std_logic;
  signal ipif_bus2ip_mst_cmplt          : std_logic;
  signal ipif_bus2ip_mst_error          : std_logic;
  signal ipif_bus2ip_mst_rearbitrate    : std_logic;
  signal ipif_bus2ip_mst_cmd_timeout    : std_logic;
  signal ipif_bus2ip_mstrd_d            : std_logic_vector(0 to C_M_AXI_LITE_DATA_WIDTH-1);
  signal ipif_bus2ip_mstrd_src_rdy_n    : std_logic;
  signal ipif_ip2bus_mstwr_d            : std_logic_vector(0 to C_M_AXI_LITE_DATA_WIDTH-1);
  signal ipif_bus2ip_mstwr_dst_rdy_n    : std_logic;

begin


  ------------------------------------------
  -- instantiate axi_master_lite
  ------------------------------------------
  AXI_MASTER_LITE_I : entity axi_master_lite_v1_00_a.axi_master_lite
    generic map
    (
      C_M_AXI_LITE_ADDR_WIDTH        => C_M_AXI_LITE_ADDR_WIDTH,
      C_M_AXI_LITE_DATA_WIDTH        => C_M_AXI_LITE_DATA_WIDTH,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      m_axi_lite_aclk                => m_axi_lite_aclk,
      m_axi_lite_aresetn             => m_axi_lite_aresetn,
      md_error                       => md_error,
      m_axi_lite_arready             => m_axi_lite_arready,
      m_axi_lite_arvalid             => m_axi_lite_arvalid,
      m_axi_lite_araddr              => m_axi_lite_araddr,
      m_axi_lite_arprot              => m_axi_lite_arprot,
      m_axi_lite_rready              => m_axi_lite_rready,
      m_axi_lite_rvalid              => m_axi_lite_rvalid,
      m_axi_lite_rdata               => m_axi_lite_rdata,
      m_axi_lite_rresp               => m_axi_lite_rresp,
      m_axi_lite_awready             => m_axi_lite_awready,
      m_axi_lite_awvalid             => m_axi_lite_awvalid,
      m_axi_lite_awaddr              => m_axi_lite_awaddr,
      m_axi_lite_awprot              => m_axi_lite_awprot,
      m_axi_lite_wready              => m_axi_lite_wready,
      m_axi_lite_wvalid              => m_axi_lite_wvalid,
      m_axi_lite_wdata               => m_axi_lite_wdata,
      m_axi_lite_wstrb               => m_axi_lite_wstrb,
      m_axi_lite_bready              => m_axi_lite_bready,
      m_axi_lite_bvalid              => m_axi_lite_bvalid,
      m_axi_lite_bresp               => m_axi_lite_bresp,
      ip2bus_mstrd_req               => ipif_ip2bus_mstrd_req,
      ip2bus_mstwr_req               => ipif_ip2bus_mstwr_req,
      ip2bus_mst_addr                => ipif_ip2bus_mst_addr,
      ip2bus_mst_be                  => ipif_ip2bus_mst_be,
      ip2bus_mst_lock                => ipif_ip2bus_mst_lock,
      ip2bus_mst_reset               => ipif_ip2bus_mst_reset,
      bus2ip_mst_cmdack              => ipif_bus2ip_mst_cmdack,
      bus2ip_mst_cmplt               => ipif_bus2ip_mst_cmplt,
      bus2ip_mst_error               => ipif_bus2ip_mst_error,
      bus2ip_mst_rearbitrate         => ipif_bus2ip_mst_rearbitrate,
      bus2ip_mst_cmd_timeout         => ipif_bus2ip_mst_cmd_timeout,
      bus2ip_mstrd_d                 => ipif_bus2ip_mstrd_d,
      bus2ip_mstrd_src_rdy_n         => ipif_bus2ip_mstrd_src_rdy_n,
      ip2bus_mstwr_d                 => ipif_ip2bus_mstwr_d,
      bus2ip_mstwr_dst_rdy_n         => ipif_bus2ip_mstwr_dst_rdy_n
    );

end IMP;
