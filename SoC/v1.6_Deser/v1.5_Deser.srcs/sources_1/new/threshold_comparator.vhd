library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.new_types.all;
use work.func_pkg.all;

entity threshold_comparator is
Port ( 
    clk : in std_logic;

    adc_buf_data     : in  adc_data_t;
    data_to_compare  : in  std_logic_vector (ADC_LENGTH * ADC_NB - 1 downto 0);
    selected_channels: in  std_logic_vector (ADC_NB - 1 downto 0);
    
    threshold_pass   : out std_logic
);
end threshold_comparator;


architecture Behavioral of threshold_comparator is
------------------------------------------------------------------------------------
    signal data_ch_A : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    signal data_ch_B : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    signal data_ch_C : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    signal data_ch_D : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    
    signal data_tc_A : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    signal data_tc_B : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    signal data_tc_C : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    signal data_tc_D : std_logic_vector (ADC_LENGTH - 1 downto 0) := (others=>'0');
    
    signal compareA : std_logic := '0';
    signal compareB : std_logic := '0';
    signal compareC : std_logic := '0';
    signal compareD : std_logic := '0';
    
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
---------------------------------------------------------------------------------------
begin
---------------------------------------------------------------------------------------
data_ch_A <= adc_buf_data(0)(13 downto 0);
data_ch_B <= adc_buf_data(1)(13 downto 0);
data_ch_C <= adc_buf_data(2)(13 downto 0);
data_ch_D <= adc_buf_data(3)(13 downto 0);

data_tc_A <= data_to_compare (13 downto 0);
data_tc_B <= data_to_compare (27 downto 14);
data_tc_C <= data_to_compare (41 downto 28);
data_tc_D <= data_to_compare (55 downto 42);
-------------------------------------------------------------------------
process (clk)
begin
if clk'event and clk = '1' then

    if adc_buf_data(0) >= data_tc_A and selected_channels(0) = '1' then
        compareA <= '1';
    else
        compareA <= '0';
    end if;
    
    if adc_buf_data(1) >= data_tc_B and selected_channels(1) = '1' then
        compareB <= '1';
    else
        compareB <= '0';
    end if;

    if adc_buf_data(2) >= data_tc_C and selected_channels(2) = '1' then
        compareC <= '1';
    else
        compareC <= '0';
    end if;
    
    if adc_buf_data(3) >= data_tc_D and selected_channels(3) = '1' then
        compareD <= '1';
    else
        compareD <= '0';
    end if; 
    
    if compareA = '1' or compareB = '1' or compareC = '1' or compareD = '1' then
        threshold_pass <= '1';
    else
        threshold_pass <= '0';
    end if;
       
end if;
end process;
-------------------------------------------------------------------------

end Behavioral;
