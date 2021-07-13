library ieee;
use ieee.std_logic_1164.all;

package reg_map is

	constant REG_NUM_ECHO           : std_logic_vector(15 downto 0)  := X"0000";
	constant REG_COMMAND            : std_logic_vector(15 downto 0)  := X"0001";
	constant REG_STATUS             : std_logic_vector(15 downto 0)  := X"0010";
    constant REG_START_EVENT        : std_logic_vector(15 downto 0)  := X"0011";
    constant REG_TRIGGER_TYPE       : std_logic_vector(15 downto 0)  := X"0100";
    constant REG_TRIGGER_LEVEL      : std_logic_vector(15 downto 0)  := X"0101";
    constant REG_SELECTED_CHANNELS  : std_logic_vector(15 downto 0)  := X"0110";
    constant REG_BASKET_NUM         : std_logic_vector(15 downto 0)  := X"0111";
    constant REG_SHAPER             : std_logic_vector(15 downto 0)  := X"1000";
    constant REG_SPECTRUM_SPEC      : std_logic_vector(15 downto 0)  := X"1001";
    constant REG_AMPLIFIERS         : std_logic_vector(15 downto 0)  := X"1010";
    constant REG_SPI_DATA           : std_logic_vector(15 downto 0)  := X"1011";
    constant REG_SPI_VALID_BYTES    : std_logic_vector(15 downto 0)  := X"1100";
    constant REG_SPI_START          : std_logic_vector(15 downto 0)  := X"1101";
    constant REG_DESER_RESYNC       : std_logic_vector(15 downto 0)  := X"1110";
    constant REG_DESER_RESET        : std_logic_vector(15 downto 0)  := X"1111";

end reg_map;

package body reg_map is
end reg_map;
