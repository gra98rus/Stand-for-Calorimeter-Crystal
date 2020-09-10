#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Mentor Graphics Questa Advanced Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Thu Sep 03 16:08:00 +07 2020
# SW Build 2258646 on Thu Jun 14 20:02:38 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
bin_path="/opt/cad/mentor/questa/questasim/bin"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep source tb_pl_top_elaborate.do 2>&1 | tee -a elaborate.log
