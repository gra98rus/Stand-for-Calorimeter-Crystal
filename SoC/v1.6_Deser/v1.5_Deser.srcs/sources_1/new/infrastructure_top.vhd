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
    
    ps_clk_50mhz       : in std_logic;
    reset              : in std_logic;   
                                                                                                    
    pl_clk_100mhz      : out std_logic;
    ext_clk_pll_locked : out std_logic;
    idelayctrl_0_ready : out std_logic;
    int_rst            : out std_logic
    );
    
end infrastructure_top;

architecture behavioral of infrastructure_top is
----------------------------------------------------------------
component pll
port
 (
  clk_in1   : in     std_logic;
  reset     : in     std_logic;
  
  clk_out1  : out    std_logic;
  clk_out2  : out    std_logic;
  locked    : out    std_logic
 );
end component;
-----------------------------------------------------------------
    signal ext_clk_pll_locked_s     : std_logic := '0';
    signal ext_clk_pll_locked_s_i   : std_logic := '0';
    signal clk_100mhz               : std_logic := '0';
    signal clk_10mhz                : std_logic := '0';
    signal idelayctrl_0_ready_s     : std_logic := '0';
    signal clk_200mhz               : std_logic := '0';
-----------------------------------------------------------------
begin
------------------------------------------------------
pll_inst : pll
port map ( 
    clk_in1  => ps_clk_50mhz,
    reset    => reset,
    
    clk_out1 => clk_100mhz,
    clk_out2 => clk_200mhz,
    locked   => ext_clk_pll_locked_s
);
    
-------------------------------------------------------
idelayctrl_0 : IDELAYCTRL
port map(
    RDY    => idelayctrl_0_ready_s,
    REFCLK => clk_200mhz,
    RST    => reset
);
    
-------------------------------------------------------
rst_sys : entity work.reset_system_m
port map ( 
    clk        => ps_clk_50mhz,
    ext_rst    => reset,
    pll_locked => ext_clk_pll_locked_s,
    
    int_rst    => int_rst
);


pl_clk_100mhz      <= clk_100mhz;
ext_clk_pll_locked <= ext_clk_pll_locked_s;
idelayctrl_0_ready <=idelayctrl_0_ready_s;

end behavioral;