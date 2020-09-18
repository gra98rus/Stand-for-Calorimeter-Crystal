------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 12/26/2018 02:57:43 PM
---- Design Name: 
---- Module Name: infrastructure_top - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_unsigned.ALL;
--use ieee.numeric_std.all;

--Library UNISIM;
--use UNISIM.vcomponents.all;

--library work;
--use work.all;

--entity infrastructure_top is
--port(     
    
--    ps_clk_50mhz         : in std_logic;
    
--    reset            : in std_logic;   
                                                                                                    
--    pl_clk_100mhz      : out std_logic;
--    ext_clk_pll_locked : out std_logic;
    
--    idelayctrl_0_ready : out std_logic
    
--    );
    
--end infrastructure_top;

--architecture behavioral of infrastructure_top is
------------------------------------------------------------------
--component clk_wiz_1                      --pll module
--port
-- (
--  clk_in   : in     std_logic;             --input clock signal
  
--  clk_out1  : out    std_logic;              --output clock signal
--  clk_out2  : out    std_logic;              --output clock signal
  
--  reset    : in     std_logic;             --control signal
--  locked   : out    std_logic              --status signal
-- );
--end component;
-------------------------------------------------------------------
--    signal ext_clk_pll_locked_s     : std_logic := '0';
--    signal ext_clk_pll_locked_s_i   : std_logic := '0';
--    signal clk_100mhz       : std_logic := '0';
--    signal clk_10mhz        : std_logic := '0';
--    signal idelayctrl_0_ready_s : std_logic := '0';
--    signal clk_200mhz       : std_logic := '0';
-------------------------------------------------------------------
--begin
--------------------------------------------------------
--clk_wiz_1_i : clk_wiz_1                     --pll block
--   port map ( 
--    clk_in => ps_clk_50mhz,                    --in
--    clk_out1 => clk_100mhz,                     --out
--    clk_out2 => clk_200mhz,
--    reset  => reset,                        --in
--    locked => ext_clk_pll_locked_s);        --out
---------------------------------------------------------
--idelayctrl_0 : IDELAYCTRL
--port map(
--    RDY    => idelayctrl_0_ready_s,
--    REFCLK => clk_200mhz,
--    RST    => reset);
---------------------------------------------------------

--        pl_clk_100mhz <= clk_100mhz;                           --out
--        ext_clk_pll_locked <= ext_clk_pll_locked_s; --out
--        idelayctrl_0_ready <=idelayctrl_0_ready_s;

--end behavioral;
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
                                                                                                    
    pl_clk_100mhz      : out std_logic;
    ext_clk_pll_locked : out std_logic;
    
    idelayctrl_0_ready : out std_logic
    
    );
    
end infrastructure_top;

architecture behavioral of infrastructure_top is
----------------------------------------------------------------
component pll                                   --pll module
port
 (
  clk_in1   : in     std_logic;                 --input clock signal
  reset     : in     std_logic;
  
  clk_out1  : out    std_logic;                 --output clock signal
  clk_out2  : out    std_logic;                 --output clock signal
  locked    : out    std_logic                  --status signal
 );
end component;
-----------------------------------------------------------------
    signal ext_clk_pll_locked_s     : std_logic := '0';
    signal ext_clk_pll_locked_s_i   : std_logic := '0';
    signal clk_100mhz       : std_logic := '0';
    signal clk_10mhz        : std_logic := '0';
    signal idelayctrl_0_ready_s : std_logic := '0';
    signal clk_200mhz       : std_logic := '0';
-----------------------------------------------------------------
begin
------------------------------------------------------
pll_inst : pll                     --pll block
   port map ( 
    clk_in1  => ps_clk_50mhz,
    reset    => reset,
    
    clk_out1 => clk_100mhz,
    clk_out2 => clk_200mhz,
    locked   => ext_clk_pll_locked_s);
-------------------------------------------------------
idelayctrl_0 : IDELAYCTRL
port map(
    RDY    => idelayctrl_0_ready_s,
    REFCLK => clk_200mhz,
    RST    => reset);
-------------------------------------------------------

        pl_clk_100mhz <= clk_100mhz;                           --out
        ext_clk_pll_locked <= ext_clk_pll_locked_s; --out
        idelayctrl_0_ready <=idelayctrl_0_ready_s;

end behavioral;