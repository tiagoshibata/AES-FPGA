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

void AES_Encrypt::get_next_state()
{
	if (clear) {
		sreg = aes_enc_st_wait;
	} else switch (sreg) {
		case aes_enc_st_wait:
			if (start) {
				snext = aes_enc_st_read;
			} else {
				snext = aes_enc_st_wait;
			}
			break;
		case aes_enc_st_read:
			snext = aes_enc_st_addroundkey;
			break;
		case aes_enc_st_addroundkey:
			snext = aes_enc_st_round_odd_in;
			break;

        case aes_enc_st_round_odd_in:
    		snext = aes_enc_st_round_odd_out;
    		break;
		case aes_enc_st_round_odd_out:
			snext = aes_enc_st_round_even_in;
			break;

        case aes_enc_st_round_even_in:
            snext = aes_enc_st_round_even_out;
    		break;
		case aes_enc_st_round_even_out:
			if (aes_round > 0) {
				snext = aes_enc_st_round_odd_in;
			} else {
				snext = aes_enc_st_round_last_in;
			}
			break;

        case aes_enc_st_round_last_in:
    		snext = aes_enc_st_round_last_out;
    		break;
		case aes_enc_st_round_last_out:
			snext = aes_enc_st_subbytes_in;
			break;

        case aes_enc_st_subbytes_in:
    		snext = aes_enc_st_subbytes_out;
    		break;
		case aes_enc_st_subbytes_out:
			snext = aes_enc_st_end;
			break;

		case aes_enc_st_end:
			snext = aes_enc_st_wait;
			break;
	}
}

void AES_Encrypt::set_state()
{
	sreg = snext;

	switch (sreg) {
		case aes_enc_st_wait:
			done = 0;
            aes_round = 0;
			rk_addr = 0;
			break;
		case aes_enc_st_read:
			aes_round = (10 >> 1) - 1;
			GET_UINT32_LE(x0, input, 0);
			GET_UINT32_LE(x1, input, 4);
			GET_UINT32_LE(x2, input, 8);
			GET_UINT32_LE(x3, input, 12);
			break;
		case aes_enc_st_addroundkey:
			x0 = x0 ^ rk0;
			x1 = x1 ^ rk1;
			x2 = x2 ^ rk2;
			x3 = x3 ^ rk3;
			rk_addr = rk_addr + 4;
			break;

        //AES_FROUND( y0, y1, y2, y3, x0, x1, x2, x3 );
		case aes_enc_st_round_odd_in:
		case aes_enc_st_round_last_in:
			froundin0 = x0; froundin1 = x1; froundin2 = x2; froundin3 = x3;
			break;
        case aes_enc_st_round_odd_out:
    	case aes_enc_st_round_last_out:
    		y0 = froundout0; y1 = froundout1; y2 = froundout2; y3 = froundout3;
                rk_addr = rk_addr + 4;
    		break;

        //AES_FROUND( x0, x1, x2, x3, y0, y1, y2, y3 );
		case aes_enc_st_round_even_in:
			froundin0 = y0; froundin1 = y1; froundin2 = y2; froundin3 = y3;
			break;
        case aes_enc_st_round_even_out:
    		x0 = froundout0; x1 = froundout1; x2 = froundout2; x3 = froundout3;
                rk_addr = rk_addr + 4;
    		aes_round--;
    		break;

        //AES_FSb( x0, x1, x2, x3, y0, y1, y2, y3 );
		case aes_enc_st_subbytes_in:
			fsbin0 = y0; fsbin1 = y1; fsbin2 = y2; fsbin3 = y3;
			break;
        case aes_enc_st_subbytes_out:
            x0 = fsbout0; x1 = fsbout1; x2 = fsbout2; x3 = fsbout3;
            rk_addr = rk_addr + 4;
            break;

		case aes_enc_st_end:
		    PUT_UINT32_LE(x0, output, 0);
		    PUT_UINT32_LE(x1, output, 4);
		    PUT_UINT32_LE(x2, output, 8);
		    PUT_UINT32_LE(x3, output, 12);
		    done = 1;
		    break;
	}
}
