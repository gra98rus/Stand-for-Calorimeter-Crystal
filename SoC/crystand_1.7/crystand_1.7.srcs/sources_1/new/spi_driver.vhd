--
--
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library work;
use work.new_types.all;

entity spi_driver_m is
Port (
    clk         : in  std_logic;
    rst         : in  std_logic;
    din         : in  std_logic_vector(31 downto 0);
    valid_bytes : in  std_logic_vector( 2 downto 0);
    start       : in  std_logic;

    sclk        : out std_logic;
    miso        : in  std_logic;
    mosi        : out std_logic;
    cs          : out std_logic
);
end spi_driver_m;

architecture Behavioral of spi_driver_m is

--------------------------------------------------------------------------------
--
--      Types
--

type spifsm_state_t is
(
    spifsmIDLE,
    spifsmTX
);

--------------------------------------------------------------------------------
--
--      Objects
--

signal spifsm_state      : spifsm_state_t;
signal spifsm_state_next : spifsm_state_t;
signal tx_data           : std_logic_vector(31 downto 0);
signal bit_counter       : integer;
signal cs_l              : std_logic;
signal nclk              : std_logic;

attribute keep_hierarchy : string;
attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;

begin

--------------------------------------------------------------------------------
--
--      Logic
--

cs    <= cs_l;
nclk  <= not clk;
sclk  <= nclk and (not cs_l);

process(clk)
begin
    if clk'event and clk='1' then
        spifsm_state <= spifsm_state_next;
        if rst='1' then
            spifsm_state      <= spifsmIDLE;
            spifsm_state_next <= spifsmIDLE;
        elsif start='1' and (not (valid_bytes = "000"))  then
            tx_data <= din;
            spifsm_state_next <= spifsmTX;
        elsif bit_counter = 1 and spifsm_state = spifsmTX then
            spifsm_state_next <= spifsmIDLE;
        end if;
    end if;
end process;

process(clk)
begin
    if clk'event and clk='1' then
        if rst='1' then
            cs_l   <= '1';
            mosi <= '0';
            bit_counter <= 0;
        else
            case spifsm_state is

            when spifsmIDLE =>
                cs_l <= '1';
                mosi <= '0';
                if spifsm_state_next = spifsmTX then
                    bit_counter <= to_integer(unsigned(valid_bytes(2 downto 0) & '0' & '0' & '0') - 1);
                end if;
            when spifsmTX =>
                cs_l        <= '0';
                bit_counter <= bit_counter - 1;
                mosi        <= tx_data(bit_counter);
            end case;
        end if;
    end if;
end process;

end Behavioral;
