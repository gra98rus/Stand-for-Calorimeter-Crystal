library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.reg_map.all;
use work.new_types.all;

entity reg_file is
port(
	clock   : in  std_logic;
	regWE   : in  std_logic;
	regNum  : in  std_logic_vector(15 downto 0);
	dataIn  : in  std_logic_vector(15 downto 0);
	dataOut : out std_logic_vector(15 downto 0);

	cmd_start : out std_logic;
    sts_in_prog    : in std_logic;
    sts_done    : in std_logic;
    
    start_event  : out std_logic;
    trigger_type : out std_logic;
    trigger_level: out std_logic_vector(13 downto 0);
        
    adc_data      : out adc_data_ltt
  	);
	
end reg_file;

architecture behavioral of reg_file is
	signal data_out_r : std_logic_vector(15 downto 0) := (others=>'0');

	signal echo_reg_r : std_logic_vector(15 downto 0) := (others=>'0');
	signal reg_echo_ena_r : std_logic := '0';
	
	signal cmd_start_ena_r    : std_logic := '0';
	signal cmd_start_r   : std_logic := '0';
	
    signal start_event_r : std_logic := '0';
    signal start_event_delay : std_logic := '0';
    signal start_event_result : std_logic := '0';
    signal trigger_type_r : std_logic := '1';
    signal trigger_level_r : std_logic_vector(13 downto 0) := (others => '0');

    signal test_value1 : std_logic_vector (13 downto 0) := "00000000000000";
    signal test_value2 : std_logic_vector (13 downto 0) := "00000000000000";
    signal test_value3 : std_logic_vector (13 downto 0) := "00000000000000";
    signal test_value4 : std_logic_vector (13 downto 0) := "00000000000000";
    signal adc_data_r : adc_data_ltt := (others=>(others=>(others=>'0')));

begin

process(clock)
begin
    if clock'event and clock='1' then
        start_event_delay <= start_event_r;
		if start_event_r = '1' and start_event_delay = '0' then
			start_event_result <= '1';
--            test_value2 <= test_value2 + 1;
	    else
	        start_event_result <= '0';
--	        test_value4 <= test_value4 + 1;
		end if;
	end if;
end process;

process(clock)
begin
	if clock'event and clock='1' then
	
		data_out_r <= (others=>'0');
		reg_echo_ena_r <= '0';
		
		if regNum=REG_NUM_ECHO then
			reg_echo_ena_r <= '1';
		end if;
		
		if reg_echo_ena_r='1' then
			if regWE='1' then
				echo_reg_r <= dataIn;
			end if;
			data_out_r <= echo_reg_r;
		end if;
		
		cmd_start_r <= '0';
		
		if regNum=REG_COMMAND then
		    if regWE='1' and dataIn(0)='1' then
                cmd_start_ena_r <= '1';
            end if;
        end if;
        
		if regNum = REG_START_EVENT and regWE = '1' then
            start_event_r <= dataIn(0);
            test_value1 <= test_value1 + 1;
        end if;
        
		if regNum = REG_TRIGGER_TYPE and regWE = '1' then
            trigger_type_r <= dataIn(0);
        end if;
        
	    if regNum = REG_TRIGGER_LEVEL and regWE = '1' then
            trigger_level_r <= dataIn(13 downto 0);
            test_value3 <= dataIn(13 downto 0);
        end if;
        
		if cmd_start_ena_r='1' then
		      cmd_start_r <= '1';
		      cmd_start_ena_r <= '0';
		end if;
		
		if regNum=REG_STATUS then
		  data_out_r(0) <= sts_done;
          data_out_r(1) <= sts_in_prog;
		end if;
    adc_data(0) <= (others => test_value1);
    adc_data(1) <= (others => test_value2);
    adc_data(2) <= (others => test_value3);
    adc_data(3) <= (others => test_value4);
	end if; -- clock

end process;
	
dataOut      <= data_out_r;
cmd_start    <= cmd_start_r;
trigger_type <= trigger_type_r;
start_event  <= start_event_result;
trigger_level<= trigger_level_r;
end architecture;