library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.new_types.all;

entity spectrum_creator is
Port (
    clk           : in std_logic;
    num_of_basket : in std_logic_vector (3 downto 0);
    start_cmd     : in std_logic;
    reset_cmd     : in std_logic;
    adc_data      : in adc_data_ltt;
    
    spectrum      : out spectrum_t
    
);
end spectrum_creator;

architecture Behavioral of spectrum_creator is

begin


end Behavioral;
