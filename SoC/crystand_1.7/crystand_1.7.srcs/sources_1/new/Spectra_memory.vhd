library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.new_types.all;

entity Spectra_memory is
Port (
    clka    : in std_logic;
    clkb    : in std_logic;
    rst     : in std_logic_vector(11 downto 0);
    addra   : in spectra_addr_t;
    PS_addr : in std_logic_vector(15 downto 0);
    dina    : in spectra_data_t;
    wea     : in std_logic_vector(11 downto 0);
    ena     : in std_logic_vector(11 downto 0);
    --enb   : in std_logic_vector(11 downto 0);
    douta   : out spectra_data_t;
    PS_data : out std_logic_vector(31 downto 0)
);

end Spectra_memory;

architecture Behavioral of Spectra_memory is

    signal addrb : std_logic_vector(11 downto 0) := (others => '0');
    signal enb   : std_logic_vector(11 downto 0) := (others => '0');
    signal doutb : spectra_data_t := (others => (others => '0'));
    
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
begin

    spectra_mem: for i in 0 to 11 generate spectrum_RAM_ii: entity work.mem_rst
        generic map(
            RAM_WIDTH => 32,
            RAM_DEPTH => 4096
            )
        port map(
            clka  => clka,
            clkb  => clkb,
            rst   => rst  (i),
            addra => addra(i),
            addrb => addrb,
            dina  => dina (i),
            wea   => wea  (i),
            ena   => ena  (i),
            enb   => enb  (i),
            douta => douta(i),
            doutb => doutb(i)
        );
    end generate spectra_mem;
                       
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


with enb select
    PS_data <= doutb(0)  when B"000000000001",
               doutb(1)  when B"000000000010",
               doutb(2)  when B"000000000100",
               doutb(3)  when B"000000001000",
               doutb(4)  when B"000000010000",
               doutb(5)  when B"000000100000",
               doutb(6)  when B"000001000000",
               doutb(7)  when B"000010000000",
               doutb(8)  when B"000100000000",
               doutb(9)  when B"001000000000",
               doutb(10) when B"010000000000",
               doutb(11) when B"100000000000",
               (others => '1') when others;

addrb <= PS_addr(11 downto 0);

end Behavioral;