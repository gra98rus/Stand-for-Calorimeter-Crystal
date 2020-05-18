library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.new_types.all;

entity spectra_controller is
Port ( 
    clk            : in std_logic;
    spectra_params : in spectrum_params;
    adc_data       : in adc_data_ltt;
    adc_data_valid : in std_logic


);
end spectra_controller;

architecture Behavioral of spectra_controller is

begin


end Behavioral;
