-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  LIBRARY video_bus_source_v1_00_a;
  USE video_bus_source_v1_00_a.video_bus_source;
  
  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

          COMPONENT VGA_Sync_Pulses
			 PORT(
                  i_Clk : IN std_logic;
						i_Rst : IN std_logic;
						o_Locked : OUT std_logic;
						o_HSync : OUT std_logic;
						o_VSync : OUT std_logic
                  );
          END COMPONENT;
			 
			 COMPONENT Sync_To_Blanking
			 PORT(
                  i_Clk : IN std_logic;
						i_Rst : IN std_logic;
						i_HSync : IN std_logic;
						i_VSync : IN std_logic;
						o_Locked : OUT std_logic;
						o_HSync : OUT std_logic;
						o_VSync : OUT std_logic;
						o_HBlank : OUT std_logic;
						o_VBlank : OUT std_logic
                  );
			END COMPONENT;
  -- Component Declaration
--          COMPONENT <component name>
--			 generic
--          (
--	       	  C_DIRECTION                    : integer              := 0;
--              C_COMPONENT_DEPTH              : integer              := 8;
--              C_USE_BLANKING                 : integer              := 0
--          );
--          PORT(
--              I_HSYNC                        : in std_logic;
--	           I_VSYNC                        : in std_logic;
--	           I_HBLANK                       : in std_logic := 'X';
--	           I_VBLANK                       : in std_logic := 'X';
--	           I_RED                          : in std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
--	           I_GREEN                        : in std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
--	           I_BLUE                         : in std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
--	 
--	           O_HSYNC                        : out std_logic;
--	           O_VSYNC                        : out std_logic;
--	           O_HBLANK                       : out std_logic := 'X';
--	           O_VBLANK                       : out std_logic := 'X';
--	           O_RED                          : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
--	           O_GREEN                        : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0);
--	           O_BLUE                         : out std_logic_vector(C_COMPONENT_DEPTH-1 downto 0)
--          );
--          END COMPONENT;

          SIGNAL VClk :  std_logic;
			 SIGNAL Rst :  std_logic;
			 
			 SIGNAL Pattern : std_logic_vector(3 downto 0) := "0110";
			 
			 SIGNAL S1_Locked :  std_logic;
			 SIGNAL S1_HSync :  std_logic;
			 SIGNAL S1_VSync :  std_logic;
			 
			 SIGNAL S2_Locked :  std_logic;
			 SIGNAL S2_HSync :  std_logic;
			 SIGNAL S2_VSync :  std_logic;
			 SIGNAL S2_HBlank :  std_logic;
			 SIGNAL S2_VBlank :  std_logic;
			 
			 SIGNAL UUT_Locked :  std_logic;
			 SIGNAL UUT_HSync :  std_logic;
			 SIGNAL UUT_VSync :  std_logic;
			 SIGNAL UUT_HBlank :  std_logic;
			 SIGNAL UUT_VBlank :  std_logic;
          SIGNAL UUT_Red :  std_logic_vector(3 downto 0);
			 SIGNAL UUT_Green :  std_logic_vector(3 downto 0);
			 SIGNAL UUT_Blue :  std_logic_vector(3 downto 0);

          CONSTANT VClk_Period : time := 1us;

  BEGIN

          stage1_timings: VGA_Sync_Pulses
			 PORT MAP(
                  i_Clk => VClk,
                  i_Rst => Rst,
						o_Locked => S1_Locked,
						o_HSync => S1_HSync,
						o_VSync => S1_VSync
          );
			 
			 stage2_timings: Sync_To_Blanking
			 PORT MAP(
                  i_Clk => VClk,
                  i_Rst => Rst,
						i_HSync => S1_HSync,
						i_VSync => S1_VSync,
						o_Locked => S2_Locked,
						o_HSync => S2_HSync,
						o_VSync => S2_VSync,
						o_HBlank => S2_HBlank,
						o_VBlank => S2_VBlank
          );
			 
  -- Component Instantiation
          uut: entity video_bus_source_v1_00_a.video_bus_source
			 GENERIC MAP
			 (
			   C_COMPONENT_DEPTH => 4,
				C_USE_BLANKING => 1
			 )
			 PORT MAP(
                  I_CLK => VClk,
                  I_HSYNC => S2_HSync,
						I_VSYNC => S2_VSync,
						I_HBLANK => S2_HBlank,
						I_VBLANK => S2_VBlank,
						I_LOCKED => S2_Locked,
						I_RED => "0110",
						I_GREEN => "0110",
						I_BLUE => "0110",
						O_LOCKED => UUT_Locked,
						O_HSYNC => UUT_HSync,
						O_VSYNC => UUT_VSync,
						O_HBLANK => UUT_HBlank,
						O_VBLANK => UUT_VBlank,
						O_RED => UUT_Red,
						O_GREEN => UUT_Green,
						O_BLUE => UUT_Blue
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
