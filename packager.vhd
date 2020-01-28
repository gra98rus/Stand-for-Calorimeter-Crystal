library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.all;

entity packager is
port(
    clock    : in std_logic;
    
    adc_data       : in adc_data_t;
    adc_data_valid : in std_logic;
       
    data_bram_addr : out std_logic_vector(31 downto 0);
    data_bram_clk  : out std_logic;
    data_bram_din  : out std_logic_vector(31 downto 0);
    data_bram_we   : out std_logic

    );

end packager;

architecture behavioral of packager is

    signal adc_data_sr     : adc_data_t := (others=>(others=>(others=>'0')));
    signal adc_data_lsr    : adc_data_lt := (others=>(others=>'0'));
    
    signal adc_data_r      : std_logic_vector(13 downto 0) := (others=>'0');
    signal data_bram_din_r : std_logic_vector(31 downto 0) := (others=>'0');
    
    signal burst_addr : unsigned(1 downto 0) := (others=>'1');
    signal sample_addr : unsigned(6 downto 0) := (others=>'1');
    
    signal addr_count : unsigned(8 downto 0) := (others=>'1');
    signal data_count : unsigned(8 downto 0) := (others=>'1');
    
    signal delay_cnt : integer := 2;
    
    signal data_bram_din_ar : std_logic_vector(31 downto 0) := (others=>'0');
    signal data_bram_din_aar : std_logic_vector(31 downto 0) := (others=>'0');

    signal sts_done : std_logic := '0';

    signal data_bram_we_r   : std_logic := '0';
    signal data_bram_we_dr  : std_logic := '0';    
    signal data_bram_we_ddr : std_logic := '0';
    signal data_bram_we_dddr : std_logic := '0';      
      
    
begin

process(clock)
begin
	if clock'event and clock='1' then


	
	   if delay_cnt /= 3 then
	       delay_cnt <= delay_cnt +1;
       end if;
       
      -- data_bram_din_r <= 
--       if sample_addr=0 then
--        data_bram_din_r <= B"0000_0000_0000_0000_00" & adc_data_lsr(0);
--       end if;
--       if sample_addr=1 then
--        data_bram_din_r <= B"0000_0000_0000_0000_00" & adc_data_lsr(1);
--       end if;
--       if sample_addr>=2 then
--        data_bram_din_r <= B"0000_0000_0000_0000_00" & adc_data_lsr(to_integer(sample_addr));
--       end if;
       
       if delay_cnt = 3 then 
	       
	       if sample_addr /= 127 then
	           sample_addr <= sample_addr +1;
	           addr_count <= addr_count + 1;
	       end if;
	   
	       if burst_addr = 3 and sample_addr=124 then
               sts_done <= '1';
           end if;

	       if sample_addr=127 and burst_addr/=3 then
                sample_addr <= (others=>'0');
                burst_addr <= burst_addr + 1;
                addr_count <= addr_count + 1;
                delay_cnt <= 0;
           end if;

	       if adc_data_valid='1' then
	           burst_addr <= (others=>'0');
	           sample_addr <= (others=>'0');
	           addr_count <= (others=>'0');
	           sts_done <= '0';
	           delay_cnt <= 0;
	           adc_data_sr <= adc_data;
               
               
               
	       end if;
	          
       end if;

       
	end if; -- clock	
end process;

process(clock)
begin
    if clock'event and clock='1' then
        
        data_bram_we_r   <= '1';
        
        if sts_done = '1' then
            data_bram_we_r <= '0';
        end if;
        
        if adc_data_valid='1' then
            data_bram_we_r <= '1';
        end if;
        
        if sample_addr = 127 then
            data_bram_we_r   <= '0';
        end if;

        data_bram_we_dr  <= data_bram_we_r;
        data_bram_we_ddr <= data_bram_we_dr;
        
        
    end if;

end process;

process(clock)
begin
    if clock'event and clock='1' then

    end if;
end process;
data_bram_we   <= data_bram_we_ddr;
data_bram_clk  <= clock;
data_bram_addr <=  B"0000_0000_0000_0000_0000_0" &  std_logic_vector(addr_count) & B"00" ;
--data_bram_addr <=  B"0000_0000_0000_0000_000" & B"000000" & std_logic_vector(sample_addr);
data_bram_din  <= B"0000_0000_0000_0000_00" & adc_data_sr(to_integer(burst_addr))(to_integer(sample_addr));




end architecture;
