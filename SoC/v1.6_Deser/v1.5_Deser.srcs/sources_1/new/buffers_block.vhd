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
    ring_clk            : in std_logic;
    adc_data_write      : in  adc_data_t;
    simple_clk          : in std_logic;
    simple_addr         : in std_logic_vector (6 downto 0);
    simple_ena          : in std_logic;
    trigg_signal        : in std_logic;
    
    simple_dout         : out std_logic_vector (63 downto 0)
     );
end buffers_block;

--------------------------------------------------------------
architecture Behavioral of buffers_block is

    type state_type is (STT_WAIT, STT_SET_ADDR, STT_RING_WAIT, STT_READ_RING);
    signal state : state_type;
        
    signal dina_ring :  std_logic_vector (63 downto 0) := (others=>'0');
    
    signal addra_ring : std_logic_vector (6 downto 0) := B"000_0000";
    signal addrb_ring : std_logic_vector (6 downto 0) := B"000_0000";
    
    signal addra_simple : std_logic_vector (6 downto 0) := B"000_0000";
    
    signal doutb_ring : std_logic_vector (63 downto 0) := (others=>'0');
 
    signal write_simple_ena: std_logic := '0';
    
-----------------------------------------------------------------
begin

ring_buf: entity work.RAM
generic map(
    RAM_WIDTH => 64,
    RAM_DEPTH => 128)
port map(
    clka  => ring_clk,
    addra => addra_ring,
    dina  => dina_ring,
    wea   => '1',
    ena   => '1',

    clkb  => ring_clk,
    addrb => addrb_ring,
    dinb  => (others => '0'),
    enb   => '1',
    doutb => doutb_ring);

dina_ring <= adc_data_write(1) & adc_data_write(2) & adc_data_write(3) & adc_data_write(4);
-----------------------------------------------------------------

simple_buf: entity work.RAM
generic map(
    RAM_WIDTH => 64,
    RAM_DEPTH => 128)
port map(
    clka  => ring_clk,
    addra => addra_simple,
    dina  => doutb_ring,
    wea   => write_simple_ena,
    ena   => '1',

    clkb  => simple_clk,
    addrb => simple_addr,
    dinb  => (others => '0'),
    enb   => simple_ena,
    doutb => simple_dout);

-----------------------------------------------------------------

process (ring_clk)                                             --port A address increment (ring buffer)
begin
    if ring_clk'event and ring_clk='1' then
        addra_ring <= std_logic_vector (unsigned(addra_ring) + 1);
    end if;
end process;
-----------------------------------------------------------------


process (ring_clk)
begin 
    if ring_clk'event and ring_clk='1' then 
        
        case (state) is
            when STT_WAIT =>                                                --waiting for the trigger signal
                write_simple_ena<= '0';
                if trigg_signal = '1' then
                    state           <= STT_SET_ADDR;
                    addrb_ring          <= std_logic_vector (unsigned(addra_ring) - 30);
                end if;

            when STT_SET_ADDR =>                                            --address offset from the address of the last record
                addra_simple        <= (others => '0');
                addrb_ring      <= std_logic_vector (unsigned(addrb_ring) + 1);
                state               <= STT_RING_WAIT;
                write_simple_ena    <= '0';

            when STT_RING_WAIT =>                                           --waiting for data at a shifted address
                state               <= STT_READ_RING;
                addrb_ring      <= std_logic_vector (unsigned(addrb_ring) + 1);
                write_simple_ena    <= '1';
                
            when STT_READ_RING =>                                           --write to a simple buffer
                if addra_simple = B"1111111" then
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
