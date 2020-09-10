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
ExecStep $bin_path/vsim -64  -do "do {tb_pl_top_simulate.do}" -l simulate.log
