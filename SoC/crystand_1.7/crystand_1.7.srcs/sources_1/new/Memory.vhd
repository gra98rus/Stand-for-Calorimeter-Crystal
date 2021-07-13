library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.new_types.all;
use work.func_pkg.all;

USE std.textio.all;

entity RAM is
generic (
    RAM_WIDTH  : integer := 32;
    RAM_DEPTH  : integer := 32;
    INIT_FILE  : string  := "RAM_INIT.dat"
);
Port (
    clka    : in  std_logic;
    clkb    : in  std_logic;
    addra   : in  std_logic_vector(clog2(RAM_DEPTH)-1 downto 0);
    addrb   : in  std_logic_vector(clog2(RAM_DEPTH)-1 downto 0);
    dina    : in  std_logic_vector(RAM_WIDTH-1 downto 0);
--    dinb    : in  std_logic_vector(RAM_WIDTH-1 downto 0);
    wea     : in  std_logic;
--    web     : in  std_logic;
    ena     : in  std_logic;
    enb     : in  std_logic;
    douta   : out std_logic_vector(RAM_WIDTH-1 downto 0);
    doutb   : out std_logic_vector(RAM_WIDTH-1 downto 0)
);

end RAM;

architecture Behavioral of RAM is

constant C_RAM_WIDTH : integer := RAM_WIDTH;
constant C_RAM_DEPTH : integer := RAM_DEPTH;
constant C_INIT_FILE : string  := INIT_FILE;

type ram_type is array (C_RAM_DEPTH-1 downto 0) of std_logic_vector (C_RAM_WIDTH-1 downto 0);      -- 2D Array Declaration for RAM signal
signal ram_data_a : std_logic_vector(C_RAM_WIDTH-1 downto 0) ;
signal ram_data_b : std_logic_vector(C_RAM_WIDTH-1 downto 0) ;

function initramfromfile (ramfilename : in string) return ram_type is
file ramfile	: text is in ramfilename;
variable ramfileline : line;
variable ram_name	: ram_type;
variable bitvec : bit_vector(C_RAM_WIDTH-1 downto 0);
begin
    for i in ram_type'range loop
        readline (ramfile, ramfileline);
        read (ramfileline, bitvec);
        ram_name(i) := to_stdlogicvector(bitvec);
    end loop;
    return ram_name;
end function;

function init_from_file_or_zeroes(ramfile : string) return ram_type is
begin
    if ramfile = "RAM_INIT.dat" then
        return (others => (others => '0'));
    else
        return InitRamFromFile(ramfile);
    end if;
end;

--shared variable mem : ram_type := (others => (others => '0'));
signal mem : ram_type := init_from_file_or_zeroes(C_INIT_FILE);

attribute keep_hierarchy : string;
attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;

begin

process(clka)
begin
    if(clka'event and clka = '1') then
        if(ena = '1') then
            if(wea = '1') then
                mem(to_integer(unsigned(addra))) <= dina;
                ram_data_a <= dina;
            else
                ram_data_a <= mem(to_integer(unsigned(addra)));
            end if;
        end if;
    end if;
end process;

process(clkb)
begin
    if(clkb'event and clkb = '1') then
        if(enb = '1') then
            ram_data_b <= mem(to_integer(unsigned(addrb)));
        end if;
    end if;
end process;

douta <= ram_data_a;
doutb <= ram_data_b;

end Behavioral;
