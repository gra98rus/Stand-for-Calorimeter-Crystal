onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib work c_counter_binary_ch_opt

do {wave.do}

view wave
view structure
view signals

do {c_counter_binary_ch.udo}

run -all

quit -force
