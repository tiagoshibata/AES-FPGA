#include <systemc>
#include "aes_roundkey.h"
#include "aes_encrypt.h"
#include "aes_nonce_counter.h"

enum aes_ctr_state {
  aes_ctr_st_wait, aes_ctr_st_rk_start, aes_ctr_st_rk_wait, aes_ctr_st_enc_start, aes_ctr_st_enc_wait, aes_ctr_st_nc_inc, aes_ctr_st_end_wait, aes_ctr_st_end
};

SC_MODULE(AES_CTR)
{
  sc_core::sc_in<bool> clock, start, clear;
  // Input:
  // - Encryption: plaintext
  // - Decryption: ciphertext
  // Nonce Counter will be incremented by 1 inside this module for each encryption
  sc_core::sc_vector<sc_core::sc_in<unsigned char>> input, nonce_counter, key;
  sc_core::sc_vector<sc_core::sc_out<unsigned char>> output;
  sc_core::sc_out<bool> done;

  // State logic
  sc_core::sc_signal<aes_ctr_state> sreg;
  sc_core::sc_signal<aes_ctr_state> snext;

  // Internal values
  sc_core::sc_signal<uint32_t> rk0, rk1, rk2, rk3, rk_addr;
  sc_core::sc_vector<sc_core::sc_signal<unsigned char>> cipher, curr_nc;

  // Modules
  AES_RoundKey *roundkey;
  sc_core::sc_signal<bool> start_rk, done_rk;
  AES_Encrypt *aes_encrypt;
  sc_core::sc_signal<bool> start_enc, done_enc;
  AES_Nonce_Counter *nonce_ctr;
  sc_core::sc_signal<bool> inc_nc;

  void get_next_state();
  void set_state();

  SC_CTOR(AES_CTR) : input("AES_CTR_input", 16), output("AES_CTR_output", 16),
      nonce_counter("AES_CTR_nonce_counter", 16), key("AES_CTR_key", 16),
      cipher("AES_CTR_cipher", 16), curr_nc("AES_CTR_curr_nc", 16)
  {
    roundkey = new AES_RoundKey("roundkey");
    roundkey->rk0(rk0); roundkey->rk1(rk1); roundkey->rk2(rk2); roundkey->rk3(rk3); roundkey->rk_addr(rk_addr);
    roundkey->clock(clock); roundkey->start(start_rk); roundkey->clear(clear); roundkey->done(done_rk);
    roundkey->key(key);

    aes_encrypt = new AES_Encrypt("encrypt");
    aes_encrypt->rk0(rk0); aes_encrypt->rk1(rk1); aes_encrypt->rk2(rk2); aes_encrypt->rk3(rk3); aes_encrypt->rk_addr(rk_addr);
    aes_encrypt->clock(clock); aes_encrypt->start(start_enc); aes_encrypt->clear(clear); aes_encrypt->done(done_enc);
    aes_encrypt->input(curr_nc); aes_encrypt->output(cipher);

    nonce_ctr = new AES_Nonce_Counter("nonce_ctr");
    nonce_ctr->clock(clock); nonce_ctr->clear(clear); nonce_ctr->increment(inc_nc);
    nonce_ctr->original_nc(nonce_counter); nonce_ctr->current_nc(curr_nc);

    SC_METHOD(get_next_state);
      sensitive << sreg << start << clear << done_rk << done_enc;
	SC_METHOD(set_state);
      sensitive << clock.pos();
  }
};
