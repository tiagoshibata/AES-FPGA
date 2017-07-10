#include <systemc>
#include <iostream>

#include "aes_ctr.h"

#define tick() do{  \
  std::cout << "Running 1 cycle\n";  \
  sc_core::sc_start(half_clock_time);  \
  clock = 1;  \
  sc_core::sc_start(half_clock_time);  \
  clock = 0;  \
}while(0)

static const unsigned char aes_test_ctr_nonce_counter[16] =
    { 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 };

static const unsigned char aes_test_ctr_key[16] =
    { 0xAE, 0x68, 0x52, 0xF8, 0x12, 0x10, 0x67, 0xCC,
      0x4B, 0xF7, 0xA5, 0x76, 0x55, 0x77, 0xF3, 0x9E };

static const unsigned char aes_test_ctr_ct[16] =
    { 0xE4, 0x09, 0x5D, 0x4F, 0xB7, 0xA7, 0xB3, 0x79,
      0x2D, 0x61, 0x75, 0xA3, 0x26, 0x13, 0x11, 0xB8 };

int sc_main(int argc, char* argv[])
{
  std::cout << "Starting simulation: " << sc_core::sc_time_stamp() << "\n";

  sc_core::sc_time half_clock_time(0.5, sc_core::sc_time_unit::SC_MS);
  AES_CTR ctr("AES_CTR");

  sc_core::sc_signal<bool> clock, start, clear;
  sc_core::sc_vector<sc_core::sc_signal<unsigned char>> input("AES_input", 16),
      nonce_counter("AES_nonce_counter", 16), key("AES_key", 16);
  sc_core::sc_vector<sc_core::sc_signal<unsigned char>> output("AES_output", 16);
  sc_core::sc_signal<bool> done;

  for (int i = 0; i < 16; i++) {
    key[i] = aes_test_ctr_key[i];
    nonce_counter[i] = aes_test_ctr_nonce_counter[i];
  }

  ctr.clock(clock);
  ctr.start(start);
  ctr.clear(clear);
  ctr.input(input);
  ctr.nonce_counter(nonce_counter);
  ctr.key(key);
  ctr.output(output);
  ctr.done(done);

  start = 1;
  tick();
  start = 0;
  while (!ctr.done) {
    tick();
  }

  std::cout << "Ended simulation: " << sc_core::sc_time_stamp() << "\n";
  for (int i = 0; i < 16; i++) {
    std::cout << "Position " << i << ": expected " << +aes_test_ctr_ct[i] << ", found " << +output[i] << "\n";
    assert(aes_test_ctr_ct[i] == output[i]);
  }

  return 0;
}
