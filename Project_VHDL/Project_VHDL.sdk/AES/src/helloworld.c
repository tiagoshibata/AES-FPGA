#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

#include "axi_dma.h"


int main()
{
    init_platform();

    axi_set_nonce(0, 0x01020304);
    axi_set_nonce(1, 0x05060708);
    axi_set_nonce(2, 0x090a0b0c);
    axi_set_nonce(3, 0x0d0e0f10);

    axi_set_pt(0, 0);
    axi_set_pt(1, 0);
    axi_set_pt(2, 0);
    axi_set_pt(3, 0xffffffff);

    axi_set_key(0, 0x11121314);
    axi_set_key(1, 0x15161718);
    axi_set_key(2, 0x191a1b1c);
    axi_set_key(3, 0x1d1e1f20);

    axi_set_clear_bit();
	axi_reset_status_word();
    axi_set_start_bit();
    while (!axi_get_done_bit()) ;

    for (int i = 0; i < 4; i++)
    	printf("%lx ", axi_get_ct(i));

    printf("\n");
    cleanup_platform();
    return 0;
}
