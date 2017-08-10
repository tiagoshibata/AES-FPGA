--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
--Date        : Tue Aug  8 21:07:48 2017
--Host        : shibata-surface running 64-bit unknown
--Command     : generate_target Microblaze_wrapper.bd
--Design      : Microblaze_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Microblaze_wrapper is
  port (
    DDR2_addr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    DDR2_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR2_cas_n : out STD_LOGIC;
    DDR2_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR2_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_ras_n : out STD_LOGIC;
    DDR2_we_n : out STD_LOGIC;
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end Microblaze_wrapper;

architecture STRUCTURE of Microblaze_wrapper is
  component Microblaze is
  port (
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    DDR2_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR2_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_addr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    DDR2_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR2_ras_n : out STD_LOGIC;
    DDR2_cas_n : out STD_LOGIC;
    DDR2_we_n : out STD_LOGIC;
    DDR2_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR2_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR2_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
  end component Microblaze;
begin
Microblaze_i: component Microblaze
     port map (
      DDR2_addr(12 downto 0) => DDR2_addr(12 downto 0),
      DDR2_ba(2 downto 0) => DDR2_ba(2 downto 0),
      DDR2_cas_n => DDR2_cas_n,
      DDR2_ck_n(0) => DDR2_ck_n(0),
      DDR2_ck_p(0) => DDR2_ck_p(0),
      DDR2_cke(0) => DDR2_cke(0),
      DDR2_cs_n(0) => DDR2_cs_n(0),
      DDR2_dm(1 downto 0) => DDR2_dm(1 downto 0),
      DDR2_dq(15 downto 0) => DDR2_dq(15 downto 0),
      DDR2_dqs_n(1 downto 0) => DDR2_dqs_n(1 downto 0),
      DDR2_dqs_p(1 downto 0) => DDR2_dqs_p(1 downto 0),
      DDR2_odt(0) => DDR2_odt(0),
      DDR2_ras_n => DDR2_ras_n,
      DDR2_we_n => DDR2_we_n,
      reset => reset,
      sys_clock => sys_clock,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
end STRUCTURE;
