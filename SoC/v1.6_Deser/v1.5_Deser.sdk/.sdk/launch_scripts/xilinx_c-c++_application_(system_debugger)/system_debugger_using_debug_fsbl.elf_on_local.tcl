connect -url tcp:127.0.0.1:3121
source /home/zhulanov/projects/crystand/hardware/adc_stand/v1.0/firmware/v1.0/crystand_hw1_0_fw1_0.sdk/crystand_top_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB II 00001876cb7901"} -index 0
loadhw /home/zhulanov/projects/crystand/hardware/adc_stand/v1.0/firmware/v1.0/crystand_hw1_0_fw1_0.sdk/crystand_top_hw_platform_0/system.hdf
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB II 00001876cb7901"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Platform Cable USB II 00001876cb7901"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Platform Cable USB II 00001876cb7901"} -index 0
dow /home/zhulanov/projects/crystand/hardware/adc_stand/v1.0/firmware/v1.0/crystand_hw1_0_fw1_0.sdk/fsbl/Debug/fsbl.elf
bpadd -addr &main
