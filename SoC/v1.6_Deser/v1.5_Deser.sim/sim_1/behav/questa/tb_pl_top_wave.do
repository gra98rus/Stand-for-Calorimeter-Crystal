onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_pl_top/ps_clk_50mhz
add wave -noupdate /tb_pl_top/pll_clk_p_100mhz
add wave -noupdate /tb_pl_top/reset
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/adc_data_write
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/data_read
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/read_ring_ena
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/read_simple_ena
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/simple_buffer_state
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/data_transfer_end
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/wea_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/web_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/ena_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/ring_data_out_observer
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/simple_data_out_observer
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/simple_buffer_state_s
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/dina_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/dinb_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/addra_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/addrb_ring
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/addra_simple
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/addrb_simple
add wave -noupdate -group {Buffers block} /tb_pl_top/pl_top_i/buffers_block_i/adc_data_read
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/addra
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/dina
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/wea
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/ena
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/douta
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/ram_data_a
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/addrb
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/dinb
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/web
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/enb
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/doutb
add wave -noupdate -expand -group {Ring buffer} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/ram_data_b
add wave -noupdate -expand -group {Ring buffer} -subitemconfig {/tb_pl_top/pl_top_i/buffers_block_i/ring_buf/mem(127) -expand} /tb_pl_top/pl_top_i/buffers_block_i/ring_buf/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29346321673 fs} 0}
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
WaveRestoreZoom {0 fs} {84185070365 fs}
