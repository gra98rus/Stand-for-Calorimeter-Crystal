----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2017 12:21:27 PM
-- Design Name: 
-- Module Name: pl_top - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.new_types.all;

entity pl_top is
port(
    
    reset   : in std_logic;

    ps_clk_50mhz    : in std_logic;
    adc_ctrl_cmd    : in std_logic;
    clk_gen_lock : in std_logic;
    Data_read_ena : in std_logic;
    COMPARE_DATA : in std_logic_vector (55 downto 0);
    
    Data_out_1     : out std_logic_vector (31 downto 0);
    Data_out_2     : out std_logic_vector (31 downto 0);
    Buffer_state : out std_logic;
    pll_clk_p_125mhz : out std_logic;
    pll_clk_n_125mhz : out std_logic;
    
    START_EVENT : in std_logic;
    START_TYPE  : in std_logic;
    
    ADC_D0A_P : in std_logic;
    ADC_D0A_N : in std_logic;
    ADC_D1A_P : in std_logic;
    ADC_D1A_N : in std_logic;
    
    ADC_D0B_P : in std_logic;
    ADC_D0B_N : in std_logic;
    ADC_D1B_P : in std_logic;
    ADC_D1B_N : in std_logic;
    
    ADC_D0C_P : in std_logic;
    ADC_D0C_N : in std_logic;
    ADC_D1C_P : in std_logic;
    ADC_D1C_N : in std_logic;
    
    ADC_D0D_P : in std_logic;
    ADC_D0D_N : in std_logic;
    ADC_D1D_P : in std_logic;
    ADC_D1D_N : in std_logic;
    
    ADC_DC0_P : in std_logic;
    ADC_DC0_N : in std_logic;
    
    ADC_FC0_P : in std_logic;
    ADC_FC0_N : in std_logic;

    JMP1 : in std_logic;
    JMP2 : in std_logic;
               
    ALT_CT_1 : in std_logic;
    ALT_CT_2 : in std_logic;
    ALT_CT_3 : in std_logic;
    ALT_CT_4 : in std_logic;
    ALT_CT_5 : in std_logic;
    ALT_CT_6 : in std_logic;
    ALT_CT_7 : in std_logic;
    ALT_CT_8 : in std_logic;
    
    TP1 : out std_logic;
    TP2 : out std_logic;
    TP3 : out std_logic;
    TP4 : out std_logic;
    TP5 : out std_logic;
    TP6 : out std_logic;
    TP7 : out std_logic;
    TP8 : out std_logic;  
    
    ALT_01 : out std_logic;
    ALT_02 : out std_logic;
    ALT_03 : out std_logic;
    ALT_04 : out std_logic;
    ALT_05 : out std_logic;
    ALT_06 : out std_logic;
    ALT_07 : out std_logic;
    ALT_08 : out std_logic;
    ALT_09 : out std_logic;
    ALT_10 : out std_logic;
    ALT_11 : out std_logic;
    ALT_12 : out std_logic;
    ALT_13 : out std_logic;
    ALT_14 : out std_logic;
    ALT_15 : out std_logic;
    ALT_16 : out std_logic;
    ALT_17 : out std_logic;
    ALT_18 : out std_logic;
    
    regWE   : in std_logic;
    regNum  : in std_logic_vector(15 downto 0);
    dataIn  : in std_logic_vector(15 downto 0);
    dataOut : out std_logic_vector(15 downto 0)
    
    );

end pl_top;

architecture Behavioral of pl_top is
-----------------------------------------------------------------  
    constant C_DCLK_StatTaps_1    : integer := 16;

    signal ps_cnt: unsigned(7 downto 0) := (others=>'0');
        
    signal ext_clk_pll_locked : std_logic := '0';
        
    signal adc_data : adc_data_t;
    signal adc_data_a : std_logic_vector(13 downto 0) := (others=>'0');
    signal adc_data_b : std_logic_vector(13 downto 0) := (others=>'0');
    signal adc_data_c : std_logic_vector(13 downto 0) := (others=>'0');
    signal adc_data_d : std_logic_vector(13 downto 0) := (others=>'0');
    
    signal adc_status_signals : std_logic_vector (3 downto 0) := (others=>'0');
         
    signal adc_deser_clock : std_logic := '0';
    signal adc_deser_clock_locked : std_logic := '0';

    signal cmd_reset_adc_deser  : std_logic := '0';
    signal cmd_resync_adc_deser : std_logic := '0';
     
    signal write_clk : std_logic := '0';
    signal read_clk : std_logic := '0';
    
    signal dataIn_buf: adc_data_t;
    signal dataOut_buf: std_logic_vector (63 downto 0) := (others=>'0');
        
    signal write_buf_ena : std_logic := '0';
    signal read_buf_ena : std_logic := '0';
    
    signal confirm_match_s : std_logic := '0';
    
    signal shapers_config : std_logic_vector (7 downto 0);
    signal shapers_controll : std_logic_vector (11 downto 0);
    
    signal simple_buffer_state: std_logic := '0';
    
    signal Data_out: std_logic_vector (63 downto 0) := (others=>'0');
    
    signal cmd_start_top : std_logic := '0';
    signal sts_in_prog_top : std_logic := '0';
    signal sts_done_top : std_logic := '0';
-----------------------------------------------------------------   
begin
-----------------------------------------------------------------
infrastructure_top_i : entity work.infrastructure_top       --pll_block
port map(     
    
    ps_clk_50mhz => ps_clk_50mhz,                   --in
                                                    
    reset         => reset,                         --in
    
    clock => adc_deser_clock,                       --out
    ext_clk_pll_locked => ext_clk_pll_locked        --out
    ); 
-----------------------------------------------------------------
adc_deser_i : entity work.adc_deser                         --deser_block
    generic map(
        C_DCLK_StatTaps  => C_DCLK_StatTaps_1,
        C_BufioLoc  => "BUFIO_X1Y9",
        C_BufrLoc   => "BUFR_X1Y9")
    port map(
        clock => adc_deser_clock,                           --in
       
        clock_locked => adc_deser_clock_locked,             --in
              
        AdcDeserReset =>cmd_reset_adc_deser,                --in
        AdcReSync     =>cmd_resync_adc_deser,               --in
        
        data_A => adc_data_a,                               --out
        data_B => adc_data_b,                               --out
        data_C => adc_data_c,                               --out
        data_D => adc_data_d,                               --out
          
        status_signals => adc_status_signals,               --out
          
        D0PA => ADC_D0A_P,      --in
        D0NA => ADC_D0A_N,      --in                    
        D1PA => ADC_D1A_P,      --in
        D1NA => ADC_D1A_N,      --in
                      
        D0PB => ADC_D0B_P,      --in
        D0NB => ADC_D0B_N,      --in    
        D1PB => ADC_D1B_P,      --in
        D1NB => ADC_D1B_N,      --in
                           
        D0PC => ADC_D0C_P,      --in
        D0NC => ADC_D0C_N,      --in 
        D1PC => ADC_D1C_P,      --in
        D1NC => ADC_D1C_N,      --in
              
        D0PD => ADC_D0D_P,      --in
        D0ND => ADC_D0D_N,      --in
        D1PD => ADC_D1D_P,      --in
        D1ND => ADC_D1D_N,      --in
                  
        FC0P => ADC_FC0_P,      --in
        FC0N => ADC_FC0_N,      --in
                          
        DC0P => ADC_DC0_P,      --in
        DC0N => ADC_DC0_N);     --in
----------------------------------------------------------------
buffers_block_i : entity work.buffers_block             --ring and simple buffers block
port map(
    write_clk_ring => write_clk,             --in
    read_clk_ring => read_clk,               --in
    read_clk_simple => ps_clk_50mhz,         --in 
                                                
    adc_data_write => dataIn_buf,            --in
    data_read => dataOut_buf,                --out
    
    read_ring_ena => read_buf_ena,           --in
    read_simple_ena => Data_read_ena,        --in
    
    simple_buffer_state => simple_buffer_state --out
);
----------------------------------------------------------------
trigg_system_i : entity work.trigg_system           --trigger_block
port map(
    clk => read_clk,                    --in

    start_type  => START_TYPE,          --in
    start_event => START_EVENT,         --in    
    confirm_match => confirm_match_s,   --in
    
    read_ena => read_buf_ena            --out
);
----------------------------------------------------------------
bound_comparator_i : entity work.bound_comparator   --comparators block
port map(
    clk => write_clk,                   --in
     
    adc_buf_data => adc_data,           --in
    data_to_compare => COMPARE_DATA,    --in
    
    confirm_match => confirm_match_s    --out
);
----------------------------------------------------------------
shaper_controller_i : entity work.shaper_controller     --shaper controller block
port map (
    clk => ps_clk_50mhz,                    --in
    
    shapers_config => shapers_config,       --in
    
    shapers_controll => shapers_controll    --out
);
----------------------------------------------------------------
reg_i : entity work.reg_file
port map (
    clock => ps_clk_50mhz,
    dataIn => dataIn,
    dataOut => dataOut,
    regNum => regNum,
    regWE => regWE,
    
    cmd_start => cmd_start_top,
    sts_in_prog => sts_in_prog_top,
    sts_done => sts_done_top
    );

----------------------------------------------------------------
process(JMP1, JMP2)     --process to choise amplifiers coefficient
begin
    
    ALT_01 <= '0';      --out
    ALT_02 <= '0';      --out
    ALT_03 <= '0';      --out            --control signals for amplifiers
    ALT_04 <= '0';      --out
    ALT_05 <= '0';      --out
    ALT_06 <= '0';      --out
--    ALT_07 <= '0';
--    ALT_08 <= '1';
--    ALT_09 <= '1';
--    ALT_10 <= '1';
--    ALT_11 <= '1';
--    ALT_12 <= '0';        --signals are controlled by shaper controller
--    ALT_13 <= '1';
--    ALT_14 <= '0';
--    ALT_15 <= '1';
--    ALT_16 <= '1';
--    ALT_17 <= '0';
--    ALT_18 <= '1';
    
    if JMP2 = '0' and JMP1 = '0' then           
        ALT_01 <= '0';
        ALT_02 <= '0';
        ALT_03 <= '0';
        ALT_04 <= '0';
        ALT_05 <= '0';
        ALT_06 <= '0';
    elsif JMP2 = '0' and JMP1 = '1' then
        ALT_01 <= '0';
        ALT_02 <= '1';
        ALT_03 <= '0';
        ALT_04 <= '1';
        ALT_05 <= '0';
        ALT_06 <= '1';
    elsif JMP2 = '1' and JMP1 = '0' then
        ALT_01 <= '1';
        ALT_02 <= '0';
        ALT_03 <= '1';
        ALT_04 <= '0';
        ALT_05 <= '1';
        ALT_06 <= '0';
    else
        ALT_01 <= '1';
        ALT_02 <= '1';
        ALT_03 <= '1';
        ALT_04 <= '1';
        ALT_05 <= '1';
        ALT_06 <= '1';
    end if;       
       
end process;
-----------------------------------------------------------------
process(ps_clk_50mhz)
begin
    if ps_clk_50mhz'event and ps_clk_50mhz='1' then
        ps_cnt <= ps_cnt + 1;                   --counter_increment
    end if;
end process;
-----------------------------------------------------------------
adc_clk_obufds : OBUFDS
port map(
    I => adc_deser_clock,
    O => pll_clk_p_125mhz,
    OB => pll_clk_n_125mhz
);
-----------------------------------------------------------------
TP1 <= ps_cnt(0);                       --out
TP2 <= ps_cnt(1);                       --out
TP3 <= ps_cnt(2);                       --out
TP4 <= ps_cnt(3);                       --out
TP5 <= ps_cnt(4);                       --out
TP6 <= ps_cnt(5);                       --out
TP7 <= ps_cnt(6);                       --out
TP8 <= ps_cnt(7);                       --out

cmd_reset_adc_deser <= adc_ctrl_cmd;    --in
adc_deser_clock_locked <= clk_gen_lock; --in

DATA_OUT_1 <= dataOut_buf(63 downto 32);                --out
DATA_OUT_2 <= dataOut_buf(31 downto 0);                --out

adc_data(1) <= adc_data_a;              --in
adc_data(2) <= adc_data_b;              --in
adc_data(3) <= adc_data_c;              --in
adc_data(4) <= adc_data_d;              --in

dataIn_buf <= adc_data;                     --in

write_clk <= adc_deser_clock;                 --in
read_clk <= adc_deser_clock;                  --in

shapers_config <= ALT_CT_8 & ALT_CT_7 & ALT_CT_6 & ALT_CT_5
                & ALT_CT_4 & ALT_CT_3 & ALT_CT_2 & ALT_CT_1;    --in
                
ALT_07 <= shapers_controll(0);              --out
ALT_08 <= shapers_controll(1);              --out
ALT_09 <= shapers_controll(2);              --out
ALT_10 <= shapers_controll(3);              --out
ALT_11 <= shapers_controll(4);              --out
ALT_12 <= shapers_controll(5);              --out
ALT_13 <= shapers_controll(6);              --out
ALT_14 <= shapers_controll(7);              --out
ALT_15 <= shapers_controll(8);              --out
ALT_16 <= shapers_controll(9);              --out
ALT_17 <= shapers_controll(10);             --out
ALT_18 <= shapers_controll(11);             --out

Buffer_state <= simple_buffer_state;        --out
----------------------------------------------------------------

end Behavioral;
