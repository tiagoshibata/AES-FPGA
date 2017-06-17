cmake_minimum_required(VERSION 2.6)
project(AES-FPGA)
set (AES-FPGA_VERSION_MAJOR 1)
set (AES-FPGA_VERSION_MINOR 0)

if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Undefined CMAKE_BUILD_TYPE will default to Release")
    set(CMAKE_BUILD_TYPE Release)
endif()

# User configuration
option(MBEDTLS_SELF_TEST "Compile mbed TLS self tests" 1)
option(STACK_PROTECTOR "Enable stack smashing detection" 0)
# End of user configuration

if(CMAKE_COMPILER_IS_GNUCC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
    if(STACK_PROTECTOR)
        add_definitions(-Wstack-protector -fstack-protector-all)
    endif()
endif()

if(MBEDTLS_SELF_TEST)
    add_definitions(-DMBEDTLS_SELF_TEST)
endif()


include_directories("include")
if(MBEDTLS_SELF_TEST)
    add_executable(run_test src/aes.c src/run_test.c)
endif()
