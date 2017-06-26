#include <systemc>

SC_MODULE(AddRoundKey)
{
  sc_core::sc_in<int> a, b;
  sc_core::sc_out<int> sum;

  void do_add()
  {
    sum.write(a.read() + b.read());
  }

  SC_CTOR(AddRoundKey)
  {
    SC_METHOD(do_add);
    sensitive << a << b;  // sensitivity list of do_add
  }
};
