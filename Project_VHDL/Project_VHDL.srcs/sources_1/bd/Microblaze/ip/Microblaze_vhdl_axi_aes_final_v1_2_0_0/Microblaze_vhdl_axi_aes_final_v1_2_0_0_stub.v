// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Aug  8 21:10:07 2017
// Host        : shibata-surface running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/tiago/code/AES-FPGA/Project_VHDL/Project_VHDL.srcs/sources_1/bd/Microblaze/ip/Microblaze_vhdl_axi_aes_final_v1_2_0_0/Microblaze_vhdl_axi_aes_final_v1_2_0_0_stub.v
// Design      : Microblaze_vhdl_axi_aes_final_v1_2_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "vhdl_axi_aes_final_v1_0,Vivado 2017.2" *)
module Microblaze_vhdl_axi_aes_final_v1_2_0_0(axi_aes_aclk, axi_aes_aresetn, 
  axi_aes_awaddr, axi_aes_awprot, axi_aes_awvalid, axi_aes_awready, axi_aes_wdata, 
  axi_aes_wstrb, axi_aes_wvalid, axi_aes_wready, axi_aes_bresp, axi_aes_bvalid, 
  axi_aes_bready, axi_aes_araddr, axi_aes_arprot, axi_aes_arvalid, axi_aes_arready, 
  axi_aes_rdata, axi_aes_rresp, axi_aes_rvalid, axi_aes_rready)
/* synthesis syn_black_box black_box_pad_pin="axi_aes_aclk,axi_aes_aresetn,axi_aes_awaddr[8:0],axi_aes_awprot[2:0],axi_aes_awvalid,axi_aes_awready,axi_aes_wdata[31:0],axi_aes_wstrb[3:0],axi_aes_wvalid,axi_aes_wready,axi_aes_bresp[1:0],axi_aes_bvalid,axi_aes_bready,axi_aes_araddr[8:0],axi_aes_arprot[2:0],axi_aes_arvalid,axi_aes_arready,axi_aes_rdata[31:0],axi_aes_rresp[1:0],axi_aes_rvalid,axi_aes_rready" */;
  input axi_aes_aclk;
  input axi_aes_aresetn;
  input [8:0]axi_aes_awaddr;
  input [2:0]axi_aes_awprot;
  input axi_aes_awvalid;
  output axi_aes_awready;
  input [31:0]axi_aes_wdata;
  input [3:0]axi_aes_wstrb;
  input axi_aes_wvalid;
  output axi_aes_wready;
  output [1:0]axi_aes_bresp;
  output axi_aes_bvalid;
  input axi_aes_bready;
  input [8:0]axi_aes_araddr;
  input [2:0]axi_aes_arprot;
  input axi_aes_arvalid;
  output axi_aes_arready;
  output [31:0]axi_aes_rdata;
  output [1:0]axi_aes_rresp;
  output axi_aes_rvalid;
  input axi_aes_rready;
endmodule
