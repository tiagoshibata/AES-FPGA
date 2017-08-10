-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: user.org:user:vhdl_axi_aes_final_v1_2:1.2
-- IP Revision: 4

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Microblaze_vhdl_axi_aes_final_v1_2_0_0 IS
  PORT (
    axi_aes_aclk : IN STD_LOGIC;
    axi_aes_aresetn : IN STD_LOGIC;
    axi_aes_awaddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    axi_aes_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    axi_aes_awvalid : IN STD_LOGIC;
    axi_aes_awready : OUT STD_LOGIC;
    axi_aes_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    axi_aes_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    axi_aes_wvalid : IN STD_LOGIC;
    axi_aes_wready : OUT STD_LOGIC;
    axi_aes_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    axi_aes_bvalid : OUT STD_LOGIC;
    axi_aes_bready : IN STD_LOGIC;
    axi_aes_araddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    axi_aes_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    axi_aes_arvalid : IN STD_LOGIC;
    axi_aes_arready : OUT STD_LOGIC;
    axi_aes_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    axi_aes_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    axi_aes_rvalid : OUT STD_LOGIC;
    axi_aes_rready : IN STD_LOGIC
  );
END Microblaze_vhdl_axi_aes_final_v1_2_0_0;

ARCHITECTURE Microblaze_vhdl_axi_aes_final_v1_2_0_0_arch OF Microblaze_vhdl_axi_aes_final_v1_2_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF Microblaze_vhdl_axi_aes_final_v1_2_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT vhdl_axi_aes_final_v1_0 IS
    GENERIC (
      C_AXI_AES_DATA_WIDTH : INTEGER;
      C_AXI_AES_ADDR_WIDTH : INTEGER
    );
    PORT (
      axi_aes_aclk : IN STD_LOGIC;
      axi_aes_aresetn : IN STD_LOGIC;
      axi_aes_awaddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      axi_aes_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      axi_aes_awvalid : IN STD_LOGIC;
      axi_aes_awready : OUT STD_LOGIC;
      axi_aes_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      axi_aes_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      axi_aes_wvalid : IN STD_LOGIC;
      axi_aes_wready : OUT STD_LOGIC;
      axi_aes_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      axi_aes_bvalid : OUT STD_LOGIC;
      axi_aes_bready : IN STD_LOGIC;
      axi_aes_araddr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      axi_aes_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      axi_aes_arvalid : IN STD_LOGIC;
      axi_aes_arready : OUT STD_LOGIC;
      axi_aes_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      axi_aes_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      axi_aes_rvalid : OUT STD_LOGIC;
      axi_aes_rready : IN STD_LOGIC
    );
  END COMPONENT vhdl_axi_aes_final_v1_0;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 axi_aes_aclk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 axi_aes_aresetn RST";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF axi_aes_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 axi_aes RREADY";
BEGIN
  U0 : vhdl_axi_aes_final_v1_0
    GENERIC MAP (
      C_AXI_AES_DATA_WIDTH => 32,
      C_AXI_AES_ADDR_WIDTH => 9
    )
    PORT MAP (
      axi_aes_aclk => axi_aes_aclk,
      axi_aes_aresetn => axi_aes_aresetn,
      axi_aes_awaddr => axi_aes_awaddr,
      axi_aes_awprot => axi_aes_awprot,
      axi_aes_awvalid => axi_aes_awvalid,
      axi_aes_awready => axi_aes_awready,
      axi_aes_wdata => axi_aes_wdata,
      axi_aes_wstrb => axi_aes_wstrb,
      axi_aes_wvalid => axi_aes_wvalid,
      axi_aes_wready => axi_aes_wready,
      axi_aes_bresp => axi_aes_bresp,
      axi_aes_bvalid => axi_aes_bvalid,
      axi_aes_bready => axi_aes_bready,
      axi_aes_araddr => axi_aes_araddr,
      axi_aes_arprot => axi_aes_arprot,
      axi_aes_arvalid => axi_aes_arvalid,
      axi_aes_arready => axi_aes_arready,
      axi_aes_rdata => axi_aes_rdata,
      axi_aes_rresp => axi_aes_rresp,
      axi_aes_rvalid => axi_aes_rvalid,
      axi_aes_rready => axi_aes_rready
    );
END Microblaze_vhdl_axi_aes_final_v1_2_0_0_arch;
