#--------------------------------------------------------------------------------------------------
#	description:   template for single-clock single-port BRAM ip-core generation
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
	#puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
	create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name $ipCoreName -dir $ipCoreOutDir

	#---
	# CONFIG.Port_A_Clock      100
	set ipParams {
			CONFIG.Memory_Type       Single_Port_RAM	
			CONFIG.Algorithm         Minimum_Area
			CONFIG.Operating_Mode_A  WRITE_FIRST
			CONFIG.Pipeline_Stages   0
			CONFIG.Reset_Type        SYNC
			CONFIG.Enable_A          Use_ENA_Pin
		     }
	set_property -dict [subst $ipParams] [get_ips $ipCoreName]
}

#--------------------------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
	puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}



