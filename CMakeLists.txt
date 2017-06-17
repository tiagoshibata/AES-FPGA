cmake_minimum_required(VERSION 2.6)
project(AES-FPGA)
set (AES-FPGA_VERSION_MAJOR 1)
set (AES-FPGA_VERSION_MINOR 0)

if(NOT CMAKE_BUILD_TYPE)
    message(WARNING "CMAKE_BUILD_TYPE not defined, defaulting to Release")
    set(CMAKE_BUILD_TYPE Release)
endif()

# User configuration
set(MBEDTLS_SELF_TEST 1 CACHE BOOL "Compile mbed TLS self tests")
# End of user configuration

if(CMAKE_COMPILER_IS_GNUCC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
endif()

if(MBEDTLS_SELF_TEST)
    add_definitions(-DMBEDTLS_SELF_TEST)
endif()

include_directories("include")

add_executable(run_test src/aes.c src/run_test.c)
