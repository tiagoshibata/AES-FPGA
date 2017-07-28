library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AES_Encrypt is
	port (
		clock, start, clear: in STD_LOGIC;
		rk0, rk1, rk2, rk3: in UNSIGNED(31 downto 0);
		input: in STD_LOGIC_VECTOR(127 downto 0);
		output: out STD_LOGIC_VECTOR(127 downto 0);
        rk_addr: out UNSIGNED(5 downto 0);
        done: out STD_LOGIC
	);
end AES_Encrypt;

architecture arch of AES_Encrypt is

-- State machine
type estados is (
    aes_enc_st_wait, aes_enc_st_read, aes_enc_st_addroundkey,
    aes_enc_st_round_odd_in, aes_enc_st_round_odd_out,
    aes_enc_st_round_even_in, aes_enc_st_round_even_out,
    aes_enc_st_round_last_in, aes_enc_st_round_last_out,
    aes_enc_st_subbytes_in, aes_enc_st_subbytes_out,
    aes_enc_st_end
);
signal sreg, snext: estados;

-- Internal signals
signal x0, x1, x2, x3, y0, y1, y2, y3: UNSIGNED(31 downto 0);
signal aes_round, Irk_addr: UNSIGNED(5 downto 0);

-- Modules
signal froundin0, froundin1, froundin2, froundin3, froundout0, froundout1, froundout2, froundout3: UNSIGNED(31 downto 0);
component AES_FROUND
	port (
		y0, y1, y2, y3, rk0, rk1, rk2, rk3: in UNSIGNED(31 downto 0);
        x0, x1, x2, x3: out UNSIGNED(31 downto 0)
	);
end component;
signal fsbin0, fsbin1, fsbin2, fsbin3, fsbout0, fsbout1, fsbout2, fsbout3: UNSIGNED(31 downto 0);
component AES_FSb
	port (
		y0, y1, y2, y3, rk0, rk1, rk2, rk3: in UNSIGNED(31 downto 0);
        x0, x1, x2, x3: out UNSIGNED(31 downto 0)
	);
end component;

begin

fround0: AES_FROUND port map (
	froundin0, froundin1, froundin2, froundin3, rk0, rk1, rk2, rk3,
	froundout0, froundout1, froundout2, froundout3
);
fsb0: AES_FSb port map (
	fsbin0, fsbin1, fsbin2, fsbin3, rk0, rk1, rk2, rk3,
	fsbout0, fsbout1, fsbout2, fsbout3
);

process (clock)
begin
    if clock'event and clock = '1' then
        sreg <= snext;

        case sreg is

			when aes_enc_st_wait =>
				done <= '0';
				aes_round <= (others => '0');
				Irk_addr <= (others => '1'); -- Unused address to update rk0-3 when started
			when aes_enc_st_read =>
				Irk_addr <= (others => '0'); -- Updates rk0-3
				aes_round <= "000011"; -- (10 >> 1) - 2
				x0 <= unsigned(input(103 downto  96) & input(111 downto 104) & input(119 downto 112) & input(127 downto 120));
                x1 <= unsigned(input( 71 downto  64) & input( 79 downto  72) & input( 87 downto  80) & input( 95 downto  88));
                x2 <= unsigned(input( 39 downto  32) & input( 47 downto  40) & input( 55 downto  48) & input( 63 downto  56));
                x3 <= unsigned(input(  7 downto   0) & input( 15 downto   8) & input( 23 downto  16) & input( 31 downto  24));
			when aes_enc_st_addroundkey =>
				x0 <= x0 xor rk0;
				x1 <= x1 xor rk1;
				x2 <= x2 xor rk2;
				x3 <= x3 xor rk3;

			--AES_FROUND( y0, y1, y2, y3, x0, x1, x2, x3 );
			when aes_enc_st_round_odd_in =>
				Irk_addr <= Irk_addr + 4;
				froundin0 <= x0; froundin1 <= x1; froundin2 <= x2; froundin3 <= x3;
			when aes_enc_st_round_odd_out =>
				y0 <= froundout0; y1 <= froundout1; y2 <= froundout2; y3 <= froundout3;
			when aes_enc_st_round_last_in =>
				Irk_addr <= Irk_addr + 4;
				froundin0 <= x0; froundin1 <= x1; froundin2 <= x2; froundin3 <= x3;
			when aes_enc_st_round_last_out =>
				y0 <= froundout0; y1 <= froundout1; y2 <= froundout2; y3 <= froundout3;

			--AES_FROUND( x0, x1, x2, x3, y0, y1, y2, y3 );
			when aes_enc_st_round_even_in =>
				Irk_addr <= Irk_addr + 4;
				froundin0 <= y0; froundin1 <= y1; froundin2 <= y2; froundin3 <= y3;
			when aes_enc_st_round_even_out =>
				x0 <= froundout0; x1 <= froundout1; x2 <= froundout2; x3 <= froundout3;
				aes_round <= aes_round - 1;

			--AES_FSb( x0, x1, x2, x3, y0, y1, y2, y3 );
			when aes_enc_st_subbytes_in =>
				Irk_addr <= Irk_addr + 4;
				fsbin0 <= y0; fsbin1 <= y1; fsbin2 <= y2; fsbin3 <= y3;
			when aes_enc_st_subbytes_out =>
				x0 <= fsbout0; x1 <= fsbout1; x2 <= fsbout2; x3 <= fsbout3;

			when aes_enc_st_end =>
				output <= std_logic_vector(x0( 7 downto  0) & x0(15 downto  8) & x0(23 downto 16) & x0(31 downto 24) &
				                           x1( 7 downto  0) & x1(15 downto  8) & x1(23 downto 16) & x1(31 downto 24) &
				                           x2( 7 downto  0) & x2(15 downto  8) & x2(23 downto 16) & x2(31 downto 24) &
				                           x3( 7 downto  0) & x3(15 downto  8) & x3(23 downto 16) & x3(31 downto 24));
				done <= '1';

        end case;
    end if;
end process;

process (sreg, start, clear, aes_round)
begin
	if (clear = '1') then
		snext <= aes_enc_st_wait;
	else case sreg is

		when aes_enc_st_wait =>
			if (start = '1') then
				snext <= aes_enc_st_read;
			else
				snext <= aes_enc_st_wait;
			end if;
		when aes_enc_st_read =>
			snext <= aes_enc_st_addroundkey;
		when aes_enc_st_addroundkey =>
			snext <= aes_enc_st_round_odd_in;
		when aes_enc_st_round_odd_in =>
			snext <= aes_enc_st_round_odd_out;
		when aes_enc_st_round_odd_out =>
			snext <= aes_enc_st_round_even_in;
		when aes_enc_st_round_even_in =>
			snext <= aes_enc_st_round_even_out;
		when aes_enc_st_round_even_out =>
			if (aes_round > 0) then
				snext <= aes_enc_st_round_odd_in;
			else
				snext <= aes_enc_st_round_last_in;
			end if;
		when aes_enc_st_round_last_in =>
			snext <= aes_enc_st_round_last_out;
		when aes_enc_st_round_last_out =>
			snext <= aes_enc_st_subbytes_in;
        when aes_enc_st_subbytes_in =>
    		snext <= aes_enc_st_subbytes_out;
		when aes_enc_st_subbytes_out =>
			snext <= aes_enc_st_end;
		when aes_enc_st_end =>
			snext <= aes_enc_st_wait;

    end case;
	end if;
end process;

rk_addr <= Irk_addr;

end arch;
