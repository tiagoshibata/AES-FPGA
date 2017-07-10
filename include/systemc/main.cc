#include <systemc>
#include <iostream>

#include "aes_ctr.h"

int sc_main(int argc, char* argv[])
{
  std::cout << "Starting simulation: " << sc_core::sc_time_stamp() << "\n";

  sc_core::sc_time clock_time(1, sc_core::sc_time_unit::SC_MS);
  AES_CTR ctr("AES_CTR");

  sc_core::sc_signal<bool> clock, start, clear;
  sc_core::sc_vector<sc_core::sc_signal<unsigned char>> input("AES_input", 16),
      nonce_counter("AES_nonce_counter", 16), key("AES_key", 16);
  sc_core::sc_vector<sc_core::sc_signal<unsigned char>> output;
  sc_core::sc_signal<bool> done;

  ctr.clock(clock);
  ctr.start(start);
  ctr.clear(clear);
  ctr.input(input);
  ctr.nonce_counter(nonce_counter);
  ctr.key(key);
  ctr.output(output);
  ctr.done(done);

  while (!ctr.done) {
    std::cout << "Running 1 cycle\n";
    sc_core::sc_start(clock_time);
  }
  // sc_core::sc_start(clock_time);
  // sc_core::sc_start(clock_time);

  std::cout << "Ended simulation: " << sc_core::sc_time_stamp() << "\n";
  return 0;
}
