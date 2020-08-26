puts "\n----------------> Compile PLL simulation resource library <----------------"
vlog -work simlib -incr -O5 -sv -mfcu\
    ${ip_name}/${ip_name}/${ip_name}_sim_netlist.v\
    ${ip_name}/${ip_name}/simulation/blk_mem_gen_v8_4.v
puts "---------------------------------------------------------------------------\n"
exit

  