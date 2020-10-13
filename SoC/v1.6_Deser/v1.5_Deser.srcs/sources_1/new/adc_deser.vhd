
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;


library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.all;
use work.new_types.all;
-----------------------------------------------------------------------
entity adc_deser is
generic(
    C_DCLK_StatTaps  : integer := 16;
    C_BufioLoc       : string := "BUFIO_X0Y17"; -- IO-bank 16
    C_BufrLoc        : string := "BUFR_X0Y17";
    
    C_AdcBits         : integer := 16;                  --ADC data bits
    C_AdcWireInt      : integer := 2;                   --ADC: 2 - 2-wire mode; 1 - 1-wire mode 
    C_FrmPattern      : string := "0000000011110000";   --ADC frame pattern (info - AdcFrame module)
    C_AdcBytOrBitMode : integer := 0;                   --ADC: 0 - byte mode; 1 - bit mode (data Sheet ad9253)
    C_AdcMsbOrLsbFst  : integer := 0);                  --ADC: 0 - Msb (most significant bit) mode; 1 - Lsb (least significant bit) mode
port( 
    clock            : in std_logic;            --pl_top system clock
           
--    idelayctrl_ready : in std_logic;          --doesn't require

    clock_locked     : in std_logic;            -- '1' - unlocked; '0' - locked
      
    AdcDeserReset    : in std_logic;            --deser system reset
    AdcReSync        : in std_logic;            --deser system resync
      
    data_A : out std_logic_vector(15 downto 0); --channel A data output 
    data_B : out std_logic_vector(15 downto 0); --channel B data output
    data_C : out std_logic_vector(15 downto 0); --channel C data output
    data_D : out std_logic_vector(15 downto 0); --channel D data output
    
    status_signals     : out std_logic_vector(3 downto 0);
    
    clk_out :  out std_logic;                   --deser system clock (formed by AdcClock module) to process input data 
                                               
    --ADC PINS:
        --CHANNEL A
    D0PA : in std_logic;
    D0NA : in std_logic;
    D1PA : in std_logic;
    D1NA : in std_logic;
        --CHANNEL B      
    D0PB : in std_logic;
    D0NB : in std_logic;       
    D1PB : in std_logic;
    D1NB : in std_logic;
        --CHANNEL C           
    D0PC : in std_logic;
    D0NC : in std_logic;       
    D1PC : in std_logic;
    D1NC : in std_logic;
        --CHANNEL D
    D0PD : in std_logic;
    D0ND : in std_logic; 
    D1PD : in std_logic;
    D1ND : in std_logic;
        --Frame clock
    FC0P : in std_logic;
    FC0N : in std_logic;
        --Data clock          
    DC0P : in std_logic;
    DC0N : in std_logic
    --END ADC PINS
    );

end adc_deser;
-----------------------------------------------------------------------
architecture Behavioral of adc_deser is
-----------------------------------------------------------------------
    constant Low  : std_logic	:= '0';
    constant High : std_logic	:= '1';
    
	signal DCLK_p : std_logic := '0';

    signal IntClk    : std_logic := '0';
    signal IntClkDiv  : std_logic := '0';
    
    signal IntBitClkDone : std_logic := '0';

    signal FCLK_p : std_logic := '0';
    signal FCLK_n : std_logic := '0';
    
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

    signal clk_rst     : std_logic := '1';
    
    signal reset     : std_logic := '1';
    
    signal data_A_r : std_logic_vector(15 downto 0);
    signal data_B_r : std_logic_vector(15 downto 0);
    signal data_C_r : std_logic_vector(15 downto 0);
    signal data_D_r : std_logic_vector(15 downto 0);
    
    signal data_valid_cnt : std_logic_vector(5 downto 0) := (others=>'1');
    signal data_valid_r   : std_logic := '0';
    
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
-----------------------------------------------------------------------
begin
-----------------------------------------------------------------------
AdcClock_i : entity work.AdcClock           --adc_clock module
generic map(
    C_BufioLoc  => C_BufioLoc,
    C_BufrLoc   => C_BufrLoc,
    C_AdcBits   => C_AdcBits,                   --16 bits            
    C_StatTaps  => C_DCLK_StatTaps)
port map (
    BitClk              => dclk_p,              --in
    BitClkRst           => clk_rst,             --in
    BitClkEna           => clock_locked,        --in
    BitClkReSync        => AdcReSync,           --in
    BitClk_MonClkOut    => IntClk,              --out
    BitClk_MonClkIn     => IntClk,              --in
    BitClk_RefClkOut    => IntClkDiv,           --out
    BitClk_RefClkIn     => IntClkDiv,           --in
    BitClkAlignWarn     => status_signals(2),   --out
    BitClkInvrtd        => open,                --out
    BitClkDone          => IntBitClkDone);      --out
-----------------------------------------------------------------------
AdcFrame_i : entity work.AdcFrame               --adc frame module
generic map(
    C_AdcBits    => C_AdcBits,                    --16 bits 
    C_AdcWireInt => C_AdcWireInt,                 --2-wire mode
    C_FrmPattern => C_FrmPattern )                --'11110000' - frame pattern
port map(
        FrmClk_n		=> FCLK_n,                --in
        FrmClk_p		=> FCLK_p,                --in
        FrmClkRst		=> reset,                 --in
        FrmClkEna		=> clock_locked,          --in
        FrmClk			=> IntClk,                --in
        FrmClkDiv		=> IntClkDiv,             --in
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
    C_AdcBits		  => C_AdcBits,              --16 bits
    C_AdcBytOrBitMode => C_AdcBytOrBitMode,      --Byte mode
    C_AdcMsbOrLsbFst  => C_AdcMsbOrLsbFst,       --MsbFst mode
    C_AdcWireInt	  => C_AdcWireInt)           --2-wire mode
port map(
    DatD0_n			=> IntDatDA0_n,               --in
    DatD0_p			=> IntDatDA0_p,               --in
    DatD1_n			=> IntDatDA1_n,               --in
    DatD1_p			=> IntDatDA1_p,               --in
    DatClk			=> IntClk,                    --in
    DatClkDiv		=> IntClkDiv,                 --in
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
    C_AdcBits		  => C_AdcBits,               --16 bits
    C_AdcBytOrBitMode => C_AdcBytOrBitMode,       --Byte mode
    C_AdcMsbOrLsbFst  => C_AdcMsbOrLsbFst,        --MsbFst mode
    C_AdcWireInt      => C_AdcWireInt)            --2-wire mode
port map(
    DatD0_n			=> IntDatDB0_n,               --in
    DatD0_p			=> IntDatDB0_p,               --in
    DatD1_n			=> IntDatDB1_n,               --in
    DatD1_p			=> IntDatDB1_p,               --in
    DatClk			=> IntClk,                    --in
    DatClkDiv		=> IntClkDiv,                 --in
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
    C_AdcBits		  => C_AdcBits,                 --16 bits
    C_AdcBytOrBitMode => C_AdcBytOrBitMode,         --Byte mode
    C_AdcMsbOrLsbFst  => C_AdcMsbOrLsbFst,          --MsbFst mode
    C_AdcWireInt      => C_AdcWireInt)              --2-wire mode
port map(
    DatD0_n         => IntDatDC0_n,                 --in
    DatD0_p         => IntDatDC0_p,                 --in
    DatD1_n         => IntDatDC1_n,                 --in
    DatD1_p         => IntDatDC1_p,                 --in
    DatClk          => IntClk,                      --in
    DatClkDiv       => IntClkDiv,                   --in
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
    C_AdcBits		  => C_AdcBits,                 --16 bits
    C_AdcBytOrBitMode => C_AdcBytOrBitMode,         --Byte mode
    C_AdcMsbOrLsbFst  => C_AdcMsbOrLsbFst,          --MsbFst mode
    C_AdcWireInt      => C_AdcWireInt)              --2-wire mode
port map(
    DatD0_n         => IntDatDD0_n,                 --in
    DatD0_p         => IntDatDD0_p,                 --in            
    DatD1_n         => IntDatDD1_n,                 --in
    DatD1_p         => IntDatDD1_p,                 --in
    DatClk          => IntClk,                      --in
    DatClkDiv       => IntClkDiv,                   --in
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

--ADC differential data inputs

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
        generic map (IOSTANDARD => "LVDS_25", DIFF_TERM => TRUE)                        
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
    DIFF_TERM => TRUE)                          --ADC differential frame clock inputs
port map (
    I  => FC0P, 
    IB => FC0N, 
    O  => FCLK_p, 
    OB => FCLK_n);
---------------------------------------------------------------------
dclk_ibufgds : IBUFGDS
generic map(
    IOSTANDARD => "LVDS_25", 
	DIFF_TERM => TRUE)
port map(                                       --ADC differential data clock inputs
	O  => DCLK_p,
	I  => DC0P,
	IB => DC0N);
---------------------------------------------------------------------

---------------------------------------------------------------------
process(IntClkDiv)  --process to restore deserialized data
begin
    if IntClkDiv'event and IntClkDiv='1' then
        
        if IntClkMsbRegEna='1' then                                     --if data bits are deserialized
                                                                        --put them in right order
            data_A_r <= IntDataOutA(1) & IntDataOutA(0) & IntDataOutA(14) & IntDataOutA(15) & IntDataOutA(12) & IntDataOutA(13) & IntDataOutA(10) & IntDataOutA(11) 
                      & IntDataOutA(8) & IntDataOutA(9) & IntDataOutA(6) & IntDataOutA(7) & IntDataOutA(4) & IntDataOutA(5) & IntDataOutA(2) & IntDataOutA(3);
            data_B_r <= IntDataOutB(1) & IntDataOutB(0) & IntDataOutB(14) & IntDataOutB(15) & IntDataOutB(12) & IntDataOutB(13) & IntDataOutB(10) & IntDataOutB(11) 
                      & IntDataOutB(8) & IntDataOutB(9) & IntDataOutB(6) & IntDataOutB(7) & IntDataOutB(4) & IntDataOutB(5) & IntDataOutB(2) & IntDataOutB(3);
            data_C_r <= IntDataOutC(1) & IntDataOutC(0) & IntDataOutC(14) & IntDataOutC(15) & IntDataOutC(12) & IntDataOutC(13) & IntDataOutC(10) & IntDataOutC(11) 
                      & IntDataOutC(8) & IntDataOutC(9) & IntDataOutC(6) & IntDataOutC(7) & IntDataOutC(4) & IntDataOutC(5) & IntDataOutC(2) & IntDataOutC(3);
            data_D_r <= IntDataOutD(1) & IntDataOutD(0) & IntDataOutD(14) & IntDataOutD(15) & IntDataOutD(12) & IntDataOutD(13) & IntDataOutD(10) & IntDataOutD(11) 
                      & IntDataOutD(8) & IntDataOutD(9) & IntDataOutD(6) & IntDataOutD(7) & IntDataOutD(4) & IntDataOutD(5) & IntDataOutD(2) & IntDataOutD(3);
        end if;
                
        if AdcFrmDataOut(15 downto 0) /= X"F0F0" or IntBitClkDone='0' then  --operator(which is worked with signals) to identify and block wrong data
            data_valid_cnt <= (others=>'1');
            data_valid_r <= '0';
        end if;
        
        if data_valid_cnt /= 0 then                                    --counter(time) to block wrong data
            data_valid_cnt <= data_valid_cnt - '1';
        end if;
                
        data_valid_r <= '0';                                           --signal to identify data validity
        if data_valid_cnt = 0 then
            data_valid_r <= '1';
        end if;
   
    end if;
end process;
----------------------------------------------------------------------
data_A <= data_A_r;             --out
data_B <= data_B_r;             --out
data_C <= data_C_r;             --out
data_D <= data_D_r;             --out

clk_rst <= AdcDeserReset;       --in
reset <= clk_rst;
clk_out <= IntClkDiv;           --out

status_signals(0) <= IntBitClkDone;    --out
status_signals(3) <= IntClkSwapMux;    --out
status_signals(1) <= '0';              --out
----------------------------------------------------------------------

end behavioral;
