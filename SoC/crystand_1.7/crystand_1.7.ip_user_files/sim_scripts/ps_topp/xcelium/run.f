-makelib xcelium_lib/xilinx_vip -sv \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/5bb9/hdl/sc_util_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/axi_protocol_checker_v2_0_3 -sv \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/03a9/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_3 -sv \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/b9a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/processing_system7_vip_v1_0_5 -sv \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/70fd/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/work \
  "../../../bd/ps_topp/ip/ps_topp_processing_system7_0_0/sim/ps_topp_processing_system7_0_0.v" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_12 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/work \
  "../../../bd/ps_topp/ip/ps_topp_proc_sys_reset_0_1/sim/ps_topp_proc_sys_reset_0_1.vhd" \
  "../../../bd/ps_topp/sim/ps_topp.vhd" \
  "../../../bd/ps_topp/ipshared/afd5/hdl/ps_top_reg_interface_v1_0_S00_AXI.vhd" \
  "../../../bd/ps_topp/ipshared/afd5/hdl/ps_top_reg_interface_v1_0.vhd" \
  "../../../bd/ps_topp/ipshared/afd5/hdl/reg_inteface_v1_0.vhd" \
  "../../../bd/ps_topp/ipshared/afd5/hdl/ps_top_ps_top_reg_interface_ip_0_0_0_0.vhd" \
  "../../../bd/ps_topp/ip/ps_topp_ps_top_reg_interface_0_1/sim/ps_topp_ps_top_reg_interface_0_1.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_3_6 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/2751/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib xcelium_lib/axi_bram_ctrl_v4_0_14 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/6db1/hdl/axi_bram_ctrl_v4_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/work \
  "../../../bd/ps_topp/ip/ps_topp_axi_bram_ctrl_0_0/sim/ps_topp_axi_bram_ctrl_0_0.vhd" \
  "../../../bd/ps_topp/ip/ps_topp_axi_bram_ctrl_1_0/sim/ps_topp_axi_bram_ctrl_1_0.vhd" \
-endlib
-makelib xcelium_lib/generic_baseblocks_v2_1_0 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_register_slice_v2_1_17 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/6020/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_2 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/7aff/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_2 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_2 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/7aff/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/axi_data_fifo_v2_1_16 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/247d/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_crossbar_v2_1_18 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/15a3/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/work \
  "../../../bd/ps_topp/ip/ps_topp_xbar_0/sim/ps_topp_xbar_0.v" \
-endlib
-makelib xcelium_lib/axi_protocol_converter_v2_1_17 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/ccfb/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_clock_converter_v2_1_16 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/e9a5/hdl/axi_clock_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/axi_dwidth_converter_v2_1_17 \
  "../../../../crystand_1.7.srcs/sources_1/bd/ps_topp/ipshared/2839/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/work \
  "../../../bd/ps_topp/ip/ps_topp_auto_ds_1/sim/ps_topp_auto_ds_1.v" \
  "../../../bd/ps_topp/ip/ps_topp_auto_ds_0/sim/ps_topp_auto_ds_0.v" \
  "../../../bd/ps_topp/ip/ps_topp_auto_pc_0/sim/ps_topp_auto_pc_0.v" \
  "../../../bd/ps_topp/ip/ps_topp_auto_pc_1/sim/ps_topp_auto_pc_1.v" \
  "../../../bd/ps_topp/ip/ps_topp_auto_us_0/sim/ps_topp_auto_us_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

