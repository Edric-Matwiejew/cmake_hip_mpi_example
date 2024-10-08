#include "test_lib.h"

#define hipCheck(stmt)                                                         \
  {                                                                            \
    hipError_t err = stmt;                                                     \
    if (err != hipSuccess) {                                                   \
      fprintf(stderr, "Failed to run %s\n%s (%d) at %s: %d\n", #stmt,          \
              hipGetErrorString(err), err, __FILE__, __LINE__);                \
      throw std::invalid_argument("hipCheck failed");                          \
    }                                                                          \
  }

int main(int argc, char* argv[]) {
    MPI_Init(&argc, &argv);

    int mpi_rank, mpi_size;
    MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

    int device_count;
    hipCheck(hipGetDeviceCount(&device_count));

    test(mpi_rank, device_count);

    MPI_Finalize();
    return 0;
}

