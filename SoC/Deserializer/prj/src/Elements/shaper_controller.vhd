----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 10:36:55 AM
-- Design Name: 
-- Module Name: shaper_controller - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shaper_controller is
Port (
    clk : in std_logic ;
    
    shapers_config : in std_logic_vector (7 downto 0);

    shapers_controll : out std_logic_vector (11 downto 0)
 );
end shaper_controller;
-----------------------------------------------------------------------
architecture Behavioral of shaper_controller is       

begin
    
process(clk)
begin

    if clk'event and clk = '1' then
        ---------------------------------------------------------
        if shapers_config (1 downto 0) = B"00" then
            shapers_controll (2 downto 0) <= B"111" ;
        elsif shapers_config (1 downto 0) = B"01" then
            shapers_controll (2 downto 0) <= B"110";                        --shaper selection for ch_A
        elsif shapers_config (1 downto 0) = B"10" then
            shapers_controll (2 downto 0) <= B"101";
        elsif shapers_config (1 downto 0) = B"11" then
            shapers_controll (2 downto 0) <= B"011";
        end if;        
        ----------------------------------------------------------
        if shapers_config (3 downto 2) = B"00" then
            shapers_controll (5 downto 3) <= B"111" ;
        elsif shapers_config (3 downto 2) = B"01" then
            shapers_controll (5 downto 3) <= B"110";                        --shaper selection for ch_B
        elsif shapers_config (3 downto 2) = B"10" then
            shapers_controll (5 downto 3) <= B"101";
        elsif shapers_config (3 downto 2) = B"11" then
            shapers_controll (5 downto 3) <= B"011";
        end if;
        ----------------------------------------------------------
        if shapers_config (5 downto 4) = B"00" then
            shapers_controll (8 downto 6) <= B"111" ;
        elsif shapers_config (5 downto 4) = B"01" then
            shapers_controll (8 downto 6) <= B"110";                        --shaper selection for ch_C
        elsif shapers_config (5 downto 4) = B"10" then
            shapers_controll (8 downto 6) <= B"101";
        elsif shapers_config (5 downto 4) = B"11" then
            shapers_controll (8 downto 6) <= B"011";
        end if;
        ----------------------------------------------------------
        if shapers_config (7 downto 6) = B"00" then
            shapers_controll (11 downto 9) <= B"111" ;
        elsif shapers_config (7 downto 6) = B"01" then
            shapers_controll (11 downto 9) <= B"110";                       --shaper selection for ch_D
        elsif shapers_config (7 downto 6) = B"10" then
            shapers_controll (11 downto 9) <= B"101";
        elsif shapers_config (7 downto 6) = B"11" then
            shapers_controll (11 downto 9) <= B"011";
        end if;        
        ----------------------------------------------------------
    end if;

end process;

end Behavioral;
