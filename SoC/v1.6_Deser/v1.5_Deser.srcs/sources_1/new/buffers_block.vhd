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
    write_clk_ring    : in std_logic;
    read_clk_ring     : in std_logic;
    read_clk_simple   : in std_logic;
    
    adc_data_write  :    in  adc_data_t;
    data_read   :    out std_logic_vector (63 downto 0);
    
    read_ring_ena   : in std_logic;
    read_simple_ena : in std_logic;
    
    simple_buffer_state: out std_logic;
    data_transfer_end : out std_logic_vector(1 downto 0)
     );
end buffers_block;
--------------------------------------------------------------
architecture Behavioral of buffers_block is

----------------------------------------------------------------
    signal wea_ring : std_logic := '1';
    signal web_ring : std_logic := '0';
    signal ena_ring : std_logic := '0';
    --constant buf_depth : integer := 100;          --buffer depth    
    signal ring_data_out_observer: std_logic_vector (1 downto 0) := (others=>'0');
    signal simple_data_out_observer: std_logic := '0';
    signal simple_buffer_state_s: std_logic := '0';
        
    signal dina_ring : std_logic_vector (63 downto 0) := (others=>'0');
    signal dinb_ring : std_logic_vector (63 downto 0) := (others=>'0');
    --signal datainA : std_logic_vector (13 downto 0) := (others=>'0');
    --signal datainB : std_logic_vector (13 downto 0) := (others=>'0');
    --signal datainC : std_logic_vector (13 downto 0) := (others=>'0');
    --signal datainD : std_logic_vector (13 downto 0) := (others=>'0');
    
    signal addra_ring : std_logic_vector (6 downto 0) := B"000_0000";
    signal addrb_ring : std_logic_vector (6 downto 0) := B"000_0000";
    
    signal addra_simple : std_logic_vector (8 downto 0) := B"0_0000_0000";
    signal addrb_simple : std_logic_vector (8 downto 0) := B"0_0000_0000";
    
    signal adc_data_read : std_logic_vector (63 downto 0) := (others=>'0');
-----------------------------------------------------------------
begin

ring_buf: entity work.RAM
generic map(
    RAM_WIDTH => 64,
    RAM_DEPTH => 128)
port map(
    clka  => write_clk_ring,
    addra => addra_ring,
    dina  => dina_ring,
    wea   => '1',
    ena   => '1',
--    rsta  => '0',                       			  -- Port A Output reset (does not affect memory contents)
--    rstb  => '0',                                   -- Port B Output reset (does not affect memory contents)
--    regcea  => '0',                                   -- Port B Output reset (does not affect memory contents)
--    regceb  => '0',                                   -- Port B Output reset (does not affect memory contents)

    
    clkb  => read_clk_ring,
    addrb => addrb_ring,
    dinb  => (others => '0'),
    web   => '0',
    enb   => read_ring_ena,
    doutb => adc_data_read);

dina_ring <= adc_data_write(1) & adc_data_write(2) & adc_data_write(3) & adc_data_write(4);
-----------------------------------------------------------------


simple_buf: entity work.RAM
generic map(
    RAM_WIDTH => 64,
    RAM_DEPTH => 512)
port map(
    clka  => read_clk_ring,
    addra => addra_simple,
    dina  => adc_data_read,
    wea   => wea_ring,
    ena   => read_ring_ena,
--    rsta  => '0',                       			  -- Port A Output reset (does not affect memory contents)
--    rstb  => '0',                                   -- Port B Output reset (does not affect memory contents)
--    regcea  => '0',                                   -- Port B Output reset (does not affect memory contents)
--    regceb  => '0', 
    
    clkb  => read_clk_simple,
    addrb => addrb_simple,
    dinb  => (others => '0'),
    web   => '0',
    enb   => read_simple_ena,
    doutb => data_read);

-------------------------------------------------


end Behavioral;
