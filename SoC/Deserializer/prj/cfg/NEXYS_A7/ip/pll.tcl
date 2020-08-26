#-------------------------------------------------------------------------------
#    project:       template project
#    IP core:       pll
#
#    cfg:           NEXUS_A7 
#
#    description:   hardware platform for standalone template project
#
#-------------------------------------------------------------------------------

set ip_type pll
set ip_name pll

#-------------------------------------------------------------------------------
if {[info exists env(XILINX)]} {

    source cfg_params.tcl
    source ${IP_LIB_DIR}/${ip_type}/${ip_type}.tcl
    
    #---------------------------------------------------------------------------
    proc ipInfo {} {
        return [dict create isSynth 1 isIp 1 isPacked 0]
    }
    
    #---------------------------------------------------------------------------
    proc ipUserCfg { ipCoreName ipCoreOutDir cfgDir } {
        puts "\[ipUserCfg\] $ipCoreName $ipCoreOutDir"

        global config_params

        set IN_CLK         [expr ([getparam CLK_FREQ]/1e6)]
        set SYS_CLK        [getparam SYS_CLK]
        
        if { [param_exists DIFF_REFCLK] } {
            set CFG_PRIM_SRC Differential_clock_capable_pin
        } else {
            set CFG_PRIM_SRC Single_ended_clock_capable_pin
        }
        
        puts "============== Parameters =============="
        puts "IN_CLK:                ${IN_CLK}"
        puts "SYS_CLK:               ${SYS_CLK}"
        puts "CFG_PRIM_SRC:          ${CFG_PRIM_SRC}"
        puts "========================================"
    
        set ipParams {
            CONFIG.PRIM_IN_FREQ                ${IN_CLK}

            CONFIG.CLKOUT1_USED                true
            CONFIG.CLKOUT1_REQUESTED_OUT_FREQ  ${SYS_CLK}

            CONFIG.USE_LOCKED                  true
            CONFIG.USE_RESET                   false
            CONFIG.PRIM_SOURCE                 ${CFG_PRIM_SRC}
            CONFIG.USE_SAFE_CLOCK_STARTUP      true
            #CONFIG.MMCM_COMPENSATION          ZHOLD
        }
        regsub -all {#.*?\n} $ipParams \n ipParams
        set_property -dict [subst $ipParams] [get_ips $ipCoreName]
        #report_property [get_ips $ipCoreName]
    }
    #---------------------------------------------------------------------------
}
if {[info exists env(MODEL_TECH)]} {
    
    source ${IP_LIB_DIR}/${ip_type}/compile_simlib.do
    
}
#-------------------------------------------------------------------------------

