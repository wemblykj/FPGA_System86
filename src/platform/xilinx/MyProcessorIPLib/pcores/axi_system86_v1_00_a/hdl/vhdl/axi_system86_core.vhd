----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:30 11/22/2011 
-- Design Name: 
-- Module Name:    axi_system86_core - Behavioral 
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

-------------------------------------------------------------------------------
-- axi_master_lite_v2_00_a library is used for axi4 component declarations
-------------------------------------------------------------------------------
library axi_master_lite_v2_00_a;
use axi_master_lite_v2_00_a.all;

library system86_v1_00_a all;

library axi_system86_v1_00_a;

------------------------------------------------------------------------
-- Module Declaration
------------------------------------------------------------------------
entity axi_system86_core is
    generic
    (
		C_INTERRUPT_PRESENT 		   : integer     		     	:= 0;
		  
        C_FAMILY                       : string               	:= "virtex6";
        C_USE_HARDWARE_CLOCKS		: integer 	:= 0;
		C_VIDEO_COMPONENT_DEPTH		: integer	:= 4;
		
		C_EPROM_M27512_ADDR_WIDTH 	: integer	:= 16;
		C_EPROM_M27512_DATA_WIDTH 	: integer	:= 8;
		C_EPROM_M27256_ADDR_WIDTH 	: integer	:= 15;
		C_EPROM_M27256_DATA_WIDTH 	: integer	:= 8;
		C_EPROM_MB7138_ADDR_WIDTH 	: integer	:= 11;
		C_EPROM_MB7138_DATA_WIDTH 	: integer	:= 8;
		C_EPROM_MB7124_ADDR_WIDTH 	: integer	:= 9;
		C_EPROM_MB7124_DATA_WIDTH 	: integer	:= 8;
		C_EPROM_MB7116_ADDR_WIDTH 	: integer	:= 9;
		C_EPROM_MB7116_DATA_WIDTH 	: integer	:= 4;
		C_EPROM_MB7112_ADDR_WIDTH 	: integer	:= 5;
		C_EPROM_MB7112_DATA_WIDTH 	: integer	:= 8;
		C_SRAM_CY6462_ADDR_WIDTH 	: integer	:= 13;
		C_SRAM_CY6462_DATA_WIDTH 	: integer	:= 8
    );
    port	
    (
        nChipEnable 			   : in std_logic;
      	nOutputEnable 		   : in std_logic;
      	nWriteEnable 			: in std_logic;
      	Address 			      : in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
      	Data 				      : inout std_logic_vector(C_DATA_WIDTH - 1 downto 0);
      	MappedAddress 		   : in std_logic_vector(C_MST_AWIDTH - 1 downto 0);
        
        ControlReg			   : in std_logic_vector(C_MST_DWIDTH - 1 downto 0);
        StatusReg 			   : out std_logic_vector(C_MST_DWIDTH - 1 downto 0);	
        
		  BusControlReadReg 	   : out std_logic_vector(C_CTRL_WIDTH - 1 downto 0);	
		  
        BusAddressReadReg 	   : out std_logic_vector(C_ADDR_WIDTH - 1 downto 0);			
        BusAddressWriteReg 	: in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);			
        
        BusDataReadReg 			: out std_logic_vector(C_DATA_WIDTH - 1 downto 0);			
        BusDataWriteReg 		: in std_logic_vector(C_DATA_WIDTH - 1 downto 0);			
        
        AddrReqIntr           : out std_logic;
        AddrReqIntrStatus     : in std_logic;
        AddrReqIntrEnable     : in std_logic;
        
        DataReadReqIntr         : out std_logic;
        DataReadReqIntrStatus   : in std_logic;
        DataReadReqIntrEnable   : in std_logic;
         
        DataWriteReqIntr         : out std_logic;
        DataWriteReqIntrStatus   : in std_logic;
        DataWriteReqIntrEnable   : in std_logic;
			
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
        M_AXI_RREADY                   : out  std_logic;
		
			-- simulation
	--
	
	-- simulation control
	rst_n 					: in std_logic;			-- hard reset the simulation
	--enable 				: in std_logic := 1;				-- enable the simulation

	-- simulation video
	vid_clk					: out    std_logic;
	vid_data					: out    std_logic_vector((3*C_VIDEO_COMPONENT_DEPTH)-1 downto 0);
	vid_red					: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
	vid_green				: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
	vid_blue					: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
	vid_hsync_n				: out    std_logic;
	vid_vsync_n				: out    std_logic;
	vid_hblank_n			: out    std_logic;
	vid_vblank_n			: out    std_logic;
	
	-- simulation generated  system clock
	clk_48m					: in	std_logic;					-- 49.152 MHz system clock
	
	--CLK_24M_ext			: in	std_logic;					-- 49.152 MHz system clock
	--CLK_12M_ext			: in	std_logic;					-- 49.152 MHz system clock
	--CLK_6M_ext			: in	std_logic;					-- 49.152 MHz system clock
	
	--
	-- System 86 external connectors
	--
	
	-- System 86 native video (albeit 4-bit digital equivalent before resister ladder conversion)
	conn_j2_sync			: out    std_logic;
	conn_j2_red			: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
	conn_j2_green			: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
	conn_j2_blue			: out    std_logic_vector(C_VIDEO_COMPONENT_DEPTH-1 downto 0);
--		
--		-- J4 connector to sub PCB (34 pin)
--		conn_j4_reset		: out    std_logic;				-- pin 18 - system reset
--		conn_j4_ce_n			: out    std_logic;				-- pin 4  - sub PCB bus 'chip enable'
--		conn_j4_oe_n			: out    std_logic;				-- pin 14 - output enable (pixel clock x2)
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
	
	mcpu_11a_addr		: in std_logic_vector(15 downto 0);
	mcpu_11a_data		: inout std_logic_vector(7 downto 0);
	mcpu_11a_we_n		: in std_logic;
	mcpu_11a_e			: out std_logic;
	mcpu_11a_q			: out std_logic;
	mcpu_11a_irq_n		: out std_logic;
	mcpu_11a_firq_n		: out std_logic;
	mcpu_11a_nmi_n		: out std_logic;
	mcpu_11a_reset_n	: out std_logic;
	mcpu_11a_halt_n	: out std_logic;
	mcpu_11a_bs			: in std_logic;
	mcpu_11a_ba			: in std_logic;
	mcpu_11a_avma		: in std_logic;
	mcpu_11a_busy		: in std_logic;
	mcpu_11a_lic		: in std_logic;
	
	scpu_9a_addr		: in std_logic_vector(15 downto 0);
	scpu_9a_data		: inout std_logic_vector(7 downto 0);
	scpu_9a_we_n		: in std_logic;
	scpu_9a_e			: out std_logic;
	scpu_9a_q			: out std_logic;
	scpu_9a_irq_n		: out std_logic;
	scpu_9a_firq_n		: out std_logic;
	scpu_9a_nmi_n		: out std_logic;
	scpu_9a_reset_n	: out std_logic;
	scpu_9a_halt_n		: out std_logic;
	scpu_9a_bs			: in std_logic;
	scpu_9a_ba			: in std_logic;
	scpu_9a_avma		: in std_logic;
	scpu_9a_busy		: in std_logic;
	scpu_9a_lic			: in std_logic;

	prom_3r_ce_n		: out std_logic;
	prom_3r_addr		: out std_logic_vector(C_EPROM_MB7124_ADDR_WIDTH-1 downto 0) := "000000000";
	prom_3r_data		: in  std_logic_vector(C_EPROM_MB7124_DATA_WIDTH-1 downto 0) := "00000000";
--		
	prom_3s_ce_n		: out std_logic;
	prom_3s_addr		: out std_logic_vector(C_EPROM_MB7116_ADDR_WIDTH-1 downto 0) := "000000000";
	prom_3s_data  		: in  std_logic_vector(C_EPROM_MB7116_DATA_WIDTH-1 downto 0) := "0000";
--		
--		prom_4v_ce_n		: out std_logic;
--		prom_4v_addr		: out std_logic_vector(C_EPROM_MB7138_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_4v_data  		: in  std_logic_vector(C_EPROM_MB7138_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_5v_ce_n		: out std_logic;
--		prom_5v_addr		: out std_logic_vector(C_EPROM_MB7138_ADDR_WIDTH-1 downto 0) := "000000000";
--		prom_5v_data  		: in  std_logic_vector(C_EPROM_MB7138_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		prom_6u_ce_n		: out std_logic;
--		prom_6u_addr		: out std_logic_vector(C_EPROM_MB7112_ADDR_WIDTH-1 downto 0) := "00000";
--		prom_6u_data  		: in  std_logic_vector(C_EPROM_MB7112_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		eprom_4r_ce_n		: out std_logic;
--		eprom_4r_oe_n		: out std_logic;
--		eprom_4r_addr		: out std_logic_vector(C_EPROM_M27512_ADDR_WIDTH-1 downto 0) := "000000000";
--		eprom_4r_data  		: in  std_logic_vector(C_EPROM_M27512_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		eprom_4s_ce_n		: out std_logic;
--		eprom_4s_oe_n		: out std_logic;
--		eprom_4s_addr		: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		eprom_4s_data  		: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		eprom_7r_ce_n		: out std_logic;
--		eprom_7r_oe_n		: out std_logic;
--		eprom_7r_addr		: out std_logic_vector(C_EPROM_M27512_ADDR_WIDTH-1 downto 0) := "000000000";
--		eprom_7r_data  		: in  std_logic_vector(C_EPROM_M27512_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		eprom_7s_ce_n		: out std_logic;
--		eprom_7s_oe_n		: out std_logic;
--		eprom_7s_addr		: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
--		eprom_7s_data  		: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
--		
	eprom_9c_ce_n		: out std_logic;
	eprom_9c_oe_n		: out std_logic;
	eprom_9c_addr		: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
	eprom_9c_data  	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
	
	eprom_9d_ce_n		: out std_logic;
	eprom_9d_oe_n		: out std_logic;
	eprom_9d_addr		:out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
	eprom_9d_data  	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
	
	eprom_12c_ce_n		: out std_logic;
	eprom_12c_oe_n		: out std_logic;
	eprom_12c_addr		: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
	eprom_12c_data 	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000";
	
	eprom_12d_ce_n		: out std_logic;
	eprom_12d_oe_n		: out std_logic;
	eprom_12d_addr		: out std_logic_vector(C_EPROM_M27256_ADDR_WIDTH-1 downto 0) := "000000000";
	eprom_12d_data 	: in  std_logic_vector(C_EPROM_M27256_DATA_WIDTH-1 downto 0) := "00000000"
	
--		sram_3f_ce_n		: out std_logic;
--		sram_3f_oe_n		: out std_logic;
--		sram_3f_we_n		: out std_logic;
--		sram_3f_addr		: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "0000000000000";
--		sram_3f_data   	: inout std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000"
	
--		sram_4n_ce_n		: out std_logic;
--		sram_4n_oe_n		: out std_logic;
--		sram_4n_we_n		: out std_logic;
--		sram_4n_addr		: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "0000000000000";
--		sram_4n_data  		: inout std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		sram_7n_ce_n		: out std_logic;
--		sram_7n_oe_n		: out std_logic;
--		sram_7n_we_n		: out std_logic;
--		sram_7n_addr		: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "0000000000000";
--		sram_7n_data  		: inout  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		sram_10m_ce_n		: out std_logic;
--		sram_10m_oe_n		: out std_logic;
--		sram_10m_we_n		: out std_logic;
--		sram_10m_addr		: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "0000000000000";
--		sram_10m_data  	: inout  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000";
--		
--		sram_11k_ce_n		: out std_logic;
--		sram_11k_oe_n		: out std_logic;
--		sram_11k_we_n		: out std_logic;
--		sram_11k_addr		: out std_logic_vector(C_SRAM_CY6462_ADDR_WIDTH-1 downto 0) := "0000000000000";
--		sram_11k_data  	: inout  std_logic_vector(C_SRAM_CY6462_DATA_WIDTH-1 downto 0) := "00000000"

    );
    attribute MAX_FANOUT                  : string;
	attribute MAX_FANOUT of M_AXI_ACLK    : signal is "10000";
    attribute MAX_FANOUT of M_AXI_ARESETN : signal is "10000";
	attribute MAX_FANOUT of clk_48m       : signal is "10000";
	attribute MAX_FANOUT of vid_clk       : signal is "10000";
  
    attribute SIGIS                       : string;
    attribute SIGIS of M_AXI_ACLK         : signal is "Clk";
    attribute SIGIS of M_AXI_ARESETN      : signal is "Rst";
	attribute SIGIS of clk_48m : signal is "Clk"; 
	attribute SIGIS of vid_clk : signal is "Clk";
end axi_system86_core;

architecture Behavioral of axi_system86_core is

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


------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------

begin

------------------------------------------------------------------------
-- Instantiate axi_system86_master
------------------------------------------------------------------------
    Inst_AxiBusMasterImpl: system86
    generic map(
        C_USE_HARDWARE_CLOCKS        => C_USE_HARDWARE_CLOCKS,
        C_VIDEO_COMPONENT_DEPTH        => C_VIDEO_COMPONENT_DEPTH)
    port map(
        rst_n 			=> rst_n,
		clk_48m			=> clk_48m,
		vid_clk			=> vid_clk,
		--vid_data			=> vid_data,
		vid_hsync_n		=> vid_hsync_n,
		vid_vsync_n		=> vid_vsync_n,
		vid_hblank_n		=> vid_hblank_n,
		vid_vblank_n		=> vid_vblank_n,
		vid_red			=> vid_red,
		vid_green		=> vid_green,
		vid_blue		=> vid_blue,
		
		conn_j2_sync		=> conn_j2_sync,
		conn_j2_red		=> conn_j2_red,
		conn_j2_green		=> conn_j2_green,
		conn_j2_blue		=> conn_j2_blue,
		
		mcpu_11a_data		=> mcpu_11a_data,
		mcpu_11a_addr		=> mcpu_11a_addr,
		mcpu_11a_we_n		=> mcpu_11a_we_n,
		mcpu_11a_e			=> mcpu_11a_e,
		mcpu_11a_q			=> mcpu_11a_q,
		mcpu_11a_bs			=> mcpu_11a_bs,
		mcpu_11a_ba			=> mcpu_11a_ba,
		mcpu_11a_reset_n	=> mcpu_11a_reset_n,
		mcpu_11a_halt_n	    => mcpu_11a_halt_n,
		mcpu_11a_irq_n		=> mcpu_11a_irq_n,
		mcpu_11a_firq_n		=> mcpu_11a_firq_n,
		mcpu_11a_nmi_n		=> mcpu_11a_nmi_n,
		mcpu_11a_avma		=> mcpu_11a_avma,
		mcpu_11a_busy		=> mcpu_11a_busy,
		mcpu_11a_lic		=> mcpu_11a_lic,

		scpu_9a_data		=> scpu_9a_data,
		scpu_9a_addr		=> scpu_9a_addr,
		scpu_9a_we_n		=> scpu_9a_we_n,
		scpu_9a_e			=> scpu_9a_e,
		scpu_9a_q			=> scpu_9a_q,
		scpu_9a_bs			=> scpu_9a_bs,
		scpu_9a_ba			=> scpu_9a_ba,
		scpu_9a_reset_n	=> scpu_9a_reset_n,
		scpu_9a_halt_n		=> scpu_9a_halt_n,
		scpu_9a_irq_n		=> scpu_9a_irq_n,
		scpu_9a_firq_n		=> scpu_9a_firq_n,
		scpu_9a_nmi_n		=> scpu_9a_nmi_n,
		scpu_9a_avma		=> scpu_9a_avma,
		scpu_9a_busy		=> scpu_9a_busy,
		scpu_9a_lic			=> scpu_9a_lic,

		prom_3r_ce_n		=> prom_3r_ce_n,
		prom_3r_addr	=> prom_3r_addr,
		prom_3r_data	=> prom_3r_data,
--		
		prom_3s_ce_n		=> prom_3s_ce_n,
		prom_3s_addr	=> prom_3s_addr,
		prom_3s_data	=> prom_3s_data,
--		
--		prom_4v_ce_n		=> prom_4v_ce_n,
--		prom_4v_addr	=> prom_4v_addr,
--		prom_4v_data	=> prom_4v_data,
--		
--		prom_5v_ce_n		=> prom_5v_ce_n,
--		prom_5v_addr	=> prom_5v_addr,
--		prom_5v_data	=> prom_5v_data,
--		
--		prom_6u_ce_n		=> prom_6u_ce_n,
--		prom_6u_addr	=> prom_6u_addr,
--		prom_6u_data	=> prom_6u_data,
--		
--		eprom_4r_ce_n		=> eprom_4r_ce_n,
--		eprom_4r_oe_n		=> eprom_4r_oe_n,
--		eprom_4r_addr	=> eprom_4r_addr,
--		eprom_4r_data	=> eprom_4r_data,
--		
--		eprom_4s_ce_n		=> eprom_4s_ce_n,
--		eprom_4s_oe_n		=> eprom_4s_oe_n,
--		eprom_4s_addr	=> eprom_4s_addr,
--		eprom_4s_data	=> eprom_4s_data,
--		
--		eprom_7r_ce_n		=> eprom_7r_ce_n,
--		eprom_7r_oe_n		=> eprom_7r_oe_n,
--		eprom_7r_addr	=> eprom_7r_addr,
--		eprom_7r_data	=> eprom_7r_data,
--		
--		eprom_7s_ce_n		=> eprom_7s_ce_n,
--		eprom_7s_oe_n		=> eprom_7s_oe_n,
--		eprom_7s_addr	=> eprom_7s_addr,
--		eprom_7s_data	=> eprom_7s_data,
--		
		eprom_9c_ce_n		=> eprom_9c_ce_n,
		eprom_9c_oe_n		=> eprom_9c_oe_n,
		eprom_9c_addr	=> eprom_9c_addr,
		eprom_9c_data	=> eprom_9c_data,
		
		eprom_9d_ce_n		=> eprom_9d_ce_n,
		eprom_9d_oe_n		=> eprom_9d_oe_n,
		eprom_9d_addr	=> eprom_9d_addr,
		eprom_9d_data	=> eprom_9d_data,
		
		eprom_12c_ce_n	=> eprom_12c_ce_n,
		eprom_12c_oe_n	=> eprom_12c_oe_n,
		eprom_12c_addr	=> eprom_12c_addr,
		eprom_12c_data	=> eprom_12c_data,
		
		eprom_12d_ce_n	=> eprom_12d_ce_n,
		eprom_12d_oe_n	=> eprom_12d_oe_n,
		eprom_12d_addr	=> eprom_12d_addr,
		eprom_12d_data	=> eprom_12d_data
--		
--		sram_3f_ce_n		=> sram_3f_ce_n,
--		sram_3f_oe_n		=> sram_3f_oe_n,
--		sram_3f_we_n		=> sram_3f_we,
--		sram_3f_addr	=> sram_3f_addr,
--		sram_3f_data	=> sram_3f_data,
--		
--		sram_4n_ce_n		=> sram_4n_ce_n,
--		sram_4n_oe_n		=> sram_4n_oe_n,
--		sram_4n_we		=> sram_4n_we,
--		sram_4n_addr	=> sram_4n_addr,
--		sram_4n_data	=> sram_4n_data,
--		
--		sram_7n_ce_n		=> sram_7n_ce_n,
--		sram_7n_oe_n		=> sram_7n_oe_n,
--		sram_7n_we		=> sram_7n_we,
--		sram_7n_addr	=> sram_7n_addr,
--		sram_7n_data	=> sram_7n_data,
--		
--		sram_10m_ce_n		=> sram_10m_ce_n,
--		sram_10m_oe_n		=> sram_10m_oe_n,
--		sram_10m_we		=> sram_10m_we,
--		sram_10m_addr	=> sram_10m_addr,
--		sram_10m_data	=> sram_10m_data,
--		
--		sram_11k_ce_n		=> sram_11k_ce_n,
--		sram_11k_oe_n		=> sram_11k_oe_n,
--		sram_11k_we		=> sram_11k_we,
--		sram_11k_addr	=> sram_11k_addr,
--		sram_11k_data	=> sram_11k_data
      );

end Behavioral;

