----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 09:27:58 AM
-- Design Name: 
-- Module Name: trigg_system - Behavioral
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
-- (is not finished, need changes)
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;
------------------------------------------------------------------------
entity trigg_system is              --(is not finished, need changes)
Port ( 
    clk : in std_logic;
    
    start_type      : in std_logic;         -- 0 - user's start; 1 -forced start 
    start_event     : in std_logic;         --signal to start reading
    confirm_match   : in std_logic;       --signal from bound_comparator_module
    trigger_state     : in std_logic_vector(1 downto 0) ; 
        
    read_ena : out std_logic
);
end trigg_system;
------------------------------------------------------------------------
architecture Behavioral of trigg_system is
------------------------------------------------------------------------
signal compare_ena : std_logic := '0';
signal action_status : std_logic := '0';
-------------------------------------------------------------------------
begin
-------------------------------------------------------------------------
process (clk)               --(is not finished, need changes)
begin

    if clk'event and clk = '1' then
    
        case trigger_state is
            
            when "00" =>
                if start_event = '1' then
                    if start_type = '1' then
                        compare_ena <= '0';
                        action_status <= '1';
                    else
                        compare_ena <= '1';
                    end if;
                end if;
                
                if compare_ena = '1' and confirm_match = '1' then 
                    action_status <= '1';
                end if;
                
            when "11" =>
                action_status <= '0';    
                compare_ena <= '0';
            
            when others =>
                action_status <= '1';
                compare_ena <= '0';
        
        end case;    
            
    end if;

end process;
---------------------------------------------------------------------------
read_ena <= action_status;
---------------------------------------------------------------------------
end Behavioral;