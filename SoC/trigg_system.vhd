library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.ALL;
library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.new_types.all;
------------------------------------------------------------------------
entity trigg_system is
Port ( 
    clk : in std_logic;
    clk_100 : in std_logic;
        
    start_type    : in std_logic;         -- 0 - user's start; 1 -forced start 
    start_event   : in std_logic;         --signal to start reading
    confirm_match : in std_logic;         --signal from bound_comparator_module
    complete_read : in std_logic;
        
    read_ena      : out std_logic;
    
    adc_data      : out adc_data_ltt

);
end trigg_system;
------------------------------------------------------------------------
architecture Behavioral of trigg_system is
------------------------------------------------------------------------
signal read_ena_s : std_logic := '0';

signal start_event_delay : std_logic := '0';
signal start_event_result : std_logic := '0';

signal test_value1 : std_logic_vector (13 downto 0) := "00000000000111";
signal test_value2 : std_logic_vector (13 downto 0) := "00000000000111";
signal test_value3 : std_logic_vector (13 downto 0) := "00000000000111";
signal test_value4 : std_logic_vector (13 downto 0) := "00000000000111";
------------------------------------------------------------------------
begin

process(clk)
begin
    if clk'event and clk='1' then
        start_event_delay <= start_event;
		if start_event = '1' and start_event_delay = '0' then
			start_event_result <= '1';
	    else
	        start_event_result <= '0';
		end if;
	end if;
end process;

process (clk_100)
variable compare_ena : integer := 0;
begin
    if clk_100'event and clk_100='1' then
        if read_ena_s = '1' and complete_read = '1' then
            read_ena_s <= '0';
            test_value2 <= test_value2 + 1;
        end if;
    
        if start_event = '1' and start_type = '1' then
            read_ena_s <= '1';
            test_value1 <= test_value1 + 1;
            compare_ena := 0;
        elsif start_event = '1' and start_type = '0' then
            compare_ena := 1;
            test_value3 <= test_value3 + 1;
        end if;
   
        if compare_ena = 1 then 
            if confirm_match = '1' then
                read_ena_s <= '1';
                compare_ena := 0;
                test_value4 <= test_value4 + 1;
            end if;
        end if;

        adc_data(0) <= (others => test_value1);
        adc_data(1) <= (others => test_value2);
        adc_data(2) <= (others => test_value3);
        adc_data(3) <= (others => test_value4);
    end if;
end process;
---------------------------------------------------------------------------
read_ena <= read_ena_s;  --in
---------------------------------------------------------------------------S
end Behavioral;