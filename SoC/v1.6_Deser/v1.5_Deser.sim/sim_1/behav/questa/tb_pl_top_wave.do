onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_pl_top/ps_clk_50mhz
add wave -noupdate /tb_pl_top/pll_clk_p_100mhz
add wave -noupdate /tb_pl_top/reset
add wave -noupdate /tb_pl_top/pl_top_i/infrastructure_top_i/rst_sys/int_rst
add wave -noupdate -radix hexadecimal -childformat {{/tb_pl_top/pl_top_i/adc_data_a(15) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(14) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(13) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(12) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(11) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(10) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(9) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(8) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(7) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(6) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(5) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(4) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(3) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(2) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(1) -radix decimal} {/tb_pl_top/pl_top_i/adc_data_a(0) -radix decimal}} -radixshowbase 0 -subitemconfig {/tb_pl_top/pl_top_i/adc_data_a(15) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(14) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(13) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(12) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(11) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(10) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(9) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(8) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(7) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(6) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(5) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(4) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(3) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(2) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(1) {-height 17 -radix decimal -radixshowbase 0} /tb_pl_top/pl_top_i/adc_data_a(0) {-height 17 -radix decimal -radixshowbase 0}} /tb_pl_top/pl_top_i/adc_data_a
add wave -noupdate -radix hexadecimal -radixshowbase 0 /tb_pl_top/pl_top_i/adc_data_b
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_c
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_d
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/adc_data_write
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/addra_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/dina_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/addrb_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/doutb_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/mem
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/addra_simple
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/write_simple_ena
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -group {Port Spectra} /tb_pl_top/pl_top_i/buffers_block_i/simple_addr_spectra
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -group {Port Spectra} /tb_pl_top/pl_top_i/buffers_block_i/simple_dout_spectra
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} /tb_pl_top/pl_top_i/buffers_block_i/simple_buf/mem
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/state
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/max_value
add wave -noupdate -expand -group {Trigger system} /tb_pl_top/pl_top_i/trigg_system_i/rst
add wave -noupdate -expand -group {Trigger system} /tb_pl_top/pl_top_i/trigg_system_i/start_type
add wave -noupdate -expand -group {Trigger system} /tb_pl_top/pl_top_i/trigg_system_i/start_event
add wave -noupdate -expand -group {Trigger system} /tb_pl_top/pl_top_i/trigg_system_i/threshold_pass
add wave -noupdate -expand -group {Trigger system} /tb_pl_top/pl_top_i/trigg_system_i/trigg_signal
add wave -noupdate -expand -group {Trigger system} /tb_pl_top/pl_top_i/trigg_system_i/state
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/adc_buf_data
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_to_compare
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/threshold_pass
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_ch_A
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_ch_B
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_ch_C
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_ch_D
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_tc_A
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_tc_B
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_tc_C
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/data_tc_D
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/compareA
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/compareB
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/compareC
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/compareD
add wave -noupdate -group {Threshold comparator} /tb_pl_top/pl_top_i/threshold_comparator_i/selected_channels
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/spectra_statuses
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/adc_data_valid
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/spectra_params
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/num_of_bins
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/selected_point
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/count
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/state
add wave -noupdate -group {Spectra controller} /tb_pl_top/pl_top_i/spectra_controller_i/relevant_adc
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/data_ready
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/start_event
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/trigger_type
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/trigger_level
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/selected_channels
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/shapers_config
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/spectrum_spec
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/data_out_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/echo_reg_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/reg_echo_ena_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/start_event_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/start_event_delay
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/start_event_result
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/trigger_type_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/trigger_level_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/selected_channels_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/shapers_config_r
add wave -noupdate -group reg_i /tb_pl_top/pl_top_i/reg_i/data_status
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11330000000 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 341
configure wave -valuecolwidth 136
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 fs} {69873257036 fs}
