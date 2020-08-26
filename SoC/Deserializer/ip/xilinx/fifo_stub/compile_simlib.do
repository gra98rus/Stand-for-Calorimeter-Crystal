puts "\n----------------> Compile PLL simulation resource library <----------------"
vlog -work simlib -incr -O5 -sv -mfcu\
    ${ip_name}/${ip_name}/${ip_name}_sim_netlist.v\
    ${ip_name}/${ip_name}/simulation/fifo_generator_vlog_beh.v
puts "---------------------------------------------------------------------------\n"
exit

  