--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
--Date        : Fri Sep 21 17:33:27 2018
--Host        : devz.inp.nsk.su running 64-bit unknown
--Command     : generate_target ps_top_wrapper.bd
--Design      : ps_top_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
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
    UART_RX : in STD_LOGIC;
    UART_TX : out STD_LOGIC;
    
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
    ADC_FC0_N : in std_logic;
    
    SPI_CSB: out std_logic;
    SPI_SCLK: out std_logic;
    SPI_SDIO: out std_logic
    );
end crystand_top;

architecture STRUCTURE of crystand_top is
  component ps_top is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    UART_0_txd : out STD_LOGIC;
    UART_0_rxd : in STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    ADC_SPI_sck_o: out STD_LOGIC;
    ADC_SPI_io0_o: out STD_LOGIC;
    ADC_SPI_ss_o: out STD_LOGIC;
    reset : out std_logic;
    DataIn1 : in std_logic_vector;
    DataIn2 : in std_logic_vector;
    pl_reg : out std_logic_vector;
    chNum : out std_logic_vector;
    ch_comp_data : out std_logic_vector
  );
  end component ps_top;
  
  signal FCLK_CLK0 : std_logic := '0';
  
  signal reset : std_logic := '0';
  
  signal pl_reg : std_logic_vector (12 downto 0);
  signal chNum : std_logic_vector (1 downto 0);
  signal ch_comp_data : std_logic_vector (13 downto 0);
  signal DataOut1 : std_logic_vector (31 downto 0) := (others=>'0');
  signal DataOut2 : std_logic_vector (31 downto 0) := (others=>'0');
  signal alt_ct : std_logic_vector (7 downto 0) := (others=>'0');
    
begin
ps_top_i: component ps_top
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
      UART_0_rxd => UART_RX,
      UART_0_txd => UART_TX,
      FCLK_CLK0 => FCLK_CLK0,
      ADC_SPI_sck_o => SPI_SCLK,
      ADC_SPI_io0_o => SPI_SDIO,
      ADC_SPI_ss_o => SPI_CSB,
      reset => reset,
      DataIn1 =>DataOut1,
      DataIn2 =>DataOut2,
      pl_reg => pl_reg,
      chNum => chNum,
      ch_comp_data => ch_comp_data
    );
    
pl_top_i : entity work.pl_top
    port map(
    
            ps_clk_50mhz => FCLK_CLK0,
            reset => reset,
            adc_ctrl_cmd => pl_reg(0),
            clk_gen_lock => pl_reg(1),
            Data_read_ena => pl_reg(2),
            CHANNAL_NUM => chNum,
            channal_compare_data => ch_comp_data,
            start_event => pl_reg(4),
            start_type => pl_reg(3),
            
            DATA_OUT_1 => DataOut1,
            DATA_OUT_2 => DataOut2,
            
            pll_clk_p_100mhz => ADC_CLK_P,
            pll_clk_n_100mhz => ADC_CLK_N,
            
            ALT_CT => pl_reg(12 downto 5),
        
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
            ADC_FC0_N => ADC_FC0_N
            
            );    
    
end STRUCTURE;
