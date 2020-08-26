#--------------------------------------------------------------------------------------------------
#	description:   template for pll ip-core generation
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
	#puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
	create_ip -name clk_wiz -vendor xilinx.com -library ip -module_name $ipCoreName -dir $ipCoreOutDir

	#---
	set ipParams {
			CONFIG.PRIMITIVE         MMCM
		     }
	set_property -dict [subst $ipParams] [get_ips $ipCoreName]
}

#--------------------------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
	puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}



