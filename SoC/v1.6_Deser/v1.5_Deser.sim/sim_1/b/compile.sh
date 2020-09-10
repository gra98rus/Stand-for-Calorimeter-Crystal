#!/bin/bash -f
bin_path="/eda/mentor/2014-15/RHELx86/QUESTA-SV-AFV_10.4/questasim/bin"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep source ./tb_pl_top_compile.do 2>&1 | tee -a compile.log
