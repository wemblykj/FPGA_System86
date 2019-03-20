------------------------------------------------------------------------------
-- axi_system86 - entity/architecture pair
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
-- Filename:          axi_system86
-- Version:           1.00.a
-- Description:       Example Axi Streaming core (VHDL).
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

entity axi_system86 is
    generic
    (
        -- Master AXI Stream Generics
        C_M_AXIS_DATA_WIDTH     : integer range 32 to 256 := 32;
    
        -- Slave AXI Stream Generics
        C_S_AXIS_DATA_WIDTH     : integer range 32 to 256 := 32
        
        -- Master AXI Generics
        C_M_AXI_THREAD_ID_WIDTH : integer := 1;
        C_M_AXI_ADDR_WIDTH      : integer := 32;
        C_M_AXI_DATA_WIDTH      : integer := 32;
        C_M_AXI_AWUSER_WIDTH    : integer := 1;
        C_M_AXI_ARUSER_WIDTH    : integer := 1;
        C_M_AXI_WUSER_WIDTH     : integer := 1;
        C_M_AXI_RUSER_WIDTH     : integer := 1;
        C_M_AXI_BUSER_WIDTH     : integer := 1;
        
        -- Slave AXI-Lite Generics
        C_S_AXI_ADDR_WIDTH      : integer := 32;
        C_S_AXI_DATA_WIDTH      : integer := 32;
    )
	port 
	(
		-- Global Ports
		ACLK	: in	std_logic;
		ARESETN	: in	std_logic;
        
        -- Master Stream Ports
		M_AXIS_TVALID	: out	std_logic;
		M_AXIS_TDATA	: out	std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
		M_AXIS_TLAST	: out	std_logic;
		M_AXIS_TREADY	: in	std_logic
        
        -- Slave Stream Ports
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(C_S_AXIS_DATA_WIDTH-1 downto 0);
		S_AXIS_TLAST	: in	std_logic;
		S_AXIS_TVALID	: in	std_logic;
        
        -- Master Interface Write Address
        M_AXI_AWID    : out std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
        M_AXI_AWADDR  : out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
        M_AXI_AWLEN   : out std_logic_vector(8-1 downto 0);
        M_AXI_AWSIZE  : out std_logic_vector(3-1 downto 0);
        M_AXI_AWBURST : out std_logic_vector(2-1 downto 0);
        M_AXI_AWLOCK  : out std_logic;
        M_AXI_AWCACHE : out std_logic_vector(4-1 downto 0);
        M_AXI_AWPROT  : out std_logic_vector(3-1 downto 0);
        -- AXI3    M_AXI_AWREGION:out std_logic_vector(4-1 downto 0);
        M_AXI_AWQOS   : out std_logic_vector(4-1 downto 0);
        M_AXI_AWUSER  : out std_logic_vector(C_M_AXI_AWUSER_WIDTH-1 downto 0);
        M_AXI_AWVALID : out std_logic;
        M_AXI_AWREADY : in  std_logic;

        -- Master Interface Write Data
        -- AXI3   M_AXI_WID(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
        M_AXI_WDATA  : out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
        M_AXI_WSTRB  : out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
        M_AXI_WLAST  : out std_logic;
        M_AXI_WUSER  : out std_logic_vector(C_M_AXI_WUSER_WIDTH-1 downto 0);
        M_AXI_WVALID : out std_logic;
        M_AXI_WREADY : in  std_logic;

        -- Master Interface Write Response
        M_AXI_BID    : in  std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
        M_AXI_BRESP  : in  std_logic_vector(2-1 downto 0);
        M_AXI_BUSER  : in  std_logic_vector(C_M_AXI_BUSER_WIDTH-1 downto 0);
        M_AXI_BVALID : in  std_logic;
        M_AXI_BREADY : out std_logic;

        -- Master Interface Read Address
        M_AXI_ARID    : out std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
        M_AXI_ARADDR  : out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
        M_AXI_ARLEN   : out std_logic_vector(8-1 downto 0);
        M_AXI_ARSIZE  : out std_logic_vector(3-1 downto 0);
        M_AXI_ARBURST : out std_logic_vector(2-1 downto 0);
        M_AXI_ARLOCK  : out std_logic_vector(2-1 downto 0);
        M_AXI_ARCACHE : out std_logic_vector(4-1 downto 0);
        M_AXI_ARPROT  : out std_logic_vector(3-1 downto 0);
        -- AXI3   M_AXI_ARREGION:out std_logic_vector(4-1 downto 0);
        M_AXI_ARQOS   : out std_logic_vector(4-1 downto 0);
        M_AXI_ARUSER  : out std_logic_vector(C_M_AXI_ARUSER_WIDTH-1 downto 0);
        M_AXI_ARVALID : out std_logic;
        M_AXI_ARREADY : in  std_logic;

        -- Master Interface Read Data 
        M_AXI_RID    : in  std_logic_vector(C_M_AXI_THREAD_ID_WIDTH-1 downto 0);
        M_AXI_RDATA  : in  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
        M_AXI_RRESP  : in  std_logic_vector(2-1 downto 0);
        M_AXI_RLAST  : in  std_logic;
        M_AXI_RUSER  : in  std_logic_vector(C_M_AXI_RUSER_WIDTH-1 downto 0);
        M_AXI_RVALID : in  std_logic;
        M_AXI_RREADY : out std_logic;
        
        -- Slave Interface Write Address Ports
        S_AXI_AWADDR   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWPROT   : in  std_logic_vector(3-1 downto 0);
        S_AXI_AWVALID  : in  std_logic;
        S_AXI_AWREADY  : out std_logic;

        -- Slave Interface Write Data Ports
        S_AXI_WDATA  : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB  : in  std_logic_vector(C_S_AXI_DATA_WIDTH/8-1 downto 0);
        S_AXI_WVALID : in  std_logic;
        S_AXI_WREADY : out std_logic;

        -- Slave Interface Write Response Ports
        S_AXI_BRESP  : out std_logic_vector(2-1 downto 0);
        S_AXI_BVALID : out std_logic;
        S_AXI_BREADY : in  std_logic;

        -- Slave Interface Read Address Ports
        S_AXI_ARADDR   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARPROT   : in  std_logic_vector(3-1 downto 0);
        S_AXI_ARVALID  : in  std_logic;
        S_AXI_ARREADY  : out std_logic;

        -- Slave Interface Read Data Ports
        S_AXI_RDATA  : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP  : out std_logic_vector(2-1 downto 0);
        S_AXI_RVALID : out std_logic;
        S_AXI_RREADY : in  std_logic
	);

attribute SIGIS : string; 
attribute SIGIS of ACLK : signal is "Clk"; 

end axi_system86;

------------------------------------------------------------------------------
-- Architecture Section
------------------------------------------------------------------------------

-- In this section, we povide an example implementation of ENTITY axi_system86
-- that does the following:
--
-- 1. Read all inputs
-- 2. Add each input to the contents of register 'sum' which
--    acts as an accumulator
-- 3. After all the inputs have been read, write out the
--    content of 'sum' into the output stream NUMBER_OF_OUTPUT_WORDS times
--
-- You will need to modify this example or implement a new architecture for
-- ENTITY axi_system86 to implement your coprocessor

architecture EXAMPLE of axi_system86 is

   -- Total number of input data.
   constant NUMBER_OF_INPUT_WORDS  : natural := 8;

   -- Total number of output data
   constant NUMBER_OF_OUTPUT_WORDS : natural := 8;

   type STATE_TYPE is (Idle, Read_Inputs, Write_Outputs);

   signal state        : STATE_TYPE;

   -- Accumulator to hold sum of inputs read at any point in time
   signal sum          : std_logic_vector(31 downto 0);

   -- Counters to store the number inputs read & outputs written
   signal nr_of_reads  : natural range 0 to NUMBER_OF_INPUT_WORDS - 1;
   signal nr_of_writes : natural range 0 to NUMBER_OF_OUTPUT_WORDS - 1;

begin
   -- CAUTION:
   -- The sequence in which data are read in and written out should be
   -- consistent with the sequence they are written and read in the
   -- driver's axi_system86.c file

   S_AXIS_TREADY  <= '1'   when state = Read_Inputs   else '0';
   M_AXIS_TVALID <= '1' when state = Write_Outputs else '0';

   M_AXIS_TDATA <= sum;
   M_AXIS_TLAST <= '0';

   The_SW_accelerator : process (ACLK) is
   begin  -- process The_SW_accelerator
    if ACLK'event and ACLK = '1' then     -- Rising clock edge
      if ARESETN = '0' then               -- Synchronous reset (active low)
        -- CAUTION: make sure your reset polarity is consistent with the
        -- system reset polarity
        state        <= Idle;
        nr_of_reads  <= 0;
        nr_of_writes <= 0;
        sum          <= (others => '0');
      else
        case state is
          when Idle =>
            if (S_AXIS_TVALID = '1') then
              state       <= Read_Inputs;
              nr_of_reads <= NUMBER_OF_INPUT_WORDS - 1;
              sum         <= (others => '0');
            end if;

          when Read_Inputs =>
            if (S_AXIS_TVALID = '1') then
              -- Coprocessor function (Adding) happens here
              sum         <= std_logic_vector(unsigned(sum) + unsigned(S_AXIS_TDATA));
              if (nr_of_reads = 0) then
                state        <= Write_Outputs;
                nr_of_writes <= NUMBER_OF_OUTPUT_WORDS - 1;
              else
                nr_of_reads <= nr_of_reads - 1;
              end if;
            end if;

          when Write_Outputs =>
            if (M_AXIS_TREADY = '1') then
              if (nr_of_writes = 0) then
                state <= Idle;
              else
                nr_of_writes <= nr_of_writes - 1;
              end if;
            end if;
        end case;
      end if;
    end if;
   end process The_SW_accelerator;
end architecture EXAMPLE;
