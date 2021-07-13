library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.new_types.all;
use work.func_pkg.all;

entity mem_rst is
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
    rst     : in  std_logic;
    dina    : in  std_logic_vector(RAM_WIDTH-1 downto 0);
    --    dinb    : in  std_logic_vector(RAM_WIDTH-1 downto 0);
    wea     : in  std_logic;
    --    web     : in  std_logic;
    ena     : in  std_logic;
    enb     : in  std_logic;
    douta   : out std_logic_vector(RAM_WIDTH-1 downto 0);
    doutb   : out std_logic_vector(RAM_WIDTH-1 downto 0)
);

end mem_rst;

architecture Behavioral of mem_rst is

    signal rst_addr : std_logic_vector(clog2(RAM_DEPTH)-1 downto 0);
    signal addra_l  : std_logic_vector(clog2(RAM_DEPTH)-1 downto 0);
    signal dina_l   : std_logic_vector(RAM_WIDTH-1 downto 0);
    signal wea_l    : std_logic;
    signal ena_l    : std_logic;

    type rstfsm_t is (rstfsm_IDLE, rstfsm_RUN);
    signal rstfsm : rstfsm_t := rstfsm_IDLE;

    attribute keep_hierarchy : string;
    attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
begin

RAM: entity work.RAM
generic map(
    RAM_WIDTH => RAM_WIDTH,
    RAM_DEPTH => RAM_DEPTH
)
port map(
    clka  => clka,
    clkb  => clkb,
    addra => addra_l,
    addrb => addrb,
    dina  => dina_l,
    wea   => wea_l,
    ena   => ena_l,
    enb   => enb,
    douta => douta,
    doutb => doutb
);

addra_l <= addra when rstfsm = rstfsm_IDLE else rst_addr;
dina_l  <= dina  when rstfsm = rstfsm_IDLE else (others => '0');
wea_l   <= wea   when rstfsm = rstfsm_IDLE else '1';
ena_l   <= ena   when rstfsm = rstfsm_IDLE else '1';

process (clka)
begin
    if clka'event and clka='1' then
        case (rstfsm) is

        when rstfsm_IDLE =>
            rst_addr <= (others => '0');
            if rst = '1' then
                rstfsm <= rstfsm_RUN;
            end if;

        when rstfsm_RUN =>
            rst_addr <= std_logic_vector(unsigned(rst_addr) + 1);
            if rst_addr = B"111111111111" then
                rstfsm <= rstfsm_IDLE;
            end if;

        end case;
    end if;
end process;


end Behavioral;
