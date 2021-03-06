--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Sun Jul  4 14:32:08 2021
--Host        : deva2 running 64-bit Ubuntu 18.04.5 LTS
--Command     : generate_target ps_topp_wrapper.bd
--Design      : ps_topp_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ps_topp_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
    OSCILLOGRAMS_BRAM_PORTA_clk : out STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_din : out STD_LOGIC_VECTOR ( 63 downto 0 );
    OSCILLOGRAMS_BRAM_PORTA_dout : in STD_LOGIC_VECTOR ( 63 downto 0 );
    OSCILLOGRAMS_BRAM_PORTA_en : out STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_rst : out STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_we : out STD_LOGIC_VECTOR ( 7 downto 0 );
    SPECTRA_BRAM_PORTA_addr : out STD_LOGIC_VECTOR ( 17 downto 0 );
    SPECTRA_BRAM_PORTA_clk : out STD_LOGIC;
    SPECTRA_BRAM_PORTA_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    SPECTRA_BRAM_PORTA_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SPECTRA_BRAM_PORTA_en : out STD_LOGIC;
    SPECTRA_BRAM_PORTA_rst : out STD_LOGIC;
    SPECTRA_BRAM_PORTA_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    dataIn : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dataOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    regNum : out STD_LOGIC_VECTOR ( 31 downto 0 );
    regWE : out STD_LOGIC;
    reset : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end ps_topp_wrapper;

architecture STRUCTURE of ps_topp_wrapper is
  component ps_topp is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
    OSCILLOGRAMS_BRAM_PORTA_clk : out STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_din : out STD_LOGIC_VECTOR ( 63 downto 0 );
    OSCILLOGRAMS_BRAM_PORTA_dout : in STD_LOGIC_VECTOR ( 63 downto 0 );
    OSCILLOGRAMS_BRAM_PORTA_en : out STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_rst : out STD_LOGIC;
    OSCILLOGRAMS_BRAM_PORTA_we : out STD_LOGIC_VECTOR ( 7 downto 0 );
    SPECTRA_BRAM_PORTA_addr : out STD_LOGIC_VECTOR ( 17 downto 0 );
    SPECTRA_BRAM_PORTA_clk : out STD_LOGIC;
    SPECTRA_BRAM_PORTA_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    SPECTRA_BRAM_PORTA_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SPECTRA_BRAM_PORTA_en : out STD_LOGIC;
    SPECTRA_BRAM_PORTA_rst : out STD_LOGIC;
    SPECTRA_BRAM_PORTA_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    UART_txd : out STD_LOGIC;
    UART_rxd : in STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    regWE : out STD_LOGIC;
    regNum : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dataOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    dataIn : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component ps_topp;
begin
ps_topp_i: component ps_topp
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FCLK_CLK0 => FCLK_CLK0,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      OSCILLOGRAMS_BRAM_PORTA_addr(11 downto 0) => OSCILLOGRAMS_BRAM_PORTA_addr(11 downto 0),
      OSCILLOGRAMS_BRAM_PORTA_clk => OSCILLOGRAMS_BRAM_PORTA_clk,
      OSCILLOGRAMS_BRAM_PORTA_din(63 downto 0) => OSCILLOGRAMS_BRAM_PORTA_din(63 downto 0),
      OSCILLOGRAMS_BRAM_PORTA_dout(63 downto 0) => OSCILLOGRAMS_BRAM_PORTA_dout(63 downto 0),
      OSCILLOGRAMS_BRAM_PORTA_en => OSCILLOGRAMS_BRAM_PORTA_en,
      OSCILLOGRAMS_BRAM_PORTA_rst => OSCILLOGRAMS_BRAM_PORTA_rst,
      OSCILLOGRAMS_BRAM_PORTA_we(7 downto 0) => OSCILLOGRAMS_BRAM_PORTA_we(7 downto 0),
      SPECTRA_BRAM_PORTA_addr(17 downto 0) => SPECTRA_BRAM_PORTA_addr(17 downto 0),
      SPECTRA_BRAM_PORTA_clk => SPECTRA_BRAM_PORTA_clk,
      SPECTRA_BRAM_PORTA_din(31 downto 0) => SPECTRA_BRAM_PORTA_din(31 downto 0),
      SPECTRA_BRAM_PORTA_dout(31 downto 0) => SPECTRA_BRAM_PORTA_dout(31 downto 0),
      SPECTRA_BRAM_PORTA_en => SPECTRA_BRAM_PORTA_en,
      SPECTRA_BRAM_PORTA_rst => SPECTRA_BRAM_PORTA_rst,
      SPECTRA_BRAM_PORTA_we(3 downto 0) => SPECTRA_BRAM_PORTA_we(3 downto 0),
      UART_rxd => UART_rxd,
      UART_txd => UART_txd,
      dataIn(31 downto 0) => dataIn(31 downto 0),
      dataOut(31 downto 0) => dataOut(31 downto 0),
      regNum(31 downto 0) => regNum(31 downto 0),
      regWE => regWE,
      reset(0) => reset(0)
    );
end STRUCTURE;
