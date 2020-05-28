library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.new_types.all;

entity spectra_controller is
Port ( 
    clk            : in std_logic;
    spectrum_spec : in std_logic_vector(9 downto 0);
    spectra_commands : in std_logic_vector(11 downto 0);
    adc_data       : in adc_data_ltt;
    adc_data_valid : in std_logic


);
end spectra_controller;

architecture Behavioral of spectra_controller is

    signal spectra_params : spectrum_params := (others => (others => '0'));

begin

spectrum_creator_0max_i : entity work.spectrum_creator 
generic map(
    channel => "00",
    type_of_spectrum => '1'
)
port map(
    clk => clk,
    cmd =>spectra_commands(0),
    spectra_params => spectra_params(0),
    adc_data => adc_data(0),
    adc_data_valid => adc_data_valid
);

spectrum_creator_0point0_i : entity work.spectrum_creator 
generic map(
    channel => "00",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(1),
    spectra_params => spectra_params(1),
    adc_data => adc_data(0),
    adc_data_valid => adc_data_valid
);

spectrum_creator_0point1_i : entity work.spectrum_creator 
generic map(
    channel => "00",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(2),
    spectra_params => spectra_params(2),
    adc_data => adc_data(0),
    adc_data_valid => adc_data_valid
);

spectrum_creator_1max_i : entity work.spectrum_creator 
generic map(
    channel => "01",
    type_of_spectrum => '1'
)
port map(
    clk => clk,
    cmd =>spectra_commands(3),
    spectra_params => spectra_params(3),
    adc_data => adc_data(1),
    adc_data_valid => adc_data_valid
);

spectrum_creator_1point0_i : entity work.spectrum_creator 
generic map(
    channel => "01",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(4),
    spectra_params => spectra_params(4),
    adc_data => adc_data(1),
    adc_data_valid => adc_data_valid
);

spectrum_creator_1point1_i : entity work.spectrum_creator 
generic map(
    channel => "01",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(5),
    spectra_params => spectra_params(5),
    adc_data => adc_data(1),
    adc_data_valid => adc_data_valid
);

spectrum_creator_2max_i : entity work.spectrum_creator 
generic map(
    channel => "10",
    type_of_spectrum => '1'
)
port map(
    clk => clk,
    cmd =>spectra_commands(6),
    spectra_params => spectra_params(6),
    adc_data => adc_data(2),
    adc_data_valid => adc_data_valid
);

spectrum_creator_2point0_i : entity work.spectrum_creator 
generic map(
    channel => "10",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(7),
    spectra_params => spectra_params(7),
    adc_data => adc_data(2),
    adc_data_valid => adc_data_valid
);

spectrum_creator_2point1_i : entity work.spectrum_creator 
generic map(
    channel => "10",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(8),
    spectra_params => spectra_params(8),
    adc_data => adc_data(2),
    adc_data_valid => adc_data_valid
);

spectrum_creator_3max_i : entity work.spectrum_creator 
generic map(
    channel => "11",
    type_of_spectrum => '1'
)
port map(
    clk => clk,
    cmd =>spectra_commands(9),
    spectra_params => spectra_params(9),
    adc_data => adc_data(3),
    adc_data_valid => adc_data_valid
);

spectrum_creator_3point0_i : entity work.spectrum_creator 
generic map(
    channel => "11",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(10),
    spectra_params => spectra_params(10),
    adc_data => adc_data(3),
    adc_data_valid => adc_data_valid
);

spectrum_creator_3point1_i : entity work.spectrum_creator 
generic map(
    channel => "11",
    type_of_spectrum => '0'
)
port map(
    clk => clk,
    cmd =>spectra_commands(11),
    spectra_params => spectra_params(11),
    adc_data => adc_data(3),
    adc_data_valid => adc_data_valid
);

end Behavioral;
