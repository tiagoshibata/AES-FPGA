#include <systemc>
#include "aes_roundkey.h"
#include "aes_encrypt.h"

enum aes_ctr_state {
  aes_ctr_st_wait, aes_ctr_st_read, aes_ctr_st_rk_start, aes_ctr_st_rk_wait, aes_ctr_st_enc_start, aes_ctr_st_enc_wait, aes_ctr_st_end
};

SC_MODULE(AES_CTR)
{
  sc_core::sc_in<bool> clock, start, clear;
  // Input:
  // - Encryption: plaintext
  // - Decryption: ciphertext
  // Nonce Counter should be incremented by 1 outside of this module
  sc_core::sc_in<unsigned char> input[16], nonce_counter[16], key[16];
  sc_core::sc_out<unsigned char> output[16];
  sc_core::sc_out<bool> done;

  // State logic
  sc_core::sc_signal<aes_ctr_state> sreg;
  sc_core::sc_signal<aes_ctr_state> snext;

  // Internal values
  sc_core::sc_signal<uint32_t> rk0, rk1, rk2, rk3, rk_addr;
  sc_core::sc_signal<unsigned char> cipher[16];

  // Modules
  AES_RoundKey *roundkey;
  sc_core::sc_signal<uint32_t> start_rk, done_rk;
  AES_Encrypt *aes_encrypt;
  sc_core::sc_signal<uint32_t> start_enc, done_enc;

  void get_next_state();
  void set_state();

  SC_CTOR(AES_CTR)
  {
    roundkey = new AES_RoundKey("roundkey");
    roundkey->rk0(rk0); roundkey->rk1(rk1); roundkey->rk2(rk2); roundkey->rk3(rk3); roundkey->rk_addr(rk_addr);
    roundkey->clock(clock); roundkey->start(start_rk); roundkey->clear(clear); roundkey->done(done_rk);
    roundkey->key(key);

    aes_encrypt = new AES_Encrypt("encrypt");
    aes_encrypt->rk0(rk0); aes_encrypt->rk1(rk1); aes_encrypt->rk2(rk2); aes_encrypt->rk3(rk3); aes_encrypt->rk_addr(rk_addr);
    aes_encrypt->clock(clock); aes_encrypt->start(start_enc); aes_encrypt->clear(clear); aes_encrypt->done(done_enc);
    aes_encrypt->input(nonce_counter); aes_encrypt->output(cipher);

    SC_METHOD(get_next_state);
      sensitive << sreg << start << clear << done_rk << done_enc;
	SC_METHOD(set_state);
      sensitive << clock.pos();
  }
};
