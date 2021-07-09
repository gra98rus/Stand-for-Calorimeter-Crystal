library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

use work.reg_map.all;
use work.new_types.all;

entity reg_file is
port(
	clock               : in  std_logic;
	regWE               : in  std_logic;
	regNum              : in  std_logic_vector(31 downto 0);
	dataIn              : in  std_logic_vector(31 downto 0);
    data_ready          : in std_logic;

	dataOut             : out std_logic_vector(31 downto 0);
    start_event         : out std_logic;
    trigger_type        : out std_logic;
    trigger_level       : out adc_data_t;
    selected_channels   : out std_logic_vector( 3 downto 0);
    shapers_config      : out std_logic_vector( 7 downto 0);
    amplifiers_config   : out std_logic_vector( 5 downto 0);
    spectrum_spec       : out std_logic_vector(14 downto 0);
    spi_data            : out std_logic_vector(31 downto 0);
    spi_valid_bytes_num : out std_logic_vector( 2 downto 0);
    spi_start           : out std_logic;
    adc_resync          : out std_logic
  	);

end reg_file;

architecture behavioral of reg_file is
	signal data_out_r          : std_logic_vector(31 downto 0) := (others=>'0');

	signal echo_reg_r          : std_logic_vector(31 downto 0) := (others=>'0');
	signal reg_echo_ena_r      : std_logic                     := '0';

    signal start_event_r       : std_logic                     := '0';
    signal start_event_delay   : std_logic                     := '0';
    signal start_event_result  : std_logic                     := '0';
    signal trigger_type_r      : std_logic                     := '1';
    signal trigger_level_r     : adc_data_t                    := (others => (others =>'0'));
    signal selected_channels_r : std_logic_vector( 3 downto 0) := (others => '0');
    signal shapers_config_r    : std_logic_vector( 7 downto 0) := (others => '0');
    signal amplifiers_config_r : std_logic_vector( 5 downto 0) := (others => '0');
    signal spi_start_r         : std_logic;
    signal spi_start_delay_r   : std_logic;
    signal adc_resync_r         : std_logic;
    signal adc_resync_delay_r   : std_logic;

    attribute keep_hierarchy : string;
    attribute keep_hierarchy of Behavioral : architecture is KEEP_HIERAR;
begin

process(clock)
begin
    if clock'event and clock='1' then
        start_event_delay <= start_event_r;
		if start_event_r = '1' and start_event_delay = '0' then
			start_event_result <= '1';
	    else
	        start_event_result <= '0';
		end if;
	end if;
end process;

process(clock)
begin
    if clock'event and clock='1' then
        spi_start_delay_r <= spi_start_r;
		if spi_start_r = '1' and spi_start_delay_r = '0' then
			spi_start <= '1';
	    else
	        spi_start <= '0';
		end if;
	end if;
end process;

process(clock)
begin
    if clock'event and clock='1' then
        adc_resync_delay_r <= adc_resync_r;
		if adc_resync_r = '1' and adc_resync_delay_r = '0' then
			adc_resync <= '1';
	    else
	        adc_resync <= '0';
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

		if regNum = REG_START_EVENT and regWE = '1' then
            start_event_r <= dataIn(0);
        end if;

		if regNum = REG_TRIGGER_TYPE and regWE = '1' then
            trigger_type_r <= dataIn(0);
        end if;

	    if regNum = REG_TRIGGER_LEVEL and regWE = '1' then
	        if dataIn(15 downto 14) = "00" then
                trigger_level_r(0) <= dataIn(13 downto 0);
            elsif dataIn(15 downto 14) = "01" then
                trigger_level_r(1) <= dataIn(13 downto 0);
            elsif dataIn(15 downto 14) = "10" then
                trigger_level_r(2) <= dataIn(13 downto 0);
            elsif dataIn(15 downto 14) = "11" then
                trigger_level_r(3) <= dataIn(13 downto 0);
            end if;
        end if;

		if regNum = REG_SELECTED_CHANNELS and regWE = '1' then
            selected_channels_r <= dataIn(3 downto 0);
        end if;

        if regNum = REG_SHAPER and regWE = '1' then
            if dataIn(3 downto 2) = "00" then
                shapers_config_r(1 downto 0) <= dataIn(1 downto 0);
            elsif dataIn(3 downto 2) = "01" then
                shapers_config_r(3 downto 2) <= dataIn(1 downto 0);
            elsif dataIn(3 downto 2) = "10" then
                shapers_config_r(5 downto 4) <= dataIn(1 downto 0);
            elsif dataIn(3 downto 2) = "11" then
                shapers_config_r(7 downto 6) <= dataIn(1 downto 0);
            end if;
        end if;

        if regNum = REG_AMPLIFIERS and regWE = '1' then
            if dataIn(3 downto 2) = "00" then
                amplifiers_config_r(1 downto 0) <= dataIn(1 downto 0);
            elsif dataIn(3 downto 2) = "01" then
                amplifiers_config_r(3 downto 2) <= dataIn(1 downto 0);
            elsif dataIn(3 downto 2) = "10" then
                amplifiers_config_r(5 downto 4) <= dataIn(1 downto 0);
            end if;
        end if;

        if regNum = REG_SPECTRUM_SPEC and regWE = '1' then
            spectrum_spec <= dataIn(14 downto 0);
        end if;

        if regNum = REG_SPI_DATA and regWE = '1' then
            spi_data <= dataIn;
        end if;

        if regNum = REG_SPI_VALID_BYTES and regWE = '1' then
            spi_valid_bytes_num <= dataIn(2 downto 0);
        end if;

        if regNum = REG_SPI_START and regWE = '1' then
            spi_start_r <= dataIn(0);
        end if;

        if regNum = REG_ADC_RESYNC and regWE = '1' then
            adc_resync_r <= dataIn(0);
        end if;

		if regNum=REG_STATUS then
		  data_out_r(0) <= data_ready;
		end if;
	end if;

end process;

dataOut           <= data_out_r;
start_event       <= start_event_result;
trigger_level     <= trigger_level_r;
trigger_type      <= trigger_type_r;
shapers_config    <= shapers_config_r;
amplifiers_config <= amplifiers_config_r;
selected_channels <= selected_channels_r;
end architecture;
