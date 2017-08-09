/*
 * axi_dma.h
 *
 *  Created on: Aug 8, 2017
 *      Author: tiago
 */

#ifndef SRC_AXI_DMA_H_
#define SRC_AXI_DMA_H_

#include <stdint.h>

volatile uint32_t *axi_dma_base = (uint32_t *)0x44a00000;

static inline char axi_get_done_bit() {
    // Read done bit
    return axi_dma_base[16];
}

static inline void axi_set_clear_bit() {
    axi_dma_base[17] = 1;
}

static inline void axi_reset_status_word() {
    axi_dma_base[17] = 0;
}

static inline void axi_set_start_bit() {
    axi_dma_base[17] |= 1 << 1;
}

static inline void axi_set_pt(uint16_t n, uint32_t v) {
    axi_dma_base[3 - n] = v;
}

static inline void axi_set_nonce(uint16_t n, uint32_t v) {
    axi_dma_base[4 + 3 - n] = v;
}

static inline void axi_set_key(uint16_t n, uint32_t v) {
    axi_dma_base[8 + 3 - n] = v;
}

static inline uint32_t axi_get_ct(uint16_t n) {
    return axi_dma_base[12 + 3 - n];
}


#endif /* SRC_AXI_DMA_H_ */
