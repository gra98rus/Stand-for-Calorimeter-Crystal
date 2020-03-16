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
component c_counter_binary_0                    --counter; read counter; final count value 0x28; start count value 0x00
port (
    CLK : in std_logic;                         --clock signal
    CE : in std_logic;                          --enable signal
    Q : out std_logic_vector (6 downto 0));     --counter value
end component;
------------------------------------------------------------------------
signal clock : std_logic := '0';                                
signal read_ena_s : std_logic := '0';
signal compare_ena : std_logic := '0';
signal confirm_match_s : std_logic := '0';

signal action_status : std_logic := '0';
signal observer : std_logic := '1';

signal match_event : std_logic := '0';
signal count_ena : std_logic := '0';
signal counterMy : std_logic_vector (6 downto 0) := B"000_0000" ;

signal counter : std_logic_vector (6 downto 0) := B"000_0000" ;
signal adc_data_r : adc_data_ltt := (others=>(others=>(others=>'0')));
signal test_value1 : std_logic_vector (13 downto 0) := "00000000000111";
signal test_value2 : std_logic_vector (13 downto 0) := "00000000000111";
signal test_value3 : std_logic_vector (13 downto 0) := "00000000000111";
signal flag : std_logic := '0';

-------------------------------------------------------------------------
begin
-------------------------------------------------------------------------
                                                    --input buffers 
compare_ibuf : IBUF
    port map(   
        I => confirm_match,                       
        O => confirm_match_s);
-------------------------------------------------------------------------
c_counter_binary_0_i : c_counter_binary_0              --counter
    port map(
        CLK => clk,                                  --in
        CE => '1',--read_ena_s,                              --in
        Q => counter);                                 --out
--------------------------------------------------------------------------
process (clk)                                -- trigger and counter conditions
begin
    if clk'event and clk='1' then                       --on clock  
        --if counter = B"111_1111" then
        if complete_read = '1' then
            read_ena_s <= '0';
            test_value2 <= test_value2 + 1;
        end if;
    
        if start_event = '1' and start_type = '1' then    --on start_event
            read_ena_s <= '1';
            test_value1 <= test_value1 + 1;
            compare_ena <= '0';
        elsif start_event = '1' and start_type = '0' then
            compare_ena <= '1';
            observer <= '1';
            test_value3 <= test_value3 + 1;
        end if;
   
--    if confirm_match_s'event and confirm_match_s = '1' and observer ='1'then     --check concurrency
--        match_event <= '1';
--        observer <= '0';
--    end if;
    
--    if compare_ena = '1' and match_event = '1' then 
--        action_status <= '1';           --bound start
--        read_ena_s <= '1';
--    end if;

--    if match_event = '1' then
--        match_event <= '0';             --reset match_event signal
--    end if;

    adc_data(0) <= (others => test_value1);
    adc_data(1) <= (others => test_value2);
    adc_data(2) <= (others => test_value3);
    end if;
end process;
---------------------------------------------------------------------------
read_ena <= read_ena_s;  --in
--adc_data <= ( others => (others => test_value));

--adc_data <= adc_data_r;
---------------------------------------------------------------------------S
end Behavioral;