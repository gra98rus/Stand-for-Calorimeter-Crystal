library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;
library work;
use work.new_types.all;
--------------------------------------------------------------
entity buffers_block is
port (
    clk_ring     : in std_logic;
    clk_simple   : in std_logic;
    
    adc_data_write  :    in  adc_data_t;
    
    trigg_ena   : in std_logic;
    read_simple_ena : in std_logic;
    
    simple_buffer_state: out std_logic;
    array_state: out std_logic;
    data_for_pack_state: out std_logic;
    
    adc_data       : out adc_data_ltt;
    adc_data_valid : out std_logic
    );
end buffers_block;
--------------------------------------------------------------
architecture Behavioral of buffers_block is
component blk_mem_gen_0                         --ring memory block
port (

    addra : in std_logic_vector (7 downto 0);   
    clka : in std_logic;                        
    dina : in std_logic_vector (55 downto 0);   
    wea : in std_logic_vector (0 downto 0);     
    
    addrb : in std_logic_vector (7 downto 0);   
    clkb : in std_logic;                        
    doutb : out std_logic_vector (55 downto 0); 
    enb : in std_logic);                        
end component;
--------------------------------------------------------------
component blk_mem_gen_1                         --simple memory block
port (

    addra : in std_logic_vector (6 downto 0);   
    clka : in std_logic;                        
    dina : in std_logic_vector (63 downto 0);   
    ena : in std_logic;                         
    wea : in std_logic_vector (0 downto 0);     
    
    addrb : in std_logic_vector (6 downto 0);   
    clkb : in std_logic;                        
    doutb : out std_logic_vector (63 downto 0); 
    enb : in std_logic);                        
end component;
----------------------------------------------------------------
    constant wea_c : std_logic_vector (0 downto 0) := B"1";
    shared variable ring_data_out_observer: integer := 0;-- std_logic := '0';--std_logic_vector (1 downto 0) := (others=>'0');
    signal simple_data_out_observer: std_logic := '0';
    signal simple_buffer_state_s: std_logic := '0';
    signal array_state_s: std_logic := '0';
    signal array_state_s1: std_logic := '0';
   
    signal dina_ring : std_logic_vector (55 downto 0) := (others=>'0');
    
    signal addra_ring : std_logic_vector (7 downto 0) := B"0000_0000";
    signal addrb_ring : std_logic_vector (7 downto 0) := B"0000_0000";
    
    signal addra_simple : std_logic_vector (6 downto 0) := B"000_0000";
    signal addrb_simple : std_logic_vector (6 downto 0) := B"000_0000";
    
    signal dina_simple : std_logic_vector (63 downto 0) := (others=>'0');
    signal adc_data_read : std_logic_vector (55 downto 0) := (others=>'0');
                
    signal counter : integer := 0;
    signal burst_cnt : integer := 0;
    
    signal adc_data_r : adc_data_ltt := (others=>(others=>(others=>'0')));
    signal adc_data_valid_r: std_logic := '0';
    signal data_read_r : std_logic_vector(63 downto 0) := (others => '0');
    
    signal test_value1 : std_logic_vector (13 downto 0) := "00000000000011";
    signal test_value2 : std_logic_vector (13 downto 0) := "00000000000011";
    signal test_value3 : std_logic_vector (13 downto 0) := "00000000000011";
    signal test_value4 : std_logic_vector (13 downto 0) := "00000000000011";

    signal trigg_ena_delay: std_logic := '0';
    signal trigg_ena_result: std_logic := '0';
    
    signal read_ring_ena: std_logic := '0';

-----------------------------------------------------------------
begin
dina_ring <= adc_data_write(4) & adc_data_write(3) & adc_data_write(2) & adc_data_write(1);
-----------------------------------------------------------------
ring_mem_gen_i : blk_mem_gen_0                 --ring memory module
port map(                                       --port A - write port            
                                                --port B - read port
    addra => addra_ring,                        --in
    clka => clk_ring,                           --in
    dina => dina_ring,                          --in           
    wea => wea_c,                               --in
    
    addrb =>addrb_ring,                         --in     
    clkb => clk_simple,                         --in
    doutb => adc_data_read,                     --out
    enb => read_ring_ena);                      --in
-----------------------------------------------------------------
simple_mem_gen_i : blk_mem_gen_1                 --simple memory module
port map(                                       --port A - write port            
                                                --port B - read port
    addra => addra_simple,                      --in
    clka => clk_simple,                         --in
    dina => dina_simple,                        --in           
    ena => read_ring_ena,                       --in               
    wea => wea_c,                               --in
        
    addrb =>addrb_simple,                       --in     
    clkb => clk_simple,                         --in
    doutb => data_read_r,                       --out
    enb => '1'
    );--read_simple_ena);                    --in
-------------------------------------------------------------------
process (clk_ring)                                             --port A address increment (ring buffer)
begin
    if clk_ring'event and clk_ring='1' then
        addra_ring <= std_logic_vector (unsigned(addra_ring) + 1);
    end if;
end process;
--------------------------------------------------------------------
process(clk_simple)
begin
    if clk_simple'event and clk_simple='1' then
        trigg_ena_delay <= trigg_ena;
		if trigg_ena = '1' and trigg_ena_delay = '0' then
			trigg_ena_result <= '1';
--            test_value2 <= test_value2 + 1;
	    else
	        trigg_ena_result <= '0';
--	        test_value4 <= test_value4 + 1;
		end if;
	end if;
end process;

process (clk_simple)
begin 
    
    if clk_simple'event and clk_simple='1' then 
    
        if ring_data_out_observer = 1 then 
            ring_data_out_observer := 0;
            addrb_ring <= std_logic_vector (unsigned(addra_ring) - 10);
            addra_simple <= B"0000000";
            test_value3 <= test_value3 + 1;
            simple_buffer_state_s <= '0';
            read_ring_ena <= '1';
        elsif read_ring_ena='1' then
            addra_simple <= std_logic_vector (unsigned(addra_simple) + 1);
            addrb_ring <= std_logic_vector (unsigned(addrb_ring) + 1);
        end if;
          
        if trigg_ena_result = '1' then
            ring_data_out_observer := 1;
            simple_buffer_state_s <= '0';
            test_value4 <= test_value4 + 1;
        end if;
        dina_simple <= B"11" & adc_data_read(55 downto 42) & B"10" & adc_data_read(41 downto 28) & B"01"  --convert adc_data (14-bit*4) to data_out (16-bit*4);
                                    & adc_data_read(27 downto 14) & B"00" & adc_data_read(13 downto 0);   --16-bit word includes 2-bit to identify channal and
        
        if array_state_s1 = '1' then
            array_state_s <= '1';
        end if;
        
        if addra_simple = B"1111111" then
            simple_buffer_state_s <= '1';
            array_state_s <= '0';
            test_value2 <= test_value2 + 1;
            read_ring_ena <= '0';
        end if;
        
        if trigg_ena_result='0' then
            ring_data_out_observer := 0;
            
        end if;
    end if;
end process;

process(clk_simple)
begin
    if clk_simple'event and clk_simple = '1' then
        if simple_buffer_state_s = '1' and array_state_s = '0' then
            array_state_s1 <= '0';
            addrb_simple <= std_logic_vector (unsigned(addrb_simple) + 1);
            --adc_data_r(burst_cnt)(counter) <= adc_data_write(3); -- adc_data_read(41 downto 28);
            adc_data_r(burst_cnt)(counter) <= data_read_r((burst_cnt+1)*16-3 downto burst_cnt*16);
            if counter /= 127 then
                counter <= counter + 1;
            elsif counter = 127 and burst_cnt /= 3 then
                burst_cnt <= burst_cnt + 1;
                counter <= 0;
            elsif counter = 127 and burst_cnt = 3 then
                burst_cnt <= 0;
                counter <= 0;
                addrb_simple <= (others => '0');
                array_state_s1 <= '1';
                test_value1 <= test_value1 + 1;
                adc_data <= adc_data_r;
            end if;
        end if;
    end if;
end process;

--------------------------------------------------------------------
simple_buffer_state <= simple_buffer_state_s;
--adc_data_valid <= adc_data_valid_r;
--adc_data(0) <= (others => test_value1);
--adc_data(1) <= (others => test_value2);
--adc_data(2) <= (others => test_value3);
--adc_data(3) <= (others => test_value4);
array_state <= array_state_s;
end Behavioral;
