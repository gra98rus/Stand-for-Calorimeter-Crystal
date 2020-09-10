vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/work

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap work riviera/work

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work work  -v2k5 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../ip/pll/pll_clk_wiz.v" \
"../../../ip/pll/pll.v" \

vlog -work work \
"glbl.v"

