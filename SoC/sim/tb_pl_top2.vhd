library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.all;

entity tb_pl_top is
end tb_pl_top;

architecture behavioral of tb_pl_top is
    
    constant ADC_DEL_TIME : time := 0.0 ns;
    constant PS_CLK_200MHZ_PERIOD : time := 5 ns;
    constant PS_CLK_50MHZ_PERIOD : time := 20 ns;
  
    signal reset : std_logic := '0';
    signal ps_clk_50mhz : std_logic := '0';

    signal pll_clk_p_125mhz : std_logic :='0';
    signal pll_clk_n_125mhz : std_logic :='1';
    
    signal adc_ctrl_cmd : std_logic := '0';
    signal PsCmdResetAdcDeser : std_logic := '0';

    signal clk_gen_lock : std_logic := '0';
    
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

    signal JMP1 : std_logic := '0';
    signal JMP2 : std_logic := '0';
    
    signal TP1 : std_logic := '0';
    signal TP2 : std_logic := '0';
    signal TP3 : std_logic := '0';
    signal TP4 : std_logic := '0';
    signal TP5 : std_logic := '0';
    signal TP6 : std_logic := '0';
    signal TP7 : std_logic := '0';
    signal TP8 : std_logic := '0';
    
    signal ALT_CT_1 : std_logic := '0';
    signal ALT_CT_2 : std_logic := '1';
    signal ALT_CT_3 : std_logic := '1';
    signal ALT_CT_4 : std_logic := '0';
    signal ALT_CT_5 : std_logic := '1';
    signal ALT_CT_6 : std_logic := '1';
    signal ALT_CT_7 : std_logic := '0';
    signal ALT_CT_8 : std_logic := '0';
    
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
        
    signal DataOut1 : std_logic_vector (31 downto 0) := (others=>'0');
    signal DataOut2 : std_logic_vector (31 downto 0) := (others=>'0');
    signal DataReadEna : std_logic := '0';
    
    signal start_type : std_logic := '1';
    signal start_event : std_logic := '0';
    
    signal CompareData : std_logic_vector (55 downto 0) := --(others=>'0');
    B"00101101101100000110000111000011111001110000000000000000";

    signal BufferState : std_logic := '1';
      
    
    signal data_bram_addr_top : std_logic_vector(31 downto 0) := (others=>'0');
    signal data_bram_clk_top  : std_logic := '0';
    signal data_bram_din_top  : std_logic_vector(31 downto 0) := (others=>'0');
    signal data_bram_dout : std_logic_vector(31 downto 0) := (others=>'0');
    signal data_bram_en   : std_logic := '1';
    signal data_bram_we_v : std_logic_vector(3 downto 0) := (others=>'0');
    signal data_bram_we_top   : std_logic := '0';
    signal data_bram_rst  : std_logic := '0';
    
    signal reg_regWE      : STD_LOGIC := '0';
    signal reg_dataFromPL   :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others=>'0');
    signal reg_dataInPL   :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others=>'0');
    signal reg_regNum :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others=>'0');
    signal spectra_bram_dout_top : std_logic_vector(31 downto 0) := (others=>'0');
    signal spectra_bram_addr_top : std_logic_vector(17 downto 0) := (others=>'0');

    
begin

pl_top_i : entity work.pl_top
port map(
            ps_clk_50mhz => ps_clk_50mhz,
            reset => reset,
            adc_ctrl_cmd => '0',
            clk_gen_lock => '0',
            
            pll_clk_p_125mhz => ADC_CLK_P,
            pll_clk_n_125mhz => ADC_CLK_N,
            
            ALT_CT_1 => '0',
            ALT_CT_2 => '0',
            ALT_CT_3 => '0',
            ALT_CT_4 => '0',
            ALT_CT_5 => '0',
            ALT_CT_6 => '0',
            ALT_CT_7 => '0',
            ALT_CT_8 => '0',
        
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
                    
            data_bram_addr => data_bram_addr_top,
            data_bram_clk  => data_bram_clk_top,
            data_bram_din  => data_bram_din_top,
            data_bram_we   => data_bram_we_top,
                    
            spectra_bram_addr => spectra_bram_addr_top(17 downto 2),
            spectra_bram_clk  => ps_clk_50mhz,
            spectra_bram_dout  => spectra_bram_dout_top,
          
            regWE   =>  reg_regWE,
            regNum(15 downto 0)  =>  reg_regNum(15 downto 0),
            dataIn(15 downto 0)  =>  reg_dataInPL(15 downto 0),
            dataOut(15 downto 0) =>  reg_dataFromPL(15 downto 0)
    );  

    ps_clk_50mhz_pr: process
    begin
        ps_clk_50mhz <= '0';
        wait for PS_CLK_50MHZ_PERIOD/2;
        ps_clk_50mhz <= '1';
        wait for PS_CLK_50MHZ_PERIOD/2;
    end process;

end behavioral;

