#include <systemc>
#include <iostream>

#include "aes_encrypt.h"

int sc_main(int argc, char* argv[])
{
  std::cout << "Starting simulation: " << sc_core::sc_time_stamp() << "\n";

  sc_core::sc_time clock_time(1, sc_core::sc_time_unit::SC_MS);
  AES_Encrypt encrypt("encrypt");

  sc_core::sc_signal<bool> clock, start, clear;
  sc_core::sc_signal<uint32_t> rk0, rk1, rk2, rk3;
  sc_core::sc_vector<sc_core::sc_signal<unsigned char>> input("AES_input", 16), output("AES_input", 16);
  sc_core::sc_signal<uint32_t> rk_addr;
  sc_core::sc_signal<bool> done;

  encrypt.clock(clock);
  encrypt.start(start);
  encrypt.clear(clear);
  encrypt.rk0(rk0);
  encrypt.rk1(rk1);
  encrypt.rk2(rk2);
  encrypt.rk3(rk3);

  encrypt.input(input);
  encrypt.output(output);

  encrypt.rk_addr(rk_addr);
  encrypt.done(done);
  encrypt.set_state();

  sc_core::sc_start(clock_time);
  sc_core::sc_start(clock_time);
  sc_core::sc_start(clock_time);

  std::cout << "Ended simulation: " << sc_core::sc_time_stamp() << "\n";
  return 0;
}
