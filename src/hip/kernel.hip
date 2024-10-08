#include "kernel.h"
__global__ void add_arrays(const int* a, int* b, size_t length)
{
  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  int grid_size = blockDim.x * gridDim.x;

  for (size_t i = idx; i < length; i += grid_size)
  {
    b[i] += a[i];
  }
}

void hip_func()
{
    size_t length = 1024;  // Example size of the arrays
    size_t size_in_bytes = length * sizeof(int);

    int *h_a = (int*)malloc(size_in_bytes);
    int *h_b = (int*)malloc(size_in_bytes);

    for (size_t i = 0; i < length; ++i) {
        h_a[i] = i;
        h_b[i] = 2 * i;
    }

    int *d_a, *d_b;
    hipCheck(hipMalloc((void**)&d_a, size_in_bytes));
    hipCheck(hipMalloc((void**)&d_b, size_in_bytes));

    hipCheck(hipMemcpy(d_a, h_a, size_in_bytes, hipMemcpyHostToDevice));
    hipCheck(hipMemcpy(d_b, h_b, size_in_bytes, hipMemcpyHostToDevice));

    int block_size = 256;
    int num_blocks = (length + block_size - 1) / block_size;
    hipLaunchKernelGGL(add_arrays, dim3(num_blocks), dim3(block_size), 0, 0, d_a, d_b, length);

    hipCheck(hipMemcpy(h_b, d_b, size_in_bytes, hipMemcpyDeviceToHost));

    std::cout << "Array after addition (first 10 elements):" << std::endl;
    for (size_t i = 0; i < 10; ++i) {
        std::cout << "b[" << i << "] = " << h_b[i] << std::endl;
    }

    hipCheck(hipFree(d_a));
    hipCheck(hipFree(d_b));
    free(h_a);
    free(h_b);
}

