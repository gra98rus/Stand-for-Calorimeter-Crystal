onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib work ps_topp_opt

do {wave.do}

view wave
view structure
view signals

do {ps_topp.udo}

run -all

quit -force
