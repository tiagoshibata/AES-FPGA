-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
-- Date        : Tue Aug  8 21:10:07 2017
-- Host        : shibata-surface running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/tiago/code/AES-FPGA/Project_VHDL/Project_VHDL.srcs/sources_1/bd/Microblaze/ip/Microblaze_vhdl_axi_aes_final_v1_2_0_0/Microblaze_vhdl_axi_aes_final_v1_2_0_0_stub.vhdl
-- Design      : Microblaze_vhdl_axi_aes_final_v1_2_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Microblaze_vhdl_axi_aes_final_v1_2_0_0 is
  Port ( 
    axi_aes_aclk : in STD_LOGIC;
    axi_aes_aresetn : in STD_LOGIC;
    axi_aes_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    axi_aes_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_aes_awvalid : in STD_LOGIC;
    axi_aes_awready : out STD_LOGIC;
    axi_aes_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_aes_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aes_wvalid : in STD_LOGIC;
    axi_aes_wready : out STD_LOGIC;
    axi_aes_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_aes_bvalid : out STD_LOGIC;
    axi_aes_bready : in STD_LOGIC;
    axi_aes_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    axi_aes_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axi_aes_arvalid : in STD_LOGIC;
    axi_aes_arready : out STD_LOGIC;
    axi_aes_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_aes_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axi_aes_rvalid : out STD_LOGIC;
    axi_aes_rready : in STD_LOGIC
  );

end Microblaze_vhdl_axi_aes_final_v1_2_0_0;

architecture stub of Microblaze_vhdl_axi_aes_final_v1_2_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "axi_aes_aclk,axi_aes_aresetn,axi_aes_awaddr[8:0],axi_aes_awprot[2:0],axi_aes_awvalid,axi_aes_awready,axi_aes_wdata[31:0],axi_aes_wstrb[3:0],axi_aes_wvalid,axi_aes_wready,axi_aes_bresp[1:0],axi_aes_bvalid,axi_aes_bready,axi_aes_araddr[8:0],axi_aes_arprot[2:0],axi_aes_arvalid,axi_aes_arready,axi_aes_rdata[31:0],axi_aes_rresp[1:0],axi_aes_rvalid,axi_aes_rready";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "vhdl_axi_aes_final_v1_0,Vivado 2017.2";
begin
end;
