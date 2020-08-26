#-------------------------------------------------------------------------------
#    project:       template project
#    cfg:           NEXYS_A7
#
#    description:   hardware platform for standalone template project
#-------------------------------------------------------------------------------

puts ""
puts "========================================================================="
puts "prologue.tcl"
puts "========================================================================="

#-----------------------------------
set prologue_debug 1
if {$prologue_debug == 1} {
        puts ""
        puts "--- common part ---"
        puts "PWD:              [pwd]"
        puts "SCRIPT_DIR:       $SCRIPT_DIR"
        puts "SRC_DIR:          $SRC_DIR"
        puts "TOP_NAME:         $TOP_NAME"
#       puts "BUILD_TOOL:       $BUILD_TOOL"
        
        if {[info exists env(XILINX)]} {
                puts ""
                puts "--- Vivado part ---"
                puts "OUT_CFG_DIR:      $OUT_CFG_DIR"
                puts "TARGET_FILE_NAME: $TARGET_FILE_NAME"
                puts "DEVICE:           $DEVICE"
                puts "LIB_DIR:          $LIB_DIR"
        }
        if {[info exists env(MODEL_TECH)]} {
                puts ""
                puts "--- Questa part ---"
                puts "IncDirs:         $IncDirs"
                puts "SrcDirs:         $SrcDirs"
        }
}

puts ""
puts "========================================================================="
puts ""

#--------------------------------------------------------------------------------
