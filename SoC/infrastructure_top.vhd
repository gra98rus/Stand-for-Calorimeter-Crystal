----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2018 02:57:43 PM
-- Design Name: 
-- Module Name: infrastructure_top - Behavioral
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
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

Library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.all;

entity infrastructure_top is
port(     
    
    ps_clk_50mhz         : in std_logic;
    
    reset            : in std_logic;   
                                                                                                    
    clock              : out std_logic;
    ext_clk_pll_locked : out std_logic
    );
    
end infrastructure_top;



architecture behavioral of infrastructure_top is
----------------------------------------------------------------
component clk_wiz_0                         --pll module
port
 (
  clk_in   : in     std_logic;             --input clock signal
  
  clk_out  : out    std_logic;              --output clock signal
  
  reset    : in     std_logic;             --control signal
  locked   : out    std_logic              --status signal
 );
end component;
-----------------------------------------------------------------
    signal clk_50mhz : std_logic := '0';
    signal ext_clk_pll_locked_s : std_logic := '0';
    signal clock_s      : std_logic := '0';
-----------------------------------------------------------------
begin
------------------------------------------------------
clk_wiz_0_i : clk_wiz_0                     --pll block
   port map ( 
    clk_in => clk_50mhz,                    --in
    clk_out => clock_s,                     --out
    reset  => reset,                        --in
    locked => ext_clk_pll_locked_s);        --out
-------------------------------------------------------
clock <= clock_s;                           --out
ext_clk_pll_locked <= ext_clk_pll_locked_s; --out
clk_50mhz <= ps_clk_50mhz;                  --in

end behavioral;
