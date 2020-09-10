----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2019 10:37:09 AM
-- Design Name: 
-- Module Name: reg_ctrl - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.reg_map.all;

entity reg_ctrl is
port(
	clock   : in  std_logic;
	regWE   : in  std_logic;
	regNum  : in  std_logic_vector(31 downto 0);
	dataIn  : in  std_logic_vector(31 downto 0);
	
	dataOut : out std_logic_vector(31 downto 0);
	
	ctrl_reg     : out std_logic_vector (12 downto 0);
	channal      : out std_logic_vector (1 downto 0);
	ch_comp_data : out std_logic_vector (13 downto 0)
	);
	
end reg_ctrl;

architecture behavioral of reg_ctrl is

	signal data_out_r : std_logic_vector(31 downto 0) := (others=>'0');
	signal ch : std_logic_vector(31 downto 0) := (others=>'0');

	
	signal adc_ctrl_cmd_r : std_logic := '0';
	signal clk_gen_lock_r : std_logic := '0';
	signal Data_read_ena_r: std_logic := '0';
	signal start_type_r   : std_logic := '0';
	signal start_event_r  : std_logic := '0';
	signal channal_r      : std_logic_vector (1 downto 0) := b"00";
	signal ch_comp_data_r : std_logic_vector (13 downto 0) := (others=>'0');
	signal ALT_CT         : std_logic_vector (7 downto 0) := (others=>'0');
	
begin

process(clock)
begin
	if clock'event and clock='1' then
	
	    adc_ctrl_cmd_r <= '0';
	    start_event_r <= '0';
	    Data_read_ena_r <= '0';
	   
		if regWE='1' then
			data_out_r <= dataIn;
			ch(0)<='1';
		end if;
	----------------------------------------------------------------------------
	    if regNum = x"0000_0000" then
	        if regWE='1' and data_out_r(0)='1' then 
	            adc_ctrl_cmd_r <= '1';
	            ch(1)<='1';
	        end if;
	    end if;
	----------------------------------------------------------------------------
	    if regNum = x"0000_0001" then
            if regWE='1' and data_out_r(1)='1' then 
                clk_gen_lock_r <= '1';
                ch(2)<='1';
            elsif regWE='1' and data_out_r(1)='0' then
                clk_gen_lock_r <= '0';
                ch(3)<='1';
            end if;
       end if;
    ----------------------------------------------------------------------------
        if regNum = x"0000_0002" then
            if regWE='1' and data_out_r(2)='1' then 
                Data_read_ena_r <= '1';
                ch(4)<='1';
            --elsif regWE='1' and data_out_r(2)='0' then
            --    Data_read_ena_r <= '0';
            --    ch(5)<='1';
            end if;
        end if;
    ----------------------------------------------------------------------------
        if regNum = x"0000_0003" then
            if regWE='1' and data_out_r(3)='1' then 
                start_type_r <= '1';
                ch(6)<='1';
            elsif regWE='1' and data_out_r(3)='0' then
                start_type_r <= '0';
                ch(7)<='1';
            end if;
        end if;
    ----------------------------------------------------------------------------
	    if regNum = x"0000_0004" then
            if regWE='1' and data_out_r(4)='1' then 
                start_event_r <= '1';
                ch(8)<='1';
            end if;
        end if;
    ----------------------------------------------------------------------------
        if regNum = x"0000_0006" then
            if regWE='1' and data_out_r(6 downto 5)=b"00" then
                channal_r <= b"00";
            elsif regWE='1' and data_out_r(6 downto 5)=b"01" then
                channal_r <= b"01";
            elsif regWE='1' and data_out_r(6 downto 5)=b"10" then
                channal_r <= b"10";
            elsif regWE='1' and data_out_r(6 downto 5)=b"11" then
                channal_r <= b"11";
            end if;
        end if;
    ----------------------------------------------------------------------------
        if regNum = x"0000_0014" then
            if regWE='1' then
                ch_comp_data_r <= data_out_r(20 downto 7);
            end if;
        end if;
    ----------------------------------------------------------------------------    
        if regNum = x"0000_001C" then
            if regWE='1' then
                ALT_CT <= data_out_r(28 downto 21);
            end if;
        end if;
    ----------------------------------------------------------------------------
        if adc_ctrl_cmd_r = '1' then
            
        end if;
        
        if start_event_r = '1' then          
            ch(9)<='1';
        end if;
    ----------------------------------------------------------------------------        
	end if;
end process;
--------------------------------------------------------------------------------		
dataOut     <=  ch;
ctrl_reg(0) <= adc_ctrl_cmd_r;
ctrl_reg(1) <= clk_gen_lock_r;
ctrl_reg(2) <= Data_read_ena_r;
ctrl_reg(3) <= start_type_r;
ctrl_reg(4) <= start_event_r;
ctrl_reg(12 downto 5) <= ALT_CT;
channal <= channal_r;
ch_comp_data <= ch_comp_data_r;

end architecture;