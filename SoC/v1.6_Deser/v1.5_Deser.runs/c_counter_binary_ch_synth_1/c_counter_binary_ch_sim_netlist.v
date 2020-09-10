// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Mon Aug 31 16:15:56 2020
// Host        : aandreev-inp running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aandreev/pro/v1.5_Deser/v1.5_Deser.runs/c_counter_binary_ch_synth_1/c_counter_binary_ch_sim_netlist.v
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
AYSo98diSPDmsOz9InQAB7WWMg42gbguANKg3n6iiczTh+bJ/zld/zoiR7gPRAuE0hgyjXIBgcns
r8ZNCu9zysBt5OvBtgFEMPwiBXe5lljg9/vwIICiJocweMzgt0Guca9wC6m1TUEcq7LqmR9vYNHZ
jGeq0rGOBTtqrxIn59lQRu7CSbP5/borZZlpxuqcCRZZ0Ymm+eoJQXZOP1IlTWye2mSeg0PpQklJ
AU2E1O5KAJzYboZh7B8iEk0ZrdcaSbOL5Xw/aROPLm/jgODldcTRMpz8YUH1DgeQwmwKg3975Lf0
52rfwxHhiNhxLIayHCz7lwpw4FfZyOymVob2IQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lcDf9Sc6ziPsluu/yf0I31nihrg1NTVhLPbVcwE2y+j/7Ar5wVc9REbd/bv+lD7sWP3Bi/OgDU1+
pMNeJ36hpgsKQ+q+XLP0W1LEjI32hEQQ6gumEUAIvjJAxC7V2/BT5CHBRytH6GkrWNxcnB1fmuyf
L62SFBytkn7kQk9K/lKaAviNzEmtr1Bl/wOWPveHd8guXcxOAwvmOMItlrzsJzCeTSAqoNqGmW5S
ahwjJtXSm62u9VJgIc78kiDIptvflxoydnslZKmHEA97fleBhFz9Oo6u/y4s3swpzjCHs/2QsndM
x2jbYtsaGP/AlA7/bwnqgzkXKzGNLO2vX4Jr8g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7872)
`pragma protect data_block
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
W7lvjizS
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
