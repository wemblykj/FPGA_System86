----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:48:42 11/22/2011 
-- Design Name: 
-- Module Name:    axi_system86_reg - Behavioral 
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

------------------------------------------------------------------------
-- Module Declaration
------------------------------------------------------------------------
entity axi_system86_reg is
    generic(
	    C_CTRL_WIDTH : integer range 2 to 3 := 3;
	    C_ADDR_WIDTH : integer range 4 to 16 := 16;
        C_DATA_WIDTH : integer range 4 to 8 := 8;
        C_SLV_DWIDTH        	  	: integer   						  := 32;
		C_USER_NUM_REG          	: integer   						  := 4
		);
    port(
        Control      		 : out std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
        Status       		 : in std_logic_vector(C_SLV_DWIDTH - 1 downto 0);
          
		BusControlRead      : in std_logic_vector(C_CTRL_WIDTH - 1 downto 0);
		  
        BusAddressRead      : in std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
        BusAddressWrite     : out std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
        
        BusDataRead         : in std_logic_vector(C_DATA_WIDTH - 1 downto 0);
        BusDataWrite        : out std_logic_vector(C_DATA_WIDTH - 1 downto 0);
        
        Bus2IP_Clk          : in  std_logic;
        Bus2IP_Resetn       : in  std_logic;
        Bus2IP_Data         : in  std_logic_vector(C_SLV_DWIDTH-1 downto 0);
        Bus2IP_BE           : in  std_logic_vector(C_SLV_DWIDTH/8-1 downto 0);
        Bus2IP_RdCE         : in  std_logic_vector(C_USER_NUM_REG-1 downto 0);
        Bus2IP_WrCE         : in  std_logic_vector(C_USER_NUM_REG-1 downto 0);
        IP2Bus_Data         : out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
        IP2Bus_RdAck        : out std_logic;
        IP2Bus_WrAck        : out std_logic;
        IP2Bus_Error        : out std_logic);
end axi_system86_reg;

architecture Behavioral of axi_system86_reg is

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------

constant BUS_LSB   : integer := 0;
constant CTRL_LSB  : integer := BUS_LSB;
constant CTRL_MSB  : integer := (CTRL_LSB + C_CTRL_WIDTH) - 1;
constant ADDR_LSB  : integer := CTRL_MSB + 1;
constant ADDR_MSB  : integer := (ADDR_LSB + C_ADDR_WIDTH) - 1;
constant DATA_LSB  : integer := ADDR_MSB + 1;
constant DATA_MSB  : integer := (DATA_LSB + C_DATA_WIDTH) - 1;
constant BUS_MSB   : integer := DATA_MSB;
constant BUS_WIDTH : integer := (BUS_MSB - BUS_LSB) + 1;

constant ZERO_BUS_PAD : std_logic_vector(0 to (C_SLV_DWIDTH-BUS_WIDTH)-1)
	:= (others => '0');

-------------------------------------------------------------------------------
-- Function Declarations
-------------------------------------------------------------------------------

function unpack_ctrl( reg : std_logic_vector ) return std_logic_vector is
	variable res : std_logic_vector(C_CTRL_WIDTH-1 downto 0);
begin
	res := reg(CTRL_MSB downto CTRL_LSB);
	return res;
end;

function unpack_addr( reg : std_logic_vector ) return std_logic_vector is
	variable res : std_logic_vector(C_ADDR_WIDTH-1 downto 0);
begin
	res := reg(ADDR_MSB downto ADDR_LSB);
	return res;
end;

function unpack_data( reg : std_logic_vector ) return std_logic_vector is
	variable res : std_logic_vector(C_DATA_WIDTH-1 downto 0);
begin
	res := reg(DATA_MSB downto DATA_LSB);
	return res;
end;

function pack_bus( data : std_logic_vector; addr : std_logic_vector; ctrl : std_logic_vector ) return std_logic_vector is
begin
	 return ZERO_BUS_PAD & data & addr & ctrl;
end;

function pack_addr( reg : std_logic_vector; addr : std_logic_vector ) return std_logic_vector is
begin
	 return ZERO_BUS_PAD & unpack_data(reg) & addr & unpack_ctrl(reg);
end;

function pack_data( reg : std_logic_vector; data : std_logic_vector ) return std_logic_vector is
begin
	 return ZERO_BUS_PAD & data & unpack_addr(reg) & unpack_ctrl(reg);
end;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------

signal control_i		  		 	: std_logic_vector(C_SLV_DWIDTH-1 downto 0);
signal bus_addr_read_i     	: std_logic_vector(C_ADDR_WIDTH-1 downto 0);
signal bus_data_read_i     	: std_logic_vector(C_DATA_WIDTH-1 downto 0);
signal bus_write_i     			: std_logic_vector(C_SLV_DWIDTH-1 downto 0);

signal slv_reg_write_sel    : std_logic_vector(C_USER_NUM_REG-1 downto 0);
signal slv_reg_read_sel     : std_logic_vector(C_USER_NUM_REG-1 downto 0);
signal slv_ip2bus_data      : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
signal slv_read_ack         : std_logic;
signal slv_write_ack        : std_logic;

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------

begin

    slv_reg_write_sel <= Bus2IP_WrCE(C_USER_NUM_REG-1 downto 0);
    slv_reg_read_sel  <= Bus2IP_RdCE(C_USER_NUM_REG-1 downto 0);
    slv_write_ack     <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3); -- or Bus2IP_WrCE(4);
    slv_read_ack      <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3); -- or Bus2IP_RdCE(4);
	 
	 Control            <= control_i;
	 BusAddressWrite    <= unpack_addr(bus_write_i);
	 BusDataWrite       <= unpack_data(bus_write_i); 
   
------------------------------------------------------------------------
-- Implement slave model software accessible registers
------------------------------------------------------------------------
    SLAVE_REG_WRITE_PROC: process(Bus2IP_Clk) is
    begin 
        if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
            if Bus2IP_Resetn = '0' then
                control_i <= (others => '0');
                
				bus_addr_read_i <= BusAddressRead;
                bus_data_read_i <= BusDataRead;
					 
				bus_write_i <= pack_bus(BusDataRead, BusAddressRead, BusControlRead);
            else
					if (bus_addr_read_i /= BusAddressRead) then
						bus_addr_read_i <= BusAddressRead;
						bus_write_i <= pack_addr(bus_write_i, BusAddressRead);
					end if;
					
					if (bus_data_read_i /= BusDataRead) then
						bus_data_read_i <= BusDataRead;
						bus_write_i <= pack_data(bus_write_i, BusDataRead);
					end if;
					
                case slv_reg_write_sel is
                    when "0010" =>
                        for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
                            if(Bus2IP_BE(byte_index) = '1') then
                                bus_write_i(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
                            end if;
                        end loop;
                    when "0001" =>
                        for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
                            if(Bus2IP_BE(byte_index) = '1') then
                                control_i(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
                            end if;
                        end loop;
                    when others => null;
                end case;
            end if;
        end if;
    end process SLAVE_REG_WRITE_PROC;
    
------------------------------------------------------------------------
-- implement slave model software accessible register read mux
------------------------------------------------------------------------
    SLAVE_REG_READ_PROC: process(slv_reg_read_sel) is
    begin
        case slv_reg_read_sel is
            when "0010" => slv_ip2bus_data <= pack_bus(BusDataRead, BusAddressRead, BusControlRead);
            when "0001" => slv_ip2bus_data <= Status;
            when others => slv_ip2bus_data <= (others => '0');
        end case;
    end process SLAVE_REG_READ_PROC;
  
    IP2Bus_Data <= slv_ip2bus_data when slv_read_ack = '1' else (others => '0');
    IP2Bus_WrAck <= slv_write_ack;
    IP2Bus_RdAck <= slv_read_ack;
    IP2Bus_Error <= '0';

end Behavioral;

