library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.all;

entity tb_pl_top is
--  Port ( );
end tb_pl_top;

architecture behavioral of tb_pl_top is
    
    constant ADC_DEL_TIME : time := 0.0 ns;
    constant ADC_DEL_DA  : time := 0.0 ns;
    constant ADC_DEL_DB  : time := 0.0 ns;
    constant ADC_DEL_DC  : time := 0.0 ns;
    constant ADC_DEL_DD  : time := 0.0 ns;
    constant PS_CLK_200MHZ_PERIOD : time := 5 ns;
    constant PS_CLK_50MHZ_PERIOD : time := 20 ns;
  
    signal reset : std_logic := '0';
    signal ps_clk_50mhz : std_logic := '0';

    signal pll_clk_p_100mhz : std_logic :='0';
    signal pll_clk_n_100mhz : std_logic :='1';
    
    signal adc_ctrl_cmd : std_logic := '0';
    signal PsCmdResetAdcDeser : std_logic := '0';

    signal ADC_CLK_P : std_logic := '0';
    signal ADC_CLK_N : std_logic := '0';
    
    signal ADC_D0A_P : std_logic := '0';
    signal ADC_D0A_N : std_logic := '1';
    signal ADC_D1A_P : std_logic := '0';
    signal ADC_D1A_N : std_logic := '1';
       
    signal ADC_D0B_P : std_logic := '0';
    signal ADC_D0B_N : std_logic := '1';
    signal ADC_D1B_P : std_logic := '0';
    signal ADC_D1B_N : std_logic := '1';
       
    signal ADC_D0C_P : std_logic := '0';
    signal ADC_D0C_N : std_logic := '1';
    signal ADC_D1C_P : std_logic := '0';
    signal ADC_D1C_N : std_logic := '1';
        
    signal ADC_D0D_P : std_logic := '0';
    signal ADC_D0D_N : std_logic := '1';
    signal ADC_D1D_P : std_logic := '0';
    signal ADC_D1D_N : std_logic := '1';
        
    signal ADC_DC0_P : std_logic := '0';
    signal ADC_DC0_N : std_logic := '1';
        
    signal ADC_FC0_P : std_logic := '0';
    signal ADC_FC0_N : std_logic := '1';

    signal JMP1 : std_logic := '1';
    signal JMP2 : std_logic := '0';
    
    signal TP1 : std_logic := '0';
    signal TP2 : std_logic := '0';
    signal TP3 : std_logic := '0';
    signal TP4 : std_logic := '0';
    signal TP5 : std_logic := '0';
    signal TP6 : std_logic := '0';
    signal TP7 : std_logic := '0';
    signal TP8 : std_logic := '0';
    
    signal ALT_CT : std_logic_vector(7 downto 0) := (others=>'0');
    
    signal ALT_01 : std_logic := '0'; 
    signal ALT_02 : std_logic := '0'; 
    signal ALT_03 : std_logic := '0'; 
    signal ALT_04 : std_logic := '0'; 
    signal ALT_05 : std_logic := '0'; 
    signal ALT_06 : std_logic := '0'; 
    signal ALT_07 : std_logic := '0'; 
    signal ALT_08 : std_logic := '0'; 
    signal ALT_09 : std_logic := '0'; 
    signal ALT_10 : std_logic := '0'; 
    signal ALT_11 : std_logic := '0'; 
    signal ALT_12 : std_logic := '0'; 
    signal ALT_13 : std_logic := '0'; 
    signal ALT_14 : std_logic := '0'; 
    signal ALT_15 : std_logic := '0'; 
    signal ALT_16 : std_logic := '0'; 
    signal ALT_17 : std_logic := '0'; 
    signal ALT_18 : std_logic := '0';
        
    signal channal : std_logic_vector (1 downto 0) := b"00";
    signal cmd_resync_adc_deser : std_logic := '0';
    
    signal start_type : std_logic := '1';
    signal start_event : std_logic := '0';
    
    signal regWE   : std_logic;
    signal regNum  : std_logic_vector(31 downto 0);
    signal dataIn  : std_logic_vector(31 downto 0);
    signal dataOut : std_logic_vector(31 downto 0);
    signal oscillograms_bram_addr_top : std_logic_vector(6 downto 0) := (others=>'0');
    signal oscillograms_bram_clk_top  : std_logic := '0';
    signal oscillograms_bram_din_top  : std_logic_vector(63 downto 0) := (others=>'0');
    signal oscillograms_bram_dout_top : std_logic_vector(63 downto 0) := (others=>'0');
    signal oscillograms_bram_en   : std_logic := '1';
    signal oscillograms_bram_we   : std_logic_vector(7 downto 0) := (others=>'0');
    signal oscillograms_bram_rst  : std_logic := '0';  
    signal spectra_bram_addr_top : std_logic_vector(15 downto 0) := (others=>'0');
    signal spectra_bram_clk_top  : std_logic := '0';
    signal spectra_bram_din_top  : std_logic_vector(63 downto 0) := (others=>'0');
    signal spectra_bram_dout_top : std_logic_vector(31 downto 0) := (others=>'0');
    signal spectra_bram_en   : std_logic := '1';
    signal spectra_bram_we   : std_logic_vector(7 downto 0) := (others=>'0');
    signal spectra_bram_rst  : std_logic := '0';  
begin

pl_top_i : entity work.pl_top
port map(

    reset => reset,
    
    ps_clk_50mhz => ps_clk_50mhz,
    pll_clk_p_100mhz => pll_clk_p_100mhz,
    pll_clk_n_100mhz => pll_clk_n_100mhz,
    
    JMP1 => JMP1, 
    JMP2 => JMP2,
    
    TP1 => TP1,
    TP2 => TP2,
    TP3 => TP3,
    TP4 => TP4,
    TP5 => TP5,
    TP6 => TP6,
    TP7 => TP7,
    TP8 => TP8,
    
    ALT_01 => ALT_01,
    ALT_02 => ALT_02,
    ALT_03 => ALT_03,
    ALT_04 => ALT_04,
    ALT_05 => ALT_05,
    ALT_06 => ALT_06,
    ALT_07 => ALT_07,
    ALT_08 => ALT_08,
    ALT_09 => ALT_09,
    ALT_10 => ALT_10,
    ALT_11 => ALT_11,
    ALT_12 => ALT_12,
    ALT_13 => ALT_13,
    ALT_14 => ALT_14,
    ALT_15 => ALT_15,
    ALT_16 => ALT_16,
    ALT_17 => ALT_17,
    ALT_18 => ALT_18,  

    --ADC_CLK_P => ADC_CLK_P,
    --ADC_CLK_N => ADC_CLK_N,

    ADC_D0A_P => ADC_D0A_P,
    ADC_D0A_N => ADC_D0A_N,
    ADC_D1A_P => ADC_D1A_P,
    ADC_D1A_N => ADC_D1A_N,
    
    ADC_D0B_P => ADC_D0B_P,
    ADC_D0B_N => ADC_D0B_N,
    ADC_D1B_P => ADC_D1B_P,
    ADC_D1B_N => ADC_D1B_N,
    
    ADC_D0C_P => ADC_D0C_P,
    ADC_D0C_N => ADC_D0C_N,
    ADC_D1C_P => ADC_D1C_P,
    ADC_D1C_N => ADC_D1C_N,
    
    ADC_D0D_P => ADC_D0D_P,
    ADC_D0D_N => ADC_D0D_N,
    ADC_D1D_P => ADC_D1D_P,
    ADC_D1D_N => ADC_D1D_N,
    
    ADC_DC0_P => ADC_DC0_P,
    ADC_DC0_N => ADC_DC0_N,
    
    ADC_FC0_P => ADC_FC0_P,
    ADC_FC0_N => ADC_FC0_N,
    
    regWE     => regWE,
    regNum    => regNum,
    dataIn    => dataIn,
    dataOut   => dataOut,
                                    
    spectra_bram_clk  => spectra_bram_clk_top,
    spectra_bram_addr => spectra_bram_addr_top,
    spectra_bram_dout => spectra_bram_dout_top,
                
    oscillograms_bram_clk  => oscillograms_bram_clk_top,
    oscillograms_bram_addr => oscillograms_bram_addr_top,
    oscillograms_bram_dout => oscillograms_bram_dout_top
);  

ps_clk_50mhz_pr: process
begin
    ps_clk_50mhz <= '0';
    wait for PS_CLK_50MHZ_PERIOD/2;
    ps_clk_50mhz <= '1';
    wait for PS_CLK_50MHZ_PERIOD/2;
end process;

tb_adc_main: entity work.tb_adc
generic map(
	module_name => "ADC_output",
	adc_del_time  => ADC_DEL_TIME,
	adc_del_da   => ADC_DEL_DA,
	adc_del_db   => ADC_DEL_DB,
	adc_del_dc   => ADC_DEL_DC,
	adc_del_dd   => ADC_DEL_DD,
	adc_data_file => "adc1.txt")
port map(

    CLKP => ADC_CLK_P,
    CLKN => ADC_CLK_N,
    
    DC0P => ADC_DC0_P,
    DC0N => ADC_DC0_N,
    
    FC0P => ADC_FC0_P,
    FC0N => ADC_FC0_N,
    
    D0PA => ADC_D0A_P,
    D0NA => ADC_D0A_N,
    D1PA => ADC_D1A_P,
    D1NA => ADC_D1A_N,
    
    D0PB => ADC_D0B_P,
    D0NB => ADC_D0B_N,
    D1PB => ADC_D1B_P,
    D1NB => ADC_D1B_N,
    
    D0PC => ADC_D0C_P,
    D0NC => ADC_D0C_N,
    D1PC => ADC_D1C_P,
    D1NC => ADC_D1C_N,
    
    D0PD => ADC_D0D_P,
    D0ND => ADC_D0D_N,
    D1PD => ADC_D1D_P,
    D1ND => ADC_D1D_N);

    ADC_CLK_P <= pll_clk_p_100mhz;
    ADC_CLK_N <= pll_clk_n_100mhz;

gc_sync_b_proc: process
begin
    PsCmdResetAdcDeser <= '0';

    wait for 11000 ns;
    PsCmdResetAdcDeser <= '1';
    wait for 100 ns;
    PsCmdResetAdcDeser <= '0';
    wait for 10000 ns;
    PsCmdResetAdcDeser <= '1';
    wait for 100 ns;
    PsCmdResetAdcDeser <= '0';
    wait;
end process;

reset_proc: process
begin
    reset <= '0';

    wait for 10000 ns;
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    wait for 10000 ns;
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    wait;
end process;

read_control: process
begin
    start_event <= '0';
    wait for 16000 ns;
    start_event <= '1';
    wait for 20 ns;
    start_event <= '0';
    wait for 2020 ns;
    start_event <= '1';
    wait for 20 ns;
    start_event <= '0';
    wait for 27340 ns;
    start_event <= '1';
    wait for 20 ns;
    start_event <= '0';
    wait;
end process;

action_stat_type: process
begin
    start_type <= '1';
    wait for 15000 ns;
    start_type <= '0';
    wait for 2000 ns;
    start_type <= '1';
    wait;   
end process;

alt_ct_pr: process
begin
    alt_ct<=b"00000000";
    wait for 1000 ns;
    alt_ct<=b"11111111";
    wait for 1000 ns;
    alt_ct<=b"00000000";
    wait;
end process;

adc_ctrl_cmd <= PsCmdResetAdcDeser;

end behavioral;

