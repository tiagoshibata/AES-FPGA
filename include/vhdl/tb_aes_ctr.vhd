--------------------------------------------------------------------------------
--! @file sort_tb.vhdl
--! @date 20170604
--! @brief Testbench para o sort
--------------------------------------------------------------------------------
entity tb_aes_ctr is end;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture stim of tb_aes_ctr is
  component AES_CTR is
  port (
    clock, start, clear: in STD_LOGIC;
    pt, nonce_counter, key: in STD_LOGIC_VECTOR(127 downto 0);
    ct: out STD_LOGIC_VECTOR(127 downto 0);
    done: out STD_LOGIC
  );
  end component;

  constant periodoClock : time := 1 ms;

  signal clock, start, clear: std_logic := '0';
  signal pt, nonce_counter, key: STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
  signal ct : STD_LOGIC_VECTOR(127 downto 0);
  signal done : STD_LOGIC;

  begin
    uut: AES_CTR port map(clock, start, clear, pt, nonce_counter, key, ct, done);
    clock <= not clock after periodoClock/2;

    tb: process
    begin
      pt <= x"53696E676C6520626C6F636B206D7367";
      nonce_counter <= x"00000030000000000000000000000001";
      key <= x"AE6852F8121067CC4BF7A5765577F39E";
      -- Ciclo de reset
      clear <= '1';
      wait for 2 ms;
      clear <= '0';
      start <= '1';
      wait for 2 ms;
      start <= '0';
      wait until done = '1';

      assert ct = x"E4095D4FB7A7B3792D6175A3261311B8"
        report "Nope"
        severity failure;

      report ":^)"
      severity note;
      wait;
    end process;

end architecture stim;
