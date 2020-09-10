-makelib ies_lib/xil_defaultlib -sv \
  "/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "/opt/cad/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/work \
  "../../../ip/pll/pll_clk_wiz.v" \
  "../../../ip/pll/pll.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

