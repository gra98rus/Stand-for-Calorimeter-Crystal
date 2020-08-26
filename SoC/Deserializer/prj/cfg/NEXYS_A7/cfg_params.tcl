#--------------------------------------------------------------------------------
#    project:       template project
#    cfg:           NEXYS_A7
#
#    description:   hardware platform for standalone template project
#--------------------------------------------------------------------------------

source ${SCRIPT_DIR}/helpers/param_utils.tcl

set config_params [list]

#--- global
defparam CLK_FREQ              100000000
defparam CLK_PERIOD            [expr 1000/([getparam CLK_FREQ]/1e6)]ns;        
defparam CLK_HALF_PERIOD       [expr 1000/([getparam CLK_FREQ]/1e6)/2]ns
#defparam DIFF_REFCLK           ""

defparam SYS_CLK               200
defparam LED_NUM               16
defparam RGB_NUM               2
defparam SEG7_NUM              8

#--------------------------------------------------------------------------------

