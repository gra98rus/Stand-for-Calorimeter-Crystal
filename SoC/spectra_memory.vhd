library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


use work.new_types.all;

entity spectra_memory is
Port (
    clka : in std_logic;
    clkb : in std_logic;
    addra : in spectra_addr;
    PS_addr : in std_logic_vector(15 downto 0);
    dina : in spectra_data;
    wea : in std_logic_vector(11 downto 0);
    ena : in std_logic_vector(11 downto 0);
    --enb : in std_logic_vector(11 downto 0);
    douta : out spectra_data;
    PS_data : out std_logic_vector(31 downto 0)
);

end spectra_memory;

architecture Behavioral of spectra_memory is

    signal addrb : std_logic_vector(11 downto 0) := (others => '0');
    signal enb   : std_logic_vector(11 downto 0) := (others => '0');
    signal doutb : spectra_data := (others => (others => '0'));

begin

    spectra_mem: for i in 0 to 11 generate spectrum_RAM_ii: entity work.spectrum_RAM
        port map(
            clka => clka,
            clkb => clkb,
            addra => addra(i),
            addrb => addrb,
            dina => dina(i),
            wea => wea(i),
            ena => ena(i),
            enb => enb(i)
        );
    end generate;

 --       addrb(to_integer(unsigned(PS_addr(15 downto 12)))) <= PS_addr(11 downto 0);
enb(0)  <= '1' when PS_addr(15 downto 12) = B"0000" else '0';
enb(1)  <= '1' when PS_addr(15 downto 12) = B"0001" else '0';
enb(2)  <= '1' when PS_addr(15 downto 12) = B"0010" else '0';
enb(3)  <= '1' when PS_addr(15 downto 12) = B"0011" else '0';
enb(4)  <= '1' when PS_addr(15 downto 12) = B"0100" else '0';
enb(5)  <= '1' when PS_addr(15 downto 12) = B"0101" else '0';
enb(6)  <= '1' when PS_addr(15 downto 12) = B"0110" else '0';
enb(7)  <= '1' when PS_addr(15 downto 12) = B"0111" else '0';
enb(8)  <= '1' when PS_addr(15 downto 12) = B"1000" else '0';
enb(9)  <= '1' when PS_addr(15 downto 12) = B"1001" else '0';
enb(10) <= '1' when PS_addr(15 downto 12) = B"1010" else '0';
enb(11) <= '1' when PS_addr(15 downto 12) = B"1011" else '0';

end Behavioral;
