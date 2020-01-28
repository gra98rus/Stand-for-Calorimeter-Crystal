library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.reg_map.all;

entity reg_file is
port(
	clock   : in  std_logic;
	regWE   : in  std_logic;
	regNum  : in  std_logic_vector(15 downto 0);
	dataIn  : in  std_logic_vector(15 downto 0);
	dataOut : out std_logic_vector(15 downto 0);

	cmd_start : out std_logic;
	--cmd_stop : out std_logic;
	
    --sts_armed	: in std_logic;
    sts_in_prog    : in std_logic;
    sts_done    : in std_logic
	
	);
	
end reg_file;

architecture behavioral of reg_file is
	signal data_in_r  : std_logic_vector(15 downto 0) := (others=>'0');
	signal data_out_r : std_logic_vector(15 downto 0) := (others=>'0');

	signal echo_reg_r : std_logic_vector(15 downto 0) := (others=>'0');
	signal reg_echo_ena_r : std_logic := '0';
	
	signal cmd_start_ena_r    : std_logic := '0';
	signal cmd_start_r   : std_logic := '0';
	
	
begin

process(clock)
begin
	if clock'event and clock='1' then
		if regWE='1' then
			data_in_r <= dataIn;
		end if;
		
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
		
		if cmd_start_ena_r='1' then
		      cmd_start_r <= '1';
		      cmd_start_ena_r <= '0';
		end if;
		  
		
		--cmd_stop_r <= '0';
		--if regNum=REG_COMMAND and regWE='1' and dataIn(1)='1' then
        --    cmd_stop_r <= '1';
		--end if;
		
		
		if regNum=REG_STATUS then
		  data_out_r(0) <= sts_done;
          --data_out_r(1) <= sts_armed;
          data_out_r(1) <= sts_in_prog;
		end if;
		
	end if; -- clock
end process;
	
	
	
dataOut     <=  data_out_r;

cmd_start   <=  cmd_start_r;
--cmd_stop    <=  cmd_stop_r;	


end architecture;