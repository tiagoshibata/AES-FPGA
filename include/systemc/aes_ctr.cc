#include "aes_ctr.h"

void AES_CTR::get_next_state()
{
	if (clear) {
		sreg = aes_ctr_st_wait;
	} else switch (sreg) {
		case aes_ctr_st_wait:
			if (start) {
				snext = aes_ctr_st_rk_start;
			} else {
				snext = aes_ctr_st_wait;
			}
			break;
		case aes_ctr_st_rk_start:
		    snext = aes_ctr_st_rk_wait;
			break;
        case aes_ctr_st_rk_wait:
            if (done_rk) {
                snext = aes_ctr_st_enc_start;
            } else {
    		    snext = aes_ctr_st_rk_wait;
            }
    		break;
        case aes_ctr_st_enc_start:
    		snext = aes_ctr_st_enc_wait;
    		break;
        case aes_ctr_st_enc_wait:
            if (done_enc) {
                snext = aes_ctr_st_end;
            } else {
        	    snext = aes_ctr_st_enc_wait;
            }
        	break;
		case aes_ctr_st_end:
			snext = aes_ctr_st_wait;
			break;
	}
}

void AES_CTR::set_state()
{
	sreg = snext;

	switch (sreg) {
		case aes_ctr_st_wait:
            done = 0;
            start_rk = 0;
            start_enc = 0;
            break;
        case aes_ctr_st_rk_start:
            start_rk = 1;
            break;
        case aes_ctr_st_rk_wait:
            start_rk = 0;
            break;
        case aes_ctr_st_enc_start:
            start_enc = 1;
            break;
        case aes_ctr_st_enc_wait:
            start_enc = 0;
            break;
		case aes_ctr_st_end:
            for (int i = 0; i < 16; i++) {
                output[i] = input[i] ^ cipher[i];
            }
            done = 1;
            break;
	}
}
