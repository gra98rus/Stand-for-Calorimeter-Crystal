#set_property IOSTANDARD LVCMOS33 [get_ports UART_TX]
#set_property PACKAGE_PIN U5 [get_ports UART_TX]

#set_property IOSTANDARD LVCMOS33 [get_ports UART_RX]
#set_property PACKAGE_PIN V5 [get_ports UART_RX]

set_property IOSTANDARD LVCMOS33 [get_ports TP1]
set_property PACKAGE_PIN Y6 [get_ports TP1]

set_property IOSTANDARD LVCMOS33 [get_ports TP2]
set_property PACKAGE_PIN Y7 [get_ports TP2]

set_property IOSTANDARD LVCMOS33 [get_ports TP3]
set_property PACKAGE_PIN V7 [get_ports TP3]

set_property IOSTANDARD LVCMOS33 [get_ports TP4]
set_property PACKAGE_PIN Y8 [get_ports TP4]

set_property IOSTANDARD LVCMOS33 [get_ports TP5]
set_property PACKAGE_PIN Y9 [get_ports TP5]

set_property IOSTANDARD LVCMOS33 [get_ports TP6]
set_property PACKAGE_PIN Y11 [get_ports TP6]

set_property IOSTANDARD LVCMOS33 [get_ports TP7]
set_property PACKAGE_PIN W10 [get_ports TP7]

set_property IOSTANDARD LVCMOS33 [get_ports TP8]
set_property PACKAGE_PIN W9 [get_ports TP8]

set_property IOSTANDARD LVCMOS33 [get_ports JMP1]
set_property PACKAGE_PIN A20 [get_ports JMP1]

set_property IOSTANDARD LVCMOS33 [get_ports JMP2]
set_property PACKAGE_PIN B20 [get_ports JMP2]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_01]
set_property PACKAGE_PIN K19 [get_ports ALT_01]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_02]
set_property PACKAGE_PIN J18 [get_ports ALT_02]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_03]
set_property PACKAGE_PIN J19 [get_ports ALT_03]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_04]
set_property PACKAGE_PIN G19 [get_ports ALT_04]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_05]
set_property PACKAGE_PIN G18 [get_ports ALT_05]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_06]
set_property PACKAGE_PIN F19 [get_ports ALT_06]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_07]
set_property PACKAGE_PIN M14 [get_ports ALT_07]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_08]
set_property PACKAGE_PIN N15 [get_ports ALT_08]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_09]
set_property PACKAGE_PIN N16 [get_ports ALT_09]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_10]
set_property PACKAGE_PIN M15 [get_ports ALT_10]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_11]
set_property PACKAGE_PIN M17 [get_ports ALT_11]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_12]
set_property PACKAGE_PIN M18 [get_ports ALT_12]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_13]
set_property PACKAGE_PIN M19 [get_ports ALT_13]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_14]
set_property PACKAGE_PIN L17 [get_ports ALT_14]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_15]
set_property PACKAGE_PIN L19 [get_ports ALT_15]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_16]
set_property PACKAGE_PIN E19 [get_ports ALT_16]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_17]
set_property PACKAGE_PIN E18 [get_ports ALT_17]

set_property IOSTANDARD LVCMOS33 [get_ports ALT_18]
set_property PACKAGE_PIN D19 [get_ports ALT_18]

set_property IOSTANDARD LVDS_25 [get_ports ADC_D0C_P]
set_property PACKAGE_PIN Y18 [get_ports ADC_D0C_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D0B_P]
set_property PACKAGE_PIN W14 [get_ports ADC_D0B_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_FC0_P]
set_property PACKAGE_PIN Y16 [get_ports ADC_FC0_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D1B_P]
set_property PACKAGE_PIN V15 [get_ports ADC_D1B_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_CLK_P]
set_property PACKAGE_PIN N20 [get_ports ADC_CLK_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D1A_P]
set_property PACKAGE_PIN V12 [get_ports ADC_D1A_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D1C_P]
set_property PACKAGE_PIN W18 [get_ports ADC_D1C_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D0D_P]
set_property PACKAGE_PIN V20 [get_ports ADC_D0D_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_DC0_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D0A_P]
set_property PACKAGE_PIN T12 [get_ports ADC_D0A_P]
set_property IOSTANDARD LVDS_25 [get_ports ADC_D1D_P]
set_property PACKAGE_PIN T20 [get_ports ADC_D1D_P]

set_property BEL BUFR [get_cells pl_top_i/adc_deser_i/AdcClock_i/Gen_Bufr_Div_4.AdcClock_I_Bufr]
set_property LOC BUFR_X1Y4 [get_cells pl_top_i/adc_deser_i/AdcClock_i/Gen_Bufr_Div_4.AdcClock_I_Bufr]
set_property LOC U14 [get_cells pl_top_i/adc_deser_i/dclk_ibufgds]
set_property LOC BUFIO_X1Y7 [get_cells pl_top_i/adc_deser_i/AdcClock_i/AdcClock_I_Bufio]
set_property LOC ILOGIC_X1Y78 [get_cells pl_top_i/adc_deser_i/AdcClock_i/AdcClock_I_Isrds_Master]
set_property LOC IDELAY_X1Y78 [get_cells pl_top_i/adc_deser_i/AdcClock_i/AdcClock_I_Iodly]
set_property PACKAGE_PIN U14 [get_ports ADC_DC0_P]
set_property PACKAGE_PIN U15 [get_ports ADC_DC0_N]

set_property IOSTANDARD LVCMOS25 [get_ports SPI_CSB]
set_property PACKAGE_PIN V13 [get_ports SPI_CSB]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_SCLK]
set_property PACKAGE_PIN V18 [get_ports SPI_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports SPI_SDIO]
set_property PACKAGE_PIN W16 [get_ports SPI_SDIO]


set_property DIFF_TERM TRUE [get_ports ADC_D1B_P]
set_property DIFF_TERM TRUE [get_ports ADC_D1B_N]



set_property DIFF_TERM FALSE [get_ports ADC_CLK_P]
set_property DIFF_TERM FALSE [get_ports ADC_CLK_N]
