library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package new_types is 

    type adc_data_t is array(1 to 4) of std_logic_vector (13 downto 0);
    
    constant ADC_NB : integer := 4;
    
    type adc_data_lt is array(0 to 127) of std_logic_vector(13 downto 0);
    type adc_data_ltt is array(0 to ADC_NB - 1) of adc_data_lt;

end new_types;