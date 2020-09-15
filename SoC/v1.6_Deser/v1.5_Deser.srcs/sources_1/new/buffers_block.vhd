library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.new_types.all;
--------------------------------------------------------------
entity buffers_block is
port (
    clk_ring            : in std_logic;
    clk_simple          : in std_logic;
    adc_data_write      : in  adc_data_t;
    read_simple_ena     : in std_logic;
    trigg_signal        : in std_logic;
    
    data_read           : out std_logic_vector (63 downto 0)
     );
end buffers_block;

--------------------------------------------------------------
architecture Behavioral of buffers_block is

    type state_type is (STT_WAIT, STT_SET_ADDR, STT_READ_RING);
    signal state : state_type;
        
    signal dina_ring :  std_logic_vector (63 downto 0) := (others=>'0');
    
    signal addra_ring : std_logic_vector (6 downto 0) := B"000_0000";
    signal addrb_ring : std_logic_vector (6 downto 0) := B"000_0000";
    
    signal addra_simple : std_logic_vector (8 downto 0) := B"0_0000_0000";
    signal addrb_simple : std_logic_vector (8 downto 0) := B"0_0000_0000";
    
    signal doutb_ring : std_logic_vector (63 downto 0) := (others=>'0');
 
    signal write_simple_ena: std_logic := '0';
    
-----------------------------------------------------------------
begin

ring_buf: entity work.RAM
generic map(
    RAM_WIDTH => 64,
    RAM_DEPTH => 128)
port map(
    clka  => clk_ring,
    addra => addra_ring,
    dina  => dina_ring,
    wea   => '1',
    ena   => '1',

    clkb  => clk_ring,
    addrb => addrb_ring,
    dinb  => (others => '0'),
    enb   => '1',
    doutb => doutb_ring);

dina_ring <= adc_data_write(1) & adc_data_write(2) & adc_data_write(3) & adc_data_write(4);
-----------------------------------------------------------------

simple_buf: entity work.RAM
generic map(
    RAM_WIDTH => 64,
    RAM_DEPTH => 512)
port map(
    clka  => clk_ring,
    addra => addra_simple,
    dina  => doutb_ring,
    wea   => write_simple_ena,
    ena   => '1',

    clkb  => clk_simple,
    addrb => addrb_simple,
    dinb  => (others => '0'),
    enb   => read_simple_ena,
    doutb => data_read);

-----------------------------------------------------------------

process (clk_ring)                                             --port A address increment (ring buffer)
begin
    if clk_ring'event and clk_ring='1' then
        addra_ring <= std_logic_vector (unsigned(addra_ring) + 1);
    end if;
end process;
-----------------------------------------------------------------


process (clk_ring)
begin 
    if clk_ring'event and clk_ring='1' then 
        
        case (state) is
            when STT_WAIT =>
                if trigg_signal = '1' then
                    state           <= STT_SET_ADDR;
                    write_simple_ena<= '0';
                end if;

            when STT_SET_ADDR =>
                addra_simple        <= (others => '0');
                addrb_ring          <= std_logic_vector (unsigned(addra_ring) - 30);
                state               <= STT_READ_RING;
                write_simple_ena    <= '1';

            when STT_READ_RING =>
                if addra_simple = B"111111111" then
                    state   <= STT_WAIT;
                else
                    write_simple_ena<= '1';
                    addra_simple    <= std_logic_vector (unsigned(addra_simple) + 1);
                    addrb_ring      <= std_logic_vector (unsigned(addrb_ring) + 1);
                end if;
        end case;

    end if;
end process;

-----------------------------------------------------------------
end Behavioral;
