library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package new_types is 

    constant ADC_NB         : integer := 4;
    constant baskets        : integer := 4096;
    constant num_of_spectra : integer := 12;
    
    constant KEEP_HIERAR    : string  := "yes";
    
    type adc_data_64_t is array(0 to 3) of std_logic_vector (15 downto 0);
    type adc_data_56_t is array(0 to 3) of std_logic_vector (13 downto 0);
 --   type adc_data_lt is array(0 to ADC_NB - 1) of adc_data_t;

    type spectrum_t         is array(0 to baskets - 1)        of std_logic_vector(23 downto 0);
    type spectrum_params_t  is array(0 to num_of_spectra - 1) of std_logic_vector(10 downto 0);  --status && num_of_bins (9 downto 7) & selected_point (6 downto 0)
    type num_of_bins_t      is array(0 to num_of_spectra - 1) of std_logic_vector( 2 downto 0);  --num_of_bins (9 downto 7) & selected_point (6 downto 0)
    type selected_point_t   is array(0 to num_of_spectra - 1) of std_logic_vector( 6 downto 0);  --num_of_bins (9 downto 7) & selected_point (6 downto 0)
    type relevant_adc_t     is array(0 to num_of_spectra - 1) of std_logic_vector(13 downto 0);  --num_of_bins (9 downto 7) & selected_point (6 downto 0)
    
    type spectra_addr is array(0 to 11) of std_logic_vector(11 downto 0);
    type spectra_data is array(0 to 11) of std_logic_vector(31 downto 0);

    type bins is array(0 to 11) of std_logic_vector(11 downto 0);

end new_types;