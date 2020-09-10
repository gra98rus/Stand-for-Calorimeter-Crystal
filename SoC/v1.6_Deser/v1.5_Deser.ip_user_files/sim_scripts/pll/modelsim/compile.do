vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/work

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap work modelsim_lib/msim/work

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work work -64 -incr "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../ip/pll/pll_clk_wiz.v" \
"../../../ip/pll/pll.v" \

vlog -work work \
"glbl.v"

