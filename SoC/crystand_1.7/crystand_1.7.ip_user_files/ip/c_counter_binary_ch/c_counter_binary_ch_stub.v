// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Nov 19 22:37:33 2020
// Host        : aandreev-inp running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aandreev/pro/Stand-for-Calorimeter-Crystal/SoC/v1.7_Deser/crystand_1.7/crystand_1.7.runs/c_counter_binary_ch_synth_1/c_counter_binary_ch_stub.v
// Design      : c_counter_binary_ch
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_counter_binary_v12_0_12,Vivado 2018.2" *)
module c_counter_binary_ch(CLK, Q)
/* synthesis syn_black_box black_box_pad_pin="CLK,Q[9:0]" */;
  input CLK;
  output [9:0]Q;
endmodule
