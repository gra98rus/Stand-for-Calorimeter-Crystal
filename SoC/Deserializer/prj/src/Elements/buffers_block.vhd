----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2019 12:38:26 PM
-- Design Name: 
-- Module Name: ring_buffer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
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
component blk_mem_gen_0                         --ring memory block
port (

    addra : in std_logic_vector (6 downto 0);   --input write_address signal
    clka : in std_logic;                        --input write_clock signal
    dina : in std_logic_vector (63 downto 0);   --input write_data signal
    wea : in std_logic_vector (0 downto 0);     --input write_type signal
    
    addrb : in std_logic_vector (6 downto 0);   --input read_address signal
    clkb : in std_logic;                        --input read_clock signal
    doutb : out std_logic_vector (63 downto 0); --output read_data signal
    enb : in std_logic);                        --input read_enable signal
end component;
--------------------------------------------------------------
component blk_mem_gen_1                         --simple memory block
port (

    addra : in std_logic_vector (8 downto 0);   --input write_address signal
    clka : in std_logic;                        --input write_clock signal
    dina : in std_logic_vector (63 downto 0);   --input write_data signal
    ena : in std_logic;                         --input write_enable signal
    wea : in std_logic_vector (0 downto 0);     --input write_type signal
    
    addrb : in std_logic_vector (8 downto 0);   --input read_address signal
    clkb : in std_logic;                        --input read_clock signal
    doutb : out std_logic_vector (63 downto 0); --output read_data signal
    enb : in std_logic);                        --input read_enable signal
end component;
----------------------------------------------------------------
    constant wea_c : std_logic_vector (0 downto 0) := B"1";
    --constant buf_depth : integer := 100;          --buffer depth    
    signal ring_data_out_observer: std_logic_vector (1 downto 0) := (others=>'0');
    signal simple_data_out_observer: std_logic := '0';
    signal simple_buffer_state_s: std_logic := '0';
        
    signal dina_ring : std_logic_vector (63 downto 0) := (others=>'0');
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
--datainA <= adc_data_write(4);
--datainB <= adc_data_write(3);
--datainC <= adc_data_write(2);                          --prepare data to write
--datainD <= adc_data_write(1);
dina_ring <= adc_data_write(1) & adc_data_write(2) & adc_data_write(3) & adc_data_write(4);
-----------------------------------------------------------------
blk_mem_gen_0_i : blk_mem_gen_0                 --ring memory module
port map(                                       --port A - write port            
                                                --port B - read port
    addra => addra_ring,                             --in
    clka => write_clk_ring,                          --in
    dina => dina_ring,                               --in           
    wea => wea_c,                                    --in
    
    addrb =>addrb_ring,                              --in     
    clkb => read_clk_ring,                           --in
    doutb => adc_data_read,                          --out
    enb => read_ring_ena);                           --in
-----------------------------------------------------------------
blk_mem_gen_1_i : blk_mem_gen_1                 --ring memory module
port map(                                       --port A - write port            
                                                --port B - read port
    addra => addra_simple,                      --in
    clka => read_clk_ring,                      --in
    dina => adc_data_read,                      --in           
    ena => read_ring_ena,                       --in               
    wea => wea_c,                               --in
        
    addrb =>addrb_simple,                       --in     
    clkb => read_clk_simple,                    --in
    doutb => data_read,                         --out
    enb => read_simple_ena);                    --in
-------------------------------------------------------------------

-------------------------------------------------------------------
process (write_clk_ring)                                             --port A address increment (ring buffer)
begin
    if write_clk_ring'event and write_clk_ring='1' then                   --every clock
        addra_ring <= std_logic_vector (unsigned(addra_ring) + 1);
    end if;
end process;
--------------------------------------------------------------------
process (read_clk_ring,read_clk_simple)                    --process to increment both ports B addresses and simple port A address
begin                                                                  

    --process part to put data into simple buffer
    if read_clk_ring'event and read_clk_ring='1' then                     --every ring_clock
       case ring_data_out_observer is
            when B"00" =>
                if read_ring_ena='1' then                  --to change read address on read event
                    ring_data_out_observer <= B"01";
                end if;
            when B"01" =>                             --if read_ring enable event
                addrb_ring <= std_logic_vector (unsigned(addra_ring) - 10);       
                ring_data_out_observer <= B"10";
                simple_buffer_state_s <= '0';
            when B"10" =>                                       --if read_ring enable
                addrb_ring <= std_logic_vector (unsigned(addrb_ring) + 1);
                addra_simple <= std_logic_vector (unsigned(addra_simple) + 1);
                if addra_simple = b"1_1111_1111" then
                    ring_data_out_observer <= B"11";
                end if;
            when B"11" =>
                if simple_buffer_state_s = '1' then
                    ring_data_out_observer <= B"00";
                end if;
            when others =>
                    ring_data_out_observer <= B"00";
        end case;
    end if;
    
    --process part to increment port B address (simple buffer)  
    if read_clk_simple'event and read_clk_simple = '1' and read_simple_ena = '1' then --to transfer data to ps_system 
    
        simple_buffer_state_s <= '0';
    
        if simple_buffer_state_s = '0' then
            addrb_simple <= std_logic_vector (unsigned(addrb_simple) + 1);
        end if;
        
        if addrb_simple = B"1_1111_1111" then  -- to indicate that all data is transferred
            simple_buffer_state_s <= '1';
        end if;    
            
    end if;
    
end process;
--------------------------------------------------------------------

simple_buffer_state <= simple_buffer_state_s;
data_transfer_end <= ring_data_out_observer;

end Behavioral;
