// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Oct 22 17:22:08 2020
// Host        : aandreev-inp running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aandreev/pro/Stand-for-Calorimeter-Crystal/SoC/v1.6_Deser/v1.5_Deser.runs/c_counter_binary_ch_synth_1/c_counter_binary_ch_sim_netlist.v
// Design      : c_counter_binary_ch
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_counter_binary_ch,c_counter_binary_v12_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_12,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module c_counter_binary_ch
   (CLK,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [9:0]Q;

  wire CLK;
  wire [9:0]Q;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "10" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "0" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "0" *) 
  (* c_thresh0_value = "1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_counter_binary_ch_c_counter_binary_v12_0_12 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "0" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "10" *) 
(* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "c_counter_binary_v12_0_12" *) (* downgradeipidentifiedwarnings = "yes" *) 
module c_counter_binary_ch_c_counter_binary_v12_0_12
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [9:0]L;
  output THRESH0;
  output [9:0]Q;

  wire \<const1> ;
  wire CLK;
  wire [9:0]Q;
  wire NLW_i_synth_THRESH0_UNCONNECTED;

  assign THRESH0 = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "10" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "0" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "0" *) 
  (* c_thresh0_value = "1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_counter_binary_ch_c_counter_binary_v12_0_12_viv i_synth
       (.CE(1'b0),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_i_synth_THRESH0_UNCONNECTED),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
RhedCTftnR/lFLJouqVu00X8CC4TkDlMiW/WeWJSYDyQHVO1xW1z9+hmgAziXI4s3uGElBs9cXRS
4yVMV7QH0w==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
qX90FYlZfOA3sZpcv0rrvWRKCSlr3skWpeAe5OSxHcZPsVQFyY0hhWVDtP/vB+dV9hIUwAN29Fn9
+L9OEXYMlIw5gH6s9NmquAs3lmPRLTrrpKJWdvf6+b+LeG9CPwLz87bXAk4qQW80zUHBaDKDLV3q
pd/gEf8Y3st+mLOGjNU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
chpH3Rj5RAirYZHkpJvTu4EJpydPPSy15v646y2lN/1w3bwHI+M8EpLMBjimx8uIWRJZ6dDWPR8E
zkwK1TMroEKFaL8IkFMSHPyzqbrH9l1jxYFs0ee8Itp8Rg8qenv5RXM+h4JRTtRmzHk1A8s8zeKY
MgXzIBCAzBa/vSgzDuDaUnO8r8f/5KtRjmE28JLNXXAxyijBrMTCiIHMRJZL5/+LgUyVq7/Zr5yx
7kuNGWv7Q0wESEqhsQbK6UNel5ak1cor7647dYJgIxnNZ6jGVJPkqi8ydAIZ0z0Dy4txBvVaMyP6
2kYYnbVN6S6q6yr/QcJHEOgefF59B/8JuWzdoQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Z2XauOF3/9FUIv1kEFfEtdy93+zHY5q9dH1pJCNLytoWWhhJBfCI5Uc2w/fQLrvVw2Ivy0/rs9qH
9fomTNECWeCphNDVpWGNcFDGE51jt6SDWt7FmgfZq4iXN7XWrfmkQa4DB7QbtSBHCMcBT53TKbDH
suKNhAWMV0htWeNEgN4Y0biiz8U4RLT1stdsMMtEzfYVhtrTmFWLihJ/9gJ01pm/kv4OB2cJEslg
sjbxCE2B4Y1uSj93tnBAw4/f2RYGfPcSrkaXkNgOYK2dc5NQgd82XvP8siAK/ETcZQ1lBK367Rxv
nlr6QUMwKALmjLVe/IThpCRGbOSy3QykkwnpHw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
F/mF2RV90mf5PFUZZUjMej6jQS+Qx16uCeiDQxUX+H+O2yjP6UECegDbtLmGk9algbDuGBCE0KgZ
HzSxX5pMwDq1J7nFyBsu1dGyu8NeJxfu0fFA/qS/SYJSTtwnZ/eIj09mNLJ3w8wGR87ke1ETTRpx
4Ni9DzGJ/aaWFaUenL/x4UWS9yqlaNi5Utcpa4kcUHC6fW0asZsThZJBqpArO54TF40nxZAD+V82
6mBGFOKUzgmHqXNsbVif4JqUd63LG8YWxjrOeesq61xzyjw9caQMuA9v/5sQslCFaeSt2atgqyaA
y4mcm0kU60s6mYqJr4KZt8DWG7LPGoIjhjpnMg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YNrNxIZl8p2OCPz+4Y4awQ09ZZ41X8EdKu2SX1gXfB3qoV3EOXf4eFHtYJ+bFIccfEIqPfZ+dnr7
udcSDAJMcxqZe+YNk5hTq+uX4PlnQH/IVlkgyYiDhQ7aRIS5pwtIRC3biXn80933ov4zlWLI+ZBq
bG8lodZjxKh6HZPWi7s=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eWToRZf4bzAQhHTj44yEkOqolJ3BOvlBPKnKoDCpSvCHSrnRcJKgOd47PnboABTqLVstQenz8AFe
rWHBbaad7KOIh3LsEXBwDHKDdby7iDAB5nd3j2Wp7qiHOv7WpIJ5RG1GMQa8+QXHMVaV4jSvsdmt
d0D9H0WEVaqrSFW2ucpsMYNE0LnKcSJ1SejKOcgISzaGJgXcmEAOVAOnCDPc4slwc3dt7Jne1KvY
i66An36Mfhhd1b0RikMf4yqpM+uVrL5XWIP+TBtw3iQRE0ZkUSn3K0My73/2vKKBfwyV0c+M/Il+
aMxNaD44Gq+/f6zGjkelgMEI4BjB5rs1KRvSCg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
N30baCKyoCzqkXEH6z9NGjUvX8RrQIlWKt6Zh6PBwfLwPAavt49NgAEAjotTfvOQWKvCSfqIct03
I/IL2wsqyzMQluVX4Qq3SuZr0efRIxLxVzWp52XW0JniVRCjHL2xk2sBT2Z9szWokQmK3X+uuSd7
P/cR2RvN1kgTw6hFVkwKKQ1jy7jWNcKNQmoyVoHMDP3VT9N2XpfwRwN+WPa+GoWG53sA2avX9Pea
xhAsP1jB1d5i3NkSbV6KWUcM32fw9Et9aWzo977pBImch67HApr4zPSFWB/8EKmnA9paDoYsgghA
HLaaEW2iajVh2IpBXzjsC/5jDY0sD+P1Jc8Yzw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UMjDEYYJUJQIZdg3W2OqR11k4Sy+p/IA2c4qZWN1r5khQd890/v1K85XVISRXfTkt2i9zyD3GmXF
7lNP2ADBm4CPYZGKTZGiE26A6adBPf+pbsOEdxrLclWcqhVRq03MwVTMQxzVw4Vs30sNoe7XDAZ+
v/fkoKz9wuUt+hXMKSWIX4MOMw9N8IJA9dEsBjLvnsBzwKq6QFN6I4T6BAfdk685x4zKYx2spNRU
ZupBse/6Ewu+MGtUz4bdjwyu4n8mdXrtTJ6JsjCKArS5t8yqU/yz4+bmjSm0GKvjS2pD6zKa37jP
Rg0z6KzpEqhjqduoq+sL0uUE3wn6NqIm/aXScQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7872)
`pragma protect data_block
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
qUpC5Jfx
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
