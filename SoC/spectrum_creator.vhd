library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.new_types.all;

entity spectrum_creator is
generic(
    --channel          : std_logic_vector (1 downto 0);
    type_of_spectrum : std_logic                     -- 0 - selected point; 1 - max value
);
Port (
    clk            : in std_logic;
    cmd            : in std_logic;
   -- num_of_basket  : in std_logic_vector (2 downto 0);
   -- selected_point : in std_logic_vector (6 downto 0);
    spectra_params : in std_logic_vector(9 downto 0);
    adc_data       : in adc_data_lt;
    adc_data_valid : in std_logic

    --spectrum       : out spectrum_t
    
);
end spectrum_creator;

architecture Behavioral of spectrum_creator is

    signal current_max : std_logic_vector(13 downto 0) := (others => '0');
    signal new_max : std_logic_vector(13 downto 0) := (others => '0');
    signal counter : integer := 0;
    signal status_of_max: integer := 0;
    signal current_basket: std_logic_vector(11 downto 0) := (others => '0');
    signal current_basket_int: integer := 0;

    signal num_of_basket  : std_logic_vector (2 downto 0) := (others => '0');
    signal selected_point : std_logic_vector (6 downto 0) := (others => '0');
     
    signal adc_data_valid_delay  : std_logic := '0';
    signal adc_data_valid_result : std_logic := '0';
    
    --signal spectrum_i : spectrum_t := (others => (others => '0'));
    function toInteger (s : std_logic_vector) return integer is
    begin
        if s = "00" then 
            return 0;
        elsif s = "01" then 
            return 1;
        elsif s = "10" then 
            return 2;
        elsif s = "11" then 
            return 3;
        end if;                                
    end function;
      
    function toInteger12 (s : std_logic_vector(11 downto 0)) return integer is
    begin
        return conv_integer(s(0 downto 0)) + conv_integer(s(1 downto 1)) * 2 + conv_integer(s(2 downto 2)) * 4 + conv_integer(s(3 downto 3)) * 8 + conv_integer(s(4 downto 4)) * 16 + conv_integer(s(5 downto 5)) * 32 + conv_integer(s(6 downto 6)) * 64 + conv_integer(s(7 downto 7)) * 128 + conv_integer(s(8 downto 8)) * 256 + conv_integer(s(9 downto 9)) * 512 + conv_integer(s(10 downto 10)) * 1024 + conv_integer(s(11 downto 11)) * 2048;                                
    end function;
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

        if cmd = '1' and adc_data_valid_result = '1' and type_of_spectrum = '1' then
            if counter = 127 then
                counter <= 0;
                new_max <= current_max;
                current_max <= (others => '0');
                --status_of_max <= 1;
        elsif adc_data(counter) > current_max then
                current_max <= adc_data(counter);
            end if;
        end if;
        
    end if;
end process;
 
process (clk)
begin
    if clk'event and clk='1' then

        if cmd = '1' and adc_data_valid_result = '1' and type_of_spectrum = '0' then
            new_max <= adc_data(to_integer(unsigned(selected_point)));
        end if;
        
    end if;
end process;

 process (clk)
begin
    if clk'event and clk='1' then

        if status_of_max = 1 then
            status_of_max <= 0;
            if num_of_basket = "000" then
                current_basket <= new_max(13 downto 2);
            elsif num_of_basket = "001" then
                current_basket <= "0" & new_max(13 downto 3);
            elsif num_of_basket = "010" then
                current_basket <= "00" & new_max(13 downto 4);
            elsif num_of_basket = "011" then
                current_basket <= "000" & new_max(13 downto 5);
            elsif num_of_basket = "100" then
                current_basket <= "0000" & new_max(13 downto 6);
            elsif num_of_basket = "101" then
                current_basket <= "00000" & new_max(13 downto 7);
            elsif num_of_basket = "110" then
                current_basket <= "000000" & new_max(13 downto 8);
            elsif num_of_basket = "111" then
                current_basket <= "0000000" & new_max(13 downto 9);
            end if;
            --spectrum_i(toInteger12(current_basket)) <= spectrum_i(toInteger12(current_basket)) + 1;
        end if;
        
    end if;
end process;

--spectrum <= spectrum_i;

end Behavioral;
