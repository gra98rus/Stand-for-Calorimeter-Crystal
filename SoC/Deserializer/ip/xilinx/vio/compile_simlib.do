puts "\n----------------> Compile VIO simulation resource library <----------------"

vlog -work simlib -incr -O5 -sv -mfcu \
    ${ip_name}/${ip_name}/sim/${ip_name}.v

puts "---------------------------------------------------------------------------\n"
exit

