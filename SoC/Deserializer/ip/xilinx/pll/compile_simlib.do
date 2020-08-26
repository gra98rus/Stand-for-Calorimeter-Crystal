puts "\n----------------> Compile PLL simulation resource library <----------------"
vlog -work simlib -incr -O5 -sv -mfcu ${ip_name}/${ip_name}/${ip_name}.v ${ip_name}/${ip_name}/${ip_name}_clk_wiz.v
puts "---------------------------------------------------------------------------\n"
exit

