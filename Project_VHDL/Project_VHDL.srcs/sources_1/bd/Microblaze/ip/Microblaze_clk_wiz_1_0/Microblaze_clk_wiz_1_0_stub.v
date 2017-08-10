// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Aug  8 20:59:22 2017
// Host        : shibata-surface running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/tiago/code/AES-FPGA/Project_VHDL/Project_VHDL.srcs/sources_1/bd/Microblaze/ip/Microblaze_clk_wiz_1_0/Microblaze_clk_wiz_1_0_stub.v
// Design      : Microblaze_clk_wiz_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module Microblaze_clk_wiz_1_0(clk_out1, clk_out2, resetn, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,resetn,locked,clk_in1" */;
  output clk_out1;
  output clk_out2;
  input resetn;
  output locked;
  input clk_in1;
endmodule
