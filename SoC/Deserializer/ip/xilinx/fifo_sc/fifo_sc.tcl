#--------------------------------------------------------------------------------------------------
#   description:   template for single-clock FIFO ip-core generation
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------------------
proc ipCfgPrologue { ipCoreName ipCoreOutDir } {
    puts "\[ipCfgPrologue\] $ipCoreName $ipCoreOutDir"
    create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name $ipCoreName -dir $ipCoreOutDir

    #---
    set ipParams {
            CONFIG.Fifo_Implementation      Common_Clock_Block_RAM
            CONFIG.INTERFACE_TYPE           Native  
             }
    report_property [get_ips $ipCoreName]
    set_property -dict [subst $ipParams] [get_ips $ipCoreName]
}

#--------------------------------------------------------------------------------------------------
proc ipCfgEpilogue { ipCoreName ipCoreOutDir } {
    # !!! if these parameters set up at ipCfgPrologue than are not set at end of init - possible Xilinx bug
    set ipParams {
            CONFIG.Performance_Options      First_Word_Fall_Through
            CONFIG.Use_Embedded_Registers   true
            CONFIG.Data_Count               true
            CONFIG.Reset_Pin                true
            CONFIG.Reset_Type               Synchronous_Reset
            CONFIG.use_dout_register        {false}
            CONFIG.Use_Dout_Reset           {false}
             }
    set_property -dict [subst $ipParams] [get_ips $ipCoreName]
    report_property [get_ips $ipCoreName]
    puts "\[ipCfgEpilogue\] $ipCoreName $ipCoreOutDir"
}



