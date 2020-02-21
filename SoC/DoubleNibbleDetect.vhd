library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_UNSIGNED.all;
library UNISIM;
	use UNISIM.vcomponents.all;
---------------------------------------------------------------------------------------------
-- Entity pin description
---------------------------------------------------------------------------------------------
-- Clock    : Clock for the design.
-- RstIn    : Reset input. Resets the necessary logic at startup.
-- Final    : This circuit checks a nibble (4-bit) for appearing twice, when for rotations or
--            slips are made, the fifth resets the circuit. this is signalled outside
--            so that a upper layer of design can take action.
-- DataIn   : Nibble input.
-- DataOut  : Corrected nibble output.
---------------------------------------------------------------------------------------------
entity DoubleNibbleDetect is
    generic (
        C_AdcBits : integer -- 16 or 12, 16 includes 14 bits
    );
	port (
        Clock   : in std_logic;
        RstIn   : in std_logic;
        Final   : out std_logic;
        DataIn  : in std_logic_vector((C_AdcBits/4)-1 downto 0);
        DataOut : out std_logic_vector((C_AdcBits/4)-1 downto 0)
	);
end DoubleNibbleDetect;

architecture DoubleNibbleDetect_struct of DoubleNibbleDetect is

	function FrmBits (Bits : integer) return integer is
	variable Temp : integer;
	begin
		if (Bits = 12) then
			Temp := 12;
		elsif (Bits = 14) then
			Temp := 16;
		elsif (Bits = 16) then
			Temp := 16;
		end if;
	return Temp;
	end function FrmBits;
	
constant Low  : std_logic	:= '0';
constant High : std_logic	:= '1';

signal IntRegOutIn      : std_logic_vector(((FrmBits(C_AdcBits)/4)-1) downto 0);
signal IntAddr          : std_logic_vector(4 downto 0);
signal IntSrlOut        : std_logic_vector(((FrmBits(C_AdcBits)/4)-1) downto 0);
--
signal IntRegOutIn_s    : std_logic_vector(((FrmBits(C_AdcBits)/4)-1) downto 0);
signal IntAddr_s        : std_logic_vector(4 downto 0);
signal IntSrlOut_s      : std_logic_vector(((FrmBits(C_AdcBits)/4)-1) downto 0);
signal DataOut_s        : std_logic_vector(((FrmBits(C_AdcBits)/4)-1) downto 0);
--
signal IntEqu           : std_logic;
signal IntEqu_d         : std_logic;
signal IntPulse         : std_logic;
signal IntSlipCnt       : std_logic_vector(3 downto 0);
signal IntSlipCnt_d     : std_logic_vector(3 downto 0);
signal IntSlipCntRst    : std_logic;
signal IntEquCnt        : std_logic_vector(3 downto 0);
signal IntEquCnt_d      : std_logic_vector(3 downto 0);
--
signal IntRstSet        : std_logic;
signal IntRstIn         : std_logic;
signal IntRstFf_d       : std_logic_vector(7 downto 0) := X"00";
signal IntRstIn_d       : std_logic;
--
signal IntAddrSet       : std_logic_vector(3 downto 0);
-- Attributes
attribute IOB : string;
attribute HBLKNM : string;
---------------------------------------------------------------------------------------------
begin
---------------------------------------------------------------------------------------------
-- Delay the start of the circuit after reset.
---------------------------------------------------------------------------------------------
IntRstIn <= RstIn or IntRstSet;
--
Gen_Rst : for n in 0 to 7 generate
    Reg_Lsb : if n = 0 generate
        DbleNibl_I_Fdse : FDSE -- Synchronous set
        generic map (INIT => '0')
        port map (D => Low, CE => High, C => Clock, S => IntRstSet, Q => IntRstFf_d(n));
    end generate Reg_Lsb;
    Reg_MidL : if n > 0 and n <= 5 generate
        DbleNibl_I_Fdse : FDSE -- Synchronous set
        generic map (INIT => '0')
        port map (D => IntRstFf_d(n-1), CE => High, C => Clock, S => IntRstSet,
                  Q => IntRstFf_d(n));
    end generate Reg_MidL;
    Reg_MidH : if n = 6 generate
        DbleNibl_I_Fdse : FDSE -- Synchronous set
        generic map (INIT => '0')
        port map (D => IntRstFf_d(n-1), CE => High, C => Clock, S => IntRstIn,
                  Q => IntRstFf_d(n));
    end generate Reg_MidH;
    Reg_Msb : if n = 7 generate
        DbleNibl_I_Fdse : FDSE -- Synchronous set
        generic map (INIT => '0')
        port map (D => IntRstFf_d(n-1), CE => High, C => Clock, S => IntRstIn,
                  Q => IntRstFf_d(n));
        --
        IntRstIn_d <= IntRstFf_d(n);
    end generate Reg_Msb;
end generate Gen_Rst;
---------------------------------------------------------------------------------------------
-- Data path registers
---------------------------------------------------------------------------------------------
Gen_Reg : for n in ((C_AdcBits)/4)-1 downto 0 generate
    In_I_Fdce : FDCE
        generic map (INIT => '0')
        port map (D => DataIn(n), CE => High, C => Clock, CLR => IntRstIn_d,
                  Q => IntRegOutIn_s(n));
IntRegOutIn(n) <= IntRegOutIn_s(n); -- after 100 ps;
    DbleNibl_I_Srlc32e : SRLC32E
        generic map (INIT => X"00000000")
        port map (D => IntRegOutIn(n), A => IntAddr, CE => High, CLK => Clock, Q31 => open,
                  Q => IntSrlOut_s(n));
IntSrlOut(n) <= IntSrlOut_s(n);  -- after 100 ps;
    Out_I_Fdce : FDCE
        generic map (INIT => '0')
        port map (D => IntSrlOut(n), CE => High, C => Clock, CLR => IntRstIn_d,
                  Q => DataOut_s(n));
DataOut(n) <= DataOut_s(n);  -- after 100 ps;
end generate Gen_Reg;
---------------------------------------------------------------------------------------------
-- Compare present and past for equality.
---------------------------------------------------------------------------------------------
IntEqu <= '1' when (DataIn = IntRegOutIn) else '0';
-----------------------------------------------------------------------------------------------
-- Generate the SRL addresses
---------------------------------------------------------------------------------------------
IntAddr(3 downto 0) <= "0100" when (IntEquCnt_d = "0000" and IntSlipCnt_d = "0000") else
                       "0011" when (IntEquCnt_d = "0001" and IntSlipCnt_d = "0111") else
                       "0010" when (IntEquCnt_d = "0011" and IntSlipCnt_d = "0110") else
                       "0001" when (IntEquCnt_d = "0010" and IntSlipCnt_d = "0010") else
                       "0000" when (IntEquCnt_d = "0110" and IntSlipCnt_d = "0011") else
                       "0100" when (IntEquCnt_d = "0111" and IntSlipCnt_d = "0001");
IntAddr(4) <= Low;
--IntRstSet <= '1' when (IntEquCnt_d = "0111" and IntSlipCnt_d = "0001") else '0';
IntRstSet <= '1' when (IntEquCnt_d = "0110" and IntSlipCnt_d = "0000" and IntPulse = '1')
                 else '0';
Final <= IntRstSet;
---------------------------------------------------------------------------------------------
-- Equal/Double nibble detect counters
---------------------------------------------------------------------------------------------
IntPulse <= IntEqu or IntEqu_d;
--
DbleNibl_I_Fdce : FDCE     -- Asynchronous reset
    generic map (INIT => '0')
    port map (D => High, CE => IntEqu, C => Clock, CLR => IntSlipCntRst, Q => IntEqu_d);
-- When a double nibble is detected shift the pulse over four taps and reset the shifter
-- at the fifth tap.
---------------------------------------------------------------------------------------------
-- Slip Counter
-- When equality is detected, this counter counts till a preset number and then resets.
---------------------------------------------------------------------------------------------
IntSlipCntRst <= '1' when (IntRstIn_d = '1' or IntSlipCnt_d = "0101") else '0';
--
Gen_SlipCnt : for n in 3 downto 0 generate
    attribute HBLKNM of Cnt_I_Fdre : label is "SlipCnt";
    attribute IOB of Cnt_I_Fdre : label is "FALSE";
    begin
    Cnt_I_Fdre : FDRE   -- Synchronous reset
        generic map (INIT => '0')
        port map (D => IntSlipCnt(n), CE => IntPulse, C => Clock, R => IntSlipCntRst,
                  Q => IntSlipCnt_d(n));
end generate Gen_SlipCnt;
-- These ar the "SlipCnt" states, organized in Gray mode
DbleNibl_SlipCnt_PROCESS : process (IntSlipCnt_d)
begin
    case IntSlipCnt_d(3 downto 0) is
        when "0000" => IntSlipCnt <= "0001";  -- after 100 ps;
        when "0001" => IntSlipCnt <= "0011";  -- after 100 ps;
        when "0011" => IntSlipCnt <= "0010";  -- after 100 ps;
        when "0010" => IntSlipCnt <= "0110";  -- after 100 ps;
        when "0110" => IntSlipCnt <= "0111";  -- after 100 ps;
        when "0111" => IntSlipCnt <= "0101";  -- after 100 ps;
        when others => IntSlipCnt <= "0000";  -- after 100 ps;
    end case;
end process;
---------------------------------------------------------------------------------------------
-- Equ Counter
-- Count how many times a double nibble is detected.
-- becuase a nibble of data is taken, it can only be four times.
-- When equality is detected for the fift time the system is reset.
---------------------------------------------------------------------------------------------
Gen_EquCnt : for n in 3 downto 0 generate
    attribute HBLKNM of Equ_I_Fdre : label is "EquCnt";
    attribute IOB of Equ_I_Fdre : label is "FALSE";
    begin
    Equ_I_Fdre : FDRE   -- Synchronous reset
        generic map (INIT => '0')
        port map (D => IntEquCnt(n), CE => IntEqu, C => Clock, R => IntRstIn_d,
                  Q => IntEquCnt_d(n));
end generate Gen_EquCnt;
--
DbleNibl_EquCnt_PROCESS : process (IntEquCnt_d)
begin
    case IntEquCnt_d(3 downto 0) is
        when "0000" => IntEquCnt <= "0001";  -- after 100 ps;
        when "0001" => IntEquCnt <= "0011";  -- after 100 ps;
        when "0011" => IntEquCnt <= "0010";  -- after 100 ps;
        when "0010" => IntEquCnt <= "0110";  -- after 100 ps;
        when "0110" => IntEquCnt <= "0111";  -- after 100 ps;
        when "0111" => IntEquCnt <= "0101";  -- after 100 ps;
        when "0101" => IntEquCnt <= "0100";  -- after 100 ps;
        when "0100" => IntEquCnt <= "1100";  -- after 100 ps;
        when "1100" => IntEquCnt <= "1101";  -- after 100 ps;
        when "1101" => IntEquCnt <= "1111";  -- after 100 ps;
        when "1111" => IntEquCnt <= "1110";  -- after 100 ps;
        when "1110" => IntEquCnt <= "1010";  -- after 100 ps;
        when "1010" => IntEquCnt <= "1011";  -- after 100 ps;
        when "1011" => IntEquCnt <= "1001";  -- after 100 ps;
        when "1001" => IntEquCnt <= "1000";  -- after 100 ps;
        when others => IntEquCnt <= "0000";  -- after 100 ps;
    end case;
end process;
---------------------------------------------------------------------------------------------
end DoubleNibbleDetect_struct;
--
