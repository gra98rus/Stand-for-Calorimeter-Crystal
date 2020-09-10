vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/work
vlib questa_lib/msim/xil_defaultlib

vmap work questa_lib/msim/work
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work work -64 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../ip/pll/pll_clk_wiz.v" \
"../../../ip/pll/pll.v" \


vlog -work work \
"glbl.v"

