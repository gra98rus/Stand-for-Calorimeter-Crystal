library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.new_types.all;

entity spectra_controller is
Port ( 
    clk            : in std_logic;
    bram_ctrl_clk  : in std_logic;
    spectrum_spec  : in std_logic_vector(9 downto 0);
    spectra_statuses : in std_logic_vector(11 downto 0);
    adc_data       : in adc_data_ltt;
    adc_data_valid : in std_logic;
    PS_addr : in std_logic_vector(15 downto 0);
    PS_data : out std_logic_vector(31 downto 0)

);
end spectra_controller;

architecture Behavioral of spectra_controller is

    signal spectra_params : spectrum_params := (others => (others => '0'));
    signal PL_addr : spectra_addr := (others => (others => '0'));
    signal data_to_mem : spectra_data := (others => (others => '0'));
    signal data_from_mem : spectra_data := (others => (others => '0'));
    signal wea : std_logic_vector(11 downto 0) := (others => '0');
    signal ena : std_logic_vector(11 downto 0) := (others => '1');
    signal enb : std_logic_vector(11 downto 0) := (others => '0');
    signal doutb : spectra_data := (others => (others => '0'));

    signal increase_status : std_logic_vector(11 downto 0) := (others => '0');
    signal increase_status_buf1 : std_logic_vector(11 downto 0) := (others => '0');
    signal increase_status_buf2 : std_logic_vector(11 downto 0) := (others => '0');
    signal bins : bins := (others => (others => '0'));
    
    signal clock_read : std_logic_vector(11 downto 0) := (others => '0');
    signal read : std_logic_vector(11 downto 0) := (others => '0');
    signal written : std_logic_vector(11 downto 0) := (others => '0');
    
begin

spectra_memory_i: entity work.spectra_memory
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

--     spectrum_RAM_ii: entity work.spectrum_RAM
--        port map(
--            clka => clk,
--            clkb => bram_ctrl_clk,
--            addra => B"000000000000",
--            addrb => PS_addr(11 downto 0),
--            dina => B"00000000000000000000000000000110",
--            wea => '1',
--            ena => '1',
--            enb => '1',
--            doutb => PS_data
--        );

spectra_max_creators: for i in 0 to 3 generate spectrum_creator_ii: entity work.spectrum_creator
    generic map(
        type_of_spectrum => '1'
    )
    port map(
        clk => clk,
        status =>spectra_statuses(i+8),
        spectra_params => spectra_params(i+8),
        adc_data => adc_data(0),
        adc_data_valid => adc_data_valid,
        bin => bins(i+8),
        increase_status => increase_status(i+8)
    );
end generate;

spectra_point_creators: for i in 0 to 7 generate spectrum_creator_ii: entity work.spectrum_creator
    generic map(
        type_of_spectrum => '0'
    )
    port map(
        clk => clk,
        status => '1',--spectra_statuses(i),
        spectra_params => B"0100000000",--spectra_params(i),
        adc_data => adc_data(0),
        adc_data_valid => adc_data_valid,
        bin => bins(i),
        increase_status => increase_status(i)
    );
end generate;

--process(clk)     
--begin
--    if clk'event and clk='1' then
--        PL_addr(2) <= B"000000001000";
--        data_to_mem(2) <= B"00000000000000000000000000011110";
--        ena(2) <= '1';
--        wea(2) <= '1';
--    end if;
--end process;

--process(clk)                  --find active creator + read
--begin
--    if clk'event and clk='1' then
--        for i in 0 to 11 loop
--            if increase_status(i) = '1' then
--            --if adc_data_valid = '1' then
--                PL_addr(i) <= bins(i);--B"000000000000";--
--                ena(i) <= '1';
--                wea(i) <= '0';
--                read(i) <= '1';
--            elsif read(i) = '1' then                             --write if it necessary
--                PL_addr(i) <= bins(i);
--                data_to_mem(i) <=  std_logic_vector(unsigned(data_from_mem(i)) + 1);--B"00000000000000000000000000001110";--
--                ena(i) <= '1';
--                wea(i) <= '1';
--                read(i) <= '0';
--                clock_read(i) <= '0';
--                written(i) <= '1';
--            elsif written(i) = '1' then                           --set default status
--                ena(i) <= '1';
--                wea(i) <= '0';
--                read(i) <= '0';
--                written(i) <= '0';
--            end if;
--        end loop;
--    end if;
--end process;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
            increase_status_buf1(i) <= increase_status(i);
        end loop;
    end if;
end process;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
            increase_status_buf2(i) <= increase_status_buf1(i);
        end loop;
    end if;
end process;

process (clk)
begin
    if clk'event and clk='1' then
        for i in 0 to 11 loop
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


end Behavioral;
