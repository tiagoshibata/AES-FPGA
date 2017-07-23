#include "aes_roundkey.h"

#define GET_UINT32_LE(n,b,i)                            \
{                                                       \
    (n) = ( (uint32_t) (b)[(i)    ]       )             \
        | ( (uint32_t) (b)[(i) + 1] <<  8 )             \
        | ( (uint32_t) (b)[(i) + 2] << 16 )             \
        | ( (uint32_t) (b)[(i) + 3] << 24 );            \
}

void AES_RoundKey::get_next_state()
{
	if (clear) {
		snext = aes_rk_st_wait;
	} else switch (sreg) {
		case aes_rk_st_wait:
			if (start) {
				snext = aes_rk_st_read;
			} else {
				snext = aes_rk_st_wait;
			}
			break;
		case aes_rk_st_read:
			snext = aes_rk_st_generate_begin;
			break;
    case aes_rk_st_generate_begin:
      snext = aes_rk_st_generate_end;
    	break;
    case aes_rk_st_generate_end:
      // set_state runs up to 9, since it takes 1 cycle for the snext
      //  update to be seen
      if (round < 9) {
        snext = aes_rk_st_generate_begin;
      } else {
  		  snext = aes_rk_st_end;
      }
  		break;
		case aes_rk_st_end:
			snext = aes_rk_st_wait;
			break;
	}
}

void AES_RoundKey::set_state()
{
	sreg = snext;

	switch (sreg) {
		case aes_rk_st_wait:
            round = 0;
			done = 0;
			break;
		case aes_rk_st_read:
			round = 0;
			GET_UINT32_LE(rk[0], key, 0);
			GET_UINT32_LE(rk[1], key, 4);
			GET_UINT32_LE(rk[2], key, 8);
			GET_UINT32_LE(rk[3], key, 12);
			break;
		case aes_rk_st_generate_begin:
			rk[4 + (round << 2)]  = rk[0 + (round << 2)] ^ RCON[round] ^
			( (uint32_t) FSb[ ( rk[3 + (round << 2)] >>  8 ) & 0xFF ]       ) ^
			( (uint32_t) FSb[ ( rk[3 + (round << 2)] >> 16 ) & 0xFF ] <<  8 ) ^
			( (uint32_t) FSb[ ( rk[3 + (round << 2)] >> 24 ) & 0xFF ] << 16 ) ^
			( (uint32_t) FSb[ ( rk[3 + (round << 2)]       ) & 0xFF ] << 24 );
			break;
    case aes_rk_st_generate_end:
  		rk[5 + (round << 2)]  = rk[1 + (round << 2)] ^ rk[4 + (round << 2)];
  		rk[6 + (round << 2)]  = rk[1 + (round << 2)] ^ rk[2 + (round << 2)] ^ rk[4 + (round << 2)];
  		rk[7 + (round << 2)]  = rk[1 + (round << 2)] ^ rk[2 + (round << 2)] ^ rk[3 + (round << 2)] ^ rk[4 + (round << 2)];
  		round = round + 1;
  		break;
		case aes_rk_st_end:
		    done = 1;
		    break;
	}
}

void AES_RoundKey::read_rk()
{
    rk0 = rk[(rk_addr    ) % 44];
    rk1 = rk[(rk_addr + 1) % 44];
    rk2 = rk[(rk_addr + 2) % 44];
    rk3 = rk[(rk_addr + 3) % 44];
}
