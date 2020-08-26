#--------------------------------------------------------------------------------------------------
#   description:   template for VIO ip-core generation
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
    #puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
    create_ip -name vio -vendor xilinx.com -library ip  -module_name $ipCoreName -dir $ipCoreOutDir
}

#--------------------------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
    puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}
