library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.all;
-----------------------------------------------------------------------
entity adc_deser is
generic(
    C_DCLK_StatTaps  : integer := 16;
    C_BufioLoc  : string := "BUFIO_X0Y17"; -- IO-bank 16
    C_BufrLoc   : string := "BUFR_X0Y17");
port( 
    clock            : in std_logic;
       
    clock_locked     : in std_logic;
      
    AdcDeserReset    : in std_logic;
    AdcReSync        : in std_logic;
      
    data_A : out std_logic_vector(13 downto 0);
    data_B : out std_logic_vector(13 downto 0);
    data_C : out std_logic_vector(13 downto 0);
    data_D : out std_logic_vector(13 downto 0);
    --data_test : out std_logic_vector(13 downto 0);
    
    status_signals     : out std_logic_vector(3 downto 0);
          
    --ADC PINS
    D0PA : in std_logic;
    D0NA : in std_logic;
    D1PA : in std_logic;
    D1NA : in std_logic;
              
    D0PB : in std_logic;
    D0NB : in std_logic;       
    D1PB : in std_logic;
    D1NB : in std_logic;
                   
    D0PC : in std_logic;
    D0NC : in std_logic;       
    D1PC : in std_logic;
    D1NC : in std_logic;
      
    D0PD : in std_logic;
    D0ND : in std_logic; 
    D1PD : in std_logic;
    D1ND : in std_logic;
          
    FC0P : in std_logic;
    FC0N : in std_logic;
                  
    DC0P : in std_logic;
    DC0N : in std_logic);

end adc_deser;
-----------------------------------------------------------------------
architecture Behavioral of adc_deser is
-----------------------------------------------------------------------
    constant Low  : std_logic	:= '0';
    constant High : std_logic	:= '1';
    
	signal dclk_ib : std_logic := '0';

    signal clk_bufio    : std_logic := '0';
    signal clock_adc_s  : std_logic := '0';
    
    signal IntBitClkDone : std_logic := '0';

    signal fclk_p_b : std_logic := '0';
    signal fclk_n_b : std_logic := '0';

    signal IntClkBitSlip_p      : std_logic := '0';
    signal IntClkBitSlip_n      : std_logic := '0';
    signal IntClkSwapMux        : std_logic := '0';
    signal IntClkMsbRegEna      : std_logic := '0';
    signal IntClkLsbRegEna      : std_logic := '0';
    signal IntFrmClkReSyncOut   : std_logic := '0';
    signal AdcFrmDataOut        : std_logic_vector(15 downto 0) := (others=>'0');
    signal AdcFrmSyncWrn        : std_logic := '0';
    
    signal IntDatDA0_n : std_logic := '0';
    signal IntDatDA0_p : std_logic := '0';
    signal IntDatDA1_n : std_logic := '0';
    signal IntDatDA1_p : std_logic := '0';
    signal IntDatDB0_n : std_logic := '0';
    signal IntDatDB0_p : std_logic := '0';
    signal IntDatDB1_n : std_logic := '0';
    signal IntDatDB1_p : std_logic := '0';
    signal IntDatDC0_n : std_logic := '0';
    signal IntDatDC0_p : std_logic := '0';
    signal IntDatDC1_n : std_logic := '0';
    signal IntDatDC1_p : std_logic := '0';
    signal IntDatDD0_n : std_logic := '0';
    signal IntDatDD0_p : std_logic := '0';
    signal IntDatDD1_n : std_logic := '0';
    signal IntDatDD1_p : std_logic := '0';
    
    signal IntDataOutA : std_logic_vector (31 downto 0) := (others => '0');
    signal IntDataOutB : std_logic_vector (31 downto 0) := (others => '0');
    signal IntDataOutC : std_logic_vector (31 downto 0) := (others => '0');
    signal IntDataOutD : std_logic_vector (31 downto 0) := (others => '0');

    signal clk_rst_cnt : std_logic_vector(5 downto 0) := B"11_1111";
    signal clk_rst_r   : std_logic := '1';
    signal clk_rst     : std_logic := '1';
    
    signal reset_cnt : std_logic_vector(5 downto 0) := B"11_1111";
    signal reset_r   : std_logic := '1';
    signal reset     : std_logic := '1';
    
    signal data_A_r : std_logic_vector(13 downto 0);
    signal data_B_r : std_logic_vector(13 downto 0);
    signal data_C_r : std_logic_vector(13 downto 0);
    signal data_D_r : std_logic_vector(13 downto 0);    
    signal data_test_r : std_logic_vector(13 downto 0) := (others => '0');   
    
-----------------------------------------------------------------------
begin
-----------------------------------------------------------------------
AdcClock_i : entity work.AdcClock           --adc_clock module
generic map(
    C_BufioLoc  => C_BufioLoc,
    C_BufrLoc   => C_BufrLoc,
    C_AdcBits   => 16,
    C_StatTaps  => C_DCLK_StatTaps)
port map (
    BitClk              => dclk_ib,             --in
    BitClkRst           => clk_rst,             --in
    BitClkEna           => clock_locked,        --in
    BitClkReSync        => '0',                 --in
    BitClk_MonClkOut    => clk_bufio,           --out
    BitClk_MonClkIn     => clk_bufio,           --in
    BitClk_RefClkOut    => clock_adc_s,         --out
    BitClk_RefClkIn     => clock_adc_s,         --in
    BitClkAlignWarn     => status_signals(2),   --out
    BitClkInvrtd        => open,                --out
    BitClkDone          => IntBitClkDone);      --out
-----------------------------------------------------------------------
AdcFrame_i : entity work.AdcFrame               --adc frame module
generic map(
    C_AdcBits    => 16,
    C_AdcWireInt => 2,
    C_FrmPattern => "0000000011110000" )
port map(
        FrmClk_n		=> fclk_n_b,              --in
        FrmClk_p		=> fclk_p_b,              --in
        FrmClkRst		=> reset,                 --in
        FrmClkEna		=> clock_locked,          --in
        FrmClk			=> clk_bufio,             --in
        FrmClkDiv		=> clock_adc_s,           --in
        FrmClkDone		=> IntBitClkDone,         --in
        FrmClkReSync	=> AdcReSync,             --in
    	FrmClkBitSlip_p	=> IntClkBitSlip_p,	      --out
        FrmClkBitSlip_n => IntClkBitSlip_n,       --out
        FrmClkSwapMux   => IntClkSwapMux,         --out
        FrmClkMsbRegEna => IntClkMsbRegEna,       --out
        FrmClkLsbRegEna => IntClkLsbRegEna,       --out
        FrmClkReSyncOut => IntFrmClkReSyncOut,    --out
        FrmClkDat       => AdcFrmDataOut,         --out
        FrmClkSyncWarn  => AdcFrmSyncWrn          --out
    );   
-----------------------------------------------------------
AdcData_A : entity work.AdcData             --adc data module, ch_A
generic map(
    C_AdcBits		  => 16,
    C_AdcBytOrBitMode => 1,
    C_AdcMsbOrLsbFst  => 1,
    C_AdcWireInt	  => 2)
port map(
    DatD0_n			=> IntDatDA0_n,               --in
    DatD0_p			=> IntDatDA0_p,               --in
    DatD1_n			=> IntDatDA1_n,               --in
    DatD1_p			=> IntDatDA1_p,               --in
    DatClk			=> clk_bufio,                 --in
    DatClkDiv		=> clock_adc_s,               --in
    DatRst			=> reset,                     --in
    DatEna			=> clock_locked,              --in
    DatDone			=> IntBitClkDone,             --in
    DatBitSlip_p	=> IntClkBitSlip_p,           --in
    DatBitSlip_n	=> IntClkBitSlip_n,           --in
    DatSwapMux		=> IntClkSwapMux,             --in
    DatMsbRegEna	=> IntClkMsbRegEna,           --in
    DatLsbRegEna	=> IntClkLsbRegEna,           --in
    DatReSync		=> IntFrmClkReSyncOut,        --in
    DatOut			=> IntDataOutA);              --out
-----------------------------------------------------------------------
AdcData_B : entity work.AdcData                 --adc data module, ch_B
generic map(
    C_AdcBits		  => 16,
    C_AdcBytOrBitMode => 1,
    C_AdcMsbOrLsbFst  => 1,
    C_AdcWireInt	  => 2)
port map(
    DatD0_n			=> IntDatDB0_n,               --in
    DatD0_p			=> IntDatDB0_p,               --in
    DatD1_n			=> IntDatDB1_n,               --in
    DatD1_p			=> IntDatDB1_p,               --in
    DatClk			=> clk_bufio,                 --in
    DatClkDiv		=> clock_adc_s,               --in
    DatRst			=> reset,                     --in
    DatEna			=> clock_locked,              --in
    DatDone			=> IntBitClkDone,             --in
    DatBitSlip_p	=> IntClkBitSlip_p,           --in
    DatBitSlip_n	=> IntClkBitSlip_n,           --in
    DatSwapMux		=> IntClkSwapMux,             --in
    DatMsbRegEna	=> IntClkMsbRegEna,           --in
    DatLsbRegEna	=> IntClkLsbRegEna,           --in
    DatReSync		=> IntFrmClkReSyncOut,        --in
    DatOut			=> IntDataOutB);              --out
-----------------------------------------------------------------------   
AdcData_C : entity work.AdcData                 --adc data module, ch_C
generic map(
    C_AdcBits         => 16,
    C_AdcBytOrBitMode => 1,
    C_AdcMsbOrLsbFst  => 1,
    C_AdcWireInt      => 2)
port map(
    DatD0_n         => IntDatDC0_n,                 --in
    DatD0_p         => IntDatDC0_p,                 --in
    DatD1_n         => IntDatDC1_n,                 --in
    DatD1_p         => IntDatDC1_p,                 --in
    DatClk          => clk_bufio,                   --in
    DatClkDiv       => clock_adc_s,                 --in
    DatRst          => reset,                       --in
    DatEna          => clock_locked,                --in
    DatDone         => IntBitClkDone,               --in
    DatBitSlip_p    => IntClkBitSlip_p,             --in
    DatBitSlip_n    => IntClkBitSlip_n,             --in
    DatSwapMux      => IntClkSwapMux,               --in
    DatMsbRegEna    => IntClkMsbRegEna,             --in
    DatLsbRegEna    => IntClkLsbRegEna,             --in
    DatReSync       => IntFrmClkReSyncOut,          --in
    DatOut          => IntDataOutC);                --out
-----------------------------------------------------------------------        
AdcData_D : entity work.AdcData                     --adc data module, ch_D
generic map(
    C_AdcBits         => 16,
    C_AdcBytOrBitMode => 1,
    C_AdcMsbOrLsbFst  => 1,
    C_AdcWireInt      => 2)
port map(
    DatD0_n         => IntDatDD0_n,                 --in
    DatD0_p         => IntDatDD0_p,                 --in            
    DatD1_n         => IntDatDD1_n,                 --in
    DatD1_p         => IntDatDD1_p,                 --in
    DatClk          => clk_bufio,                   --in
    DatClkDiv       => clock_adc_s,                 --in
    DatRst          => reset,                       --in
    DatEna          => clock_locked,                --in
    DatDone         => IntBitClkDone,               --in
    DatBitSlip_p    => IntClkBitSlip_p,             --in
    DatBitSlip_n    => IntClkBitSlip_n,             --in
    DatSwapMux      => IntClkSwapMux,               --in
    DatMsbRegEna    => IntClkMsbRegEna,             --in
    DatLsbRegEna    => IntClkLsbRegEna,             --in
    DatReSync       => IntFrmClkReSyncOut,          --in
    DatOut          => IntDataOutD);                --out
-----------------------------------------------------------------------
da0_ibufds : IBUFDS_DIFF_OUT
    generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
    port map (I => D0PA, IB => D0NA, O => IntDatDA0_p, OB => IntDatDA0_n);
    
da1_ibufds : IBUFDS_DIFF_OUT
        generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
        port map (I => D1PA, IB => D1NA, O => IntDatDA1_p, OB => IntDatDA1_n);

db0_ibufds : IBUFDS_DIFF_OUT
    generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
    port map (I => D0PB, IB => D0NB, O => IntDatDB0_p, OB => IntDatDB0_n);
    
db1_ibufds : IBUFDS_DIFF_OUT
        generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)                        --convert data inputs to data signals
        port map (I => D1PB, IB => D1NB, O => IntDatDB1_p, OB => IntDatDB1_n);

dc0_ibufds : IBUFDS_DIFF_OUT
    generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
    port map (I => D0PC, IB => D0NC, O => IntDatDC0_p, OB => IntDatDC0_n);

dc1_ibufds : IBUFDS_DIFF_OUT
    generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
    port map (I => D1PC, IB => D1NC, O => IntDatDC1_p, OB => IntDatDC1_n);

dd0_ibufds : IBUFDS_DIFF_OUT
    generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
    port map (I => D0PD, IB => D0ND, O => IntDatDD0_p, OB => IntDatDD0_n);

dd1_ibufds : IBUFDS_DIFF_OUT
    generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)
    port map (I => D1PD, IB => D1ND, O => IntDatDD1_p, OB => IntDatDD1_n);
---------------------------------------------------------------------
fclk_ibufds : IBUFDS_DIFF_OUT
generic map(
    IOSTANDARD => "LVDS_25", 
    DIFF_TERM => TRUE)                          -- convert frame clock inputs to signals
port map (
    I  => FC0P, 
    IB => FC0N, 
    O  => fclk_p_b, 
    OB => fclk_n_b);
---------------------------------------------------------------------
dclk_ibufgds : IBUFGDS
generic map(
	DIFF_TERM => TRUE)
port map(                                       --convert differential data clock inputs to signal
	O  => dclk_ib,
	I  => DC0P,
	IB => DC0N);
---------------------------------------------------------------------
process(clock, clock_locked)
begin
    if clock_locked='0' then 
      clk_rst_cnt <= (others=>'1');
      clk_rst_r <= '1';
    elsif clock'event and clock='1' then            --reset clock module counter
        clk_rst_r <= '0';
        if clk_rst_cnt /= 0 then
            clk_rst_r <= '1';
            clk_rst_cnt <= clk_rst_cnt - '1';
        end if;
    end if;
end process;
----------------------------------------------------------------------
process(clock, IntBitClkDone)
begin
    if IntBitClkDone='0' then 
      reset_cnt <= (others=>'1');
      reset_r <= '1';
    elsif clock'event and clock='1' then            --reset frame and data modules counter
        reset_r <= '0';
        if reset_cnt /= 0 then
            reset_r <= '1';
            reset_cnt <= reset_cnt - '1';
        end if;
    end if;
end process;

process(clock)
begin
    if clock'event and clock='1' then 
        data_test_r <= data_test_r + 1;
    end if;
end process;

---------------------------------------------------------------------
process(clock_adc_s) --process to chang signals sequence
begin
    if clock_adc_s'event and clock_adc_s='1' then
        
        data_A_r <= IntDataOutA(2 downto 2) & IntDataOutA(3 downto 3)  & IntDataOutA(0 downto 0)  & IntDataOutA(1 downto 1)
          & IntDataOutA(6 downto 6)  & IntDataOutA(7 downto 7)  & IntDataOutA(4 downto 4)  & IntDataOutA(5 downto 5)
          & IntDataOutA(10 downto 10)  & IntDataOutA(11 downto 11)  & IntDataOutA(8 downto 8)  & IntDataOutA(9 downto 9)
          & IntDataOutA(14 downto 14)  & IntDataOutA(15 downto 15);
        data_B_r <= IntDataOutB(2 downto 2) & IntDataOutB(3 downto 3)  & IntDataOutB(0 downto 0)  & IntDataOutB(1 downto 1)
          & IntDataOutB(6 downto 6)  & IntDataOutB(7 downto 7)  & IntDataOutB(4 downto 4)  & IntDataOutB(5 downto 5)
          & IntDataOutB(10 downto 10)  & IntDataOutB(11 downto 11)  & IntDataOutB(8 downto 8)  & IntDataOutB(9 downto 9)
          & IntDataOutB(14 downto 14)  & IntDataOutB(15 downto 15); 
        data_C_r <= IntDataOutC(2 downto 2) & IntDataOutC(3 downto 3)  & IntDataOutC(0 downto 0)  & IntDataOutC(1 downto 1)
          & IntDataOutC(6 downto 6)  & IntDataOutC(7 downto 7)  & IntDataOutC(4 downto 4)  & IntDataOutC(5 downto 5)
          & IntDataOutC(10 downto 10)  & IntDataOutC(11 downto 11)  & IntDataOutC(8 downto 8)  & IntDataOutC(9 downto 9)
          & IntDataOutC(14 downto 14)  & IntDataOutC(15 downto 15);
        data_D_r <= IntDataOutD(2 downto 2) & IntDataOutD(3 downto 3)  & IntDataOutD(0 downto 0)  & IntDataOutD(1 downto 1)
          & IntDataOutD(6 downto 6)  & IntDataOutD(7 downto 7)  & IntDataOutD(4 downto 4)  & IntDataOutD(5 downto 5)
          & IntDataOutD(10 downto 10)  & IntDataOutD(11 downto 11)  & IntDataOutD(8 downto 8)  & IntDataOutD(9 downto 9)
          & IntDataOutD(14 downto 14)  & IntDataOutD(15 downto 15); 
    end if;
end process;
----------------------------------------------------------------------
data_A <= IntDatDA0_p & IntDatDA0_n & IntDatDA1_p & IntDatDA1_n & IntDatDB0_p & IntDatDB0_n & IntDatDB1_p & IntDatDB1_n &
         IntDatDD0_p & IntDatDD0_n & IntDatDD1_p & IntDatDD1_n & B"00";--data_A_r;             --out
data_B <= data_B_r;             --out
data_C <= data_test_r;           --out
data_D <= data_test_r;             --out

clk_rst <= AdcDeserReset;       --in
reset <= reset_r;               --in

status_signals(0) <= IntBitClkDone;    --out
status_signals(3) <= IntClkSwapMux;    --out
status_signals(1) <= '0';

--data_test <= data_test_r;
----------------------------------------------------------------------

end behavioral;




