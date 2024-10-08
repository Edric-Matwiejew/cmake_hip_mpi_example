#ifndef HIP_MPI_UTILS_H
#define HIP_MPI_UTILS_H

#include <iostream>
#include <mpi.h>
#include <hip/hip_runtime.h>
#include <hipfft.h>

extern "C" void test(int mpi_rank, int device_count);

#endif // HIP_MPI_UTILS_H

