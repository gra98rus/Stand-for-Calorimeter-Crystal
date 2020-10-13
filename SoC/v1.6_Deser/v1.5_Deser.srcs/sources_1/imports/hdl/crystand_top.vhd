library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity crystand_top is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
--    UART_RX : in STD_LOGIC;
--    UART_TX : out STD_LOGIC;
    
    JMP1 : in std_logic;
    JMP2 : in std_logic;
    
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
    
    ADC_CLK_P : out std_logic;
    ADC_CLK_N : out std_logic;
        
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
    ADC_FC0_N : in std_logic
    
--    SPI_CSB: out std_logic;
--    SPI_SCLK: out std_logic;
--    SPI_SDIO: out std_logic
    );
end crystand_top;

architecture STRUCTURE of crystand_top is
  component ps_topp is
  port (
  DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
  DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
  DDR_cas_n : inout STD_LOGIC;
  DDR_ck_n : inout STD_LOGIC;
  DDR_ck_p : inout STD_LOGIC;
  DDR_cke : inout STD_LOGIC;
  DDR_cs_n : inout STD_LOGIC;
  DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
  DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
  DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
  DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
  DDR_odt : inout STD_LOGIC;
  DDR_ras_n : inout STD_LOGIC;
  DDR_reset_n : inout STD_LOGIC;
  DDR_we_n : inout STD_LOGIC;
  FCLK_CLK0 : out STD_LOGIC;
  FIXED_IO_ddr_vrn : inout STD_LOGIC;
  FIXED_IO_ddr_vrp : inout STD_LOGIC;
  FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
  FIXED_IO_ps_clk : inout STD_LOGIC;
  FIXED_IO_ps_porb : inout STD_LOGIC;
  FIXED_IO_ps_srstb : inout STD_LOGIC;
  OSCILLOGRAMS_BRAM_PORTA_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
  OSCILLOGRAMS_BRAM_PORTA_clk : out STD_LOGIC;
  OSCILLOGRAMS_BRAM_PORTA_din : out STD_LOGIC_VECTOR ( 63 downto 0 );
  OSCILLOGRAMS_BRAM_PORTA_dout : in STD_LOGIC_VECTOR ( 63 downto 0 );
  OSCILLOGRAMS_BRAM_PORTA_en : out STD_LOGIC;
  OSCILLOGRAMS_BRAM_PORTA_rst : out STD_LOGIC;
  OSCILLOGRAMS_BRAM_PORTA_we : out STD_LOGIC_VECTOR ( 7 downto 0 );
  SPECTRA_BRAM_PORTA_addr : out STD_LOGIC_VECTOR ( 17 downto 0 );
  SPECTRA_BRAM_PORTA_clk : out STD_LOGIC;
  SPECTRA_BRAM_PORTA_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
  SPECTRA_BRAM_PORTA_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
  SPECTRA_BRAM_PORTA_en : out STD_LOGIC;
  SPECTRA_BRAM_PORTA_rst : out STD_LOGIC;
  SPECTRA_BRAM_PORTA_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
  dataIn : in STD_LOGIC_VECTOR ( 31 downto 0 );
  dataOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
  regNum : out STD_LOGIC_VECTOR ( 31 downto 0 );
  regWE : out STD_LOGIC;
  reset : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component ps_topp;
  
    signal FCLK_CLK0 : std_logic := '0';
  
    signal reset : std_logic_vector (0 downto 0) := (others=>'0');
    
    signal reg_regWE      : STD_LOGIC := '0';
    signal reg_dataFromPL   :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others=>'0');
    signal reg_dataInPL   :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others=>'0');
    signal reg_regNum :  STD_LOGIC_VECTOR ( 31 downto 0 ) := (others=>'0');
    
    signal spectra_bram_addr_top : std_logic_vector(17 downto 0) := (others=>'0');
    signal spectra_bram_clk_top  : std_logic := '0';
    signal spectra_bram_din_top  : std_logic_vector(31 downto 0) := (others=>'0');
    signal spectra_bram_dout_top : std_logic_vector(31 downto 0) := (others=>'0');
    signal spectra_bram_en   : std_logic := '1';
    signal spectra_bram_we   : std_logic_vector(3 downto 0) := (others=>'0');
    signal spectra_bram_rst  : std_logic := '0';
    
    signal oscillograms_bram_addr_top : std_logic_vector(11 downto 0) := (others=>'0');
    signal oscillograms_bram_clk_top  : std_logic := '0';
    signal oscillograms_bram_din_top  : std_logic_vector(63 downto 0) := (others=>'0');
    signal oscillograms_bram_dout_top : std_logic_vector(63 downto 0) := (others=>'0');
    signal oscillograms_bram_en   : std_logic := '1';
    signal oscillograms_bram_we   : std_logic_vector(7 downto 0) := (others=>'0');
    signal oscillograms_bram_rst  : std_logic := '0';    
begin
ps_topp_i: component ps_topp
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      FCLK_CLK0 => FCLK_CLK0,
      SPECTRA_BRAM_PORTA_addr => spectra_bram_addr_top,
      SPECTRA_BRAM_PORTA_clk  => spectra_bram_clk_top,
      SPECTRA_BRAM_PORTA_din  => spectra_bram_din_top,
      SPECTRA_BRAM_PORTA_dout => spectra_bram_dout_top,
      SPECTRA_BRAM_PORTA_en   => spectra_bram_en,
      SPECTRA_BRAM_PORTA_rst  => spectra_bram_rst,
      SPECTRA_BRAM_PORTA_we   => spectra_bram_we,
      
      OSCILLOGRAMS_BRAM_PORTA_addr => oscillograms_bram_addr_top,
      OSCILLOGRAMS_BRAM_PORTA_clk  => oscillograms_bram_clk_top,
      OSCILLOGRAMS_BRAM_PORTA_din  => oscillograms_bram_din_top,
      OSCILLOGRAMS_BRAM_PORTA_dout => oscillograms_bram_dout_top,
      OSCILLOGRAMS_BRAM_PORTA_en   => oscillograms_bram_en,
      OSCILLOGRAMS_BRAM_PORTA_rst  => oscillograms_bram_rst,
      OSCILLOGRAMS_BRAM_PORTA_we   => oscillograms_bram_we,
                  
      reset               => reset,
      
      dataIn(31 downto 0) => reg_dataFromPL(31 downto 0),
      dataOut(31 downto 0) => reg_dataInPL(31 downto 0),
      regNum(31 downto 0) => reg_regNum(31 downto 0),
      regWE => reg_regWE  
      );
    
pl_top_i : entity work.pl_top
    port map(
    
            ps_clk_50mhz => FCLK_CLK0,
            reset => reset(0),

            pll_clk_p_100mhz => ADC_CLK_P,
            pll_clk_n_100mhz => ADC_CLK_N,
            
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

            regWE   =>  reg_regWE,
            regNum  =>  reg_regNum,
            dataIn  =>  reg_dataInPL,
            dataOut =>  reg_dataFromPL,
                                
            spectra_bram_clk  => spectra_bram_clk_top,
            spectra_bram_addr => spectra_bram_addr_top(17 downto 2),
            spectra_bram_dout => spectra_bram_dout_top,
            
            oscillograms_bram_clk  => oscillograms_bram_clk_top,
            oscillograms_bram_addr => oscillograms_bram_addr_top(9 downto 3),
            oscillograms_bram_dout => oscillograms_bram_dout_top
            
            );    
    
end STRUCTURE;
