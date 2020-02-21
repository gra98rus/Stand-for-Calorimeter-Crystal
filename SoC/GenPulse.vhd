library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_UNSIGNED.all;
library work;
    use work.all;
    
entity GenPulse is
    port (
        Clk		: in std_logic;
        Ena		: in std_logic;
        SigIn	: in std_logic;
        SigOut	: out std_logic
    );
end GenPulse;

architecture GenPulse_struct of GenPulse  is
constant Low  : std_logic	:= '0';
constant High : std_logic	:= '1';

signal IntSigClr    : std_logic;

attribute KEEP_HIERARCHY : string;
    attribute KEEP_HIERARCHY of GenPulse_struct : architecture is "NO";
-----------------------------------------------------------------------------------------------
begin
--
GenPulse_I_Fdcr_1 : entity work.Fdcr
    generic map (INIT => '0')
    port map (D => SigIn, CE => Ena, C => Clk, R => IntSigClr, Q => SigOut);
--
GenPulse_I_Fdcr_2 : entity work.Fdcr
    generic map (INIT => '0')
    port map (D => SigIn, CE => High, C => Clk, R => Low, Q => IntSigClr);
--
-----------------------------------------------------------------------------------------------
end  GenPulse_struct;