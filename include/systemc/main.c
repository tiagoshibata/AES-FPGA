#include <systemc>
#include <iostream>

int sc_main()
{
  std::cout << "Starting simulation: " << sc_core::sc_time_stamp() << "\n";
  sc_core::sc_start();
  // Run stuff
  std::cout << "Ended simulation: " << sc_core::sc_time_stamp() << "\n";
  return 0;
}
