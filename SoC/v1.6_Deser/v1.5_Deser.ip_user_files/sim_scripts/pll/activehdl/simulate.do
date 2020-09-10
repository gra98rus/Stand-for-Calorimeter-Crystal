onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+pll -L xil_defaultlib -L xpm -L work -L unisims_ver -L unimacro_ver -L secureip -O5 work.pll work.glbl

do {wave.do}

view wave
view structure

do {pll.udo}

run -all

endsim

quit -force
