#include <systemc>

enum aes_rk_state {
  aes_rk_st_wait, aes_rk_st_read, aes_rk_st_generate, aes_rk_st_end
};

SC_MODULE(AES_RoundKey)
{
  sc_core::sc_in<bool> clock, start, clear;
  sc_core::sc_in<uint32_t> rk_addr;
  sc_core::sc_in<unsigned char> key[16];
  sc_core::sc_out<uint32_t> rk0, rk1, rk2, rk3;
  sc_core::sc_out<bool> done;

  // State logic
  sc_core::sc_signal<aes_rk_state> sreg;
  sc_core::sc_signal<aes_rk_state> snext;

  // Internal values
  sc_core::sc_signal<uint32_t> rk[44];
  int round;

  void get_next_state();
  void set_state();
  void read_rk();

  SC_CTOR(AES_RoundKey)
  {
    round = 0;

    SC_METHOD(get_next_state);
      sensitive << sreg << start << clear << round;
	SC_METHOD(set_state);
      sensitive << clock.pos();
    SC_METHOD(read_rk);
      sensitive << rk_addr;
  }
};
