----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:30 11/22/2011 
-- Design Name: 
-- Module Name:    axi_ttl_memory_bus_reg_top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.ipif_pkg.all;

library interrupt_control_v2_01_a; 

-------------------------------------------------------------------------------
-- axi_master_lite_v2_00_a library is used for axi4 component declarations
-------------------------------------------------------------------------------
library axi_master_lite_v2_00_a;
use axi_master_lite_v2_00_a.all;

library axi_ttl_memory_bus_v1_00_a;

------------------------------------------------------------------------
-- Module Declaration
------------------------------------------------------------------------
entity axi_ttl_memory_bus_master_top is
    generic
    (
	C_ADDR_WIDTH        		: integer     		:= 16;
	C_DATA_WIDTH        		: integer     		:= 8;
	C_MAPPED_ADDRESS        	: std_logic_vector     	:= X"FFFFFFFF";
	C_USE_DYNAMIC_MAPPING	  	: std_logic  		:= '0';
		  
        C_M_AXI_DATA_WIDTH             : integer              	:= 32;
        C_M_AXI_ADDR_WIDTH             : integer              	:= 32;
        --C_M_AXI_MIN_SIZE               : std_logic_vector     	:= X"000001FF";
        --C_USE_WSTRB                    : integer              := 0;
        --C_DPHASE_TIMEOUT               : integer              := 8;
        --C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
        --C_HIGHADDR                     : std_logic_vector     := X"00000000";
        C_FAMILY                       : string               	:= "virtex6";
        C_MST_AWIDTH                   : integer              := 32;
        C_MST_DWIDTH                   : integer              := 32
    );
    port
    (
      	ChipEnable 			: in std_logic;
      	OutputEnable 			: in std_logic;
      	WriteEnable 			: in std_logic;
      	Address 			: in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
      	Data 				: inout std_logic_vector(C_DATA_WIDTH - 1 downto 0);
      	MappedAddress 			: in std_logic_vector(C_M_AXI_ADDR_WIDTH - 1 downto 0);
			IP2INTC_Irpt            : out std_logic;
			
        M_AXI_ACLK                     : in  std_logic;
        M_AXI_ARESETN                  : in  std_logic;
		  
        M_AXI_AWADDR                   : out  std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
        M_AXI_AWVALID                  : out  std_logic;
		  M_AXI_AWREADY                  : in std_logic;
		  
        M_AXI_WDATA                    : out  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
        M_AXI_WSTRB                    : out  std_logic_vector((C_M_AXI_DATA_WIDTH/8)-1 downto 0);
        M_AXI_WVALID                   : out  std_logic;
		  M_AXI_WREADY                   : in std_logic;
		  
        M_AXI_BRESP                    : in std_logic_vector(1 downto 0);
        M_AXI_BVALID                   : in std_logic;
        M_AXI_BREADY                   : out  std_logic;
		  
        M_AXI_ARADDR                   : out  std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
        M_AXI_ARVALID                  : out  std_logic;
        M_AXI_ARREADY                  : in std_logic;
		  
        M_AXI_RDATA                    : in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
        M_AXI_RRESP                    : in std_logic_vector(1 downto 0);
        M_AXI_RVALID                   : in std_logic;
        M_AXI_RREADY                   : out  std_logic
    );
    attribute MAX_FANOUT                  : string;
    attribute SIGIS                       : string;
    attribute MAX_FANOUT of M_AXI_ACLK    : signal is "10000";
    attribute MAX_FANOUT of M_AXI_ARESETN : signal is "10000";
    attribute SIGIS of M_AXI_ACLK         : signal is "Clk";
    attribute SIGIS of M_AXI_ARESETN      : signal is "Rst";
end axi_ttl_memory_bus_master_top;

architecture Behavioral of axi_ttl_memory_bus_master_top is

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------

--constant USER_SLV_DWIDTH                : integer              := C_M_AXI_DATA_WIDTH;
--constant IPIF_SLV_DWIDTH                : integer              := C_M_AXI_DATA_WIDTH;
--constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 31) := (others => '0');
--constant USER_SLV_BASEADDR              : std_logic_vector     := C_BASEADDR;
--constant USER_SLV_HIGHADDR              : std_logic_vector     := C_HIGHADDR;
--constant IPIF_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE     := 
--  (
--    ZERO_ADDR_PAD & USER_SLV_BASEADDR,  -- user logic slave space base address
--    ZERO_ADDR_PAD & USER_SLV_HIGHADDR   -- user logic slave space high address
--  );
--constant USER_SLV_NUM_REG               : integer              := 3;
--constant USER_NUM_REG                   : integer              := USER_SLV_NUM_REG;
--constant TOTAL_IPIF_CE                  : integer              := USER_NUM_REG;
--constant IPIF_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE   := 
--  (
--    0  => (USER_SLV_NUM_REG)            -- number of ce for user logic slave space
--  );
--constant USER_SLV_CS_INDEX              : integer              := 0;
--constant USER_SLV_CE_INDEX              : integer              := calc_start_ce_index(IPIF_ARD_NUM_CE_ARRAY, USER_SLV_CS_INDEX);
--constant USER_CE_INDEX                  : integer              := USER_SLV_CE_INDEX;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------

  -- Interrupts
  signal ip2bus_intrevent     : std_logic_vector(0 to 1);

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

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------

component axi_ttl_memory_bus_master
    generic(
	C_ADDR_WIDTH 		: integer 			:= 16;
	C_DATA_WIDTH 		: integer 			:= 8;
	C_MST_AWIDTH 		: integer 			:= 32;
	C_MST_DWIDTH 		: integer 			:= 32
	  );
    port(
      	ChipEnable 		: in std_logic;
      	OutputEnable 		: in std_logic;
      	WriteEnable 		: in std_logic;
      	Address 		: in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
      	Data 			: inout std_logic_vector(C_DATA_WIDTH - 1 downto 0);
      	MappedAddress 		: in std_logic_vector(C_MST_AWIDTH - 1 downto 0);
			
			-----------------------------------------------------------------------------
    -- IP Master Request/Qualifers
    -----------------------------------------------------------------------------
    ip2bus_mstwr_req           : out  std_logic;                                           -- IPIC
    ip2bus_mst_addr            : out  std_logic_vector(C_M_AXI_LITE_ADDR_WIDTH-1 downto 0);    -- IPIC
    ip2bus_mst_be              : out  std_logic_vector((C_M_AXI_LITE_DATA_WIDTH/8)-1 downto 0);-- IPIC     
    ip2bus_mst_lock            : out  std_logic;                                           -- IPIC
    ip2bus_mst_reset           : out  std_logic;                                           -- IPIC
                                                                                          -- IPIC
    -----------------------------------------------------------------------------
    -- IP Request Status Reply                                                            
    -----------------------------------------------------------------------------
    bus2ip_mst_cmdack          : in std_logic;                                           -- IPIC
    bus2ip_mst_cmplt           : in std_logic;                                           -- IPIC
    bus2ip_mst_error           : in std_logic;                                           -- IPIC
    bus2ip_mst_rearbitrate     : in std_logic;                                           -- IPIC
    bus2ip_mst_cmd_timeout     : in std_logic;                                           -- IPIC
                                                                                          -- IPIC
                                                                                          -- IPIC
    -----------------------------------------------------------------------------
    -- IPIC Read data                                                                     
    -----------------------------------------------------------------------------
    bus2ip_mstrd_d             : in std_logic_vector(C_M_AXI_LITE_DATA_WIDTH-1 downto 0);-- IPIC
    bus2ip_mstrd_src_rdy_n     : in std_logic;                                           -- IPIC
                                                                                          -- IPIC
    -----------------------------------------------------------------------------
    -- IPIC Write data                                                                    
    -----------------------------------------------------------------------------
    ip2bus_mstwr_d             : out  std_logic_vector(C_M_AXI_LITE_DATA_WIDTH-1 downto 0);-- IPIC
    bus2ip_mstwr_dst_rdy_n     : in  std_logic);                                          -- IPIC
end component;

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------

begin

------------------------------------------------------------------------
-- Instantiate axi_master_lite
------------------------------------------------------------------------
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

------------------------------------------------------------------------
-- Instantiate axi_ttl_memory_bus_master
------------------------------------------------------------------------
    Inst_AxiBusMasterImpl: axi_ttl_memory_bus_master
    generic map(
        C_ADDR_WIDTH            => C_ADDR_WIDTH,
        C_DATA_WIDTH            => C_DATA_WIDTH,
        C_MST_AWIDTH            => C_MST_AWIDTH,
        C_MST_DWIDTH            => C_MST_DWIDTH)
    port map(
        ChipEnable              => ChipEnable,
        OutputEnable            => OutputEnable,
        WriteEnable             => WriteEnable,
		  Address                 => Address,
		  Data	                => Data,
		  MappedAddress           => MappedAddress,

      ip2bus_mstrd_req => ip2bus_mstrd_req,
      ip2bus_mstwr_req => ip2bus_mstwr_req,
      ip2bus_mst_addr => ip2bus_mst_addr,
      ip2bus_mst_be => ip2bus_mst_be,
      ip2bus_mst_lock => ip2bus_mst_lock,
      ip2bus_mst_reset => ip2bus_mst_reset,

      bus2ip_mst_cmdack => bus2ip_mst_cmdack,
      bus2ip_mst_cmplt => bus2ip_mst_cmplt,
      bus2ip_mst_error => bus2ip_mst_error,
      bus2ip_mst_rearbitrate => bus2ip_mst_rearbitrate,
      bus2ip_mst_cmd_timeout => bus2ip_mst_cmd_timeout,

      bus2ip_mstrd_d => bus2ip_mstrd_d,
      bus2ip_mstrd_src_rdy_n => bus2ip_mstrd_src_rdy_n,

      ip2bus_mstwr_d => ip2bus_mstwr_d,
      bus2ip_mstwr_dst_rdy_n => bus2ip_mstwr_dst_rdy_n
      );

end Behavioral;

