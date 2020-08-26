//------------------------------------------------------------------------------
//  project:       template project
//
//  modules:       hw_standalone_tb 
//
//  description:   testbench platform for standalone template project
//------------------------------------------------------------------------------

`include "common.svh"
`include "tb.svh" 
`include "params.svh"   

//******************************************************************************
//******************************************************************************
module hw_standalone_tb import tb_pkg::*;
();

//==============================================================================
//    Settings
//==============================================================================

//------------------------------------------------------------------------------
//--- general params (measured in ns)
parameter real             CLK_PERIOD    = (1.0/`CLK_FREQ)*1e9;
parameter longint unsigned STOP_TIME     = 345;
parameter longint unsigned EPILOGUE_TIME = CLK_PERIOD/2;

//==============================================================================
//    Objects
//==============================================================================

//---
//logic ref_clk;
logic finish  = 1'b0;

//---
`ifdef CFG_NAME_NEXYS_A7
    logic                        clk;
    logic                        reset;

`endif


//==============================================================================
//     Logic
//==============================================================================

//------------------------------------------------------------------------------
initial begin
    fork
        //--- general
        clk_control(CLK_PERIOD, clk);
        stop_signal_control(finish, EPILOGUE_TIME);
        stop_time_control(STOP_TIME);
        reset_sys(CLK_PERIOD*2,CLK_PERIOD, reset);
    join_any
    $stop(2);
end

//==============================================================================
//    Instances
//==============================================================================

hw_standalone DUT
(
    `ifdef CFG_NAME_NEXYS_A7
        .clk    ( clk ),
        .reset  ( reset )

    `endif    
);

endmodule : hw_standalone_tb

