puts "\n----------------> Compile PLL simulation resource library <----------------"
# ${ip_name}/${ip_name}/${ip_name}_sim_netlist.v
vlog -work simlib -incr -O5 -sv -mfcu\
    ${ip_name}/${ip_name}/source/pcie_pipe_eq.v \
    ${ip_name}/${ip_name}/source/pcie_pipe_drp.v \
    ${ip_name}/${ip_name}/source/pcie_pipe_rate.v \
    ${ip_name}/${ip_name}/source/pcie_pipe_reset.v \
    ${ip_name}/${ip_name}/source/pcie_pipe_sync.v \
    ${ip_name}/${ip_name}/source/pcie_gtp_pipe_rate.v \
    ${ip_name}/${ip_name}/source/pcie_gtp_pipe_drp.v \
    ${ip_name}/${ip_name}/source/pcie_gtp_pipe_reset.v \
    ${ip_name}/${ip_name}/source/pcie_pipe_user.v \
    ${ip_name}/${ip_name}/source/pcie_pipe_wrapper.v \
    ${ip_name}/${ip_name}/source/pcie_qpll_drp.v \
    ${ip_name}/${ip_name}/source/pcie_qpll_reset.v \
    ${ip_name}/${ip_name}/source/pcie_qpll_wrapper.v \
    ${ip_name}/${ip_name}/source/pcie_rxeq_scan.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_top.v \
    ${ip_name}/${ip_name}/source/pcie_core_top.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_rx_null_gen.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_rx_pipeline.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_rx.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_top.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_tx_pipeline.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_tx_thrtl_ctl.v \
    ${ip_name}/${ip_name}/source/pcie_axi_basic_tx.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_7x.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_bram_7x.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_bram_top_7x.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_brams_7x.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_pipe_lane.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_pipe_misc.v \
    ${ip_name}/${ip_name}/source/pcie_pcie_pipe_pipeline.v \
    ${ip_name}/${ip_name}/source/pcie_gt_top.v \
    ${ip_name}/${ip_name}/source/pcie_gt_common.v \
    ${ip_name}/${ip_name}/source/pcie_gtp_cpllpd_ovrd.v \
    ${ip_name}/${ip_name}/source/pcie_gtx_cpllpd_ovrd.v \
    ${ip_name}/${ip_name}/source/pcie_gt_rx_valid_filter_7x.v \
    ${ip_name}/${ip_name}/source/pcie_gt_wrapper.v \
    ${ip_name}/${ip_name}/source/pcie_pcie2_top.v \
    ${ip_name}/${ip_name}/sim/pcie.v

puts "---------------------------------------------------------------------------\n"
exit

  