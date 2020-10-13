library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.new_types.all;

entity reset_system_m is
port ( 
    clk        : in  std_logic;
    ext_rst    : in  std_logic;
    pll_locked : in  std_logic;
    
    int_rst    : out std_logic
);
end reset_system_m;

architecture Behavioral of reset_system_m is

type state_type is (STT_READY, STT_WAIT);
signal state     : state_type;

begin


process(clk)
begin
    if clk'event and clk = '1' then
        case(state) is
            when STT_READY =>
                int_rst <= '0';
                if ext_rst = '1' then
                    state     <= STT_WAIT;
                end if;
            
            when STT_WAIT =>
                if pll_locked = '1' then
                    state   <= STT_READY;
                    int_rst <= '1';
                end if;
        end case;
    end if;
end process;

end Behavioral;
