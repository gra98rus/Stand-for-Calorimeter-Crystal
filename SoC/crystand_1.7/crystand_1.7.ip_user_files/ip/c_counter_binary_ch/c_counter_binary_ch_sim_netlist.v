// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Nov 19 22:37:33 2020
// Host        : aandreev-inp running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aandreev/pro/Stand-for-Calorimeter-Crystal/SoC/v1.7_Deser/crystand_1.7/crystand_1.7.runs/c_counter_binary_ch_synth_1/c_counter_binary_ch_sim_netlist.v
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
KJ6GTCJzexQridytxYuMxm61XKF85cyngzjfR+bJTtcxDTm8Y2b2EQOcJjBz69NfkigH5ht8pC2O
Ujw+1HgfUS8CAeBEgCq+Vsra2EHkhBnnF9m1djRraimcItko7wHo2nw3j2laMFEkddfNIjT1Q/Xb
NVnLrUSNs9Msu0Vwv48TwXAfG91tLJUp+Z+gvjbsCDxkugsWmrEO9JrGsdT8HFWbwyWfA8TJDnaC
CeWsLE3i64P7+Vy6HGa6Et5P+Spj4F17YcpngM4p1VMDiCeDqBuo3pZYbmVnlFddd2+o8oINb1ar
7rxcKyWM3HNOkNRQE2zmX88Xaew5/alTmOLLqw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eLjpaoP0P2N27BFlf/b/SzuVnw76wi6FvWlyoKfCMYFOcKpIkqXyQEQiATBT/VExIRzBWpuROVRu
hrW5FIPvgIt4qiYRjgVqV1rL+RMMVGL/BugAZ7jS0v19rQqy/IbeC5XBGAJ28dZMPCpyq2/Ckft1
hBiwaepHQZJJPcP0A3nJaQh3Aw7xMfuhQKfRTayN4SRgg/cFts+qlLeKIRIIFeg74KLBZmBzhThj
WvZHENiDa0/ahMaq63xdjT6k5GavO1tgXjx/Ms0onOXy2TX+MmQObjML9yuogPiJKV5UuuDMfux7
sNYSCUOC/ZVFwqUwCT4y3875xgYLHmbh2lGFig==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7872)
`pragma protect data_block
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
zL5MRtZm
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
