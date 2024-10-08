# CMake version 3.21 or higher is required to use CMake HIP language support.
cmake_minimum_required(VERSION 3.21)

project(test_lib LANGUAGES CXX HIP)

find_package(HIP REQUIRED)
find_package(hipfft REQUIRED)
find_package(MPI REQUIRED)

# Initialise the CMAKE_HIP_FLAGS variable if it is not defined.
if(NOT DEFINED CMAKE_HIP_FLAGS)
    set(CMAKE_HIP_FLAGS "")
endif()

# By default, don't build the Fortran interface library.
if(NOT DEFINED BUILD_FORTRAN)
    set(BUILD_FORTRAN 0)
endif()

# Add -fPIC to CMAKE_HIP_FLAGS if it is not present.
string(FIND "${CMAKE_HIP_FLAGS}" "-fPIC" PIC_FOUND)
if(PIC_FOUND EQUAL -1)
    set(CMAKE_HIP_FLAGS "${CMAKE_HIP_FLAGS} -fPIC")
endif()

# Detect if the C++ compiler is GCC.
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")

    # If so, check wether the user specifies a gcc-toolchain.
    string(FIND "${CMAKE_HIP_FLAGS}" "--gcc-toolchain" GCC_TOOLCHAIN_FOUND)

    if(GCC_TOOLCHAIN_FOUND EQUAL -1)
        # If not, find the gcc-toolchain directory and supply the path to hipcc. 
        # This is done to ensure that the C++ standard library is consistent 
        # between objects generated with hipcc and g++.
        get_filename_component(CXX_COMPILER_DIR ${CMAKE_CXX_COMPILER} DIRECTORY)
        get_filename_component(GCC_TOOLCHAIN_DIR ${CXX_COMPILER_DIR} DIRECTORY)

        set(CMAKE_HIP_FLAGS "${CMAKE_HIP_FLAGS} --gcc-toolchain=${GCC_TOOLCHAIN_DIR}")
        message(STATUS "GCC detected, setting --gcc-toolchain to ${GCC_TOOLCHAIN_DIR}")
    endif()
endif()

message(STATUS "CMAKE_HIP_FLAGS: ${CMAKE_HIP_FLAGS}")


add_subdirectory(src/cpp)

if(BUILD_FORTRAN)
    message(STATUS "Build Fortran - yes")
    add_subdirectory(src/f90)
else()
    message(STATUS "Build Fortran - no")
endif()

# C++ 11 is required to compile for GPU devices with hipcc.
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
