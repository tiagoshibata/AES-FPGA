#include <stdint.h>

volatile uint32_t *axi_gpio_base = (uint32_t *)0x40000000;
#define GPIO_DATA   0
#define GPIO_TRI    1

static inline char axi_gpio_get_done_bit() {
    // Read GPIO done bit
    return axi_gpio_base[GPIO_DATA] & (1 << 2);
}

static inline void axi_gpio_set_clear_bit(char value) {
    value = !!value;  // constrain to 0 or 1
    axi_gpio_base[GPIO_DATA] |= value;
}

static inline void axi_gpio_set_start_bit(char value) {
    value = !!value;  // constrain to 0 or 1
    axi_gpio_base[GPIO_DATA] |= (value << 1);
}
