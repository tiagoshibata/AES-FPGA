#include "aes_encrypt.h"

#define GET_UINT32_LE(n,b,i)                            \
{                                                       \
    (n) = ( (uint32_t) (b)[(i)    ]       )             \
        | ( (uint32_t) (b)[(i) + 1] <<  8 )             \
        | ( (uint32_t) (b)[(i) + 2] << 16 )             \
        | ( (uint32_t) (b)[(i) + 3] << 24 );            \
}
#define PUT_UINT32_LE(n,b,i)                                    \
{                                                               \
    (b)[(i)    ] = (unsigned char) ( ( (n)       ) & 0xFF );    \
    (b)[(i) + 1] = (unsigned char) ( ( (n) >>  8 ) & 0xFF );    \
    (b)[(i) + 2] = (unsigned char) ( ( (n) >> 16 ) & 0xFF );    \
    (b)[(i) + 3] = (unsigned char) ( ( (n) >> 24 ) & 0xFF );    \
}

void AES_encrypt::get_next_state()
{
	if (clear) {
		sreg = st_wait;
	} else switch (sreg) {
		case st_wait:
			if (start.read()) {
				snext = st_read;
			} else {
				snext = st_wait;
			}
			break;
		case st_read:
			snext = st_addroundkey;
			break;
		case st_addroundkey:
			snext = st_round_odd;
			break;
		case st_round_odd:
			snext = st_round_even;
			break;
		case st_round_even:
			if (round > 0) {
				snext = st_round_odd;
			} else {
				snext = st_round_last;
			}
			break;
		case st_round_last:
			snext = st_subbytes;
			break;
		case st_subbytes:
			snext = st_end;
			break;
		case st_end:
			snext = st_wait;
			break;
	}
}

void AES_encrypt::set_state()
{
	sreg = snext;

	switch (sreg) {
		case st_wait:
			done = 0;
			rk_addr = 0;
			break;
		case st_read:
			round = (10 >> 1) - 1;
			rk_addr = 0;
			GET_UINT32_LE(x0, input, 0);
			GET_UINT32_LE(x1, input, 4);
			GET_UINT32_LE(x2, input, 8);
			GET_UINT32_LE(x3, input, 12);
			break;
		case st_addroundkey:
			x0 = x0 ^ rk0;
			x1 = x1 ^ rk1;
			x2 = x2 ^ rk2;
			x3 = x3 ^ rk3;
			rk_addr += 4;
			break;
		case st_round_odd:
		case st_round_last:
			//AES_FROUND( y0, y1, y2, y3, x0, x1, x2, x3 );
			froundin0 = x0; froundin1 = x1; froundin2 = x2; froundin3 = x3;
			froundout0 = y0; froundout1 = y1; froundout2 = y2; froundout2 = y2;
			rk_addr += 4;
			break;
		case st_round_even:
			//AES_FROUND( x0, x1, x2, x3, y0, y1, y2, y3 );
			froundin0 = y0; froundin1 = y1; froundin2 = y2; froundin3 = y3;
			froundout0 = x0; froundout1 = x1; froundout2 = x2; froundout2 = x2;
			rk_addr += 4;
			round--;
			break;
		case st_subbytes:
			//AES_FSb( x0, x1, x2, x3, y0, y1, y2, y3 );
			fsbin0 = y0; fsbin1 = y1; fsbin2 = y2; fsbin3 = y3;
			fsbout0 = x0; fsbout1 = x1; fsbout2 = x2; fsbout2 = x2;
			rk_addr += 4;
			break;
		case st_end:
		    PUT_UINT32_LE(x0, output, 0);
		    PUT_UINT32_LE(x1, output, 4);
		    PUT_UINT32_LE(x2, output, 8);
		    PUT_UINT32_LE(x3, output, 12);
		    done = 1;
		    break;
	}
}
