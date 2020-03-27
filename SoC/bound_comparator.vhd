library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.new_types.all;

entity bound_comparator is
Port (
    clk : in std_logic;
    adc_buf_data : in adc_data_t;
    data_to_compare : in std_logic_vector (55 downto 0);
    selected_channels: in std_logic_vector(3 downto 0);
    confirm_match: out std_logic;
    adc_data       : out adc_data_ltt
);
end bound_comparator;

architecture Behavioral of bound_comparator is
------------------------------------------------------------------------------------
    signal data_ch_A : std_logic_vector (13 downto 0) := (others=>'0');
    signal data_ch_B : std_logic_vector (13 downto 0) := (others=>'0');
    signal data_ch_C : std_logic_vector (13 downto 0) := (others=>'0');
    signal data_ch_D : std_logic_vector (13 downto 0) := (others=>'0');
    
    signal data_tc_A : std_logic_vector (13 downto 0) := (others=>'0');
    signal data_tc_B : std_logic_vector (13 downto 0) := (others=>'0');
    signal data_tc_C : std_logic_vector (13 downto 0) := (others=>'0');
    signal data_tc_D : std_logic_vector (13 downto 0) := (others=>'0');
    
    signal compareA : std_logic := '0';
    signal compareB : std_logic := '0';
    signal compareC : std_logic := '0';
    signal compareD : std_logic := '0';
    signal adc_data_r : adc_data_ltt := (others=>(others=>(others=>'0')));
---------------------------------------------------------------------------------------
begin
---------------------------------------------------------------------------------------
data_ch_A <= adc_buf_data(1);
data_ch_B <= adc_buf_data(2);
data_ch_C <= adc_buf_data(3);
data_ch_D <= adc_buf_data(4);

data_tc_A <= data_to_compare (13 downto 0);
data_tc_B <= data_to_compare (27 downto 14);
data_tc_C <= data_to_compare (41 downto 28);
data_tc_D <= data_to_compare (55 downto 42);
-------------------------------------------------------------------------
process (clk)
begin
if clk'event and clk = '1' then

    if data_ch_A >= data_tc_A and selected_channels(0) = '1' then
        compareA <= '1';
    else
        compareA <= '0';
    end if;
    
    if data_ch_B >= data_tc_B and selected_channels(1) = '1' then
        compareB <= '1';
    else
        compareB <= '0';
    end if;

    if data_ch_C >= data_tc_C and selected_channels(2) = '1' then
        compareC <= '1';
    else
        compareC <= '0';
    end if;
    
    if data_ch_D >= data_tc_D and selected_channels(3) = '1' then
        compareD <= '1';
    else
        compareD <= '0';
    end if; 
    
    if compareA = '1' or compareB = '1' or compareC = '1' or compareD = '1' then
        confirm_match <= '1';
    else
        confirm_match <= '0';
    end if;
    adc_data_r(0) <= (others => data_tc_A);
    adc_data_r(1) <= (others => data_tc_B);
    adc_data_r(2) <= (others => data_tc_C);
    adc_data_r(3) <= (others => data_tc_D);
    
end if;
end process;
-------------------------------------------------------------------------
adc_data <= adc_data_r;
end Behavioral;
