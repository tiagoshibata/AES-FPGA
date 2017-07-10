#include <systemc>
#include "aes_fround.h"
#include "aes_fsb.h"

enum aes_enc_state {
  aes_enc_st_wait, aes_enc_st_read, aes_enc_st_addroundkey,
    aes_enc_st_round_odd_in, aes_enc_st_round_odd_out,
    aes_enc_st_round_even_in, aes_enc_st_round_even_out,
    aes_enc_st_round_last_in, aes_enc_st_round_last_out,
    aes_enc_st_subbytes_in, aes_enc_st_subbytes_out,
  aes_enc_st_end
};

SC_MODULE(AES_Encrypt)
{
  sc_core::sc_in<bool> clock, start, clear;
  sc_core::sc_in<uint32_t> rk0, rk1, rk2, rk3;
  sc_core::sc_in<unsigned char> input[16];
  sc_core::sc_out<unsigned char> output[16];
  sc_core::sc_out<uint32_t> rk_addr;
  sc_core::sc_out<bool> done;

  // State logic
  sc_core::sc_signal<aes_enc_state> sreg;
  sc_core::sc_signal<aes_enc_state> snext;

  // Internal values
  sc_core::sc_signal<uint32_t> x0, x1, x2, x3, y0, y1, y2, y3;
  int aes_round;

  // Modules
  AES_FROUND *fround;
  sc_core::sc_signal<uint32_t> froundin0, froundin1, froundin2, froundin3, froundout0, froundout1, froundout2, froundout3;
  AES_FSb *fsb;
  sc_core::sc_signal<uint32_t> fsbin0, fsbin1, fsbin2, fsbin3, fsbout0, fsbout1, fsbout2, fsbout3;

  void get_next_state();
  void set_state();

  SC_CTOR(AES_Encrypt)
  {
    aes_round = 0;

    fround = new AES_FROUND("fround");
    fround->y0(froundin0); fround->y1(froundin1); fround->y2(froundin2); fround->y3(froundin3);
    fround->rk0(rk0); fround->rk1(rk1); fround->rk2(rk2); fround->rk3(rk3);
    fround->x0(froundout0); fround->x1(froundout1); fround->x2(froundout2); fround->x3(froundout3);

    fsb = new AES_FSb("fsb");
    fsb->y0(fsbin0); fsb->y1(fsbin1); fsb->y2(fsbin2); fsb->y3(fsbin3);
    fsb->rk0(rk0); fsb->rk1(rk1); fsb->rk2(rk2); fsb->rk3(rk3);
    fsb->x0(fsbout0); fsb->x1(fsbout1); fsb->x2(fsbout2); fsb->x3(fsbout3);

    SC_METHOD(get_next_state);
      sensitive << sreg << start << clear;
	SC_METHOD(set_state);
      sensitive << clock.pos();
  }
};
