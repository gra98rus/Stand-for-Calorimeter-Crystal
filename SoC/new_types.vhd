library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package new_types is 

    type adc_data_t is array(1 to 4) of std_logic_vector (13 downto 0);
    
    constant ADC_NB : integer := 4;
    constant baskets: integer := 4096;
    constant num_of_spectra : integer := 12;
    type adc_data_lt is array(0 to 127) of std_logic_vector(13 downto 0);
    type adc_data_ltt is array(0 to ADC_NB - 1) of adc_data_lt;
    
    type spectrum_t is array(0 to baskets - 1) of std_logic_vector(23 downto 0);
    type spectrum_params is array(0 to num_of_spectra - 1) of std_logic_vector(10 downto 0);  --cmd(10 downto 10) & num_of_basket (9 downto 7) & selected_point (6 downto 0)

end new_types;