onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_pl_top/ps_clk_50mhz
add wave -noupdate /tb_pl_top/pll_clk_p_100mhz
add wave -noupdate /tb_pl_top/reset
add wave -noupdate -radix decimal -radixshowbase 0 /tb_pl_top/pl_top_i/adc_data_a
add wave -noupdate -radix hexadecimal -radixshowbase 0 /tb_pl_top/pl_top_i/adc_data_b
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_c
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_d
add wave -noupdate /tb_pl_top/pl_top_i/dataIn_buf
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/adc_data_write
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/addra_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/dina_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/addrb_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/doutb_ring
add wave -noupdate -expand -group {Buffers block} -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/mem
add wave -noupdate -expand -group {Buffers block} -group {Simple buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/addra_simple
add wave -noupdate -expand -group {Buffers block} -group {Simple buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/addrb_simple
add wave -noupdate -expand -group {Buffers block} -group {Simple buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/read_simple_ena
add wave -noupdate -expand -group {Buffers block} -group {Simple buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/data_read
add wave -noupdate -expand -group {Buffers block} -group {Simple buffer} /tb_pl_top/pl_top_i/buffers_block_i/simple_buf/mem
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/state
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {41193514047 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 366
configure wave -valuecolwidth 100
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
WaveRestoreZoom {1375321892 fs} {129150846607 fs}
