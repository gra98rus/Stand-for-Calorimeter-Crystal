#-------------------------------------------------------------------------------
#    project:       RISC-V
#    cfg:           NEXYS_A7
#
#    description:   single cycled RISC-V processor
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# REF_DIR    - top level dir (attention please!)
#-------------------------------------------------------------------------------

DEVICE         := xc7a100tcsg324-1
TOP_NAME       := pl_top
TBENCH_NAME    := hw_standalone_tb

CFG_DIR        := $(CURDIR)
REF_DIR        := ../../..
LIB_DIR        := $(REF_DIR)/lib
SRC_DIR        := ../../src
CFG_IP_DIR     := $(CFG_DIR)/ip

SIM_WLIB_NAME  := wlib

#-------------------------------------------------------------------------------
#
#    Synthesis
#
#-----------------------------------------------------------
#
#    Sources
#
#INC := $(SRC_DIR)/params.svh

SRC := $(SRC_DIR)/crystand_top.vhd	          			\
	   $(SRC_DIR)/ps_top.vhd			     			\
	   $(SRC_DIR)/pl_top.vhd			     			\
	   $(SRC_DIR)/Deserializer/AdcData.vhd     			\
	   $(SRC_DIR)/Deserializer/AdcClock.vhd    			\
	   $(SRC_DIR)/Deserializer/AdcFrame.vhd    			\
	   $(SRC_DIR)/Deserializer/DoubleNibbleDetect.vhd	\
	   $(SRC_DIR)/Deserializer/GenPulse.vhd    			\
	   $(SRC_DIR)/Deserializer/Fdcr.vhd 	   			\
	   $(SRC_DIR)/Elements/adc_deser.vhd   				\
	   $(SRC_DIR)/Elements/bound_comparator.vhd			\
	   $(SRC_DIR)/Elements/buffers_block.vhd			\
	   $(SRC_DIR)/Elements/infrastructure_top.vhd		\
	   $(SRC_DIR)/Elements/new_types.vhd	   			\
	   $(SRC_DIR)/Elements/reg_ctrl.vhd		   			\
	   $(SRC_DIR)/Elements/reg_map.vhd	    			\
	   $(SRC_DIR)/Elements/shaper_controller.vhd		\
	   $(SRC_DIR)/Elements/trigg_system.vhd			

#-----------------------------------------------------------
#
#    Constraints
#
SDC := nexys_a7.sdc \
       nexys_a7.xdc

#-----------------------------------------------------------
#
#    IP cores
#
CFG_IP := pll        

#-----------------------------------------------------------
#
#    Target hardware
#
TRG_BOARD  := "Digilent/210292AD326AA"
TRG_DEVICE := "xc7a100t_0"

#-------------------------------------------------------------------------------
#
#    Simulator
#
#-----------------------------------------------------------
#
#    Sources
#
SRC_SIM := $(SRC)\
           $(SRC_DIR)/sim/func/hw_standalone_tb.sv

SIM_INC_DIRS := $(CFG_DIR) $(SRC_DIR) $(LIB_DIR)

#-----------------------------------------------------------
#
#    Options
#
VLOG_FLAGS := -O5 -ccflags "-std=c++14" -ccflags "-Wall" -ccflags "-Wpedantic"
VOPT_FLAGS := -O5 -L unifast_ver -L unisims_ver 

#-------------------------------------------------------------------------------

include $(REF_DIR)/script/xilinx.mk

#-------------------------------------------------------------------------------

