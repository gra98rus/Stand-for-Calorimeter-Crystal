library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE std.textio.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.new_types.all;

entity pl_top is
port(

    ps_clk_50mhz     : in std_logic;
    reset            : in std_logic;

    --clock to adc
    pll_clk_p_100mhz : out std_logic;                               
    pll_clk_n_100mhz : out std_logic;
    
    --ADC signals
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
    
    --supporting signals (free)
    TP1 : out std_logic;
    TP2 : out std_logic;
    TP3 : out std_logic;
    TP4 : out std_logic;
    TP5 : out std_logic;
    TP6 : out std_logic;
    TP7 : out std_logic;
    TP8 : out std_logic;  
    
    --amplifier control signals
    ALT_01 : out std_logic;
    ALT_02 : out std_logic;
    ALT_03 : out std_logic;
    ALT_04 : out std_logic;
    ALT_05 : out std_logic;
    ALT_06 : out std_logic;
    
    --shapers control signals
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
    regNum  : in std_logic_vector(31 downto 0);
    dataIn  : in std_logic_vector(31 downto 0);
    dataOut : out std_logic_vector(31 downto 0);
    
    oscillograms_bram_clk  : in  std_logic;
    oscillograms_bram_addr : in  std_logic_vector(6 downto 0);
    oscillograms_bram_dout : out std_logic_vector(63 downto 0);
                
    spectra_bram_addr : in std_logic_vector(15 downto 0);
    spectra_bram_clk  : in std_logic;
    spectra_bram_dout : out std_logic_vector(31 downto 0)
    
);

end pl_top;

architecture Behavioral of pl_top is
----------------------------------------------------------------- 
component c_counter_binary_ch
port ( CLK : in std_logic;
        Q  : out std_logic_vector (9 downto 0)
        );
end component;
-------------------------------------------------------------------
    constant C_DCLK_StatTaps_1    : integer := 16;

    signal ps_cnt: unsigned(7 downto 0) := (others=>'0');
        
    signal ext_clk_pll_locked : std_logic := '0';
    signal ps_clk_50mhz_s : std_logic := '0';
        
    signal adc_data : adc_data_64_t;
    signal adc_data_a : std_logic_vector(15 downto 0) := (others=>'0');
    signal adc_data_b : std_logic_vector(15 downto 0) := (others=>'0');
    signal adc_data_c : std_logic_vector(15 downto 0) := (others=>'0');
    signal adc_data_d : std_logic_vector(15 downto 0) := (others=>'0');
    
    signal adc_status_signals : std_logic_vector (3 downto 0) := (others=>'0');
         
    signal adc_deser_clock : std_logic := '0';
    signal clk_100mhz : std_logic := '0';
    signal int_rst : std_logic;

    signal cmd_resync_adc_deser : std_logic := '0';
     
    signal adc_clk : std_logic := '0';
    signal read_clk : std_logic := '0';
    
    signal dataOut_buf: std_logic_vector (63 downto 0) := (others=>'0');
        
    signal write_buf_ena : std_logic := '0';
    signal read_buf_ena : std_logic := '0';
    
    signal confirm_match_s : std_logic := '0';
    
    signal shapers_controll : std_logic_vector (11 downto 0);
    
    signal Data_out: std_logic_vector (63 downto 0) := (others=>'0');
    
    signal compare_data : std_logic_vector (55 downto 0) := (others=>'0');--b"00101101101100000110000111000011111001110000000000000000";
    signal adc_pin : std_logic;
    
    signal start_type_s : std_logic;
    signal start_event_s : std_logic;
    signal Data_read_ena_s : std_logic;
    
    signal idelayctrl_r: std_logic;
        
    signal counter_val : std_logic_vector (9 downto 0) := (others=>'0');
    signal synq: std_logic := '0';
    
    signal deser_out_clk : std_logic := '0';
    signal deser_locked : std_logic := '0';
    
    signal trigger_ena : std_logic_vector(1 downto 0) := "00";
    
    signal start_type            : std_logic                      := '0';
    signal start_event           : std_logic                      := '0';
    signal buffer_data_valid     : std_logic                      := '0';
    signal selected_channels_top : std_logic_vector ( 3 downto 0) := (others => '0');
    signal shapers_config_top    : std_logic_vector ( 7 downto 0);
    signal spectra_params        : std_logic_vector (13 downto 0) := (others => '0');
    attribute keep_hierarchy     : string;
    attribute keep_hierarchy of infrastructure_top_i : label is "yes";

    signal spectra_commands : std_logic_vector(11 downto 0) := (others => '0');
    
    signal adc_data_spectra : adc_data_56_t;
    signal addr_spectra     : std_logic_vector(6 downto 0);
    
    signal adc_max_value : adc_data_56_t;

-----------------------------------------------------------------   
begin

-----------------------------------------------------------------

infrastructure_top_i : entity work.infrastructure_top
port map(     
    ps_clk_50mhz       => ps_clk_50mhz,
    reset              => reset,
    
    pl_clk_100mhz      => adc_deser_clock,
    ext_clk_pll_locked => ext_clk_pll_locked,
    int_rst            => int_rst
); 

-----------------------------------------------------------------
adc_deser_i : entity work.adc_deser
generic map(
    C_DCLK_StatTaps  => C_DCLK_StatTaps_1,
    C_BufioLoc       => "BUFIO_X1Y9",
    C_BufrLoc        => "BUFR_X1Y9")
port map(
    clock         => adc_deser_clock,
    clock_locked  => ext_clk_pll_locked,
         
    AdcDeserReset => int_rst,
    AdcReSync     => cmd_resync_adc_deser,
    
    data_A => adc_data_a,
    data_B => adc_data_b,
    data_C => adc_data_c,
    data_D => adc_data_d,
         
    status_signals => adc_status_signals,
    
    clk_out => deser_out_clk,
          
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
    D1ND => ADC_D1D_N,
                 
    FC0P => ADC_FC0_P,
    FC0N => ADC_FC0_N,
                       
    DC0P => ADC_DC0_P,
    DC0N => ADC_DC0_N);
    
----------------------------------------------------------------
buffers_block_i : entity work.buffers_block
port map(
    ring_clk            => adc_clk,
    adc_data_write      => adc_data,
    
    simple_clk          => oscillograms_bram_clk,
    simple_addr         => oscillograms_bram_addr,
    
    simple_clk_spectra  => ps_clk_50mhz,
    simple_addr_spectra => addr_spectra,
    
    trigg_signal        => read_buf_ena,
    
    simple_dout         => oscillograms_bram_dout,
    simple_dout_spectra => adc_data_spectra,
    simple_max_value    => adc_max_value,
        
    simple_data_valid   => buffer_data_valid
);
----------------------------------------------------------------
trigg_system_i : entity work.trigg_system
port map(
    clk => adc_clk,                    --in
    rst => int_rst,
    start_type  => start_type,          --in
    start_event => start_event,         --in    
    threshold_pass => confirm_match_s,   --in
    
    trigg_signal => read_buf_ena            --in
);
----------------------------------------------------------------
threshold_comparator_i : entity work.threshold_comparator
port map(
    clk               => adc_clk,
    adc_buf_data      => adc_data,
    data_to_compare   => compare_data,
    selected_channels => selected_channels_top,
    
    threshold_pass    => confirm_match_s
);
----------------------------------------------------------------
shaper_controller_i : entity work.shaper_controller
port map (
    clk => ps_clk_50mhz,
    shapers_config => shapers_config_top,
    
    shapers_controll => shapers_controll
);
----------------------------------------------------------------
reg_i : entity work.reg_file
port map (
    clock             => ps_clk_50mhz,
    dataIn            => dataIn,
    dataOut           => dataOut,
    regNum            => regNum,
    regWE             => regWE,    
    data_ready        => buffer_data_valid,

    start_event       => start_event,
    trigger_type      => start_type,
    selected_channels => selected_channels_top,
    shapers_config    => shapers_config_top,
    trigger_level     => COMPARE_DATA,
    spectrum_spec     => spectra_params
);

spectra_controller_i: entity work.Spectra_controller
port map (
    clk              => ps_clk_50mhz,
    bram_ctrl_clk    => spectra_bram_clk,
    spectrum_spec    => spectra_params,
    spectra_statuses => spectra_commands,
    adc_data         => adc_data_spectra,
    adc_data_valid   => buffer_data_valid,
    PS_addr          => spectra_bram_addr,
    adc_max_value    => adc_max_value,
    
    simple_buff_addr => addr_spectra,
    PS_data          => spectra_bram_dout
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
--    ALT_12 <= '0';        --signals are controlled by shaper_controller
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
adc_clk_obufds : OBUFDS
port map(
    I => adc_deser_clock,
    O => pll_clk_p_100mhz,
    OB => pll_clk_n_100mhz
);
-----------------------------------------------------------------
c_counter_i : c_counter_binary_ch       --counter to construct reference signal
port map(
    CLK => adc_deser_clock,
    Q => counter_val
);
-----------------------------------------------------------------
process (adc_deser_clock)       --process to construct reference signal
begin
    
    if adc_deser_clock'event and adc_deser_clock = '1' then
        if counter_val < b"0000001010" then
            synq <= '1';
        else
            synq <= '0';
        end if;
    end if;
    
end process;
-----------------------------------------------------------------
TP1 <= synq;                            --out
TP2 <= adc_deser_clock;                       --out
TP3 <= ps_cnt(0);                       --out
TP4 <= ps_cnt(0);                       --out
TP5 <= ps_cnt(4);                       --out
TP6 <= ps_cnt(5);                       --out
TP7 <= ps_cnt(6);                       --out
TP8 <= ps_cnt(7);                       --out

clk_100mhz <= adc_deser_clock;          --out

adc_data(3) <= adc_data_d;              --in
adc_data(2) <= adc_data_c;              --in
adc_data(1) <= adc_data_b;              --in
adc_data(0) <= adc_data_a;              --in

adc_clk <= deser_out_clk;
read_clk <= adc_deser_clock;

ALT_07 <= shapers_controll( 0);
ALT_08 <= shapers_controll( 1);
ALT_09 <= shapers_controll( 2);
ALT_10 <= shapers_controll( 3);
ALT_11 <= shapers_controll( 4);
ALT_12 <= shapers_controll( 5);
ALT_13 <= shapers_controll( 6);
ALT_14 <= shapers_controll( 7);
ALT_15 <= shapers_controll( 8);
ALT_16 <= shapers_controll( 9);
ALT_17 <= shapers_controll(10);
ALT_18 <= shapers_controll(11);
----------------------------------------------------------------

end Behavioral;
