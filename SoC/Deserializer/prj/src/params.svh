//------------------------------------------------------------------------------
//  project:       template project
//
//  packages:      params
//
//  description:   test & work params
//------------------------------------------------------------------------------

`ifndef PARAMS_SVH
`define PARAMS_SVH

`include "common.svh"

//------------------------------------------------------------------------------
`ifndef SIMULATOR
`else
`endif

//------------------------------------------------------------------------------
//    PRJ_KEEP_HIEARARCHY
//
//    when defined  "yes" - (* keep_hierarchy = "yes" *)
//    wnen defined  "no"  - (* keep_hierarchy = "yes" *)
//------------------------------------------------------------------------------
`define PRJ_KEEP_HIEARARCHY "yes"

`endif // PARAMS_SVH

