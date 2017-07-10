#include <systemc>

SC_MODULE(AES_Nonce_Counter)
{
  sc_core::sc_in<bool> clock, clear, increment;
  sc_core::sc_vector<sc_core::sc_in<unsigned char>> original_nc;
  sc_core::sc_vector<sc_core::sc_out<unsigned char>> current_nc;

  void do_nc()
  {
    if (clear) {
      for (int i = 0; i < 16; i++) {
        current_nc[i] = original_nc[i];
      }
    } else if (increment) {
      for (int i = 16; i > 0; i--) {
        current_nc[i-1] = current_nc[i-1] + 1;
        if (current_nc[i-1] != 0) break;
      }
    }
  };

  SC_CTOR(AES_Nonce_Counter) : original_nc("AES_Nonce_Counter_original_nc", 16),
      current_nc("AES_Nonce_Counter_current_nc", 16)
  {
    SC_METHOD(do_nc);
    sensitive << clock.pos();
  }
};
