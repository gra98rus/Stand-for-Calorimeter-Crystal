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
    clk             : in std_logic;
    rst             : in std_logic;
    start_type      : in std_logic;         -- 0 - user's start; 1 -forced start 
    start_event     : in std_logic;         --signal to start reading
    threshold_pass  : in std_logic;         --signal from threshold_comparator_module
        
    trigg_signal    : out std_logic
);
end trigg_system;
------------------------------------------------------------------------
architecture Behavioral of trigg_system is
------------------------------------------------------------------------

type state_type is (STT_WAIT, STT_FORCE, STT_THRESHOLD);
signal state : state_type;

attribute keep_hierarchy : string;
attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
------------------------------------------------------------------------
begin

process (clk)
begin 
    if clk'event and clk='1' then 
        if rst = '1' then
            state        <= STT_WAIT;
            trigg_signal <= '0';
        else 
            case (state) is
                when STT_WAIT =>
                    trigg_signal <= '0';
                    if start_event = '1' and start_type = '1' then
                        state           <= STT_FORCE;
                    elsif start_event = '1' and start_type = '0' then
                        state           <= STT_THRESHOLD;
                    end if;
                when STT_FORCE =>
                    state               <= STT_WAIT;
                    trigg_signal        <= '1';

                when STT_THRESHOLD =>
                    if threshold_pass = '1' then
                        state           <= STT_WAIT;
                        trigg_signal    <= '1';
                    else
                        trigg_signal    <= '0';
                    end if;
            end case;
        end if;
    end if;
end process;
---------------------------------------------------------------------------

end Behavioral;