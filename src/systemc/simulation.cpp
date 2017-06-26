#include <systemc>
#include "systemc/add_round_key.hpp"

int sc_main(int argc, char* argv[])
{
  AddRoundKey add_round_key();
  sc_core::sc_start();
  return 0;
}
