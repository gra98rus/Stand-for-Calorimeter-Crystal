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
    RAM_DEPTH  : integer := 32
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


type ram_type is array (C_RAM_DEPTH-1 downto 0) of std_logic_vector (C_RAM_WIDTH-1 downto 0);      -- 2D Array Declaration for RAM signal
signal ram_data_a : std_logic_vector(C_RAM_WIDTH-1 downto 0) ;
signal ram_data_b : std_logic_vector(C_RAM_WIDTH-1 downto 0) ;

--shared variable mem : ram_type := (others => (others => '0'));
signal mem : ram_type := (others => (others => '0'));

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
--            if(web = '1') then
--                mem(to_integer(unsigned(addrb))) <= dinb;
--                ram_data_b <= dinb;
--            else
                ram_data_b <= mem(to_integer(unsigned(addrb)));
--            end if;
        end if;
    end if;
end process;

douta <= ram_data_a;
doutb <= ram_data_b;

end Behavioral;
