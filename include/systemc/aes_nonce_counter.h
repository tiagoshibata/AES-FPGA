#include <systemc>

SC_MODULE(AES_Nonce_Counter)
{
  sc_core::sc_in<bool> clear, increment;
  sc_core::sc_in<unsigned char> original_nc[16];
  sc_core::sc_out<unsigned char> current_nc[16];

  void do_clear_nc()
  {
    if (clear) {
      for (int i = 0; i < 16; i++) {
        current_nc[i] = original_nc[i];
      }
    }
  };

  void do_increment_nc()
  {
    if (increment) {
      for (int i = 16; i > 0; i--) {
        if (++current_nc[i-1] != 0) break;
      }
    }
  };

  SC_CTOR(AES_Nonce_Counter)
  {
    SC_METHOD(do_clear_nc);
    sensitive << clear;
    SC_METHOD(do_increment_nc);
    sensitive << increment;
  }
};
