vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/smartconnect_v1_0
vlib riviera/axi_protocol_checker_v2_0_3
vlib riviera/axi_vip_v1_1_3
vlib riviera/processing_system7_vip_v1_0_5
vlib riviera/work
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_12
vlib riviera/blk_mem_gen_v8_3_6
vlib riviera/axi_bram_ctrl_v4_0_14
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_register_slice_v2_1_17
vlib riviera/fifo_generator_v13_2_2
vlib riviera/axi_data_fifo_v2_1_16
vlib riviera/axi_crossbar_v2_1_18
vlib riviera/axi_protocol_converter_v2_1_17
vlib riviera/axi_clock_converter_v2_1_16
vlib riviera/blk_mem_gen_v8_4_1
vlib riviera/axi_dwidth_converter_v2_1_17

vmap xilinx_vip riviera/xilinx_vip
vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_protocol_checker_v2_0_3 riviera/axi_protocol_checker_v2_0_3
vmap axi_vip_v1_1_3 riviera/axi_vip_v1_1_3
vmap processing_system7_vip_v1_0_5 riviera/processing_system7_vip_v1_0_5
vmap work riviera/work
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_12 riviera/proc_sys_reset_v5_0_12
vmap blk_mem_gen_v8_3_6 riviera/blk_mem_gen_v8_3_6
vmap axi_bram_ctrl_v4_0_14 riviera/axi_bram_ctrl_v4_0_14
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_17 riviera/axi_register_slice_v2_1_17
vmap fifo_generator_v13_2_2 riviera/fifo_generator_v13_2_2
vmap axi_data_fifo_v2_1_16 riviera/axi_data_fifo_v2_1_16
vmap axi_crossbar_v2_1_18 riviera/axi_crossbar_v2_1_18
vmap axi_protocol_converter_v2_1_17 riviera/axi_protocol_converter_v2_1_17
vmap axi_clock_converter_v2_1_16 riviera/axi_clock_converter_v2_1_16
vmap blk_mem_gen_v8_4_1 riviera/blk_mem_gen_v8_4_1
vmap axi_dwidth_converter_v2_1_17 riviera/axi_dwidth_converter_v2_1_17

vlog -work xilinx_vip  -sv2k12 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/sc_util_v1_0_vl_rfs.sv" \

vlog -work axi_protocol_checker_v2_0_3  -sv2k12 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/03a9/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \

vlog -work axi_vip_v1_1_3  -sv2k12 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/b9a8/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_5  -sv2k12 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work work  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../bd/ps_topp/ip/ps_topp_processing_system7_0_0/sim/ps_topp_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work work -93 \
"../../../bd/ps_topp/ip/ps_topp_proc_sys_reset_0_1/sim/ps_topp_proc_sys_reset_0_1.vhd" \
"../../../bd/ps_topp/sim/ps_topp.vhd" \
"../../../bd/ps_topp/ipshared/afd5/hdl/ps_top_reg_interface_v1_0_S00_AXI.vhd" \
"../../../bd/ps_topp/ipshared/afd5/hdl/ps_top_reg_interface_v1_0.vhd" \
"../../../bd/ps_topp/ipshared/afd5/hdl/reg_inteface_v1_0.vhd" \
"../../../bd/ps_topp/ipshared/afd5/hdl/ps_top_ps_top_reg_interface_ip_0_0_0_0.vhd" \
"../../../bd/ps_topp/ip/ps_topp_ps_top_reg_interface_0_1/sim/ps_topp_ps_top_reg_interface_0_1.vhd" \

vlog -work blk_mem_gen_v8_3_6  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/2751/simulation/blk_mem_gen_v8_3.v" \

vcom -work axi_bram_ctrl_v4_0_14 -93 \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/6db1/hdl/axi_bram_ctrl_v4_0_rfs.vhd" \

vcom -work work -93 \
"../../../bd/ps_topp/ip/ps_topp_axi_bram_ctrl_0_0/sim/ps_topp_axi_bram_ctrl_0_0.vhd" \
"../../../bd/ps_topp/ip/ps_topp_axi_bram_ctrl_1_0/sim/ps_topp_axi_bram_ctrl_1_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_17  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/6020/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_2  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/7aff/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_2 -93 \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_2  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_16  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/247d/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_18  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/15a3/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../bd/ps_topp/ip/ps_topp_xbar_0/sim/ps_topp_xbar_0.v" \

vlog -work axi_protocol_converter_v2_1_17  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ccfb/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_16  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/e9a5/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_17  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/2839/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/verilog" "+incdir+../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl" "+incdir+/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/include" \
"../../../bd/ps_topp/ip/ps_topp_auto_ds_1/sim/ps_topp_auto_ds_1.v" \
"../../../bd/ps_topp/ip/ps_topp_auto_ds_0/sim/ps_topp_auto_ds_0.v" \
"../../../bd/ps_topp/ip/ps_topp_auto_pc_0/sim/ps_topp_auto_pc_0.v" \
"../../../bd/ps_topp/ip/ps_topp_auto_pc_1/sim/ps_topp_auto_pc_1.v" \
"../../../bd/ps_topp/ip/ps_topp_auto_us_0/sim/ps_topp_auto_us_0.v" \

vlog -work work \
"glbl.v"

