######################################################################
#
# File name : tb_pl_top_compile.do
# Created on: Thu Sep 24 19:27:52 +07 2020
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/work

vmap work questa_lib/msim/work

vcom -64 -93 -work work  \
"../../../../v1.5_Deser.ip_user_files/ip/c_counter_binary_ch/sim/c_counter_binary_ch.vhd" \

vlog -64 -incr -work work  "+incdir+../../../../v1.5_Deser.srcs/sources_1/ip/pll" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_processing_system7_0_0/sim/ps_topp_processing_system7_0_0.v" \

vcom -64 -93 -work work  \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_axi_bram_ctrl_0_0/sim/ps_topp_axi_bram_ctrl_0_0.vhd" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_axi_bram_ctrl_1_0/sim/ps_topp_axi_bram_ctrl_1_0.vhd" \

vlog -64 -incr -work work  "+incdir+../../../../v1.5_Deser.srcs/sources_1/ip/pll" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_xbar_0/sim/ps_topp_xbar_0.v" \

vcom -64 -93 -work work  \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ipshared/afd5/hdl/ps_top_reg_interface_v1_0_S00_AXI.vhd" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ipshared/afd5/hdl/ps_top_reg_interface_v1_0.vhd" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ipshared/afd5/hdl/reg_inteface_v1_0.vhd" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ipshared/afd5/hdl/ps_top_ps_top_reg_interface_ip_0_0_0_0.vhd" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_ps_top_reg_interface_0_1/sim/ps_topp_ps_top_reg_interface_0_1.vhd" \

vlog -64 -incr -work work  "+incdir+../../../../v1.5_Deser.srcs/sources_1/ip/pll" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../v1.5_Deser.ip_user_files/ip/pll/pll_clk_wiz.v" \
"../../../../v1.5_Deser.ip_user_files/ip/pll/pll.v" \

vcom -64 -93 -work work  \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_proc_sys_reset_0_1/sim/ps_topp_proc_sys_reset_0_1.vhd" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/sim/ps_topp.vhd" \

vlog -64 -incr -work work  "+incdir+../../../../v1.5_Deser.srcs/sources_1/ip/pll" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../v1.5_Deser.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_auto_ds_1/sim/ps_topp_auto_ds_1.v" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_auto_ds_0/sim/ps_topp_auto_ds_0.v" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_auto_pc_0/sim/ps_topp_auto_pc_0.v" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_auto_pc_1/sim/ps_topp_auto_pc_1.v" \
"../../../../v1.5_Deser.ip_user_files/bd/ps_topp/ip/ps_topp_auto_us_0/sim/ps_topp_auto_us_0.v" \

vcom -64 -93 -work work  \
"../../../../v1.5_Deser.srcs/sources_1/new/new_types.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/Spectra_memory.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/Spectrum_creator.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/Spectra_controller.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/threshold_comparator.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/reg_map.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/reg_file.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/sources_1/import/main/AdcClock.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/sources_1/import/main/AdcData.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/sources_1/import/main/DoubleNibbleDetect.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/sources_1/import/main/Fdcr.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/sources_1/import/main/GenPulse.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/sources_1/import/main/AdcFrame.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/Memory.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/adc_deser.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/buffers_block.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/infrastructure_top.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/trigg_system.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/new/shaper_controller.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/new/pl_top.vhd" \
"../../../../v1.5_Deser.srcs/sources_1/imports/hdl/crystand_top.vhd" \
"../../../../v1.5_Deser.srcs/sim_1/imports/new/tb_adc.vhd" \
"../../../../v1.5_Deser.srcs/sim_1/new/tb_pl_top.vhd" \

# compile glbl module
vlog -work work "glbl.v"

