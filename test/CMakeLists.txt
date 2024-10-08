cmake_minimum_required(VERSION 3.10)
project(hip_mpi_program LANGUAGES CXX Fortran)

find_package(HIP REQUIRED)
find_package(MPI REQUIRED)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

if(NOT DEFINED TEST_LIB_PATH)
    set(TEST_LIB_PATH "/usr/local")
endif()

message(STATUS "TEST_LIB_PATH: ${TEST_LIB_PREFIX}")

include_directories(${TEST_LIB_PATH}/include)
link_directories(${TEST_LIB_PATH}/lib)

add_executable(hip_mpi_program_cpp test.cpp)
target_link_libraries(hip_mpi_program_cpp PRIVATE test_lib hip::host MPI::MPI_CXX)
install(TARGETS hip_mpi_program_cpp RUNTIME DESTINATION bin)

if(ENABLE_FORTRAN)
    message(STATUS "Build Fortran...yes.")
    add_executable(hip_mpi_program_f90 test.f90)
    target_link_libraries(hip_mpi_program_f90 PRIVATE test_lib_f90 test_lib hip::host MPI::MPI_Fortran)
    install(TARGETS hip_mpi_program_f90 RUNTIME DESTINATION bin)
else()
    message(STATUS "Build Fortran...no.")
endif()
