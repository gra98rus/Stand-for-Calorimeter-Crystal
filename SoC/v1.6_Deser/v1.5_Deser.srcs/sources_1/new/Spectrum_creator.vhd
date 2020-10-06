library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.new_types.all;

entity Spectrum_creator is
Port (
    clk            : in std_logic;
    ena            : in std_logic;
    num_of_bins    : in std_logic_vector(2 downto 0);
    selected_point : in std_logic_vector(6 downto 0);
    adc_data       : in std_logic_vector(13 downto 0);
    adc_data_valid : in std_logic;

    bin            : out std_logic_vector(11 downto 0);
    increase_status: out std_logic
);
end Spectrum_creator;

architecture Behavioral of Spectrum_creator is

    signal current_max : std_logic_vector(13 downto 0) := (others => '0');
    signal new_value : std_logic_vector(13 downto 0) := (others => '0');
    signal counter : integer := 0;
    signal status_of_val: integer := 0;
    signal current_bin: std_logic_vector(11 downto 0) := (others => '0');

    signal adc_data_valid_delay  : std_logic := '0';
    signal adc_data_valid_result : std_logic := '0';
    
    signal increase_status_r : std_logic := '0';
    
begin

process(clk)
begin
if clk'event and clk='1' then
    adc_data_valid_delay <= adc_data_valid;
    if adc_data_valid = '1' and adc_data_valid_delay = '0' then
        adc_data_valid_result <= '1';
    else
        adc_data_valid_result <= '0';
    end if;
end if;
end process;

process (clk)
begin
    if clk'event and clk='1' then
        if adc_data_valid_result = '1' and ena = '1' then
            if num_of_bins = "111" then
                bin <= adc_data(13 downto 2);
            elsif num_of_bins = "110" then
                bin <= "0" & adc_data(13 downto 3);
            elsif num_of_bins = "101" then
                bin <= "00" & adc_data(13 downto 4);
            elsif num_of_bins = "100" then
                bin <= "000" & adc_data(13 downto 5);
            elsif num_of_bins = "011" then
                bin <= "0000" & adc_data(13 downto 6);
            elsif num_of_bins = "010" then
                bin <= "00000" & adc_data(13 downto 7);
            elsif num_of_bins = "001" then
                bin <= "000000" & adc_data(13 downto 8);
            elsif num_of_bins = "000" then
                bin <= "0000000" & adc_data(13 downto 9);
            end if;
        increase_status <= '1';    
        else 
            increase_status <= '0';
        end if;
        
    end if;
end process;

end Behavioral;