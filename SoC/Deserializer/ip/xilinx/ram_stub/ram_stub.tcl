#--------------------------------------------------------------------------------------------------
#	description:   template for BRAM ip-core generation
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
	#puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
	create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name $ipCoreName -dir $ipCoreOutDir

	set ipParams {
        CONFIG.INTERFACE_TYPE           Native
    }
	set_property -dict [subst $ipParams] [get_ips $ipCoreName]
}

#--------------------------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
	puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}



