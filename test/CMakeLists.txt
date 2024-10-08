cmake_minimum_required(VERSION 3.21)
project(hip_mpi_program LANGUAGES CXX)

# Set CMP0144 to the new find_package behavior for _ROOT environment variables
if(POLICY CMP0144)
  cmake_policy(SET CMP0144 NEW)
endif()

find_package(MPI REQUIRED COMPONENTS CXX)
find_package(HIP REQUIRED)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

if(NOT DEFINED TEST_LIB_PATH)
  set(TEST_LIB_PATH "/usr/local")
endif()

message(STATUS "TEST_LIB_PATH: ${TEST_LIB_PREFIX}")

include_directories(${TEST_LIB_PATH}/include)
link_directories(${TEST_LIB_PATH}/lib)

if(BUILD_FORTRAN)
  enable_language(Fortran)
  find_package(hipfort REQUIRED)
  find_package(MPI REQUIRED COMPONENTS Fortran)
  message(STATUS "Build Fortran - yes")
  add_executable(hip_mpi_program_f90 test.f90)
  target_link_libraries(
    hip_mpi_program_f90 PRIVATE test_lib_f90 test_lib hip::host
                                MPI::MPI_Fortran hipfort::hipfort-amdgcn)
  install(TARGETS hip_mpi_program_f90 RUNTIME DESTINATION bin)
else()
  message(STATUS "Build Fortran - no")
endif()

add_executable(hip_mpi_program_cpp test.cpp)
target_link_libraries(hip_mpi_program_cpp PRIVATE test_lib hip::host
                                                  MPI::MPI_CXX)
install(TARGETS hip_mpi_program_cpp RUNTIME DESTINATION bin)
