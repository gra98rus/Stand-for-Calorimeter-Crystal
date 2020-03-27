library ieee;
use ieee.std_logic_1164.all;

package reg_map is

	constant REG_NUM_ECHO : std_logic_vector(15 downto 0) := X"0000";
	constant REG_COMMAND : std_logic_vector(15 downto 0)  := X"0001";
	constant REG_STATUS : std_logic_vector(15 downto 0)   := X"0010";
    constant REG_START_EVENT : std_logic_vector(15 downto 0)  := X"0011";
    constant REG_TRIGGER_TYPE : std_logic_vector(15 downto 0) := X"0100";
    constant REG_TRIGGER_LEVEL : std_logic_vector(15 downto 0) := X"0101";
    constant REG_SELECTED_CHANNELS : std_logic_vector(15 downto 0) := X"0110";

end reg_map;

package body reg_map is
end reg_map;
