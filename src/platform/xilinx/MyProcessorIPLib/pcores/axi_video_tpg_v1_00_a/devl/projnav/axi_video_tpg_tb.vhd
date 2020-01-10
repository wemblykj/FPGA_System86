-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  LIBRARY video_lib_v1_00_a;
  USE video_lib_v1_00_a.ALL;
  
  library axi_video_tpg_v1_00_a;
  use axi_video_tpg_v1_00_a.axi_video_tpg;
  
  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT VGA_Sync_Pulses
			 GENERIC(
						-- ADD USER GENERICS BELOW THIS LINE ---------------
						TOTAL_COLS : INTEGER := 800;
						TOTAL_ROWS : INTEGER := 525;
						SYNC_PULSE_HORZ : INTEGER := 96;
						SYNC_PULSE_VERT : INTEGER := 2
						);
			 PORT(
                  i_Clk : IN std_logic;
						i_Rst : IN std_logic;
						o_Locked : OUT std_logic;
						o_HSync : OUT std_logic;
						o_VSync : OUT std_logic;
						o_Col_Count : OUT std_logic_vector(9 DOWNTO 0);
						o_Row_Count : OUT std_logic_vector(9 DOWNTO 0)
                  );
          END COMPONENT;
			 
--			 COMPONENT Sync_To_Blanking
--			 PORT(
--                  i_Clk : IN std_logic;
--						i_Rst : IN std_logic;
--						i_HSync : IN std_logic;
--						i_VSync : IN std_logic;
--						o_Locked : OUT std_logic;
--						o_HSync : OUT std_logic;
--						o_VSync : OUT std_logic;
--						o_HBlank : OUT std_logic;
--						o_VBlank : OUT std_logic
--                  );
--          END COMPONENT;
			 
--			 COMPONENT axi_video_tpg2
--			 GENERIC(
--						C_COMPONENT_DEPTH              : integer              := 8;
--						 C_TOTAL_COLS                   : integer              := 800;
--						 C_TOTAL_ROWS                   : integer              := 525;
--						 C_ACTIVE_COLS                  : integer              := 640;
--						 C_ACTIVE_ROWS                  : integer              := 480;
--						 C_SYNC_PULSE_HORZ              : integer              := 96;
--						 C_SYNC_PULSE_VERT              : integer              := 2;
--						 C_USE_BLANKING                 : integer              := 0;
--						 C_FRONT_PORCH_HORZ             : integer              := 16;
--						 C_BACK_PORCH_HORZ              : integer              := 48;
--						 C_FRONT_PORCH_VERT             : integer              := 10;
--						 C_BACK_PORCH_VERT              : integer              := 33;
--						 
--						 C_S_AXI_DATA_WIDTH             : integer              := 32;
--						 C_S_AXI_ADDR_WIDTH             : integer              := 32;
--						 C_S_AXI_MIN_SIZE               : std_logic_vector     := X"000001FF";
--						 C_USE_WSTRB                    : integer              := 0;
--						 C_DPHASE_TIMEOUT               : integer              := 8;
--						 C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
--						 C_HIGHADDR                     : std_logic_vector     := X"00000000";
--						 C_FAMILY                       : string               := "virtex6";
--						 C_NUM_REG                      : integer              := 1;
--						 C_NUM_MEM                      : integer              := 1;
--						 C_SLV_AWIDTH                   : integer              := 32;
--						 C_SLV_DWIDTH                   : integer              := 32
--			 );
--          PORT(
--                  I_CLK : IN std_logic;
--						I_RST : IN std_logic;
--						I_PATTERN : IN std_logic_vector(3 downto 0);
--						I_HSYNC : IN std_logic;
--						I_VSYNC : IN std_logic;
--						O_LOCKED : OUT std_logic;
--						O_HSYNC : OUT std_logic;
--						O_VSYNC : OUT std_logic;
--						O_HBLANK : OUT std_logic;
--						O_VBLANK : OUT std_logic;
--                  O_RED : OUT std_logic_vector(3 downto 0);       
--                  O_GREEN : OUT std_logic_vector(3 downto 0);
--						O_BLUE : OUT std_logic_vector(3 downto 0);
--						
--						S_AXI_ACLK                     : in  std_logic;
--						 S_AXI_ARESETN                  : in  std_logic;
--						 S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
--						 S_AXI_AWVALID                  : in  std_logic;
--						 S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
--						 S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
--						 S_AXI_WVALID                   : in  std_logic;
--						 S_AXI_BREADY                   : in  std_logic;
--						 S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
--						 S_AXI_ARVALID                  : in  std_logic;
--						 S_AXI_RREADY                   : in  std_logic;
--						 S_AXI_ARREADY                  : out std_logic;
--						 S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
--						 S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
--						 S_AXI_RVALID                   : out std_logic;
--						 S_AXI_WREADY                   : out std_logic;
--						 S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
--						 S_AXI_BVALID                   : out std_logic;
--						 S_AXI_AWREADY                  : out std_logic
--                  );
--          END COMPONENT;
			 
          SIGNAL VClk :  std_logic;
			 SIGNAL Rst :  std_logic;
			 
			 SIGNAL Pattern : std_logic_vector(3 downto 0) := "0110";
			 
			 SIGNAL S1_Locked :  std_logic;
			 SIGNAL S1_HSync :  std_logic;
			 SIGNAL S1_VSync :  std_logic;
			 
			 SIGNAL UUT_Locked :  std_logic;
			 SIGNAL UUT_HSync :  std_logic;
			 SIGNAL UUT_VSync :  std_logic;
			 SIGNAL UUT_HBlank :  std_logic;
			 SIGNAL UUT_VBlank :  std_logic;
          SIGNAL UUT_Red :  std_logic_vector(3 downto 0);
			 SIGNAL UUT_Green :  std_logic_vector(3 downto 0);
			 SIGNAL UUT_Blue :  std_logic_vector(3 downto 0);
          
			 SIGNAL S_AXI_ACLK                     : std_logic;
			 SIGNAL S_AXI_ARESETN                  : std_logic;
			 SIGNAL S_AXI_AWADDR                   : std_logic_vector(31 downto 0);
			 SIGNAL S_AXI_AWVALID                  : std_logic;
			 SIGNAL S_AXI_WDATA                    : std_logic_vector(31 downto 0);
			 SIGNAL S_AXI_WSTRB                    : std_logic_vector(3 downto 0);
			 SIGNAL S_AXI_WVALID                   : std_logic;
			 SIGNAL S_AXI_BREADY                   : std_logic;
			 SIGNAL S_AXI_ARADDR                   : std_logic_vector(31 downto 0);
			 SIGNAL S_AXI_ARVALID                  : std_logic;
			 SIGNAL S_AXI_RREADY                   : std_logic;
	 
          CONSTANT VClk_Period : time := 1us;
  BEGIN

  -- Component Instantiation
          stage1_timings: VGA_Sync_Pulses
			 PORT MAP(
                  i_Clk => VClk,
                  i_Rst => Rst,
						o_Locked => S1_Locked,
						o_HSync => S1_HSync,
						o_VSync => S1_VSync
          );

          -- uut: axi_video_tpg2 -- ENTITY axi_video_tpg_v1_00_a.axi_video_tpg
			 uut: ENTITY axi_video_tpg_v1_00_a.axi_video_tpg
			 GENERIC MAP
			 (
				C_COMPONENT_DEPTH => 4,
				C_USE_BLANKING => 1
			 )
			 PORT MAP(
                  I_CLK => VClk,
                  I_RST => Rst,
						I_PATTERN => Pattern,
						I_HSYNC => S1_HSync,
						I_VSYNC => S1_VSync,
						O_LOCKED => UUT_Locked,
						O_HSYNC => UUT_HSync,
						O_VSYNC => UUT_VSync,
						O_HBLANK => UUT_HBlank,
						O_VBLANK => UUT_VBlank,
						O_RED => UUT_Red,
						O_GREEN => UUT_Green,
						O_BLUE => UUT_Blue,
						
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
						S_AXI_RREADY => S_AXI_RREADY
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here

        Rst <= '1';
		  wait for 100 ns;
		  Rst <= '0';
		  
        wait; -- will wait forever
     END PROCESS tb;
	  
	  vid_clk : PROCESS
     BEGIN
        VClk <= '0';
        wait for VClk_Period/2;
        VClk <= '1';
		  wait for VClk_Period/2;
     END PROCESS vid_clk;

  --  End Test Bench 

  END;
