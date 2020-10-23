library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.new_types.all;
use work.func_pkg.all;
--------------------------------------------------------------
entity buffers_block is
port (
    ring_clk            : in std_logic;
    adc_data_write      : in  adc_data_64_t;
    
    simple_clk          : in std_logic;
    simple_addr         : in std_logic_vector  (6 downto 0);
    
    simple_clk_spectra  : in std_logic;
    simple_addr_spectra : in std_logic_vector  (6 downto 0);
    
    trigg_signal        : in std_logic;
    
    simple_dout         : out std_logic_vector (63 downto 0);
    simple_dout_spectra : out adc_data_spectr_t;
    simple_max_value    : out adc_data_spectr_t;

    simple_data_valid   : out std_logic
);
end buffers_block;

--------------------------------------------------------------
architecture Behavioral of buffers_block is

    type state_type is (STT_WAIT, STT_SET_ADDR, STT_RING_WAIT, STT_READ_RING);
    signal state                : state_type;
        
    signal dina_ring            : std_logic_vector (63 downto 0) := (others => '0');
    
    signal addra_ring           : std_logic_vector ( 8 downto 0) := B"00000_0000";
    signal addrb_ring           : std_logic_vector ( 8 downto 0) := B"00000_0000";
    
    signal addra_simple         : std_logic_vector ( 6 downto 0) := B"000_0000";
    
    signal doutb_ring           : std_logic_vector (63 downto 0) := (others => '0');
    signal doutb_simple_spectra : std_logic_vector (63 downto 0) := (others => '0');
 
    signal write_simple_ena     : std_logic                      := '0';
    
    signal max_value            : adc_data_spectr_t              := (others => (others => '0'));
    
    attribute keep_hierarchy    : string;
    attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
-----------------------------------------------------------------
begin

ring_buf: entity work.RAM
generic map(
    RAM_WIDTH => BUFFER_WIDTH,
    RAM_DEPTH => 512)
port map(
    clka  => ring_clk,
    addra => addra_ring,
    dina  => dina_ring,
    wea   => '1',
    ena   => '1',

    clkb  => ring_clk,
    addrb => addrb_ring,
    enb   => '1',
    doutb => doutb_ring);

dina_ring <= adc_data_write(3) & adc_data_write(2) & adc_data_write(1) & adc_data_write(0);
-----------------------------------------------------------------

simple_buf: entity work.RAM
generic map(
    RAM_WIDTH => BUFFER_WIDTH,
    RAM_DEPTH => 128)
port map(
    clka  => ring_clk,
    addra => addra_simple,
    dina  => doutb_ring,
    wea   => write_simple_ena,
    ena   => '1',

    clkb  => simple_clk,
    addrb => simple_addr,
    enb   => '1',
    doutb => simple_dout);
    
simple_buf_for_spectra: entity work.RAM
generic map(
    RAM_WIDTH => BUFFER_WIDTH,
    RAM_DEPTH => 128)
port map(
    clka  => ring_clk,
    addra => addra_simple,
    dina  => doutb_ring,
    wea   => write_simple_ena,
    ena   => '1',

    clkb  => simple_clk_spectra,
    addrb => simple_addr_spectra,
    enb   => '1',
    doutb => doutb_simple_spectra);
    
read_SBFS: for i in 0 to ADC_NB - 1 generate
    simple_dout_spectra(i) <= doutb_simple_spectra(BUFFER_WIDTH / ADC_NB * i + clog2(BINS_NUM) - 1 downto BUFFER_WIDTH / ADC_NB * i);
end generate read_SBFS;
    
--simple_dout_spectra(0) <= doutb_simple_spectra(13 downto  0);
--simple_dout_spectra(1) <= doutb_simple_spectra(29 downto 16);
--simple_dout_spectra(2) <= doutb_simple_spectra(45 downto 32);
--simple_dout_spectra(3) <= doutb_simple_spectra(61 downto 48);

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
                    state             <= STT_SET_ADDR;
                    addrb_ring        <= std_logic_vector (unsigned(addra_ring) - 30);
                end if;

            when STT_SET_ADDR =>                                            --address offset from the address of the last record
                addra_simple          <= (others => '0');
                addrb_ring            <= std_logic_vector (unsigned(addrb_ring) + 1);
                state                 <= STT_RING_WAIT;
                write_simple_ena      <= '0';
                simple_data_valid     <= '0';
                max_value             <= (others => (others => '0'));
                    
            when STT_RING_WAIT =>                                           --waiting for data at a shifted address
                state                 <= STT_READ_RING;
                addrb_ring            <= std_logic_vector (unsigned(addrb_ring) + 1);
                write_simple_ena      <= '1';
                
            when STT_READ_RING =>                                           --write to a simple buffer
                if addra_simple = B"1111111" then
                    state             <= STT_WAIT;
                    write_simple_ena  <= '0';
                    simple_data_valid <= '1';
                    if doutb_ring(13 downto  2) > max_value(0) then
                        max_value(0) <= doutb_ring(13 downto 2);
                    end if;
                    if doutb_ring(29 downto 18) > max_value(1) then
                        max_value(1) <= doutb_ring(29 downto 18);
                    end if;
                    if doutb_ring(45 downto 34) > max_value(2) then
                        max_value(2) <= doutb_ring(45 downto 34);
                    end if;
                    if doutb_ring(61 downto 50) > max_value(3) then
                        max_value(3) <= doutb_ring(61 downto 50);
                    end if;
                else
                    write_simple_ena  <= '1';
                    addra_simple      <= std_logic_vector (unsigned(addra_simple) + 1);
                    addrb_ring        <= std_logic_vector (unsigned(addrb_ring) + 1);
                    if doutb_ring(13 downto  2) > max_value(0) then
                        max_value(0) <= doutb_ring(13 downto 2);
                    end if;
                    if doutb_ring(29 downto 18) > max_value(1) then
                        max_value(1) <= doutb_ring(29 downto 18);
                    end if;
                    if doutb_ring(45 downto 34) > max_value(2) then
                        max_value(2) <= doutb_ring(45 downto 34);
                    end if;
                    if doutb_ring(61 downto 50) > max_value(3) then
                        max_value(3) <= doutb_ring(61 downto 50);
                    end if;
                end if;
        end case;

    end if;
end process;

simple_max_value <= max_value;
-----------------------------------------------------------------
end Behavioral;
