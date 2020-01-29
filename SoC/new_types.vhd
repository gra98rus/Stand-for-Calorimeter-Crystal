library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package new_types is 

    type adc_data_t is array(1 to 4) of std_logic_vector (13 downto 0);

end new_types;