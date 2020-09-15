onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_pl_top/ps_clk_50mhz
add wave -noupdate /tb_pl_top/pll_clk_p_100mhz
add wave -noupdate /tb_pl_top/reset
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_a
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_b
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_c
add wave -noupdate /tb_pl_top/pl_top_i/adc_data_d
add wave -noupdate /tb_pl_top/pl_top_i/dataIn_buf
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/adc_data_write
add wave -noupdate -expand -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/trigg_ena
add wave -noupdate -expand -group {Buffers block} -expand -group {Ring buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/addra_ring
add wave -noupdate -expand -group {Buffers block} -expand -group {Ring buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/dina_ring
add wave -noupdate -expand -group {Buffers block} -expand -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/read_ring_ena
add wave -noupdate -expand -group {Buffers block} -expand -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/addrb_ring
add wave -noupdate -expand -group {Buffers block} -expand -group {Ring buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/doutb_ring
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/addra_simple
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -expand -group {Port A} /tb_pl_top/pl_top_i/buffers_block_i/dina_simple
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/addrb_simple
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/read_simple_ena
add wave -noupdate -expand -group {Buffers block} -expand -group {Simple buffer} -expand -group {Port B} /tb_pl_top/pl_top_i/buffers_block_i/data_read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20290827967 fs} 0}
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
WaveRestoreZoom {6731564281 fs} {41750970302 fs}
