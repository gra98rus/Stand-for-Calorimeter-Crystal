#--------------------------------------------------------------------------------
#   description:   stub for FIFO IP core generating
#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
    puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
    create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name $ipCoreName -dir $ipCoreOutDir

    #---
    set ipParams {
        CONFIG.INTERFACE_TYPE           Native  
    }
    report_property [get_ips $ipCoreName]
    set_property -dict [subst $ipParams] [get_ips $ipCoreName]
}
#--------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
    report_property [get_ips $ipCoreName]
    puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}



