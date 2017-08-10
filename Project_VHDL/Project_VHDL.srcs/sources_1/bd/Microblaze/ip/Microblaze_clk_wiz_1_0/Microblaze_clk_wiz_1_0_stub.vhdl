-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Aug  8 20:59:22 2017
-- Host        : shibata-surface running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/tiago/code/AES-FPGA/Project_VHDL/Project_VHDL.srcs/sources_1/bd/Microblaze/ip/Microblaze_clk_wiz_1_0/Microblaze_clk_wiz_1_0_stub.vhdl
-- Design      : Microblaze_clk_wiz_1_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Microblaze_clk_wiz_1_0 is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end Microblaze_clk_wiz_1_0;

architecture stub of Microblaze_clk_wiz_1_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_out2,resetn,locked,clk_in1";
begin
end;
