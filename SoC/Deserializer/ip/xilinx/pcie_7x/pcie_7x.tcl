#--------------------------------------------------------------------------------------------------
#   Description:   Template for 7 Series FPGA PCIe IP core generating
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
    puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
    create_ip -name pcie_7x -vendor xilinx.com -library ip -version 3.3 -module_name $ipCoreName -dir $ipCoreOutDir

    #---
    set ipParams {
        CONFIG.IntX_Generation         false
        CONFIG.Legacy_Interrupt        NONE
    }
    set_property -dict [subst $ipParams] [get_ips $ipCoreName]
}
#--------------------------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
    report_property [get_ips $ipCoreName]
    puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}
#--------------------------------------------------------------------------------------------------



