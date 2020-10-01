library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.new_types.all;

entity Spectra_controller is
Port ( 
    clk              : in  std_logic;
    bram_ctrl_clk    : in  std_logic;
    spectrum_spec    : in  std_logic_vector(13 downto 0);
    spectra_statuses : in  std_logic_vector(11 downto 0);
    adc_data         : in  adc_data_56_t;
    adc_max_value    : in  adc_data_56_t;
    adc_data_valid   : in  std_logic;
    PS_addr          : in  std_logic_vector(15 downto 0);
    
    simple_buff_addr : out std_logic_vector(6  downto 0); 
    PS_data          : out std_logic_vector(31 downto 0)

);
end Spectra_controller;

architecture Behavioral of Spectra_controller is

    signal spectra_params : spectrum_params_t             := (others => (others => '0'));
    signal num_of_bins    : num_of_bins_t                 := (others => (others => '0'));
    signal selected_point : selected_point_t              := (others => (others => '0'));
    signal PL_addr        : spectra_addr                  := (others => (others => '0'));
    signal data_to_mem    : spectra_data                  := (others => (others => '0'));
    signal data_from_mem  : spectra_data                  := (others => (others => '0'));
    signal wea            : std_logic_vector(11 downto 0) := (others => '0');
    signal ena            : std_logic_vector(11 downto 0) := (others => '1');
    signal enb            : std_logic_vector(11 downto 0) := (others => '0');
    signal doutb          : spectra_data                  := (others => (others => '0'));
    signal relevant_adc   : relevant_adc_t                := (others => (others => '0'));
    signal start_creators : std_logic                     := '0'; 
    
    signal increase_status      : std_logic_vector(11 downto 0) := (others => '0');
    signal increase_status_buf1 : std_logic_vector(11 downto 0) := (others => '0');
    signal increase_status_buf2 : std_logic_vector(11 downto 0) := (others => '0');
    signal bins                 : bins                          := (others => (others => '0'));
    
    signal clock_read : std_logic_vector(11 downto 0) := (others => '0');
    signal read       : std_logic_vector(11 downto 0) := (others => '0');
    signal written    : std_logic_vector(11 downto 0) := (others => '0');
    
    signal count      : integer                       := 0;
    type   state_type is (STT_READY, STT_READ_DATA, STT_START_CREATORS, STT_WAIT);
    signal state      : state_type;
    
    
begin

spectra_memory_i: entity work.Spectra_memory
port map(
    clka => clk,
    clkb => bram_ctrl_clk,
    addra => PL_addr,
    PS_addr => PS_addr,
    dina => data_to_mem,
    wea => wea,
    ena => ena,
    --enb => enb,
    douta => data_from_mem,
    PS_data => PS_data
);

spectra_max_creators: for i in 0 to 3 generate spectrum_creator_ii: entity work.Spectrum_creator
    port map(
        clk => clk,
        status => spectra_statuses(i*3),
        spectra_params => spectra_params(i*3),
        adc_data => relevant_adc(i*3),
        adc_data_valid => start_creators,
        bin => bins(i*3),
        increase_status => increase_status(i*3)
    );
end generate;

spectra_point_creators: for i in 0 to 7 generate spectrum_creator_ii: entity work.Spectrum_creator
    port map(
        clk => clk,
        status => spectra_statuses(i + i/2 + 1),
        spectra_params => spectra_params(i + i/2 + 1),
        adc_data => relevant_adc(i + i/2 + 1),
        adc_data_valid => start_creators,
        bin => bins(i + i/2 + 1),
        increase_status => increase_status(i + i/2 + 1)
    );
end generate;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
            increase_status_buf1(i) <= increase_status(i);
            increase_status_buf2(i) <= increase_status_buf1(i);
            wea(i) <= increase_status_buf2(i);
        end loop;
    end if;
end process;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
            if increase_status(i) = '1' then
                PL_addr(i) <= bins(i);
            end if;
        end loop;
    end if;
end process;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
            data_to_mem(i) <=  std_logic_vector(unsigned(data_from_mem(i)) + 1);
        end loop;
    end if;
end process;

process (clk)
begin 
    if clk'event and clk='1' then 
        
        case (state) is
            when STT_READY =>                                                --waiting for the new valid data
                start_creators          <= '0';
                if adc_data_valid = '1' then
                    state               <= STT_READ_DATA;
                    count               <= 0;
                    simple_buff_addr    <= selected_point(count);
                    relevant_adc(0) <= adc_max_value(0);
                    relevant_adc(3) <= adc_max_value(1);
                    relevant_adc(6) <= adc_max_value(2);
                    relevant_adc(9) <= adc_max_value(3);
                end if;

            when STT_READ_DATA =>                                            --address offset from the address of the last record
                if count < 8 then
                    simple_buff_addr    <= selected_point(count);
                    relevant_adc(count + count/2 + 1) <= adc_data(count / 2);
                    count               <= count + 1;
                else
                    state               <= STT_START_CREATORS;
                end if;
                
            when STT_START_CREATORS =>
                start_creators          <= '1';
                if adc_data_valid = '1' then
                    state               <= STT_WAIT;
                else
                    state               <= STT_READY;
                end if;
                
            when STT_WAIT =>
                start_creators          <= '0';
                if adc_data_valid = '0' then
                    state <= STT_READY;
                end if;
        end case;

    end if;
end process;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
            if spectrum_spec(13 downto 10) = std_logic_vector(to_unsigned(i, 4)) then
                num_of_bins   (i) <= spectrum_spec(9 downto 7);
                selected_point(i) <= spectrum_spec(6 downto 0);
            end if;
        end loop;
    end if;
end process;

end Behavioral;