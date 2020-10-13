library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.new_types.all;

entity reset_system_m is
port ( 
    clk       : in  std_logic;
    ext_rst   : in  std_logic;
    
    int_rst   : out std_logic
);
end reset_system_m;

architecture Behavioral of reset_system_m is

type state_type is (STT_WAIT, STT_COUNT);
signal state     : state_type;

signal prescaler : std_logic_vector (RST_PRESCALER - 1 downto 0);
signal rst_presc : std_logic;

begin

process(clk)
begin
    if rst_presc = '1' then
        prescaler <= (others => '0');
    elsif clk'event and clk = '1' then
        prescaler <= std_logic_vector (unsigned(prescaler) + 1);
    end if;
end process;

process(clk)
begin
    if clk'event and clk = '1' then
        case(state) is
            when STT_WAIT =>
                int_rst <= '0';
                if ext_rst = '1' then
                    state     <= STT_COUNT;
                    rst_presc <= '1';
                end if;
            
            when STT_COUNT =>
                rst_presc <= '0';
                if prescaler = "111111" then
                    state   <= STT_WAIT;
                    int_rst <= '1';
                end if;
        end case;
    end if;
end process;

end Behavioral;
