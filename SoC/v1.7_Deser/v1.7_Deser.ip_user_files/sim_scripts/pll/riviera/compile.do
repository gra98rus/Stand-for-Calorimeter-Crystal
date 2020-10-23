vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/work

vmap xilinx_vip riviera/xilinx_vip
vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap work riviera/work

vlog -work xilinx_vip  -sv2k12 "+incdir+../../../ipstatic" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work work  -v2k5 "+incdir+../../../ipstatic" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../ip/pll/pll_clk_wiz.v" \
"../../../ip/pll/pll.v" \

vlog -work work \
"glbl.v"

