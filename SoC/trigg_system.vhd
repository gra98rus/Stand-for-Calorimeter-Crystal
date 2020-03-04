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

signal counter : std_logic_vector (6 downto 0) := B"000_0000" ;
signal adc_data_r : adc_data_ltt := (others=>(others=>(others=>'0')));
signal test_value : std_logic_vector (13 downto 0) := "00000000000111";

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
        CE => read_ena_s,                              --in
        Q => counter);                                 --out
--------------------------------------------------------------------------
process (clk,start_event,confirm_match_s)                                -- trigger and counter conditions
begin
    
    if clk'event and clk='1' then                       --on clock  
        if start_event = '0' and action_status = '1' then   --stop reading if counter has TOP_VALUE 
            --if counter = B"111_1111" then
            if complete_read = '1' then
                read_ena_s <= '0';
                action_status <= '0';
            end if;   
        end if;
    end if;
    
    if start_event'event and start_event = '1' then    --on start_event
        if start_type = '1' then
            action_status <= '1';            --forsed start enable       
            read_ena_s <= '1';
            adc_data_r <= ( others => (others => test_value));
            test_value <= test_value + 1;
            compare_ena <= '0';
        else
            compare_ena <= '1';              --bound start enable
            observer <= '1';
        end if;
    end if;
 
    if confirm_match_s'event and confirm_match_s = '1' and observer ='1'then     --check concurrency
        match_event <= '1';
        observer <= '0';
    end if;
    
    if compare_ena = '1' and match_event = '1' then 
        action_status <= '1';           --bound start
        read_ena_s <= '1';
    end if;

    if match_event = '1' then
        match_event <= '0';             --reset match_event signal
    end if;

end process;
---------------------------------------------------------------------------
read_ena <= read_ena_s;  --in

adc_data <= adc_data_r;
---------------------------------------------------------------------------S
end Behavioral;