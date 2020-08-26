----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2019 12:54:10 PM
-- Design Name: 
-- Module Name: bound_comparator - Behavioral
-- Project Name: 
-- Target Devices:
-- Tool Versions: 
-- Description:
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.new_types.all;

entity bound_comparator is
Port ( 
    clk : in std_logic;

    adc_buf_data : in adc_data_t;
    data_to_compare : in std_logic_vector (55 downto 0);
    
    confirm_match: out std_logic
);
end bound_comparator;


architecture Behavioral of bound_comparator is
------------------------------------------------------------------------------------
    signal data_ch_A : std_logic_vector (15 downto 0) := (others=>'0');
    signal data_ch_B : std_logic_vector (15 downto 0) := (others=>'0');
    signal data_ch_C : std_logic_vector (15 downto 0) := (others=>'0');
    signal data_ch_D : std_logic_vector (15 downto 0) := (others=>'0');
    
    signal data_tc_A : std_logic_vector (15 downto 0) := (others=>'0');
    signal data_tc_B : std_logic_vector (15 downto 0) := (others=>'0');
    signal data_tc_C : std_logic_vector (15 downto 0) := (others=>'0');
    signal data_tc_D : std_logic_vector (15 downto 0) := (others=>'0');
    
    signal compareA : std_logic := '0';
    signal compareB : std_logic := '0';
    signal compareC : std_logic := '0';
    signal compareD : std_logic := '0';
---------------------------------------------------------------------------------------
begin
---------------------------------------------------------------------------------------
                                            --prepare data to compare
data_ch_A <= adc_buf_data(1);                   
data_ch_B <= adc_buf_data(2);               --adc data
data_ch_C <= adc_buf_data(3);                          
data_ch_D <= adc_buf_data(4);

data_tc_A <= B"00" & data_to_compare (13 downto 0);
data_tc_B <= B"00" & data_to_compare (27 downto 14);
data_tc_C <= B"00" & data_to_compare (41 downto 28);    --compare data
data_tc_D <= B"00" & data_to_compare (55 downto 42);
-------------------------------------------------------------------------
process (clk)
begin
if clk'event and clk = '1' then

    if data_ch_A >= data_tc_A then
        compareA <= '1';
    else
        compareA <= '0';                        --ch_A comparator
    end if;
    
    if data_ch_B >= data_tc_B then
        compareB <= '1';
    else
        compareB <= '0';                        --ch_B comparator
    end if;

    if data_ch_C >= data_tc_C then
        compareC <= '1';
    else
        compareC <= '0';                        --ch_C comparator
    end if;
    
    if data_ch_D >= data_tc_D then
        compareD <= '1';
    else
        compareD <= '0';                        --ch_D comparator
    end if; 
    
    if compareA = '1' and compareB = '1' and compareC = '1' and compareD = '1' then
        confirm_match <= '1';
    else                                        --compare result
        confirm_match <= '0';
    end if;
       
end if;
end process;
-------------------------------------------------------------------------

end Behavioral;
