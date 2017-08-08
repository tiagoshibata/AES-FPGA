library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vhdl_axi_aes_final_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface AXI_AES
		C_AXI_AES_DATA_WIDTH	: integer	:= 32;
		C_AXI_AES_ADDR_WIDTH	: integer	:= 9
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface AXI_AES
		axi_aes_aclk	: in std_logic;
		axi_aes_aresetn	: in std_logic;
		axi_aes_awaddr	: in std_logic_vector(C_AXI_AES_ADDR_WIDTH-1 downto 0);
		axi_aes_awprot	: in std_logic_vector(2 downto 0);
		axi_aes_awvalid	: in std_logic;
		axi_aes_awready	: out std_logic;
		axi_aes_wdata	: in std_logic_vector(C_AXI_AES_DATA_WIDTH-1 downto 0);
		axi_aes_wstrb	: in std_logic_vector((C_AXI_AES_DATA_WIDTH/8)-1 downto 0);
		axi_aes_wvalid	: in std_logic;
		axi_aes_wready	: out std_logic;
		axi_aes_bresp	: out std_logic_vector(1 downto 0);
		axi_aes_bvalid	: out std_logic;
		axi_aes_bready	: in std_logic;
		axi_aes_araddr	: in std_logic_vector(C_AXI_AES_ADDR_WIDTH-1 downto 0);
		axi_aes_arprot	: in std_logic_vector(2 downto 0);
		axi_aes_arvalid	: in std_logic;
		axi_aes_arready	: out std_logic;
		axi_aes_rdata	: out std_logic_vector(C_AXI_AES_DATA_WIDTH-1 downto 0);
		axi_aes_rresp	: out std_logic_vector(1 downto 0);
		axi_aes_rvalid	: out std_logic;
		axi_aes_rready	: in std_logic
	);
end vhdl_axi_aes_final_v1_0;

architecture arch_imp of vhdl_axi_aes_final_v1_0 is

	-- component declaration
	component vhdl_axi_aes_final_v1_0_AXI_AES is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 9
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component vhdl_axi_aes_final_v1_0_AXI_AES;

begin

-- Instantiation of Axi Bus Interface AXI_AES
vhdl_axi_aes_final_v1_0_AXI_AES_inst : vhdl_axi_aes_final_v1_0_AXI_AES
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_AXI_AES_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_AXI_AES_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> axi_aes_aclk,
		S_AXI_ARESETN	=> axi_aes_aresetn,
		S_AXI_AWADDR	=> axi_aes_awaddr,
		S_AXI_AWPROT	=> axi_aes_awprot,
		S_AXI_AWVALID	=> axi_aes_awvalid,
		S_AXI_AWREADY	=> axi_aes_awready,
		S_AXI_WDATA	=> axi_aes_wdata,
		S_AXI_WSTRB	=> axi_aes_wstrb,
		S_AXI_WVALID	=> axi_aes_wvalid,
		S_AXI_WREADY	=> axi_aes_wready,
		S_AXI_BRESP	=> axi_aes_bresp,
		S_AXI_BVALID	=> axi_aes_bvalid,
		S_AXI_BREADY	=> axi_aes_bready,
		S_AXI_ARADDR	=> axi_aes_araddr,
		S_AXI_ARPROT	=> axi_aes_arprot,
		S_AXI_ARVALID	=> axi_aes_arvalid,
		S_AXI_ARREADY	=> axi_aes_arready,
		S_AXI_RDATA	=> axi_aes_rdata,
		S_AXI_RRESP	=> axi_aes_rresp,
		S_AXI_RVALID	=> axi_aes_rvalid,
		S_AXI_RREADY	=> axi_aes_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
