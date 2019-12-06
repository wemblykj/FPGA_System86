-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
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
			 
          COMPONENT axi_video_tpg
			 GENERIC(
						C_COMPONENT_DEPTH : integer := 3;
						C_USE_BLANKING : integer := 1
			 );
          PORT(
                  I_CLK : IN std_logic;
						I_RST : IN std_logic;
						I_HSYNC : IN std_logic;
						I_VSYNC : IN std_logic;
						O_LOCKED : OUT std_logic;
						O_HSYNC : OUT std_logic;
						O_VSYNC : OUT std_logic;
						O_HBLANK : OUT std_logic;
						O_VBLANK : OUT std_logic;
                  O_RED : OUT std_logic_vector(3 downto 0);       
                  O_GREEN : OUT std_logic_vector(3 downto 0);
						O_BLUE : OUT std_logic_vector(3 downto 0)
                  );
          END COMPONENT;

          SIGNAL VClk :  std_logic;
			 SIGNAL Rst :  std_logic;
			 
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
			 
          uut: axi_video_tpg 
			 GENERIC MAP
			 (
				C_COMPONENT_DEPTH => 3,
				C_USE_BLANKING => 1
			 )
			 PORT MAP(
                  I_CLK => VClk,
                  I_RST => Rst,
						I_HSYNC => S1_HSync,
						I_VSYNC => S1_VSync,
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
