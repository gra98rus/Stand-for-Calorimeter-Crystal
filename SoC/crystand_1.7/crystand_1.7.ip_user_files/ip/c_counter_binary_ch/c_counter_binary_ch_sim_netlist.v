// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Jun 17 17:37:41 2021
// Host        : deva2 running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aandreev/pro/Stand-for-Calorimeter-Crystal/SoC/crystand_1.7/crystand_1.7.runs/c_counter_binary_ch_synth_1/c_counter_binary_ch_sim_netlist.v
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
om901/sg7BBxI/Z2DNIZo0SqPZWfhXHQ1XUVuPsp1NCmSa3Bj2ERiKhFxEgdKrTunhgg6z0Eujr/
AdJL26qP/ovtRQxH6qQrbV0CTV02RcOwg0whqu/d5M2L1KN2jn5wMLjWhCTG5RQ/01FSAQrn/V8B
qpDkxvXP3ACuGIN73uAXvBc3K5c3L/AaVrdwUn2/h15Lqck8Ys5mo3/bFEafF2UYmdV+cH6wxijY
vUVPtt4H/6ULXQdKusZNYdsr7huz96rL157H+JyNxOuOiA4OJEbYBzLgueaSwc5ko8xd4BHCMVHV
6Iy9noLMI29ocNtZ1045+VFxoucozZHkKUPLxg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Oc+ichbbOIoW/ZWP2kDusWXA7cuuP3It4VNt56Wjosa/f2Xvtjj+KbR/y4rloK6211jzy6So+gRG
gORLJoiDs6/ixiHKd2W8PiPmzzkDBOEManvcRNbU8VGJO0M2fU2dddDDoWC4YMgLGY2Y7E5jGSM8
53U83cRPwIHWmNefMxXNWAwZTnP8xXhlNSLeyT9Mx795S5cu74nwgCDiN2Yukw87vYHiewONHA7Z
+NlDhIGJbIvs402Ws1q7hLS04dudUxyCsqp+7alMChHLl3M2WMulOsZy3ldo1qD9XmcY6TwpeWLd
zlP05DuoV8ltnrtcMP79B0c8oUkghLsQ0mjU8g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7872)
`pragma protect data_block
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
0Wna9v2I
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
