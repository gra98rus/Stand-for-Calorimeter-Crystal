library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package new_types is 

    constant ADC_LENGTH     : integer := 14;
    constant ADC_NB         : integer := 4;
    constant BINS_NUM       : integer := 4096;
    constant SPECTRA_NUM    : integer := 12;
    
    
    constant KEEP_HIERAR    : string  := "yes";
    
    type adc_data_64_t is array(0 to ADC_NB - 1) of std_logic_vector (15 downto 0);
    type adc_data_56_t is array(0 to ADC_NB - 1) of std_logic_vector (13 downto 0);
    type adc_data_t    is array(0 to ADC_NB - 1) of std_logic_vector (ADC_LENGTH - 1 downto 0);

    type spectrum_t         is array(0 to BINS_NUM - 1)    of std_logic_vector(23 downto 0);
    type spectrum_params_t  is array(0 to SPECTRA_NUM - 1) of std_logic_vector(10 downto 0);  --status && num_of_bins (9 downto 7) & selected_point (6 downto 0)
    type num_of_bins_t      is array(0 to SPECTRA_NUM - 1) of std_logic_vector( 2 downto 0);
    type selected_point_t   is array(0 to SPECTRA_NUM - 1) of std_logic_vector( 6 downto 0);
    type relevant_adc_t     is array(0 to SPECTRA_NUM - 1) of std_logic_vector(13 downto 0);
    
    type spectra_addr_t     is array(0 to 11) of std_logic_vector(11 downto 0);
    type spectra_data_t     is array(0 to 11) of std_logic_vector(31 downto 0);

    type bins_t             is array(0 to 11) of std_logic_vector(11 downto 0);

end new_types;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package func_pkg is
    function clog2 (depth: in natural)                  return integer;
end func_pkg;

package body func_pkg is

function clog2( depth : natural) return integer is
variable temp    : integer := depth;
variable ret_val : integer := 0;
begin
    while temp > 1 loop
        ret_val := ret_val + 1;
        temp    := temp / 2;
    end loop;

    return ret_val;
end function;

end package body func_pkg;