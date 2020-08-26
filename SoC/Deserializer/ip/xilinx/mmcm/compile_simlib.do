
puts "\n----------------> Compile MMCM simulation resource library <----------------"
vlog -work simlib -incr -O5 -sv -mfcu mmcm/mmcm/mmcm.v mmcm/mmcm/mmcm_clk_wiz.v
puts "---------------------------------------------------------------------------\n"
exit

