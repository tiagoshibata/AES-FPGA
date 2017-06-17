#include <stdio.h>
#include <string.h>

#include "mbedtls/aes.h"
#include "mbedtls/config.h"

#ifndef MBEDTLS_SELF_TEST
#error MBEDTLS_SELF_TEST must be defined to compile tests
#endif

int main(int argc, char **argv)
{
    int verbose = 0;

    switch (argc) {
    case 1:
        break;

    case 2:
        if (!strcmp(argv[1], "-v")) {
            verbose = 1;
            break;
        }
        // fall-through

    default:
        fprintf(stderr, "Usage: %s [-v]\n"
                "\t-v\tVerbose mode.\n", argv[0]);
        return -1;
    }

    if (verbose)
        printf("=== Running AES tests ===\n");
    return mbedtls_aes_self_test(verbose);
}
