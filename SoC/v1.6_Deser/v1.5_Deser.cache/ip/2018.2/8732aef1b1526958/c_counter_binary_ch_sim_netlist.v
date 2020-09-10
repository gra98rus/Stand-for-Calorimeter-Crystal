// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Mon Aug 31 16:15:55 2020
// Host        : aandreev-inp running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ c_counter_binary_ch_sim_netlist.v
// Design      : c_counter_binary_ch
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_counter_binary_ch,c_counter_binary_v12_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_12,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_12 U0
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
(* C_XDEVICEFAMILY = "zynq" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_12
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_12_viv i_synth
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
Ppc+FbygryZI3Iij4consvGmnh4NFEBnX1dckhNSvgImEikGsLulJ+L1wj44ZbjKd9/n67dJT8dd
07KeYTFU38wq+YSs8D8yrasp82o0p0m7UlzLCBs1hSk08Nl/NIWQ4xVj+FHwxWBBaEUKbGkb7yMv
Pw2sko73nKr0FqtQ6oXm4cmWuBZwXJ3HIK6yChBcUMwBMqhD6ydKkr7wDP43wIsAT765ekXIGbmF
jKGG5p6Q4mduFz4l4I3MX/CmJVayad0CmFQq3E7blrsMQo1D77geCm4GTRN/d4vWxnZBHIIA5w4N
+ZC/xuWQDXeZxJCvO1cMhZUxqFd/nj0r+esURg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DniIdC6Ckxd8HdZzJevkqZqHNrHWIZZ/gEj+KVM2OdcrlvdkHpHs6kAwJkOeNqVRF0upSCRJKo7F
ZrQBysF6HLh5bfMEBYOQXxDK0MXbopcOmFPNVFVaH98zM5UGRbM/Gxgpx30M54FZbezuhShTyLGJ
9yVaXv+wWxb2VLuTgTX40Hw2ztVrPSuFXBXEsqojDxy0Pl7DhcPcuzQGGVQqlucn9cIHV28/nsvh
VjTeEvVL/oB+vLlmNFyBNRIMkfgSKt5TIqMzWS0lWn3ziqUvdNlkCP9O9hyt6mflssi+Dmy2EfJx
Opjyr3gVtGwV5TIto6MewLsh2IGFvgzivYO0CA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7808)
`pragma protect data_block
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
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
