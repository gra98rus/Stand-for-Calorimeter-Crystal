library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.new_types.all;

entity spectrum_creator is
generic(
    type_of_spectrum : std_logic                     -- 1 - selected point; 0 - max value
);
Port (
    clk            : in std_logic;
    status            : in std_logic;
   -- num_of_basket  : in std_logic_vector (2 downto 0);
   -- selected_point : in std_logic_vector (6 downto 0);
    spectra_params : in std_logic_vector(9 downto 0);
    adc_data       : in adc_data_lt;
    adc_data_valid : in std_logic;

    bin            : out std_logic_vector(11 downto 0);
    increase_status: out std_logic
    
);
end spectrum_creator;

architecture Behavioral of spectrum_creator is

    signal current_max : std_logic_vector(13 downto 0) := (others => '0');
    signal new_value : std_logic_vector(13 downto 0) := (others => '0');
    signal counter : integer := 0;
    signal status_of_val: integer := 0;
    signal current_bin: std_logic_vector(11 downto 0) := (others => '0');

    signal num_of_basket  : std_logic_vector (2 downto 0) := (others => '0');
    signal selected_point : std_logic_vector (6 downto 0) := (others => '0');
     
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

        if status = '1' and adc_data_valid_result = '1' and type_of_spectrum = '0' then
            if counter = 127 then
                counter <= 0;
                new_value <= current_max;
                current_max <= (others => '0');
                status_of_val <= 1;
            elsif adc_data(counter) > current_max then
                current_max <= adc_data(counter);
                status_of_val <= 0;
            end if;
        elsif status = '1' and adc_data_valid_result = '1' and type_of_spectrum = '1' then
            new_value <= adc_data(to_integer(unsigned(selected_point)));
            status_of_val <= 1;
        else
            status_of_val <= 0;
        end if;        
    end if;
end process;
 
--process (clk)
--begin
--    if clk'event and clk='1' then

--        if status = '1' and adc_data_valid_result = '1' and type_of_spectrum = '0' then
--            new_value <= adc_data(to_integer(unsigned(selected_point)));
--        end if;
        
--    end if;
--end process;

 process (clk)
begin
    if clk'event and clk='1' then

        if status_of_val = 1 then
            --status_of_val <= 0;
            if num_of_basket = "111" then
                current_bin <= new_value(13 downto 2);
            elsif num_of_basket = "110" then
                current_bin <= "0" & new_value(13 downto 3);
            elsif num_of_basket = "101" then
                current_bin <= "00" & new_value(13 downto 4);
            elsif num_of_basket = "100" then
                current_bin <= "000" & new_value(13 downto 5);
            elsif num_of_basket = "011" then
                current_bin <= "0000" & new_value(13 downto 6);
            elsif num_of_basket = "010" then
                current_bin <= "00000" & new_value(13 downto 7);
            elsif num_of_basket = "001" then
                current_bin <= "000000" & new_value(13 downto 8);
            elsif num_of_basket = "000" then
                current_bin <= "0000000" & new_value(13 downto 9);
            end if;
        increase_status_r <= '1';    
        elsif increase_status_r = '1' then
            increase_status_r <= '0';
        end if;
        
    end if;
end process;

num_of_basket <= spectra_params(9 downto 7);
selected_point <= spectra_params(6 downto 0);

bin <= current_bin;
increase_status <= increase_status_r;

end Behavioral;
