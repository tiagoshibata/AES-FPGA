library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AES_CTR is
		port (
			clock, start, clear: in STD_LOGIC;
			pt, nonce_counter, key: in STD_LOGIC_VECTOR(127 downto 0);
			ct: out STD_LOGIC_VECTOR(127 downto 0);
	        done: out STD_LOGIC
		);
end AES_CTR;

architecture arch of AES_CTR is

-- State machine
type estados is (
    aes_ctr_st_wait, aes_ctr_st_rk_start, aes_ctr_st_rk_wait,
    aes_ctr_st_enc_start, aes_ctr_st_enc_wait,
    aes_ctr_st_nc_inc, aes_ctr_st_end_wait, aes_ctr_st_end
);
signal sreg, snext: estados;

-- Internal signals
signal rk0, rk1, rk2, rk3: UNSIGNED(31 downto 0);
signal rk_addr: UNSIGNED(5 downto 0);
signal cipher, curr_nc: STD_LOGIC_VECTOR(127 downto 0);

-- Modules
signal start_rk, done_rk: STD_LOGIC;
component AES_RoundKey
	port (
		clock, start, clear: in STD_LOGIC;
		rk_addr: in UNSIGNED(5 downto 0);
		key: in STD_LOGIC_VECTOR(127 downto 0);
        rk0, rk1, rk2, rk3: out UNSIGNED(31 downto 0);
        done: out STD_LOGIC
	);
end component;
signal start_enc, done_enc: STD_LOGIC;
component AES_Encrypt
	port (
		clock, start, clear: in STD_LOGIC;
		rk0, rk1, rk2, rk3: in UNSIGNED(31 downto 0);
		pt: in STD_LOGIC_VECTOR(127 downto 0);
		ct: out STD_LOGIC_VECTOR(127 downto 0);
        rk_addr: out UNSIGNED(5 downto 0);
        done: out STD_LOGIC
	);
end component;
signal inc_nc: STD_LOGIC;
component AES_Nonce_Counter
	port (
		clock, clear, increment: in STD_LOGIC;
		original_nc: in STD_LOGIC_VECTOR(127 downto 0);
        current_nc: out STD_LOGIC_VECTOR(127 downto 0)
	);
end component;

begin

roundkey0: AES_RoundKey port map (
	clock, start_rk, clear,
	rk_addr,
	key,
	rk0, rk1, rk2, rk3,
	done_rk
);
aes_encrypt0: AES_Encrypt port map (
	clock, start_enc, clear,
	rk0, rk1, rk2, rk3,
	curr_nc,
	cipher,
	rk_addr,
	done_enc
);
nonce_ctr: AES_Nonce_Counter port map (
	clock, clear, inc_nc,
	nonce_counter,
	curr_nc
);

process (clock)
begin
    if clock'event and clock = '1' then
        sreg <= snext;

        case sreg is

			when aes_ctr_st_wait =>
				done <= '0';
				inc_nc <= '0';
				start_rk <= '0';
				start_enc <= '0';
			when aes_ctr_st_rk_start =>
				start_rk <= '1';
			when aes_ctr_st_rk_wait =>
				start_rk <= '0';
			when aes_ctr_st_enc_start =>
				start_enc <= '1';
			when aes_ctr_st_enc_wait =>
				start_enc <= '0';
			when aes_ctr_st_nc_inc =>
				ct <= pt xor cipher;
				inc_nc <= '1';
			when aes_ctr_st_end_wait =>
				inc_nc <= '0';
				done <= '1';
			when aes_ctr_st_end =>
				done <= '1';

        end case;
    end if;
end process;

process (sreg, start, clear, done_rk, done_enc)
begin
	if (clear = '1') then
		snext <= aes_ctr_st_wait;
	else case sreg is

		when aes_ctr_st_wait =>
			if (start = '1') then
				snext <= aes_ctr_st_rk_start;
			else
				snext <= aes_ctr_st_wait;
			end if;
		when aes_ctr_st_rk_start =>
		    snext <= aes_ctr_st_rk_wait;
        when aes_ctr_st_rk_wait =>
            if (done_rk = '1') then
                snext <= aes_ctr_st_enc_start;
            else
    		    snext <= aes_ctr_st_rk_wait;
            end if;
        when aes_ctr_st_enc_start =>
    		snext <= aes_ctr_st_enc_wait;
        when aes_ctr_st_enc_wait =>
            if (done_enc = '1') then
                snext <= aes_ctr_st_nc_inc;
            else
        	    snext <= aes_ctr_st_enc_wait;
            end if;
		when aes_ctr_st_nc_inc =>
			snext <= aes_ctr_st_end_wait;
		when aes_ctr_st_end_wait =>
			if (start = '1') then
				snext <= aes_ctr_st_end_wait; -- Wait until start is released
			else
				snext <= aes_ctr_st_end;
			end if;
		when aes_ctr_st_end =>
			if (start = '1') then
				snext <= aes_ctr_st_enc_start; -- No need to recalculate round keys
			else
				snext <= aes_ctr_st_end;
			end if;

    end case;
	end if;
end process;

end arch;
