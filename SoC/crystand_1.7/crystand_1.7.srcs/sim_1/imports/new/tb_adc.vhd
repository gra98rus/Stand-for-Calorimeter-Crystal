----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2018 04:11:20 PM
-- Design Name: 
-- Module Name: tb_adc - Behavioral
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
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use ieee.std_logic_arith.all; -- conv_std_logic_vector
use ieee.numeric_bit.all;

use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_adc is
generic (
    module_name : string;
    adc_del_time : time;
    adc_del_da  : time;
    adc_del_db  : time;
    adc_del_dc  : time;
    adc_del_dd  : time;
    adc_data_file: string);
port ( 
    CLKP : in std_logic;
    CLKN : in std_logic;
    
    D0PA : out std_logic;
    D0NA : out std_logic;
    D1PA : out std_logic;
    D1NA : out std_logic;
        
    D0PB : out std_logic;
    D0NB : out std_logic;       
    D1PB : out std_logic;
    D1NB : out std_logic;
             
    D0PC : out std_logic;
    D0NC : out std_logic;       
    D1PC : out std_logic;
    D1NC : out std_logic;

    D0PD : out std_logic;
    D0ND : out std_logic; 
    D1PD : out std_logic;
    D1ND : out std_logic;
    
    FC0P : out std_logic;
    FC0N : out std_logic;
            
    DC0P : out std_logic;
    DC0N : out std_logic);
end tb_adc;

architecture behavioral of tb_adc is

    signal dc0 : std_logic :='0';
    signal fc0 : std_logic :='0';
    signal d0a : std_logic :='0';
    signal d1a : std_logic :='0';
    signal d0b : std_logic :='0';
    signal d1b : std_logic :='0';       --inner signals
    signal d0c : std_logic :='0';
    signal d1c : std_logic :='0';
    signal d0d : std_logic :='0';
    signal d1d : std_logic :='0';
    ----------------------------------------------------------
    signal dc0p_s: std_logic :='0';
    signal dc0n_s: std_logic :='1';
    
    signal fc0p_s: std_logic :='0';
    signal fc0n_s: std_logic :='1';
    
    signal d0ap_s: std_logic :='0';
    signal d0an_s: std_logic :='1';
    
    signal d1ap_s: std_logic :='0';
    signal d1an_s: std_logic :='1';         --out signals
    
    signal d0bp_s: std_logic :='0';
    signal d0bn_s: std_logic :='1';
    
    signal d1bp_s: std_logic :='0';
    signal d1bn_s: std_logic :='1';
    
    signal d0cp_s: std_logic :='0';
    signal d0cn_s: std_logic :='1';
    
    signal d1cp_s: std_logic :='0';
    signal d1cn_s: std_logic :='1';
    
    signal d0dp_s: std_logic :='0';
    signal d0dn_s: std_logic :='1';
    
    signal d1dp_s: std_logic :='0';
    signal d1dn_s: std_logic :='1';
    ----------------------------------------------------------
    signal dbg_a : std_logic_vector(13 downto 0) := (others=>'0');
    signal dbg_b : std_logic_vector(13 downto 0) := (others=>'0');      --signals to control data
    signal dbg_c : std_logic_vector(13 downto 0) := (others=>'0');
    signal dbg_d : std_logic_vector(13 downto 0) := (others=>'0');
    -----------------------------------------------------------
    signal clk_front_time_s : time := 0 ps;
    constant C_MAX_PERIOD : time := 15 ns;
    signal clk_period_time : time := 0 ps;          -- time signals
    signal tick_time_s : time := 0 ns;
    ------------------------------------------------------------
begin
-------------------------------------------------------------------------
clk_period_measure_proc : process
    
        variable no_first_front_v : boolean := false;
        variable no_second_front_v : boolean := false;
        variable clk_period_v : time := 10 ns;
    
begin
    wait on CLKP until CLKP'event and CLKP='1';
    
    if no_first_front_v = false then
        no_first_front_v := true;
    elsif no_second_front_v = false then
       no_second_front_v := true;
--       clk_front_time_v := now;
        clk_front_time_s <= now;                             -- is not checked
    else
        clk_period_v     := now - clk_front_time_s;
        if clk_period_v > C_MAX_PERIOD then -- high bound
          clk_period_v := C_MAX_PERIOD;
        end if;
        
        clk_period_time <= clk_period_v;
        tick_time_s     <= clk_period_v / 16;

        clk_front_time_s <= now;
    end if; 
end process;
--------------------------------------------------------------------------
gen_data_proc: process
    file adc_data_fd: TEXT open read_mode is adc_data_file;

    variable ilin : line;                                                                                               --to get line
    variable ch_i : integer := 0;                                                                                       --to get data from line
    variable cha_s,chb_s,chc_s,chd_s : std_logic_vector (13 downto 0) := (others =>'0');                                --to conver data
    variable cha0_s,cha1_s,chb0_s,chb1_s,chc0_s,chc1_s,chd0_s,chd1_s: std_logic_vector(7 downto 0) := (others =>'0');   --to split data on channals

begin

    wait on CLKP until CLKP'event and CLKP='1';

    readline (adc_data_fd, ilin);                                   --data initiation
    read(ilin, ch_i);
    cha_s := conv_std_logic_vector(ch_i,14);
    cha1_s := cha_s(cha_s'high) & cha_s(cha_s'high-1) & cha_s(cha_s'high-2) & cha_s(cha_s'high-3) & cha_s(cha_s'high-4)& cha_s(cha_s'high-5) & cha_s(cha_s'high-6) & cha_s(cha_s'high-7) ;
    cha0_s := cha_s(cha_s'high-8) & cha_s(cha_s'high-9) & cha_s(cha_s'high-10) & cha_s(cha_s'high-11) & cha_s(cha_s'high-12) & cha_s(cha_s'high-13) & '0' & '0';
    read(ilin,ch_i);
    chb_s := conv_std_logic_vector(ch_i,14);
    chb1_s := chb_s(chb_s'high) & chb_s(chb_s'high-1) & chb_s(chb_s'high-2) & chb_s(chb_s'high-3) & chb_s(chb_s'high-4)& chb_s(chb_s'high-5) & chb_s(chb_s'high-6) & chb_s(chb_s'high-7) ;
    chb0_s := chb_s(chb_s'high-8) & chb_s(chb_s'high-9) & chb_s(chb_s'high-10) & chb_s(chb_s'high-11) & chb_s(chb_s'high-12) & chb_s(chb_s'high-13) & '0' & '0';
    read(ilin,ch_i);
    chc_s := conv_std_logic_vector(ch_i,14);
    chc1_s := chc_s(chc_s'high) & chc_s(chc_s'high-1) & chc_s(chc_s'high-2) & chc_s(chc_s'high-3) & chc_s(chc_s'high-4)& chc_s(chc_s'high-5) & chc_s(chc_s'high-6) & chc_s(chc_s'high-7) ;
    chc0_s := chc_s(chc_s'high-8) & chc_s(chc_s'high-9) & chc_s(chc_s'high-10) & chc_s(chc_s'high-11) & chc_s(chc_s'high-12) & chc_s(chc_s'high-13) & '0' & '0';
    read(ilin,ch_i);
    chd_s := conv_std_logic_vector(ch_i,14);
    chd1_s := chd_s(chd_s'high) & chd_s(chd_s'high-1) & chd_s(chd_s'high-2) & chd_s(chd_s'high-3) & chd_s(chd_s'high-4)& chd_s(chd_s'high-5) & chd_s(chd_s'high-6) & chd_s(chd_s'high-7) ;
    chd0_s := chd_s(chd_s'high-8) & chd_s(chd_s'high-9) & chd_s(chd_s'high-10) & chd_s(chd_s'high-11) & chd_s(chd_s'high-12) & chd_s(chd_s'high-13) & '0' & '0';
                                                                      --
    dbg_a <= cha_s;
    dbg_b <= chb_s;
    dbg_c <= chc_s;                                                    --init signals to check
    dbg_d <= chd_s;
    
    dc0 <= '0';
    wait for tick_time_s;
    
    fc0 <= '1';
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';
    
    wait for tick_time_s;
    dc0 <= '1';
    wait for tick_time_s;
    
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';
    
    wait for tick_time_s;
    dc0 <= '0';
    wait for tick_time_s;
    
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';    
    
    wait for tick_time_s;
    dc0 <= '1';
    wait for tick_time_s;
    
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';    
    
    wait for tick_time_s;
    dc0 <= '0';
    wait for tick_time_s;
    
    fc0 <= '0';
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';    
    
    wait for tick_time_s;
    dc0 <= '1';
    wait for tick_time_s;
    
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';    
    
    wait for tick_time_s;
    dc0 <= '0';
    wait for tick_time_s;
    
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';    
    
    wait for tick_time_s;
    dc0 <= '1';
    wait for tick_time_s;
    
    d0a <= cha0_s(cha0_s'high);
    cha0_s := cha0_s(cha0_s'high-1 downto 0) & '0';
    d1a <= cha1_s(cha1_s'high);
    cha1_s := cha1_s(cha1_s'high-1 downto 0) & '0';
    d0b <= chb0_s(chb0_s'high);
    chb0_s := chb0_s(chb0_s'high-1 downto 0) & '0';
    d1b <= chb1_s(chb1_s'high);
    chb1_s := chb1_s(chb1_s'high-1 downto 0) & '0';
    d0c <= chc0_s(chc0_s'high);
    chc0_s := chc0_s(chc0_s'high-1 downto 0) & '0';
    d1c <= chc1_s(chc1_s'high);
    chc1_s := chc1_s(chc1_s'high-1 downto 0) & '0';
    d0d <= chd0_s(chd0_s'high);
    chd0_s := chd0_s(chd0_s'high-1 downto 0) & '0';
    d1d <= chd1_s(chd1_s'high);
    chd1_s := chd1_s(chd1_s'high-1 downto 0) & '0';    
    
end process;

    dc0p_s <= transport     dc0 after adc_del_time;
	dc0n_s <= transport not dc0 after adc_del_time;

	fc0p_s <= transport     fc0 after adc_del_time;
	fc0n_s <= transport not fc0 after adc_del_time;

	d0ap_s <= transport     d0a after adc_del_da;
	d0an_s <= transport not d0a after adc_del_da;
    d1ap_s <= transport     d1a after adc_del_da;
    d1an_s <= transport not d1a after adc_del_da;

	d0bp_s <= transport     d0b after adc_del_db;
	d0bn_s <= transport not d0b after adc_del_db;
    d1bp_s <= transport     d1b after adc_del_db;
    d1bn_s <= transport not d1b after adc_del_db;

	d0cp_s <= transport     d0c after adc_del_dc;
	d0cn_s <= transport not d0c after adc_del_dc;
    d1cp_s <= transport     d1c after adc_del_dc;
    d1cn_s <= transport not d1c after adc_del_dc;

	d0dp_s <= transport     d0d after adc_del_dd;
	d0dn_s <= transport not d0d after adc_del_dd;
    d1dp_s <= transport     d1d after adc_del_dd;
    d1dn_s <= transport not d1d after adc_del_dd;

	DC0P <= dc0p_s;
	DC0N <= dc0n_s;
	
	FC0P <= fc0p_s;
	FC0N <= fc0n_s;

	D0PA <= d0ap_s;
	D0NA <= d0an_s;
	D1PA <= d1ap_s;
    D1NA <= d1an_s;

	D0PB <= d0bp_s;
	D0NB <= d0bn_s;
	D1PB <= d1bp_s;
    D1NB <= d1bn_s;

	D0PC <= d0cp_s;
	D0NC <= d0cn_s;
	D1PC <= d1cp_s;
    D1NC <= d1cn_s;

	D0PD <= d0dp_s;
	D0ND <= d0dn_s;
	D1PD <= d1dp_s;
    D1ND <= d1dn_s;

end Behavioral;
