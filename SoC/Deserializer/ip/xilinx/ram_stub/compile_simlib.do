puts "\n----------------> Compile BRAM simulation resource library <----------------"
vlog -work simlib -incr -O5 -sv -mfcu\
    ${ip_name}/${ip_name}/sim/${ip_name}.v \
    ${ip_name}/ip_user_files/ipstatic/simulation/blk_mem_gen_v8_4.v
puts "---------------------------------------------------------------------------\n"
exit

  