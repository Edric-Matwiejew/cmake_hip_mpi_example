#include "test_lib.h"

int main(int argc, char* argv[]) {
    MPI_Init(&argc, &argv);

    int mpi_rank, mpi_size;
    MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

    int device_count;
    HIP_CHECK(hipGetDeviceCount(&device_count));

    test(mpi_rank, device_count);

    MPI_Finalize();
    return 0;
}

