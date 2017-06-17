cmake_minimum_required(VERSION 2.6)
project(AES-FPGA)
set (AES-FPGA_VERSION_MAJOR 1)
set (AES-FPGA_VERSION_MINOR 0)

if(CMAKE_COMPILER_IS_GNUCC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
endif()

include_directories("include")

add_executable(run_test src/aes.c src/run_test.c)
