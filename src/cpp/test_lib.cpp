#include "test_lib.h"
#include "kernel.h"

extern "C" void test(int mpi_rank, int device_count) {
    if (mpi_rank < device_count) {
        std::cout << "Rank " << mpi_rank << " has access to a device." << std::endl;

        // Create a 1D FFT plan with hipFFT and destroy it.
        hipfftHandle plan;
        int n = 1024;  
        hipfftResult result = hipfftPlan1d(&plan, n, HIPFFT_C2C, 1);
        if (result != HIPFFT_SUCCESS) {
            std::cerr << "Failed to create hipFFT plan on rank " << mpi_rank << std::endl;
        } else {
            std::cout << "Created hipFFT plan on rank " << mpi_rank << std::endl;
            result = hipfftDestroy(plan);
            if (result != HIPFFT_SUCCESS) {
                std::cerr << "Failed to destroy hipFFT plan on rank " << mpi_rank << std::endl;
            } else {
                std::cout << "Destroyed hipFFT plan on rank " << mpi_rank << std::endl;
            }
        }
        hip_func();  // Call a function that utilises a user-defined hip kernel.
    } else {
        std::cout << "Rank " << mpi_rank << " does not have access to a device." << std::endl;
    }

}
