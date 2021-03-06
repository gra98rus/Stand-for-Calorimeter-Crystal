######################################################################
#
# File name : tb_pl_top_simulate.do
# Created on: Fri Jul 09 10:17:13 +07 2021
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -lib work tb_pl_top_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {tb_pl_top_wave.do}

view wave
view structure
view signals

do {tb_pl_top.udo}

run 1000ns
