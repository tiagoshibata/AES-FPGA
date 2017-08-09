library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AES_Nonce_Counter is
	port (
		clock, clear, increment: in STD_LOGIC;
		original_nc: in STD_LOGIC_VECTOR(127 downto 0);
        current_nc: out STD_LOGIC_VECTOR(127 downto 0)
	);
end AES_Nonce_Counter;

architecture arch of AES_Nonce_Counter is

-- Internal signal
signal nc: UNSIGNED(127 downto 0) := (others => '0');

begin

process (clock, clear, increment)
begin
    if clock'event and clock = '1' then
        if clear = '1' then
			nc <= unsigned(original_nc);
		elsif increment = '1' then
			nc <= nc + 1;
		end if;
    end if;
end process;

current_nc <= std_logic_vector(nc);

end arch;
